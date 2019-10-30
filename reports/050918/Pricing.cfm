<!---
	Pricing.cfr expects the query passed into it to contain the following column names:
		Field: Location_No           DataType: Integer
		Field: Address               DataType: String
		Field: Type                  DataType: String
		Field: Priority_No           DataType: Integer
		Field: Package               DataType: String
		Field: Package_No            DataType: Integer
		Field: Package_Group         DataType: String
		Field: Work_Order            DataType: String
		Field: Name                  DataType: String
		Field: CONTINGENCY           DataType: Float
		Field: CONTINGENCY_PERCENT   DataType: Float
		Field: ENGINEERS_ESTIMATE_TOTAL_COST  DataType: Float
		Field: BID_UNIT              DataType: String
		Field: UOM                   DataType: String
		Field: QUANTITY              DataType: Integer
		Field: U_PRICE               DataType: Big Decimal
		Field: DISPLAY_ORDER         DataType: Integer
		Field: CONTRACTORS_COST      DataType: Big Decimal
		Field: Item_TOTAL            DataType: Big Decimal
		Field: rowid                 DataType: Long
--->

<cfquery name="MyQuery" datasource="sidewalk">
	SELECT    a.Location_No, a.Address, a.Type, a.Priority_No, wo.Package, a.Package_No, a.Package_Group, wo.Work_Order, a.Name, e.CONTINGENCY, e.CONTINGENCY_PERCENT, e.ENGINEERS_ESTIMATE_TOTAL_COST, p.BID_UNIT, p.UOM, p.QUANTITY, p.U_PRICE, p.DISPLAY_ORDER, cp.CONTRACTORS_COST,
	
	COALESCE( p.QUANTITY * p.U_PRICE, 0 ) as 'Item_TOTAL',
	ReportLabel.Sort_Order as 'rowid'
	
	FROM      dbo.vwHDRWorkOrders AS wo
	INNER JOIN dbo.vwHDRAssessmentTracking AS a ON wo.Package = a.Package
	INNER JOIN dbo.vwHDREngineeringEstimate AS e ON a.Location_No = e.Location_No
	INNER JOIN dbo.vwHDR_RPT_Pricing AS p ON a.Location_No = p.Location_No
	INNER JOIN dbo.vwHDRContractorPricing AS cp ON a.Location_No = cp.Location_No
	LEFT JOIN ReportLabel ON p.DISPLAY_ORDER = ReportLabel.hdrk

	WHERE p.QUANTITY > 0
	  AND (wo.Package = '#URL.my_package#') 
	ORDER BY a.Package_Group, a.Package_No, a.Location_No, ( case when ReportLabel.Sort_Order is null then 1 else 0 end ), ReportLabel.Sort_Order, p.BID_UNIT
</cfquery>

<cfreport template="Pricing.cfr" format="pdf" query="MyQuery">
	<cfreportparam name="my_package" value="#URL.my_package#"> <!-- String -->
</cfreport>