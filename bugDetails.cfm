<cf_template pagename="User details page">
	<!--- get query results --->
	<cfset bugDetails = application.bugController.getBugByID(url.id)>	
	<!--- submit form handle --->
	<cfif structKeyExists(#form#, 'submitChangeStatus')>
		<cfif application.bugHistoryController.changeStatus(bugDetails.getbug_id(), form.submitChangeStatus, 
		                                                    form.field_comment) and application.bugController.changeStatus(bugDetails.getbug_id(), 
		                                                                                                                   form.submitChangeStatus)>
			<cflocation url="bugDetails.cfm?id=#bugDetails.getbug_id()#">
		</cfif>
	</cfif>
	<!--- if can't find the bug --->
	<div class="container d-block col-lg-5 col-md-6 col-sm-12 col-xs-12 bt-container-list">
		<cfif (not structKeyExists(url, 'id')) or (IsNull(bugDetails))>
			<p class="text-danger">
				Oops! We can't find the details about the bug with this id. Please, try again.
			</p>
			<cfabort>
		</cfif>
		<!--- bug details list --->
		<cfoutput>
			<h2>
				Bug detailed information
			</h2>
			<div class="d-flex justify-content-end">
				<a class="btn btn-sm btn-primary btn-block col-lg-5 col-md-6 col-sm-8 col-xs-7 mb-2" 
				   href="bugAdd.cfm?id=#bugDetails.getbug_id#">
					Update bug
				</a>
			</div>
			<ul class="list-group">
				<li class="list-group-item">
					#bugDetails.getfind_date()#
				</li>
				<li class="list-group-item">
					#bugDetails.getshort_desc()#
				</li>
				<li class="list-group-item">
					#bugDetails.getfull_desc()#
				</li>
				<li class="list-group-item">
					#bugDetails.geturgency()#
				</li>
				<li class="list-group-item">
					#bugDetails.getcriticality()#
				</li>
				<li class="list-group-item d-flex justify-content-between align-items-center">
					#bugDetails.getstatus()#
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
					<cfif bugDetails.getstatus == 'solved'>
						<cfinput class="btn btn-md btn-primary btn-inline-block col-5" type="submit" 
						         name="submitChangeStatus" id="submitChangeStatus" 
						         value="#application.utils.changeStatusButton(bugDetails.getstatus())[1]#"/>
						<cfinput class="btn btn-md btn-primary btn-inline-block col-5" type="submit" 
						         name="submitChangeStatus" id="submitChangeStatus" 
						         value="#application.utils.changeStatusButton(bugDetails.getstatus())[2]#"/>
					<cfelse>
						<cfinput class="btn btn-md btn-primary btn-block" type="submit" name="submitChangeStatus" 
						         id="submitChangeStatus" 
						         value="#application.utils.changeStatusButton(bugDetails.getstatus())[1]#"/>
					</cfif>
				</div>
			</cfform>
		</cfoutput>
	</div>
	<hr>

	<!--- bug history list --->
	<div class="container col-10 d-block justify-content-between bt-container-table">
		<h2 class="text-center">
			<cfoutput>Bug change history</cfoutput>
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
				<cfoutput>
					<cfloop index="i" from="1" to="#arraylen(bugDetails.getHistory())#">
						<tr>
							<td>
								#bugDetails.getHistory()[i].getaction()#
							</td>
							<td>
								#DateTimeFormat(bugDetails.getHistory()[i].getAction_date(), "yyyy-mm-dd HH:nn:ss")#								
							</td>
							<td>
								#bugDetails.getHistory()[i].getaction_comment()#
							</td>
							<td>
								<a href="userDetails.cfm?email=#bugDetails.getHistory()[i].getuser_email()#">
									#bugDetails.getHistory()[i].getuser_email()#
								</a>
							</td>
						</tr>
					</cfloop>
				</cfoutput>
			
				<!---<cfoutput collection="#bugDetails.getHistory()#">
				    
				</cfoutput>--->
			</tbody>
		</table>
	</div>
</cf_template>