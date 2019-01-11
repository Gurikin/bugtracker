<cf_template pagename="User details page">
	<!--- get query results --->
	<cfset bugDetails = application.bugController.getBugByID(url.id)>
	<cfset bugHistory = application.bugHistoryController.getBugHistory(url.id)>
	<!--- submit form handle --->
	<cfif structKeyExists(#form#, 'submitChangeStatus')>
		<cfif application.bugHistoryController.changeStatus(bugDetails.bug_id, form.submitChangeStatus, 
		                                                    form.field_comment) and application.bugController.changeStatus(bugDetails.bug_id, 
		                                                                                                                   form.submitChangeStatus)>
			<cflocation url="bugDetails.cfm?id=#bugDetails.bug_id#">
		</cfif>
	</cfif>
	<!--- if can't find the bug --->
	<div class="container d-block col-lg-5 col-md-6 col-sm-12 col-xs-12 bt-container-list">
		<cfif (not structKeyExists(url, 'id')) or (bugDetails.RecordCount == 0)>
			<p class="text-danger">
				Oops! We can't find the details about the bug with this id. Please, try again.
			</p>
			<cfabort>
		</cfif>
		<!--- bug details list --->
		<cfoutput query="bugDetails">
			<h2>
				Bug detailed information
			</h2>
			<div class="d-flex justify-content-end">
				<a class="btn btn-sm btn-primary btn-block col-lg-5 col-md-6 col-sm-8 col-xs-7 mb-2" href="bugAdd.cfm?id=#bugDetails.bug_id#">
					Update bug
				</a>
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
					            message="Please, fill a comment field" rows=4/>
					<label for="field_comment">
						Add the comment, if you want to change the status of bug
					</label>
				</div>
				<div class="d-flex justify-content-between">
					<cfif bugDetails.status == 'solved'>
						<cfinput class="btn btn-md btn-primary btn-inline-block col-5" type="submit" 
						         name="submitChangeStatus" id="submitChangeStatus" 
						         value="#application.utils.changeStatusButton(bugDetails.status)[1]#">
						<cfinput class="btn btn-md btn-primary btn-inline-block col-5" type="submit" 
						         name="submitChangeStatus" id="submitChangeStatus" 
						         value="#application.utils.changeStatusButton(bugDetails.status)[2]#"/>
					<cfelse>
						<cfinput class="btn btn-md btn-primary btn-block" type="submit" name="submitChangeStatus" 
						         id="submitChangeStatus" 
						         value="#application.utils.changeStatusButton(bugDetails.status)[1]#"/>
					</cfif>
				</div>
			</cfform>
		</cfoutput>
	</div>
	<hr>
	
	<!--- bug history list --->
	<div class="container col-10 d-block justify-content-between bt-container-table">
	<h2 class="text-center">
		<cfoutput>
			Bug change history
		</cfoutput>
	</h2>
		<table class="col-12 table table-hover border">
			<thead class="text-center">
				<th scope="col">
					Status action
				</th>
				<th>
					Date of changes
				</th>
				<th>
					User comment
				</th>
				<th>
					User email
				</th>
			</thead>
			<tbody class="text-center">
				<cfoutput query="bugHistory">
					<tr>
						<td>
							#bugHistory.action#
						</td>
						<td>							
							#DateTimeFormat(bugHistory.action_date,"yyyy-mm-dd HH:nn:ss")#							
						</td>
						<td>
							#bugHistory.action_comment#
						</td>
						<td>
							<a href="userDetails.cfm?email=#bugHistory.user_email#">
								#bugHistory.user_email#
							</a>
						</td>
					</tr>
				</cfoutput>
			</tbody>
		</table>
	</div>
</cf_template>