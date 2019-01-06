<cf_template pagename="Bug add/update page">
	<cfoutput>
	<div class="container col-5">
		<cfform id="formBug" preservedata="true">
			<fieldset>
			<cfset bugColumns = application.bugController.getEnumStructs()>
			<cfif (not structKeyExists(url, 'id'))>
				<cfset bugDetails = {find_date = DateTimeFormat(now(),"yyyy-mm-dd"), short_desc = '', full_desc = '', status = 'new', urgency = 'urgently', criticality = 'dont critical'}>
				<cfset btnText = 'Add bug'>				
				<legend>
					Add bug to the bugTracker list				
				</legend>
				<cfelse>
				<cfset bugDetails = application.bugController.getBugByID(url.id)>
				<cfset btnText = 'Update bug info'>
				<legend>
					Details of bug ## #bugDetails.bug_id#				
				</legend>
			</cfif>			
						
				<div class="form-label-group">
					<cfinput class="form-control" placeholder="findDate" type="date" name="field_findDate"
					         id="field_findDate" required="true" validate="date" validateat="onSubmit"
					         message="Please, enter a valid date" value=#bugDetails.find_date#/>					         
					<label for="field_findDate">
						Date of find bug. 
					</label>
				</div>
				<div class="form-label-group">
					<cfinput class="form-control" placeholder="Short description" type="text" name="field_shortDesc"
					         id="field_shortDesc" required="true" value=#bugDetails.short_desc#/>
					<label for="field_shortDesc">
						Short description of bug 
					</label>
				</div>
				<div class="form-label-group">
					<cfinput class="form-control" placeholder="Full description" type="text" name="field_fullDesc"
					         id="field_fullDesc" required="false" value=#bugDetails.full_desc#/>
					<label for="field_fullDesc">
						Full description of bug 
					</label>
				</div>				
				<div class="form-label-group">
					<cfselect size="1" name="status" class="custom-select">
					<cfloop collection="#bugColumns[1]#" item="itm">
						<cfset enumItem = "#bugColumns[1][itm]#" >
						<cfif (bugDetails.status EQ enumItem)>
							<option class = "#application.utils.getBugTrClass(enumItem)#" value="#enumItem#" selected>#enumItem#</option>
						<cfelse>
							<option class = "#application.utils.getBugTrClass(enumItem)#" value="#enumItem#">#enumItem#</option>
						</cfif>										    	 
					</cfloop>
					</cfselect>
					<label for="status">
						Select the status of bug 
					</label>
				</div>				
				<div class="form-label-group">
					<cfselect size="1" name="urgency" class="custom-select">
					<cfloop collection="#bugColumns[2]#" item="itm">
						<cfset enumItem = "#bugColumns[2][itm]#" >
						<cfif (bugDetails.urgency EQ enumItem)>
							<option class = "#application.utils.getBugTrClass(enumItem)#" value="#enumItem#" selected>#enumItem#</option>
						<cfelse>
							<option class = "#application.utils.getBugTrClass(enumItem)#" value="#enumItem#">#enumItem#</option>
						</cfif>										    	 
					</cfloop>
					</cfselect>
					<label for="status">
						Select the urgency of bug 
					</label>
				</div>
				<div class="form-label-group">
					<cfselect size="1" name="criticality" class="custom-select">
					<cfloop collection="#bugColumns[3]#" item="itm">
						<cfset enumItem = "#bugColumns[3][itm]#" >
						<cfif (bugDetails.criticality EQ enumItem)>
							<option class = "#application.utils.getBugTrClass(enumItem)#" value="#enumItem#" selected>#enumItem#</option>
						<cfelse>
							<option class = "#application.utils.getBugTrClass(enumItem)#" value="#enumItem#">#enumItem#</option>
						</cfif>										    	 
					</cfloop>
					</cfselect>
					<label for="status">
						Select the criticality of bug 
					</label>
				</div>
							
				<div class="d-flex justify-content-between">
					<cfinput class="btn btn-lg btn-primary btn-block" type="submit" name="submitUpdateBug" 
					         id="submitUpdateBug" value="#btnText#"/>
				</div>			
		</cfform>
	</div>		
	</cfoutput>	
</cf_template>