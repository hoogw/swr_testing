<!---
	CompletedImprovements.cfr expects the query passed into it to contain the following column names:
		Field: Ramp_Count            DataType: Integer
		Field: Address               DataType: String
		Field: Council_District      DataType: Float
		Field: Zip_Code              DataType: String
		Field: Completed             DataType: String
		Field: Location_No           DataType: Integer
--->


<cfset end_date = DateAdd("d", 1, Now()) />
<cfparam name="qe" type="date" default=#end_date# />
<cfparam name="qel" type="string" default="PRESENT DAY" />
<cfparam name="qlock" type="boolean" default="False" />

<cfif IsDefined("URL.report_year") and IsValid("integer", URL.report_year) >
	<cfif URL.report_year gt 2017 and URL.report_year lt 2100 >
		<cfset qe = CreateDate( URL.report_year, 6, 30) />
		<cfset qel = DateFormat(qe, "MMMM d, yyyy") />
		<cfset qlock = "True" />
	</cfif>
</cfif>

<cfquery name="ReportQuery" datasource="sidewalk">

with pai ( location_no, count, completed) as (
select location_no, count(*), max(construction_completed_date)
from tblCurbRamps
where ( removed is null or removed = '' ) and construction_completed_date <> '' AND Construction_Completed_Date >= '2017-7-1' AND
	Construction_Completed_Date <= <cfqueryparam value=#qe# CFSQLTYPE="CF_SQL_DATE" />
group by location_no )

select a.Location_No,a.Council_District, a.Address, a.Zip_Code, coalesce(pai.count,0) ramp_count, a.Construction_Completed_Date completed
from pai
right join vwHDRAssessmentTracking a on pai.location_no = a.Location_No
where Construction_Completed_Date >= '2017-7-1'
<cfif qlock >
and ( a.locked = 'yes' )
</cfif>
order by a.Construction_Completed_Date desc, a.Location_No
</cfquery>





<cfreport template="CompletedImprovements.cfr" format="pdf" query="ReportQuery" >
<cfreportparam name="Report_End_Date" value=#qel# />
</cfreport>