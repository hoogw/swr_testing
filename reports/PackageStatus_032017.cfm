<!---
	PackageStatus.cfr expects the query passed into it to contain the following column names:
		Field: Package               DataType: String
		Field: Package_No            DataType: String
		Field: Package_Group         DataType: String
		Field: Engineers_Estimate    DataType: Big Decimal
		Field: Work_Order            DataType: String
		Field: Bids_Due_Date         DataType: Time Stamp
		Field: Construct_Order_Date  DataType: Time Stamp
		Field: Precon_Meeting_Date   DataType: Time Stamp
		Field: Notice_To_Proceed_Date  DataType: Time Stamp
		Field: Awarded_Bid           DataType: Big Decimal
		Field: Contractor            DataType: String
		Field: Construction_Start_Date  DataType: String
		Field: Construction_Completed_Date  DataType: String
		Field: Notes                 DataType: String
		Field: Total_Concrete        DataType: Float
		Field: CM                    DataType: String
		Field: Number_of_Sites       DataType: Integer
		Field: Number_of_Trees       DataType: Integer
		Field: Contract_Number       DataType: String
		Field: Fiscal_Year           DataType: String
		Field: Not_to_Exceed_Amount  DataType: Float
		Field: Site_Walk_Date        DataType: Time Stamp
		Field: Ten_Day_Notice_Date   DataType: Time Stamp
		Field: percent_Complete      DataType: Integer
		Field: Status                DataType: String
--->

<cfquery name="ReportQuery" datasource="sidewalk">
WITH trees( loc, ntrees ) AS
(
SELECT Location_No, count(ID) FROM vwHDRTreeList GROUP BY Location_No
),
tracking ( package, nsites, csites, total, trees, sdt, cdt ) AS
(
SELECT 
	package,
	COUNT(Location_No) nsites,
	SUM( CASE WHEN construction_completed_date is null THEN 0 ELSE 1 END ) csites,
	SUM(Total_Concrete) total,
	SUM( ntrees ),
	MIN(Construction_Start_date) sdt,
	MAX(construction_Completed_Date ) cdt 
FROM vwHDRAssessmentTracking a
LEFT JOIN trees t ON a.Location_No = t.loc
GROUP BY package
)
SELECT 
	COALESCE(Construction_Manager, '') 'CM',
	COALESCE(Work_Order, '') 'Work_Order',
	wo.Package,
	COALESCE(t.nsites, 0) 'Number_of_Sites',
	COALESCE(t.total, 0) 'Total_Concrete',
	t.trees 'Number_of_Trees',
	COALESCE(Contractor, '') 'Contractor',
	COALESCE(Engineers_Estimate, 0) 'Engineers_Estimate',
	Bids_Due_Date,
	Construct_Order_Date,
	Contract_Number,
	Notice_To_Proceed_Date,
	Awarded_Bid, 
	Not_To_Exceed_Amount,
	Fiscal_Year,
	Precon_Meeting_Date,
	Site_Walk_Date,
	Ten_Day_Notice_Date,
	t.sdt 'Construction_Start_Date',
	t.csites,
	( t.csites * 100. ) / t.nsites 'percent_Complete',
	t.cdt 'Construction_Completed_Date',
	Status,
	Notes,
	package_group,
	package_no
FROM vwHDRWorkOrders wo
LEFT JOIN tracking t ON wo.Package = t.package
ORDER BY package_group, CAST( Package_No AS numeric )
</cfquery>

<cfreport template="PackageStatus.cfr" format="pdf" query="ReportQuery"/>