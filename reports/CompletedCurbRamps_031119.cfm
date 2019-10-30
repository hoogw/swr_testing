<!---
	CompletedCurbRamps.cfr expects the query passed into it to contain the following column names:
		Field: Ramp_No               DataType: Float
		Field: Primary_Street        DataType: String
		Field: Secondary_Street      DataType: String
		Field: Council_District      DataType: Float
		Field: Zip_Code              DataType: Float
		Field: Construction_Completed_Date  DataType: String
		Field: Location_No           DataType: Float
		Field: Intersection_Corner   DataType: String
--->

<cfset end_date = DateAdd("d", 1, Now()) />
<cfparam name="qe" type="date" default=#end_date# />
<cfparam name="qel" type="string" default="PRESENT DAY" />

<cfif IsDefined("URL.report_year") and IsValid("integer", URL.report_year) >
	<cfif URL.report_year gt 2017 and URL.report_year lt 2100 >
		<cfset qe = CreateDate( URL.report_year, 6, 30) />
		<cfset qel = DateFormat(qe, "MMMM d, yyyy") />
	</cfif>
</cfif>

<cfquery name="MyQuery" datasource="sidewalk">
	SELECT    Ramp_No, Primary_Street, Secondary_Street, Council_District, Zip_Code, Construction_Completed_Date, Location_No, Intersection_Corner
	FROM      dbo.tblCurbRamps 
	WHERE     (Construction_Completed_Date <> '' AND Construction_Completed_Date >= '2017-7-1') AND
	Construction_Completed_Date <= <cfqueryparam value=#qe# CFSQLTYPE="CF_SQL_DATE" />
	ORDER BY Construction_Completed_Date DESC
</cfquery>

<cfreport template="CompletedCurbRamps.cfr" format="pdf" query="MyQuery" >
<cfreportparam name="Report_End_Date" value=#qel# />
</cfreport>