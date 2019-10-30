<!---
	CompletedImprovements.cfr expects the query passed into it to contain the following column names:
		Field: Ramp_Count            DataType: Integer
		Field: Address               DataType: String
		Field: Council_District      DataType: Float
		Field: Zip_Code              DataType: String
		Field: Completed             DataType: String
		Field: Location_No           DataType: Integer
--->

<cfparam name="qe" type="date" default="2020-06-30" />
<cfparam name="qel" type="string" default="Present Day" />

<cfif IsDefined("URL.report_year") and IsValid("integer", URL.report_year) >
	<cfif URL.report_year ge 2017 and URL.report_year lt 2100 >
		<cfset qe = CreateDate( URL.report_year, 6, 30) />
	</cfif>
</cfif>

<cfquery name="ReportQuery" datasource="sidewalk">
select id, council_district as 'sect_id', street, st_from, st_to, fiscaly, schedule
	, convert( date, schedule + ' 1, ' + right(fiscaly,2), 107) sch
from vwHDRReportStResurfacing
where convert( date, schedule + ' 1, ' + right(fiscaly,2), 107) <= <cfqueryparam value=#qe# CFSQLTYPE="CF_SQL_DATE" />
order by council_district, street
</cfquery>


<cfset qel = DateFormat(qe, "MMMM d, yyyy") />

<cfreport template="Resurfacing.cfr" format="pdf" query="ReportQuery" >
<cfreportparam name="Report_End_Date" value=#qel# />
</cfreport>