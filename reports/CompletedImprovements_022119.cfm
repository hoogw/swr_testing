<!---
	CompletedImprovements.cfr expects the query passed into it to contain the following column names:
		Field: Ramp_Count            DataType: Integer
		Field: Address               DataType: String
		Field: Council_District      DataType: Float
		Field: Zip_Code              DataType: String
		Field: Completed             DataType: String
		Field: Location_No           DataType: Integer
--->

<cfquery name="ReportQuery" datasource="sidewalk">

with pai ( location_no, count, completed) as (
select location_no, count(*), max(construction_completed_date)
from tblCurbRamps
where construction_completed_date <> '' and construction_completed_date is not null
group by location_no )

select a.Location_No,a.Council_District, a.Address, a.Zip_Code, pai.count ramp_count, pai.completed
from pai
inner join vwHDRAssessmentTracking a on pai.location_no = a.Location_No
order by pai.completed desc
</cfquery>





<cfreport template="CompletedImprovements.cfr" format="pdf" query="ReportQuery"/>