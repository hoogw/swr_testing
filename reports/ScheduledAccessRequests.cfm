<!---
		Field: Address               DataType: String
		Field: Council_District      DataType: Float
		Field: Zip_Code              DataType: String
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
select distinct a.Location_No,a.Council_District, a.Address, a.Zip_Code
from vwHDRAssessmentTracking a
where a.date_logged <= <cfqueryparam value=#qe# CFSQLTYPE="CF_SQL_DATE" />
and a.category = 'access request' and a.scheduled = 'yes'
order by a.Council_District, a.Zip_Code, a.Address
</cfquery>


<cfset qel = DateFormat(qe, "MMMM d, yyyy") />

<cfreport template="ScheduledAccessRequests.cfr" format="pdf" query="ReportQuery" >
<cfreportparam name="Report_End_Date" value=#qel# />
</cfreport>