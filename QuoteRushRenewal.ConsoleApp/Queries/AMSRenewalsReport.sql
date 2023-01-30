
declare @cmeas_dt date, @Beg_dt date


set @cmeas_dt = CONVERT(date,GETDATE())			-- Current Date 
set @Beg_dt   = DATEADD (MM, -13, @cmeas_dt)		-- 13 MONTHS PRIOR TO CURRENT DAT 



SELECT  ttl.PolId
		, ttl.PolTypeLOB
		, ttl.PolNo
		, ttl.PolEffDate
		, ttl.PolExpDate
		, ttl.FirstName
		, ttl.LastName
		, ISNULL(ttl.DOB, '1980-01-01') as DOB
		, ISNULL(ttl.Phone, '904-999-9999') Phone
		, ttl.Addr1
		, ttl.City
		, ttl.State
		, ttl.ZipCode
		, ttl.County
		, ISNULL(ttl.FormType, 'N/A') as FormType
		, max(ttl.Cova) as Cova
		, max(ttl.Covb) as Covb
		, max(ttl.Covc) as Covc
		, max(ttl.Covd) as Covd
		, max(ttl.liability) as liability
		, max(ttl.MedPay) as MedPay
		, max(ttl.Rental) as Rental
		, max(ttl.AddtLvng) as AddtLvng
		, max(ttl.allPerilsDed) as allPerilsDed
		, max(ttl.HurrDed) as HurrDed
		, max(ttl.xwind) as xwind
		--, max(ttl.Flood) as Flood, max(ttl.HasFlood) as HasFlood
		, ttl.FullTermPremium
		, max(ttl.rplcst_contents) as rplcst_contents
		, max(ttl.OrdlawCov) as OrdLawCov
		, ttl.ConstructionType
		, ttl.rt_YrBlt
		, ttl.DwellingUse
		, ISNULL(ttl.NoOfFamilies, 0) as NoOfFamilies
		, ttl.NoOfFireDiv
		, ttl.TerritoryCode
		, ttl.ProtClass
		, ttl.Burglar
		, ttl.Fire
		, ttl.Foundation
		, 'rt_ResType' = case WHEN ttl.rt_ResType IS NULL THEN 'Single Family'
							WHEN ttl.rt_ResType = 'Dwelling' THEN 'Single Family'
							else ttl.rt_ResType END
		, ttl.Occupancy
		, ttl.HeatingYear
		, ttl.RoofingYear
		, ttl.WiringYear
		, ttl.DwellingLoc
		, ttl.BldgCodeGrade
		, ttl.TotalSqFt
		, ttl.SwimPool
		, ttl.DivingBoard
		, ttl.FireDistrict
		, ttl.FireDistrictCode
		, ttl.StormShutterType
		, ttl.RoofMaterial
		, ttl.NoOfStories
		, ttl.NoOfApts
		, max(ttl.sinkholelosscov) as sinkholelosscov
		, max(ttl.sinkholeded) as sinkholeded
		, ttl.HydrantDistance
		, CAST(ISNULL(ttl.FireStaDistance, 0) as int) as FireStaDistance
		, max(ttl.Fungi1) as Fungi1
		, max(ttl.Fungi2) as Fungi2
		, ttl.ParentCo
		, ttl.WritingCo
		, ttl.Office
		, ttl.MailAddr1
		, ttl.mailcity
		, ttl.mailstate
		, ttl.mailzip
		, ttl.email
		, max(ttl.ReplaceCost) as ReplaceCost
		, ttl.Exc, ttl.CustNo
		, ttl.RenewalRptFlagDesc
		, '9 months or more' as MonthsOwnerOccupied
		, ISNULL(ttl.BillTo, 'Mortgage Billed') as BillTo
from (
		Select 	pols.FirstName, pols.LastName, pols.DOB, Phone, pols.MailAddr1, pols.City as MailCity, pols.State as MailState, pols.ZipCode as MailZip, pols.Email, pols.CustNo, pols.CustId,
			 pols.PolId, pols.PolNo, pols.PolEffDate, pols.PolExpDate, pols.PolTypeLOB, pols.FullTermPremium, pols.EXC, pols.CSR, pols.WritingCo, pols.ParentCo,
			 pols.Office, pols.OfficeContact, pols.ContactEmail, pols.ContactPhone, pols.MarketingName, pols.RenewalRptFlagDesc, pols.BillTo
			, case when cov.CoverageCode = 'Dwelling' then cov.limit1 else 0 end as Cova
			, case when cov.CoverageCode = 'Other structures' then cov.limit1 else 0 end as Covb
			, case when cov.CoverageCode = 'Personal property' then cov.limit1 else 0 end as Covc
			, case when cov.CoverageCode = 'Loss of use' then cov.limit1 else 0 end as Covd
			, case when cov.CoverageCode = 'Personal liability' then cov.limit1 else 0 end as liability
			, case when cov.CoverageCode = 'Medical payments' then cov.limit1 else 0 end as MedPay
			, case when cov.CoverageCode = 'Fair rental value' then cov.limit1 else 0 end as Rental
			, case when cov.CoverageCode = 'Additional living expense' then cov.limit1 else 0 end as AddtLvng
			, case when cov.CoverageCode = 'Dwelling' then cov.deduct1 else 0 end as allPerilsDed
			, case when cov.CoverageCode in ('Hurricane Deductible', 'HURRICANE DEDUCTIBLE $500', 'Hurricane Deduct') then cov.deduct1 else 0 end as HurrDed
			, case when cov.CoverageCode = 'Limited Fungi Coverage' then cov.limit1 else 0 end as Fungi1
			, case when cov.CoverageCode = 'Limited Fungi Cov - Section II' then cov.limit1 else 0 end as Fungi2
			, case when cov.CoverageCode in ('WHHDP','WHHDF') then cov.limit1 else 0 end as xwind
			, case when cov.CoverageCode = 'Personal prop replacement cost' then 'Y' else 'N' end as rplcst_contents
			, case when cov.CoverageCode = 'Sinkhole collapse' then 'Y' else 'N' end as sinkholelosscov
			, case when cov.CoverageCode = 'Sinkhole collapse' then cov.deduct1 else 0 end as sinkholeded
			, case when cov.CoverageCode = 'Building ordinance or law coverage' then cov.limit1 else 0 end as OrdlawCov
			, case when cov.CoverageCode = 'Flood Coverage' then cov.limit1 when cov.CoverageCode = 'FLDBC' then cov.limit1 else 0 end as Flood,
			frm.FormType,
			rtng.ResidenceType as rt_ResType, rtng.ConstructionType, rtng.DwellingUse, rtng.YearBuilt as rt_YrBlt, rtng.TotalSqFt, rtng.MarketValue, rtng.ReplaceCost, rtng.IsDeadbolt, rtng.NoOfFamilies,
			rtng.NoOfRooms, rtng.NoOfApts, rtng.HeatType, rtng.RoofMaterial, rtng.PurchaseDate, rtng.DateInspected, rtng.Occupancy, rtng.WindClass, rtng.Foundation, rtng.DwellLoc,
			rtng.HeatTypeSec, rtng.Sprinkler, rtng.SwimPool, rtng.IsSmokeDetector, rtng.IsFireExtinguisher, rtng.DivingBoard, rtng.YearOccupied, rtng.NoHouseRes, rtng.PurchasePrice,
			rtng.StormShutterType, rtng.BldgCodeGrade, rtng.Fire, rtng.Temperature, rtng.Smoke, rtng.Burglar, rtng.ProtClass, rtng.TerritoryCode, rtng.HydrantDistance, rtng.FireStaDistance,
			rtng.NoOfUnits, rtng.FireECRate, rtng.DwellingLoc, rtng.WiringYear, rtng.PlumbingYear, rtng.HeatingYear, rtng.RoofingYear, rtng.RatingMethod, rtng.FireDistrict, rtng.FireDistrictCode,
			rtng.NoOfFireDiv, rtng.ECPremGrp, rtng.PersLiabTerrCode, rtng.ExtPaint, rtng.Condition, rtng.GroundFloorSqFt, rtng.NoOfStories, rtng.PerimeterLinFt, rtng.PlaceCode,
			cd.Addr1, cd.Addr2, cd.City, cd.State, cd.ZipCode, cd.County, cd.YearBuilt as loc_YrBlt, cd.ResidenceType as loc_ResType, cd.Occupancy as loc_occup, cd.NoOfUnits as loc_numunits, cd.Usage as loc_usage
		From
		(
			Select	Distinct 'FirstName' = CASE
					WHEN C.FirmNameCust IS NOT NULL THEN C.FirmNameCust
					WHEN C.FirstName IS NULL THEN C.LastName
						ELSE C.FirstName END,
					C.LastName,
					'MailAddr1' = CASE WHEN C.Addr2 IS NULL THEN C.Addr1
						ELSE C.Addr1 + ' ' + C.Addr2 END,
					C.City,
					C.State,
					LEFT(C.ZipCode,5) as ZipCode,
					'Email' = COALESCE(C.Email, C.Email2, ''),
					C.CustNo, C.CustId,					
					C.DOB,
					C.ResAreaCode + '-' + Substring(C.ResPhone, 1, 3) + '-' + SUBSTRING(C.ResPhone, 4, 4)  as 'Phone',
					BPI.PolId, BPI.PolNo, BPI.PolEffDate, BPI.PolExpDate, BPI.RenewalRptFlag, BPI.PolTypeLOB, BPI.FullTermPremium,
					'EXC' = COALESCE(EXC.FirstName+' '+EXC.LastName, EXC.LastName, 'n/a'),
					'CSR' = COALESCE(CSR.FirstName+' '+CSR.LastName, CSR.LastName, 'n/a'),
					WCo.Name as 'WritingCo',
					PCo.Name as 'ParentCo',
					OH.Office,
					OH.Contact as 'OfficeContact',
					OH.ContactTitle,
					OH.ContactEmail,
					OH.ContactPhone,
					OH.MarketingName,
					REM.Remark as BillTo,
					GLG.ShortName as 'PolState',
					'RenewalRptFlagDesc' = CASE WHEN BPI.RenewalRptFlag = 'N' THEN 'Non-Renewed'
										WHEN BPI.RenewalRptFlag = 'A' THEN 'Active'
										WHEN BPI.RenewalRptFlag = 'I' THEN 'Include'
										WHEN BPI.RenewalRptFlag = 'R' THEN 'Renewed'
										ELSE 'Other' END
			From	AFW_Customer C
					--joined to get the most recent active policies
					Inner Join AFW_BasicPolInfo BPI
						on C.CustId = BPI.CustId
						and BPI.Status in ('A','C') -- Add, Change
						and BPI.PolSubType = 'P' -- Policy
						AND bpi.PolTypeLOB in ('Homeowners','Dwelling Fire')
						and BPI.RenewalRptFlag in ('A','R','I','N') -- Active, Renewed, Include, Non-Renewed (active until exp dt)
						and GetDate() between BPI.PolEffDate and BPI.PolExpDate -- Effective Policy Term
						--and CONVERT(date,bpi.PolExpDate) between dateadd(dd, 30, CONVERT(date, GETDATE())) and DATEADD(dd, 45, CONVERT(date,GETDATE()))
					--joined to get the name of the office on the policy
					Left Join AFW_Employee EXC
						ON BPI.ExecCode = EXC.EmpCode
						AND EXC.Status in ('A','C') -- Add, Change
					--joined to get the name of the CSR on the policy
					Left Join AFW_Employee CSR
						ON BPI.CSRCode = CSR.EmpCode
						AND CSR.Status in ('A','C') -- Add, Change
					--joined to get the name of the underwriting company on the policy
					Left Join AFW_Company WCo
						ON BPI.WritingCoCode = WCo.CoCode
					--joined to get the name of the parent carrier/company on the policy
					Left Join AFW_Company PCo
						ON WCo.ParentCoCode = PCo.CoCode
					--joined to get the state/group the policy is assigned to for tax purposes
					Left Join AFW_GeneralLedgerGroup GLG
						ON BPI.GLGrpCode = GLG.GLGrpCode
					--joined to get the office specific info for Marketing purposes
					Left Join (
							Select
								SUBSTRING(DescriptSusp, 14, 4) as 'OfficeNum', 
								SUBSTRING(DescriptSusp, 28, 75) as 'Office',
								SUBSTRING(DescriptSusp, 364, 75) as 'Contact',
								SUBSTRING(DescriptSusp, 439, 75) as 'ContactTitle',	
								SUBSTRING(DescriptSusp, 514, 100) as 'ContactEmail',
								SUBSTRING(DescriptSusp, 614, 12) as 'ContactPhone',	
								SUBSTRING(DescriptSusp, 776, 150) as 'MarketingName',
								SUBSTRING(DescriptSusp, 1356, 3) as 'ExecCode'
							From AFW_Suspense a
							Where a.EntityType = 2
								and a.DBAction = 'System Maintenance (Home Office)'
								and SUBSTRING(a.DescriptSusp, 0, 14) = 'Office_HackV2'
							) as OH
						ON BPI.ExecCode = OH.ExecCode
					left join (
							Select	m.PolId
								, 'remark' = CASE WHEN m.remark = 'Payor Code: Mortgagee' THEN 'Mortgage Billed'
												ELSE 'Insured Pay Plan' END
						FROM	AFW_Remark m
						JOIN	(
							SELECT	m1.polId
									, MAX(m1.ChangedDate) mdt
							FROM	AFW_Remark m1
							where	m1.Status <> 'D'
							GROUP	BY m1.PolId
						) md_tbl ON m.PolId = md_tbl.PolId and m.ChangedDate = md_tbl.mdt
						WHERE	m.Status <> 'D'
								AND	(m.Remark = 'Payor Code: Insured' OR m.Remark = 'Payor Code: Mortgagee')
						GROUP	BY m.PolId, m.Remark
					) REM on BPI.PolId = REM.PolId
			Where
				C.Active = 'Y' -- Active
				and C.TypeCust = 'C' -- Customer
				and PCo.Name in ('Capitol Preferred Insurance Company', 'Southern Fidelity Insurance')
				and CONVERT(date,bpi.PolExpDate) between {0} and {1}
				and OH.OfficeNum in ('0004', '0220', '0120', '0063', '0055', '0088', '0062')
				--and CONVERT(date,bpi.PolExpDate) between dateadd(dd, 30, CONVERT(date, GETDATE())) and DATEADD(dd, 45, CONVERT(date,GETDATE()))
				--and convert(date,BPI.PolExpDate) between dateadd(dd,30,getdate()) and dateadd(dd,45,getdate())
		) Pols
		LEFT JOIN (SELECT a.PolId, a.CoverageCode, a.formno, a.DescrCov, a.Iscoverage, a.limit1, a.limit2, a.deduct1, a.deduct2, a.deducttype1, a.deducttype2, a.FullTermPrem FROM AFW_Coverage a
					INNER JOIN (SELECT PolId, CoverageCode, MAX(entereddate) med
								FROM AFW_Coverage
								WHERE Status in('A','C')
								GROUP BY PolId, CoverageCode) md
						on a.PolId = md.PolId and a.CoverageCode = md.CoverageCode and a.EnteredDate = md.med
			WHERE a.Status in('A','C')
			and a.effdate > @Beg_dt
			) cov
		ON cov.PolId = Pols.PolId
			LEFT JOIN (SELECT hrt.* from AFW_HomeRating hrt
						INNER JOIN (SELECT DISTINCT * FROM (SELECT polid, MAX(changeddate) med FROM AFW_HomeRating where Status in('A','C') group by PolId) med) md1
							on hrt.PolId = md1.PolId and hrt.ChangedDate = md1.med) rtng
				ON rtng.PolId = Pols.PolId
			LEFT JOIN (select c.* from AFW_Location c
						INNER JOIN (select distinct * from (select LocId, MAX(changeddate) med from AFW_Location where Status in('A','C') group by LocId) med2) md2
							on c.LocId = md2.LocId and c.ChangedDate = md2.med) cd
				ON rtng.LocId = cd.LocId
			LEFT JOIN (SELECT a.PolId, a.LocId, a.FormType FROM AFW_FormType a
						INNER JOIN (select distinct * from (select PolId, LocId, MAX(changeddate) med from AFW_FormType where Status in('A','C') group by PolId, LocId) med2) md2
							on a.PolId = md2.PolId and a.LocId = md2.LocId and a.ChangedDate = md2.med) frm
				ON rtng.PolId = frm.PolId
				AND rtng.LocId = frm.LocId
)ttl
group by ttl.PolId
		, ttl.PolTypeLOB
		, ttl.PolNo
		, ttl.PolEffDate
		, ttl.PolExpDate
		, ttl.FirstName
		, ttl.LastName
		, ttl.DOB
		, ttl.Phone
		, ttl.Addr1
		, ttl.City
		, ttl.State
		, ttl.ZipCode
		, ttl.County
		, ttl.FormType
		, ttl.FullTermPremium
		, ttl.ConstructionType
		, ttl.rt_YrBlt
		, ttl.DwellingUse
		, ttl.NoOfFamilies
		, ttl.NoOfFireDiv
		, ttl.TerritoryCode
		, ttl.ProtClass
		, ttl.Burglar
		, ttl.Fire
		, ttl.Foundation
		, ttl.rt_ResType
		, ttl.Occupancy
		, ttl.HeatingYear
		, ttl.RoofingYear
		, ttl.WiringYear
		, ttl.DwellingLoc
		, ttl.BldgCodeGrade
		, ttl.TotalSqFt
		, ttl.SwimPool
		, ttl.DivingBoard
		, ttl.FireDistrict
		, ttl.FireDistrictCode
		, ttl.StormShutterType
		, ttl.RoofMaterial
		, ttl.NoOfStories
		, ttl.NoOfApts
		, ttl.HydrantDistance
		, ttl.FireStaDistance
		, ttl.ParentCo
		, ttl.WritingCo
		, ttl.office
		, ttl.MailAddr1
		, ttl.mailcity
		, ttl.mailstate
		, ttl.mailzip
		, ttl.email
		, ttl.Exc
		, ttl.CustNo
		, ttl.RenewalRptFlagDesc
		, ttl.BillTo