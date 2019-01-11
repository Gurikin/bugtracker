<cf_template pagename="Users list">
	<!--- set default sort variables --->
	<cfset url.orderBy = (structKeyExists(url, "orderBy") ? url.orderBy : "fname")>
	<cfset url.sortOrder = (structKeyExists(url, "sortOrder") ? url.sortOrder : "ASC")>
	<!--- get the query results with all users --->
	<cfset userList = application.userController.getAllUsers("", url.orderBy, url.sortOrder)>
	<!--- table with users info --->
	<div class="container">
		<table class="col-12 table table-hover table-dark border">
			<thead class="text-center">
				<th scope="col">
					<a href="?orderBy=fname&sortOrder=<cfoutput>#((url.orderBy == 'fname' and url.sortOrder == 'ASC') ? 'DESC' : 'ASC')#</cfoutput>">
						First name
					</a>
				</th>
				<th>
					<a href="?orderBy=lname&sortOrder=<cfoutput>#((url.orderBy == 'lname' and url.sortOrder == 'ASC') ? 'DESC' : 'ASC')#</cfoutput>">
						Last Name
					</a>
				</th>
				<th>
					<a href="?orderBy=email&sortOrder=<cfoutput>#((url.orderBy == 'email' and url.sortOrder == 'ASC') ? 'DESC' : 'ASC')#</cfoutput>">
						Email
					</a>
				</th>
			</thead>
			<tbody class="text-center">				
				<cfoutput query="userList">
					<tr onclick="document.location = 'userDetails.cfm?email=#userList.email#'">
						<td>
							#userList.fName#
						</td>
						<td>
							#userList.lName#
						</td>
						<td>
							#userList.email#
						</td>
					</tr>
				</cfoutput>
			</tbody>
		</table>
	</div>
</cf_template>