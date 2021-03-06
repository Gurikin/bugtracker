<cf_template pagename="Bug tracker">
	<!--- set default sort variables --->
	<cfset url.orderBy = (structKeyExists(url, "orderBy") ? url.orderBy : "find_date")>
	<cfset url.sortOrder = (structKeyExists(url, "sortOrder") ? url.sortOrder : "ASC")>
	<!--- get query result with list of all opened bugs binded with specific user --->
	<cfset bugList = application.bugController.getOpenedBugsByUserID(url.email)>
	<!--- bugs list --->
	<div class="container">
		<table class="col-12 table table-hover table-dark border">
			<thead class="text-center">
				<th scope="col">
					<a href="?orderBy=find_date&sortOrder=<cfoutput>#((url.orderBy == 'find_date' and url.sortOrder == 'ASC') ? 'DESC' : 'ASC')#</cfoutput>">
						Find date
					</a>
				</th>
				<th>
					<a href="?orderBy=short_desc&sortOrder=<cfoutput>#((url.orderBy == 'short_desc' and url.sortOrder == 'ASC') ? 'DESC' : 'ASC')#</cfoutput>">
						Short description
					</a>
				</th>
				<th>
					<a href="?orderBy=status&sortOrder=<cfoutput>#((url.orderBy == 'status' and url.sortOrder == 'ASC') ? 'DESC' : 'ASC')#</cfoutput>">
						Status
					</a>
				</th>
				<th>
					<a href="?orderBy=urgency&sortOrder=<cfoutput>#((url.orderBy == 'urgency' and url.sortOrder == 'ASC') ? 'DESC' : 'ASC')#</cfoutput>">
						Urgency
					</a>
				</th>
				<th>
					<a href="?orderBy=criticality&sortOrder=<cfoutput>#((url.orderBy == 'criticality' and url.sortOrder == 'ASC') ? 'DESC' : 'ASC')#</cfoutput>">
						Criticality
					</a>
				</th>
				<th>
					<a href="?orderBy=criticality&sortOrder=<cfoutput>#((url.orderBy == 'usr_email' and url.sortOrder == 'ASC') ? 'DESC' : 'ASC')#</cfoutput>">
						User
					</a>
				</th>
			</thead>
			<tbody class="text-center">
				<cfoutput query="bugList">
					<cfset bug_id = bugList.bug_id>
					<tr onclick="document.location = 'bugDetails.cfm?id=#bug_id#'">
						<td>
							#bugList.find_date#
						</td>
						<td>
							#bugList.short_desc#
						</td>
						<td class="#application.utils.getBugTrClass(bugList.status)#">
							#bugList.status#
						</td>
						<td class="#application.utils.getBugTrClass(bugList.urgency)#">
							#bugList.urgency#
						</td>
						<td class="#application.utils.getBugTrClass(bugList.criticality)#">
							#bugList.criticality#
						</td>
						<td>
							<a href="userDetails.cfm?email=#bugList.usr_email#">
								#bugList.usr_email#
							</a>
						</td>
					</tr>
				</cfoutput>
			</tbody>
		</table>
	</div>
</cf_template>