using System;

namespace QuoteRushRenewal.ConsoleApp.Domain
{
    public class BotRenewalResults
    {

		public Guid PolId { get; set; }
		public string CarrCode { get; set; }
		public string PolNo { get; set; }
		public Guid CustId { get; set; }
		public DateTime Expiration { get; set; }
		public string DBName { get; set; }

		//[Column(TypeName = "money")]
		public string DeductibleAmount { get; set; }
		public string BuildCodeEffectGrade { get; set; }
		public string BuildCodeEffectGradeYear { get; set; }
		public string Construction { get; set; }
		public string Year { get; set; }
		public string DistFromHydrant { get; set; }
		public string DistFireStation { get; set; }
		public string DwellingInCity { get; set; }
		public string Hurricane { get; set; }
		public string MitCredit { get; set; }
		public string NumOfFamily { get; set; }
		public string Stories { get; set; }
		public string NumUnits { get; set; }
		public string ProtectionClass { get; set; }

		//[Column(TypeName = "money")]
		public string PurchasePrice { get; set; }

		//[Column(TypeName = "money")]
		public string ReplacementCost { get; set; }
		public string RoofShape { get; set; }
		public string SqrFeet { get; set; }
		public string SuperierConstruction { get; set; }
		public string TerritoryCode { get; set; }
		public string TerritoryDesc { get; set; }


	}
}
