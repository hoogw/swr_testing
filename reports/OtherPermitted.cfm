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
select distinct Council_District councildistrict 
	, location
	, zipcode Zip_Code
from vwHDRReportPermits
order by councildistrict, zip_code, location
</cfquery>


<cfset qel = DateFormat(qe, "MMMM d, yyyy") />

<cfreport template="OtherPermitted.cfr" format="pdf" query="ReportQuery" >
<cfreportparam name="Report_End_Date" value=#qel# />
</cfreport>