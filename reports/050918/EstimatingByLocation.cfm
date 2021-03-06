<!---
	EstimatingByLocation.cfr expects the query passed into it to contain the following column names:
		Field: Location_No           DataType: Integer
		Field: Address               DataType: String
		Field: Type                  DataType: String
		Field: Priority_No           DataType: Integer
		Field: Package               DataType: String
		Field: Package_No            DataType: Integer
		Field: Package_Group         DataType: String
		Field: BID_UNIT              DataType: String
		Field: UOM                   DataType: String
		Field: QUANTITY              DataType: Float
		Field: U_PRICE               DataType: Float
		Field: DISPLAY_ORDER         DataType: Integer
		Field: Name                  DataType: String
		Field: CONTINGENCY           DataType: Float
		Field: CONTINGENCY_PERCENT   DataType: Float
		Field: ENGINEERS_ESTIMATE_TOTAL_COST  DataType: Float
		Field: Work_Order            DataType: String
		Field: rowid                 DataType: Long
---

<cfquery name="MyQuery" datasource="sidewalk">
	SELECT    vwHDRAssessmentTracking.Location_No, vwHDRAssessmentTracking.Address, vwHDRAssessmentTracking.Type, vwHDRAssessmentTracking.Priority_No, vwHDRAssessmentTracking.Package, vwHDRAssessmentTracking.Package_No, vwHDRAssessmentTracking.Package_Group, vwUgly.BID_UNIT, vwUgly.UOM, vwUgly.QUANTITY, vwUgly.U_PRICE, vwUgly.DISPLAY_ORDER, vwHDRAssessmentTracking.Name, vwHDREngineeringEstimate.CONTINGENCY, vwHDREngineeringEstimate.CONTINGENCY_PERCENT, vwHDREngineeringEstimate.ENGINEERS_ESTIMATE_TOTAL_COST, vwHDRAssessmentTracking.Work_Order,
	
	row_number() over ( partition by vwUgly.Location_No order by vwUgly.DISPLAY_ORDER ) as 'rowid'
	
	FROM      dbo.vwHDRAssessmentTracking, dbo.vwUgly, dbo.vwHDREngineeringEstimate 
	WHERE     dbo.vwHDRAssessmentTracking.Location_No = dbo.vwUgly.Location_No
	  AND     dbo.vwHDRAssessmentTracking.Location_No = dbo.vwHDREngineeringEstimate.Location_No
	  AND vwUgly.QUANTITY > 0
	  AND     (vwHDRAssessmentTracking.Location_No = #URL.my_loc#)
	ORDER BY vwHDRAssessmentTracking.Package_Group, vwHDRAssessmentTracking.Package_No, vwHDRAssessmentTracking.Location_No, vwUgly.DISPLAY_ORDER
</cfquery>
--->

<cfquery name="MyQuery" datasource="sidewalk">
	SELECT    vwHDRAssessmentTracking.Location_No, vwHDRAssessmentTracking.Address, vwHDRAssessmentTracking.Type, vwHDRAssessmentTracking.Priority_No, vwHDRAssessmentTracking.Package, vwHDRAssessmentTracking.Package_No, vwHDRAssessmentTracking.Package_Group, vwUgly.BID_UNIT, vwUgly.UOM, vwUgly.QUANTITY, vwUgly.U_PRICE, vwUgly.DISPLAY_ORDER, vwHDRAssessmentTracking.Name, vwHDREngineeringEstimate.CONTINGENCY, vwHDREngineeringEstimate.CONTINGENCY_PERCENT, vwHDREngineeringEstimate.ENGINEERS_ESTIMATE_TOTAL_COST, vwHDRAssessmentTracking.Work_Order,
	
	ReportLabel.Sort_Order as 'rowid'
	
	FROM      dbo.vwHDRAssessmentTracking
	inner join dbo.vwUgly on dbo.vwHDRAssessmentTracking.Location_No = dbo.vwUgly.Location_No
	inner join dbo.vwHDREngineeringEstimate on dbo.vwHDRAssessmentTracking.Location_No = dbo.vwHDREngineeringEstimate.Location_No
	left join  ReportLabel on dbo.vwUgly.DISPLAY_ORDER = ReportLabel.hdrk
	WHERE  vwUgly.QUANTITY > 0
	  AND     (vwHDRAssessmentTracking.Location_No = #URL.my_loc#)
	ORDER BY vwHDRAssessmentTracking.Package_Group, vwHDRAssessmentTracking.Package_No, vwHDRAssessmentTracking.Location_No
			, ( case when ReportLabel.Sort_Order is null then 1 else 0 end ), ReportLabel.Sort_Order, dbo.vwUgly.BID_UNIT
</cfquery>


<cfheader name="Content-Disposition" value="inline; filename=EE.pdf" >
<cfreport template="EstimatingByLocation.cfr" format="pdf" query="MyQuery">
	<cfreportparam name="my_loc" value="#URL.my_loc#"> <!-- Integer -->
</cfreport>