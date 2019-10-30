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
<cfparam name="qs" type="date" default='2017-7-1' />
<cfparam name="qe" type="date" default=#end_date# />
<cfparam name="qel" type="string" default="PRESENT DAY" />
<cfparam name="qlock" type="boolean" default="False" />

<cfif IsDefined("URL.start_year") and IsValid("integer", URL.start_year) >
	<cfset qs = CreateDate( URL.start_year, 7, 1) />
</cfif>

<cfif IsDefined("URL.report_year") and IsValid("integer", URL.report_year) >
	<cfif URL.report_year gt 2017 and URL.report_year lt 2100 >
		<cfset qe = CreateDate( URL.report_year, 7, 1) />
		<cfset qel = DateFormat(qe, "MMMM d, yyyy") />
		<cfset qlock = "True" />
	</cfif>
</cfif>

<cfquery name="ReportQuery" datasource="sidewalk">
select a.Location_No,a.Council_District, a.Address, a.Zip_Code, 0 ramp_count, a.Construction_Completed_Date completed
from vwHDRAssessmentTracking a
where (( a.Construction_Completed_Date >= <cfqueryparam value=#qs# CFSQLTYPE="CF_SQL_DATE" /> ) and
	( a.Construction_Completed_Date < <cfqueryparam value=#qe# CFSQLTYPE="CF_SQL_DATE" /> ))
and a.category = 'access request'
<cfif qlock>
and ( a.locked = 'yes' )
</cfif>
order by a.Construction_Completed_Date desc, a.Location_No
</cfquery>



<cfset sd = DateFormat(qs, "MMM d, yyyy") />

<cfreport template="CompletedAccessRequests.cfr" format="pdf" query="ReportQuery" >
<cfreportparam name="Report_Start_Date" value=#sd# />
<cfreportparam name="Report_End_Date" value=#qel# />
</cfreport>