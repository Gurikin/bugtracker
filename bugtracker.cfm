<cf_template pagename="Bug tracker">
	<!--- set default sort variables --->
	<cfset url.orderBy = (structKeyExists(url, "orderBy") ? url.orderBy : "find_date")>
	<cfset url.sortOrder = (structKeyExists(url, "sortOrder") ? url.sortOrder : "ASC")>
	<!--- get query result with list of all bugs (status != closed)--->
	<cfset bugList = application.bugController.getAllBugs("closed", url.orderBy, url.sortOrder)>
	<!--- bugs list --->	
	<div class="container bt-container-table-lg">
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
				<cfloop index="i" from="1" to="#arrayLen(bugList)#">
					<cfset bug_id = bugList[i][1]>
					<cfoutput>
						<tr onclick="document.location = 'bugDetails.cfm?id=#bug_id#'">
							<td>
								#bugList[i][2]#
							</td>
							<td>
								#bugList[i][3]#
							</td>
							<td class="#application.utils.getBugTrClass(bugList[i][5])#">
								#bugList[i][5]#
							</td>
							<td class="#application.utils.getBugTrClass(bugList[i][6])#">
								#bugList[i][6]#
							</td>
							<td class="#application.utils.getBugTrClass(bugList[i][7])#">
								#bugList[i][7]#
							</td>
							<td>
								<a href="userDetails.cfm?email=#bugList[i][8]#">
									#bugList[i][8]#
								</a>
							</td>
						</tr>
					</cfoutput>
				</cfloop>
			</tbody>
		</table>
	</div>
</cf_template>