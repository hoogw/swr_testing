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


<cfparam name="planting_start" type="date" default="2000-1-1" />
<cfparam name="planting_end" type="date" default="2100-1-1" />

<cfparam name="myTitle" type="string" default="Trees Planted" />
<cfset myTitle = "Trees Planted from " & planting_start & " to " & planting_end />

<cfscript>

    outdir = "D:/sidewalk_repair/downloads/";

    myFile = outdir & "ttt.xls";

    myQuery = new Query( datasource = "sidewalk" );
    myQuery.setSql("select
        site_type,
        Site_Subtype,
        t.Location_No,
        a.Name,
        a.address,
        a.Construction_Start_Date,
        a.Construction_Completed_Date,
        t.TREE_NO,
        t.TREE_PLANTING_DATE,
        t.ADDRESS,
        s.TREE_REMOVAL_NOTES
    from vwHDRTreeList t
    inner join vwHDRTreeSiteInfo s on t.Location_No = s.Location_No
    left join vwHDRAssessmentTracking a on t.Location_No = a.Location_No
    where t.TREE_PLANTING_DATE between :p_start and :p_end 
    order by t.TREE_PLANTING_DATE desc" );

    myQuery.addParam(name="p_start", value=planting_start, cfsqltype="CF_SQL_DATE");
    myQuery.addParam(name="p_end", value=planting_end, cfsqltype="CF_SQL_DATE");
    trees = myQuery.execute().getResult();

    myXls = SpreadsheetNew( "Tree Data" );
    SpreadsheetAddRow( myXls, "Sidewalk Repair Program", 1,1 );
    SpreadsheetAddRow( myXls, myTitle, 2,1 );
    SpreadsheetAddRow( myXls, "", 3, 1);
    SpreadsheetAddRow( myXls, "Type,Subtype,Site No,Facility Name,Facility Addres,Constrution Start Date,Construction Completed Date,Tree No,Tree Planting Date,Address,Notes", 4,1);
    SpreadsheetAddRows( myXls, trees );
   
    SpreadsheetWrite( myXls, myFile, "yes" );

</cfscript>

<cfheader name="Content-Disposition" value="attachment; filename=tree_planted.xls" />
<cfcontent type="application/vnd.ms-excel" file="#myFile#" deletefile="yes" />