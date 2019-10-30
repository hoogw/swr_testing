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


<cfscript>

    outdir = "D:/sidewalk_repair/downloads/";

    myFile = outdir & "ttt.xls";

    myQuery = new Query( datasource = "sidewalk" );
    myQuery.setSql("with good ( loc, group_no, tree_no, action_type ) as (
        select location_no, group_no, tree_no, action_type
        from vwHDRTreeList
        where deleted = 0 or deleted is null
    )
    , removal( loc, group_no, tree_no, action_type ) as (
        select * from good where action_type = 'Removal'
    )
    , plant( loc, group_no, tree_no, action_type ) as (
        select * from good where action_type = 'Planting'
    )
	, preserved2 ( loc, group_no, tree_no, action_type ) as (
		select * from good where action_type not in ( 'Removal', 'Planting' )
	)
    , preserved ( loc, preserved ) as (
        select loc, count(*) from good where action_type not in ( 'Removal', 'Planting' ) group by loc
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

        , r.TREE_NO, r.SPECIES, r.TREE_SIZE, r.PERMIT_ISSUANCE_DATE, r.TREE_REMOVAL_DATE, r.ADDRESS
            , info.TREE_REMOVAL_CONTRACTOR, info.TREE_REMOVAL_NOTES
        , t.TREE_NO
            , case t.OFFSITE when 'yes' then 'Y' else '' end 
            , t.SPECIES, t.TREE_BOX_SIZE, info.Tree_Planting_Assigned_Contractor_Date, t.PERMIT_ISSUANCE_DATE, t.TREE_PLANTING_DATE, t.START_WATERING_DATE, t.END_WATERING_DATE, null
            , t.ADDRESS
            , info.TREE_PLANTING_CONTRACTOR
		, p.TREE_NO, p.SPECIES, p.PERMIT_ISSUANCE_DATE, p.ROOT_PRUNING_DATE

        , coalesce( pr.preserved, 0)
        , coalesce(ee.[EXISTING_STUMP_REMOVAL_QUANTITY],0) + coalesce(qc.[EXISTING_STUMP_REMOVAL_QUANTITY],0) + coalesce(co.[EXISTING_STUMP_REMOVAL_QUANTITY],0 )
        , coalesce(ee.[TREE_CANOPY_PRUNING_(PER_TREE)_QUANTITY],0) + coalesce(qc.[TREE_CANOPY_PRUNING_(PER_TREE)_QUANTITY],0) + coalesce(co.[TREE_CANOPY_PRUNING_(PER_TREE)_QUANTITY],0 ) canopy_prune
        , info.Root_Barrier_Lock 

    from report_line rl
    left join vwHDRAssessmentTracking a on rl.site = a.Location_No
    left join vwHDRTreeSiteInfo info on rl.site = info.Location_No
    left join vwHDRTreeList r on rl.site = r.Location_No and rl.rgroup_no = r.group_no and rl.rtree_no = r.TREE_NO and r.ACTION_TYPE = 'Removal'
    left join vwHDRTreeList t on rl.site = t.location_no and rl.tgroup_no = t.group_no and rl.ttree_no = t.tree_no and t.ACTION_TYPE = 'Planting'
	left join vwHDRTreeList p on rl.site = p.Location_No and rl.pgroup_no = p.GROUP_NO and rl.ptree_no = p.TREE_NO and p.ACTION_TYPE = 'Root Pruning / Shaving'
    left join vwHDREngineeringEstimate ee on rl.site = ee.Location_No
    left join vwHDRQCQuantity qc on rl.site = qc.Location_No
    left join vwHDRChangeOrders co on rl.site = co.Location_No
    left join preserved pr on rl.site = pr.loc
    order by 1,2" );

    trees = myQuery.execute().getResult();

    myXls = SpreadsheetNew( "Tree Data" );
    SpreadsheetAddRow( myXls, "Removal", 1,14);
    SpreadsheetSetCellValue( myXls, "Removal", 1, 14);
    SpreadsheetSetCellValue( myXls, "Planting", 1, 22);
    SpreadsheetSetCellValue( myXls, "Preserved", 1, 34);
    SpreadsheetAddRow( myXls, "s,l, Type, Sub Type, Package, Site No, Facility Name, Facility Address, ZIP, Council District, Construction Start Date, Construction Completed Date, Ready to Plant, Tree No, Species, Size, Permit Issuance Date, Tree Removal Date, Address, Contractor, Notes, Tree No, Offsite, Species, Box Size, Assign Date, Permit Issuance Date, Tree Planting Date, Start Watering Date, End Watering Date, Most Recent Watering Date, Addres, Contractor, Tree No, Species, Permit Issuance Date, Root Prune Date, Trees Preserved, Existing Stump Removal, Tree Canopy Pruning, Root Control Barrier Installed", 2,1);
    SpreadsheetAddRows( myXls, trees );

    // pretty print. merge cells
    format = new Query( dbtype = "query" );
    format.setAttributes( trees = trees );
    format.setSql ("select site, count(*) as m from trees group by site");
    ff = format.execute().getResult();

    start_r = 3;
    end_r = 2;

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
        // SpreadsheetMergeCells( myXls, start_r, end_r, 14,14);
        SpreadsheetMergeCells( myXls, start_r, end_r, 20,20);
        SpreadsheetMergeCells( myXls, start_r, end_r, 21,21);
        SpreadsheetMergeCells( myXls, start_r, end_r, 31,31);
        SpreadsheetMergeCells( myXls, start_r, end_r, 32,32);
        SpreadsheetMergeCells( myXls, start_r, end_r, 33,33);
        SpreadsheetMergeCells( myXls, start_r, end_r, 38,38);
        SpreadsheetMergeCells( myXls, start_r, end_r, 39,39);
        SpreadsheetMergeCells( myXls, start_r, end_r, 40,40);
        SpreadsheetMergeCells( myXls, start_r, end_r, 41,41);
        start_r = start_r + g["m"];
    }
    SpreadsheetDeleteColumn( myXls, 1);
    SpreadsheetDeleteColumn( myXls, 2);
    

    // summary counts
    totalQuery = new Query( datasource = "sidewalk" );
    totalQuery.setSql( "with good ( location_no, action_type, planted_tree_condition, has_removal, has_planting ) as (
        select Location_No, action_type, planted_tree_condition,
        case when TREE_REMOVAL_DATE is null then 0 else 1 end,
        case when TREE_PLANTING_DATE is null then 0 else 1 end
        from vwHDRTreeList
        where DELETED = 0
    )

    select 1, 'Total Number of Trees Preserved', count(*) from good 
    inner join vwHDRAssessmentTracking a on good.location_no = a.Location_No
    where action_type not in ( 'removal', 'planting' ) and a.Construction_Completed_Date is not null

    union
    select 2, 'Total Number of Trees Removed', count(*) from good where action_type = 'removal' and has_removal = 1

    union
    select 3, 'Total Number of Trees Planted', count(*) from good where action_type = 'planting' and has_planting = 1

    union
    select 4, 'Total Number of Trees Planted identified as Dead/Failed', COUNT(*) from good where action_type = 'planting' and has_planting = 1 and planted_tree_condition = 'dead' " );

    summary = totalQuery.execute().getResult();

    SpreadsheetCreateSheet( myXls, "Summary" );
    SpreadsheetSetActiveSheet( myXls, "Summary" );
    SpreadsheetAddRow( myXls, "Sidewalk Repair Program" ,1,2);
    SpreadsheetAddRow( myXls, "Tree Report", 2,2);
    SpreadsheetAddRow( myXls, Now() ,3,2);
    SpreadsheetAddRows( myXls, summary, 5,1);
    SpreadsheetDeleteColumn( myXls, 1);
    SpreadsheetShiftColumns( myXls, 2,3, -1);

    // by programs
    totalQuery.setSql("with good ( package_no, ccdate, action_type, site_type, site_subtype, tree_planting_date, tree_removal_date, t_type, offsite) as
        ( 
            select a.Package_No, a.Construction_Completed_Date, t.ACTION_TYPE, t.Site_Type, t.Site_Subtype, t.TREE_PLANTING_DATE, t.TREE_REMOVAL_DATE, t.TYPE, t.Offsite
            from vwHDRTreeList t
            inner join vwHDRAssessmentTracking a on t.Location_No = a.Location_No
            where t.DELETED = 0 OR t.DELETED IS NULL 
        )
        select site_type, site_subtype
            , sum( case when action_type = 'Planting' and tree_planting_date is not null then 1 else 0 end ) planted
            , sum( case when action_type = 'Removal' and tree_removal_date is not null then 1 else 0 end ) removed
            , sum( case when action_type not in ('Removal', 'Planting') and ccdate is not null then 1 else 0 end ) preserved
        from good
        group by site_type, site_subtype
        order by site_type, site_subtype");

    prgms = totalQuery.execute().getResult();
    SpreadsheetCreateSheet( myXls, "Summary By Programs" );
    SpreadsheetSetActiveSheet( myXls, "Summary By Programs" );
    SpreadsheetAddRow( myXls, "Sidewalk Repair Program" ,1,1);
    SpreadsheetAddRow( myXls, "Tree Report", 2,1);
    SpreadsheetAddRow( myXls, Now() ,3,1);
    SpreadsheetAddRow( myXls, "Site Type,Site Subtype,Planted,Removed,Preserved", 5,1);
    SpreadsheetAddRows( myXls, prgms, 6,1);

    // replacement
    totalQuery.setSql("with good ( location_no, ccdate, action_type, site_type, site_subtype, tree_planting_date, tree_removal_date, t_type, offsite, contractor, assigned ) as
        ( 
            select a.Location_No, 
                case when a.Construction_Completed_Date is null then 0 else 1 end, 
                t.ACTION_TYPE, t.Site_Type, t.Site_Subtype, t.TREE_PLANTING_DATE, t.TREE_REMOVAL_DATE, t.TYPE, t.Offsite, 
                case when s.Tree_Planting_Contractor_Type = 'bss-city plants' then 1 else 0 end, 
                case when s.Tree_Planting_Assigned_Contractor_Date is null then 0 else 1 end
            from vwHDRTreeList t
            inner join vwHDRTreeSiteInfo s on t.Location_No = s.Location_No
            inner join vwHDRAssessmentTracking a on t.Location_No = a.Location_No
            where t.DELETED = 0 OR t.DELETED IS NULL 
        ), 
                
        fact ( location_no, ccdate, contractor, assigned, removes, planted, plantings ) as (
        select location_no, ccdate, contractor, assigned,
            sum( case when action_type = 'removal' and tree_removal_date is not null then 1 else 0 end ) removes,
            sum( case when action_type = 'planting' and tree_planting_date is not null then 1 else 0 end ) planted,
            sum( case when action_type = 'planting' and tree_planting_date is not null then 1 else 0 end ) plantings
        from good
        -- where tree_planting_date is null and tree_removal_date is null and contractor = 'bss-city plants' and ccdate is not null 
        group by location_no, ccdate, contractor, assigned
        ),

        pending ( location_no, ccdate, contractor, assigned, removes, planted, plantings, missing ) as (
            select location_no, ccdate, contractor, assigned, removes, planted, plantings, ( removes *2 ) - planted
            from fact
            where removes * 2 > planted
        )

        select --site_type, site_subtype, 
        offsite,
        sum( case when action_type not in ( 'removal', 'planting' ) and ccdate is not null then 1 else 0 end ) preserved,
        sum( case when action_type = 'removal' and tree_removal_date is not null then 1 else 0 end ) removed,
        sum( case when action_type = 'planting' and tree_planting_date is not null then 1 else 0 end ) planted,

            ( select coalesce ( sum( missing ), 0 ) from pending where contractor = 1 and assigned = 1 ) a_city_plants,
            ( select coalesce ( sum( missing ), 0 ) from pending where ccdate = 1 and contractor = 1 and assigned = 0 ) p_a_city_plants,
            ( select coalesce ( sum( missing ), 0 ) from pending where ccdate = 0 ) p_consturction

        from good
        group by offsite");

    updates = totalQuery.execute().getResult();

    supdate = new Query( dbtype = "query" );
    supdate.setAttributes( updates = updates );
    supdate.setSql( "select sum(preserved) pr, sum(removed) r, sum(planted) pl, sum(a_city_plants) a  from updates" );
    srst = supdate.execute().getResult();

    //
    SpreadsheetCreateSheet( myXls, "Tree Replacement Update" );
    SpreadsheetSetActiveSheet( myXls, "Tree Replacement Update" );
    SpreadsheetAddRow( myXls, "Sidewalk Repair Program" ,1,1);
    SpreadsheetAddRow( myXls, Now() ,2,1);
    SpreadsheetAddRow( myXls, "Tree Replacement Update", 3,1);
    SpreadsheetMergeCells( myXls, 3,3, 1,7 );

    SpreadsheetAddRow( myXls, "Sidewalk Program, Sidewalk Program", 5,3 );
    SpreadsheetAddRow( myXls, "Preserved Trees,Preserved Trees,0", 6,1);
    SpreadsheetAddRow( myXls, "Removed Trees,Removed Trees,0", 7,1);
    SpreadsheetAddRow( myXls, "Planted Trees,Trees Planted - Onsite, 0,0", 8,1);
    SpreadsheetAddRow( myXls, "Planted Trees,Trees Planted - Offsite, 0,0", 9,1);
    SpreadsheetAddRow( myXls, "Pending Planting,Assigned to City Plants, 0,0", 10,1);
    SpreadsheetAddRow( myXls, "Pending Planting,Pending Assignments to City Plants, 0,0", 11,1);
    SpreadsheetAddRow( myXls, "Pending Planting,Pending Construction Completion, 0,0", 12,1);
    SpreadsheetAddRow( myXls, "Pending Planting,Other Pending, 0,0", 13,1);

    // SpreadsheetAddRows( myXls, updates, 20,1 );

    //
    // sidewalk
    if ( srst.recordcount > 0 ) {
        SpreadsheetSetCellValue( myXls, srst.pr[1], 6,3 );
        SpreadsheetSetCellValue( myXls, srst.r[1], 7,3 );
        SpreadsheetSetCellValue( myXls, updates.planted[2], 8,3 );
        SpreadsheetSetCellValue( myXls, updates.planted[1], 9,3 );
        SpreadsheetSetCellValue( myXls, srst.pl[1], 8,4);

        SpreadsheetSetCellValue( myXls, updates.a_city_plants[1], 10,3 );
        SpreadsheetSetCellValue( myXls, updates.p_a_city_plants[1], 11,3 );
        SpreadsheetSetCellValue( myXls, updates.p_consturction[1], 12,3 );

        SpreadsheetSetCellFormula( myXls, "(c7*2)-d8-sum(c10:c12)", 13,3 );
    }    
    
    shet = myXls.getWorkBook().getSheetAt( javacast("int", 3));
        for( i=0; i<7; i++)
            shet.autoSizeColumn( javacast("int", i));

    SpreadsheetMergeCells( myXls, 5,5, 3,4 );
    SpreadsheetMergeCells( myXls, 6,6, 3,4 );
    SpreadsheetMergeCells( myXls, 7,7, 3,4 );
    SpreadsheetMergeCells( myXls, 10,10, 3,4 );
    SpreadsheetMergeCells( myXls, 11,11, 3,4 );
    SpreadsheetMergeCells( myXls, 12,12, 3,4 );
    SpreadsheetMergeCells( myXls, 13,13, 3,4 );

    SpreadsheetMergeCells( myXls, 6,6, 1,2 );
    SpreadsheetMergeCells( myXls, 7,7, 1,2 );
    SpreadsheetMergeCells( myXls, 8,9, 1,1 );
 
    SpreadsheetMergeCells( myXls, 10,13, 1,1 );

    SpreadsheetMergeCells( myXls, 8,9, 4,4 );

    myFormat = StructNew();
    myFormat.alignment = "center";
    myFormat.verticalalignment = "vertical_center";
    SpreadsheetFormatCellRange( myXls, myFormat, 5,3, 13,4 );


    SpreadsheetSetActiveSheet( myXls, "Summary" );    
    SpreadsheetWrite( myXls, myFile, "yes" );

</cfscript>

<cfheader name="Content-Disposition" value="attachment; filename=tree_tracking.xls" />
<cfcontent type="application/vnd.ms-excel" file="#myFile#" deletefile="yes" />