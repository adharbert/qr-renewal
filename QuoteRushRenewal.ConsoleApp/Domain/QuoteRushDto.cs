using System;
using System.Collections.Generic;
using System.Text;

namespace QuoteRushRenewal.ConsoleApp.Domain
{
    public class QuoteRushDto
    {

        public Guid PolId { get; set; }
        public string PolNo { get; set; }
        public string NameFirst { get; set; }
        public string NameLast { get; set; }
        public DateTime DOB { get; set; }
        public string Phone { get; set; }
        public string Address { get; set; }
        public string City { get; set; }
        public string State { get; set; }
        public string Zip { get; set; }
        public string FormType { get; set; }
        public string PropertyAddress { get; set; }
        public string PropertyCity { get; set; }
        public string PropertyState { get; set; }
        public string PropertyZip { get; set; }
        public string PropertyCounty { get; set; }
        public string NewPurchase { get; set; }
        public string UsageType { get; set; }
        public string YearBuilt { get; set; }
        public string StructureType { get; set; }
        public string Families { get; set; }
        public string Stories { get; set; }
        public string SquareFeet { get; set; }
        public string ConstructionType { get; set; }
        public string FoundationType { get; set; }
        public string RoofShape { get; set; }
        public string RoofMaterial { get; set; }
        public string PoolType { get; set; }
        public string RoofYear  { get; set; }
        public int CoverageA { get; set; }
        public int CoverageB { get; set; }
        public int CoverageC { get; set; }
        public int CoverageD { get; set; }
        public int CoverageE { get; set; }
        public int CoverageF { get; set; }
        public string HurricaneDeductible { get; set; }
        public string AllOtherPerilsDeductible { get; set; }
        public string CurrentlyInsured { get; set; }
        public string Lapses { get; set; }
        public DateTime EffectiveDate { get; set; }
        public DateTime ExpirationDate { get; set; }
        public string Claims { get; set; }
        public string BurglarAlarm { get; set; }
        public string FireAlarm { get; set; }
        public string DistanceToStation { get; set; }
        public string DistanceToHydrant { get; set; }
        public string GatedCommunity { get; set; }
        public string KitchenType { get; set; }
        public string Bathroom1Type { get; set; }
        public string Bathroom1Count { get; set; }
        public string GarageType { get; set; }
        public int GarageCapacity { get; set; }
        public string CentralHeatAndAir { get; set; }
        public string QualityGrade { get; set; }
        public int WallHeight { get; set; }
        public string FoundationShape { get; set; }
        public string RenewalFlagStatus { get; set; }
        public string MonthsOwnerOccupied { get; set; }
        public string BillTo { get; set; }
    }
}
