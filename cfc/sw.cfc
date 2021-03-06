<cfcomponent output="false">
	
	<cffunction name="addSite" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_sno" required="true">
		<!--- <cfargument name="sw_sfx" required="true"> --->
		<cfargument name="sw_name" required="true">
		<cfargument name="sw_address" required="true">
		<cfargument name="sw_type" required="true">
		<cfargument name="sw_cd" required="true">
		<!--- <cfargument name="sw_assessed" required="true"> --->
		<!--- <cfargument name="sw_assessor" required="true"> --->
		<!--- <cfargument name="sw_assdate" required="true">
		<cfargument name="sw_repairs" required="true">
		<cfargument name="sw_severity" required="true"> --->
		<!--- <cfargument name="sw_qc" required="true"> --->
		<!--- <cfargument name="sw_qcdate" required="true"> --->
		<!--- <cfargument name="sw_tcon" required="true"> --->
		<!--- <cfargument name="sw_con_start" required="true">
		<cfargument name="sw_con_comp" required="true">
		<cfargument name="sw_antdate" required="true">
		<cfargument name="sw_notes" required="true">
		<cfargument name="sw_loc" required="true">
		<cfargument name="sw_damage" required="true"> --->
		<cfargument name="sw_cityowned" required="true">
		<cfargument name="sw_priority" required="true">
		<cfargument name="sw_logdate" required="true">
		<cfargument name="sw_zip" required="true">
		<cfargument name="sw_curbramp" required="true">
		<!--- <cfargument name="sw_tree_notes" required="true"> --->
		
		<cfset var data = {}>
		
		<cfset tbl = "tblSites">
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Creation Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<!--- Retrieve New NoteID --->
		<cfquery name="chkDuplicate" datasource="#request.sqlconn#">
		SELECT count(*) as cnt FROM #tbl# WHERE location_no = #sw_sno# <!--- AND
		<cfif sw_sfx is "">site_suffix is NULL<cfelse>site_suffix = '#sw_sfx#'</cfif> --->
		</cfquery>
		
		<cfif chkDuplicate.cnt gt 0>
			<cfset data.result = "- Site Creation Failed: Duplicate Site Number.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
			
		<cftry>
			
			<!--- <cfif sw_assdate is not "">
				<cfset arrDT = listtoarray(sw_assdate,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_assdate = createODBCDate(dt)>
			</cfif>
			
			<cfif sw_qcdate is not "">
				<cfset arrDT = listtoarray(sw_qcdate,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_qcdate = createODBCDate(dt)>
			</cfif>
			
			<cfif sw_antdate is not "">
				<cfset arrDT = listtoarray(sw_antdate,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_antdate = createODBCDate(dt)>
			</cfif> --->
			
			<cfif sw_logdate is not "">
				<cfset arrDT = listtoarray(sw_logdate,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_logdate = createODBCDate(dt)>
			</cfif>
			
			<!--- <cfif sw_con_start is not "">
				<cfset arrDT = listtoarray(sw_con_start,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_con_start = createODBCDate(dt)>
			</cfif>
			
			<cfif sw_con_comp is not "">
				<cfset arrDT = listtoarray(sw_con_comp,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_con_comp = createODBCDate(dt)>
			</cfif> --->
			
			<cfset sw_name = replace(sw_name,"'","''","ALL")>
			<cfset sw_address = replace(sw_address,"'","''","ALL")>
			<!--- <cfset sw_assessor = replace(sw_assessor,"'","''","ALL")> --->
			<!--- <cfset sw_qc = replace(sw_qc,"'","''","ALL")> --->
			<!--- <cfset sw_notes = replace(sw_notes,"'","''","ALL")>
			<cfset sw_loc = replace(sw_loc,"'","''","ALL")>
			<cfset sw_damage = replace(sw_damage,"'","''","ALL")>
			<cfset sw_tree_notes = replace(sw_tree_notes,"'","''","ALL")> --->
			<!--- <cfset sw_tcon = replace(sw_tcon,",","","ALL")> --->
			
			<cfquery name="addFeature" datasource="#request.sqlconn#">
			INSERT INTO dbo.#tbl#
			( 
				Location_No,
		      	<!--- <cfif trim(sw_sfx) is not "">Site_Suffix,</cfif> --->
			    <cfif trim(sw_name) is not "">Name,</cfif>
			    <cfif trim(sw_address) is not "">Address,</cfif>
			    <cfif trim(sw_type) is not "">Type,</cfif>
			    <cfif trim(sw_cd) is not "">Council_District,</cfif>
			    <!--- <cfif trim(sw_assessed) is not "">Field_Assessed,</cfif> --->
			    <!--- <cfif trim(sw_assessor) is not "">Field_Assessor,</cfif> --->
			    <!--- <cfif trim(sw_repairs) is not "">Repairs_Required,</cfif>
				<cfif trim(sw_severity) is not "">Severity_Index,</cfif>
			    <cfif trim(sw_assdate) is not "">Assessed_Date,</cfif> --->
			    <!--- <cfif trim(sw_qc) is not "">QC,</cfif> --->
			    <!--- <cfif trim(sw_qcdate) is not "">QC_Date,</cfif> --->
				<!--- <cfif trim(sw_tcon) is not "">Total_Concrete,</cfif> --->
				<!--- <cfif trim(sw_con_start) is not "">Construction_Start_Date,</cfif>
				<cfif trim(sw_con_comp) is not "">Construction_Completed_Date,</cfif>
				<cfif trim(sw_antdate) is not "">Anticipated_Completion_Date,</cfif>
			    <cfif trim(sw_notes) is not "">Notes,</cfif>
			    <cfif trim(sw_loc) is not "">Location_Description,</cfif>
			    <cfif trim(sw_damage) is not "">Damage_Description,</cfif> --->
				<!--- <cfif trim(sw_tree_desc) is not "">Tree_Removal_Description,</cfif> --->
				<cfif trim(sw_cityowned) is not "">City_Owned_Property,</cfif>
			    <!--- <cfif trim(sw_priority) is not "">Priority_No,</cfif> ---> <!--- Removed because priority number is auto generated and new sites have a null Priority --->
			    <cfif trim(sw_logdate) is not "">Date_Logged,</cfif>
			    <cfif trim(sw_zip) is not "">Zip_Code,</cfif>
				<cfif trim(sw_curbramp) is not "">Curb_Ramp_Only,</cfif>
				User_ID,
				Creation_Date
			) 
			Values 
			(
				#sw_sno#,
				<!--- <cfif trim(sw_sfx) is not "">'#sw_sfx#',</cfif> --->
			    <cfif trim(sw_name) is not "">'#PreserveSingleQuotes(sw_name)#',</cfif>
			    <cfif trim(sw_address) is not "">'#PreserveSingleQuotes(sw_address)#',</cfif>
			    <cfif trim(sw_type) is not "">'#PreserveSingleQuotes(sw_type)#',</cfif>
			    <cfif trim(sw_cd) is not "">#PreserveSingleQuotes(sw_cd)#,</cfif>
			    <!--- <cfif trim(sw_assessed) is not "">#PreserveSingleQuotes(sw_assessed)#,</cfif> --->
			    <!--- <cfif trim(sw_assessor) is not "">'#PreserveSingleQuotes(sw_assessor)#',</cfif> --->
			   <!---  <cfif trim(sw_repairs) is not "">#PreserveSingleQuotes(sw_repairs)#,</cfif>
				<cfif trim(sw_severity) is not "">#PreserveSingleQuotes(sw_severity)#,</cfif>
			    <cfif trim(sw_assdate) is not "">#sw_assdate#,</cfif> --->
			    <!--- <cfif trim(sw_qc) is not "">'#PreserveSingleQuotes(sw_qc)#',</cfif> --->
			    <!--- <cfif trim(sw_qcdate) is not "">#sw_qcdate#,</cfif> --->
				<!--- <cfif trim(sw_tcon) is not "">#PreserveSingleQuotes(sw_tcon)#,</cfif> --->
				<!--- <cfif trim(sw_con_start) is not "">#PreserveSingleQuotes(sw_con_start)#,</cfif>
				<cfif trim(sw_con_comp) is not "">#PreserveSingleQuotes(sw_con_comp)#,</cfif>
				<cfif trim(sw_antdate) is not "">#sw_antdate#,</cfif>
			    <cfif trim(sw_notes) is not "">'#PreserveSingleQuotes(sw_notes)#',</cfif>
			    <cfif trim(sw_loc) is not "">'#PreserveSingleQuotes(sw_loc)#',</cfif>
			    <cfif trim(sw_damage) is not "">'#PreserveSingleQuotes(sw_damage)#',</cfif> --->
				<!--- <cfif trim(sw_tree_desc) is not "">'#PreserveSingleQuotes(sw_tree_desc)#',</cfif> --->
				<cfif trim(sw_cityowned) is not "">#sw_cityowned#,</cfif>
			    <!--- <cfif trim(sw_priority) is not "">#sw_priority#,</cfif> --->
			    <cfif trim(sw_logdate) is not "">#sw_logdate#,</cfif>
			    <cfif trim(sw_zip) is not "">#sw_zip#,</cfif>
				<cfif trim(sw_curbramp) is not "">#sw_curbramp#,</cfif>
				#session.user_num#,
				#CreateODBCDateTime(Now())#
			)
			</cfquery>
			
			<!--- <cfif sw_tree_notes is not "">
				<cfquery name="addFeature" datasource="#request.sqlconn#">		
				INSERT INTO dbo.tblTreeRemovalInfo
				( 
					Location_No,
					tree_removal_notes,
					User_ID,
					Creation_Date
				) 
				Values 
				(
					#sw_sno#,
					'#PreserveSingleQuotes(sw_tree_notes)#',
					#session.user_num#,
					#CreateODBCDateTime(Now())#
				)
				</cfquery>
			</cfif> --->
			
			<!--- Get the ID of record --->
			<cfquery name="getID" datasource="#request.sqlconn#">
			SELECT id FROM #tbl# WHERE location_no = #sw_sno# <!--- <cfif trim(sw_sfx) is not "">AND site_suffix = '#sw_sfx#'</cfif> --->
			</cfquery>
			
			<cfset data.id = getID.id>
			<cfset data.result = "Success">
		
		<cfcatch>
		
			<cfset data.result = "- Site Creation Failed: Database Error.">
		
			<!--- Get the ID of record --->
			<cfquery name="getID" datasource="#request.sqlconn#">
			DELETE FROM #tbl# WHERE location_no = #sw_sno# <!--- <cfif trim(sw_sfx) is not "">AND site_suffix = '#sw_sfx#'</cfif> --->
			</cfquery>
			
			<!--- <cfquery name="getID" datasource="#request.sqlconn#">
			DELETE FROM tblTreeRemovalInfo WHERE location_no = #sw_sno#
			</cfquery> --->
		
		</cfcatch>
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
		
	</cffunction>
	
	
    
    
    
    
	
	<cffunction name="addPackage" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_pgroup" required="true">
		<cfargument name="sw_pno" required="true">
		<cfargument name="sw_idList" required="true">
		
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Creation Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level lt 2>
			<cfset data.result = "- Site Creation Failed: You are not authorized to make edits.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cftry>
		
			<!--- First check if Package Exists. If not, create it --->
			<cfquery name="chkExists" datasource="#request.sqlconn#">
			SELECT count(*) as cnt FROM tblPackages WHERE package_no = #sw_pno# AND
			package_group = '#sw_pgroup#'
			</cfquery>
			
			<cfif chkExists.cnt is 0>
				<cfquery name="addPackage" datasource="#request.sqlconn#">
				INSERT INTO tblPackages (
					package_no,
					package_group,
					User_ID,
					Creation_Date
				) 
				VALUES (
					#sw_pno#,
					'#sw_pgroup#',
					#session.user_num#,
					#CreateODBCDateTime(Now())#
				)
				</cfquery>
			<cfelse>
				<cfquery name="addPackage" datasource="#request.sqlconn#">
				UPDATE tblPackages SET
				removed = NULL,
				modified_date = #CreateODBCDateTime(Now())#,
				User_ID = #session.user_num#
				WHERE package_no = #sw_pno# AND package_group = '#sw_pgroup#'
				</cfquery>
			</cfif>
			
			
			<cfset arrIDs = listtoarray(sw_idList,",")>
			<cfloop index="i" from="1" to="#arrayLen(arrIDs)#">
				
				<!--- Check if it already is in a package... --->
				<cfquery name="chkExists" datasource="#request.sqlconn#">
				SELECT count(*) as cnt FROM tblSites WHERE id = #arrIDs[i]# and package_no is null AND package_group is null
				</cfquery>
				
				<cfif chkExists.cnt gt 0>
					<cfquery name="updateSite" datasource="#request.sqlconn#">
					UPDATE tblSites SET
					package_no = #sw_pno#,
					package_group = '#sw_pgroup#',
					modified_date = #CreateODBCDateTime(Now())#,
					Packaged_Date = #CreateODBCDateTime(Now())#,
					User_ID = #session.user_num#
					WHERE id = #arrIDs[i]#
					</cfquery>
				</cfif>
				
			</cfloop>
			
			<!--- Get the ID of record --->
			<cfquery name="getID" datasource="#request.sqlconn#">
			SELECT id FROM tblPackages WHERE package_no = #sw_pno# AND
			package_group = '#sw_pgroup#'
			</cfquery>
			
			<!--- Update Package Estimates and Cost --->
			<cfquery name="getIDs" datasource="#request.sqlconn#">
			SELECT location_no FROM tblSites WHERE package_no = #sw_pno# AND
			package_group = '#sw_pgroup#'
			</cfquery>
			
			<cfif chkExists.cnt is 0> <!--- Only do if new package --->
				<cfif getIDs.recordcount gt 0>
					<cfset str = "">
					<cfloop query="getIDs">
						<cfset str = str & location_no & ",">
					</cfloop>
					<cfset str = left(str,len(str)-1)>
					<cfset qstr = "SELECT sum(engineers_estimate_total_cost) as cost FROM tblEngineeringEstimate WHERE location_no IN (" & str & ")">
					<cfset cqstr = "SELECT sum(contractors_cost) as cost FROM tblContractorPricing WHERE location_no IN (" & str & ")">
					
					<cfquery name="getEstimate" datasource="#request.sqlconn#">
					#preservesinglequotes(qstr)#
					</cfquery>
					
					<cfset v = getEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
					<cfquery name="setEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					engineers_estimate = #v#
					WHERE package_no = #sw_pno# AND package_group = '#sw_pgroup#'
					</cfquery>
					
					<cfquery name="getCEstimate" datasource="#request.sqlconn#">
					#preservesinglequotes(cqstr)#
					</cfquery>
					
					<cfset v = getCEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
					<cfquery name="setCEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					awarded_bid = #v#
					WHERE package_no = #sw_pno# AND package_group = '#sw_pgroup#'
					</cfquery>
				<cfelse>
					<cfquery name="setEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					engineers_estimate = NULL
					WHERE package_no = #sw_pno# AND package_group = '#sw_pgroup#'
					</cfquery>
					
					<cfquery name="setCEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					awarded_bid = NULL
					WHERE package_no = #sw_pno# AND package_group = '#sw_pgroup#'
					</cfquery>
				</cfif>
			</cfif>
			
			<cfset data.id = getID.id>
			
			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Package Creation/Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	<cffunction name="getPackageSiteIDs" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_pgroup" required="true">
		
		<cfset var data = {}>
		<cfquery name="getIDs" datasource="#request.sqlconn#">
		SELECT package_no FROM tblPackages WHERE package_group = '#sw_pgroup#' <!--- AND removed is null ---> ORDER BY package_no
		</cfquery>
		<cfquery name="getID" datasource="#request.sqlconn#">
		SELECT max(package_no) as id FROM tblPackages WHERE package_group = '#sw_pgroup#'
		</cfquery>
		<cfif getID.id is ""><cfset swid = 1><cfelse><cfset swid = getID.id + 1></cfif>
		<cfset arrIDs = arrayNew(1)>
		<cfloop query="getIDs">
			<cfset doit = arrayAppend(arrIDs,package_no)>
		</cfloop>
		<cfset doit = arrayAppend(arrIDs,swid & "")>
		<cfset data.arrIDs = arrIDs>
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    <cfreturn data>
		
	</cffunction>
	
	
	<cffunction name="getPackageGroup" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_pno" required="true">
		
		<cfset var data = {}>
		<cfquery name="getGroup" datasource="#request.sqlconn#">
		SELECT package_group FROM tblPackages WHERE package_no = #sw_pno#
		</cfquery>
		
		<cfset data.group = ""><cfif getGroup.recordcount gt 0><cfset data.group = getGroup.package_group></cfif>
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    <cfreturn data>
		
	</cffunction>
	
	
	
	<cffunction name="updatePackage" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		<cfargument name="sw_wo" required="true">
		<cfargument name="sw_nfb" required="true">
		<cfargument name="sw_bid" required="true">
		<cfargument name="sw_co" required="true">
		<cfargument name="sw_precon" required="true">
		<cfargument name="sw_ntp" required="true">
        
        
        <cfargument name="sw_soc" required="true">
        
        
		<cfargument name="sw_est" required="true">
		<cfargument name="sw_award" required="true">
		<cfargument name="sw_cm" required="true">
		<cfargument name="sw_contractor" required="true">
		<cfargument name="sw_cname" required="true">
		<cfargument name="sw_caddress" required="true">
		<cfargument name="sw_cemail" required="true">
		<cfargument name="sw_cphone" required="true">
		<cfargument name="sw_performance" required="true">
		<cfargument name="sw_payment" required="true">
		<cfargument name="sw_notes" required="true">
		<cfargument name="sw_idList" required="true">
		<cfargument name="sw_remove" required="false" default="0">
		<cfargument name="sw_cno" required="true">
		<cfargument name="sw_fy" required="true">
		<cfargument name="sw_pstatus" required="true">
		<cfargument name="sw_eco1name" required="true">
		<cfargument name="sw_eco1phone" required="true">
		<cfargument name="sw_eco2name" required="true">
		<cfargument name="sw_eco2phone" required="true">
		<cfargument name="sw_ntea" required="true">
		<cfargument name="sw_swalk" required="true">
		<cfargument name="sw_tdn" required="true">
		<cfargument name="sw_cont" required="true">
		<cfargument name="sw_bad" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Package Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level is not 0 AND session.user_power is not 1>
			<cfif session.user_level lt 2>
				<cfset data.result = "- Package Update Failed: You are not authorized to make edits.">
				<cfset data = serializeJSON(data)>
			    <!--- wrap --->
			    <cfif structKeyExists(arguments, "callback")>
			        <cfset data = arguments.callback & "" & data & "">
			    </cfif>
			    <cfreturn data>
				<cfabort>
			</cfif>		
		</cfif>
		
		<cftry>
		
			<!--- Set to null when needed --->
			<cfif trim(sw_wo) is ""><cfset sw_wo = "NULL"></cfif>
			<cfif trim(sw_nfb) is ""><cfset sw_nfb = "NULL"></cfif>
			<cfif trim(sw_bid) is ""><cfset sw_bid = "NULL"></cfif>
			<cfif trim(sw_co) is ""><cfset sw_co = "NULL"></cfif>
			<cfif trim(sw_precon) is ""><cfset sw_precon = "NULL"></cfif>
			<cfif trim(sw_ntp) is ""><cfset sw_ntp = "NULL"></cfif>
            
            
            <cfif trim(sw_soc) is ""><cfset sw_soc = "NULL"></cfif>
            
			<cfif trim(sw_est) is ""><cfset sw_est = "NULL"></cfif>
			<cfif trim(sw_award) is ""><cfset sw_award = "NULL"></cfif>
			<cfif trim(sw_cm) is ""><cfset sw_cm = "NULL"></cfif>
			<cfif trim(sw_contractor) is ""><cfset sw_contractor = "NULL"></cfif>
			<cfif trim(sw_cname) is ""><cfset sw_cname = "NULL"></cfif>
			<cfif trim(sw_cemail) is ""><cfset sw_cemail = "NULL"></cfif>
			<cfif trim(sw_cphone) is ""><cfset sw_cphone = "NULL"></cfif>
			<cfif trim(sw_performance) is ""><cfset sw_performance = "NULL"></cfif>
			<cfif trim(sw_payment) is ""><cfset sw_payment = "NULL"></cfif>
			<cfif trim(sw_notes) is ""><cfset sw_notes = "NULL"></cfif>
			<cfif trim(sw_caddress) is ""><cfset sw_caddress = "NULL"></cfif>
			<cfif trim(sw_cno) is ""><cfset sw_cno = "NULL"></cfif>
			<cfif trim(sw_fy) is ""><cfset sw_fy = "NULL"></cfif>
			<cfif trim(sw_pstatus) is ""><cfset sw_pstatus = "NULL"></cfif>
			<cfif trim(sw_eco1name) is ""><cfset sw_eco1name = "NULL"></cfif>
			<cfif trim(sw_eco1phone) is ""><cfset sw_eco1phone = "NULL"></cfif>
			<cfif trim(sw_eco2name) is ""><cfset sw_eco2name = "NULL"></cfif>
			<cfif trim(sw_eco2phone) is ""><cfset sw_eco2phone = "NULL"></cfif>
			<cfif trim(sw_ntea) is ""><cfset sw_ntea = "NULL"></cfif>
			<cfif trim(sw_swalk) is ""><cfset sw_swalk = "NULL"></cfif>
			<cfif trim(sw_tdn) is ""><cfset sw_tdn = "NULL"></cfif>
			<cfif trim(sw_cont) is ""><cfset sw_cont = "NULL"></cfif>
			<cfif trim(sw_bad) is ""><cfset sw_bad = "NULL"></cfif>
			
			<cfset sw_wo = replace(sw_wo,"'","''","ALL")>
			<cfset sw_contractor = replace(sw_contractor,"'","''","ALL")>
			<cfset sw_cname = replace(sw_cname,"'","''","ALL")>
			<cfset sw_cemail = replace(sw_cemail,"'","''","ALL")>
			<cfset sw_cphone = replace(sw_cphone,"'","''","ALL")>
			<cfset sw_notes = replace(sw_notes,"'","''","ALL")>
			<cfset sw_est = replace(sw_est,",","","ALL")>
			<cfset sw_award = replace(sw_award,",","","ALL")>
			<cfset sw_caddress = replace(sw_caddress,"'","","ALL")>
			<cfset sw_cno = replace(sw_cno,"'","","ALL")>
			<cfset sw_eco1name = replace(sw_eco1name,"'","","ALL")>
			<cfset sw_eco1phone = replace(sw_eco1phone,"'","","ALL")>
			<cfset sw_eco2name = replace(sw_eco2name,"'","","ALL")>
			<cfset sw_eco2phone = replace(sw_eco2phone,"'","","ALL")>
			<cfset sw_ntea = replace(sw_ntea,",","","ALL")>
			<cfset sw_cont = replace(sw_cont,",","","ALL")>
			
			<cfif sw_nfb is not "NULL">
				<cfset arrDT = listtoarray(sw_nfb,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_nfb = createODBCDate(dt)>
			</cfif>
			<cfif sw_bid is not "NULL">
				<cfset arrDT = listtoarray(sw_bid,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_bid = createODBCDate(dt)>
			</cfif>
			<cfif sw_co is not "NULL">
				<cfset arrDT = listtoarray(sw_co,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_co = createODBCDate(dt)>
			</cfif>
			<cfif sw_precon is not "NULL">
				<cfset arrDT = listtoarray(sw_precon,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_precon = createODBCDate(dt)>
			</cfif>
			<cfif sw_ntp is not "NULL">
				<cfset arrDT = listtoarray(sw_ntp,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_ntp = createODBCDate(dt)>
			</cfif>
            
            
            
            
            <cfif sw_soc is not "NULL">
				<cfset arrDT = listtoarray(sw_soc,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_soc = createODBCDate(dt)>
			</cfif>
            
            
            
            
            
            
			<cfif sw_swalk is not "NULL">
				<cfset arrDT = listtoarray(sw_swalk,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_swalk = createODBCDate(dt)>
			</cfif>
			<cfif sw_tdn is not "NULL">
				<cfset arrDT = listtoarray(sw_tdn,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_tdn = createODBCDate(dt)>
			</cfif>
			<cfif sw_bad is not "NULL">
				<cfset arrDT = listtoarray(sw_bad,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sw_bad = createODBCDate(dt)>
			</cfif>

			
			<!--- Update Package Information. --->
			<cfquery name="updatePackage" datasource="#request.sqlconn#">
			UPDATE tblPackages SET
			engineers_estimate = #sw_est#,
			work_order = <cfif sw_wo is "NULL">#sw_wo#<cfelse>'#PreserveSingleQuotes(sw_wo)#'</cfif>,
			nfb_date = #sw_nfb#,
			bids_due_date = #sw_bid#,
			construct_order_date = #sw_co#,
			precon_meeting_date = #sw_precon#,
			notice_to_proceed_date = #sw_ntp#,
            
            statement_of_completion_date = #sw_soc#,
            
			Awarded_Bid = #sw_award#,
			Contingency = #sw_cont#,
			Contractor = <cfif sw_contractor is "NULL">#sw_contractor#<cfelse>'#PreserveSingleQuotes(sw_contractor)#'</cfif>,
			Contractor_name = <cfif sw_cname is "NULL">#sw_cname#<cfelse>'#PreserveSingleQuotes(sw_cname)#'</cfif>,
			Contractor_address = <cfif sw_caddress is "NULL">#sw_caddress#<cfelse>'#PreserveSingleQuotes(sw_caddress)#'</cfif>,
			Contractor_email = <cfif sw_cemail is "NULL">#sw_cemail#<cfelse>'#PreserveSingleQuotes(sw_cemail)#'</cfif>,
			Contractor_phone = <cfif sw_cphone is "NULL">#sw_cphone#<cfelse>'#PreserveSingleQuotes(sw_cphone)#'</cfif>,
			construction_manager = <cfif sw_cm is "NULL">#sw_cm#<cfelse>'#PreserveSingleQuotes(sw_cm)#'</cfif>,
			fiscal_year = <cfif sw_fy is "NULL">#sw_fy#<cfelse>'#PreserveSingleQuotes(sw_fy)#'</cfif>,
			contract_number = <cfif sw_cno is "NULL">#sw_cno#<cfelse>'#PreserveSingleQuotes(sw_cno)#'</cfif>,
			Emergency_contact_one_name = <cfif sw_eco1name is "NULL">#sw_eco1name#<cfelse>'#PreserveSingleQuotes(sw_eco1name)#'</cfif>,
			Emergency_contact_one_phone = <cfif sw_eco1phone is "NULL">#sw_eco1phone#<cfelse>'#PreserveSingleQuotes(sw_eco1phone)#'</cfif>,
			Emergency_contact_two_name = <cfif sw_eco2name is "NULL">#sw_eco2name#<cfelse>'#PreserveSingleQuotes(sw_eco2name)#'</cfif>,
			Emergency_contact_two_phone = <cfif sw_eco2phone is "NULL">#sw_eco2phone#<cfelse>'#PreserveSingleQuotes(sw_eco2phone)#'</cfif>,
			Not_To_Exceed_Amount = #sw_ntea#,
			Site_Walk_Date = #sw_swalk#,
			Ten_Day_Notice_Date = #sw_tdn#,
			Status = #sw_pstatus#,
			performance_bond = #sw_performance#,
			payment_bond = #sw_payment#,
			board_acceptance_date = #sw_bad#,
			notes = <cfif sw_notes is "NULL">#sw_notes#<cfelse>'#PreserveSingleQuotes(sw_notes)#'</cfif>,
			<cfif sw_remove is 1>removed = #sw_remove#,</cfif>
			modified_date = #CreateODBCDateTime(Now())#,
			User_ID = #session.user_num#
			WHERE id = #sw_id#
			</cfquery>
			
			<!--- Remove Sites --->
			<cfset data.removed = "false">
			<cfif sw_idList is not "">
				<cfset arrIDs = listtoarray(sw_idList,",")>
				<cfloop index="i" from="1" to="#arrayLen(arrIDs)#">
					
					<!--- Check if it already is in a package... --->
					<cfquery name="chkExists" datasource="#request.sqlconn#">
					SELECT count(*) as cnt FROM tblSites WHERE id = #arrIDs[i]#
					</cfquery>
					
					<cfif chkExists.cnt gt 0>
						<cfquery name="updateSite" datasource="#request.sqlconn#">
						UPDATE tblSites SET
						package_no = NULL,
						package_group = NULL,
						modified_date = #CreateODBCDateTime(Now())#,
						User_ID = #session.user_num#,
						Packaged_Date = NULL
						WHERE id = #arrIDs[i]#
						</cfquery>
						<cfset data.removed = "true">
					</cfif>
					
				</cfloop>
			</cfif>
			<cfif sw_remove is 1>
			
				<cfquery name="getPackage" datasource="#request.sqlconn#">
				SELECT package_no,package_group FROM tblPackages WHERE id = #sw_id#
				</cfquery>
				
				<cfquery name="updateSite" datasource="#request.sqlconn#">
				UPDATE tblSites SET
				package_no = NULL,
				package_group = NULL,
				modified_date = #CreateODBCDateTime(Now())#,
				User_ID = #session.user_num#
				WHERE package_no = #getPackage.package_no# AND package_group = '#getPackage.package_group#'
				</cfquery>
			
			</cfif>
			
			<!--- Update Package Estimates and Cost --->
			<!--- <cfquery name="getPackage" datasource="#request.sqlconn#">
			SELECT package_no as pno,package_group as pgp FROM tblPackages WHERE id = #sw_id#
			</cfquery>
			
			<cfquery name="getIDs" datasource="#request.sqlconn#">
			SELECT location_no FROM tblSites WHERE package_no = #getPackage.pno# AND
			package_group = '#getPackage.pgp#'
			</cfquery>
			
			<cfif getIDs.recordcount gt 0>
				<cfset str = "">
				<cfloop query="getIDs">
					<cfset str = str & location_no & ",">
				</cfloop>
				<cfset str = left(str,len(str)-1)>
				<cfset qstr = "SELECT sum(engineers_estimate_total_cost) as cost FROM tblEngineeringEstimate WHERE location_no IN (" & str & ")">
				<cfset cqstr = "SELECT sum(contractors_cost) as cost FROM tblContractorPricing WHERE location_no IN (" & str & ")">
				
				<cfquery name="getEstimate" datasource="#request.sqlconn#">
				#preservesinglequotes(qstr)#
				</cfquery>
				
				<cfset v = getEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
				<cfquery name="setEstimate" datasource="#request.sqlconn#">
				UPDATE tblPackages SET
				engineers_estimate = #v#
				WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
				</cfquery>
				
				<cfquery name="getCEstimate" datasource="#request.sqlconn#">
				#preservesinglequotes(cqstr)#
				</cfquery>
				
				<cfset v = getCEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
				<cfquery name="setCEstimate" datasource="#request.sqlconn#">
				UPDATE tblPackages SET
				awarded_bid = #v#
				WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
				</cfquery>
			<cfelse>
				<cfquery name="setEstimate" datasource="#request.sqlconn#">
				UPDATE tblPackages SET
				engineers_estimate = NULL
				WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
				</cfquery>
				
				<cfquery name="setCEstimate" datasource="#request.sqlconn#">
				UPDATE tblPackages SET
				awarded_bid = NULL
				WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
				</cfquery>
			</cfif> --->
			
			<cfset data.id = sw_id>
			
			<cfset data.remove = sw_remove>
			
			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Package Creation/Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	
	<cffunction name="updateSite" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		<cfargument name="sw_name" required="true">
		<cfargument name="sw_address" required="true">
		<cfargument name="sw_type" required="true">
		<cfargument name="sw_cd" required="true">
		<cfargument name="sw_assessed" required="true">
		<cfargument name="sw_assessor" required="true">
		<cfargument name="sw_assdate" required="true">
		<cfargument name="sw_repairs" required="true">
		<cfargument name="sw_severity" required="true">
		<!--- <cfargument name="sw_qc" required="true"> --->
		<cfargument name="sw_qcdate" required="true">
		<!--- <cfargument name="sw_tcon" required="true"> --->
		<cfargument name="sw_con_start" required="true">
		<cfargument name="sw_con_comp" required="true">
		<cfargument name="sw_antdate" required="true">
		<cfargument name="sw_notes" required="true">
		<cfargument name="sw_loc" required="true">
		<cfargument name="sw_damage" required="true">
		<cfargument name="sw_cityowned" required="true">
		<cfargument name="sw_priority_t1" required="true">
		<cfargument name="sw_priority_t2" required="true">
		<cfargument name="sw_logdate" required="true">
		<cfargument name="sw_zip" required="true">
		<!--- <cfargument name="sw_tree_desc" required="true">
		<cfargument name="sw_tree_rmv" required="true"> --->
		<!--- <cfargument name="sw_no_trees" required="true">
		<cfargument name="sw_tree_rm_date" required="true">
		<cfargument name="sw_tree_notes" required="true"> --->
		<cfargument name="sw_curbramp" required="true">
		<cfargument name="sw_designreq" required="true">
		<cfargument name="sw_dsgnstart" required="true">
		<cfargument name="sw_dsgnfinish" required="true">
		<!--- <cfargument name="sw_ait_type" required="true">
		<cfargument name="sw_costeffect" required="true">
		<cfargument name="sw_injury" required="true">
		<cfargument name="sw_disabled" required="true">
		<cfargument name="sw_complaints" required="true">
		<cfargument name="sw_pedestrian" required="true"> --->	
		<cfargument name="sw_phase" required="true">
		<cfargument name="sw_bic" required="true">	
        
        <cfargument name="sw_specialfund" required="true">	
        
		<cfargument name="sw_class" required="true">	
		<cfargument name="sw_excptn" required="true">	
		<cfargument name="sw_excptn_notes" required="true">
        
        
        <!--- joe hu ------- 9/19/2018 --------- add scheduled check box -----------  --->
        <cfargument name="sw_scheduled" required="true">
        
        
        
        <!--- joe hu ------- 9/19/2018 --------- add scheduled check box -----------  --->
        
        
        
        
        <!--- joe hu 2019-4 multi change --->
        <cfargument name="sw_grievance" required="true">
        <!--- end ---- joe hu 2019-4 multi change --->
        
        
        
        
		
		<cfargument name="do_priority" required="false" default="0">		

		<cfset tbl = "tblSites">
		<cfset tbl2 = "tblTreeRemovalInfo">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif trim(sw_type) is ""><cfset sw_type = "NULL"></cfif>
		<cfif trim(sw_cd) is ""><cfset sw_cd = "NULL"></cfif>
		<cfif trim(sw_assessed) is ""><cfset sw_assessed = "NULL"></cfif>
		<cfif trim(sw_assessor) is ""><cfset sw_assessor = "NULL"></cfif>
		<cfif trim(sw_assdate) is ""><cfset sw_assdate = "NULL"></cfif>
		<cfif trim(sw_repairs) is ""><cfset sw_repairs = "NULL"></cfif>
		<cfif trim(sw_severity) is ""><cfset sw_severity = "NULL"></cfif>
		<!--- <cfif trim(sw_qc) is ""><cfset sw_qc = "NULL"></cfif> --->
		<cfif trim(sw_qcdate) is ""><cfset sw_qcdate = "NULL"></cfif>
		<!--- <cfif trim(sw_tcon) is ""><cfset sw_tcon = "NULL"></cfif> --->
		<cfif trim(sw_con_start) is ""><cfset sw_con_start = "NULL"></cfif>
		<cfif trim(sw_con_comp) is ""><cfset sw_con_comp = "NULL"></cfif>
		<cfif trim(sw_antdate) is ""><cfset sw_antdate = "NULL"></cfif>
		<cfif trim(sw_notes) is ""><cfset sw_notes = "NULL"></cfif>
		<cfif trim(sw_loc) is ""><cfset sw_loc = "NULL"></cfif>
		<cfif trim(sw_damage) is ""><cfset sw_damage = "NULL"></cfif>
		<cfif trim(sw_cityowned) is ""><cfset sw_cityowned = "NULL"></cfif>
		<!--- <cfif trim(sw_priority) is ""><cfset sw_priority = "NULL"></cfif> --->
		<cfif trim(sw_logdate) is ""><cfset sw_logdate = "NULL"></cfif>
		<cfif trim(sw_zip) is ""><cfset sw_zip = "NULL"></cfif>
		<!--- <cfif trim(sw_tree_rmv) is ""><cfset sw_tree_rmv = "NULL"></cfif>
		<cfif trim(sw_tree_desc) is ""><cfset sw_tree_desc = "NULL"></cfif> --->
		<!--- <cfif trim(sw_no_trees) is ""><cfset sw_no_trees = "NULL"></cfif>
		<cfif trim(sw_tree_rm_date) is ""><cfset sw_tree_rm_date = "NULL"></cfif>
		<cfif trim(sw_tree_notes) is ""><cfset sw_tree_notes = "NULL"></cfif> --->
		<cfif trim(sw_curbramp) is ""><cfset sw_curbramp = "NULL"></cfif>
		<cfif trim(sw_designreq) is ""><cfset sw_designreq = "NULL"></cfif>
		<cfif trim(sw_dsgnstart) is ""><cfset sw_dsgnstart = "NULL"></cfif>
		<cfif trim(sw_dsgnfinish) is ""><cfset sw_dsgnfinish = "NULL"></cfif>
		<!--- <cfif trim(sw_ait_type) is ""><cfset sw_ait_type = "NULL"></cfif>
		<cfif trim(sw_costeffect) is ""><cfset sw_costeffect = "NULL"></cfif>
		<cfif trim(sw_injury) is ""><cfset sw_injury = "NULL"></cfif>
		<cfif trim(sw_disabled) is ""><cfset sw_disabled = "NULL"></cfif>
		<cfif trim(sw_complaints) is ""><cfset sw_complaints = "NULL"></cfif>
		<cfif trim(sw_pedestrian) is ""><cfset sw_pedestrian = "NULL"></cfif> --->	
		<cfif trim(sw_excptn) is ""><cfset sw_excptn = "NULL"></cfif>
		<cfif trim(sw_excptn_notes) is ""><cfset sw_excptn_notes = "NULL"></cfif>	
		<cfif trim(sw_phase) is ""><cfset sw_phase = "NULL"></cfif>
		<cfif trim(sw_bic) is ""><cfset sw_bic = "NULL"></cfif>	
        
        <cfif trim(sw_specialfund) is ""><cfset sw_specialfund = "NULL"></cfif>	
        
        
		<cfif trim(sw_class) is ""><cfset sw_class = "NULL"></cfif>	
        
        
       
        <!--- joe hu ------- 9/19/2018 --------- add scheduled check box -----------  --->
        
         <cfif trim(sw_scheduled) is "">
		        <cfset sw_scheduled = "NULL">
         <cfelse>
         
                <cfset sw_scheduled = 1 >
         
                
         </cfif>
         
         
         <!--- joe hu 2019-4 multi change --->
				  <cfif trim(sw_grievance) is "">
                        <cfset sw_grievance = "NULL">
                 <cfelse>
                 
                        <cfset sw_grievance = 1 >
                 
                        
                 </cfif>
         <!--- end ---- joe hu 2019-4 multi change --->
         
         
        <!--- joe hu ------- 9/19/2018 --------- add scheduled check box -----------  --->
        
		
		<cfif sw_assdate is not "NULL">
			<cfset arrDT = listtoarray(sw_assdate,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_assdate = createODBCDate(dt)>
		</cfif>
		
		<cfif sw_qcdate is not "NULL">
			<cfset arrDT = listtoarray(sw_qcdate,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_qcdate = createODBCDate(dt)>
		</cfif>
		
		<cfif sw_antdate is not "NULL">
			<cfset arrDT = listtoarray(sw_antdate,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_antdate = createODBCDate(dt)>
		</cfif>
		
		<cfif sw_logdate is not "NULL">
			<cfset arrDT = listtoarray(sw_logdate,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_logdate = createODBCDate(dt)>
		</cfif>
		
		<cfif sw_con_start is not "NULL">
			<cfset arrDT = listtoarray(sw_con_start,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_con_start = createODBCDate(dt)>
		</cfif>
		
		<cfif sw_con_comp is not "NULL">
			<cfset arrDT = listtoarray(sw_con_comp,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_con_comp = createODBCDate(dt)>
		</cfif>
		
		<!--- <cfif sw_tree_rm_date is not "NULL">
			<cfset arrDT = listtoarray(sw_tree_rm_date,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_tree_rm_date = createODBCDate(dt)>
		</cfif> --->
		
		<cfif sw_dsgnstart is not "NULL">
			<cfset arrDT = listtoarray(sw_dsgnstart,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_dsgnstart = createODBCDate(dt)>
		</cfif>
		
		<cfif sw_dsgnfinish is not "NULL">
			<cfset arrDT = listtoarray(sw_dsgnfinish,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset sw_dsgnfinish = createODBCDate(dt)>
		</cfif>
		
		<cfset sw_name = replace(sw_name,"'","''","ALL")>
		<cfset sw_address = replace(sw_address,"'","''","ALL")>
		<cfset sw_assessor = replace(sw_assessor,"'","''","ALL")>
		<!--- <cfset sw_qc = replace(sw_qc,"'","''","ALL")> --->
		<cfset sw_notes = replace(sw_notes,"'","''","ALL")>
		<cfset sw_loc = replace(sw_loc,"'","''","ALL")>
		<cfset sw_damage = replace(sw_damage,"'","''","ALL")>
		<!--- <cfset sw_tcon = replace(sw_tcon,",","","ALL")> --->
		<cfset sw_tree_notes = replace(sw_tree_notes,"'","''","ALL")>
		<cfset sw_excptn_notes = replace(sw_excptn_notes,"'","''","ALL")>
		
		<!--- s: get the original phase (for potentially sending a sr ticket update --->
		<cfquery name="getPhase" datasource="#request.sqlconn#">		
		SELECT phase,location_no,sr_number FROM #tbl# WHERE id = #sw_id#
		</cfquery>
		<cfset phase = getPhase.phase>
		<cfset locno = getPhase.location_no>
		<cfset sr_num = getPhase.sr_number>
		<!--- e: get the original phase (for potentially sending a sr ticket update --->
		
		<cfquery name="addFeature" datasource="#request.sqlconn#">		
		UPDATE #tbl# SET
		Name = '#PreserveSingleQuotes(sw_name)#',
		Address = '#PreserveSingleQuotes(sw_address)#',
		Type = #sw_type#,
		Council_District = #sw_cd#,
		Field_Assessed = #sw_assessed#,
		Field_Assessor = <cfif sw_assessor is "NULL">#sw_assessor#<cfelse>'#PreserveSingleQuotes(sw_assessor)#'</cfif>,
		Repairs_Required = #sw_repairs#,
		Severity_Index = #sw_severity#,
		Assessed_Date = #sw_assdate#,
		<!--- QC = <cfif sw_qc is "NULL">#sw_qc#<cfelse>'#PreserveSingleQuotes(sw_qc)#'</cfif>, --->
		QC_Date = #sw_qcdate#,
		<!--- Total_Concrete = #sw_tcon#, --->
		Construction_Start_Date = #sw_con_start#,
		Construction_Completed_Date = #sw_con_comp#,
		Anticipated_Completion_Date = #sw_antdate#,
		Notes = <cfif sw_notes is "NULL">#sw_notes#<cfelse>'#PreserveSingleQuotes(sw_notes)#'</cfif>,
		Location_Description = <cfif sw_loc is "NULL">#sw_loc#<cfelse>'#PreserveSingleQuotes(sw_loc)#'</cfif>,
		Damage_Description = <cfif sw_damage is "NULL">#sw_damage#<cfelse>'#PreserveSingleQuotes(sw_damage)#'</cfif>,
		<!--- Tree_Removed = #sw_tree_rmv#,
		Tree_Removal_Description = <cfif sw_tree_desc is "NULL">#sw_tree_desc#<cfelse>'#PreserveSingleQuotes(sw_tree_desc)#'</cfif>, --->
		ADA_Exception = #sw_excptn#,
		ADA_Exception_Notes = <cfif sw_excptn_notes is "NULL">#sw_excptn_notes#<cfelse>'#PreserveSingleQuotes(sw_excptn_notes)#'</cfif>,
		City_Owned_Property = #sw_cityowned#,
		<!--- Priority_No = #sw_priority#, --->
		Date_Logged = #sw_logdate#,
		Zip_Code = #sw_zip#,
		Curb_Ramp_Only = #sw_curbramp#,
		Design_Required = #sw_designreq#,
		Design_Start_Date = #sw_dsgnstart#,
		Design_Finish_Date = #sw_dsgnfinish#,
		Phase = #sw_phase#,
		StatusBIC = #sw_bic#,
        
        
        SpecialFund = #sw_specialfund#,
        
		Classification = #sw_class#,
		<!--- Access_Improvement = #sw_ait_type#,
		Cost_Effective = #sw_costeffect#,
		Within_High_Injury = #sw_injury#,
		Traveled_By_Disabled = #sw_disabled#,
		Complaints_No = #sw_complaints#,
		High_Pedestrian_Traffic = #sw_pedestrian#, --->
		modified_date = #CreateODBCDateTime(Now())#,
        
        
        
        <!--- joe hu ------- 9/19/2018 --------- add scheduled check box -----------  --->
        Scheduled = #sw_scheduled#,
        
        
       
        
        <!---  end ----- joe hu ------- 9/19/2018 --------- add scheduled check box -----------  --->
    
        
        
        	<!--- joe hu 2019-4 multi change --->

             Grievance = #sw_grievance#,
            
             <!--- end ---- joe hu 2019-4 multi change --->
        
        
        
        
		User_ID = #session.user_num#
		WHERE id = #sw_id#
		</cfquery>


		<!--- <cfquery name="chkTrees" datasource="#request.sqlconn#">		
		SELECT id FROM #tbl2# WHERE location_no = #getLocNo.location_no#
		</cfquery>

		<cfif chkTrees.recordcount gt 0>
			<cfquery name="addFeature" datasource="#request.sqlconn#">		
			UPDATE #tbl2# SET
			no_trees_to_remove_per_arborist = #sw_no_trees#,
			tree_removal_notes = <cfif sw_tree_notes is "NULL">#sw_tree_notes#<cfelse>'#PreserveSingleQuotes(sw_tree_notes)#'</cfif>,
			trees_removed_date = #sw_tree_rm_date#
			<!--- modified_date = #CreateODBCDateTime(Now())#, --->
			<!--- User_ID = #session.user_num# --->
			WHERE location_no = #getLocNo.location_no#
			</cfquery>
		<cfelse>
			<cfquery name="addFeature" datasource="#request.sqlconn#">		
			INSERT INTO dbo.#tbl2#
			( 
				Location_No,
			    <cfif trim(sw_tree_rm_date) is not "NULL">trees_removed_date,</cfif>
				<cfif trim(sw_tree_notes) is not "NULL">tree_removal_notes,</cfif>
			    <cfif trim(sw_no_trees) is not "NULL">no_trees_to_remove_per_arborist,</cfif>
				User_ID,
				Creation_Date
			) 
			Values 
			(
				#getLocNo.location_no#,
			    <cfif trim(sw_tree_rm_date) is not "NULL">#sw_tree_rm_date#,</cfif>
				<cfif trim(sw_tree_notes) is not "NULL">'#PreserveSingleQuotes(sw_tree_notes)#',</cfif>
			    <cfif trim(sw_no_trees) is not "NULL">#sw_no_trees#,</cfif>
				#session.user_num#,
				#CreateODBCDateTime(Now())#
			)
			</cfquery>
		
		</cfif> --->
		
		<cfquery name="getLocNo" datasource="#request.sqlconn#">		
		SELECT location_no FROM #tbl# WHERE id = #sw_id#
		</cfquery>
		
		<!--- s: Send a sr ticket update if phase changed --->
		<cfif phase is not sw_phase AND sw_phase lt 5 AND sr_num is not "">
			<cfset ticket = updateSRTicket(sw_phase,locno,sr_num)>
			<cfset data.ticket = ticket>
		</cfif>
		<!--- e: Send a sr ticket update if phase changed --->
		
		<cfif do_priority is 1> <!--- This was set in the javascript to updat the Tier 2 priority --->
			<cfset data.priority = updatePriority(getLocNo.location_no,tbl)>
		</cfif>
		
		<cfset data.result = "Success">
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
		
		
	    
	    <cfreturn data>
		
	</cffunction>
	
	<cffunction name="updatePriority" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="loc_no" type="numeric" required="no" default="0"> 
		<cfargument name="tbl" type="string" required="yes"> 
		
		<cfset vw = "vwPriorityTier2">
		<cfset rv = ''>
		
		<cfquery name="getPriority" datasource="#request.sqlconn#">		
		SELECT score FROM #vw# WHERE location_no = #loc_no#
		</cfquery>
		
		<cfif getPriority.recordcount gt 0>
		
			<cfquery name="chkTypeStatus" datasource="#request.sqlconn#">		
			SELECT * FROM #tbl# WHERE location_no = #loc_no# AND sr_number is NULL AND construction_completed_date is NULL
			</cfquery>
			
			<cfset sc = "NULL">
			<cfif chkTypeStatus.recordcount gt 0><cfset sc = getPriority.score><cfset rv = sc></cfif>
			
			<cfquery name="setPriority" datasource="#request.sqlconn#">		
			UPDATE #tbl# SET priority_tier2 = #sc# WHERE location_no = #loc_no#
			</cfquery>
			
		</cfif>
		
		<cfreturn rv>  
	
	</cffunction>
	
	<!--- s: retired priority sytem --->
	<cffunction name="updatePriorityOLD" access="remote" returnType="any" returnFormat="plain" output="false"> 
		<cfargument name="loc_no" type="numeric" required="no" default="0">  
		<cfargument name="tbl" type="string" required="yes">  
		
		<cfset vw = "vwPriority">
		<cfset rv = 0>
		
		<cfquery name="getPriorities" datasource="#request.sqlconn#">		
		SELECT * FROM #vw# ORDER BY points DESC
		</cfquery>
		
		<cfset prty_no = 1><cfset pts = getPriorities.points><cfset cnt = 0>
		<cfloop query="getPriorities">
			<cfset cnt = cnt + 1>
			<cfif pts is not points>
				<cfset prty_no = cnt>
				<cfset pts = points>
			</cfif>
		
			<cfquery name="updatePriorities" datasource="#request.sqlconn#">		
			UPDATE #tbl# SET priority_no = #prty_no# where location_no = #location_no#
			</cfquery>
			
			<cfif loc_no is location_no><cfset rv = prty_no></cfif>
			
		</cfloop>
		
		<cfquery name="getNonPriorities" datasource="#request.sqlconn#">		
		SELECT location_no FROM dbo.#tbl# 
		WHERE (location_no NOT IN (SELECT location_no FROM dbo.#vw#))
		</cfquery>
		
		<cfloop query="getNonPriorities">
			<cfquery name="updatePriorities" datasource="#request.sqlconn#">		
			UPDATE #tbl# SET priority_no = NULL where location_no = #location_no#
			</cfquery>
		</cfloop>
		
		<cfreturn rv>  
		
	</cffunction>
	<!--- e: retired priority sytem --->
	
	
	
	
	<cffunction name="searchPackages" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="ps_no" required="true">
		<cfargument name="ps_group" required="true">
		<cfargument name="ps_wo" required="true">
		<cfargument name="ps_con" required="true">
		<cfargument name="ps_name" required="true">
		<cfargument name="ps_fy" required="true">
		<cfargument name="ps_order" required="false" default="package_group DESC,package_no">
		
		<cfset var data = {}>
		
		<cfset ps_where = "">
		<cfif trim(ps_name) is not "">
			<cfquery name="getSites" datasource="#request.sqlconn#">
            
            <!--- joe hu ------ 2/26/2018     -----------  requestID 107 ---- 2) ----------  ---> 

				<!--- SELECT DISTINCT package_no,package_group FROM tblSites WHERE name LIKE '%#ps_name#%' AND package_no is not null --->
            
				SELECT DISTINCT package_no,package_group FROM tblSites WHERE  package_no is not null
				
				<cfset target_string = '' >
				<cfset quoted_string_array = []>
				
				<cfif trim(ps_name) is not "">
				
					<cfset target_string = ps_name >
					
					<cfset regular_expression_double_quote = '"([^"]*)"'  />
					<cfset regular_expression_single_quote = "'([^']*)'"  />
					
					<cfset quoted_string_array_double_quote = REMatch(regular_expression_double_quote, target_string) >
					<cfset quoted_string_array_single_quote = REMatch(regular_expression_single_quote, target_string) >
					
					<cfset ArrayAppend(quoted_string_array, quoted_string_array_double_quote, true) >
					<cfset ArrayAppend(quoted_string_array, quoted_string_array_single_quote, true) >
					
					<cfloop array="#quoted_string_array#" index="quoted_string_item">
						<cfset quoted_string_item_fake = replace(quoted_string_item, " ","~","all") >
						<cfset target_string = replace(target_string, quoted_string_item, quoted_string_item_fake, "all") >	
					</cfloop>

					<cfset target_string_array = ListToArray(target_string, " " ) />
					
					<cfloop array="#target_string_array#" index="item">
						<cfset first_char=Left(item,1) />
						
						<cfif first_char is "-">
						
							<cfset item = RemoveChars(item, 1, 1) />
							
							<!--- remove all single quote, double quote ,  replace ~ with space --->
							<cfset item = trim(replace(item,'"','',"ALL"))>
							<cfset item = trim(replace(item,"'",'',"ALL"))>
							<cfset item = trim(replace(item,"~",' ',"ALL"))>
							AND name Not LIKE '%#preservesinglequotes(item)#%'
							
						<cfelse>

							<!--- remove all single quote, double quote ,  replace ~ with space --->
							<cfset item = trim(replace(item,'"','',"ALL"))>
							<cfset item = trim(replace(item,"'",'',"ALL"))>
							<cfset item = trim(replace(item,"~",' ',"ALL"))>
							AND name LIKE '%#preservesinglequotes(item)#%'
						
						</cfif>
					</cfloop>
				</cfif> 

            <!---  --------- END ------------ joe hu ------ 2/26/2018     -----------  requestID 107 ---- 2) ----------  ---> 
            
			</cfquery>
			<cfif getSites.recordcount gt 0>
				<cfset ps_where = "AND (">
				<cfloop query="getSites">
					<cfset ps_where = ps_where & "(package_no = " & package_no & " AND package_group = '" & package_group & "') OR ">
				</cfloop>
				<cfset ps_where = trim(ps_where)>
				<cfset ps_where = left(ps_where,len(ps_where)-3) & ")">
				<cfset data.ps_where = ps_where>
			</cfif>
		</cfif>
        
		<cfquery name="getPackages" datasource="#request.sqlconn#">
		SELECT * FROM tblPackages WHERE removed is null
		<cfif ps_group is not "">AND package_group = '#ps_group#'</cfif> 
		<cfif ps_no is not "">AND package_no = #ps_no#</cfif> 
		<cfif trim(ps_wo) is not "">AND work_order LIKE '%#trim(ps_wo)#%'</cfif> 

        <!--- joe hu ------ 2/22/2018     -----------  requestID 107 ---- 2) ----------  ---> 
        
			<!--- ---- original ------   
			<cfif trim(ps_con) is not "">AND contractor LIKE '%#trim(ps_con)#%'</cfif> 
			--->
			<!---  =========== contractor  ================    ---> 

			<cfset target_string = '' >
			<cfset quoted_string_array = []>
			
			<cfif trim(ps_con) is not "">
				<cfset target_string = ps_con >
				
				<!---    https://stackoverflow.com/questions/12947242/coldfusion-how-to-extract-a-substring-using-regex    --->
				<cfset regular_expression_double_quote = '"([^"]*)"'  />
				<cfset regular_expression_single_quote = "'([^']*)'"  />
				
				<cfset quoted_string_array_double_quote = REMatch(regular_expression_double_quote, target_string) >
				<cfset quoted_string_array_single_quote = REMatch(regular_expression_single_quote, target_string) >
				
				<cfset ArrayAppend(quoted_string_array, quoted_string_array_double_quote, true) >
				<cfset ArrayAppend(quoted_string_array, quoted_string_array_single_quote, true) >
				
				<cfloop array="#quoted_string_array#" index="quoted_string_item">
					<cfset quoted_string_item_fake = replace(quoted_string_item, " ","~","all") >
					<cfset target_string = replace(target_string, quoted_string_item, quoted_string_item_fake, "all") >
				</cfloop>
				
				<cfset target_string_array = ListToArray(target_string, " " ) />
				
				<cfloop array="#target_string_array#" index="item">
					<cfset first_char=Left(item,1) />
					
					<cfif first_char is "-">
					
						<cfset item = RemoveChars(item, 1, 1) />
						
						<!--- remove all single quote, double quote ,  replace ~ with space --->
						<cfset item = trim(replace(item,'"','',"ALL"))>
						<cfset item = trim(replace(item,"'",'',"ALL"))>
						<cfset item = trim(replace(item,"~",' ',"ALL"))>
						AND contractor Not LIKE '%#preservesinglequotes(item)#%'
	
					<cfelse>
	
						<!--- remove all single quote, double quote ,  replace ~ with space --->
						<cfset item = trim(replace(item,'"','',"ALL"))>
						<cfset item = trim(replace(item,"'",'',"ALL"))>
						<cfset item = trim(replace(item,"~",' ',"ALL"))>
						AND contractor LIKE '%#preservesinglequotes(item)#%'
						
					</cfif>
				</cfloop>
			</cfif> 

        <!--- ------ End ------------ joe hu ------ 2/22/2018     -----------  requestID 107 ---- 2) ----------  --->   
        
		<cfif trim(ps_fy) is not "">AND fiscal_year = '#trim(ps_fy)#'</cfif> 
		#preservesinglequotes(ps_where)#
		ORDER BY #ps_order#
		</cfquery>
	
		<cfset data.query = serializeJSON(getPackages)>
	
		<cfset data.result = "Success" >
        
        <!--- debug  --->
        <!--- <cfset data.target_string = target_string >
		<cfset data.quoted_string_array = quoted_string_array > --->

		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
        
	    <cfreturn data >
		
	</cffunction>
	
	
	<cffunction name="searchSites" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="ss_no" required="true">
		<!--- <cfargument name="ss_sfx" required="true"> --->
		<cfargument name="ss_pgroup" required="true">
		<cfargument name="ss_pno" required="true">
		<cfargument name="ss_category" required="true">
		<cfargument name="ss_type" required="true">
		<cfargument name="ss_name" required="true">
		<cfargument name="ss_address" required="true">
		<cfargument name="ss_wo" required="true">
		<cfargument name="ss_assessed" required="true">
		<!--- <cfargument name="ss_assessor" required="true"> --->
		<cfargument name="ss_assfrm" required="true">
		<cfargument name="ss_assto" required="true">
		<cfargument name="ss_qcfrm" required="true">
		<cfargument name="ss_qcto" required="true">
		<cfargument name="ss_consfrm" required="true">
		<cfargument name="ss_consto" required="true">
		<cfargument name="ss_concfrm" required="true">
		<cfargument name="ss_concto" required="true">
		<cfargument name="ss_repairs" required="true">
	<!---	<cfargument name="ss_severity" required="true">  --->
    
    
    
    
     <!--- joe hu 2019-4 multi change --->
    		<cfargument name="ss_grievance" required="true">
    		<cfargument name="ss_locked" required="true">
            <cfargument name="ss_specialfund" required="true">
            
           
            
     <!--- end ---- joe hu 2019-4 multi change --->
     
     
     
     
     
     
     
     
     <!---  ---- joe hu 8-2-2019 search bar change --->
    
   
         <cfargument name="ss_action" required="false">
     
     
         
           
      
     
     <!---        ---- end ---- joe hu 8-2-2019 search bar change --->
     
     
     
     
     
     
     
     
     
    
		<!--- <cfargument name="ss_qc" required="true"> --->
		<cfargument name="ss_cd" required="true">
		<cfargument name="ss_removed" required="true">
		<cfargument name="ss_zip" required="true">
		<cfargument name="ss_curbramp" required="true">
		<!--- <cfargument name="ss_pn" required="true"> --->
		<cfargument name="ss_keyword" required="true">
        
	<!---	<cfargument name="ss_hasA" required="true">    --->
	<!---	<cfargument name="ss_hasB" required="true">    --->
    
		<cfargument name="ss_hascert" required="true">
		<cfargument name="ss_assnull" required="false">
		<cfargument name="ss_qcnull" required="false">
		<cfargument name="ss_consnull" required="false">
		<cfargument name="ss_concnull" required="false">
		<cfargument name="ss_order" required="false" default="location_no,location_suffix">
		
		<cfif isdefined("ss_assnull")><cfset session.ss_assnull = 1><cfelse><cfset StructDelete(Session, "ss_assnull")></cfif>
		<cfif isdefined("ss_qcnull")><cfset session.ss_qcnull = 1><cfelse><cfset StructDelete(Session, "ss_qcnull")></cfif>
		<cfif isdefined("ss_consnull")><cfset session.ss_consnull = 1><cfelse><cfset StructDelete(Session, "ss_consnull")></cfif>
		<cfif isdefined("ss_concnull")><cfset session.ss_concnull = 1><cfelse><cfset StructDelete(Session, "ss_concnull")></cfif>
		


 <!---  ---- joe hu 8-2-2019 search bar change --->
 
        <cfif ss_action is not "">
 
						<cfif ss_action eq 0>
                             <cfset tree_action_type = "Has_Removed_Trees" >
                         <cfelseif ss_action eq 1>    
                              <cfset tree_action_type = "Has_Planted_Trees" >
                         <cfelseif ss_action eq 2>  
                               <cfset tree_action_type = "Has_Preserved_Trees" >
                               
                          </cfif>     
               
         </cfif>
 <!---        ---- end ---- joe hu 8-2-2019 search bar change --->


		<cfset var data = {}>
		
		<cfset ss_name = trim(replace(ss_name,"'","''","ALL"))>
		<cfset ss_address = trim(replace(ss_address,"'","''","ALL"))>
		<cfset ss_wo = trim(ss_wo)>
		<cfset ss_zip = trim(ss_zip)>
		<cfset ss_keyword = trim(replace(ss_keyword,"'","''","ALL"))>
		
        <!---  joe 2/14/2018 ---- remove  
		<cfset nt = "">
		<cfif left(ss_keyword,1) is "-">
			<cfset nt = "NOT">
			<cfset ss_keyword = right(ss_keyword,len(ss_keyword)-1)>
		</cfif>
		--->
		
		<!--- <cfset ss_assessor = trim(ss_assessor)> --->
		<!--- <cfset ss_qc = trim(ss_qc)> --->
		
		<cfset ss_assessor = "">
		<cfset ss_qc = "">
		
		<cfif ss_assfrm is not "">
			<cfset arrDT = listtoarray(ss_assfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_assfrm = createODBCDate(dt)>
		</cfif>
		<cfif ss_assto is not "">
			<cfset arrDT = listtoarray(ss_assto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_assto = createODBCDate(dt)>
		</cfif>
		<cfif ss_qcfrm is not "">
			<cfset arrDT = listtoarray(ss_qcfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_qcfrm = createODBCDate(dt)>
		</cfif>
		<cfif ss_qcto is not "">
			<cfset arrDT = listtoarray(ss_qcto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_qcto = createODBCDate(dt)>
		</cfif>
		
		<cfset ss_constart = "">
		<cfset ss_concomplete = "">
		
		<cfif ss_consfrm is not "">
			<cfset arrDT = listtoarray(ss_consfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_consfrm = createODBCDate(dt)>
		</cfif>
		<cfif ss_consto is not "">
			<cfset arrDT = listtoarray(ss_consto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_consto = createODBCDate(dt)>
		</cfif>
		<cfif ss_concfrm is not "">
			<cfset arrDT = listtoarray(ss_concfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_concfrm = createODBCDate(dt)>
		</cfif>
		<cfif ss_concto is not "">
			<cfset arrDT = listtoarray(ss_concto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset ss_concto = createODBCDate(dt)>
		</cfif>

		<cfif trim(ss_assfrm) is not "" AND trim(ss_assto) is ""><cfset ss_assessor = ss_assfrm></cfif>
		<cfif trim(ss_assto) is not "" AND trim(ss_assfrm) is ""><cfset ss_assessor = ss_assto></cfif>
		<cfset assbtwn = "">
		<cfif trim(ss_assfrm) is not "" AND trim(ss_assto) is not "">
			<cfset assbtwn = "AND (assessed_date >= " & ss_assfrm & " AND assessed_date <= " & ss_assto & ")"> 
		</cfif>
		
		<cfif trim(ss_qcfrm) is not "" AND trim(ss_qcto) is ""><cfset ss_qc = ss_qcfrm></cfif>
		<cfif trim(ss_qcto) is not "" AND trim(ss_qcfrm) is ""><cfset ss_qc = ss_qcto></cfif>
		<cfset qcbtwn = "">
		<cfif trim(ss_qcfrm) is not "" AND trim(ss_qcto) is not "">
			<cfset qcbtwn = "AND (qc_date >= " & ss_qcfrm & " AND qc_date <= " & ss_qcto & ")"> 
		</cfif>
        
		<!--- joe -----   2/12/2018 -----------  requestID 107 ---- 3)--->
         
			<!--- construction start date --->
                            
            <!---
            <cfif trim(ss_consfrm) is not "" AND trim(ss_consto) is ""><cfset ss_constart = ss_consfrm></cfif>
            <cfif trim(ss_consto) is not "" AND trim(ss_consfrm) is ""><cfset ss_constart = ss_consto></cfif>
            --->
                            
            <cfset consbtwn = "">
            <cfif trim(ss_consfrm) is not "" AND trim(ss_consto) is "">
            	<cfset consbtwn = "AND (construction_start_date >= " & ss_consfrm  & ")">
            	<cfset ss_constart = "">
            </cfif>
            <cfif trim(ss_consto) is not "" AND trim(ss_consfrm) is "">
                <cfset consbtwn = " AND (construction_start_date <= " & ss_consto & ")"> 
                <cfset ss_constart = "">
            </cfif>
            <cfif trim(ss_consfrm) is not "" AND trim(ss_consto) is not "">
                <cfset consbtwn = "AND (construction_start_date >= " & ss_consfrm & " AND construction_start_date <= " & ss_consto & ")"> 
            </cfif>
            
            <!--- construction complete date --->
             
            <!---
            <cfif trim(ss_concfrm) is not "" AND trim(ss_concto) is ""><cfset ss_concomplete = ss_concfrm></cfif>
            <cfif trim(ss_concto) is not "" AND trim(ss_concfrm) is ""><cfset ss_concomplete = ss_concto></cfif>
            --->
            
            <cfset concbtwn = "">
            <cfif trim(ss_concfrm) is not "" AND trim(ss_concto) is "">
            	<cfset concbtwn = "AND (construction_completed_date >= " & ss_concfrm  & ")">
                <cfset ss_concomplete = "">
            </cfif>
            <cfif trim(ss_concto) is not "" AND trim(ss_concfrm) is "">
                <cfset concbtwn = " AND (construction_completed_date <= " & ss_concto & ")"> 
                <cfset ss_concomplete = "">
            </cfif>
            <cfif trim(ss_concfrm) is not "" AND trim(ss_concto) is not "">
                <cfset concbtwn = "AND (construction_completed_date >= " & ss_concfrm & " AND construction_completed_date <= " & ss_concto & ")"> 
            </cfif>

        <!--- End ---  joe -----   2/12/2018 -----------  requestID 107 ---- 3)         --->
        
		<cfquery name="getPackages" datasource="#request.sqlconn#">
		SELECT * FROM vwSites WHERE 1=1
		<cfif ss_no is not "">AND location_no = #ss_no#</cfif> 
		<!--- <cfif ss_sfx is not "">AND site_suffix = '#ss_sfx#'</cfif>  --->
		<cfif ss_pgroup is not "">
			<cfif ss_pgroup is "ALL">
				AND package_group is not NULL
			<cfelseif ss_pgroup is "NONE">
				AND package_group is NULL
			<cfelse>
				AND package_group = '#ss_pgroup#'
			</cfif>
		</cfif> 
		<cfif ss_pno is not "">AND package_no = '#ss_pno#'</cfif> 
		<cfif ss_type is not "">AND type = '#ss_type#'</cfif>
		<cfif ss_category is not "">AND type_desc = '#ss_category#'</cfif>
        
        
        <!--- joe hu ------ 2/14/2018     -----------  requestID 107 ---- 2) ----------  ---> 
        
        	<!---  =========== Facility Name  ================    ---> 
                
			<!--- ---- original ------    
	        <cfif trim(ss_name) is not "">AND name LIKE '%#preservesinglequotes(ss_name)#%'</cfif> 
	        --->
        
            <cfset target_string = '' >
            <cfset quoted_string_array = []>
            <cfif trim(ss_name) is not "">
	            <cfset target_string = ss_name >
	                   
	            <cfset regular_expression_double_quote = '"([^"]*)"'  />
				<cfset regular_expression_single_quote = "'([^']*)'"  />
	            
	            <cfset quoted_string_array_double_quote = REMatch(regular_expression_double_quote, target_string) >
	            <cfset quoted_string_array_single_quote = REMatch(regular_expression_single_quote, target_string) >
	 
	            <cfset ArrayAppend(quoted_string_array, quoted_string_array_double_quote, true) >
	            <cfset ArrayAppend(quoted_string_array, quoted_string_array_single_quote, true) >
	                                           							
	            <cfloop array="#quoted_string_array#" index="quoted_string_item">
	            	<cfset quoted_string_item_fake = replace(quoted_string_item, " ","~","all") >
	                <cfset target_string = replace(target_string, quoted_string_item, quoted_string_item_fake, "all") >
	            </cfloop>
									   
				<cfset target_string_array = ListToArray(target_string, " " ) />
	                           
	            <cfloop array="#target_string_array#" index="item">
	 				<cfset first_char=Left(item,1) />
	                <cfif first_char is "-">
						<cfset item = RemoveChars(item, 1, 1) />
	                                                           
	                    <!--- remove all single quote, double quote ,  replace ~ with space --->
	                    <cfset item = trim(replace(item,'"','',"ALL"))>
	                    <cfset item = trim(replace(item,"'",'',"ALL"))>
	                    <cfset item = trim(replace(item,"~",' ',"ALL"))>
						AND name Not LIKE '%#preservesinglequotes(item)#%'
						
					<cfelse>
        
						<!--- remove all single quote, double quote ,  replace ~ with space --->
                        <cfset item = trim(replace(item,'"','',"ALL"))>
                        <cfset item = trim(replace(item,"'",'',"ALL"))>
                        <cfset item = trim(replace(item,"~",' ',"ALL"))>
                        AND name LIKE '%#preservesinglequotes(item)#%'
						
                    </cfif> 
				</cfloop>     
			</cfif> 
                         
			<!---  =========== Address  ================    ---> 
                    
            <!--- ---- original ------
            <cfif trim(ss_address) is not "">AND address LIKE '%#preservesinglequotes(ss_address)#%'</cfif> 
            --->
        
			<cfset target_string = '' >
			<cfset quoted_string_array = []>
			
			<cfif trim(ss_address) is not "">
				<cfset target_string = ss_address >

				<cfset regular_expression_double_quote = '"([^"]*)"'  />
				<cfset regular_expression_single_quote = "'([^']*)'"  />
				
				<cfset quoted_string_array_double_quote = REMatch(regular_expression_double_quote, target_string) >
				<cfset quoted_string_array_single_quote = REMatch(regular_expression_single_quote, target_string) >

				<cfset ArrayAppend(quoted_string_array, quoted_string_array_double_quote, true) >
				<cfset ArrayAppend(quoted_string_array, quoted_string_array_single_quote, true) >
				
				<cfloop array="#quoted_string_array#" index="quoted_string_item">
					<cfset quoted_string_item_fake = replace(quoted_string_item, " ","~","all") >
					<cfset target_string = replace(target_string, quoted_string_item, quoted_string_item_fake, "all") >
				</cfloop>
				
				<cfset target_string_array = ListToArray(target_string, " " ) />
				
				<cfloop array="#target_string_array#" index="item">
					<cfset first_char=Left(item,1) />
					<cfif first_char is "-">		
						<cfset item = RemoveChars(item, 1, 1) />
						
						<!--- remove all single quote, double quote ,  replace ~ with space --->
						<cfset item = trim(replace(item,'"','',"ALL"))>
						<cfset item = trim(replace(item,"'",'',"ALL"))>
						<cfset item = trim(replace(item,"~",' ',"ALL"))>
						AND address Not LIKE '%#preservesinglequotes(item)#%'
					
					<cfelse>

						<!--- remove all single quote, double quote ,  replace ~ with space --->
						<cfset item = trim(replace(item,'"','',"ALL"))>
						<cfset item = trim(replace(item,"'",'',"ALL"))>
						<cfset item = trim(replace(item,"~",' ',"ALL"))>
						AND address LIKE '%#preservesinglequotes(item)#%'
						
					</cfif>
				</cfloop>
			</cfif> 
     
			<!---  =========== Keyword  ================    ---> 
			
			<!--- ---- original ------
			<cfif ss_keyword is not "">AND (
			notes #nt# LIKE '%#preservesinglequotes(ss_keyword)#%' OR 
			name #nt# LIKE '%#preservesinglequotes(ss_keyword)#%' OR
			address #nt# LIKE '%#preservesinglequotes(ss_keyword)#%' OR
			location_description #nt# LIKE '%#preservesinglequotes(ss_keyword)#%' OR
			damage_description #nt# LIKE '%#preservesinglequotes(ss_keyword)#%' OR
			tree_removal_notes #nt# LIKE '%#preservesinglequotes(ss_keyword)#%')	
			</cfif> --->

			<cfset target_string = '' >
			<cfset quoted_string_array = []>
			
			<cfif trim(ss_keyword) is not "">
				<cfset target_string = ss_keyword >
				
				<cfset regular_expression_double_quote = '"([^"]*)"'  />
				<cfset regular_expression_single_quote = "'([^']*)'"  />
				
				<cfset quoted_string_array_double_quote = REMatch(regular_expression_double_quote, target_string) >
				<cfset quoted_string_array_single_quote = REMatch(regular_expression_single_quote, target_string) >
				
				<cfset ArrayAppend(quoted_string_array, quoted_string_array_double_quote, true) >
				<cfset ArrayAppend(quoted_string_array, quoted_string_array_single_quote, true) >
				
				<cfloop array="#quoted_string_array#" index="quoted_string_item">
					<cfset quoted_string_item_fake = replace(quoted_string_item, " ","~","all") >
					<cfset target_string = replace(target_string, quoted_string_item, quoted_string_item_fake, "all") >
				</cfloop>
				
				<cfset target_string_array = ListToArray(target_string, " " ) />
				
				<cfloop array="#target_string_array#" index="item">
	
					<cfset first_char=Left(item,1) />
					
					<cfif first_char is "-">
						<cfset item = RemoveChars(item, 1, 1) />
						
						<!--- remove all single quote, double quote ,  replace ~ with space --->
						<cfset item = trim(replace(item,'"','',"ALL"))>
						<cfset item = trim(replace(item,"'",'',"ALL"))>
						<cfset item = trim(replace(item,"~",' ',"ALL"))>
						AND name NOT LIKE '%#preservesinglequotes(item)#%'
						AND address NOT LIKE '%#preservesinglequotes(item)#%'
						
						<!---   
						AND location_description NOT LIKE '%#preservesinglequotes(item)#%'
						AND notes NOT LIKE '%#preservesinglequotes(item)#%'
						AND damage_description NOT LIKE '%#preservesinglequotes(item)#%'       
						AND tree_removal_notes NOT LIKE '%#preservesinglequotes(item)#%'
						--->
						
					<cfelse>
					
						<!--- remove all single quote, double quote ,  replace ~ with space --->
						<cfset item = trim(replace(item,'"','',"ALL"))>
						<cfset item = trim(replace(item,"'",'',"ALL"))>
						<cfset item = trim(replace(item,"~",' ',"ALL"))>
						AND (
						name LIKE '%#preservesinglequotes(item)#%'
						OR address LIKE '%#preservesinglequotes(item)#%'
						OR notes LIKE '%#preservesinglequotes(item)#%'
						OR location_description LIKE '%#preservesinglequotes(item)#%'
						OR damage_description LIKE '%#preservesinglequotes(item)#%'
						OR tree_removal_notes LIKE '%#preservesinglequotes(item)#%'
						)
					
					</cfif>
				</cfloop>
			</cfif> 

        <!--- ------ End ------------ joe hu ------ 2/14/2018     -----------  requestID 107 ---- 2) ----------  ---> 
          
		<cfif trim(ss_wo) is not "">AND work_order LIKE '%#preservesinglequotes(ss_wo)#%'</cfif> 
		<cfif ss_assessed is not "">
			<cfif ss_assessed is 1>
				AND field_assessed = #ss_assessed#
			<cfelse>
				AND (field_assessed = 0 OR field_assessed is null)
			</cfif>
		</cfif> 
		<cfif trim(ss_assessor) is not "">AND assessed_date = #preservesinglequotes(ss_assessor)#</cfif>
		<cfif trim(assbtwn) is not "">#preservesinglequotes(assbtwn)#</cfif>
		<cfif ss_repairs is not "">AND repairs_required = #ss_repairs#</cfif> 
	<!---	<cfif ss_severity is not "">AND severity_index = #ss_severity#</cfif>  --->
    
    
    
   
    
    
    
        
		<cfif trim(ss_qc) is not "">AND qc_date = #preservesinglequotes(ss_qc)#</cfif>
		<cfif trim(qcbtwn) is not "">#preservesinglequotes(qcbtwn)#</cfif>
		<cfif trim(ss_constart) is not "">AND construction_start_date = #preservesinglequotes(ss_constart)#</cfif>
		<cfif trim(consbtwn) is not "">#preservesinglequotes(consbtwn)#</cfif>
		<cfif trim(ss_concomplete) is not "">AND construction_completed_date = #preservesinglequotes(ss_concomplete)#</cfif>
		<cfif trim(concbtwn) is not "">#preservesinglequotes(concbtwn)#</cfif>
		<cfif ss_cd is not "">AND council_district = #ss_cd#</cfif> 
		<cfif ss_zip is not "">AND zip_code = #ss_zip#</cfif>
		<cfif ss_curbramp is not "">AND curb_ramp_only = #ss_curbramp#</cfif>
        
        
        
        
         <!--- joe hu 2019-4 multi change --->
    
		<cfif ss_locked eq 1>AND locked = 1</cfif>
        
        <!--- joe hu 2019-9  ,  when locked is no(0), include all null and 0 --->
       <cfif ss_locked eq 0>AND ((locked is null) or (locked = 0)) </cfif>
        
        
        <cfif ss_grievance is not "">AND grievance = #ss_grievance#</cfif>
         <cfif ss_specialfund is not "">AND specialfund = #ss_specialfund#</cfif>
    <!--- end ---- joe hu 2019-4 multi change --->
        
        
        
        <!--- ---- joe hu 8-2-2019 search bar change --->
          <cfif ss_action is not "">AND #tree_action_type# = 'True' </cfif>  
        <!--- end ---- joe hu 8-2-2019 search bar change --->
        
        
        
		<!--- <cfif ss_pn is not "">AND priority_no = #ss_pn#</cfif>  --->
        
		<!---  joe remove 2/14/2018 -------
		
		<cfif ss_keyword is not "">AND (
		notes #nt# LIKE '%#preservesinglequotes(ss_keyword)#%' OR 
		name #nt# LIKE '%#preservesinglequotes(ss_keyword)#%' OR
		address #nt# LIKE '%#preservesinglequotes(ss_keyword)#%' OR
		location_description #nt# LIKE '%#preservesinglequotes(ss_keyword)#%' OR
		damage_description #nt# LIKE '%#preservesinglequotes(ss_keyword)#%' OR
		tree_removal_notes #nt# LIKE '%#preservesinglequotes(ss_keyword)#%')	
		</cfif> 
		
		

		<cfif ss_hasA is not "">
			<cfif ss_hasA is 1>AND has_after = 1<cfelse>AND (has_after <> 1 OR has_after is NULL)</cfif>
		</cfif>
		<cfif ss_hasB is not "">
			<cfif ss_hasB is 1>AND has_before = 1<cfelse>AND (has_before <> 1 OR has_before is NULL)</cfif>
		</cfif> 
        
		--->
        
        
        
        
        
		<cfif ss_hascert is not "">AND has_certificate = '#ss_hascert#'</cfif> 
		<cfif ss_removed is not "">AND removed = #ss_removed#<cfelse>AND removed is NULL</cfif> 
		<cfif isdefined("ss_assnull")>AND assessed_date IS NULL</cfif>
		<cfif isdefined("ss_qcnull")>AND qc_date IS NULL</cfif>
		<cfif isdefined("ss_consnull")>AND construction_start_date IS NULL</cfif>
		<cfif isdefined("ss_concnull")>AND construction_completed_date IS NULL</cfif>
		ORDER BY #ss_order#
	</cfquery>
	
		<cfset data.query = serializeJSON(getPackages)>
		
		<cfset session.siteQuery = getPackages>
	
		<cfset data.result = "Success">
        
        <!---
         <cfset data.target_string = target_string >
		 <cfset data.quoted_string_array = quoted_string_array >
        --->
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
		
	</cffunction>
	
	
	
	<cffunction name="updateEstimate" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT COLUMN_NAME,DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'tblEngineeringEstimate' AND TABLE_SCHEMA='dbo'
		</cfquery>
		
		<cfset uqstr = "UPDATE tblEngineeringEstimate SET ">
		<cfset iqstr = "INSERT INTO tblEngineeringEstimate (">
		<cfset tmp1 = "Location_No,">
		<cfset tmp2 = "#sw_id#,">
		
		<cfset cuqstr = "UPDATE tblContractorPricing SET CONTRACTORS_COST = " & replace(c_contractors_cost,",","","ALL") & ",">
		<cfset ciqstr = "INSERT INTO tblContractorPricing (">
		<cfset ctmp1 = "Location_No,CONTRACTORS_COST,">
		<cfset ctmp2 = "#sw_id#," & replace(c_contractors_cost,",","","ALL") & ",">
		
		<cfloop query="getFlds">
		
			<cfif isdefined("#column_name#")>
				<cfset v = evaluate("#column_name#")>
				<!--- <cfset "data.#column_name#" = v> --->
	
				<cfset uqstr = uqstr & column_name & " = ">
				<cfif data_type is "nvarchar">
					<cfset uqstr = uqstr & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset uqstr = uqstr & replace(v,",","","ALL") & ",">
				</cfif>
				
				<cfset tmp1 = tmp1 & column_name & ",">
				<cfif data_type is "nvarchar">
					<cfset tmp2 = tmp2 & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset tmp2 = tmp2 & replace(v,",","","ALL") & ",">
				</cfif>
				
			</cfif>
				
			<cfif isdefined("c_#column_name#")>
				
				<cfif find("UNIT_PRICE",column_name,"1") gt 0>
					
					<cfset v = evaluate("c_#column_name#")>
					
					<cfset cuqstr = cuqstr & column_name & " = ">
					<cfif data_type is "nvarchar">
						<cfset cuqstr = cuqstr & "'" & replace(v,"'","''","ALL") & "',">
					<cfelse>
						<cfset cuqstr = cuqstr & replace(v,",","","ALL") & ",">
					</cfif>
					
					<cfset ctmp1 = ctmp1 & column_name & ",">
					<cfif data_type is "nvarchar">
						<cfset ctmp2 = ctmp2 & "'" & replace(v,"'","''","ALL") & "',">
					<cfelse>
						<cfset ctmp2 = ctmp2 & replace(v,",","","ALL") & ",">
					</cfif>
				
				</cfif>
				
			
			</cfif>
		
		</cfloop>
		<cfset iqstr = iqstr & left(tmp1,len(tmp1)-1) & ") VALUES (" & left(tmp2,len(tmp2)-1)  & ")">
		<cfset uqstr = left(uqstr,len(uqstr)-1) & " WHERE location_no = " & sw_id>
		
		<cfset ciqstr = ciqstr & left(ctmp1,len(ctmp1)-1) & ") VALUES (" & left(ctmp2,len(ctmp2)-1)  & ")">
		<cfset cuqstr = left(cuqstr,len(cuqstr)-1) & " WHERE location_no = " & sw_id>
		
		<!--- <cfset data.uqstr = uqstr>
		<cfset data.iqstr = iqstr> --->
		<!--- <cfset data.cuqstr = cuqstr>
		<cfset data.ciqstr = ciqstr> --->
		
		<!--- <cfdump var="#sw_user#"><br><br>
		<cfdump var="#uqstr#"><br><br>
		<cfdump var="#iqstr#"><br><br>
		<cfdump var="#cuqstr#"><br><br>
		<cfdump var="#ciqstr#"><br><br> --->
		
		<cftry>
		
			<cfif sw_user is not "BSS"><!--- Added so that BSS doesn't update the Engineers Estimate --->
		
				<cfquery name="chkRecord" datasource="#request.sqlconn#">
				SELECT * FROM tblEngineeringEstimate WHERE location_no = #sw_id#
				</cfquery>
				<cfif chkRecord.recordcount gt 0>
					<cfset qstr = uqstr>
				<cfelse>
					<cfset qstr = iqstr>
				</cfif>
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				#preservesinglequotes(qstr)#
				</cfquery>
				
				<cfif chkRecord.recordcount gt 0><cfset fld = "modified_date">
				<cfelse><cfset fld = "creation_date"></cfif>
				
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblEngineeringEstimate SET
				user_id = #session.user_num#,
				#fld# = #CreateODBCDateTime(Now())#
				WHERE location_no = #sw_id#
				</cfquery>
			
			</cfif>
			
			<cfquery name="chkRecord" datasource="#request.sqlconn#">
			SELECT * FROM tblContractorPricing WHERE location_no = #sw_id#
			</cfquery>
			<cfif chkRecord.recordcount gt 0>
				<cfset cqstr = cuqstr>
			<cfelse>
				<cfset cqstr = ciqstr>
			</cfif>
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			#preservesinglequotes(cqstr)#
			</cfquery>
			
			<cfif chkRecord.recordcount gt 0><cfset fld = "modified_date">
			<cfelse><cfset fld = "creation_date"></cfif>
			
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			UPDATE tblContractorPricing SET
			user_id = #session.user_num#,
			#fld# = #CreateODBCDateTime(Now())#
			WHERE location_no = #sw_id#
			</cfquery>
			
			<!--- <cfset data.qstr = qstr>
			<cfset data.qstr = cqstr> --->
			
			
			<!--- Update Package Estimates and Cost --->
			<!--- <cfquery name="getPackage" datasource="#request.sqlconn#">
			SELECT package_no as pno,package_group as pgp FROM tblSites WHERE location_no = #sw_id#
			</cfquery>
			
			<cfif getPackage.pno is not "">
				<cfquery name="getIDs" datasource="#request.sqlconn#">
				SELECT location_no FROM tblSites WHERE package_no = #getPackage.pno# AND
				package_group = '#getPackage.pgp#'
				</cfquery>
				<cfif getIDs.recordcount gt 0>
					<cfset str = "">
					<cfloop query="getIDs">
						<cfset str = str & location_no & ",">
					</cfloop>
					<cfset str = left(str,len(str)-1)>
					<cfset qstr = "SELECT sum(engineers_estimate_total_cost) as cost FROM tblEngineeringEstimate WHERE location_no IN (" & str & ")">
					<cfset cqstr = "SELECT sum(contractors_cost) as cost FROM tblContractorPricing WHERE location_no IN (" & str & ")">
					
					<cfquery name="getEstimate" datasource="#request.sqlconn#">
					#preservesinglequotes(qstr)#
					</cfquery>
					
					<cfset v = getEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
					<cfquery name="setEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					engineers_estimate = #v#
					WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
					</cfquery>
					
					<cfquery name="getCEstimate" datasource="#request.sqlconn#">
					#preservesinglequotes(cqstr)#
					</cfquery>
					
					<cfset v = getCEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
					<cfquery name="setCEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					awarded_bid = #v#
					WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
					</cfquery>
				<cfelse>
					<cfquery name="setEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					engineers_estimate = NULL
					WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
					</cfquery>
					
					<cfquery name="setCEstimate" datasource="#request.sqlconn#">
					UPDATE tblPackages SET
					awarded_bid = NULL
					WHERE package_no = #getPackage.pno# AND package_group = '#getPackage.pgp#'
					</cfquery>
				</cfif>
			</cfif> --->
		
			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	
	<cffunction name="updateADA" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT COLUMN_NAME,DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'tblADACurbRamps' AND TABLE_SCHEMA='dbo'
		</cfquery>
		
		<cfset uqstr = "UPDATE tblADACurbRamps SET ">
		<cfset iqstr = "INSERT INTO tblADACurbRamps (">
		<cfset tmp1 = "Location_No,">
		<cfset tmp2 = "#sw_id#,">
		
		<cfloop query="getFlds">
		
			<cfif isdefined("#column_name#")>
				<cfset v = evaluate("#column_name#")>
				<!--- <cfset "data.#column_name#" = v> --->
	
				<cfset uqstr = uqstr & column_name & " = ">
				<cfif data_type is "nvarchar">
					<cfset uqstr = uqstr & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset uqstr = uqstr & v & ",">
				</cfif>
				
				<cfset tmp1 = tmp1 & column_name & ",">
				<cfif data_type is "nvarchar">
					<cfset tmp2 = tmp2 & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset tmp2 = tmp2 & v & ",">
				</cfif>				
			
			</cfif>
		
		</cfloop>
		<cfset iqstr = iqstr & left(tmp1,len(tmp1)-1) & ") VALUES (" & left(tmp2,len(tmp2)-1)  & ")">
		<cfset uqstr = left(uqstr,len(uqstr)-1) & " WHERE location_no = " & sw_id>
		
		<!--- <cfset data.uqstr = uqstr>
		<cfset data.iqstr = iqstr> --->
		
		<cftry>
		
			<cfquery name="chkRecord" datasource="#request.sqlconn#">
			SELECT * FROM tblADACurbRamps WHERE location_no = #sw_id#
			</cfquery>
			<cfif chkRecord.recordcount gt 0>
				<cfset qstr = uqstr>
			<cfelse>
				<cfset qstr = iqstr>
			</cfif>
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			#preservesinglequotes(qstr)#
			</cfquery>
			
			<cfif chkRecord.recordcount gt 0><cfset fld = "modified_date">
			<cfelse><cfset fld = "creation_date"></cfif>
			
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			UPDATE tblADACurbRamps SET
			user_id = #session.user_num#,
			#fld# = #CreateODBCDateTime(Now())#
			WHERE location_no = #sw_id#
			</cfquery>
			
			<!--- <cfset data.qstr = qstr> --->
		
			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	
	<cffunction name="deleteSite" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sid" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Deletion Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level lt 2>
			<cfset data.result = "- Site Deletion Failed: You are not authorized to make edits.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>		
		
		<cfset data.sid = sid>
	
		<!--- <cftry> --->
		
			<cfquery name="getRecord" datasource="#request.sqlconn#">
			SELECT * FROM tblSites WHERE id = #sid#
			</cfquery>
			
			<cfif getRecord.recordcount gt 0>
				<cfset pno = getRecord.package_no>
				<cfset pgp = getRecord.package_group>
				<cfset loc = getRecord.location_no>
			
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblSites SET
				removed = 1,
				package_no = NULL,
				package_group = NULL,
				user_id = #session.user_num#,
				modified_date = #CreateODBCDateTime(Now())#
				WHERE id = #sid#
				</cfquery>
				
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblGeocoding SET
				deleted = 1,
				userid = #session.user_num#,
				lastmodifieddate = #CreateODBCDateTime(Now())#
				WHERE location_no = #loc#
				</cfquery>
				
				<!--- <cfif pno is not "">
					<cfquery name="getIDs" datasource="#request.sqlconn#">
					SELECT location_no FROM tblSites WHERE package_no = #pno# AND
					package_group = '#pgp#'
					</cfquery>
					<cfif getIDs.recordcount gt 0>
						<cfset str = "">
						<cfloop query="getIDs">
							<cfset str = str & location_no & ",">
						</cfloop>
						<cfset str = left(str,len(str)-1)>
						<cfset qstr = "SELECT sum(engineers_estimate_total_cost) as cost FROM tblEngineeringEstimate WHERE location_no IN (" & str & ")">
						<cfset cqstr = "SELECT sum(contractors_cost) as cost FROM tblContractorPricing WHERE location_no IN (" & str & ")">
						
						<cfquery name="getEstimate" datasource="#request.sqlconn#">
						#preservesinglequotes(qstr)#
						</cfquery>
						
						<cfset v = getEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
						<cfquery name="setEstimate" datasource="#request.sqlconn#">
						UPDATE tblPackages SET
						engineers_estimate = #v#
						WHERE package_no = #pno# AND package_group = '#pgp#'
						</cfquery>
						
						<cfquery name="getCEstimate" datasource="#request.sqlconn#">
						#preservesinglequotes(cqstr)#
						</cfquery>
						
						<cfset v = getCEstimate.cost><cfif v is ""><cfset v = "NULL"></cfif>
						<cfquery name="setCEstimate" datasource="#request.sqlconn#">
						UPDATE tblPackages SET
						awarded_bid = #v#
						WHERE package_no = #pno# AND package_group = '#pgp#'
						</cfquery>
					<cfelse>
					
						<cfquery name="setEstimate" datasource="#request.sqlconn#">
						UPDATE tblPackages SET
						engineers_estimate = NULL
						WHERE package_no = #pno# AND package_group = '#pgp#'
						</cfquery>
			
						<cfquery name="setCEstimate" datasource="#request.sqlconn#">
						UPDATE tblPackages SET
						awarded_bid = NULL
						WHERE package_no = #pno# AND package_group = '#pgp#'
						</cfquery>
					</cfif>
				</cfif> --->
			
			</cfif>
		
			<cfset data.result = "Success">
		<!--- <cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry> --->
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
	
	
	<cffunction name="restoreSite" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sid" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Restoration Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level lt 2>
			<cfset data.result = "- Site Restoration Failed: You are not authorized to make edits.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>		
		
		<cfset data.sid = sid>
	
		<cftry>
		
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			UPDATE tblSites SET
			removed = NULL,
			user_id = #session.user_num#,
			modified_date = #CreateODBCDateTime(Now())#
			WHERE id = #sid#
			</cfquery>
				
			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
	
	
	
	<!--- ------------ joe hu 6/14/2018 delete curbRamp  --------------  ----------- --->
	
	<cffunction name="deleteCurbRamp" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="crid" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- CurbRamp Deletion Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level lt 2>
			<cfset data.result = "- CurbRamp Deletion Failed: You are not authorized to make edits.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>		
		
		<cfset data.crid = crid>
	
			<cfquery name="getRecord" datasource="#request.sqlconn#">
			SELECT * FROM tblCurbRamps WHERE Ramp_No = #crid#
			</cfquery>
			
			<cfif getRecord.recordcount gt 0>
				
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblCurbRamps SET
				removed = 1,
				
				user_id = #session.user_num#,
				modified_date = #CreateODBCDateTime(Now())#
				WHERE Ramp_No = #crid#
				</cfquery>
				
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblGeocodingCurbRamps SET
				deleted = 1,
				userid = #session.user_num#,
				lastmodifieddate = #CreateODBCDateTime(Now())#
				WHERE Ramp_No = #crid#
				</cfquery>
				
			</cfif>
		
			<cfset data.result = "Success">
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
    
	
    <cffunction name="restoreCurbRamp" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="crid" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- CurbRamp Restoration Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level lt 2>
			<cfset data.result = "- CurbRamp Restoration Failed: You are not authorized to make edits.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>		
		
		<cfset data.crid = crid>
	
		<cftry>
		
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			UPDATE tblCurbRamps SET
			removed = NULL,
			user_id = #session.user_num#,
			modified_date = #CreateODBCDateTime(Now())#
			WHERE Ramp_No = #crid#
			</cfquery>
				
			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
    

    <!--- ---------    End  -------------- joe hu 6/14/2018 delete curbRamp  --------------   --->
	
	
	
	<cffunction name="downloadData" access="remote" returnType="any" returnFormat="plain" output="false">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Download Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level lt 3>
			<cfset data.result = "- Download Failed: You are not authorized to download.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>		
		
		<cftry>
		
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRAssessmentTracking' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfset filename = expandPath("../downloads/SidewalkRepairProgram.xls")>
			<cfspreadsheet action="write" query="getFlds" filename="#filename#" overwrite="true">
			<cfset s = spreadsheetNew("AssessmentTracking","no")>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRAssessmentTracking
			</cfquery>
			
			<!--- <cfset spreadsheetCreateSheet(s,"AssessmentTracking")>
			<cfset spreadsheetRemoveSheet(s,"Sheet1")> 
			<cfset spreadsheetsetActiveSheet(s,"AssessmentTracking")> --->
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRWorkOrders' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRWorkOrders
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"WorkOrders")>
			<cfset spreadsheetsetActiveSheet(s,"WorkOrders")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwEngineeringEstimateDL1' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwEngineeringEstimateDL1
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"EngineeringEstimate1")>
			<cfset spreadsheetsetActiveSheet(s,"EngineeringEstimate1")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwEngineeringEstimateDL2' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwEngineeringEstimateDL2
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"EngineeringEstimate2")>
			<cfset spreadsheetsetActiveSheet(s,"EngineeringEstimate2")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwContractorPricingDL1' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwContractorPricingDL1
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"ContractorPricing1")>
			<cfset spreadsheetsetActiveSheet(s,"ContractorPricing1")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwContractorPricingDL2' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwContractorPricingDL2
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"ContractorPricing2")>
			<cfset spreadsheetsetActiveSheet(s,"ContractorPricing2")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRADACurbRamps' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRADACurbRamps
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"ADACurbRamps")>
			<cfset spreadsheetsetActiveSheet(s,"ADACurbRamps")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRCurbRamps' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRCurbRamps
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"CurbRamps")>
			<cfset spreadsheetsetActiveSheet(s,"CurbRamps")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRTreeSiteInfo' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRTreeSiteInfo
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"TreeSiteInfo")>
			<cfset spreadsheetsetActiveSheet(s,"TreeSiteInfo")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRTreeList' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRTreeList
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"TreeList")>
			<cfset spreadsheetsetActiveSheet(s,"TreeList")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRQCQuantity' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRQCQuantity
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"QCQuantity")>
			<cfset spreadsheetsetActiveSheet(s,"QCQuantity")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRChangeOrders' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRChangeOrders
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"ChangeOrders")>
			<cfset spreadsheetsetActiveSheet(s,"ChangeOrders")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME
			FROM INFORMATION_SCHEMA.COLUMNS
			WHERE TABLE_NAME = 'vwHDRCertificates' AND TABLE_SCHEMA='dbo'
			</cfquery>
			
			<cfset columns = ""><cfset cnt = 0>
			<cfloop query="getFlds">
				<cfset cnt = cnt + 1>
				<cfset columns = columns & column_name>
				<cfif cnt is not getFlds.recordcount><cfset columns = columns & ","></cfif>
			</cfloop>
			
			<cfquery name="getRecords" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM vwHDRCertificates
			</cfquery>
			
			<cfset spreadsheetCreateSheet(s,"CertificatesOfCompliance")>
			<cfset spreadsheetsetActiveSheet(s,"CertificatesOfCompliance")>
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, getRecords)>
			
			
			
			
			<cfset spreadsheetsetActiveSheet(s,"AssessmentTracking")>
			<cfset spreadsheetWrite(s, filename, true)>
			
			<cfzip file="#replace(filename,'xls','zip','ALL')#" source="#filename#" overwrite = "yes">
			
			<cfset data.result = "Success">
			<cfset data.filename = replace(filename,'xls','zip','ALL')>
		<cfcatch>
			<cfset data.result = " - Download Failed: Database Error.">
		</cfcatch>
		</cftry>
		
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
	
	
	<cffunction name="getDefaults" access="remote" returnType="any" returnFormat="plain" output="false">
	
		<cfset var data = {}>
		
		<cfquery name="Defaults" datasource="#request.sqlconn#">
		SELECT * FROM dbo.tblEstimateDefaults
		</cfquery>
		
		<cfset data.query = serializeJSON(Defaults)>
		<cfset data.result = "Success">
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
	
	<cffunction name="reCalculateTotal" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		<cfargument name="sw_type" required="true">
	
		<cfset var data = {}>
		
		<cfquery name="getPackage" datasource="#request.sqlconn#">
		SELECT package_no as pno,package_group as pgp FROM tblPackages WHERE id = #sw_id#
		</cfquery>
		<cfquery name="getIDs" datasource="#request.sqlconn#">
		SELECT location_no FROM tblSites WHERE package_no = #getPackage.pno# AND
		package_group = '#getPackage.pgp#'
		</cfquery>
		
		<cfset v = 0>
		<cfif sw_type is "ee">

			<cfif getIDs.recordcount gt 0>
				<cfset str = "">
				<cfloop query="getIDs">
					<cfset str = str & location_no & ",">
				</cfloop>
				<cfset str = left(str,len(str)-1)>
				<cfset qstr = "SELECT sum(engineers_estimate_total_cost) as cost FROM tblEngineeringEstimate WHERE location_no IN (" & str & ")">
				
				<cfquery name="getEstimate" datasource="#request.sqlconn#">
				#preservesinglequotes(qstr)#
				</cfquery>
				<cfset v = getEstimate.cost><cfif v is ""><cfset v = 0></cfif>
			</cfif>
		
		<cfelse>
			
			<cfif getIDs.recordcount gt 0>
				<cfset str = "">
				<cfloop query="getIDs">
					<cfset str = str & location_no & ",">
				</cfloop>
				<cfset str = left(str,len(str)-1)>
				<cfset cqstr = "SELECT sum(contractors_cost) as cost FROM tblContractorPricing WHERE location_no IN (" & str & ")">
				
				<cfquery name="getCEstimate" datasource="#request.sqlconn#">
				#preservesinglequotes(cqstr)#
				</cfquery>
				<cfset v = getCEstimate.cost><cfif v is ""><cfset v = 0></cfif>
				
			</cfif>
			
		</cfif>
		
		<cfset data.value = numberformat(v,"999,999,999")>
		<cfif v is 0><cfset data.value = ""></cfif>
		<cfset data.result = "Success">
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
	
	
	
	<cffunction name="updateAssessment" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT COLUMN_NAME,DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'tblEngineeringEstimate' AND TABLE_SCHEMA='dbo'
		</cfquery>
		
		<!--- <cfset uqstr = "UPDATE tblEngineeringEstimate SET COMMENTS = '" & replace(comments,"'","''","ALL") & "',"> --->
		<cfset uqstr = "UPDATE tblEngineeringEstimate SET ">
		<cfset iqstr = "INSERT INTO tblEngineeringEstimate (">
		<!--- <cfset tmp1 = "Location_No,COMMENTS,">
		<cfset tmp2 = "#sw_id#,'" & replace(comments,"'","''","ALL") & "',"> --->
		<cfset tmp1 = "Location_No,">
		<cfset tmp2 = "#sw_id#,">
		
		<cfset cuqstr = "UPDATE tblQCQuantity SET ">
		<cfset ciqstr = "INSERT INTO tblQCQuantity (">
		<cfset ctmp1 = "Location_No,">
		<cfset ctmp2 = "#sw_id#,">
		
		<cfloop query="getFlds">
		
			<cfif isdefined("ass_#column_name#")>
				<cfset v = evaluate("ass_#column_name#")>
				<!--- <cfset "data.#column_name#" = v> --->
	
				<cfset uqstr = uqstr & column_name & " = ">
				<cfif data_type is "nvarchar">
					<cfset uqstr = uqstr & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset uqstr = uqstr & replace(v,",","","ALL") & ",">
				</cfif>
				
				<cfset tmp1 = tmp1 & column_name & ",">
				<cfif data_type is "nvarchar">
					<cfset tmp2 = tmp2 & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset tmp2 = tmp2 & replace(v,",","","ALL") & ",">
				</cfif>
				
			</cfif>
			
			<cfif isdefined("ass_q_#column_name#")>

				<cfset v = evaluate("ass_q_#column_name#")>
				
				<cfset cuqstr = cuqstr & column_name & " = ">
				<cfif data_type is "nvarchar">
					<cfset cuqstr = cuqstr & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset cuqstr = cuqstr & replace(v,",","","ALL") & ",">
				</cfif>
				
				<cfset ctmp1 = ctmp1 & column_name & ",">
				<cfif data_type is "nvarchar">
					<cfset ctmp2 = ctmp2 & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset ctmp2 = ctmp2 & replace(v,",","","ALL") & ",">
				</cfif>
				
			</cfif>
		
		</cfloop>
		
		<cfset doQC = false><cfif isdefined("ass_q_MOBILIZATION_quantity")><cfset doQC = true></cfif>
		
		<cfset iqstr = iqstr & left(tmp1,len(tmp1)-1) & ") VALUES (" & left(tmp2,len(tmp2)-1)  & ")">
		<cfset uqstr = left(uqstr,len(uqstr)-1) & " WHERE location_no = " & sw_id>
		
		<cfset ciqstr = ciqstr & left(ctmp1,len(ctmp1)-1) & ") VALUES (" & left(ctmp2,len(ctmp2)-1)  & ")">
		<cfset cuqstr = left(cuqstr,len(cuqstr)-1) & " WHERE location_no = " & sw_id>
		
		<!--- <cfset data.uqstr = uqstr>
		<cfset data.iqstr = iqstr>
		<cfset data.cuqstr = cuqstr>
		<cfset data.ciqstr = ciqstr>
		<cfset data.doQC = doQC> --->
		
		<cftry>
		
			<cfquery name="chkRecord" datasource="#request.sqlconn#">
			SELECT * FROM tblEngineeringEstimate WHERE location_no = #sw_id#
			</cfquery>
			<cfif chkRecord.recordcount gt 0>
				<cfset qstr = uqstr>
			<cfelse>
				<cfset qstr = iqstr>
			</cfif>
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			#preservesinglequotes(qstr)#
			</cfquery>
			
			<cfif chkRecord.recordcount gt 0><cfset fld = "modified_date">
			<cfelse><cfset fld = "creation_date"></cfif>
			
			<!--- <cfif doQC is false> --->
			
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblEngineeringEstimate SET
				user_id = #session.user_num#,
				#fld# = #CreateODBCDateTime(Now())#
				WHERE location_no = #sw_id#
				</cfquery>
			
			<!--- </cfif> --->
			
			<cfif doQC is true>
			
				<cfquery name="chkRecord" datasource="#request.sqlconn#">
				SELECT * FROM tblQCQuantity WHERE location_no = #sw_id#
				</cfquery>
				<cfif chkRecord.recordcount gt 0>
					<cfset cqstr = cuqstr>
				<cfelse>
					<cfset cqstr = ciqstr>
				</cfif>
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				#preservesinglequotes(cqstr)#
				</cfquery>
				
				<cfif chkRecord.recordcount gt 0><cfset fld = "modified_date">
				<cfelse><cfset fld = "creation_date"></cfif>
				
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblQCQuantity SET
				user_id = #session.user_num#,
				#fld# = #CreateODBCDateTime(Now())#
				WHERE location_no = #sw_id#
				</cfquery>
			
			</cfif>
		
			<cfset data.result = "Success">
			
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	<cffunction name="updateChangeOrder" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT COLUMN_NAME,DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'tblChangeOrders' AND TABLE_SCHEMA='dbo'
		</cfquery>
		
		<cfset cuqstr = "UPDATE tblChangeOrders SET ">
		<cfset ciqstr = "INSERT INTO tblChangeOrders (">
		<cfset ctmp1 = "Location_No,">
		<cfset ctmp2 = "#sw_id#,">
		
		<cfloop query="getFlds">
			
			<cfif isdefined("cor_#column_name#")>

				<cfset v = evaluate("cor_#column_name#")>
				
				<cfset cuqstr = cuqstr & column_name & " = ">
				<cfif data_type is "nvarchar">
					<cfset cuqstr = cuqstr & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset cuqstr = cuqstr & replace(v,",","","ALL") & ",">
				</cfif>
				
				<cfset ctmp1 = ctmp1 & column_name & ",">
				<cfif data_type is "nvarchar">
					<cfset ctmp2 = ctmp2 & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset ctmp2 = ctmp2 & replace(v,",","","ALL") & ",">
				</cfif>
				
			</cfif>
		
		</cfloop>
		
		<cfset ciqstr = ciqstr & left(ctmp1,len(ctmp1)-1) & ") VALUES (" & left(ctmp2,len(ctmp2)-1)  & ")">
		<cfset cuqstr = left(cuqstr,len(cuqstr)-1) & " WHERE location_no = " & sw_id>

		<!--- <cfset data.cuqstr = cuqstr>
		<cfset data.ciqstr = ciqstr> --->
		
		<cftry>
	
			<cfquery name="chkRecord" datasource="#request.sqlconn#">
			SELECT * FROM tblChangeOrders WHERE location_no = #sw_id#
			</cfquery>
			<cfif chkRecord.recordcount gt 0>
				<cfset cqstr = cuqstr>
			<cfelse>
				<cfset cqstr = ciqstr>
			</cfif>
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			#preservesinglequotes(cqstr)#
			</cfquery>
			
			<cfif chkRecord.recordcount gt 0><cfset fld = "modified_date">
			<cfelse><cfset fld = "creation_date"></cfif>
			
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			UPDATE tblChangeOrders SET
			user_id = #session.user_num#,
			#fld# = #CreateODBCDateTime(Now())#
			WHERE location_no = #sw_id#
			</cfquery>

			<cfset data.result = "Success">
			
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	<cffunction name="updateTrees" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT COLUMN_NAME,DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = 'tblTreeRemovalInfo' AND TABLE_SCHEMA='dbo'
		</cfquery>
		
		<cfset uqstr = "UPDATE tblTreeRemovalInfo SET ">
		<cfset iqstr = "INSERT INTO tblTreeRemovalInfo (">
		<cfset tmp1 = "Location_No,">
		<cfset tmp2 = "#sw_id#,">
		
		<cfloop query="getFlds">
		
			<cfif isdefined("#column_name#")>
				<cfset v = evaluate("#column_name#")>
				<!--- <cfset "data.#column_name#" = v> --->
				<cfif v is ""><cfset v = "NULL"></cfif>
				<cfif data_type is "datetime">
					<cfif v is not "NULL">
						<cfset arrDT = listtoarray(v,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset v = createODBCDate(dt)>
					</cfif>
				</cfif>
				
				<cfset uqstr = uqstr & column_name & " = ">
				<cfif data_type is "nvarchar" AND v is not "NULL">
					<cfset uqstr = uqstr & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset uqstr = uqstr & v & ",">
				</cfif>
				
				<cfset tmp1 = tmp1 & column_name & ",">
				<cfif data_type is "nvarchar" AND v is not "NULL">
					<cfset tmp2 = tmp2 & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset tmp2 = tmp2 & v & ",">
				</cfif>				
			
			</cfif>
		
		</cfloop>
		<cfset iqstr = iqstr & left(tmp1,len(tmp1)-1) & ") VALUES (" & left(tmp2,len(tmp2)-1)  & ")">
		<cfset uqstr = left(uqstr,len(uqstr)-1) & " WHERE location_no = " & sw_id>
		
		<!--- <cfset data.uqstr = uqstr>
		<cfset data.iqstr = iqstr> --->
		
		<cftry>
		
			<cfquery name="chkRecord" datasource="#request.sqlconn#">
			SELECT * FROM tblTreeRemovalInfo WHERE location_no = #sw_id#
			</cfquery>
			<cfif chkRecord.recordcount gt 0>
				<cfset qstr = uqstr>
			<cfelse>
				<cfset qstr = iqstr>
			</cfif>
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			#preservesinglequotes(qstr)#
			</cfquery>
			
			<cfif chkRecord.recordcount gt 0><cfset fld = "modified_date">
			<cfelse><cfset fld = "creation_date"></cfif>
			
			<cfquery name="updateRecord" datasource="#request.sqlconn#">
			UPDATE tblTreeRemovalInfo SET
			user_id = #session.user_num#,
			#fld# = #CreateODBCDateTime(Now())#
			WHERE location_no = #sw_id#
			</cfquery>
			
			<!--- <cfset data.qstr = qstr> --->
		
			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	
	
	<cffunction name="updateDefault" access="remote" returnType="any" returnFormat="plain" output="false">
		<!--- <cfargument name="sw_id" required="true"> --->
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level lt 3>
			<cfset data.result = "- Download Failed: You are not authorized to update the Estimate Default Table.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>		
		
		<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT COLUMN_NAME, sort_order, sort_group
		FROM vwSortOrder WHERE column_name not like 'EXTRA%'
		ORDER BY full_sort, sort_group, sort_order 
		</cfquery>
		
		<!--- <cfset data.uqstr = uqstr>
		<cfset data.iqstr = iqstr> --->
		
		<!--- <cftry> --->
		
			<cfloop index="i" from="1" to="#getFlds.recordcount#">
		
				<cfset field = evaluate("fieldname_#i#")>
				<cfset units = replace(evaluate("units_#i#"),"'","''","ALL")>
				<cfset price = evaluate("price_#i#")>
			
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblEstimateDefaults SET 
				units = '#units#',
				price = #price#
				WHERE fieldname = '#field#'
				</cfquery>
				
			</cfloop>

			<cfset data.result = "Success">
		<!--- <cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry> --->
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	<cffunction name="updateContractorAll" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		
		<cfset tbl = "tblContractorPricing">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfquery name="getPackage" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT package_no, package_group FROM tblSites WHERE id = #sw_id#
		</cfquery>
		
		<cfset pno = getPAckage.package_no>
		<cfset pgrp = getPAckage.package_group>
		
		<cfquery name="getSites" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT location_no FROM tblSites WHERE package_no = #pno# AND package_group = '#pgrp#'
		</cfquery>
		
		<cfset locs = ValueList(getSites.location_no,",")>
		<cfset arrLocs = listToArray(locs,",")>
		
		<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT COLUMN_NAME,DATA_TYPE
		FROM INFORMATION_SCHEMA.COLUMNS
		WHERE TABLE_NAME = '#tbl#' AND TABLE_SCHEMA='dbo'
		</cfquery>
		
		<cfset uqstr = "UPDATE #tbl# SET ">
		<cfset tmp1 = "Location_No,">
		<cfset tmp2 = "#sw_id#,">
		
		<cfloop query="getFlds">
		
			<cfif isdefined("c_#column_name#")>
				<cfset v = evaluate("c_#column_name#")>
				<!--- <cfset "data.#column_name#" = v> --->
				<cfif v is ""><cfset v = "NULL"></cfif>
				<cfif data_type is "datetime">
					<cfif v is not "NULL">
						<cfset arrDT = listtoarray(v,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset v = createODBCDate(dt)>
					</cfif>
				</cfif>
				
				<cfset uqstr = uqstr & column_name & " = ">
				<cfif data_type is "nvarchar" AND v is not "NULL">
					<cfset uqstr = uqstr & "'" & replace(v,"'","''","ALL") & "',">
				<cfelse>
					<cfset uqstr = uqstr & v & ",">
				</cfif>
				
			</cfif>
		
		</cfloop>
		<cfset uqstr = left(uqstr,len(uqstr)-1)>
		<!--- <cfset data.uqstr = uqstr> --->
		
		<cftry>
		
			<cfloop index="i" from="1" to="#arrayLen(arrLocs)#">
		
				<cfquery name="chkExist" datasource="#request.sqlconn#" dbtype="ODBC">
				SELECT count(*) as cnt FROM #tbl# WHERE location_no = #arrLocs[i]#
				</cfquery>
				
				<cfset fld = "modified_date">			
				<cfif chkExist.cnt is 0>
					<cfset fld = "creation_date">
					<cfquery name="chkExist" datasource="#request.sqlconn#" dbtype="ODBC">
				 	INSERT INTO #tbl# (location_no,#fld#,user_id) VALUES (#arrLocs[i]#,#CreateODBCDateTime(Now())#,#session.user_num#)
					</cfquery>
				<cfelse>
					<cfquery name="updateRecord" datasource="#request.sqlconn#">
					UPDATE #tbl# SET
					user_id = #session.user_num#,
					#fld# = #CreateODBCDateTime(Now())#
					WHERE location_no = #arrLocs[i]#
					</cfquery>
				</cfif>
				
				<cfquery name="UpdatePricing" datasource="#request.sqlconn#" dbtype="ODBC">
				#uqstr# WHERE location_no = #arrLocs[i]#
				</cfquery>
				
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblTreeRemovalInfo SET
				user_id = #session.user_num#,
				#fld# = #CreateODBCDateTime(Now())#
				WHERE location_no = #sw_id#
				</cfquery>
			
			</cfloop>

			<cfset data.result = "Success">
		<cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	<cffunction name="downloadSiteSearch" access="remote" returnType="any" returnFormat="plain" output="false">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Download Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<!--- <cfif session.user_level lt 3>
			<cfset data.result = "- Download Failed: You are not authorized to download.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif> --->
		
		<cftry>
		
			<cfset sfx = timeformat(now(),"HHmmss")>

			<cfset columns = "Site,Council District,Package,Facility Name,Address,Construction Start Date,Construction Completed Date,Classification,Priority Score,Engineer's Estimate,Total Cost,Total Concrete,Type,Subtype,Work Order,Number of Curb Ramps,Has Certificate,Certificate Total,Has Before Photo,Has After Photo, Has Planted Trees, Has Removed Trees, Has Preserved Trees">
			
			<cfquery name="setSearch" dbtype="query">
			SELECT location_no as site,council_district as cd, package,name as facility_name,address,construction_start_date,
			construction_completed_date,classification,priority_score,engineers_estimate,total_cost,total_concrete,type_desc,subtype_desc,work_order,number_curbramps,has_certificate,certificate_total,
            Has_Before,
            Has_After,
            Has_Planted_Trees,
            Has_Removed_Trees,
            Has_Preserved_Trees
            
               FROM session.siteQuery
			</cfquery>
			
			<cfset filename = expandPath("../downloads/SidewalkRepairSiteSearch_#sfx#.xls")>
			<cfspreadsheet action="write" query="setSearch" filename="#filename#" overwrite="true">
			<cfset s = spreadsheetNew("SiteSearchResults","no")>
			
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, setSearch)>
			
			<!--- <cfset spreadsheetsetActiveSheet(s,"AssessmentTracking")> --->
			<cfset spreadsheetWrite(s, filename, true)>
			
			<cfzip file="#replace(filename,'xls','zip','ALL')#" source="#filename#" overwrite = "yes">
			
			<cfset data.result = "Success">
			<cfset data.filename = replace(filename,'xls','zip','ALL')>
			
			<cfset data.href = request.url & "downloads/SidewalkRepairSiteSearch_" & sfx & ".zip">
			
		<cfcatch>
			<cfset data.result = " - Download Failed: Database Error.">
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset dir = request.dir & "\downloads">
			<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.xls">
			<cfoutput query="pdfdir">
				<cfif DateDiff("h",pdfdir.datelastmodified,now()) gt 1>
					<cffile action="DELETE" file="#dir#\#pdfdir.name#">
				</cfif>
			</cfoutput>
			<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.zip">
			<cfoutput query="pdfdir">
				<cfif DateDiff("h",pdfdir.datelastmodified,now()) gt 1>
					<cffile action="DELETE" file="#dir#\#pdfdir.name#">
				</cfif>
			</cfoutput>
		<cfcatch>
		</cfcatch>
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
	
	
	
	
	<cffunction name="downloadCurbSearch" access="remote" returnType="any" returnFormat="plain" output="false">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Download Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cftry>
		
			<cfset sfx = timeformat(now(),"HHmmss")>


        <!--- joe hu 4/30/2019 ---- add zip_code geocode  --->
           
           
			<cfset columns = "Curb Ramp No,Council District,Site No,Intersection Corner,Primary Street,Secondary Street,Design Finish Date,Construction Completed Date,Designed By,Priority No,Type, Zip Code, Geocoded">
			
			<cfquery name="setSearch" dbtype="query">
			SELECT ramp_no,council_district as cd, location_no as site,intersection_corner,primary_street,secondary_street,design_finish_date,construction_completed_date,
			designed_by,priority_no,type_description, zip_code, Geocoded FROM session.curbQuery
			</cfquery>
			
         <!---  ---- end ------  joe hu 4/30/2019 ---- add zip_code geocode  --->
            
            
			<cfset filename = expandPath("../downloads/CurbRampRepairSearch_#sfx#.xls")>
			<cfspreadsheet action="write" query="setSearch" filename="#filename#" overwrite="true">
			<cfset s = spreadsheetNew("CurbRampSearchResults","no")>
			
			<cfset spreadsheetAddRow(s, columns)>
			<cfset spreadsheetFormatRow(s,{fgcolor="pale_blue",alignment="left"},1)>
			<cfset spreadsheetAddRows(s, setSearch)>
			
			<!--- <cfset spreadsheetsetActiveSheet(s,"AssessmentTracking")> --->
			<cfset spreadsheetWrite(s, filename, true)>
			
			<cfzip file="#replace(filename,'xls','zip','ALL')#" source="#filename#" overwrite = "yes">
			
			<cfset data.result = "Success">
			<cfset data.filename = replace(filename,'xls','zip','ALL')>
			
			<cfset data.href = request.url & "downloads/CurbRampRepairSearch_" & sfx & ".zip">
			
		<cfcatch>
			<cfset data.result = " - Download Failed: Database Error.">
		</cfcatch>
		</cftry>
		
		<cftry>
			<cfset dir = request.dir & "\downloads">
			<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.xls">
			<cfoutput query="pdfdir">
				<cfif DateDiff("h",pdfdir.datelastmodified,now()) gt 1>
					<cffile action="DELETE" file="#dir#\#pdfdir.name#">
				</cfif>
			</cfoutput>
			<cfdirectory action="LIST" directory="#dir#" name="pdfdir" filter="*.zip">
			<cfoutput query="pdfdir">
				<cfif DateDiff("h",pdfdir.datelastmodified,now()) gt 1>
					<cffile action="DELETE" file="#dir#\#pdfdir.name#">
				</cfif>
			</cfoutput>
		<cfcatch>
		</cfcatch>
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	</cffunction>
	
	
	
	
	<cffunction name="doDeleteAttachment" access="remote" returnType="any" returnFormat="plain" output="false">
	
		<cfset var data = {}>
	
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Delete Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
	
		<cfset f = request.PDFlocation & dir & "\" & file_name>
		<cftry>
			<cffile action="DELETE" file="#f#">
			<cfset data.response = "Success">
		<cfcatch>
			<cfset data.response = "Failed">
		</cfcatch>
		</cftry>
		<!--- <cfset data.f = f> --->

		<cfset data = serializeJSON(data)>
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    <cfreturn data>

	</cffunction>
	
	
	
	<cffunction name="chkLogin" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="user" required="true">
		<cfargument name="password" required="true">
	
		<cfset var data = {}>
	
		<cfquery name="login_chk" datasource="#request.sqlconn#" dbtype="ODBC">
		SELECT * FROM dbo.tblUsers WHERE user_name = '#user#' AND user_password = '#password#' AND user_level >= 0
		</cfquery>	
		
		<cfif login_chk.recordcount gt 0>
			<cfset session.userid = login_chk.user_name>
			<cfset session.password = login_chk.user_password>
			<cfset session.agency = login_chk.user_agency>
			<cfset session.user_level = login_chk.user_level>
			<cfset session.user_power = login_chk.user_power>
			<cfset session.user_num = login_chk.user_id>
			<cfset session.user_cert = login_chk.user_cert>
			<cfset session.user_ufd = login_chk.user_ufd>
			<cfset session.user_report = login_chk.user_report>
			<cfset data.response = "Success">
			
			<cfset session.token = CreateUUID()>
			<cfquery name="login_update" datasource="#request.sqlconn#" dbtype="ODBC">
			UPDATE dbo.tblUsers SET user_token = '#session.token#' WHERE user_id = #session.user_num#
			</cfquery>
			
		<cfelse>
			<cfquery name="login_chk" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT * FROM dbo.tblUsers WHERE user_name = '#user#' AND user_level >= 0
			</cfquery>
			<cfif login_chk.recordcount is 0>
				<cfset chk_log = "log">
			<cfelse>
				<cfset chk_log = "pass">
			</cfif>
			<cfset data.response = "Failed">
			<cfset data.chk = chk_log>
		</cfif>

		<cfset data = serializeJSON(data)>
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    <cfreturn data>

	</cffunction>
	
	<cffunction name="doLogoff" access="remote" returnType="any" returnFormat="plain" output="false">
	
		<cfset var data = {}>
	
		<cflock timeout=20 scope="Session" type="Exclusive">
		
			<cfquery name="login_update" datasource="#request.sqlconn#" dbtype="ODBC">
			UPDATE dbo.tblUsers SET user_token = NULL WHERE user_id = #session.user_num#
			</cfquery>
		
	  		<cfset StructDelete(Session, "userid")>
			<cfset StructDelete(Session, "password")>
			<cfset StructDelete(Session, "agency")>
			<cfset StructDelete(Session, "user_level")>
			<cfset StructDelete(Session, "user_power")>
			<cfset StructDelete(Session, "user_cert")>
			<cfset StructDelete(Session, "user_ufd")>
			<cfset StructDelete(Session, "user_report")>
			<cfset StructDelete(Session, "user_num")>
			<cfset StructDelete(Session, "arrSUMAll")>
			<cfset StructDelete(Session, "arrWWUsers")>
			<cfset StructDelete(Session, "siteQuery")>
			<cfinclude template="../deleteClientVariables.cfm">
		</cflock>
		
		<cfset data.response = "Success">

		<cfset data = serializeJSON(data)>
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    <cfreturn data>

	</cffunction>
	
	
    
    
    
    
    
    
    
    <!--- ------------ joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
    
    
      <!--- joe hu update below section --------   --->
    
    
    
    
    
    
    
	
	
	<cffunction name="updateTrees2" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		
        
        
        
        
        
        
        
        
		
		
		<!--- <cftry> --->
		
		
		<!--- UPDATE the first table --->
        
        
		<cfset tbl = "tblTreeSiteInfo">
		<cfquery name="chkTree" datasource="#request.sqlconn#">
		SELECT * FROM dbo.#tbl# WHERE location_no = #sw_id#
		</cfquery>
		<cfset tree_trc = replace(tree_trc,"'","''","ALL")>
		<cfset tree_tpc = replace(tree_tpc,"'","''","ALL")>
        
        
        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
        <cfset tree_trc_type = replace(tree_trc_type,"'","''","ALL")>
        <cfset tree_tpc_type = replace(tree_tpc_type,"'","''","ALL")>
        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
        
        
        
        <!--- ------------ joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
        <!--- cfset tree_trpsc = replace(tree_trpsc,"'","''","ALL")   --->
        <!--- ----- End ------- joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
        
        
		<!--- <cfset tree_twc = replace(tree_twc,"'","''","ALL")> --->
		<cfset tree_trn = replace(tree_trn,"'","''","ALL")>
		<cfset tree_arbname = replace(tree_arbname,"'","''","ALL")>

		<cfif tree_lock is not ""><cfset tree_lock = 1></cfif>
		
		<cfset tree_preinspby = replace(trim(tree_preinspby),"'","''","ALL")>
        <cfset replant_tree_postinspby = replace(trim(replant_tree_postinspby),"'","''","ALL")>
        
		<cfset tree_postinspby = replace(trim(tree_postinspby),"'","''","ALL")>
		<cfif tree_readytp is not ""><cfset tree_readytp = 1></cfif>
		
        
        
		<cfif trim(tree_preinspdt) is ""><cfset tree_preinspdt = "NULL"></cfif>
		<cfif tree_preinspdt is not "NULL">
			<cfset arrDT = listtoarray(tree_preinspdt,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset tree_preinspdt = createODBCDate(dt)>
		</cfif>
        
        
        <cfif trim(replant_tree_postinspdt) is ""><cfset replant_tree_postinspdt = "NULL"></cfif>
		<cfif replant_tree_postinspdt is not "NULL">
			<cfset arrDT = listtoarray(replant_tree_postinspdt,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset replant_tree_postinspdt = createODBCDate(dt)>
		</cfif>
        
        
        
        
        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
        <cfif trim(tree_tpc_dt) is ""><cfset tree_tpc_dt = "NULL"></cfif>
		<cfif tree_tpc_dt is not "NULL">
			<cfset arrDT = listtoarray(tree_tpc_dt,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset tree_tpc_dt = createODBCDate(dt)>
		</cfif>
        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
        
        
        
        
        
		<cfif trim(tree_postinspdt) is ""><cfset tree_postinspdt = "NULL"></cfif>
		<cfif tree_postinspdt is not "NULL">
			<cfset arrDT = listtoarray(tree_postinspdt,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset tree_postinspdt = createODBCDate(dt)>
		</cfif>
		

		<cfif chkTree.recordcount is 0>
			
			<cfquery name="addTreeInfo" datasource="#request.sqlconn#">
			INSERT INTO dbo.#tbl#
			( 
				Location_No,
			    <cfif trim(tree_trc) is not "">Tree_Removal_Contractor,</cfif>
			    <cfif trim(tree_tpc) is not "">Tree_Planting_Contractor,</cfif>
                
                
                
                <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                <cfif trim(tree_trc_type) is not "">Tree_removal_contractor_type,</cfif>
			    <cfif trim(tree_tpc_type) is not "">Tree_planting_contractor_type,</cfif>
                <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                
                
                
                <!--- ------------ joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
                <!--- <cfif trim(tree_trpsc) is not "">Root_Pruning_Contractor,</cfif>    --->
                <!--- ------ end ------ joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
                
                
			    <!--- <cfif trim(tree_twc) is not "">Tree_Watering_Contractor,</cfif> --->
			    <cfif trim(tree_trn) is not "">Tree_Removal_Notes,</cfif>
				<cfif trim(tree_arbname) is not "">Arborist_Name,</cfif>
				<cfif trim(tree_lock) is not "">Root_Barrier_Lock,</cfif>
				<cfif trim(tree_preinspby) is not "">Pre_Inspection_By,</cfif>
				<cfif trim(tree_preinspdt) is not "">Pre_Inspection_Date,</cfif>
                <cfif trim(replant_tree_postinspby) is not "">Replant_Post_Inspection_By,</cfif>
				<cfif trim(replant_tree_postinspdt) is not "">Replant_Post_Inspection_Date,</cfif>
                
                
                <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                <cfif trim(tree_tpc_dt) is not "">Tree_planting_assigned_contractor_date,</cfif>
                
                
                
				<cfif trim(tree_postinspby) is not "">Post_Inspection_By,</cfif>
				<cfif trim(tree_postinspdt) is not "">Post_Inspection_Date,</cfif>
				<cfif trim(tree_readytp) is not "">Ready_To_Plant,</cfif>
				User_ID,
				Creation_Date
			) 
			Values 
			(
				#sw_id#,
			    <cfif trim(tree_trc) is not "">'#PreserveSingleQuotes(tree_trc)#',</cfif>
			    <cfif trim(tree_tpc) is not "">'#PreserveSingleQuotes(tree_tpc)#',</cfif>
                
                <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                <cfif trim(tree_trc_type) is not "">#tree_trc_type#,</cfif>
			    <cfif trim(tree_tpc_type) is not "">#tree_tpc_type#,</cfif>
                
                
                
                
                
                
                <!--- ------------ joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
                <!--- <cfif trim(tree_trpsc) is not "">'#PreserveSingleQuotes(tree_trpsc)#',</cfif> --->
                <!--- ------- End ----- joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
                
			    <!--- <cfif trim(tree_twc) is not "">'#PreserveSingleQuotes(tree_twc)#',</cfif> --->
			    <cfif trim(tree_trn) is not "">'#PreserveSingleQuotes(tree_trn)#',</cfif>
				<cfif trim(tree_arbname) is not "">'#PreserveSingleQuotes(tree_arbname)#',</cfif>
				<cfif trim(tree_lock) is not "">#tree_lock#,</cfif>
				<cfif trim(tree_preinspby) is not "">'#PreserveSingleQuotes(tree_preinspby)#',</cfif>
				<cfif trim(tree_preinspdt) is not "">#tree_preinspdt#,</cfif>
                
                
                <cfif trim(replant_tree_postinspby) is not "">'#PreserveSingleQuotes(replant_tree_postinspby)#',</cfif>
				<cfif trim(replant_tree_postinspdt) is not "">#replant_tree_postinspdt#,</cfif>
                
                 <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                <cfif trim(tree_tpc_dt) is not "">#tree_tpc_dt#,</cfif>
                
                
                
                
				<cfif trim(tree_postinspby) is not "">'#PreserveSingleQuotes(tree_postinspby)#',</cfif>
				<cfif trim(tree_postinspdt) is not "">#tree_postinspdt#,</cfif>
				<cfif trim(tree_readytp) is not "">#tree_readytp#,</cfif>
				#session.user_num#,
				#CreateODBCDateTime(Now())#
			)
			</cfquery>
		
		<cfelse>
		
			<cfquery name="updateTreeInfo" datasource="#request.sqlconn#">
			UPDATE dbo.#tbl# SET
			Tree_Removal_Contractor = <cfif tree_trc is "">NULL<cfelse>'#PreserveSingleQuotes(tree_trc)#'</cfif>,
			Tree_Planting_Contractor = <cfif tree_tpc is "">NULL<cfelse>'#PreserveSingleQuotes(tree_tpc)#'</cfif>,
            
            
            
            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
            Tree_removal_contractor_type = <cfif tree_trc_type is "">NULL<cfelse>#tree_trc_type#</cfif>,
			Tree_Planting_Contractor_type = <cfif tree_tpc_type is "">NULL<cfelse>#tree_tpc_type#</cfif>,
            
            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
            
            
            <!--- ------------ joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
         <!---    Root_Pruning_Contractor = <cfif tree_trpsc is "">NULL<cfelse>'#PreserveSingleQuotes(tree_trpsc)#'</cfif>,   --->
            <!--- ------- End ----- joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
            
			<!--- Tree_Watering_Contractor = <cfif tree_twc is "">NULL<cfelse>'#PreserveSingleQuotes(tree_twc)#'</cfif>, --->
			Tree_Removal_Notes = <cfif tree_trn is "">NULL<cfelse>'#PreserveSingleQuotes(tree_trn)#'</cfif>,
			Arborist_Name = <cfif tree_arbname is "">NULL<cfelse>'#PreserveSingleQuotes(tree_arbname)#'</cfif>,
			Root_Barrier_Lock = <cfif tree_lock is "">NULL<cfelse>#tree_lock#</cfif>,
			Pre_Inspection_By = <cfif tree_preinspby is "">NULL<cfelse>'#PreserveSingleQuotes(tree_preinspby)#'</cfif>,
			Pre_Inspection_Date = <cfif tree_preinspdt is "">NULL<cfelse>#tree_preinspdt#</cfif>,
            Replant_Post_Inspection_By = <cfif replant_tree_postinspby is "">NULL<cfelse>'#PreserveSingleQuotes(replant_tree_postinspby)#'</cfif>,
			Replant_Post_Inspection_Date = <cfif replant_tree_postinspdt is "">NULL<cfelse>#replant_tree_postinspdt#</cfif>,
            
            
            
            
             <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
            Tree_planting_assigned_contractor_date = <cfif tree_tpc_dt is "">NULL<cfelse>#tree_tpc_dt#</cfif>,
            
            
			Post_Inspection_By = <cfif tree_postinspby is "">NULL<cfelse>'#PreserveSingleQuotes(tree_postinspby)#'</cfif>,
			Post_Inspection_Date = <cfif tree_postinspdt is "">NULL<cfelse>#tree_postinspdt#</cfif>,
			Ready_To_Plant = <cfif tree_readytp is "">NULL<cfelse>#tree_readytp#</cfif>,
			User_ID = #session.user_num#,
			Modified_Date = #CreateODBCDateTime(Now())#
			WHERE Location_No = #sw_id#
			</cfquery>
			
		</cfif>
        
        
        
        
        
        
		
		<!--- UPDATE the second table --->
		
		<cfset tbl = "tblTreeList">
		<cfset tbl2 = "tblTreeSIRs">
		
		<cfset cnt = trees_sir_cnt>
		<cfset lt_total = 0>
		<cfset gt_total = 0>
		
		<cfset data.adds = arrayNew(1)>
		
		<cfloop index="i" from="1" to="#cnt#">
		
			<cfset sir = evaluate("sir_" & i)>
			<cfset sirdt = evaluate("sirdt_" & i)>
            
            
            
            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
            <cfset sirBPWapprovalRequired = evaluate("sirBPWapprovalRequired_" & i)>
            <cfset sirBPWapprovaldt = evaluate("sirBPWapprovaldt_" & i)>
            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
            
            
            
            
			<cfset grp = i>
			
			<cfset add_cnt = evaluate("tr_add_cnt_" & i)>
			<cfset rmv_cnt = evaluate("tr_rmv_cnt_" & i)>
            <cfset stumprmv_cnt = evaluate("tr_stumprmv_cnt_" & i)>
            <!--- ------------ joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
            <cfset root_cnt = evaluate("tr_root_cnt_" & i)>
            <!--- ------- End ----- joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
			
			<cfif trim(sir) is ""><cfset sir = "NULL"></cfif>
			<cfif trim(sirdt) is ""><cfset sirdt = "NULL"></cfif>
            
            
            
            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
            
            <cfif trim(sirBPWapprovalRequired) is "on"><cfset sirBPWapprovalRequired = 1><cfelse><cfset sirBPWapprovalRequired = 0></cfif>
            
            <cfif trim(sirBPWapprovaldt) is ""><cfset sirBPWapprovaldt = "NULL"></cfif>
            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
            
            
            
			<cfset sir = replace(sir,"'","''","ALL")>
			
			<cfif sirdt is not "NULL">
				<cfset arrDT = listtoarray(sirdt,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sirdt = createODBCDate(dt)>
			</cfif>
            
            
            
            
            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
            <cfif sirBPWapprovaldt is not "NULL">
				<cfset arrDT = listtoarray(sirBPWapprovaldt,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset sirBPWapprovaldt = createODBCDate(dt)>
			</cfif>
            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
            
            
            
			
			<cfif rmv_cnt gt 0>
				
				<cfloop index="j" from="1" to="#rmv_cnt#">
				
					<cfset tmp = evaluate("trdia_" & i & "_" & j)>
					<cfif tmp gt 24><cfset gt_total = gt_total + 1><cfelse><cfset lt_total = lt_total + 1></cfif>
					
					<cfquery name="chkTree" datasource="#request.sqlconn#">
					SELECT * FROM dbo.#tbl# WHERE location_no = #sw_id# AND group_no = #i# AND tree_no = #j# AND action_type = 0 AND deleted <> 1
					</cfquery>
					
					<cfset tree = j>
					<cfset trdia = evaluate("trdia_" & i & "_" & j)>
					<cfset trpidt = evaluate("trpidt_" & i & "_" & j)>
					<cfset trtrdt = evaluate("trtrdt_" & i & "_" & j)>
					<cfset traddr = evaluate("traddr_" & i & "_" & j)>
					<cfset trspecies = evaluate("trspecies_" & i & "_" & j)>
					<cfset trtype = evaluate("trtype_" & i & "_" & j)>
                    
                     <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    <cfset trExistingCondition = evaluate("trExistingCondition_" & i & "_" & j)>
                    <cfset trAttemptedPreservation = evaluate("trAttemptedPreservation_" & i & "_" & j)>
                     <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    
					<cfset trnote = evaluate("trnote_" & i & "_" & j)>
					
					<cfif trim(trpidt) is ""><cfset trpidt = "NULL"></cfif>
					<cfif trim(trtrdt) is ""><cfset trtrdt = "NULL"></cfif>
					<cfif trim(traddr) is ""><cfset traddr = "NULL"></cfif>
					<cfif trim(trspecies) is ""><cfset trspecies = "NULL"></cfif>
					<cfif trim(trtype) is ""><cfset trtype = "NULL"></cfif>
                    
                    
                    
                     <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    <cfif trim(trExistingCondition) is ""><cfset trExistingCondition = "NULL"></cfif>
                    <cfif trim(trAttemptedPreservation) is ""><cfset trAttemptedPreservation = "NULL"></cfif>
                     <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                     
                     
                     
                     
                    
					<cfif trim(trnote) is ""><cfset trnote = "NULL"></cfif>
					
					<cfset traddr = replace(traddr,"'","''","ALL")>
					<cfset trspecies = ucase(replace(trspecies,"'","''","ALL"))>
					<cfset trnote = replace(trnote,"'","''","ALL")>
					
					<cfif trpidt is not "NULL">
						<cfset arrDT = listtoarray(trpidt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset trpidt = createODBCDate(dt)>
					</cfif>
					<cfif trtrdt is not "NULL">
						<cfset arrDT = listtoarray(trtrdt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset trtrdt = createODBCDate(dt)>
					</cfif>
					
					<cfif chkTree.recordcount is 0>
					
						<cfquery name="addTreeList" datasource="#request.sqlconn#">
						INSERT INTO dbo.#tbl#
						( 
							Location_No,
							Group_No,
							Tree_No,
                            
						    <cfif trim(sir) is not "NULL">SIR_No,</cfif>
						    <cfif trim(sirdt) is not "NULL">SIR_Date,</cfif>
                            
                            
                            
                            
                            
                            
						    <cfif trim(trdia) is not "NULL">Tree_Size,</cfif>
						    <cfif trim(trpidt) is not "NULL">Permit_Issuance_Date,</cfif>
							<cfif trim(trtrdt) is not "NULL">Tree_Removal_Date,</cfif>
                            
						    <cfif trim(traddr) is not "NULL">Address,</cfif>
						    <cfif trim(trspecies) is not "NULL">Species,</cfif>
							<cfif trim(trtype) is not "NULL">Type,</cfif>
                            
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            <cfif trim(trExistingCondition) is not "NULL">Removals_Existing_Tree_Condition,</cfif>
                            <cfif trim(trAttemptedPreservation) is not "NULL">Attempted_Tree_Preservation,</cfif>
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            
							<cfif trim(trnote) is not "NULL">Note,</cfif>
							Action_Type,
							Deleted,
							User_ID,
							Creation_Date
						) 
						Values 
						(
							#sw_id#,
							#grp#,
							#tree#,
                            
						    <cfif trim(sir) is not "NULL">'#PreserveSingleQuotes(sir)#',</cfif>
						    <cfif trim(sirdt) is not "NULL">#sirdt#,</cfif>
                            
                            
						    <cfif trim(trdia) is not "NULL">#trdia#,</cfif>
						    <cfif trim(trpidt) is not "NULL">#trpidt#,</cfif>
							<cfif trim(trtrdt) is not "NULL">#trtrdt#,</cfif>
                            
						    <cfif trim(traddr) is not "NULL">'#PreserveSingleQuotes(traddr)#',</cfif>
						    <cfif trim(trspecies) is not "NULL">'#PreserveSingleQuotes(trspecies)#',</cfif>
							<cfif trim(trtype) is not "NULL">#trtype#,</cfif>
                            
                            
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            <cfif trim(trExistingCondition) is not "NULL">#trExistingCondition#,</cfif>
                            <cfif trim(trAttemptedPreservation) is not "NULL">#trAttemptedPreservation#,</cfif>
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            
                            
							<cfif trim(trnote) is not "NULL">'#PreserveSingleQuotes(trnote)#',</cfif>
							0,
							0,
							#session.user_num#,
                            
                            <!---   Joe hu,   2019 March 13,  both works cold fusion function works, native SQL server function works too 
						 	#CreateODBCDateTime(Now())# 
                           #Now()#   --->
                           
                           
                           GETDATE()
                            
						)
						</cfquery>

					<cfelse>
					
						<cfquery name="updateTreeInfo" datasource="#request.sqlconn#">
						UPDATE dbo.#tbl# SET
						SIR_No = <cfif sir is "NULL">NULL<cfelse>'#PreserveSingleQuotes(sir)#'</cfif>,
						SIR_Date = <cfif sirdt is "NULL">NULL<cfelse>#sirdt#</cfif>,
						Tree_Size = <cfif trdia is "NULL">NULL<cfelse>#trdia#</cfif>,
						Permit_Issuance_Date = <cfif trpidt is "NULL">NULL<cfelse>#trpidt#</cfif>,
						Tree_Removal_Date = <cfif trtrdt is "NULL">NULL<cfelse>#trtrdt#</cfif>,
						Address = <cfif traddr is "NULL">NULL<cfelse>'#PreserveSingleQuotes(traddr)#'</cfif>,
						Species = <cfif trspecies is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trspecies)#'</cfif>,
						Type = <cfif trtype is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trtype)#'</cfif>,
                        
                        
                        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                       Removals_Existing_Tree_Condition = <cfif trExistingCondition is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trExistingCondition)#'</cfif>,
                        Attempted_Tree_Preservation = <cfif trAttemptedPreservation is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trAttemptedPreservation)#'</cfif>,
                        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                        
                        
						Note = <cfif trnote is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trnote)#'</cfif>,
						User_ID = #session.user_num#,
						Modified_Date = #CreateODBCDateTime(Now())#
						WHERE Location_No = #sw_id#	AND Group_No = #grp# AND Tree_No = #tree# AND Action_Type = 0 AND Deleted <> 1
						</cfquery>
					
					</cfif>
                    

				</cfloop>
				
			</cfif>
			
            
            
            
            
            
            <!--- --------------------------- joe hu 6/11/2019 ------------- add stump removals --------------------------  --->
            
            
            	<cfif stumprmv_cnt gt 0>
				
				<cfloop index="j" from="1" to="#stumprmv_cnt#">
				
					<cfset tmp = evaluate("tsdia_" & i & "_" & j)>
					<cfif tmp gt 24><cfset gt_total = gt_total + 1><cfelse><cfset lt_total = lt_total + 1></cfif>
					
					<cfquery name="chkTree" datasource="#request.sqlconn#">
					SELECT * FROM dbo.#tbl# WHERE location_no = #sw_id# AND group_no = #i# AND tree_no = #j# AND action_type = 3 AND deleted <> 1
					</cfquery>
					
					<cfset tree = j>
					<cfset tsdia = evaluate("tsdia_" & i & "_" & j)>
					<cfset tspidt = evaluate("tspidt_" & i & "_" & j)>
					<cfset tssrdt = evaluate("tssrdt_" & i & "_" & j)>
					<cfset tsaddr = evaluate("tsaddr_" & i & "_" & j)>
					 <!---<cfset tsspecies = evaluate("tsspecies_" & i & "_" & j)>  --->
                     
                     <cfset tsparkway = evaluate("tsparkway_" & i & "_" & j)> 
                     <cfset tssubpos = evaluate("tssubpos_" & i & "_" & j)> 
                     
                     
					<cfset tstype = evaluate("tstype_" & i & "_" & j)>
                    
                     <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    <cfset tsExistingCondition = evaluate("tsExistingCondition_" & i & "_" & j)>
                  <!---  <cfset tsAttemptedPreservation = evaluate("tsAttemptedPreservation_" & i & "_" & j)>  --->
                     <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    
					<cfset tsnote = evaluate("tsnote_" & i & "_" & j)>
					
					<cfif trim(tspidt) is ""><cfset tspidt = "NULL"></cfif>
					<cfif trim(tssrdt) is ""><cfset tssrdt = "NULL"></cfif>
					<cfif trim(tsaddr) is ""><cfset tsaddr = "NULL"></cfif>
                    
				<!---	<cfif trim(tsspecies) is ""><cfset tsspecies = "NULL"></cfif>  --->
                    
                     <cfif trim(tsparkway) is ""><cfset tsparkway = "NULL"></cfif>
                     <cfif trim(tssubpos) is ""><cfset tssubpos = "NULL"></cfif>
                    
                    
					<cfif trim(tstype) is ""><cfset tstype = "NULL"></cfif>
                    
                    
                    
                     <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    <cfif trim(tsExistingCondition) is ""><cfset tsExistingCondition = "NULL"></cfif>
                <!---    <cfif trim(tsAttemptedPreservation) is ""><cfset tsAttemptedPreservation = "NULL"></cfif>  --->
                     <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                     
                     
                     
                     
                    
					<cfif trim(tsnote) is ""><cfset tsnote = "NULL"></cfif>
					
					<cfset tsaddr = replace(tsaddr,"'","''","ALL")>
				 <!---	<cfset tsspecies = ucase(replace(tsspecies,"'","''","ALL"))>     --->
                    
                    
                    <cfset tsparkway = ucase(replace(tsparkway,"'","''","ALL"))>
                    <cfset tssubpos = ucase(replace(tssubpos,"'","''","ALL"))>
                    
                    
                    
					<cfset tsnote = replace(tsnote,"'","''","ALL")>
					
					<cfif tspidt is not "NULL">
						<cfset arrDT = listtoarray(tspidt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset tspidt = createODBCDate(dt)>
					</cfif>
					<cfif tssrdt is not "NULL">
						<cfset arrDT = listtoarray(tssrdt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset tssrdt = createODBCDate(dt)>
					</cfif>
					
					<cfif chkTree.recordcount is 0>
					
						<cfquery name="addTreeList" datasource="#request.sqlconn#">
						INSERT INTO dbo.#tbl#
						( 
							Location_No,
							Group_No,
							Tree_No,
                            
						    <cfif trim(sir) is not "NULL">SIR_No,</cfif>
						    <cfif trim(sirdt) is not "NULL">SIR_Date,</cfif>
                            
                            
                            
                            
                            
                            
						    <cfif trim(tsdia) is not "NULL">Tree_Size,</cfif>
						    <cfif trim(tspidt) is not "NULL">Permit_Issuance_Date,</cfif>
							<cfif trim(tssrdt) is not "NULL">Stump_Removal_Date,</cfif>
                            
						    <cfif trim(tsaddr) is not "NULL">Address,</cfif>
						  <!---  <cfif trim(tsspecies) is not "NULL">Species,</cfif>  --->
                            
                            
                            <cfif trim(tsparkway) is not "NULL">PARKWAY_TREEWELL_SIZE,</cfif>
                            <cfif trim(tssubpos) is not "NULL">SUB_POSITION,</cfif>
                            
                            
							<cfif trim(tstype) is not "NULL">Type,</cfif>
                            
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            <cfif trim(tsExistingCondition) is not "NULL">Removals_Existing_Tree_Condition,</cfif>
                         <!---     <cfif trim(tsAttemptedPreservation) is not "NULL">Attempted_Tree_Preservation,</cfif>   --->
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            
							<cfif trim(tsnote) is not "NULL">Note,</cfif>
							Action_Type,
							Deleted,
							User_ID,
							Creation_Date
						) 
						Values 
						(
							#sw_id#,
							#grp#,
							#tree#,
                            
						    <cfif trim(sir) is not "NULL">'#PreserveSingleQuotes(sir)#',</cfif>
						    <cfif trim(sirdt) is not "NULL">#sirdt#,</cfif>
                            
                            
						    <cfif trim(tsdia) is not "NULL">#tsdia#,</cfif>
						    <cfif trim(tspidt) is not "NULL">#tspidt#,</cfif>
							<cfif trim(tssrdt) is not "NULL">#tssrdt#,</cfif>
                            
						    <cfif trim(tsaddr) is not "NULL">'#PreserveSingleQuotes(tsaddr)#',</cfif>
                            
						  <!---  <cfif trim(tsspecies) is not "NULL">'#PreserveSingleQuotes(tsspecies)#',</cfif>   --->
                            <cfif trim(tsparkway) is not "NULL">'#PreserveSingleQuotes(tsparkway)#',</cfif>
                            <cfif trim(tssubpos) is not "NULL">'#PreserveSingleQuotes(tssubpos)#',</cfif>
                            
                            
							<cfif trim(tstype) is not "NULL">#tstype#,</cfif>
                            
                            
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            <cfif trim(tsExistingCondition) is not "NULL">#tsExistingCondition#,</cfif>
                        <!---     <cfif trim(tsAttemptedPreservation) is not "NULL">#tsAttemptedPreservation#,</cfif>   --->
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            
                            
							<cfif trim(tsnote) is not "NULL">'#PreserveSingleQuotes(tsnote)#',</cfif>
							3,
							0,
							#session.user_num#,
                            
                            <!---   Joe hu,   2019 March 13,  both works cold fusion function works, native SQL server function works too 
						 	#CreateODBCDateTime(Now())# 
                           #Now()#   --->
                           
                           
                           GETDATE()
                            
						)
						</cfquery>

					<cfelse>
					
						<cfquery name="updateTreeInfo" datasource="#request.sqlconn#">
						UPDATE dbo.#tbl# SET
						SIR_No = <cfif sir is "NULL">NULL<cfelse>'#PreserveSingleQuotes(sir)#'</cfif>,
						SIR_Date = <cfif sirdt is "NULL">NULL<cfelse>#sirdt#</cfif>,
						Tree_Size = <cfif tsdia is "NULL">NULL<cfelse>#tsdia#</cfif>,
						Permit_Issuance_Date = <cfif tspidt is "NULL">NULL<cfelse>#tspidt#</cfif>,
						Stump_Removal_Date = <cfif tssrdt is "NULL">NULL<cfelse>#tssrdt#</cfif>,
						Address = <cfif tsaddr is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tsaddr)#'</cfif>,
                        
                        
					<!---	Species = <cfif tsspecies is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tsspecies)#'</cfif>,  --->
                        
                        PARKWAY_TREEWELL_SIZE = <cfif tsparkway is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tsparkway)#'</cfif>,
                        SUB_POSITION = <cfif tssubpos is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tssubpos)#'</cfif>,
                        
						Type = <cfif tstype is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tstype)#'</cfif>,
                        
                        
                        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                       Removals_Existing_Tree_Condition = <cfif tsExistingCondition is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tsExistingCondition)#'</cfif>,
                 <!---       Attempted_Tree_Preservation = <cfif tsAttemptedPreservation is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tsAttemptedPreservation)#'</cfif>,  --->
                        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                        
                        
						Note = <cfif tsnote is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tsnote)#'</cfif>,
						User_ID = #session.user_num#,
						Modified_Date = #CreateODBCDateTime(Now())#
						WHERE Location_No = #sw_id#	AND Group_No = #grp# AND Tree_No = #tree# AND Action_Type = 3 AND Deleted <> 1
						</cfquery>
					
					</cfif>
                    

				</cfloop>
				
			</cfif>
            
            <!---  end --------------------------- joe hu 6/11/2019 ------------- add stump removals --------------------------  --->
            
            
            
            
            
            
            
            
            
            
            
            
            
            
            
			<cfif add_cnt gt 0>
				
				<cfloop index="j" from="1" to="#add_cnt#">
				
					<cfquery name="chkTree" datasource="#request.sqlconn#">
					SELECT * FROM dbo.#tbl# WHERE location_no = #sw_id# AND group_no = #i# AND tree_no = #j# AND action_type = 1 AND deleted <> 1
					</cfquery>
					
					<cfset tree = j>
					<cfset tpdia = evaluate("tpdia_" & i & "_" & j)>
					<cfset tppidt = evaluate("tppidt_" & i & "_" & j)>
                    
                    <cfset tpadt = evaluate("tpadt_" & i & "_" & j)>
                    
                    
					<cfset tptrdt = evaluate("tptrdt_" & i & "_" & j)>
					<cfset tpswdt = evaluate("tpswdt_" & i & "_" & j)>
					<cfset tpewdt = evaluate("tpewdt_" & i & "_" & j)>
					<cfset tpaddr = evaluate("tpaddr_" & i & "_" & j)>
					<cfset tpspecies = evaluate("tpspecies_" & i & "_" & j)>
					<cfset tpoffsite = evaluate("tpoffsite_" & i & "_" & j)>
                    <cfset tpgatorbags = evaluate("tpgatorbags_" & i & "_" & j)>
                    
                    
					<cfset tptype = evaluate("tptype_" & i & "_" & j)>
                    
            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->         
                    
                    
                    <cfset tpPlantedCondition = evaluate("tpPlantedCondition_" & i & "_" & j)>
                    
             <!--- ---------- end ----------  joe hu  Feb 2019 multiple update --------------------  --->       
                    
                    
                    
					<cfset tpparkway = evaluate("tpparkway_" & i & "_" & j)>
					<cfset tpoverhead = evaluate("tpoverhead_" & i & "_" & j)>
					<cfset tpsubpos = evaluate("tpsubpos_" & i & "_" & j)>
					<cfset tppostinspect = evaluate("tppostinspect_" & i & "_" & j)>
                    
                   
                    
                    
                    
                    
                    
                    
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->    
					<cfset tppassedpostinspection = evaluate("tppassedpostinspection_" & i & "_" & j)>
                    
                    
                    
					<cfset tpnote = evaluate("tpnote_" & i & "_" & j)>
					
					<cfif trim(tppidt) is ""><cfset tppidt = "NULL"></cfif>
                    <cfif trim(tpadt) is ""><cfset tpadt = "NULL"></cfif>
                    
                    
                    
                    
					<cfif trim(tptrdt) is ""><cfset tptrdt = "NULL"></cfif>
					<cfif trim(tpswdt) is ""><cfset tpswdt = "NULL"></cfif>
					<cfif trim(tpewdt) is ""><cfset tpewdt = "NULL"></cfif>
					<cfif trim(tpaddr) is ""><cfset tpaddr = "NULL"></cfif>
					<cfif trim(tpspecies) is ""><cfset tpspecies = "NULL"></cfif>
					<cfif trim(tpoffsite) is "on"><cfset tpoffsite = 1><cfelse><cfset tpoffsite = 0></cfif>
                    <cfif trim(tpgatorbags) is "on"><cfset tpgatorbags = 1><cfelse><cfset tpgatorbags = 0></cfif>
                    
					<cfif trim(tptype) is ""><cfset tptype = "NULL"></cfif>
					
                    
                      <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->   
                    
                    <cfif trim(tpPlantedCondition) is ""><cfset tpPlantedCondition = "NULL"></cfif>
                     <!--- ---------- end ----------  joe hu  Feb 2019 multiple update --------------------  --->  
                    
                    
					<cfif trim(tpparkway) is ""><cfset tpparkway = "NULL"></cfif>
					<cfif trim(tpoverhead) is "on"><cfset tpoverhead = 1><cfelse><cfset tpoverhead = 0></cfif>
					<cfif trim(tpsubpos) is ""><cfset tpsubpos = "NULL"></cfif>
					<cfif trim(tppostinspect) is "on"><cfset tppostinspect = 1><cfelse><cfset tppostinspect = 0></cfif>
                    
                    
                    
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->   
                    <cfif trim(tppassedpostinspection) is "on"><cfset tppassedpostinspection = 1><cfelse><cfset tppassedpostinspection = 0></cfif>
                    
                    
                    
					<cfif trim(tpnote) is ""><cfset tpnote = "NULL"></cfif>
					
					<cfset tpaddr = replace(tpaddr,"'","''","ALL")>
					<cfset tpspecies = ucase(replace(tpspecies,"'","''","ALL"))>
					<cfset tpparkway = replace(tpparkway,"'","''","ALL")>
					<cfset tpsubpos = ucase(replace(tpsubpos,"'","''","ALL"))>
					<cfset tpnote = replace(tpnote,"'","''","ALL")>
					
					<cfif tppidt is not "NULL">
						<cfset arrDT = listtoarray(tppidt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset tppidt = createODBCDate(dt)>
					</cfif>
                    
                    
                    
                    <cfif tpadt is not "NULL">
						<cfset arrDT = listtoarray(tpadt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset tpadt = createODBCDate(dt)>
					</cfif>
                    
                    
                    
                    
					<cfif tptrdt is not "NULL">
						<cfset arrDT = listtoarray(tptrdt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset tptrdt = createODBCDate(dt)>
					</cfif>
					<cfif tpswdt is not "NULL">
						<cfset arrDT = listtoarray(tpswdt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset tpswdt = createODBCDate(dt)>
					</cfif>
					<cfif tpewdt is not "NULL">
						<cfset arrDT = listtoarray(tpewdt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset tpewdt = createODBCDate(dt)>
					</cfif>
					
					<cfif chkTree.recordcount is 0>
					
						<cfquery name="addTreeList" datasource="#request.sqlconn#">
						INSERT INTO dbo.#tbl#
						( 
							Location_No,
							Group_No,
							Tree_No,
						    <cfif trim(sir) is not "NULL">SIR_No,</cfif>
						    <cfif trim(sirdt) is not "NULL">SIR_Date,</cfif>
						    <cfif trim(tpdia) is not "NULL">Tree_Box_Size,</cfif>
						    <cfif trim(tppidt) is not "NULL">Permit_Issuance_Date,</cfif>
                            
                            
                             <cfif trim(tpadt) is not "NULL">Assigned_Date,</cfif>
                            
                            
							<cfif trim(tptrdt) is not "NULL">Tree_Planting_Date,</cfif>
							<cfif trim(tpswdt) is not "NULL">Start_Watering_Date,</cfif>
							<cfif trim(tpewdt) is not "NULL">End_Watering_Date,</cfif>
						    <cfif trim(tpaddr) is not "NULL">Address,</cfif>
						    <cfif trim(tpspecies) is not "NULL">Species,</cfif>
							<cfif trim(tpoffsite) is not "NULL">Offsite,</cfif>
                            <cfif trim(tpgatorbags) is not "NULL">Gator_Bags,</cfif>
                            
                            
							<cfif trim(tptype) is not "NULL">Type,</cfif>
                            
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            <cfif trim(tpPlantedCondition) is not "NULL">Planted_Tree_Condition,</cfif>
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            
                            
                            
							<cfif trim(tpparkway) is not "NULL">Parkway_Treewell_Size,</cfif>
							<cfif trim(tpoverhead) is not "NULL">Overhead_Wires,</cfif>
							<cfif trim(tpsubpos) is not "NULL">Sub_Position,</cfif>
							<cfif trim(tppostinspect) is not "NULL">Post_Inspected,</cfif>
                            
                            
                            
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            <cfif trim(tppassedpostinspection) is not "NULL">Passed_Post_Inspection,</cfif>
                            
                            
                            
							<cfif trim(tpnote) is not "NULL">Note,</cfif>
							Action_Type,
							Deleted,
							User_ID,
							Creation_Date
						) 
						Values 
						(
							#sw_id#,
							#grp#,
							#tree#,
						    <cfif trim(sir) is not "NULL">'#PreserveSingleQuotes(sir)#',</cfif>
						    <cfif trim(sirdt) is not "NULL">#sirdt#,</cfif>
						    <cfif trim(tpdia) is not "NULL">#tpdia#,</cfif>
						    <cfif trim(tppidt) is not "NULL">#tppidt#,</cfif>
                            
                            <cfif trim(tpadt) is not "NULL">#tpadt#,</cfif>
                            
							<cfif trim(tptrdt) is not "NULL">#tptrdt#,</cfif>
							<cfif trim(tpswdt) is not "NULL">#tpswdt#,</cfif>
							<cfif trim(tpewdt) is not "NULL">#tpewdt#,</cfif>
						    <cfif trim(tpaddr) is not "NULL">'#PreserveSingleQuotes(tpaddr)#',</cfif>
						    <cfif trim(tpspecies) is not "NULL">'#PreserveSingleQuotes(tpspecies)#',</cfif>
							<cfif trim(tpoffsite) is not "NULL">#tpoffsite#,</cfif>
                            <cfif trim(tpgatorbags) is not "NULL">#tpgatorbags#,</cfif>
                            
							<cfif trim(tptype) is not "NULL">#tptype#,</cfif>
                            
                            
                            
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            <cfif trim(tpPlantedCondition) is not "NULL">#tpPlantedCondition#,</cfif>
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            
                            
                            
							<cfif trim(tpparkway) is not "NULL">'#PreserveSingleQuotes(tpparkway)#',</cfif>
							<cfif trim(tpoverhead) is not "NULL">#tpoverhead#,</cfif>
							<cfif trim(tpsubpos) is not "NULL">'#PreserveSingleQuotes(tpsubpos)#',</cfif>
							<cfif trim(tppostinspect) is not "NULL">#tppostinspect#,</cfif>
                            
                            
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            <cfif trim(tppassedpostinspection) is not "NULL">#tppassedpostinspection#,</cfif>
                            
                            
                            
                            
							<cfif trim(tpnote) is not "NULL">'#PreserveSingleQuotes(tpnote)#',</cfif>
							1,
							0,
							#session.user_num#,
							#CreateODBCDateTime(Now())#
						)
						</cfquery>

					<cfelse>
					
						<cfquery name="updateTreeInfo" datasource="#request.sqlconn#">
						UPDATE dbo.#tbl# SET
						SIR_No = <cfif sir is "NULL">NULL<cfelse>'#PreserveSingleQuotes(sir)#'</cfif>,
						SIR_Date = <cfif sirdt is "NULL">NULL<cfelse>#sirdt#</cfif>,
						Tree_Box_Size = <cfif tpdia is "NULL">NULL<cfelse>#tpdia#</cfif>,
						Permit_Issuance_Date = <cfif tppidt is "NULL">NULL<cfelse>#tppidt#</cfif>,
                        
                        
                        Assigned_Date = <cfif tpadt is "NULL">NULL<cfelse>#tpadt#</cfif>,
                        
						Tree_Planting_Date = <cfif tptrdt is "NULL">NULL<cfelse>#tptrdt#</cfif>,
						Start_Watering_Date = <cfif tpswdt is "NULL">NULL<cfelse>#tpswdt#</cfif>,
						End_Watering_Date = <cfif tpewdt is "NULL">NULL<cfelse>#tpewdt#</cfif>,
						Address = <cfif tpaddr is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tpaddr)#'</cfif>,
						Species = <cfif tpspecies is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tpspecies)#'</cfif>,
						Gator_Bags = <cfif tpoffsite is "NULL">NULL<cfelse>#tpgatorbags#</cfif>,
                        
						Type = <cfif tptype is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tptype)#'</cfif>,
                        
                        
                        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                        Planted_Tree_Condition = <cfif tpPlantedCondition is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tpPlantedCondition)#'</cfif>,
                        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                        
                        
						Parkway_Treewell_Size = <cfif tpparkway is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tpparkway)#'</cfif>,
						Overhead_Wires = <cfif tpoverhead is "NULL">NULL<cfelse>#tpoverhead#</cfif>,
						Sub_Position = <cfif tpsubpos is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tpsubpos)#'</cfif>,
						Post_Inspected = <cfif tppostinspect is "NULL">NULL<cfelse>#tppostinspect#</cfif>,
                        
                        
                        
                        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                        Passed_Post_Inspection = <cfif tppassedpostinspection is "NULL">NULL<cfelse>#tppassedpostinspection#</cfif>,
                        
                        
                        
                        
                        
						Note = <cfif tpnote is "NULL">NULL<cfelse>'#PreserveSingleQuotes(tpnote)#'</cfif>,
						User_ID = #session.user_num#,
						Modified_Date = #CreateODBCDateTime(Now())#
						WHERE Location_No = #sw_id#	AND Group_No = #grp# AND Tree_No = #tree# AND Action_Type = 1 AND Deleted <> 1
						</cfquery>
					
					</cfif>
					
					<!--- retrieve treeid for planting icon in app --->
					<cfquery name="getTreeID" datasource="#request.sqlconn#">
					SELECT id FROM dbo.#tbl# WHERE Location_No = #sw_id# AND Group_No = #grp# AND Tree_No = #tree# AND action_type = 1 AND Deleted <> 1
					</cfquery>
					<cfquery name="getCount" datasource="ufd_inventory_spatial">
					SELECT objectid FROM #request.tree_tbl# WHERE srp_tree_id = #getTreeID.id#
					</cfquery>
					<cfset t = 0><cfif getCount.recordcount gt 0><cfset t = 1></cfif>
					
                    <!--- ---------------- joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
					<cfset go = arrayAppend(data.adds, sw_id & "|" & grp & "|" & tree & "|" & getTreeID.id & "|" & t & "|planting")>
                    <!--- --------  End    --------- joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->

				</cfloop>
				
			</cfif>
            
            
            
            
            
            
            
            
            
            
             <!--- ------------ joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
            
            
            <cfif root_cnt gt 0>
				
				<cfloop index="j" from="1" to="#root_cnt#">
				
					<cfquery name="chkTree" datasource="#request.sqlconn#">
					SELECT * FROM dbo.#tbl# WHERE location_no = #sw_id# AND group_no = #i# AND tree_no = #j# AND action_type = 2 AND deleted <> 1
					</cfquery>
					
					<cfset tree = j>
					<cfset trpsdia = evaluate("trpsdia_" & i & "_" & j)>
					<cfset trpspidt = evaluate("trpspidt_" & i & "_" & j)>
				    <cfset trpstrdt = evaluate("trpstrdt_" & i & "_" & j)>   
					<cfset trpsrpdt = evaluate("trpsrpdt_" & i & "_" & j)>
					
					<!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->    
					<cfset trpsfurpr = evaluate("trpsfurpr_" & i & "_" & j)>
					
					<cfset trpsfurpdt = evaluate("trpsfurpdt_" & i & "_" & j)>
                    
                    
                    
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->    
					<cfset trpsct = evaluate("trpsct_" & i & "_" & j)>
                    
                    
                    
                    
                    
					<cfset trpsaddr = evaluate("trpsaddr_" & i & "_" & j)>
					<cfset trpsspecies = evaluate("trpsspecies_" & i & "_" & j)>
					
				 <!---	<cfset trpsoffsite = evaluate("trpsoffsite_" & i & "_" & j)>   --->
					
					<cfset trpstype = evaluate("trpstype_" & i & "_" & j)>
                    
                    
                    
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    <cfset trpsExistingCondition = evaluate("trpsExistingCondition_" & i & "_" & j)>
                    <cfset trpsPreservationAlternative = evaluate("trpsPreservationAlternative_" & i & "_" & j)>
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    
                    
                    
					<cfset trpsparkway = evaluate("trpsparkway_" & i & "_" & j)>
                    
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    <cfset trpslf = evaluate("trpslf_" & i & "_" & j)>
                    
                    
					
				 <!---	<cfset trpsoverhead = evaluate("trpsoverhead_" & i & "_" & j)>   --->
					
					
					<cfset trpssubpos = evaluate("trpssubpos_" & i & "_" & j)>
					
					
				 <!---	<cfset trpspostinspect = evaluate("trpspostinspect_" & i & "_" & j)>   --->
					
					<cfset trpsnote = evaluate("trpsnote_" & i & "_" & j)>
					
					<cfif trim(trpspidt) is ""><cfset trpspidt = "NULL"></cfif>
				    <cfif trim(trpstrdt) is ""><cfset trpstrdt = "NULL"></cfif> 
					<cfif trim(trpsrpdt) is ""><cfset trpsrpdt = "NULL"></cfif>
					
					
					
                    
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->   
                    <cfif trim(trpsfurpr) is "on"><cfset trpsfurpr = 1><cfelse><cfset trpsfurpr = 0></cfif>
                    
                    
					
					<cfif trim(trpsfurpdt) is ""><cfset trpsfurpdt = "NULL"></cfif>
                    
                    
                    
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->   
                    <cfif trim(trpsct) is "on"><cfset trpsct = 1><cfelse><cfset trpsct = 0></cfif>
                    
                    
                    
                    
					<cfif trim(trpsaddr) is ""><cfset trpsaddr = "NULL"></cfif>
					<cfif trim(trpsspecies) is ""><cfset trpsspecies = "NULL"></cfif>
				<!---	<cfif trim(trpsoffsite) is "on"><cfset trpsoffsite = 1><cfelse><cfset trpsoffsite = 0></cfif>                       --->
					<cfif trim(trpstype) is ""><cfset trpstype = "NULL"></cfif>
                    
                    
                    
                    
                    
                    
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    <cfif trim(trpsExistingCondition) is ""><cfset trpsExistingCondition = "NULL"></cfif>
                    <cfif trim(trpsPreservationAlternative) is ""><cfset trpsPreservationAlternative = "NULL"></cfif>
                    
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    
                    
                    
                    
                    
					
					<cfif trim(trpsparkway) is ""><cfset trpsparkway = "NULL"></cfif>
                    
                    
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    <cfif trim(trpslf) is ""><cfset trpslf = "NULL"></cfif>
                    
                    
                    
				<!---	<cfif trim(trpsoverhead) is "on"><cfset trpsoverhead = 1><cfelse><cfset trpsoverhead = 0></cfif>                       --->
					<cfif trim(trpssubpos) is ""><cfset trpssubpos = "NULL"></cfif>
				<!---	<cfif trim(trpspostinspect) is "on"><cfset trpspostinspect = 1><cfelse><cfset trpspostinspect = 0></cfif>                  --->
					<cfif trim(trpsnote) is ""><cfset trpsnote = "NULL"></cfif>
					
					<cfset trpsaddr = replace(trpsaddr,"'","''","ALL")>
					<cfset trpsspecies = ucase(replace(trpsspecies,"'","''","ALL"))>
                    
                    
					<cfset trpsparkway = replace(trpsparkway,"'","''","ALL")>
                    
					<!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
					<cfset trpslf = replace(trpslf,"'","''","ALL")>
                    
                    
                    
					
					<cfset trpssubpos = ucase(replace(trpssubpos,"'","''","ALL"))>
					<cfset trpsnote = replace(trpsnote,"'","''","ALL")>
					
					<cfif trpspidt is not "NULL">
						<cfset arrDT = listtoarray(trpspidt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset trpspidt = createODBCDate(dt)>
					</cfif>
					<cfif trpstrdt is not "NULL">
						<cfset arrDT = listtoarray(trpstrdt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset trpstrdt = createODBCDate(dt)>
					</cfif>
					<cfif trpsrpdt is not "NULL">
						<cfset arrDT = listtoarray(trpsrpdt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset trpsrpdt = createODBCDate(dt)>
					</cfif>
					<cfif trpsfurpdt is not "NULL">
						<cfset arrDT = listtoarray(trpsfurpdt,"/")>
						<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
						<cfset trpsfurpdt = createODBCDate(dt)>
					</cfif>
					
					<cfif chkTree.recordcount is 0>
					
						<cfquery name="addTreeList" datasource="#request.sqlconn#">
						INSERT INTO dbo.#tbl#
						( 
							Location_No,
							Group_No,
							Tree_No,
						    <cfif trim(sir) is not "NULL">SIR_No,</cfif>
						    <cfif trim(sirdt) is not "NULL">SIR_Date,</cfif>
						    <cfif trim(trpsdia) is not "NULL">Tree_Box_Size,</cfif>
						    <cfif trim(trpspidt) is not "NULL">Permit_Issuance_Date,</cfif>
							<cfif trim(trpstrdt) is not "NULL">Tree_Planting_Date,</cfif>
							<cfif trim(trpsrpdt) is not "NULL">Root_Pruning_Date,</cfif>
                            
							
							
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            <cfif trim(trpsfurpr) is not "NULL">Follow_Up_Root_Prune_Required,</cfif>
                            
                            
							
							<cfif trim(trpsfurpdt) is not "NULL">Follow_Up_Root_Pruning_Date,</cfif>
						    
                            
                            
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            <cfif trim(trpsct) is not "NULL">Canopy_Trim,</cfif>
                            
                            
							
							
							<cfif trim(trpsaddr) is not "NULL">Address,</cfif>
						    <cfif trim(trpsspecies) is not "NULL">Species,</cfif>
						<!---	<cfif trim(trpsoffsite) is not "NULL">Offsite,</cfif>   --->
							<cfif trim(trpstype) is not "NULL">Type,</cfif>
                            
                            
                            
                            
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            <cfif trim(trpsExistingCondition) is not "NULL">Preservation_Existing_Tree_Condition,</cfif>
                            <cfif trim(trpsPreservationAlternative) is not "NULL">Preservation_Alternative,</cfif>
                            
                            <cfif trim(trpslf) is not "NULL">Linear_Ft_of_Root_Pruning,</cfif>
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            
                            
                            
                            
                            
                            
                            
							<cfif trim(trpsparkway) is not "NULL">Parkway_Treewell_Size,</cfif>
                            
                            
                            
                            
                            
                            
						<!---	<cfif trim(trpsoverhead) is not "NULL">Overhead_Wires,</cfif>     --->
							<cfif trim(trpssubpos) is not "NULL">Sub_Position,</cfif>
						<!---	<cfif trim(trpspostinspect) is not "NULL">Post_Inspected,</cfif>    --->
							<cfif trim(trpsnote) is not "NULL">Note,</cfif>
							Action_Type,
							Deleted,
							User_ID,
							Creation_Date
						) 
						Values 
						(
							#sw_id#,
							#grp#,
							#tree#,
						    <cfif trim(sir) is not "NULL">'#PreserveSingleQuotes(sir)#',</cfif>
						    <cfif trim(sirdt) is not "NULL">#sirdt#,</cfif>
						    <cfif trim(trpsdia) is not "NULL">#trpsdia#,</cfif>
						    <cfif trim(trpspidt) is not "NULL">#trpspidt#,</cfif>
							<cfif trim(trpstrdt) is not "NULL">#trpstrdt#,</cfif>
							<cfif trim(trpsrpdt) is not "NULL">#trpsrpdt#,</cfif>
                            
                            
                            
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            <cfif trim(trpsfurpr) is not "NULL">#trpsfurpr#,</cfif>
                            
                            
                            
							<cfif trim(trpsfurpdt) is not "NULL">#trpsfurpdt#,</cfif>
						    
							
                            
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            <cfif trim(trpsct) is not "NULL">#trpsct#,</cfif>
                            
                            
							
							
							<cfif trim(trpsaddr) is not "NULL">'#PreserveSingleQuotes(trpsaddr)#',</cfif>
						    <cfif trim(trpsspecies) is not "NULL">'#PreserveSingleQuotes(trpsspecies)#',</cfif>
						<!---	<cfif trim(trpsoffsite) is not "NULL">#trpsoffsite#,</cfif>                               --->
							<cfif trim(trpstype) is not "NULL">#trpstype#,</cfif>
                            
                            
                            
                            
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            <cfif trim(trpsExistingCondition) is not "NULL">#trpsExistingCondition#,</cfif>
                            <cfif trim(trpsPreservationAlternative) is not "NULL">#trpsPreservationAlternative#,</cfif>
                            <cfif trim(trpslf) is not "NULL">'#PreserveSingleQuotes(trpslf)#',</cfif>
                            <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                            
                            
                            
                            
                            
							<cfif trim(trpsparkway) is not "NULL">'#PreserveSingleQuotes(trpsparkway)#',</cfif>
						<!---	<cfif trim(trpsoverhead) is not "NULL">#trpsoverhead#,</cfif>                              --->
							<cfif trim(trpssubpos) is not "NULL">'#PreserveSingleQuotes(trpssubpos)#',</cfif>
						<!---	<cfif trim(trpspostinspect) is not "NULL">#trpspostinspect#,</cfif>                         --->
							<cfif trim(trpsnote) is not "NULL">'#PreserveSingleQuotes(trpsnote)#',</cfif>
							2,
							0,
							#session.user_num#,
							#CreateODBCDateTime(Now())#
						)
						</cfquery>

					<cfelse>
					
						<cfquery name="updateTreeInfo" datasource="#request.sqlconn#">
						UPDATE dbo.#tbl# SET
						SIR_No = <cfif sir is "NULL">NULL<cfelse>'#PreserveSingleQuotes(sir)#'</cfif>,
						SIR_Date = <cfif sirdt is "NULL">NULL<cfelse>#sirdt#</cfif>,
						Tree_Box_Size = <cfif trpsdia is "NULL">NULL<cfelse>#trpsdia#</cfif>,
						Permit_Issuance_Date = <cfif trpspidt is "NULL">NULL<cfelse>#trpspidt#</cfif>,
						Tree_Planting_Date = <cfif trpstrdt is "NULL">NULL<cfelse>#trpstrdt#</cfif>,
						Root_Pruning_Date = <cfif trpsrpdt is "NULL">NULL<cfelse>#trpsrpdt#</cfif>,
                        
                        
                        
                        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                        Follow_Up_Root_Prune_Required = <cfif trpsfurpr is "NULL">NULL<cfelse>#trpsfurpr#</cfif>,
                        
                        
                        
						Follow_Up_Root_Pruning_Date = <cfif trpsfurpdt is "NULL">NULL<cfelse>#trpsfurpdt#</cfif>,
						
                        
                        
                        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                        Canopy_Trim = <cfif trpsct is "NULL">NULL<cfelse>#trpsct#</cfif>,
                        
                        
                        
                        
                        
                        
                        Address = <cfif trpsaddr is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trpsaddr)#'</cfif>,
						Species = <cfif trpsspecies is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trpsspecies)#'</cfif>,
					<!---	Offsite = <cfif trpsoffsite is "NULL">NULL<cfelse>#trpsoffsite#</cfif>,                                                --->
						Type = <cfif trpstype is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trpstype)#'</cfif>,
                        
                        
                        
                        
                        
                        
                        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                        Preservation_Existing_Tree_Condition = <cfif trpsExistingCondition is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trpsExistingCondition)#'</cfif>,
                        Preservation_Alternative = <cfif trpsPreservationAlternative is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trpsPreservationAlternative)#'</cfif>,
                        Linear_Ft_of_Root_Pruning = <cfif trpslf is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trpslf)#'</cfif>,
                        <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                        
                        
                        
                        
                        
                        
						Parkway_Treewell_Size = <cfif trpsparkway is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trpsparkway)#'</cfif>,
					<!---	Overhead_Wires = <cfif trpsoverhead is "NULL">NULL<cfelse>#trpsoverhead#</cfif>,                                       --->
						Sub_Position = <cfif trpssubpos is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trpssubpos)#'</cfif>,
					<!---	Post_Inspected = <cfif trpspostinspect is "NULL">NULL<cfelse>#trpspostinspect#</cfif>,                                 --->
						Note = <cfif trpsnote is "NULL">NULL<cfelse>'#PreserveSingleQuotes(trpsnote)#'</cfif>,
						User_ID = #session.user_num#,
						Modified_Date = #CreateODBCDateTime(Now())#
						WHERE Location_No = #sw_id#	AND Group_No = #grp# AND Tree_No = #tree# AND Action_Type = 2 AND Deleted <> 1
						</cfquery>
                        
					
					</cfif>
					
					<!--- retrieve treeid for root pruning icon in app --->
					<cfquery name="getTreeID" datasource="#request.sqlconn#">
					SELECT id FROM dbo.#tbl# WHERE Location_No = #sw_id# AND Group_No = #grp# AND Tree_No = #tree# AND action_type = 2 AND Deleted <> 1
					</cfquery>
					<cfquery name="getCount" datasource="ufd_inventory_spatial">
					SELECT objectid FROM #request.tree_tbl# WHERE srp_tree_id = #getTreeID.id#
					</cfquery>
					<cfset t = 0><cfif getCount.recordcount gt 0><cfset t = 1></cfif>
					
					<cfset go = arrayAppend(data.adds, sw_id & "|" & grp & "|" & tree & "|" & getTreeID.id & "|" & t & "|root_pruning")>

				</cfloop>
				
			</cfif>
            
            
            
             <!--- --------  End    --------- joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
            
            
            
            
            
            
			
			<!--- Delete From treeList table --->
			
            <cfquery name="delTree" datasource="#request.sqlconn#">
			UPDATE dbo.#tbl# SET deleted = 1
			WHERE location_no = #sw_id# AND group_no = #i# AND tree_no > #add_cnt# AND action_type = 1 AND Deleted <> 1
			</cfquery>
            
            
            <!--- -------- --------- joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
            <cfquery name="delTree" datasource="#request.sqlconn#">
			UPDATE dbo.#tbl# SET deleted = 1
			WHERE location_no = #sw_id# AND group_no = #i# AND tree_no > #root_cnt# AND action_type = 2 AND Deleted <> 1
			</cfquery>
            <!--- --------  End    --------- joe hu ------ 8/7/18  ---------- add root pruning ---------------  --->
            
            
            
            
            
            <!--- ---- joe hu 6-19-2019 add stump removal --->
            <cfquery name="delTree" datasource="#request.sqlconn#">
			UPDATE dbo.#tbl# SET deleted = 1
			WHERE location_no = #sw_id# AND group_no = #i# AND tree_no > #stumprmv_cnt# AND action_type = 3 AND Deleted <> 1
			</cfquery>
           <!--- end ---- joe hu 6-19-2019 add stump removal --->
            
            
            
            
            
			<cfquery name="delTree" datasource="#request.sqlconn#">
			UPDATE dbo.#tbl# SET deleted = 1
			WHERE location_no = #sw_id# AND group_no = #i# AND tree_no > #rmv_cnt# AND action_type = 0 AND Deleted <> 1
			</cfquery>
			
			
			<!--- Add to SIR Table --->
			<cfquery name="chkSIR" datasource="#request.sqlconn#">
			SELECT * FROM dbo.#tbl2# WHERE location_no = #sw_id# AND group_no = #i# AND deleted <> 1
			</cfquery>
			
			<cfif chkSIR.recordcount is 0>
			
				<cfquery name="addSIR" datasource="#request.sqlconn#">
				INSERT INTO dbo.#tbl2#
				( 
					Location_No,
					Group_No,
				    <cfif trim(sir) is not "NULL">SIR_No,</cfif>
                    
                    <cfif trim(sirdt) is not "NULL">SIR_Date,</cfif>
                    
                    
                    
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                     <cfif trim(sirBPWapprovalRequired) is not "NULL">sir_BPWapprovalRequired,</cfif>
				     <cfif trim(sirBPWapprovaldt) is not "NULL">sir_BPWapproval_date,</cfif>
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    
                    
                    
                    
                    
                    
                    
                    
					Deleted,
					User_ID,
					Creation_Date
				) 
				Values 
				(
					#sw_id#,
					#grp#,
				    <cfif trim(sir) is not "NULL">'#PreserveSingleQuotes(sir)#',</cfif>
				    <cfif trim(sirdt) is not "NULL">#sirdt#,</cfif>
                    
                    
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    <cfif trim(sirBPWapprovalRequired) is not "NULL">#sirBPWapprovalRequired#,</cfif>
                    <cfif trim(sirBPWapprovaldt) is not "NULL">#sirBPWapprovaldt#,</cfif>
                    <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                    
                    
                    
					0,
					#session.user_num#,
					#CreateODBCDateTime(Now())#
				)
				</cfquery>
			
			<cfelse>
			
				<cfquery name="updateSIR" datasource="#request.sqlconn#">
				UPDATE dbo.#tbl2# SET
				SIR_No = <cfif sir is "NULL">NULL<cfelse>'#PreserveSingleQuotes(sir)#'</cfif>,
				SIR_Date = <cfif sirdt is "NULL">NULL<cfelse>#sirdt#</cfif>,
                
                
                
                <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                
                sir_BPWapprovalRequired = <cfif sirBPWapprovalRequired is "NULL">NULL<cfelse>#sirBPWapprovalRequired#</cfif>,
                sir_BPWapproval_date = <cfif sirBPWapprovaldt is "NULL">NULL<cfelse>#sirBPWapprovaldt#</cfif>,
                <!--- ---------- joe hu  Feb 2019 multiple update --------------------  --->
                
                
                
                
                
				User_ID = #session.user_num#,
				Modified_Date = #CreateODBCDateTime(Now())#
				WHERE Location_No = #sw_id#	AND Group_No = #grp# AND Deleted <> 1
				</cfquery>
				
			</cfif>
			
			
			
		</cfloop>
        
        
		
		<!--- Delete From SIR and treeList tables --->
		<cfquery name="delTree" datasource="#request.sqlconn#">
		UPDATE dbo.#tbl2# SET deleted = 1
		WHERE location_no = #sw_id# AND group_no > #cnt# AND Deleted <> 1
		</cfquery>
		<cfquery name="delTree" datasource="#request.sqlconn#">
		UPDATE dbo.#tbl# SET deleted = 1
		WHERE location_no = #sw_id# AND group_no = #i# AND Deleted <> 1
		</cfquery>
		
	
		<!--- <cfdump var="#lt_total#"><br>
		<cfdump var="#gt_total#"><br> --->
		
		<!--- UPDATE the third table --->
		<cfset tbl = "tblEngineeringEstimate">
		<cfquery name="chkTree" datasource="#request.sqlconn#">
		SELECT * FROM dbo.#tbl# WHERE location_no = #sw_id#
		</cfquery>
		
		<cfset arrTrees = arrayNew(1)>
		<cfset arrTrees[1] = "TREE_ROOT_PRUNING_L_SHAVING__PER_TREE___">
		<cfset arrTrees[2] = "TREE_CANOPY_PRUNING__PER_TREE___">
		<cfset arrTrees[3] = "INSTALL_ROOT_CONTROL_BARRIER_">
		<cfset arrTrees[4] = "EXISTING_STUMP_REMOVAL_">
		<cfset arrTrees[5] = "FURNISH_AND_PLANT_24_INCH_BOX_SIZE_TREE_">
		<cfset arrTrees[6] = "WATER_TREE__UP_TO_30_GALLONS_l_WEEK___FOR_ONE_MONTH_">
		
		<cfif chkTree.recordcount is 0>
		
			<cfquery name="getFlds" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT COLUMN_NAME, sort_order, sort_group
			FROM vwSortOrder
			ORDER BY full_sort, sort_group, sort_order
			</cfquery>
			
			<cfset qstr = "INSERT INTO dbo.#tbl# (Location_No,">
			<cfset wstr = " VALUES (#sw_id#,">
			<cfloop query="getFlds">
			
				<cfset fld = replace(column_name,"_UNITS","","ALL")>
				<cfquery name="getDefault" datasource="#request.sqlconn#" dbtype="ODBC">
				SELECT * FROM tblEstimateDefaults WHERE fieldname = '#fld#'
				</cfquery>
				
				<cfset qstr = qstr & "#fld#_UNITS,#fld#_QUANTITY,#fld#_UNIT_PRICE,">
				
				<cfset u=evaluate("getDefault.UNITS")>
                
				<cfset p=evaluate("getDefault.PRICE")>
				<cfif p is ""><cfset p = 0></cfif>	
				
				<cfset wstr = wstr & "'#u#',0,#p#,">
			
			</cfloop>
		
			<!--- <cfdump var="#qstr#">
			<cfdump var="#wstr#"> --->
			
			<cfset qstr = qstr & "Creation_Date)">
			<cfset wstr = wstr & "#CreateODBCDateTime(Now())#)">
			<cfset qstr = qstr & wstr>
		
			<cfquery name="addTreeInfo" datasource="#request.sqlconn#">
			#preservesinglequotes(qstr)#
			</cfquery>
		
		</cfif>
		
		<cfquery name="updateTreeInfo" datasource="#request.sqlconn#">
                    UPDATE dbo.#tbl# 
                    SET
                                TREE_AND_STUMP_REMOVAL__6_INCH_TO_24_INCH_DIAMETER___QUANTITY = #lt_total#,
                                
                                <cfset data.TREE_REMOVAL__6_INCH_TO_24_INCH_DIAMETER___QUANTITY = lt_total>
                                
                                TREE_AND_STUMP_REMOVAL__OVER_24_INCH_DIAMETER___QUANTITY = #gt_total#,
                                
                                <cfset data.TREE_REMOVAL__OVER_24_INCH_DIAMETER___QUANTITY = gt_total>
                                
                                <cfloop index="i" from="1" to="#arrayLen(arrTrees)#">
                                    <cfset v = evaluate("tree_#arrTrees[i]#UNITS")>
                                    #arrTrees[i]#UNITS = '#v#',
                                    <cfset v = trim(evaluate("tree_#arrTrees[i]#QUANTITY"))>
                                    <cfset data[arrTrees[i] & "QUANTITY"] = v>
                                    #arrTrees[i]#QUANTITY = <cfif v is "">0<cfelse>#v#</cfif>,
                                </cfloop>
                                
                                User_ID = #session.user_num#,
                                Modified_Date = #CreateODBCDateTime(Now())#
                                
                    WHERE Location_No = #sw_id#
        
		</cfquery>
		
        
		<cfset data.result = "Success">
		
		<cfset data.id = session.token>
		
		<!--- <cfcatch>
			<cfset data.result = "- Site Update Failed: Database Error.">
		</cfcatch>	
		</cftry> --->
		
		<!--- <cfdump var="#arguments#"> --->
		<!--- <cfdump var="#data#">
		<cfabort> --->

		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	<cffunction name="addCurbRamp" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="cr_no" required="true">
		<cfargument name="cr_primary" required="true">
		<cfargument name="cr_type" required="true">
		<cfargument name="cr_secondary" required="true">
		<cfargument name="cr_cd" required="true">
		<cfargument name="cr_zip" required="true">
		<cfargument name="cr_corner" required="true">
		<cfargument name="cr_priority" required="true">
		<cfargument name="cr_logdate" required="true">
		<cfargument name="cr_assessed" required="true">
		<cfargument name="cr_existing" required="true">
		<cfargument name="cr_compliant" required="true">
		<cfargument name="cr_applicable" required="true">
		<cfargument name="cr_repairs" required="true">
		<cfargument name="cr_design" required="true">
		<cfargument name="cr_design_sdt" required="true">
		<cfargument name="cr_design_fdt" required="true">
		<cfargument name="cr_designby" required="true">
		<cfargument name="cr_assessed_dt" required="true">
		<cfargument name="cr_assessedby" required="true">
		<cfargument name="cr_dotcoord" required="true">
		<cfargument name="cr_con_cdt" required="true">
		<cfargument name="cr_utility" required="true">
		<cfargument name="cr_minor" required="true">
		<cfargument name="cr_notes" required="true">
		<cfargument name="cr_sno" required="true">
		<cfargument name="cr_excptn_notes" required="true">
		
		<cfif isdefined("cr_bsl") is false><cfset cr_bsl = ""><cfelse><cfset cr_bsl = 1></cfif>
		<cfif isdefined("cr_dwp") is false><cfset cr_dwp = ""><cfelse><cfset cr_dwp = 1></cfif>
		<cfif isdefined("cr_bos") is false><cfset cr_bos = ""><cfelse><cfset cr_bos = 1></cfif>
		<cfif isdefined("cr_dot") is false><cfset cr_dot = ""><cfelse><cfset cr_dot = 1></cfif>
		<cfif isdefined("cr_other") is false><cfset cr_other = ""></cfif>
		<cfif isdefined("cr_truncate") is false><cfset cr_truncate = ""><cfelse><cfset cr_truncate = 1></cfif>
		<cfif isdefined("cr_lip") is false><cfset cr_lip = ""><cfelse><cfset cr_lip = 1></cfif>
		<cfif isdefined("cr_scoring") is false><cfset cr_scoring = ""><cfelse><cfset cr_scoring = 1></cfif>
		<cfif isdefined("cr_excptn") is false><cfset cr_excptn = ""><cfelse><cfset cr_excptn = 1></cfif>

		<cfset var data = {}>
		
		<cfset tbl = "tblCurbRamps">
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Curb Ramp Creation Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<!--- Retrieve New NoteID --->
		<cfquery name="chkDuplicate" datasource="#request.sqlconn#">
		SELECT count(*) as cnt FROM #tbl# WHERE ramp_no = #cr_no#
		</cfquery>
		
		<cfif chkDuplicate.cnt gt 0>
			<!--- Retrieve Highest Ramp Number --->
			<cfquery name="getMax" datasource="#request.sqlconn#">
			SELECT (max(ramp_no)+1) as num FROM #tbl#
			</cfquery>
			<!--- <cfset data.result = "- Curb Ramp Creation Failed: Duplicate Curb Ramp Number.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort> --->
			<cfset cr_no = getMax.num>
		</cfif>
			
		<cftry>
			
			<cfif cr_logdate is not "">
				<cfset arrDT = listtoarray(cr_logdate,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset cr_logdate = createODBCDate(dt)>
			</cfif>
			
			<cfif cr_design_sdt is not "">
				<cfset arrDT = listtoarray(cr_design_sdt,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset cr_design_sdt = createODBCDate(dt)>
			</cfif>
			
			<cfif cr_design_fdt is not "">
				<cfset arrDT = listtoarray(cr_design_fdt,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset cr_design_fdt = createODBCDate(dt)>
			</cfif>
			
			<cfif cr_assessed_dt is not "">
				<cfset arrDT = listtoarray(cr_assessed_dt,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset cr_assessed_dt = createODBCDate(dt)>
			</cfif>
			
			<cfif cr_con_cdt is not "">
				<cfset arrDT = listtoarray(cr_con_cdt,"/")>
				<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
				<cfset cr_con_cdt = createODBCDate(dt)>
			</cfif>

			<cfset cr_primary = replace(cr_primary,"'","''","ALL")>
			<cfset cr_secondary = replace(cr_secondary,"'","''","ALL")>
			<cfset cr_corner = replace(cr_corner,"'","''","ALL")>
			<cfset cr_designby = replace(cr_designby,"'","''","ALL")>
			<cfset cr_assessedby = replace(cr_assessedby,"'","''","ALL")>
			<cfset cr_other = replace(cr_other,"'","''","ALL")>
			<cfset cr_notes = replace(cr_notes,"'","''","ALL")>
			<cfset cr_excptn_notes = replace(cr_excptn_notes,"'","''","ALL")>
			
			<cfquery name="addFeature" datasource="#request.sqlconn#">
			INSERT INTO dbo.#tbl#
			( 
				Ramp_No,
			    <cfif trim(cr_primary) is not "">Primary_Street,</cfif>
			    <cfif trim(cr_type) is not "">Type,</cfif>
			    <cfif trim(cr_secondary) is not "">Secondary_Street,</cfif>
			    <cfif trim(cr_cd) is not "">Council_District,</cfif>
				<cfif trim(cr_zip) is not "">Zip_Code,</cfif>
				<cfif trim(cr_corner) is not "">Intersection_Corner,</cfif>
				<cfif trim(cr_priority) is not "">Priority_No,</cfif>
				<cfif trim(cr_logdate) is not "">Date_Logged,</cfif>
				<cfif trim(cr_assessed) is not "">Field_Assessed,</cfif>
				<cfif trim(cr_existing) is not "">Existing_Ramp,</cfif>
				<cfif trim(cr_compliant) is not "">ADA_Compliant,</cfif>
				<cfif trim(cr_applicable) is not "">Standard_Plan_Applicable,</cfif>
				<cfif trim(cr_repairs) is not "">Repairs_Required,</cfif>
				<cfif trim(cr_design) is not "">Design_Required,</cfif>
				<cfif trim(cr_design_sdt) is not "">Design_Start_Date,</cfif>
				<cfif trim(cr_design_fdt) is not "">Design_Finish_Date,</cfif>
				<cfif trim(cr_designby) is not "">Designed_By,</cfif>
				<cfif trim(cr_assessed_dt) is not "">Assessed_Date,</cfif>
				<cfif trim(cr_assessedby) is not "">Assessed_By,</cfif>
				<cfif trim(cr_dotcoord) is not "">DOT_Coordination,</cfif>
				<cfif trim(cr_con_cdt) is not "">Construction_Completed_Date,</cfif>
				<cfif trim(cr_utility) is not "">Utility_Conflict,</cfif>
				<cfif trim(cr_bsl) is not "">BSL_Conflict,</cfif>
				<cfif trim(cr_dwp) is not "">DWP_Conflict,</cfif>
				<cfif trim(cr_bos) is not "">BOS_Conflict,</cfif>
				<cfif trim(cr_dot) is not "">DOT_Conflict,</cfif>
				<cfif trim(cr_other) is not "">Other_Conflict,</cfif>
				<cfif trim(cr_minor) is not "">Minor_Repair_Only,</cfif>
				<cfif trim(cr_truncate) is not "">Add_Truncated_Domes,</cfif>
				<cfif trim(cr_lip) is not "">Lip_Grind,</cfif>
				<cfif trim(cr_scoring) is not "">Add_Scoring_Lines,</cfif>
				<cfif trim(cr_notes) is not "">Notes,</cfif>
				<cfif trim(cr_excptn) is not "">ADA_Exception,</cfif>
				<cfif trim(cr_excptn_notes) is not "">ADA_Exception_Notes,</cfif>
				<cfif trim(cr_sno) is not "">Location_No,</cfif>
				User_ID,
				Creation_Date
			) 
			Values 
			(
				#cr_no#,
				<cfif trim(cr_primary) is not "">'#PreserveSingleQuotes(cr_primary)#',</cfif>
			    <cfif trim(cr_type) is not "">#cr_type#,</cfif>
			    <cfif trim(cr_secondary) is not "">'#PreserveSingleQuotes(cr_secondary)#',</cfif>
			    <cfif trim(cr_cd) is not "">#cr_cd#,</cfif>
				<cfif trim(cr_zip) is not "">#cr_zip#,</cfif>
				<cfif trim(cr_corner) is not "">'#PreserveSingleQuotes(cr_corner)#',</cfif>
				<cfif trim(cr_priority) is not "">#cr_priority#,</cfif>
				<cfif trim(cr_logdate) is not "">#cr_logdate#,</cfif>
				<cfif trim(cr_assessed) is not "">#cr_assessed#,</cfif>
				<cfif trim(cr_existing) is not "">#cr_existing#,</cfif>
				<cfif trim(cr_compliant) is not "">#cr_compliant#,</cfif>
				<cfif trim(cr_applicable) is not "">#cr_applicable#,</cfif>
				<cfif trim(cr_repairs) is not "">#cr_repairs#,</cfif>
				<cfif trim(cr_design) is not "">#cr_design#,</cfif>
				<cfif trim(cr_design_sdt) is not "">#cr_design_sdt#,</cfif>
				<cfif trim(cr_design_fdt) is not "">#cr_design_fdt#,</cfif>
				<cfif trim(cr_designby) is not "">'#PreserveSingleQuotes(cr_designby)#',</cfif>
				<cfif trim(cr_assessed_dt) is not "">#cr_assessed_dt#,</cfif>
				<cfif trim(cr_assessedby) is not "">'#PreserveSingleQuotes(cr_assessedby)#',</cfif>
				<cfif trim(cr_dotcoord) is not "">#cr_dotcoord#,</cfif>
				<cfif trim(cr_con_cdt) is not "">#cr_con_cdt#,</cfif>
				<cfif trim(cr_utility) is not "">#cr_utility#,</cfif>
				<cfif trim(cr_bsl) is not "">#cr_bsl#,</cfif>
				<cfif trim(cr_dwp) is not "">#cr_dwp#,</cfif>
				<cfif trim(cr_bos) is not "">#cr_bos#,</cfif>
				<cfif trim(cr_dot) is not "">#cr_dot#,</cfif>
				<cfif trim(cr_other) is not "">'#PreserveSingleQuotes(cr_other)#',</cfif>
				<cfif trim(cr_minor) is not "">#cr_minor#,</cfif>
				<cfif trim(cr_truncate) is not "">#cr_truncate#,</cfif>
				<cfif trim(cr_lip) is not "">#cr_lip#,</cfif>
				<cfif trim(cr_scoring) is not "">#cr_scoring#,</cfif>
				<cfif trim(cr_notes) is not "">'#PreserveSingleQuotes(cr_notes)#',</cfif>
				<cfif trim(cr_excptn) is not "">#cr_excptn#,</cfif>
				<cfif trim(cr_excptn_notes) is not "">'#PreserveSingleQuotes(cr_excptn_notes)#',</cfif>
				<cfif trim(cr_sno) is not "">#cr_sno#,</cfif>
				#session.user_num#,
				#CreateODBCDateTime(Now())#
			)
			</cfquery>

			<cfset data.id = cr_no>
			<cfset data.result = "Success">
		
		<cfcatch>
		
			<cfset data.result = "- Site Creation Failed: Database Error.">
		
			<!--- Remove the ID of record --->
			<!--- <cfquery name="getID" datasource="#request.sqlconn#">
			DELETE FROM #tbl# WHERE ramp_no = #cr_no#
			</cfquery> --->
		
		</cfcatch>
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
		
	</cffunction>
	
	
	
	<cffunction name="updateCurbRamp" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="cr_no" required="true">
		<cfargument name="cr_primary" required="true">
		<cfargument name="cr_type" required="true">
		<cfargument name="cr_secondary" required="true">
		<cfargument name="cr_cd" required="true">
		<cfargument name="cr_zip" required="true">
		<cfargument name="cr_corner" required="true">
		<cfargument name="cr_priority" required="true">
		<cfargument name="cr_logdate" required="true">
		<cfargument name="cr_assessed" required="true">
		<cfargument name="cr_existing" required="true">
		<cfargument name="cr_compliant" required="true">
		<cfargument name="cr_applicable" required="true">
		<cfargument name="cr_repairs" required="true">
		<cfargument name="cr_design" required="true">
		<cfargument name="cr_design_sdt" required="true">
		<cfargument name="cr_design_fdt" required="true">
		<cfargument name="cr_designby" required="true">
		<cfargument name="cr_assessed_dt" required="true">
		<cfargument name="cr_assessedby" required="true">
		<cfargument name="cr_qc_dt" required="true">
		<cfargument name="cr_qcby" required="true">
		<cfargument name="cr_dotcoord" required="true">
		<cfargument name="cr_con_cdt" required="true">
		<cfargument name="cr_totalcost" required="true">
		<cfargument name="cr_utility" required="true">
		<cfargument name="cr_minor" required="true">
		<cfargument name="cr_notes" required="true">
		<cfargument name="cr_sno" required="true">
		<cfargument name="cr_excptn_notes" required="true">
		
		<cfif isdefined("cr_bsl") is false><cfset cr_bsl = ""><cfelse><cfset cr_bsl = 1></cfif>
		<cfif isdefined("cr_dwp") is false><cfset cr_dwp = ""><cfelse><cfset cr_dwp = 1></cfif>
		<cfif isdefined("cr_bos") is false><cfset cr_bos = ""><cfelse><cfset cr_bos = 1></cfif>
		<cfif isdefined("cr_dot") is false><cfset cr_dot = ""><cfelse><cfset cr_dot = 1></cfif>
		<cfif isdefined("cr_other") is false><cfset cr_other = ""></cfif>
		<cfif isdefined("cr_truncate") is false><cfset cr_truncate = ""><cfelse><cfset cr_truncate = 1></cfif>
		<cfif isdefined("cr_lip") is false><cfset cr_lip = ""><cfelse><cfset cr_lip = 1></cfif>
		<cfif isdefined("cr_scoring") is false><cfset cr_scoring = ""><cfelse><cfset cr_scoring = 1></cfif>
		<cfif isdefined("cr_excptn") is false><cfset cr_excptn = ""><cfelse><cfset cr_excptn = 1></cfif>
		

		<cfset var data = {}>
		<cfset tbl = "tblCurbRamps">
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Curb Ramp Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif cr_logdate is not "">
			<cfset arrDT = listtoarray(cr_logdate,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset cr_logdate = createODBCDate(dt)>
		</cfif>
		
		<cfif cr_design_sdt is not "">
			<cfset arrDT = listtoarray(cr_design_sdt,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset cr_design_sdt = createODBCDate(dt)>
		</cfif>
		
		<cfif cr_design_fdt is not "">
			<cfset arrDT = listtoarray(cr_design_fdt,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset cr_design_fdt = createODBCDate(dt)>
		</cfif>
		
		<cfif cr_assessed_dt is not "">
			<cfset arrDT = listtoarray(cr_assessed_dt,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset cr_assessed_dt = createODBCDate(dt)>
		</cfif>
		
		<cfif cr_qc_dt is not "">
			<cfset arrDT = listtoarray(cr_qc_dt,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset cr_qc_dt = createODBCDate(dt)>
		</cfif>
		
		<cfif cr_con_cdt is not "">
			<cfset arrDT = listtoarray(cr_con_cdt,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset cr_con_cdt = createODBCDate(dt)>
		</cfif>
		
		<cfif trim(cr_primary) is ""><cfset cr_primary = "NULL"></cfif>
		<cfif trim(cr_type) is ""><cfset cr_type = "NULL"></cfif>
		<cfif trim(cr_secondary) is ""><cfset cr_secondary = "NULL"></cfif>
		<cfif trim(cr_cd) is ""><cfset cr_cd = "NULL"></cfif>
		<cfif trim(cr_zip) is ""><cfset cr_zip = "NULL"></cfif>
		<cfif trim(cr_corner) is ""><cfset cr_corner = "NULL"></cfif>
		<cfif trim(cr_priority) is ""><cfset cr_priority = "NULL"></cfif>
		<cfif trim(cr_logdate) is ""><cfset cr_logdate = "NULL"></cfif>
		<cfif trim(cr_assessed) is ""><cfset cr_assessed = "NULL"></cfif>
		<cfif trim(cr_existing) is ""><cfset cr_existing = "NULL"></cfif>
		<cfif trim(cr_compliant) is ""><cfset cr_compliant = "NULL"></cfif>
		<cfif trim(cr_applicable) is ""><cfset cr_applicable = "NULL"></cfif>
		<cfif trim(cr_repairs) is ""><cfset cr_repairs = "NULL"></cfif>
		<cfif trim(cr_design) is ""><cfset cr_design = "NULL"></cfif>
		<cfif trim(cr_design_sdt) is ""><cfset cr_design_sdt = "NULL"></cfif>
		<cfif trim(cr_design_fdt) is ""><cfset cr_design_fdt = "NULL"></cfif>
		<cfif trim(cr_designby) is ""><cfset cr_designby = "NULL"></cfif>
		<cfif trim(cr_assessed_dt) is ""><cfset cr_assessed_dt = "NULL"></cfif>
		<cfif trim(cr_assessedby) is ""><cfset cr_assessedby = "NULL"></cfif>
		<cfif trim(cr_qc_dt) is ""><cfset cr_qc_dt = "NULL"></cfif>
		<cfif trim(cr_qcby) is ""><cfset cr_qcby = "NULL"></cfif>
		<cfif trim(cr_dotcoord) is ""><cfset cr_dotcoord = "NULL"></cfif>
		<cfif trim(cr_con_cdt) is ""><cfset cr_con_cdt = "NULL"></cfif>
		<cfif trim(cr_totalcost) is ""><cfset cr_totalcost = "NULL"></cfif>
		<cfif trim(cr_utility) is ""><cfset cr_utility = "NULL"></cfif>
		<cfif trim(cr_minor) is ""><cfset cr_minor = "NULL"></cfif>
		<cfif trim(cr_notes) is ""><cfset cr_notes = "NULL"></cfif>
		<cfif trim(cr_sno) is ""><cfset cr_sno = "NULL"></cfif>
		<cfif trim(cr_bsl) is ""><cfset cr_bsl = "NULL"></cfif>
		<cfif trim(cr_dwp) is ""><cfset cr_dwp = "NULL"></cfif>
		<cfif trim(cr_bos) is ""><cfset cr_bos = "NULL"></cfif>
		<cfif trim(cr_dot) is ""><cfset cr_dot = "NULL"></cfif>
		<cfif trim(cr_other) is ""><cfset cr_other = "NULL"></cfif>
		<cfif trim(cr_truncate) is ""><cfset cr_truncate = "NULL"></cfif>
		<cfif trim(cr_lip) is ""><cfset cr_lip = "NULL"></cfif>
		<cfif trim(cr_scoring) is ""><cfset cr_scoring = "NULL"></cfif>
		<cfif trim(cr_excptn) is ""><cfset cr_excptn = "NULL"></cfif>
		<cfif trim(cr_excptn_notes) is ""><cfset cr_excptn_notes = "NULL"></cfif>
		
		<cfset cr_primary = replace(cr_primary,"'","''","ALL")>
		<cfset cr_secondary = replace(cr_secondary,"'","''","ALL")>
		<cfset cr_corner = replace(cr_corner,"'","''","ALL")>
		<cfset cr_designby = replace(cr_designby,"'","''","ALL")>
		<cfset cr_assessedby = replace(cr_assessedby,"'","''","ALL")>
		<cfset cr_qcby = replace(cr_qcby,"'","''","ALL")>
		<cfset cr_other = replace(cr_other,"'","''","ALL")>
		<cfset cr_notes = replace(cr_notes,"'","''","ALL")>
		<cfset cr_excptn_notes = replace(cr_excptn_notes,"'","''","ALL")>
		
			
		<cftry>
		
			<cfquery name="UpdateFeature" datasource="#request.sqlconn#">		
			UPDATE #tbl# SET
			Primary_Street = '#PreserveSingleQuotes(cr_primary)#',
			Secondary_Street = <cfif cr_secondary is "NULL">#cr_secondary#<cfelse>'#PreserveSingleQuotes(cr_secondary)#'</cfif>,
			Type = #cr_type#,
			Council_District = #cr_cd#,
			Zip_Code = #cr_zip#,
			Intersection_Corner = <cfif cr_corner is "NULL">#cr_corner#<cfelse>'#PreserveSingleQuotes(cr_corner)#'</cfif>,
			Priority_No = #cr_priority#,
			Date_Logged = #cr_logdate#,
			Field_Assessed = #cr_assessed#,
			Existing_Ramp = #cr_existing#,
			ADA_Compliant = #cr_compliant#,
			Standard_Plan_Applicable = #cr_applicable#,
			Repairs_Required = #cr_repairs#,
			Design_Required = #cr_design#,
			Design_Start_Date = #cr_design_sdt#,
			Design_Finish_Date = #cr_design_fdt#,
			Designed_By = <cfif cr_designby is "NULL">#cr_designby#<cfelse>'#PreserveSingleQuotes(cr_designby)#'</cfif>,
			Assessed_Date = #cr_assessed_dt#,
			Assessed_By = <cfif cr_assessedby is "NULL">#cr_assessedby#<cfelse>'#PreserveSingleQuotes(cr_assessedby)#'</cfif>,
			QC_Date = #cr_qc_dt#,
			QC_By = <cfif cr_qcby is "NULL">#cr_qcby#<cfelse>'#PreserveSingleQuotes(cr_qcby)#'</cfif>,
			DOT_Coordination = #cr_dotcoord#,
			Construction_Completed_Date = #cr_con_cdt#,
			Total_Cost = #cr_totalcost#,
			Utility_Conflict = #cr_utility#,
			BSL_Conflict = #cr_bsl#,
			DWP_Conflict = #cr_dwp#,
			BOS_Conflict = #cr_bos#,
			DOT_Conflict = #cr_dot#,
			Other_Conflict = <cfif cr_other is "NULL">#cr_other#<cfelse>'#PreserveSingleQuotes(cr_other)#'</cfif>,
			Minor_Repair_Only = #cr_minor#,
			Add_Truncated_Domes = #cr_truncate#,
			Lip_Grind = #cr_lip#,
			Add_Scoring_Lines = #cr_scoring#,
			Notes = <cfif cr_notes is "NULL">#cr_notes#<cfelse>'#PreserveSingleQuotes(cr_notes)#'</cfif>,
			ADA_Exception = #cr_excptn#,
			ADA_Exception_Notes = <cfif cr_excptn_notes is "NULL">#cr_excptn_notes#<cfelse>'#PreserveSingleQuotes(cr_excptn_notes)#'</cfif>,
			Location_No = #cr_sno#,
			modified_date = #CreateODBCDateTime(Now())#,
			User_ID = #session.user_num#
			WHERE ramp_no = #cr_no#
			</cfquery>
		
			<cfset data.id = cr_no>
			<cfset data.result = "Success">
		
		<cfcatch>
		
			<cfset data.result = "- Curb Ramp Update Failed: Database Error.">
		
		</cfcatch>
		</cftry>
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
		
	</cffunction>
	
	
	<cffunction name="searchCurbRamps" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="scr_no" required="true">
		<cfargument name="scr_sno" required="true">
		<cfargument name="scr_pgroup" required="true">
		<cfargument name="scr_pno" required="true">
		<cfargument name="scr_type" required="true">
		<cfargument name="scr_primary" required="true">
		<cfargument name="scr_secondary" required="true">
		<cfargument name="scr_zip" required="true">
		<cfargument name="scr_assessed" required="true">
		<cfargument name="scr_repairs" required="true">
		<cfargument name="scr_design" required="true">
		
		<!--- joe hu ------ 6/14/2018     ------- added (2) ----------  ---> 
        <cfargument name="scr_removed" required="true">
		
		<cfargument name="scr_applicable" required="true">
		<cfargument name="scr_utility" required="true">
		<cfargument name="scr_minor" required="true">
		<cfargument name="scr_corner" required="true">
		<cfargument name="scr_priority" required="true">
		<cfargument name="scr_cd" required="true">
		<cfargument name="scr_dsdfrm" required="true">
		<cfargument name="scr_dsdto" required="true">
		<cfargument name="scr_dfdfrm" required="true">
		<cfargument name="scr_dfdto" required="true">
		<cfargument name="scr_assfrm" required="true">
		<cfargument name="scr_assto" required="true">
		<cfargument name="scr_ccdfrm" required="true">
		<cfargument name="scr_ccdto" required="true">
		<cfargument name="scr_dsdnull" required="false">
		<cfargument name="scr_dfdnull" required="false">
		<cfargument name="scr_assnull" required="false">
		<cfargument name="scr_ccdnull" required="false">
		<cfargument name="scr_order" required="false" default="ramp_no,location_no">
		
		<cfif isdefined("scr_dsdnull")><cfset session.scr_dsdnull = 1><cfelse><cfset StructDelete(Session, "scr_dsdnull")></cfif>
		<cfif isdefined("scr_dfdnull")><cfset session.scr_dfdnull = 1><cfelse><cfset StructDelete(Session, "scr_dfdnull")></cfif>
		<cfif isdefined("scr_assnull")><cfset session.scr_assnull = 1><cfelse><cfset StructDelete(Session, "scr_assnull")></cfif>
		<cfif isdefined("scr_ccdnull")><cfset session.scr_ccdnull = 1><cfelse><cfset StructDelete(Session, "scr_ccdnull")></cfif>
		
		<!--- <cfdump var="#arguments#">
		<cfabort> --->
		
		<cfset var data = {}>
		
		<cfset scr_primary = trim(scr_primary)>
		<cfset scr_secondary = trim(scr_secondary)>
		<cfset scr_zip = trim(scr_zip)>
		
		<cfset scr_dsgnstart = "">
		<cfset scr_dsgnfinish = "">
		
		<cfif scr_dsdfrm is not "">
			<cfset arrDT = listtoarray(scr_dsdfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_dsdfrm = createODBCDate(dt)>
		</cfif>
		<cfif scr_dsdto is not "">
			<cfset arrDT = listtoarray(scr_dsdto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_dsdto = createODBCDate(dt)>
		</cfif>
		<cfif scr_dfdfrm is not "">
			<cfset arrDT = listtoarray(scr_dfdfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_dfdfrm = createODBCDate(dt)>
		</cfif>
		<cfif scr_dfdto is not "">
			<cfset arrDT = listtoarray(scr_dfdto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_dfdto = createODBCDate(dt)>
		</cfif>
		
		<cfset scr_assessor = "">
		<cfset scr_concomplete = "">
		
		<cfif scr_assfrm is not "">
			<cfset arrDT = listtoarray(scr_assfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_assfrm = createODBCDate(dt)>
		</cfif>
		<cfif scr_assto is not "">
			<cfset arrDT = listtoarray(scr_assto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_assto = createODBCDate(dt)>
		</cfif>
		<cfif scr_ccdfrm is not "">
			<cfset arrDT = listtoarray(scr_ccdfrm,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_ccdfrm = createODBCDate(dt)>
		</cfif>
		<cfif scr_ccdto is not "">
			<cfset arrDT = listtoarray(scr_ccdto,"/")>
			<cfset dt = createdate(arrDT[3],arrDT[1],arrDT[2])>
			<cfset scr_ccdto = createODBCDate(dt)>
		</cfif>
		
		<cfif trim(scr_dsdfrm) is not "" AND trim(scr_dsdto) is ""><cfset scr_dsgnstart = scr_dsdfrm></cfif>
		<cfif trim(scr_dsdto) is not "" AND trim(scr_dsdfrm) is ""><cfset scr_dsgnstart = scr_dsdto></cfif>
		<cfset dsdbtwn = "">
		<cfif trim(scr_dsdfrm) is not "" AND trim(scr_dsdto) is not "">
			<cfset dsdbtwn = "AND (design_start_date >= " & scr_dsdfrm & " AND design_start_date <= " & scr_dsdto & ")"> 
		</cfif>
		<cfif trim(scr_dsdfrm) is "" AND trim(scr_dsdto) is not "">
			<cfset scr_dsgnstart = "">
			<cfset dsdbtwn = "AND design_start_date <= " & scr_dsdto> 
		</cfif>
		
		<cfif trim(scr_dfdfrm) is not "" AND trim(scr_dfdto) is ""><cfset scr_dsgnfinish = scr_dfdfrm></cfif>
		<cfif trim(scr_dfdto) is not "" AND trim(scr_dfdfrm) is ""><cfset scr_dsgnfinish = scr_dfdto></cfif>
		<cfset dfdbtwn = "">
		<cfif trim(scr_dfdfrm) is not "" AND trim(scr_dfdto) is not "">
			<cfset dfdbtwn = "AND (design_finish_date >= " & scr_dfdfrm & " AND design_finish_date <= " & scr_dfdto & ")"> 
		</cfif>	
		<cfif trim(scr_dfdfrm) is "" AND trim(scr_dfdto) is not "">
			<cfset scr_dsgnfinish = "">
			<cfset dfdbtwn = "AND design_finish_date <= " & scr_dfdto> 
		</cfif>

		<cfif trim(scr_assfrm) is not "" AND trim(scr_assto) is ""><cfset scr_assessor = scr_assfrm></cfif>
		<cfif trim(scr_assto) is not "" AND trim(scr_assfrm) is ""><cfset scr_assessor = scr_assto></cfif>
		<cfset assbtwn = "">
		<cfif trim(scr_assfrm) is not "" AND trim(scr_assto) is not "">
			<cfset assbtwn = "AND (assessed_date >= " & scr_assfrm & " AND assessed_date <= " & scr_assto & ")"> 
		</cfif>
		<cfif trim(scr_assfrm) is "" AND trim(scr_assto) is not "">
			<cfset scr_assessor = "">
			<cfset assbtwn = "AND  assessed_date <= " & scr_assto> 
		</cfif>
		
		<cfif trim(scr_ccdfrm) is not "" AND trim(scr_ccdto) is ""><cfset scr_concomplete = scr_ccdfrm></cfif>
		<cfif trim(scr_ccdto) is not "" AND trim(scr_ccdfrm) is ""><cfset scr_concomplete = scr_ccdto></cfif>
		<cfset concbtwn = "">
		<cfif trim(scr_ccdfrm) is not "" AND trim(scr_ccdto) is not "">
			<cfset concbtwn = "AND (construction_completed_date >= " & scr_ccdfrm & " AND construction_completed_date <= " & scr_ccdto & ")"> 
		</cfif>
		<cfif trim(scr_ccdfrm) is "" AND trim(scr_ccdto) is not "">
			<cfset scr_concomplete = "">
			<cfset concbtwn = "AND construction_completed_date <= " & scr_ccdto> 
		</cfif>
	
    
    
    
    
		
		<cfquery name="getCurbRamps" datasource="#request.sqlconn#">
		SELECT * FROM vwCurbRamps WHERE 1=1
		<cfif scr_no is not "">AND ramp_no = #scr_no#</cfif> 
		<cfif scr_sno is not "">AND location_no = #scr_sno#</cfif> 
		<cfif scr_pgroup is not "">
			<cfif scr_pgroup is "ALL">
				AND package_group is not NULL
			<cfelseif scr_pgroup is "NONE">
				AND package_group is NULL
			<cfelse>
				AND package_group = '#scr_pgroup#'
			</cfif>
		</cfif> 
		<cfif scr_pno is not "">AND package_no = '#scr_pno#'</cfif> 
		<cfif scr_type is not "">AND type = '#scr_type#'</cfif> 
        
        <!--- joe -----   2/15/2018 -----------  requestID 107 ---- 2) ------------------      --->
        
			<!--- ---- original ------  
			<cfif trim(scr_primary) is not "">AND primary_street LIKE '%#preservesinglequotes(scr_primary)#%'</cfif> 
			<cfif trim(scr_secondary) is not "">AND secondary_street LIKE '%#preservesinglequotes(scr_secondary)#%'</cfif> 
			--->

			<!---  =========== primary street  ================    ---> 

			<cfset target_string = '' >
			<cfset quoted_string_array = []>
			
			<cfif trim(scr_primary) is not "">
			
				<cfset target_string = scr_primary >
				
				<cfset regular_expression_double_quote = '"([^"]*)"'  />
				<cfset regular_expression_single_quote = "'([^']*)'"  />
				
				<cfset quoted_string_array_double_quote = REMatch(regular_expression_double_quote, target_string) >
				<cfset quoted_string_array_single_quote = REMatch(regular_expression_single_quote, target_string) >
				
				<cfset ArrayAppend(quoted_string_array, quoted_string_array_double_quote, true) >
				<cfset ArrayAppend(quoted_string_array, quoted_string_array_single_quote, true) >
	
				<cfloop array="#quoted_string_array#" index="quoted_string_item">
					<cfset quoted_string_item_fake = replace(quoted_string_item, " ","~","all") >
					<cfset target_string = replace(target_string, quoted_string_item, quoted_string_item_fake, "all") >
				</cfloop>

				<cfset target_string_array = ListToArray(target_string, " " ) />
				
				<cfloop array="#target_string_array#" index="item">

					<cfset first_char=Left(item,1) />
					
					<cfif first_char is "-">
					
						<cfset item = RemoveChars(item, 1, 1) />
						
						<!--- remove all single quote, double quote ,  replace ~ with space --->
						<cfset item = trim(replace(item,'"','',"ALL"))>
						<cfset item = trim(replace(item,"'",'',"ALL"))>
						<cfset item = trim(replace(item,"~",' ',"ALL"))>
						AND primary_street Not LIKE '%#preservesinglequotes(item)#%'
						
					<cfelse>

						<!--- remove all single quote, double quote ,  replace ~ with space --->
						<cfset item = trim(replace(item,'"','',"ALL"))>
						<cfset item = trim(replace(item,"'",'',"ALL"))>
						<cfset item = trim(replace(item,"~",' ',"ALL"))>
						AND primary_street LIKE '%#preservesinglequotes(item)#%'
						
					</cfif>
				</cfloop>
			</cfif> 

			<!---  =========== secondary street  ================    ---> 
			
			<cfset target_string = '' >
			<cfset quoted_string_array = []>
			
			<cfif trim(scr_secondary) is not "">
			
				<cfset target_string = scr_secondary >
				
				<cfset regular_expression_double_quote = '"([^"]*)"'  />
				<cfset regular_expression_single_quote = "'([^']*)'"  />
				
				<cfset quoted_string_array_double_quote = REMatch(regular_expression_double_quote, target_string) >
				<cfset quoted_string_array_single_quote = REMatch(regular_expression_single_quote, target_string) >
				
				
				<cfset ArrayAppend(quoted_string_array, quoted_string_array_double_quote, true) >
				<cfset ArrayAppend(quoted_string_array, quoted_string_array_single_quote, true) >
				
				<cfloop array="#quoted_string_array#" index="quoted_string_item">
					<cfset quoted_string_item_fake = replace(quoted_string_item, " ","~","all") >
					<cfset target_string = replace(target_string, quoted_string_item, quoted_string_item_fake, "all") >
				</cfloop>
				
				<cfset target_string_array = ListToArray(target_string, " " ) />
				
				<cfloop array="#target_string_array#" index="item">
				
					<cfset first_char=Left(item,1) />
					
					<cfif first_char is "-">
					
						<cfset item = RemoveChars(item, 1, 1) />
						
						<!--- remove all single quote, double quote ,  replace ~ with space --->
						<cfset item = trim(replace(item,'"','',"ALL"))>
						<cfset item = trim(replace(item,"'",'',"ALL"))>
						<cfset item = trim(replace(item,"~",' ',"ALL"))>
						AND secondary_street Not LIKE '%#preservesinglequotes(item)#%'
							
					<cfelse>
		
						<!--- remove all single quote, double quote ,  replace ~ with space --->
						<cfset item = trim(replace(item,'"','',"ALL"))>
						<cfset item = trim(replace(item,"'",'',"ALL"))>
						<cfset item = trim(replace(item,"~",' ',"ALL"))>
						AND secondary_street LIKE '%#preservesinglequotes(item)#%'
					
					</cfif>
				</cfloop>
			</cfif>

        <!---  ------- End --------------- joe -----   2/15/2018 -----------  requestID 107 ---- 2)--->
        
		<cfif scr_zip is not "">AND zip_code = #scr_zip#</cfif>
		<cfif scr_assessed is not "">
			<cfif scr_assessed is 1>
				AND field_assessed = #scr_assessed#
			<cfelse>
				AND (field_assessed = 0 OR field_assessed is null)
			</cfif>
		</cfif> 
		<cfif scr_repairs is not "">AND repairs_required = #scr_repairs#</cfif> 
		<cfif scr_design is not "">AND design_required = #scr_design#</cfif> 
		
		<!--- joe hu ------ 6/14/2018     ------- added (3) ----------  ---> 
        <cfif scr_removed is not "">AND removed = #scr_removed#<cfelse>AND removed is NULL</cfif>
		
		<cfif scr_applicable is not "">AND standard_plan_applicable = #scr_applicable#</cfif> 
		<cfif scr_utility is not "">AND utility_conflict = #scr_utility#</cfif> 
		<cfif scr_minor is not "">AND minor_repair_only = #scr_minor#</cfif> 
		<cfif trim(scr_corner) is not "">AND intersection_corner = '#preservesinglequotes(scr_corner)#'</cfif>
		<cfif scr_priority is not "">AND priority_no = #scr_priority#</cfif> 
		<cfif scr_cd is not "">AND council_district = #scr_cd#</cfif> 
		<cfif trim(scr_dsgnstart) is not "">AND design_start_date = #preservesinglequotes(scr_dsgnstart)#</cfif>
		<cfif trim(dsdbtwn) is not "">#preservesinglequotes(dsdbtwn)#</cfif>
		<cfif trim(scr_dsgnfinish) is not "">AND design_finish_date = #preservesinglequotes(scr_dsgnfinish)#</cfif>
		<cfif trim(dfdbtwn) is not "">#preservesinglequotes(dfdbtwn)#</cfif>
		<cfif trim(scr_assessor) is not "">AND assessed_date = #preservesinglequotes(scr_assessor)#</cfif>
		<cfif trim(assbtwn) is not "">#preservesinglequotes(assbtwn)#</cfif>
		<cfif trim(scr_concomplete) is not "">AND construction_completed_date = #preservesinglequotes(scr_concomplete)#</cfif>
		<cfif trim(concbtwn) is not "">#preservesinglequotes(concbtwn)#</cfif>
		<cfif isdefined("scr_dsdnull")>AND design_start_date IS NULL</cfif>
		<cfif isdefined("scr_dfdnull")>AND design_finish_date IS NULL</cfif>
		<cfif isdefined("scr_assnull")>AND assessed_date IS NULL</cfif>
		<cfif isdefined("scr_ccdnull")>AND construction_completed_date IS NULL</cfif>
		ORDER BY #scr_order#
		</cfquery>
	
		<cfset data.query = serializeJSON(getCurbRamps)>
		
		<cfset session.curbQuery = getCurbRamps>
	
		<cfset data.result = "Success">
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
		
	</cffunction>
	
	
	<cffunction name="updatePriorityDefault" access="remote" returnType="any" returnFormat="plain" output="false">
		<!--- <cfargument name="sw_id" required="true"> --->
		
		<cfset var data = {}>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif session.user_level lt 3>
			<cfset data.result = "- Download Failed: You are not authorized to update the Estimate Default Table.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>		
		
		<!--- <cfset data.uqstr = uqstr>
		<cfset data.iqstr = iqstr> --->
		
		<cfquery name="getKeys" datasource="#request.sqlconn#">
		SELECT id FROM tblPriorityRanks
		</cfquery>
		
		<!--- <cftry> --->
		
			<cfloop query="getKeys">
		
				<cfset points = evaluate("points_#getKeys.id#")>
			
				<cfquery name="updateRecord" datasource="#request.sqlconn#">
				UPDATE tblPriorityRanks SET 
				points = #points#
				WHERE id = #getKeys.id#
				</cfquery>
				
			</cfloop>

			<cfset data.result = "Success">
		<!--- <cfcatch>
			<cfset data.result = "- Update Failed: Database Error.">
		</cfcatch>
		
		</cftry> --->
		
		<cfset tbl = "tblSites">
		<cfset data.priority = updatePriority(0,tbl)>
		
		
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    
	    <cfreturn data>
	
	
	</cffunction>
	
	
	<cffunction name="AddSRID" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		<cfargument name="sw_add_srid" required="true">
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>

		<cfset var data = {}>
		
		<cfquery name="insertSRID" datasource="#request.sqlconn#">
		INSERT INTO tblSRNumbers (
		[Location_No],
		[SR_Number],
		[User_ID],
		[Creation_Date]
		)
		VALUES ( 
		#sw_id#,
		'#sw_add_srid#',
		#session.user_num#,
		#CreateODBCDateTime(Now())#
		)
		</cfquery>
		
		<cfquery name="getIDs" datasource="#request.sqlconn#">
		SELECT * FROM tblSRNumbers WHERE location_no = #sw_id# AND removed IS NULL ORDER BY sr_number
		</cfquery>
		
		<cfset str = "">
		<cfloop query="getIDs">
			<cfset str = str & "," & SR_Number>
		</cfloop>
		<cfset data.sr_numbers = right(str,(len(str)-1))>
		<cfset data.id = sw_add_srid>
		<cfset data.result = "Success">
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    <cfreturn data>
		
	</cffunction>
	
	<cffunction name="RemoveSRID" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sw_id" required="true">
		<cfargument name="sridStr" required="true">
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>

		<cfset var data = {}>
		
		<cfset arrSRIDs = listToArray(sridStr,",")>
		
		<cfloop index="i" from="1" to="#arrayLen(arrSRIDs)#">
			
			<cfquery name="updateSRID" datasource="#request.sqlconn#">
			UPDATE tblSRNumbers SET
			[User_ID] = #session.user_num#,
			[Modified_Date] = #CreateODBCDateTime(Now())#,
			[Removed] = 1
			WHERE location_no = #sw_id# AND SR_Number = '#arrSRIDs[i]#'
			</cfquery>
		
		</cfloop>
		
		<cfquery name="getIDs" datasource="#request.sqlconn#">
		SELECT * FROM tblSRNumbers WHERE location_no = #sw_id# AND removed IS NULL ORDER BY sr_number
		</cfquery>
		
		<cfset str = "">
		<cfloop query="getIDs">
			<cfset str = str & "," & SR_Number>
		</cfloop>
		<cfif str is not "">
			<cfset str = right(str,(len(str)-1))>
		</cfif>
		<cfset data.sr_numbers = str>
		<cfset data.sw_id = sw_id>		
		<cfset data.result = "Success">
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    <cfreturn data>
		
	</cffunction>
	
	<cffunction name="updateSRTicket" access="private" returnType="any" returnFormat="plain" output="false">
		<cfargument name="phase" required="true">
		<cfargument name="locno" required="true">
		<cfargument name="sr_num" required="true">
		
		<cfquery name="getPhase" datasource="#request.sqlconn#">
		SELECT value FROM tblPhaseType WHERE id = #phase#
		</cfquery>
		<cfset phz = getPhase.value>
		<cfset msg = "Thank you for submitting your Access Request. Due to the high volume of Access Requests, there could be a significant wait before work is completed. Currently your Access Request is in the '#phz#' phase. You can check the status of your request by logging into MyLA311 and selecting ""Manage Service Requests"". Thank you for your patience as we strive to implement this new program.">
		
		
		<!--- s: get other srids associated with the site --->
		<cfquery name="getSRIDs" datasource="#request.sqlconn#">
		SELECT sr_number FROM tblSRNumbers WHERE location_no = #locno# AND removed is NULL
		</cfquery>
		<cfset srids = sr_num>
		<cfif getSRIDs.recordcount gt 0><cfset srids = sr_num & "," & ValueList(getSRIDs.sr_number)></cfif>
		<cfset arrSRIDs = listtoarray(srids)>
		<!--- e: get other srids associated with the site --->
		
		<!--- s: loop through srids to update sr ticket --->
		<cfloop index="i" from="1" to="#arrayLen(arrSRIDs)#">
			<cfset answer = sendSRTicket(arrSRIDs[i],msg,(phase+28))>
		</cfloop>
		
		<!--- e: loop through srids to update sr ticket --->
		
	
		<cfset response = answer>
	
		<cfreturn response>
	
	</cffunction>
	
	<cffunction name="sendSRTicket" access="private" returnType="any" returnFormat="plain" output="false">
		<cfargument name="sr_num" required="true">
		<cfargument name="sr_comment" required="true">
		<cfargument name="sr_reasoncode" required="true" type="string">
		
		
		<!--- Setup script variables --->
		<cfset request.srupdate_err_message = "">
		<cfset request.myLA311Root = "https://lacity-test.apigee.net"><cfset sfx = "_qa">
		<cfif request.production is 2><cfset request.myLA311Root = "https://lacity-prod.apigee.net"><cfset sfx = ""></cfif>
		<cfset apiKey = "8lN5QbdIeZGNu1P7orjIIemsDwrA7WAR">
		
		<cfset queryMethodAPI = "#request.myLA311Root#/myla311#sfx#/QuerySRs?apikey=#apiKey#">
		<cfset upsertMethodAPI = "#request.myLA311Root#/myla311#sfx#/UpsertSR?apikey=#apiKey#">
		<cfset updateUserID = "BOEINTEGRATION">
		
		<!--- Query the existing SR to get the IntegrationID --->
		<cfset queryJSON = {
		    "MetaData": {},
		    "QueryRequest": {
		        "SRNumber": "#sr_num#",
						"srType": [
							"Sidewalk Repair"
		        ],
		        "NewQuery":"new",
		        "PageSize":"10",
		        "StartRowNum":"1"
		    }
		}>
		
		<!---  Call the query method. --->
		<cfif request.production is not 2>
			<cfhttp url = "#queryMethodAPI#" method = "post" timeout = "60" result = "httpQueryResp" proxyServer="bcproxy.ci.la.ca.us" proxyPort="8080">
			  <cfhttpparam type = "header" name = "Content-Type" value = "application/json">
			  <cfhttpparam type = "body" value = "#serializeJSON(queryJSON)#">
			</cfhttp>
		<cfelse>
			<cfhttp url = "#queryMethodAPI#" method = "post" timeout = "60" result = "httpQueryResp">
			  <cfhttpparam type = "header" name = "Content-Type" value = "application/json">
			  <cfhttpparam type = "body" value = "#serializeJSON(queryJSON)#">
			</cfhttp>
		</cfif>
		
		<!--- Validate the returned JSON data --->
		<cfif !IsJSON(httpQueryResp.Filecontent)><cfset request.srupdate_err_message = "Something went wrong with the httpMyLA311Resp variable and cfhttp call.">
		<!--- Data is valid so keep going --->
		<cfelse>
		  <cfset myla311Data = DeserializeJSON(httpQueryResp.Filecontent)>
		  <!--- Process the response codes and summarize the data --->
		  <cfif myla311Data.status.code neq "311">
		        <cfset request.srupdate_err_message="The max number of retries was exceeded">
		  </cfif>
		  <!--- Get the integrationID number --->
		  <cfif myla311Data.Response.NumOutputObjects neq 0>
		    <cfset the311Records = myla311Data.Response.ListOfServiceRequest.ServiceRequest>
		    <cfset integrationID = the311Records[1].IntegrationId>
		  <cfelse>
		  	<cfset request.srupdate_err_message="No records to process">
		  </cfif>
		</cfif>
		
		<cfif request.srupdate_err_message is ""> <!--- Continue if no Error message --->
		
			<cfset upsertData = {
			  "MetaData": {},
			  "SRData": {
			    "SRNumber": "#sr_num#",
			    "SRType": "Sidewalk Repair",
			    "IntegrationId": "#integrationID#",
			    "UpdatedByUserLogin": "#updateUserID#",
			    "ListOfLa311ServiceRequestNotes": {
			      "La311ServiceRequestNotes": [
			        {
			          "Comment": "#sr_comment#",
			          "CreatedByUser": "#updateUserID#",
			          "CommentType": "External",
			          "Notification": "N"
			        }
			      ]
			    },
				"ReasonCode": "#sr_reasoncode# "
			  }
			}>
		
			<!--- s: Only Add if data was actual sent --->
			<cfif sr_comment is not "">
				<!---  Call the upsert method. --->
				<cfhttp url = "#upsertMethodAPI#" method = "post" timeout = "60" result = "httpResp">
				  <cfhttpparam type = "header" name = "Content-Type" value = "application/json">
				  <cfhttpparam type = "body" value = "#serializeJSON(upsertData)#">
				</cfhttp>
				<!--- <cfdump var = "#httpResp#"> --->
				<cfset my311FContent = deserializeJSON(httpResp.filecontent)>
				<cfset my311Status = my311FContent.status>
				<!--- <cfdump var = "#my311FContent.status#"> --->
				<cfif my311Status.code neq "311">
					<cfset request.srupdate_err_message=my311Status.message>
				</cfif>
			<cfelse>
				<cfset request.srupdate_err_message = "No parameters were sent">
			</cfif>
			<!--- e: Only Add if data was actual sent --->
		
		</cfif>
	
		<cfset response = upsertData>
	
		<cfreturn response>
	
	</cffunction>
	
	<cffunction name="updateSiteNo" access="remote" returnType="any" returnFormat="plain" output="false">
		<cfargument name="idx" required="true">
		<cfargument name="sno" required="true">
		<cfargument name="typ" required="true">
		
		<cfset var data = {}>
		<cfset data.idx = idx>
		<cfset data.sno = sno>
		
		<cfif isdefined("session.userid") is false>
			<cfset data.result = "- Site Update Failed: You are no longer logged in.">
			<cfset data = serializeJSON(data)>
		    <!--- wrap --->
		    <cfif structKeyExists(arguments, "callback")>
		        <cfset data = arguments.callback & "" & data & "">
		    </cfif>
		    <cfreturn data>
			<cfabort>
		</cfif>
		
		<cfif typ is "add">
			<!--- First check if the location_no has been assigned already --->
			<cfquery name="chkPriority" datasource="#request.sqlconn#">
			SELECT location_no FROM tblCityPropertyPriority WHERE location_no = #sno#
			</cfquery>
			
			<cfif chkPriority.recordcount gt 0>
				<cfset data.result = "- Site Update Failed: The Site No. has already been assigned!">
				<cfset data = serializeJSON(data)>
			    <!--- wrap --->
			    <cfif structKeyExists(arguments, "callback")>
			        <cfset data = arguments.callback & "" & data & "">
			    </cfif>
			    <cfreturn data>
				<cfabort>
			</cfif>
			
			
			<!--- Next check if the location_no is an Access Request or a Rebate Request --->
			<cfquery name="chkPriority" datasource="#request.sqlconn#">
			SELECT location_no FROM tblSites WHERE location_no = #sno# AND type IN (11,27,28)
			</cfquery>
			
			<cfif chkPriority.recordcount gt 0>
				<cfset data.result = "- Site Update Failed: This myLA311 request can't be assigned!">
				<cfset data = serializeJSON(data)>
			    <!--- wrap --->
			    <cfif structKeyExists(arguments, "callback")>
			        <cfset data = arguments.callback & "" & data & "">
			    </cfif>
			    <cfreturn data>
				<cfabort>
			</cfif>
			
			<!--- Next check if the location_no exists at all --->
			<cfquery name="chkPriority" datasource="#request.sqlconn#">
			SELECT location_no FROM tblSites WHERE location_no = #sno#
			</cfquery>
			
			<cfif chkPriority.recordcount is 0>
				<cfset data.result = "- Site Update Failed: This Site No. doesn't exist!">
				<cfset data = serializeJSON(data)>
			    <!--- wrap --->
			    <cfif structKeyExists(arguments, "callback")>
			        <cfset data = arguments.callback & "" & data & "">
			    </cfif>
			    <cfreturn data>
				<cfabort>
			</cfif>
			
		</cfif>
		
		<cfset sn = sno>
		<cfif typ is "remove"><cfset sn = "NULL"></cfif>

		<cfset data.stk = 0>
				
		<!--- s: get Score to update table --->
		<cfif typ is "add">
			<!--- s: Get the calculated Tier 1 values and updates the table --->
			<cfquery name="getScore" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT scoretier1 FROM tblCityPropertyPriority WHERE id = #idx#
			</cfquery>
			
			<!--- s: Get the calculated Tier 2 values and updates the table --->
			<cfquery name="getScore2" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT score FROM vwPriorityTier2 WHERE location_no = #sno#
			</cfquery>
			<cfset score = getScore2.score>
			<cfif score is ""><cfset score = 0></cfif>
			
			<cfset data.tier1 = getScore.scoretier1>
			<cfset data.tier2 = score>
			<cfset data.score = getScore.scoretier1 + score>
			
			<!--- s: update tblSites table with new value --->
			<cfquery name="updateSitePriority" datasource="#request.sqlconn#">
			UPDATE tblSites SET
			[Priority_Tier1] = #data.tier1#,
			[User_ID] = #session.user_num#,
			[Modified_Date] = #CreateODBCDateTime(Now())#
			WHERE location_no = #sn#
			</cfquery>
			
			<!--- s: update tblCityPropertyPriority table with new value --->
			<cfquery name="updateSitePriority" datasource="#request.sqlconn#">
			UPDATE tblCityPropertyPriority SET
			[ScoreTier2] = #data.tier2#
			WHERE id = #idx#
			</cfquery>
			
			<cfquery name="getCompleted" datasource="#request.sqlconn#">
			SELECT construction_completed_date as dt FROM tblSites WHERE location_no = #sn#
			</cfquery>
			<cfif getCompleted.dt is not ""><cfset data.stk = 1></cfif>
			
		<cfelse>
			<!--- s: Get current score --->
			<cfquery name="getScore" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT location_no,scoretier1 FROM tblCityPropertyPriority WHERE id = #idx#
			</cfquery>
			<cfset locno = getScore.location_no>

			<!--- s: Get the calculated Tier 2 values and updates the table --->
			<!--- <cfquery name="getScore2" datasource="#request.sqlconn#" dbtype="ODBC">
			SELECT score FROM vwPriorityTier2 WHERE location_no = #locno#
			</cfquery>
			<cfset score = getScore2.score>
			<cfif score is ""><cfset score = "NULL"></cfif> --->
			
			<!--- these values are for resetting tblCityPropertyPriority and the array on the page with original scores --->
			<cfset data.tier1 = getScore.scoretier1>
			<cfset data.tier2 = "NULL">
			<cfset data.score = getScore.scoretier1>
			
			<!--- s: update tblSites table with new value --->
			<cfquery name="updateSitePriority" datasource="#request.sqlconn#">
			UPDATE tblSites SET
			[Priority_Tier1] = [Priority_Backup],
			[User_ID] = #session.user_num#,
			[Modified_Date] = #CreateODBCDateTime(Now())#
			WHERE location_no = #locno#
			</cfquery>
			
		</cfif>
		<!--- e: get Score to update table --->
		
		
		<cfquery name="updatePriority" datasource="#request.sqlconn#">
		UPDATE tblCityPropertyPriority SET
		[Location_No] = #sn#,
		[ScoreTier1] = #data.tier1#,
		[ScoreTier2] = #data.tier2#,
		[User_ID] = #session.user_num#,
		[Modified_Date] = #CreateODBCDateTime(Now())#
		WHERE id = #idx#
		</cfquery>
		<cfif typ is "remove"><cfset data.tier2 = ""></cfif>
		
		<!--- s: Set all completed Sites to null since they are no longer active --->
		<cfquery name="setCompleted" datasource="#request.sqlconn#">
		UPDATE tblSites SET priority_tier1 = null, priority_tier2 = null WHERE construction_completed_date IS NOT null
		</cfquery>
		<!--- e: Set all completed Sites to null since they are no longer active --->
		
		<cfset data.result = "Success">
		<cfset data = serializeJSON(data)>
		
	    <!--- wrap --->
	    <cfif structKeyExists(arguments, "callback")>
	        <cfset data = arguments.callback & "" & data & "">
	    </cfif>
	    <cfreturn data>
		
	</cffunction>
	
	
	
    
    
    
    
    <!--- ---------- joe hu ---------- super admin ---------  9/6/2018 ---------------  --->
    
    
    
    
    					 			  <cffunction name="getUser" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                                   
                                                        <!---  User_Power = -1  means deleted user   --->
                                                      <cfquery name="select_all_user" datasource="#request.sqlconn#">
                                                                                         
                                                                  SELECT 
                                                                            User_ID        as id,
                                                                            User_FullName    as full_name,  
                                                                            User_Name    as  name,  
                                                                            User_Password    as  password,  
                                                                            User_Agency    as  agency,  
                                                                            User_Level    as  level,  
                                                                            User_Power    as  power,  
                                                                            User_Cert    as  cert,  
                                                                            User_UFD    as  ufd,  
                                                                            User_Report    as  report 
                                                                            
                                                                            
                                                                  FROM tblUsers
                                                                  
                                                                  where  User_Power > -1     
                                                                                         
                                                       </cfquery>
                                                       
                                                    <cfreturn select_all_user>
                                            
                                        </cffunction>
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                      <cffunction name="updateUser" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                                   
                                                   
                             <!---
                                Get the HTTP request body content.
                                NOTE: We have to use toString() as an intermediary method
                                call since the JSON packet comes across as a byte array
                                (binary data) which needs to be turned back into a string before
                                ColdFusion can parse it as a JSON value.
                                        --->
                                
                                <cfset requestBody = toString( getHttpRequestData().content ) />
                    
                                    <!--- Double-check to make sure it's a JSON value. --->
                                   
                                   
                                    <cfif isJSON( requestBody )>
                                    
                                    
                                        <cfset json_post = deserializeJson( requestBody ) >
                                        
                                        
                                        <!--- Echo back POST data.
                                        <cfdump
                                            var="#deserializeJSON( requestBody )#"
                                            label="HTTP Body"
                                            />
                                         --->
                                         
                                         
                                            <cfset _id            = json_post.id>
                                            
                                            
                                            <cfset _full_name     = json_post.full_name>
											<cfset _name          = json_post.name>
                                            <cfset _password      = json_post.password>
                                            <cfset _agency        = json_post.agency>
                                            <cfset _level         = json_post.level>
                                            <cfset _power         = json_post.power>
                                            <cfset _cert          = json_post.cert>
                                            <cfset _ufd           = json_post.ufd>
                                            
                                          
                                            
                                            <!--- if you not sure whether 'some_key' exist or not use below code to check  --->
                                             <cfif StructKeyExists( json_post, "report")>
                                                                                 <cfset _report			= json_post.report >
                                                                             <cfelse>
                                                                                  <cfset _report 			= '' >  
                                                                            </cfif>
                                            <!--- End ---- if you not sure whether the 'some_key' exist or not use below code to check  --->
                                            
                                            
                                            
                                            
                                                   
                                     </cfif>	 
                                     
                                                    
                                                   
                                                   
                               <!---     ******   start update database     ******  --->     
								
										
                                 <cftransaction action="begin">
									<cftry>
                                                 
                                                 
                                         
                                         			<!---  -------------    update user  -----------  --->
										 
                                         
                                                                                          
                                                                                          
                                                                                          <cfquery name="update_user" datasource="#request.sqlconn#">
                                                                                         
                                                                                               UPDATE tblUsers
                                                                                               SET 
                                                                                                
                                                                                                      <!--- db column is varchar(), MUST use single quote, avoid sql error --->
                                                                                                      <!--- if db column is int or number type, then no need single quote --->
                                                                                                      
                                                                                                        User_FullName = '#_full_name#' ,
                                                                                                        User_Name    = '#_name#', 
                                                                                                        User_Password    = '#_password#', 
                                                                                                        User_Agency    = '#_agency#', 
                                                                                                        User_Level    = #_level#, 
                                                                                                        User_Power    = #_power#, 
                                                                                                        User_Cert    = #_cert#, 
                                                                                                        User_UFD    = #_ufd#, 
                                                                                                        User_Report    = '#_report#'
                                                                                                
                                                                                               WHERE 
                                                                                                      User_ID = #_id#
                                                                                         
                                                                                         </cfquery>
                                                                                          
                                                                                          
                                                                                         
                                                                               
                                                         
                                                              			
                                                        
                                                        
                                                        
                                                          <!--------- end ------ update user tables   ------------    --->  
                                                          
                                                          
                                                          
                                                          
                                                                         
                                                         
                                                          <cftransaction action="commit" />
                      
                                                          <!--- something happened, roll everyting back ---> 
                                                          <cfcatch type="any">
                                                         
                                                                                        <cftransaction action="rollback" />
                                                                                        
                                                                                         
																						<!--- <cfset _error = #cfcatch#>    ---> <!--- full error details in json --->
                                                                                        
																						 <cfset _error = #cfcatch.Message#>  <!--- only error message in string--->
                                                                                         
                                                                                         
                                                                                        <cfreturn _error>
                                                                                        <cfabort>
                                                                                        
                                                          </cfcatch>
                                                        
                                                        
                                                        
                                                        
                                               </cftry>
                                            </cftransaction>
                                            
                                            
                                            
                                               <!--- success  --->
                                              <cfset _result = "success"/>              
                                              <cfreturn _result>             
                                                          
                                                                
                                                   
                                                     
                                            
                                        </cffunction>
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                                             
                      <cffunction name="insertUser" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                                   
                                                   
                             <!---
                                Get the HTTP request body content.
                                NOTE: We have to use toString() as an intermediary method
                                call since the JSON packet comes across as a byte array
                                (binary data) which needs to be turned back into a string before
                                ColdFusion can parse it as a JSON value.
                                        --->
                                
                                <cfset requestBody = toString( getHttpRequestData().content ) />
                    
                                    <!--- Double-check to make sure it's a JSON value. --->
                                   
                                   
                                    <cfif isJSON( requestBody )>
                                    
                                    
                                        <cfset json_post = deserializeJson( requestBody ) >
                                        
                                        
                                        <!--- Echo back POST data.
                                        <cfdump
                                            var="#deserializeJSON( requestBody )#"
                                            label="HTTP Body"
                                            />
                                         --->
                                         
                                         
                                            
                                            
                                            <cfset _full_name     = json_post.full_name>
											<cfset _name          = json_post.name>
                                            <cfset _password      = json_post.password>
                                            <cfset _agency        = json_post.agency>
                                            <cfset _level         = json_post.level>
                                            <cfset _power         = json_post.power>
                                            <cfset _cert          = json_post.cert>
                                            <cfset _ufd           = json_post.ufd>
                                            
                                          
                                            
                                            <!--- if you not sure whether 'some_key' exist or not use below code to check  --->
                                             <cfif StructKeyExists( json_post, "report")>
                                                                                 <cfset _report			= json_post.report >
                                                                             <cfelse>
                                                                                  <cfset _report 			= '' >  
                                                                            </cfif>
                                            <!--- End ---- if you not sure whether the 'some_key' exist or not use below code to check  --->
                                            
                                            
                                            
                                            
                                                   
                                     </cfif>	 
                                     
                                                    
                                                   
                                                   
                               <!---     ******   start insert database     ******  --->     
								
										
                                 <cftransaction action="begin">
									<cftry>
                                                 
                                                 
                                         
                                         			<!---  -------------    insert user -----------  --->
										 
                                         
                                                                                          
                                                                                          
                                                                                          <cfquery name="insert_user" datasource="#request.sqlconn#">
                                                                                         
                                                                                               insert into tblUsers 
                                                                                               (
                                                                                                
                                                                                                      
                                                                                                        User_FullName, 
                                                                                                        User_Name,  
                                                                                                        User_Password, 
                                                                                                        User_Agency, 
                                                                                                        User_Level, 
                                                                                                        User_Power, 
                                                                                                        User_Cert, 
                                                                                                        User_UFD, 
                                                                                                        User_Report
                                                                                                 )
                                                                                                 
                                                                                                 values (
                                                                                                 
                                                                                                 
                                                                                                      <!--- db column is varchar(), MUST use single quote, avoid sql error --->
                                                                                                      <!--- if db column is int or number type, then no need single quote --->
                                                                                                      
                                                                                                        '#_full_name#',
                                                                                                        '#_name#', 
                                                                                                        '#_password#', 
                                                                                                        '#_agency#', 
                                                                                                         #_level#, 
                                                                                                         #_power#, 
                                                                                                         #_cert#, 
                                                                                                         #_ufd#, 
                                                                                                        '#_report#'
                                                                                                 
                                                                                                 
                                                                                                 
                                                                                                 
                                                                                                 )       
                                                                                                
                                                                                              
                                                                                         
                                                                                         </cfquery>
                                                                                          
                                                                                          
                                                                                         
                                                                               
                                                         
                                                              			
                                                        
                                                        
                                                        
                                                          <!--------- end ------ update user tables   ------------    --->  
                                                          
                                                          
                                                          
                                                          
                                                                         
                                                         
                                                          <cftransaction action="commit" />
                      
                                                          <!--- something happened, roll everyting back ---> 
                                                          <cfcatch type="any">
                                                         
                                                                                        <cftransaction action="rollback" />
                                                                                        
                                                                                         
																						<!--- <cfset _error = #cfcatch#>    ---> <!--- full error details in json --->
                                                                                        
																						 <cfset _error = #cfcatch.Message#>  <!--- only error message in string--->
                                                                                         
                                                                                         
                                                                                        <cfreturn _error>
                                                                                        <cfabort>
                                                                                        
                                                          </cfcatch>
                                                        
                                                        
                                                        
                                                        
                                               </cftry>
                                            </cftransaction>
                                            
                                            
                                            
                                               <!--- success  --->
                                              <cfset _result = "success"/>              
                                              <cfreturn _result>             
                                                          
                                                                
                                                   
                                                     
                                            
                                        </cffunction>
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                                        
                        <cffunction name="deleteUser" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                                   
                                                   
                             <!---
                                Get the HTTP request body content.
                                NOTE: We have to use toString() as an intermediary method
                                call since the JSON packet comes across as a byte array
                                (binary data) which needs to be turned back into a string before
                                ColdFusion can parse it as a JSON value.
                                        --->
                                
                                <cfset requestBody = toString( getHttpRequestData().content ) />
                    
                                    <!--- Double-check to make sure it's a JSON value. --->
                                   
                                   
                                    <cfif isJSON( requestBody )>
                                    
                                    
                                        <cfset json_post = deserializeJson( requestBody ) >
                                        
                                        
                                        <!--- Echo back POST data.
                                        <cfdump
                                            var="#deserializeJSON( requestBody )#"
                                            label="HTTP Body"
                                            />
                                         --->
                                         
                                         
                                            <cfset _id            = json_post.id>
                                            
                                            
                                     </cfif>	 
                                     
                                                    
                                                   
                                                   
                               <!---     ******   start delete      ******  --->     
								
										
                                 <cftransaction action="begin">
									<cftry>
                                                 
                                                 
                                         
                                         			<!---  -------------    delete user  -----------  --->
										 
                                         
                                                                                          
                                                                                          
                                                                                          <cfquery name="delete_user" datasource="#request.sqlconn#">
                                                                                         
                                                                                         
                                                                                               <!---
                                                                                               delete from tblUsers 
                                                                                               where  User_ID = #_id#
																							   --->
																							   
                                                                                               
                                                                                               UPDATE tblUsers
                                                                                               SET  
                                                                                                    User_Power    = -1
                                                                                                       
                                                                                               WHERE 
                                                                                                    User_ID = #_id#
                                                                                              
                                                                                              
                                                                                              
                                                                                         </cfquery>
                                                                                          
                                                                                          
                                                                                         
                                                                               
                                                         
                                                              			
                                                        
                                                        
                                                        
                                                          <!--------- end ------ delete user   ------------    --->  
                                                          
                                                          
                                                          
                                                          
                                                                         
                                                         
                                                          <cftransaction action="commit" />
                      
                                                          <!--- something happened, roll everyting back ---> 
                                                          <cfcatch type="any">
                                                         
                                                                                        <cftransaction action="rollback" />
                                                                                        
                                                                                         
																						<!--- <cfset _error = #cfcatch#>    ---> <!--- full error details in json --->
                                                                                        
																						 <cfset _error = #cfcatch.Message#>  <!--- only error message in string--->
                                                                                         
                                                                                         
                                                                                        <cfreturn _error>
                                                                                        <cfabort>
                                                                                        
                                                          </cfcatch>
                                                        
                                                        
                                                        
                                                        
                                               </cftry>
                                            </cftransaction>
                                            
                                            
                                            
                                               <!--- success  --->
                                              <cfset _result = "success"/>              
                                              <cfreturn _result>             
                                                          
                                                                
                                                   
                                                     
                                            
                                        </cffunction>
                                        
                                        
                                        
    
    
    <!--- ---- end ------ joe hu ---------- super admin ---------  9/6/2018 ---------------  --->
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    <!--- ---------- joe hu ---------- nanage users ---------  9/25/2018 ---------------  --->
    
    
              <cffunction name="get_user" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                    
                                             
                             <!---
                                Get the HTTP request body content.
                                NOTE: We have to use toString() as an intermediary method
                                call since the JSON packet comes across as a byte array
                                (binary data) which needs to be turned back into a string before
                                ColdFusion can parse it as a JSON value.
                                        --->
                                
                                <cfset requestBody = toString( getHttpRequestData().content ) />
                    
                                    <!--- Double-check to make sure it's a JSON value. --->
                                   
                                   
                                    <cfif isJSON( requestBody )>
                                    
                                    
                                        <cfset json_post = deserializeJson( requestBody ) >
                                        
                                        
                                        <!--- Echo back POST data.
                                        <cfdump
                                            var="#deserializeJSON( requestBody )#"
                                            label="HTTP Body"
                                            />
                                         --->
                                         
                                         
                                           
                                            
                                            <cfset _full_name     = json_post.full_name>
											<cfset _agency        = json_post.agency>
                                            <cfset _role          = json_post.role>
                                            
										    <cfset _order_by          = json_post.order_by>
                                            <cfset _asc_desc          = json_post.asc_desc>
                                        
                                     <!---   
                                        
                                     <cfreturn _asc_desc> 
                                    --->
                                    
                                    
                                        
                                        <!---
											<cfset _name          = json_post.name>
                                            <cfset _password      = json_post.password>
                                            
                                            <cfset _level         = json_post.level>
                                            <cfset _power         = json_post.power>
                                            <cfset _cert          = json_post.cert>
                                            <cfset _ufd           = json_post.ufd>
											
                                          --->
                                          
                                            
                                            <!--- if you not sure whether 'some_key' exist or not use below code to check  --->
                                            <!---
                                            
                                             <cfif StructKeyExists( json_post, "full_name")>
                                                                                 <cfset _full_name			= json_post.full_name >
                                                                             <cfelse>
                                                                                  <cfset _full_name 			= '' >  
                                                                            </cfif>
                                                                            
                                                                            
                                                                            
                                                                            
                                                                            
                                             <cfif StructKeyExists( json_post, "agency")>
                                                                                 <cfset _agency			= json_post.agency >
                                                                             <cfelse>
                                                                                  <cfset _agency 			= '' >  
                                                                            </cfif>        
                                                                            
                                                                                       
                                                                                       
                                                                                                   
                                                                            
                                              <cfif StructKeyExists( json_post, "role")>
                                                                                 <cfset _role			= json_post.role >
                                                                             <cfelse>
                                                                                  <cfset _role 			= '' >  
                                                                            </cfif>   
                                                                            
                                                                            
                                                                                                         
                                                --->                             
                                            <!--- End ---- if you not sure whether the 'some_key' exist or not use below code to check  --->
                                            
                                                
                                                
                                        </cfif>	 
                                         
                                                
                                                
                                                          
                                    
                                     <cftransaction action="begin">
									<cftry>
                                             
                                    
                                    
                                    
                                                   
                                                        <!---  User_Level = -1  means deleted user   --->
                                                      <cfquery name="select_user" datasource="#request.sqlconn#">
                                                                                         
                                                                  SELECT 
                                                                            User_ID        as id,
                                                                            User_FullName    as full_name,  
                                                                            User_Name    as  name,  
                                                                            User_Password    as  password,  
                                                                            User_Agency    as  agency,  
                                                                            User_Level    as  level,  
                                                                            User_Power    as  power,  
                                                                            User_Cert    as  cert,  
                                                                            User_UFD    as  ufd,  
                                                                            User_Report    as  report, 
                                                                            Role_Name as role
                                                                            
                                                                  FROM vwUserRole
                                                                  
                                                                  where  User_Level > -1   and  User_FullName <> 'Joe Hu'  and  User_FullName <> 'Nathan Neumann'
                                                                  
                                                                 and   User_FullName like <cfqueryparam cfsqltype="cf_sql_varchar" value="%#_full_name#%">
                                                                 
                                                                 
                                                                 
                                                                 <cfif len(_agency)>
                                                                 
                                                                     and User_Agency = '#_agency#'
                                                                    
                                                                 </cfif>
                                                                 
                                                                 
                                                                 <cfif len(_role)>
                                                                 
                                                                     and Role_Name = '#_role#'
                                                                    
                                                                 </cfif>
                                                                 
                                                                  <cfif len(_order_by)>
                                                                 
                                                                     order by '#_order_by#'  
                                                                    
                                                                 </cfif>     
                                                                     
                                                                  <!---    failed, not sure why  
                                                                  <cfif len(_asc_desc)>
                                                                 
                                                                      '#_asc_desc#'  
                                                                    
                                                                 </cfif>     
                                                                   --->
                                                                   
                                                                   
                                                                   <cfif _asc_desc eq 'asc'>
                                                                 
                                                                       asc
                                                                    
                                                                    </cfif>  
                                                                   
                                                                    <cfif _asc_desc eq 'desc'>
                                                                 
                                                                       desc
                                                                    
                                                                    </cfif>  
                                                                      
                                                                                        
                                                       </cfquery>
                                                       
                                                       
                                                       
                                                       
                                                       
                                                       
                                                       
                                                         
                                                          <cftransaction action="commit" />
                      
                                                          <!--- something happened, roll everyting back ---> 
                                                          <cfcatch type="any">
                                                         
                                                                                        <cftransaction action="rollback" />
                                                                                        
                                                                                         
																						<!--- <cfset _error = #cfcatch#>    ---> <!--- full error details in json --->
                                                                                        
																						 <cfset _error = #cfcatch.Message#>  <!--- only error message in string--->
                                                                                         
                                                                                         
                                                                                        <cfreturn _error>
                                                                                        <cfabort>
                                                                                        
                                                          </cfcatch>
                                                        
                                                        
                                                        
                                                        
                                               </cftry>
                                            </cftransaction>
                                            
                                                       
                                                       
                                                       
                                                       
                                                    <cfreturn select_user>
                                            
                                        </cffunction>
    
    
    
    
              <cffunction name="get_user_byid" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                <cfset requestBody = toString( getHttpRequestData().content ) />
                    
                                    <cfif isJSON( requestBody )>
                                    
                                        <cfset json_post = deserializeJson( requestBody ) >
                                        
                                            <cfset _user_id     = json_post.user_id>
											
                                        </cfif>	 
                                         
                                            
                                  <cftransaction action="begin">
									<cftry>
                                                  
                                                        <!---  User_Level = -1  means deleted user   --->
                                                      <cfquery name="select_user_by_id" datasource="#request.sqlconn#">
                                                                                         
                                                                  SELECT 
                                                                            User_ID        as id,
                                                                            User_FullName    as full_name,  
                                                                            User_Name    as  name,  
                                                                            User_Password    as  password,  
                                                                            User_Agency    as  agency,  
                                                                            User_Level    as  level,  
                                                                            User_Power    as  power,  
                                                                            User_Cert    as  cert,  
                                                                            User_UFD    as  ufd,  
                                                                            User_Report    as  report, 
                                                                            Role_Name as role
                                                                            
                                                                  FROM vwUserRole
                                                                  
                                                                  where  User_ID = #_user_id#
                                                                              
                                                       </cfquery>
                                                       
                                                       
                                                          <cftransaction action="commit" />
                      
                                                          <!--- something happened, roll everyting back ---> 
                                                          <cfcatch type="any">
                                                         
                                                                                        <cftransaction action="rollback" />
                                                                                        
                                                                                         
																						<!--- <cfset _error = #cfcatch#>    ---> <!--- full error details in json --->
                                                                                        
																						 <cfset _error = #cfcatch.Message#>  <!--- only error message in string--->
                                                                                         
                                                                                         
                                                                                        <cfreturn _error>
                                                                                        <cfabort>
                                                                                        
                                                          </cfcatch>
                                                        
                                               </cftry>
                                            </cftransaction>
                                            
                                                    <cfreturn select_user_by_id>
                                            
                                        </cffunction>
    
    
    
    
    
    
    
                    
                                        
                                        
                                                             
                      <cffunction name="insert_user" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                                   
                                                   
                             <!---
                                Get the HTTP request body content.
                                NOTE: We have to use toString() as an intermediary method
                                call since the JSON packet comes across as a byte array
                                (binary data) which needs to be turned back into a string before
                                ColdFusion can parse it as a JSON value.
                                        --->
                                
                                <cfset requestBody = toString( getHttpRequestData().content ) />
                    
                                    <!--- Double-check to make sure it's a JSON value. --->
                                   
                                   
                                    <cfif isJSON( requestBody )>
                                    
                                    
                                        <cfset json_post = deserializeJson( requestBody ) >
                                        
                                        
                                        <!--- Echo back POST data.
                                        <cfdump
                                            var="#deserializeJSON( requestBody )#"
                                            label="HTTP Body"
                                            />
                                         --->
                                         
                                         
                                            
                                            
                                            <cfset _full_name     = json_post.full_name>
											<cfset _name          = json_post.name>
                                            <cfset _password      = json_post.password>
                                            <cfset _agency        = json_post.agency>
                                            <cfset _role          = json_post.role>
                                            <cfset _cert          = json_post.certificate>
                                            <cfset _ufd           = 0>
                                            <cfset _report 			= '' >  
                                            
                                            
                                                   
                                     </cfif>	 
                                     
                                                    
                                                   
                                                   
                               <!---     ******   start insert database     ******  --->     
								
										
                                 <cftransaction action="begin">
									<cftry>
                                                 
                                                 
                                                      <cfquery name="getLeverPower_byRole" datasource="#request.sqlconn#">
                                                                                         
                                                              select * from tblRole
                                                              where Role_Name = '#_role#'
                                                 
                                                       </cfquery>
                                                 
                                                         <cfloop query = "getLeverPower_byRole"
                                                            startRow = "1"> 
                                                           
                                                         	<cfset _level          = getLeverPower_byRole.User_Level>
                                                          	<cfset _power         = getLeverPower_byRole.User_Power>
                                                          
                                                         </cfloop>
                                                         
                                                         
                                                        
                                                         
														 
                                             <!---  ------------- if user full name exist,  do not insert new user, instead update exist user -----------  --->     
                                                         
                                                         
                                                 <cfquery name="select_user_by_user_full_name" datasource="#request.sqlconn#">
                                                                                         
                                                                  SELECT User_FullName
                                                                            
                                                                  FROM tblUsers
                                                                  
                                                                  where  User_FullName = '#_full_name#'
                                                                              
                                                 </cfquery>
                                                         
                                                
                                               <!---   <cfreturn select_user_by_user_full_name>  --->   
                                                
                                                <cfif select_user_by_user_full_name.recordCount gt 0 >
                                                    
                                                        <!---  ------------- do not insert new user, instead update exist user -----------  --->     
                                                    
                                                    
                                                        <cfquery name="update_user_by_full_name" datasource="#request.sqlconn#">
                                                                                         
                                                                                         UPDATE tblUsers
                                                                                            SET 
                                                                                                  
                                                                                                  User_Name  = '#_name#', 
                                                                                                   User_Password = '#_password#',
                                                                                                   User_Agency   = '#_agency#',
                                                                                                   User_Level   =  #_level#, 
                                                                                                   User_Power    =   #_power#,
                                                                                                   User_Cert    =    #_cert#, 
                                                                                                   User_UFD     =     #_ufd#, 
                                                                                             
                                                                                             <!---  comment out this line to make sure,  User_Report is null,    --->      
                                                                                             <!---       User_Report    =   '#_report#'    --->   
                                                                                             
                                                                                                   
                                                                                                   
                                                                                            WHERE User_FullName = '#_full_name#'                                                                                                                                                                                     
                                                                                              
                                                                                              
                                                                                         
                                                         </cfquery>
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                    
                                                <cfelse>
                                                  
                                                      
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                                         
                                         
                                         			                                   <!---  -------------    insert user -----------  --->
										 
                                         
                                                                                          <cfquery name="insert_user" datasource="#request.sqlconn#">
                                                                                         
                                                                                               insert into tblUsers 
                                                                                               (
                                                                                                
                                                                                                      
                                                                                                        User_FullName, 
                                                                                                        User_Name,  
                                                                                                        User_Password, 
                                                                                                        User_Agency, 
                                                                                                        User_Level, 
                                                                                                        User_Power,
                                                                                                        
                                                                                                       
                                                                                                        User_Cert, 
                                                                                                        User_UFD
                                                                                                        
                                                                                                      <!---  comment out this line to make sure,  User_Report is null,    --->         
                                                                                                    <!---    User_Report    --->
																										
                                                                                                 )
                                                                                                 
                                                                                                 values (
                                                                                                 
                                                                                                 
                                                                                                      <!--- db column is varchar(), MUST use single quote, avoid sql error --->
                                                                                                      <!--- if db column is int or number type, then no need single quote --->
                                                                                                      
                                                                                                        '#_full_name#',
                                                                                                        '#_name#', 
                                                                                                        '#_password#', 
                                                                                                        '#_agency#', 
                                                                                                         #_level#, 
                                                                                                         #_power#,
                                                                                                         
                                                                                                         
                                                                                                         #_cert#, 
                                                                                                         #_ufd#
                                                                                                         
                                                                                                          <!---  comment out this line to make sure,  User_Report is null,    --->       
                                                                                                       <!---  '#_report#'    --->     
                                                                                                          
                                                                                                 
                                                                                                 
                                                                                                 
                                                                                                 )       
                                                                                                
                                                                                              
                                                                                         
                                                                                         </cfquery>
                                                                                          
                                                                                          
                                                        
                                                                                         <!--------- end ------ insert user  ------------    --->  
                                                          
                                                          
                                                           </cfif>       
                                                          
                                                                            
                                                         
                                                          <cftransaction action="commit" />
                      
                                                          <!--- something happened, roll everyting back ---> 
                                                          <cfcatch type="any">
                                                         
                                                                                        <cftransaction action="rollback" />
                                                                                        
                                                                                         
																						<!--- <cfset _error = #cfcatch#>    ---> <!--- full error details in json --->
                                                                                        
																						 <cfset _error = #cfcatch.Message#>  <!--- only error message in string--->
                                                                                         
                                                                                         
                                                                                        <cfreturn _error>
                                                                                        <cfabort>
                                                                                        
                                                          </cfcatch>
                                                        
                                                        
                                                        
                                                        
                                               </cftry>
                                            </cftransaction>
                                            
                                            
                                            
                                               <!--- success  --->
                                              <cfset _result = "success"/>              
                                              <cfreturn _result>             
                                                          
                                                                
                                                   
                                                     
                                            
                                        </cffunction>
    
    
    
    
    
    
                      
                                                             
                      <cffunction name="update_user" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                                   
                                                   
                             <!---
                                Get the HTTP request body content.
                                NOTE: We have to use toString() as an intermediary method
                                call since the JSON packet comes across as a byte array
                                (binary data) which needs to be turned back into a string before
                                ColdFusion can parse it as a JSON value.
                                        --->
                                
                                <cfset requestBody = toString( getHttpRequestData().content ) />
                    
                                    <!--- Double-check to make sure it's a JSON value. --->
                                   
                                   
                                    <cfif isJSON( requestBody )>
                                    
                                    
                                        <cfset json_post = deserializeJson( requestBody ) >
                                        
                                        
                                        <!--- Echo back POST data.
                                        <cfdump
                                            var="#deserializeJSON( requestBody )#"
                                            label="HTTP Body"
                                            />
                                         --->
                                         
                                         
                                            
                                            <cfset _id            = json_post.id>
                                            <cfset _full_name     = json_post.full_name>
											<cfset _name          = json_post.name>
                                            <cfset _password      = json_post.password>
                                            <cfset _agency        = json_post.agency>
                                            <cfset _role          = json_post.role>
                                            <cfset _cert          = json_post.certificate>
                                            <cfset _ufd           = 0>
                                            <cfset _report 			= '' >  
                                            
                                            
                                                   
                                     </cfif>	 
                                     
                                                    
                                                   
                                                   
                               <!---     ******   start update database     ******  --->     
								
										
                                 <cftransaction action="begin">
									<cftry>
                                                 
                                                 
                                                      <cfquery name="getLeverPower_byRole" datasource="#request.sqlconn#">
                                                                                         
                                                              select * from tblRole
                                                              where Role_Name = '#_role#'
                                                 
                                                       </cfquery>
                                                 
                                                         <cfloop query = "getLeverPower_byRole"
                                                            startRow = "1"> 
                                                           
                                                         	<cfset _level          = getLeverPower_byRole.User_Level>
                                                          	<cfset _power         = getLeverPower_byRole.User_Power>
                                                          
                                                         </cfloop>
                                                         
                                                         
                                                         
                                                         
                                                         
                                         
                                         			<!---  -------------    update user -----------  --->
										 
                                         
                                                                                          
                                                                                          
                                                                          <cfquery name="update_user" datasource="#request.sqlconn#">
                                                                                         
                                                                                         UPDATE tblUsers
                                                                                            SET 
                                                                                                  User_FullName = '#_full_name#',
                                                                                                  User_Name  = '#_name#', 
                                                                                                   User_Password = '#_password#',
                                                                                                   User_Agency   = '#_agency#',
                                                                                                   User_Level   =  #_level#, 
                                                                                                   User_Power    =   #_power#,
                                                                                                   User_Cert    =    #_cert#, 
                                                                                                   User_UFD     =     #_ufd#
                                                                                                   
                                                                                                   
                                                                                                <!---   User_Report    =   '#_report#'   --->
                                                                                                   
                                                                                                   
                                                                                            WHERE User_ID = #_id#                                                                                                                                                                                     
                                                                                              
                                                                                              
                                                                                         
                                                                                         </cfquery>
                                                                                          
                                                                                          
                                                                                         
                                                                               
                                                         
                                                              			
                                                        
                                                        
                                                        
                                                          <!--------- end ------ update user tables   ------------    --->  
                                                          
                                                          
                                                          
                                                          
                                                                         
                                                         
                                                          <cftransaction action="commit" />
                      
                                                          <!--- something happened, roll everyting back ---> 
                                                          <cfcatch type="any">
                                                         
                                                                                        <cftransaction action="rollback" />
                                                                                        
                                                                                         
																						<!--- <cfset _error = #cfcatch#>    ---> <!--- full error details in json --->
                                                                                        
																						 <cfset _error = #cfcatch.Message#>  <!--- only error message in string--->
                                                                                         
                                                                                         
                                                                                        <cfreturn _error>
                                                                                        <cfabort>
                                                                                        
                                                          </cfcatch>
                                                        
                                                        
                                                        
                                                        
                                               </cftry>
                                            </cftransaction>
                                            
                                            
                                            
                                               <!--- success  --->
                                              <cfset _result = "success"/>              
                                              <cfreturn _result>             
                                                          
                                                                
                                                   
                                                     
                                            
                                        </cffunction>
    
    
    
    
    
    
    
    
    
    
    
              <cffunction name="remove_user" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                <cfset requestBody = toString( getHttpRequestData().content ) />
                    
                                    <cfif isJSON( requestBody )>
                                    
                                        <cfset json_post = deserializeJson( requestBody ) >
                                        
                                            <cfset _user_id     = json_post.user_id>
											
                                        </cfif>	 
                                         
                                            
                                  <cftransaction action="begin">
									<cftry>
                                                  
                                                        <!---  User_Level = -1  means deleted user   --->
                                                      <cfquery name="remove_user_by_id" datasource="#request.sqlconn#">
                                                                                         
                                                                  update tblUsers 
                                                                           
                                                                  set User_Level = -1
                                                                      
                                                                  where  User_ID = #_user_id#
                                                                              
                                                       </cfquery>
                                                       
                                                       
                                                          <cftransaction action="commit" />
                      
                                                          <!--- something happened, roll everyting back ---> 
                                                          <cfcatch type="any">
                                                         
                                                                                        <cftransaction action="rollback" />
                                                                                        
                                                                                         
																						<!--- <cfset _error = #cfcatch#>    ---> <!--- full error details in json --->
                                                                                        
																						 <cfset _error = #cfcatch.Message#>  <!--- only error message in string--->
                                                                                         
                                                                                         
                                                                                        <cfreturn _error>
                                                                                        <cfabort>
                                                                                        
                                                          </cfcatch>
                                                        
                                               </cftry>
                                            </cftransaction>
                                            
                                                  
                                            
                                               <!--- success  --->
                                              <cfset _result = "success"/>              
                                              <cfreturn _result>             
                                                          
                                            
                                            
                                        </cffunction>
    
    
    
    
    
    
    
    
    
    
    
      <cffunction name="check_user" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                    
                           
                                
                                <cfset requestBody = toString( getHttpRequestData().content ) />
                    
                                    <!--- Double-check to make sure it's a JSON value. --->
                                   
                                   
                                    <cfif isJSON( requestBody )>
                                    
                                    
                                        <cfset json_post = deserializeJson( requestBody ) >
                                        
                                    
                                         
                                           
                                            
                                            <cfset _full_name     = json_post.full_name>
											<cfset _name          = json_post.name>
                                           
                                    
                                          
                                                
                                        </cfif>	 
                                         
                                                
                                                
                                                          
                                    
                                     <cftransaction action="begin">
									<cftry>
                                             
                                    
                                    
                                    
                                                   
                                                        <!---  User_Level = -1  means deleted user   --->
                                                      <cfquery name="check_user" datasource="#request.sqlconn#">
                                                                                         
                                                                  SELECT 
                                                                            *
                                                                            
                                                                  FROM tblUsers
                                                                  
                                                                  WHERE User_Level > -1 
                                                                  
                                                                  
                                                                  
                                                                   
                                                                 
                                                                 
                                                                 <cfif len(_full_name)>
                                                                 
                                                                  AND
                                                                 
                                                                      User_FullName = '#_full_name#'
                                                                    
                                                                 </cfif>
                                                                 
                                                                 
                                                                 <cfif len(_name)>
                                                                 
                                                                 AND
                                                                     User_Name = '#_name#'
                                                                    
                                                                 </cfif>
                                                                 
                                                                  
                                                                                        
                                                       </cfquery>
                                                       
                                                       
                                                       
                                                       
                                                       
                                                       
                                                       
                                                         
                                                          <cftransaction action="commit" />
                      
                                                          <!--- something happened, roll everyting back ---> 
                                                          <cfcatch type="any">
                                                         
                                                                                        <cftransaction action="rollback" />
                                                                                        
                                                                                         
																						<!--- <cfset _error = #cfcatch#>    ---> <!--- full error details in json --->
                                                                                        
																						 <cfset _error = #cfcatch.Message#>  <!--- only error message in string--->
                                                                                         
                                                                                         
                                                                                        <cfreturn _error>
                                                                                        <cfabort>
                                                                                        
                                                          </cfcatch>
                                                        
                                                        
                                                        
                                                        
                                               </cftry>
                                            </cftransaction>
                                            
                                                       
                                                       
                                                       
                                                       
                                                    <cfreturn check_user>
                                            
                                        </cffunction>
    
    
    
    
    
    
    
    
    
    <!--- ------- end --- joe hu ---------- nanage users ---------  9/25/2018 ---------------  --->
    
    
    
    
    
    
    
    
    
    
    
    
    <!--- joe hu 12/5/2018 ---------- do not count NON-SRP construction sites --------------- --->
 
     
 
 

    
    
    
    
    
    
              <cffunction name="getSubTypeByCategory" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                    
                           
                                
                                <cfset requestBody = toString( getHttpRequestData().content ) />
                    
                                    <!--- Double-check to make sure it's a JSON value. --->
                                   
                                   
                                    <cfif isJSON( requestBody )>
                                    
                                    
                                        <cfset json_post = deserializeJson( requestBody ) >
                                        
                                    
                                         
                                           
                                            
                                            <cfset _category  = json_post.category>
											
                                            
                                            
                                                
                                        </cfif>	 
                                         
                                                
                                                
                                                          
                                    
                                     <cftransaction action="begin">
									<cftry>
                                             
                                    
                                    
                                                      
                                                      <cfquery name="_getSubTypeByCategory" datasource="#request.sqlconn#">
                                                                                         
                                                                  SELECT 
                                                                            *
                                                                            
                                                                  FROM tblType
                                                                  
                                                                 WHERE  ( Category  =  '#_category#'   ) AND (Deleted IS NULL) 
                                                              
                                                                                        
                                                       </cfquery>
                                                       
                                                       
                                                       
                                                       
                                                       
                                                       
                                                       
                                                         
                                                          <cftransaction action="commit" />
                      
                                                          <!--- something happened, roll everyting back ---> 
                                                          <cfcatch type="any">
                                                         
                                                                                        <cftransaction action="rollback" />
                                                                                        
                                                                                         
																						<!--- <cfset _error = #cfcatch#>    ---> <!--- full error details in json --->
                                                                                        
																						 <cfset _error = #cfcatch.Message#>  <!--- only error message in string--->
                                                                                         
                                                                                         
                                                                                        <cfreturn _error>
                                                                                        <cfabort>
                                                                                        
                                                          </cfcatch>
                                                        
                                                        
                                                        
                                                        
                                               </cftry>
                                            </cftransaction>
                                            
                                                       
                                                       
                                                       
                                                       
                                                    <cfreturn _getSubTypeByCategory>
                                            
                                        </cffunction>
    
    
    
    
    
    
                       <cffunction name="getAllSubType" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                <cftransaction action="begin">
									<cftry>
                                              
                                                      <cfquery name="_getAllSubType" datasource="#request.sqlconn#">
                                                                                         
                                                                  SELECT 
                                                                            *
                                                                            
                                                                  FROM tblType
                                                                  
                                                                  WHERE deleted is null 
                                                                  
                                                                  ORDER BY type
                                                                                     
                                                       </cfquery>
                                                       
                                                       
                                                       
                                                         
                                                          <cftransaction action="commit" />
                      
                                                          <!--- something happened, roll everyting back ---> 
                                                          <cfcatch type="any">
                                                         
                                                                                        <cftransaction action="rollback" />
                                                                                        
                                                                                         
																						<!--- <cfset _error = #cfcatch#>    ---> <!--- full error details in json --->
                                                                                        
																						 <cfset _error = #cfcatch.Message#>  <!--- only error message in string--->
                                                                                         
                                                                                         
                                                                                        <cfreturn _error>
                                                                                        <cfabort>
                                                                                        
                                                          </cfcatch>
                                                        
                                               </cftry>
                                            </cftransaction>
                                            
                                                    <cfreturn _getAllSubType>
                                            
                                        </cffunction>
    
    
    
    
    
    
    
    
    
	<!--- joe hu 12/5/2018 ---------- do not count NON-SRP construction sites --------------- --->
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    <!--- --------------- super admin lock/unlock toggle for site editing ------------ 12/31/2018 joe hu------------ --->  
    
       <cffunction name="site_lock" access="remote" returnType="any" returnFormat="json" output="false">
                                    
                                    
                           
                                
                                <cfset requestBody = toString( getHttpRequestData().content ) />
                    
                                    <!--- Double-check to make sure it's a JSON value. --->
                                   
                                   
                                    <cfif isJSON( requestBody )>
                                    
                                    
                                        <cfset json_post = deserializeJson( requestBody ) >
                                        
                                    
                                         
                                           
                                            
                                            <cfset _site_number  = json_post.site_number>
											
                                             <cfset _lock_value  = json_post.lock_value>
                                            
                                                
                                        </cfif>	 
                                         
                                                
                                                
                                                          
                                    
                                     <cftransaction action="begin">
									<cftry>
                                             
                                    
                                    
                                                      
                                                      <cfquery name="_updateSiteLockStatus" datasource="#request.sqlconn#">
                                                                                         
                                                                  UPDATE tblSites
                                                                    SET Locked = #_lock_value#
                                                                    WHERE Location_No =  #_site_number#
                                                              
                                                                                        
                                                       </cfquery>
                                                       
                                                       
                                                       
                                                            <!--- --------- update related curbRamp associated with this site number ---------    --->
                                                       
                                                       
                                                                    <cfquery name="_getRampBySite" datasource="#request.sqlconn#">
                                                                                         
                                                                              select Ramp_No from tblCurbRamps
                                                                              where Location_No = #_site_number#
                                                              
                                                                                        
                                                       				</cfquery>
                                                       
                                                       
                                                       
                                                       
                                                                     <cfloop query = "_getRampBySite"> 
																		
                                                                             <cfquery name="_updateCurbRampLockStatus" datasource="#request.sqlconn#">
                                                                                         
                                                                                          UPDATE tblCurbRamps
                                                                                            SET Locked = #_lock_value#
                                                                                            WHERE Ramp_No =  #Ramp_No#
                                                                                      
                                                                                                                
                                                                               </cfquery>
                                                                        
                                                                        
                                                                        
                                                                    </cfloop>
                                                       
                                                       
                                                       
                                                              <!--- --------- end -------------- update related curbRamp associated with this site number --->
                                                       
                                                       
                                                       
                                                       
                                                       
                                                         
                                                          <cftransaction action="commit" />
                      
                                                          <!--- something happened, roll everyting back ---> 
                                                          <cfcatch type="any">
                                                         
                                                                                        <cftransaction action="rollback" />
                                                                                        
                                                                                         
																						<!--- <cfset _error = #cfcatch#>    ---> <!--- full error details in json --->
                                                                                        
																						 <cfset _error = #cfcatch.Message#>  <!--- only error message in string--->
                                                                                         
                                                                                         
                                                                                        <cfreturn _error>
                                                                                        <cfabort>
                                                                                        
                                                          </cfcatch>
                                                        
                                                        
                                                        
                                                        
                                               </cftry>
                                            </cftransaction>
                                            
                                                       
                                                      <!--- success  --->
													  <cfset _result = "success"/>              
                                                      <cfreturn _result>     
                                                       
                                                       
                                                   
                                            
                                        </cffunction>
              
    
             
    
    
    
    
    
    <!--- --------- End ------ super admin lock/unlock toggle for site editing ------------ 12/31/2018 joe hu------------ --->  
    
    
    
    
    
	
</cfcomponent>
