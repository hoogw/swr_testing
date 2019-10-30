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
<cfparam name="qs" type="date" default='2017-7-1' />
<cfparam name="qe" type="date" default=#end_date# />
<cfparam name="qel" type="string" default="Present Day" />
<cfparam name="qlock" type="boolean" default="False" />

<cfif IsDefined("URL.start_year") and IsValid("integer", URL.start_year) >
	<cfset qs = CreateDate( URL.start_year, 7, 1) />
</cfif>

<cfif IsDefined("URL.report_year") and IsValid("integer", URL.report_year) >
	<cfif URL.report_year gt 2017 and URL.report_year lt 2100 >
		<cfset qe = CreateDate( URL.report_year, 6, 30) />
		<cfset qel = DateFormat(qe, "MMMM d, yyyy") />
		<cfset qlock = "True" />
	</cfif>
</cfif>

<cfquery name="MyQuery" datasource="sidewalk">
	SELECT    Ramp_No, Primary_Street, Secondary_Street, c.Council_District, c.Zip_Code, c.Construction_Completed_Date, c.Location_No, Intersection_Corner
	FROM      dbo.tblCurbRamps c
	INNER JOIN vwHDRAssessmentTracking a on c.location_no = a.Location_No
	WHERE     ( removed is null or removed = '' ) AND (c.Construction_Completed_Date <> '' AND 
	c.Construction_Completed_Date >= <cfqueryparam value=#qs# CFSQLTYPE="CF_SQL_DATE" /> AND
	c.Construction_Completed_Date <= <cfqueryparam value=#qe# CFSQLTYPE="CF_SQL_DATE" /> )
	<cfif qlock >
	and ( a.locked = 'yes' )
	</cfif>
	ORDER BY c.Council_District, c.Zip_Code 
</cfquery>


<cfset sd = DateFormat(qs, "MMMM d, yyyy") />

<cfreport template="CompletedCurbRamps.cfr" format="pdf" query="MyQuery" >
<cfreportparam name="Report_Start_Date" value=#sd# />
<cfreportparam name="Report_End_Date" value=#qel# />
</cfreport>