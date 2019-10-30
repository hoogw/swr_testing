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

<cfquery name="MyQuery" datasource="sidewalk">
	SELECT    Ramp_No, Primary_Street, Secondary_Street, Council_District, Zip_Code, Construction_Completed_Date, Location_No, Intersection_Corner
	FROM      dbo.tblCurbRamps 
	WHERE     (Construction_Completed_Date <> '' AND Construction_Completed_Date >= '2017-7-1')
	ORDER BY Construction_Completed_Date DESC
</cfquery>

<cfreport template="CompletedCurbRamps.cfr" format="pdf" query="MyQuery"/>