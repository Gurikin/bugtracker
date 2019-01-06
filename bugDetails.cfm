<cf_template pagename="User details page">
	<cfset bugDetails = application.bugController.getBugByID(url.id)>
	<cfif structKeyExists(#form#, 'submitChangeStatus')>
		<cfif application.bugController.updateBugHistory(bugDetails.bug_id, form.submitChangeStatus, form.field_comment)>
			<cflocation url="bugDetails.cfm?id=#bugDetails.bug_id#">
		</cfif>		
	</cfif>	
	<div class="container col-5">
		<cfif (not structKeyExists(url, 'id')) or (bugDetails.RecordCount == 0)>
			<p class="text-danger">
				Oops! We can't find the details about the bug with this id. Please, try again.
			</p>
			<cfabort>
		</cfif>
		<cfoutput query="bugDetails">
			<h2>
				Details about bug ## 
				#bugDetails.bug_id#
			</h2>
			<div class="d-flex justify-content-end">
				<a class="btn btn-sm btn-primary btn-block col-2" href="bugAdd.cfm?id=#bugDetails.bug_id#">Update bug</a>				
			</div>			
			<ul class="list-group">
				<li class="list-group-item">
					#bugDetails.find_date#
				</li>
				<li class="list-group-item">
					#bugDetails.short_desc#
				</li>
				<li class="list-group-item">
					#bugDetails.full_desc#
				</li>
				<li class="list-group-item">
					#bugDetails.urgency#
				</li>
				<li class="list-group-item">
					#bugDetails.criticality#
				</li>
				<li class="list-group-item d-flex justify-content-between align-items-center">
					#bugDetails.status#
				</li>
			</ul>
		</cfoutput>
		<cfoutput>
			<cfform id="formBugHistory" preservedata="true">
				<div class="form-label-group">
					<cftextarea class="form-control" placeholder="Comment" type="text" name="field_comment"
					            id="field_comment" required="true" validateat="onSubmit" 
					            message="Please, fill a comment field" rows=4 />
					<label for="field_comment">
						Add the comment, if you want to change the status of bug
					</label>
				</div>
				<div class="d-flex justify-content-between">
					<cfif bugDetails.status == 'solved'>
						<cfinput class="btn btn-md btn-primary btn-inline-block col-5" type="submit" name="submitChangeStatus" id="submitChangeStatus" value="#application.utils.changeStatusButton(bugDetails.status)[1]#">
						<cfinput class="btn btn-md btn-primary btn-inline-block col-5" type="submit" name="submitChangeStatus" id="submitChangeStatus" value="#application.utils.changeStatusButton(bugDetails.status)[2]#"/>
						<cfelse>
						<cfinput class="btn btn-md btn-primary btn-block" type="submit" name="submitChangeStatus" id="submitChangeStatus" value="#application.utils.changeStatusButton(bugDetails.status)[1]#"/>
					</cfif>
					
				</div>
			</cfform>
		</cfoutput>
	</div>	
</cf_template>