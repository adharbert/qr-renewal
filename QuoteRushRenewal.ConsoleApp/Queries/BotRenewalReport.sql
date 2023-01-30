DECLARE @stateDate varchar(10)
		,@endDate  varchar(10)
SET		@stateDate = {0}
SET		@endDate = {1}


SELECT	PolId
		, CarrCode
		, PolNo
		, CustId
		, Expiration 
		, DBName
		, [AOP Deductible Amount] 'DeductibleAmount'
		, [Building Code Effectiveness Grade] 'BuildCodeEffectGrade'
		, [Building Code Effectiveness Grade Certificate Year] 'BuildCodeEffectGradeYear'
		, [Construction] 
		, [Construction Year] 'Year'
		, [Distance From Fire Hydrant] 'DistFromHydrant'
		, [Distance From Fire Station] 'DistFireStation'
		, [Dwelling In City Limits] 'DwellingInCity'
		, [Hurricane Deductible] 'Hurricane'
		, [Mitigation Credit] 'MitCredit'
		, [Number Of Families] 'NumOfFamily'
		, [Number Of Stories] 'Stories'
		, [Number Of Units] 'NumUnits'
		, [Protection Class] 'ProtectionClass'
		, [Purchase Price] 'PurchasePrice'
		, [Replacement Cost] 'ReplacementCost'
		, [Roof Shape] 'RoofShape'
		, [Square Feet] 'SqrFeet'
		, [Superior Construction] 'SuperierConstruction'
		, [Territory Code] 'TerritoryCode'
		, [Territory Description] 'TerritoryDesc'
FROM (

		Select	PolicyId
				, PolId
				, CarrCode
				, PolNo
				, CustId
				, Expiration
				, DBName
				, Description
				, Value
		FROM (
			SELECT	p.PolicyId 'PolicyId'
					, p.PolId 'PolId'
					, p.CarrCode 'CarrCode'
					--, p.Carrier
					, p.PolNo 'PolNo'
					, p.CustId 'CustId'
					, p.Expiration
					, vara.DBName
					, vara.Description 'Description'
					, vara.Value 'Value'
			FROM	[dbo].[Policy] p
			JOIN	[dbo].[Property] pr on p.PolicyId = pr.PolicyId
			JOIN	[dbo].[Attribute_varchar] vara on pr.PropertyId = vara.EntityId
			WHERE	p.CarrCode IN ('SFI_O','CAP_O')

			UNION ALL 

			SELECT	p.PolicyId 'PolicyId'
					, p.PolId 'PolId'
					, p.CarrCode 'CarrCode'
					--, p.Carrier
					, p.PolNo 'PolNo'
					, p.CustId 'CustId'
					, p.Expiration
					, vara.DBName
					, vara.Description 'Description'
					, vara.Value 'Value'
			FROM	[dbo].[Policy] p
			JOIN	[Attribute_varchar] vara on p.PolicyId = vara.EntityId
			WHERE	p.CarrCode IN ('SFI_O','CAP_O')
		 ) tbl
		where	Expiration between @stateDate AND @endDate


) as SourceTable
PIVOT (
	MAX([Value])
	FOR [Description] in (
					  [AOP Deductible Amount]
					, [Building Code Effectiveness Grade]
					, [Building Code Effectiveness Grade Certificate Year]
					, [Construction]
					, [Construction Year]
					, [Distance From Fire Hydrant]
					, [Distance From Fire Station]
					, [Dwelling In City Limits]
					, [Hurricane Deductible]
					, [Mitigation Credit]
					, [Number Of Families]
					, [Number Of Stories]
					, [Number Of Units]
					, [Protection Class]
					, [Purchase Price]
					, [Replacement Cost]
					, [Roof Shape]
					, [Square Feet]
					, [Superior Construction]
					, [Territory Code]
					, [Territory Description]
				)
) as PivotTable
order	by Expiration, PolicyId