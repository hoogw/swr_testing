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
<cfparam name="qel" type="string" default="Present Day" />
<cfparam name="qlock" type="boolean" default="False" />

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
select distinct a.Location_No,a.Council_District, a.Address, a.Zip_Code, 0 ramp_count,
case 
when a.sr_number is null then 'PENDING'
when design_start_date is not null and construction_start_date is not null then 'CONSTRUCTION' 
when design_start_date is null and construction_start_date is null then 'QUEUE' 
when design_start_date is not null and construction_start_date is null then 'DESIGN' 
end completed
--, r.*, a.Category, a.Type, a.Date_Logged
from vwARPDatabaseRequests r
right join vwHDRAssessmentTracking a on r.sr_number = a.SR_Number
where 
--ar_status_cd in ( 'bssassessmentcompleted', 'pendingbssreview', 'received' )
(( a.date_logged >= <cfqueryparam value=#qs# CFSQLTYPE="CF_SQL_DATE" /> ) and
	( a.date_logged <= <cfqueryparam value=#qe# CFSQLTYPE="CF_SQL_DATE" /> ))
and a.category = 'access request' and a.name not like 'Non%SAR%'
and a.Construction_Completed_Date is null

union

select distinct a.Location_No,r.Council_Dist, r.job_Address, r.Zip_Cd, 0 ramp_count,
case
when a.sr_number is null then 'PENDING'
else 'QUEUE2'  
end completed
--, r.*, a.Category, a.Type, a.Date_Logged
from vwARPDatabaseRequests r
left join vwHDRAssessmentTracking a on r.sr_number = a.SR_Number
where 
ar_status_cd in ( 'bssassessmentcompleted', 'pendingbssreview', 'received' ) and a.SR_Number is null and r.sr_number is not null
and (( r.ddate_submitted >= <cfqueryparam value=#qs# CFSQLTYPE="CF_SQL_DATE" /> ) and
	( r.ddate_submitted <= <cfqueryparam value=#qe# CFSQLTYPE="CF_SQL_DATE" /> ))
order by a.Council_district, a.Zip_Code, a.Address, a.Location_No
</cfquery>



<cfset sd = DateFormat(qs, "MMMM d, yyyy") />

<cfreport template="PendingAccessRequests.cfr" format="pdf" query="ReportQuery" >
<cfreportparam name="Report_Start_Date" value=#sd# />
<cfreportparam name="Report_End_Date" value=#qel# />
</cfreport>