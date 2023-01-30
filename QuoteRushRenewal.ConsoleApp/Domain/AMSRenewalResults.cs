using System;
using System.ComponentModel.DataAnnotations.Schema;

namespace QuoteRushRenewal.ConsoleApp.Domain
{
    public class AMSRenewalResults
    {

		public Guid PolId { get; set; }
		public string? PolTypeLOB { get; set; }
		public string? PolNo { get; set; }
		public DateTime PolEffDate { get; set; }
		public DateTime PolExpDate { get; set; }
		public string? FirstName { get; set; }
		public string? LastName { get; set; }
        public DateTime DOB { get; set; }
        public string Phone { get; set; }
        public string? Addr1 { get; set; }
		public string? City { get; set; }
		public string? State { get; set; }
		public string? ZipCode { get; set; }
		public string? County { get; set; }
		public string? FormType { get; set; }
		public int Cova { get; set; } = 0;
		public int Covb { get; set; } = 0;
		public int Covc { get; set; } = 0;
		public int Covd { get; set; } = 0;
		public int liability { get; set; } = 0;
		public int MedPay { get; set; } = 0;
		public int Rental { get; set; } = 0;
		public int AddtLvng { get; set; } = 0;
		public double allPerilsDed { get; set; }
		public double HurrDed { get; set; }
		public int xwind { get; set; }
		//public int Flood { get; set; }

		[Column(TypeName = "money")]
		public double FullTermPremium { get; set; }
		public string? rplcst_contents { get; set; }
		public int OrdLawCov { get; set; }
		public string? ConstructionType { get; set; }
		public string? rt_YrBlt { get; set; }
		public string? DwellingUse { get; set; }
		public Byte? NoOfFamilies { get; set; }
		public Int16? NoOfFireDiv { get; set; } = 0;
		public string? TerritoryCode { get; set; }
		public string? ProtClass { get; set; }
		public string? Burglar { get; set; }
		public string? Fire { get; set; }
		public string? Foundation { get; set; }
		public string? rt_ResType { get; set; }
		public string? Occupancy { get; set; }
		public string? HeatingYear { get; set; }
		public string? RoofingYear { get; set; }
		public string? WiringYear { get; set; }
		public string? DwellingLoc { get; set; }
		public string? BldgCodeGrade { get; set; }
		public int? TotalSqFt { get; set; }
		public string? SwimPool { get; set; }
		public string? DivingBoard { get; set; }
		public string? FireDistrict { get; set; }
		public int? FireDistrictCode { get; set; }
		public string? StormShutterType { get; set; }
		public string? RoofMaterial { get; set; }
		public string? NoOfStories { get; set; }
		public string? NoOfApts { get; set; }
		public string? sinkholelosscov { get; set; }
		public double sinkholeded { get; set; } = 0;
		public Int16? HydrantDistance { get; set; }
		public int? FireStaDistance { get; set; }
		public int Fungi1 { get; set; } = 0;
		public int Fungi2 { get; set; } = 0;
		public string? ParentCo { get; set; }
		public string? WritingCo { get; set; }
		public string? Office { get; set; }
		public string? MailAddr1 { get; set; }
		public string? mailcity { get; set; }
		public string? mailstate { get; set; }
		public string? mailzip { get; set; }
		public string? email { get; set; }
		[Column(TypeName = "money")]
		public decimal? ReplaceCost { get; set; }
		public string? Exc { get; set; }
		public int CustNo { get; set; }
        public string RenewalRptFlagDesc { get; set; }
        public string MonthsOwnerOccupied { get; set; }
        public string BillTo { get; set; }


    }
}
