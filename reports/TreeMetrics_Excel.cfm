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

<cfparam name="myTitle" type="string" default="City Plants Metrics" />
<cfset myTitle = "City Plants Metrics from " & planting_start & " to " & planting_end />

<cfscript>

    outdir = "D:/sidewalk_repair/downloads/";

    myFile = outdir & "ttt.xls";

    myQuery = new Query( datasource = "sidewalk" );
    myQuery.setSql("with good ( loc, group_no, tree_no, action_type ) as (
        select t.location_no, group_no, tree_no, action_type
        from vwHDRTreeList t
		inner join vwHDRTreeSiteInfo s on t.Location_No = s.Location_No
        where ( deleted = 0 or deleted is null ) and s.Tree_Planting_Contractor_Type = 'bss-city plants'
        and s.Tree_Planting_Assigned_Contractor_Date between :p_start and :p_end
    )
    , removal( loc, group_no, tree_no, action_type ) as (
        select * from good where action_type = 'Removal'
    )
    , plant( loc, group_no, tree_no, action_type ) as (
        select * from good where action_type = 'Planting'
    )
	, preserved2 ( loc, group_no, tree_no, action_type ) as (
		select * from good where action_type = 'Root Pruning / Shaving'
	)
    , preserved ( loc, preserved ) as (
        select loc, count(*) from good where action_type = 'Root Pruning / Shaving' group by loc
    ) 
    , report_line0 ( site, line, rloc, rgroup_no, rtree_no, raction_type, tloc, tgroup_no, ttree_no, taction_type ) as (
    select coalesce(g0.loc, g1.loc) site, coalesce(g0.tree_no, g1.tree_no) line, * 
    from removal g0
    full outer join plant g1 on g0.loc = g1.loc and g0.group_no = g1.group_no and g0.tree_no = g1.tree_no
    )
    , report_line ( site, line, rloc, rgroup_no, rtree_no, raction_type, tloc, tgroup_no, ttree_no, taction_type, ploc, pgroup_no, ptree_no, paction_type ) as (
    select coalesce(g0.site, g2.loc) site, coalesce(g0.line, g2.tree_no ) line, rloc, rgroup_no, rtree_no, raction_type, tloc, tgroup_no, ttree_no, taction_type, g2.loc, g2.group_no, g2.tree_no, g2.action_type 
    from report_line0 g0
	full outer join preserved2 g2 on g0.site = g2.loc and g0.line = g2.tree_no
    )
	--select * from report_line order by 1, 2
    select site, line
        , coalesce( r.site_type, t.site_type )
        , a.Type
        , a.Package
        , a.Location_No
        , a.Name, a.Address, a.Zip_Code
        , a.Council_District
        , a.Construction_Start_Date, a.Construction_Completed_Date
        , info.ready_to_plant

        , r.TREE_NO, r.SPECIES, r.TREE_SIZE, r.TREE_REMOVAL_DATE, info.TREE_REMOVAL_CONTRACTOR, r.REMOVALS_EXISTING_TREE_CONDITION, r.ATTEMPTED_TREE_PRESERVATION
        , t.TREE_NO, t.TREE_PLANTING_DATE, t.ADDRESS, info.TREE_PLANTING_CONTRACTOR, info.Tree_Planting_Assigned_Contractor_Date
		, p.TREE_NO, p.ROOT_PRUNING_DATE, p.ADDRESS, p.PRESERVATION_ALTERNATIVE

		
    from report_line rl
    left join vwHDRAssessmentTracking a on rl.site = a.Location_No
    left join vwHDRTreeSiteInfo info on rl.site = info.Location_No
    left join vwHDRTreeList r on rl.site = r.Location_No and rl.rgroup_no = r.group_no and rl.rtree_no = r.TREE_NO and r.ACTION_TYPE = 'Removal'
    left join vwHDRTreeList t on rl.site = t.location_no and rl.tgroup_no = t.group_no and rl.ttree_no = t.tree_no and t.ACTION_TYPE = 'Planting'
	left join vwHDRTreeList p on rl.site = p.Location_No and rl.pgroup_no = p.GROUP_NO and rl.ptree_no = p.TREE_NO and p.ACTION_TYPE = 'Root Pruning / Shaving'
    order by 1,2");

    myQuery.addParam(name="p_start", value=planting_start, cfsqltype="CF_SQL_DATE");
    myQuery.addParam(name="p_end", value=planting_end, cfsqltype="CF_SQL_DATE");
    trees = myQuery.execute().getResult();

    myXls = SpreadsheetNew( "Tree Data" );
    SpreadsheetAddRow( myXls, "1,1,Sidewalk Repair Program", 1,1);
    SpreadsheetAddRow( myXls, myTitle, 2,3 );
    SpreadsheetAddRow( myXls, "s,l, Type, Sub Type, Package, Site No, Facility Name, Facility Address, ZIP, Council District, Construction Start Date, Construction Completed Date,Ready to Plant, Tree No, Species, Size, Tree Removal Date, Contractor,Existing Tree Condition,Attempted Tree Presevation,Tree No,Tree Planting Date,Address,Contractor,Planting Assigned Contractor Date,Tree No,Root Prune Date,Address,Preservation Alternative", 4,1);
    SpreadsheetAddRows( myXls, trees );

    start_r = 5;
    end_r = 4;

    // pretty print. merge cells
    format = new Query( dbtype = "query" );
    format.setAttributes( trees = trees );
    format.setSql ("select site, count(*) as m from trees group by site");
    ff = format.execute().getResult();

    for( g in ff ) {
        end_r = end_r + g["m"];    

        // blank out counts to support Excl operations
        // for( d=start_r+1; d<=end_r; d++ ) {
        //     SpreadsheetSetCellValue( myXls, "", d, 33);
        //     SpreadsheetSetCellValue( myXls, "", d, 34);
        //     SpreadsheetSetCellValue( myXls, "", d, 35);
        //}
        SpreadsheetMergeCells( myXls, start_r, end_r, 3,3);
        SpreadsheetMergeCells( myXls, start_r, end_r, 4,4);
        SpreadsheetMergeCells( myXls, start_r, end_r, 5,5);
        SpreadsheetMergeCells( myXls, start_r, end_r, 6,6);
        SpreadsheetMergeCells( myXls, start_r, end_r, 7,7);
        SpreadsheetMergeCells( myXls, start_r, end_r, 8,8);
        SpreadsheetMergeCells( myXls, start_r, end_r, 9,9);
        SpreadsheetMergeCells( myXls, start_r, end_r, 10,10);
        SpreadsheetMergeCells( myXls, start_r, end_r, 11,11);
        SpreadsheetMergeCells( myXls, start_r, end_r, 12,12);
        SpreadsheetMergeCells( myXls, start_r, end_r, 13,13);
        start_r = start_r + g["m"];
    }
    SpreadsheetDeleteColumn( myXls, 1);
    SpreadsheetDeleteColumn( myXls, 2);
    

    // summary counts
    totalQuery = new Query( datasource = "sidewalk" );
    totalQuery.setSql( "with candidate ( location_no, assigned, ccdate ) as (
    select s.Location_No, s.Tree_Planting_Assigned_Contractor_Date, a.Construction_Completed_Date
    from vwHDRTreeSiteInfo s
    inner join vwHDRAssessmentTracking a on s.Location_No = a.Location_No
    where s.Tree_Planting_Contractor_Type = 'bss-city plants' and s.Tree_Planting_Assigned_Contractor_Date between :p_start and :p_end
    )
    , wait ( assigned, planted ) as (
    select coalesce( DATEDIFF(day, ccdate, assigned ), 1000), coalesce( DATEDIFF(day, assigned, tree_planting_date ), 1000 )
    from candidate c
    inner join vwHDRTreeList t on t.Location_No = c.location_no
    )

    select 
    sum( case when assigned <= 30 then 1 else 0 end ) ass_30,
    sum( case when assigned > 30 then 1 else 0 end ) ass_30_p,
    sum( case when planted <= 30 then 1 else 0 end ) plant_30,
    sum( case when planted > 30 then 1 else 0 end ) plant_30_p
    from wait" );

    totalQuery.addParam(name="p_start", value=planting_start, cfsqltype="CF_SQL_DATE");
    totalQuery.addParam(name="p_end", value=planting_end, cfsqltype="CF_SQL_DATE");
    summary = totalQuery.execute().getResult();

    SpreadsheetCreateSheet( myXls, "Summary" );
    SpreadsheetSetActiveSheet( myXls, "Summary" );
    SpreadsheetAddRow( myXls, "Sidewalk Repair Program" ,1,1);
    SpreadsheetAddRow( myXls, myTitle, 2,1);
    SpreadsheetAddRow( myXls, Now() ,3,1);

    SpreadsheetAddRow( myXls, "Tree Plantings assigned to City Plants by BSS Less Than 30 Days", 6,1);
    SpreadsheetSetCellValue( myXls, summary.ass_30[1], 6,2 );
    SpreadsheetAddRow( myXls, "Tree Plantings assigned to City Plants by BSS Greater Than 30 Days", 7,1);
    SpreadsheetSetCellValue( myXls, summary.ass_30_p[1], 7,2);
    SpreadsheetAddRow( myXls, "Tree Planted by City Plants Less Than 30 Days From Assignment", 8,1);
    SpreadsheetSetCellValue( myXls, summary.plant_30[1], 8,2);
    SpreadsheetAddRow( myXls, "Tree Planted by City Plants Greater Than 30 Days After Assignment", 9,1);
    SpreadsheetSetCellValue( myXls, summary.plant_30_p[1], 9,2);

    SpreadsheetSetActiveSheet( myXls, "Summary" );    
    SpreadsheetWrite( myXls, myFile, "yes" );

</cfscript>

<cfheader name="Content-Disposition" value="attachment; filename=tree_metrics.xls" />
<cfcontent type="application/vnd.ms-excel" file="#myFile#" deletefile="yes" />