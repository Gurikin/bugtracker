<cf_template pagename="Users list">	
	<cfset url.orderBy = (structKeyExists(url,"orderBy") ? url.orderBy : "fname")>
	<cfset url.sortOrder = (structKeyExists(url,"sortOrder") ? url.sortOrder : "ASC")>
	<cfset userList = application.userController.getAllUsers("", url.orderBy, url.sortOrder)>	
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
			</thead>
			<tbody class="text-center">
				<cfoutput query="userList">
					<cfset user_id = userList.email>
					<tr onclick="document.location = 'userDetails.cfm?email=#user_id#'">
						<td>
							#userList.fname#
						</td>
						<td>
							#userList.lname#
						</td>						
					</tr>
				</cfoutput>
			</tbody>
		</table>
	</div>
</cf_template>