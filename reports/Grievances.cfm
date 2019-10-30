<!---
		Field: Address               DataType: String
		Field: Council_District      DataType: Float
		Field: Zip_Code              DataType: String
--->

<cfset end_date = DateAdd("d", 1, Now()) />
<cfparam name="qs" type="date" default='2017-7-1' />
<cfparam name="qe" type="date" default=#end_date# />
<cfparam name="qel" type="string" default="Present Day" />

<cfif IsDefined("URL.start_year") and IsValid("integer", URL.start_year) >
	<cfset qs = CreateDate( URL.start_year, 7, 1) />
</cfif>

<cfif IsDefined("URL.report_year") and IsValid("integer", URL.report_year) >
	<cfif URL.report_year ge 2017 and URL.report_year lt 2100 >
		<cfset qe = CreateDate( URL.report_year, 6, 30) />
		<cfset qel = DateFormat(qe, "MMMM d, yyyy") />
	</cfif>
</cfif>

<cfquery name="ReportQuery" datasource="sidewalk">
select a.Location_No,a.Council_District, a.Address, a.Zip_Code
from vwHDRAssessmentTracking a
where (( a.date_logged >= <cfqueryparam value=#qs# CFSQLTYPE="CF_SQL_DATE" /> ) and
	( a.date_logged <= <cfqueryparam value=#qe# CFSQLTYPE="CF_SQL_DATE" /> ))
and a.grievance = 'yes'
order by a.Council_District, a.Zip_Code, a.Address
</cfquery>



<cfset sd = DateFormat(qs, "MMMM d, yyyy") />

<cfreport template="Grievances.cfr" format="pdf" query="ReportQuery" >
<cfreportparam name="Report_Start_Date" value=#sd# />
<cfreportparam name="Report_End_Date" value=#qel# />
</cfreport>