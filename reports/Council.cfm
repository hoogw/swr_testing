<cfoutput>
<cfif isdefined("session.userid") is false>
	<script>
	top.location.reload();
	//var rand = Math.random();
	//url = "toc.cfm?r=" + rand;
	//window.parent.document.getElementById('FORM2').src = url;
	//self.location.replace("../login.cfm?relog=exe&r=#Rand()#&s=6");
	</script>
	<cfabort>
</cfif>
<cfif session.user_level lt 0>
	<script>
	self.location.replace("../login.cfm?relog=false&r=#Rand()#&s=6&chk=authority");
	</script>
	<cfabort>
</cfif>
</cfoutput>

<!---
	Councils.cfr expects the query passed into it to contain the following column names:
		Field: Council_District      DataType: Integer
		Field: Location_No           DataType: Integer
		Field: Name                  DataType: String
		Field: Type                  DataType: String
		Field: Field_Assessed        DataType: String
		Field: Repairs_Required      DataType: String
		Field: Construction_Start_Date  DataType: Time Stamp
		Field: Construction_Completed_Date  DataType: Time Stamp
		Field: Anticipated_Completion_Date  DataType: Time Stamp
		Field: Package               DataType: String
		Field: Notice_To_Proceed_Date  DataType: Time Stamp
--->

<cfquery name="ReportQuery" datasource="sidewalk">
SELECT    
cast( vwHDRAssessmentTracking.Council_District as int ) Council_District, 
vwHDRAssessmentTracking.Location_No, 
case when (vwHDRAssessmentTracking.Type = 'Measure R (Prg. Acc. Imp)') then vwHDRAssessmentTracking.Name + ' (Measure R - CURB RAMP)'
	else vwHDRAssessmentTracking.Name
end Name, 
vwHDRAssessmentTracking.Type, 
vwHDRAssessmentTracking.Field_Assessed, 
vwHDRAssessmentTracking.Repairs_Required, 
vwHDRAssessmentTracking.design_start_date,
coalesce( vwHDRAssessmentTracking.Construction_Start_Date, vwHDRAssessmentTracking.Design_Start_Date ) Construction_Start_Date,
case
	when vwHDRAssessmentTracking.Design_Start_Date is not null AND vwHDRAssessmentTracking.Construction_Start_Date is null then vwHDRAssessmentTracking.Design_Finish_Date
	else vwHDRAssessmentTracking.Construction_Completed_Date
end 'Construction_Completed_Date', 
vwHDRAssessmentTracking.Anticipated_Completion_Date, 
vwHDRAssessmentTracking.Package, 
vwHDRWorkOrders.Notice_To_Proceed_Date,
vwHDRAssessmentTracking.Date_Logged,
vwHDRAssessmentTracking.sr_number,
case 
	when ( vwHDRAssessmentTracking.Construction_Start_Date is not null or vwHDRAssessmentTracking.Construction_Completed_Date is not null ) then 'Construction'
	when vwHDRAssessmentTracking.Design_Start_Date is not null AND vwHDRAssessmentTracking.Construction_Start_Date is null then 'Design'
	else 'Queue'
end Phase
FROM      dbo.vwHDRAssessmentTracking
left outer join dbo.vwHDRWorkOrders 
on     dbo.vwHDRAssessmentTracking.Package_No = dbo.vwHDRWorkOrders.Package_No
  AND     dbo.vwHDRAssessmentTracking.Package_Group = dbo.vwHDRWorkOrders.Package_Group
WHERE not ( Name like '%Non-SAR%' and Construction_Completed_Date is null and Construction_Start_Date is null and Design_Finish_Date is null and Design_Start_Date is null )
AND not ( category = 'Program Access Improvement' and Date_Logged < '2017-1-1' and Construction_Completed_Date is null and Construction_Completed_Date is null and Design_Finish_Date is null and Design_Start_Date is null )

ORDER BY vwHDRAssessmentTracking.Council_District, phase, Date_Logged desc, vwHDRAssessmentTracking.Location_No
</cfquery>


<cfif IsDefined("URL.D") and URL.D neq "" >
<cfquery name="ReportQuery" datasource="sidewalk">
SELECT    
cast( vwHDRAssessmentTracking.Council_District as int ) Council_District, 
vwHDRAssessmentTracking.Location_No, 
case when (vwHDRAssessmentTracking.Type = 'Measure R (Prg. Acc. Imp)') then vwHDRAssessmentTracking.Name + ' (Measure R - CURB RAMP)'
	else vwHDRAssessmentTracking.Name
end Name, 
vwHDRAssessmentTracking.Type, 
vwHDRAssessmentTracking.Field_Assessed, 
vwHDRAssessmentTracking.Repairs_Required, 
vwHDRAssessmentTracking.design_start_date,
coalesce( vwHDRAssessmentTracking.Construction_Start_Date, vwHDRAssessmentTracking.Design_Start_Date ) Construction_Start_Date,
case
	when vwHDRAssessmentTracking.Design_Start_Date is not null AND vwHDRAssessmentTracking.Construction_Start_Date is null then vwHDRAssessmentTracking.Design_Finish_Date
	else vwHDRAssessmentTracking.Construction_Completed_Date
end 'Construction_Completed_Date', 
vwHDRAssessmentTracking.Anticipated_Completion_Date, 
vwHDRAssessmentTracking.Package, 
vwHDRWorkOrders.Notice_To_Proceed_Date,
vwHDRAssessmentTracking.Date_Logged,
vwHDRAssessmentTracking.sr_number,
case 
	when ( vwHDRAssessmentTracking.Construction_Start_Date is not null or vwHDRAssessmentTracking.Construction_Completed_Date is not null ) then 'Construction'
	when vwHDRAssessmentTracking.Design_Start_Date is not null AND vwHDRAssessmentTracking.Construction_Start_Date is null then 'Design'
	else 'Queue'
end Phase
FROM      dbo.vwHDRAssessmentTracking
left outer join dbo.vwHDRWorkOrders 
on     dbo.vwHDRAssessmentTracking.Package_No = dbo.vwHDRWorkOrders.Package_No
  AND     dbo.vwHDRAssessmentTracking.Package_Group = dbo.vwHDRWorkOrders.Package_Group
WHERE vwHDRAssessmentTracking.Council_District in ( <cfqueryparam value="#URL.D#" cfsqltype="cf_sql_integer" list="true" > ) 
AND ( not ( Name like '%Non-SAR%' and Construction_Completed_Date is null and Construction_Start_Date is null and Design_Finish_Date is null and Design_Start_Date is null ))
AND ( not ( category = 'Program Access Improvement' and Date_Logged < '2017-1-1' and Construction_Completed_Date is null and Construction_Completed_Date is null and Design_Finish_Date is null and Design_Start_Date is null ))

ORDER BY vwHDRAssessmentTracking.Council_District, phase, Date_Logged desc, vwHDRAssessmentTracking.Location_No
</cfquery>
</cfif>

<cfreport template="Councils.cfr" format="pdf" query="ReportQuery"/>