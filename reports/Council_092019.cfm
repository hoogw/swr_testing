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
vwHDRAssessmentTracking.Name, 
vwHDRAssessmentTracking.Type, 
vwHDRAssessmentTracking.Field_Assessed, 
vwHDRAssessmentTracking.Repairs_Required, 
vwHDRAssessmentTracking.design_start_date,
coalesce( vwHDRAssessmentTracking.Construction_Start_Date, vwHDRAssessmentTracking.Design_Start_Date ) Construction_Start_Date,
vwHDRAssessmentTracking.Construction_Completed_Date, 
vwHDRAssessmentTracking.Anticipated_Completion_Date, 
vwHDRAssessmentTracking.Package, 
vwHDRWorkOrders.Notice_To_Proceed_Date,
vwHDRAssessmentTracking.Date_Logged,
vwHDRAssessmentTracking.sr_number,
case 
	when vwHDRAssessmentTracking.Construction_Start_Date is not null then 'Construction'
	when vwHDRAssessmentTracking.Design_Start_Date is not null AND vwHDRAssessmentTracking.Construction_Start_Date is null then 'Design'
	else 'Queue'
end Phase
FROM      dbo.vwHDRAssessmentTracking
left outer join dbo.vwHDRWorkOrders 
on     dbo.vwHDRAssessmentTracking.Package_No = dbo.vwHDRWorkOrders.Package_No
  AND     dbo.vwHDRAssessmentTracking.Package_Group = dbo.vwHDRWorkOrders.Package_Group
ORDER BY vwHDRAssessmentTracking.Council_District, phase, Date_Logged, vwHDRAssessmentTracking.Location_No
</cfquery>

<cfreport template="Councils.cfr" format="pdf" query="ReportQuery"/>