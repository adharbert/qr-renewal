using ClosedXML.Excel;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using QuoteRushRenewal.ConsoleApp.Domain;
using QuoteRushRenewal.ConsoleApp.Persistance;
using QuoteRushRenewal.ConsoleApp.Utility;
using System;
using System.Collections.Generic;
using System.IO;
using System.Linq;
using System.Threading.Tasks;

namespace QuoteRushRenewal.ConsoleApp
{
    class Program
    {

        public static IConfigurationRoot configuration;

        static async Task Main(string[] args)
        {           
            Console.Write("Enter Integer for Month: ");
            var valMonth = Console.ReadLine();
            Console.Write("Enter Integer for Year: ");
            var valYear = Console.ReadLine();

            DateTime startDt = DateTime.Parse($"{valMonth}/1/{valYear}");
            DateTime endDt = startDt.AddMonths(1).AddMinutes(-1);


            var queryAms = Queries.Queries.Named("AMSRenewalsReport");
            var queryBot = Queries.Queries.Named("BotRenewalReport");
            List<AMSRenewalResults> custList = new List<AMSRenewalResults>();
            List<BotRenewalResults> botList = new List<BotRenewalResults>();

            try
            {

                using (var context = new AmsDbContext())
                {
                    custList = await context.Set<AMSRenewalResults>().FromSqlRaw(queryAms, startDt, endDt).ToListAsync();
                    Console.WriteLine("Number of AMS records: {0}", custList.Count);
                }

                using (var bContext = new BotDbContext())
                {
                    botList = await bContext.Set<BotRenewalResults>().FromSqlRaw(queryBot, startDt, endDt).ToListAsync();
                    Console.WriteLine("Number of bot records: {0}", botList.Count);
                }

                Console.WriteLine("Starting new object call");

                var query = from ams in custList
                            join bot in botList
                                on ams.PolId equals bot.PolId
                            select new QuoteRushDto
                            {
                                PolId = ams.PolId
                                , PolNo = ams.PolNo
                                , NameFirst = ams.FirstName
                                , NameLast = ams.LastName
                                , DOB = ams.DOB
                                , Phone = ams.Phone
                                , Address = ams.MailAddr1
                                , City = ams.mailcity
                                , State = ams.State
                                , Zip = ams.ZipCode
                                , FormType = ams.FormType
                                , PropertyAddress = ams.Addr1
                                , PropertyCity = ams.City
                                , PropertyState = ams.State
                                , PropertyZip = ams.ZipCode
                                , PropertyCounty = ams.County ?? bot.TerritoryCode
                                , NewPurchase = "No"
                                , UsageType = ams.DwellingUse
                                , YearBuilt = ams.rt_YrBlt ?? bot.Year
                                , StructureType = ams.rt_ResType
                                , Families = ams.NoOfFamilies.ToString()
                                , Stories = "1" // bot.Stories
                                , SquareFeet = bot.SqrFeet ?? ams.TotalSqFt.ToString()
                                , ConstructionType = ams.ConstructionType
                                , FoundationType = "Slab" // ams.Foundation
                                , RoofShape = "Gable" // bot.RoofShape
                                , RoofMaterial = "Composite Shingle" // ams.RoofMaterial
                                , PoolType = string.IsNullOrEmpty(ams.SwimPool) ? "None" : ams.SwimPool == "Y" ? "Yes" : "None"
                                , RoofYear = ams.RoofingYear // string.IsNullOrEmpty(ams.RoofingYear) ? "N/A" : int.Parse(ams.RoofingYear)
                                , CoverageA = ams.Cova
                                , CoverageB = ams.Covb
                                , CoverageC = ams.Covc
                                , CoverageD = ams.Covd
                                , CoverageE = ams.liability
                                , CoverageF = ams.MedPay
                                , AllOtherPerilsDeductible = ams.allPerilsDed.ToString()
                                , CurrentlyInsured = "Yes"
                                , Lapses = "No"
                                , EffectiveDate = ams.PolEffDate
                                , ExpirationDate = ams.PolExpDate
                                , Claims = "No"
                                , BurglarAlarm = ams.Burglar ?? "None"
                                , FireAlarm = ams.Fire ?? "None"
                                , DistanceToStation = (ams.FireStaDistance > 0) ? ams.FireStaDistance.ToString() : bot.DistFireStation
                                , DistanceToHydrant = (ams.HydrantDistance > 0) ? ams.HydrantDistance.ToString() : bot.DistFromHydrant
                                , GatedCommunity = "No"
                                , KitchenType = "Basic"
                                , Bathroom1Type = "Full Basic"
                                , HurricaneDeductible = "2%"
                                , Bathroom1Count = "2"
                                , GarageType = "Attached"
                                , GarageCapacity = 2
                                , CentralHeatAndAir = "Yes"
                                , QualityGrade = "Standard" // ams.BldgCodeGrade
                                , WallHeight = 8
                                , FoundationShape = "4-5 Corners - Square/Rectangle"
                                , RenewalFlagStatus = ams.RenewalRptFlagDesc
                                , MonthsOwnerOccupied = ams.MonthsOwnerOccupied
                                , BillTo = ams.BillTo
                            };
                var qrList = query.OrderBy(qr => qr.EffectiveDate).Select(s => s).ToList();

                Console.WriteLine("Merge count: {0}", qrList.Count);

                var workbook = new XLWorkbook();
                ExcelWorksheet.CreateWorksheet(qrList, ref workbook, "QR Loader");
                ExcelWorksheet.CreateWorksheet(custList, ref workbook, "AMS");
                ExcelWorksheet.CreateWorksheet(botList, ref workbook, "BOT");

                string path = "C:\\QRFile";
                if (!Directory.Exists(path))
                {
                    Directory.CreateDirectory(path);
                }

                // Save the results to local directoy on computer.
                string fileName = string.Format("QR-Renewals-{0}.xlsx", startDt.ToString("yyyyMMdd"));
                if (File.Exists($"{path}\\{fileName}"))
                {
                    File.Delete($"{path}\\{fileName}");
                }
                workbook.SaveAs($"{path}\\{fileName}");

            }
            catch (Exception ex)
            {
                Console.WriteLine("Error: {0}", ex.Message);
            }


            // merge AMs & BOT data into one record



            Console.ReadKey();

        }



    }
}
