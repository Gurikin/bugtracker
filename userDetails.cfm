<cf_template pagename="User details page">
	<cfset userDetails = application.userController.getUserByID(url.email)>
	<cfset userBugs = application.bugController.getOpenedBugsByUserID(url.email)>
	<div class="container col-5">
		<cfif (not structKeyExists(url, 'email')) or (userDetails.RecordCount == 0)>
			<p class="text-danger">
				Oops! We can't find the details about the user with this email. Please, try again.
			</p>
			<cfabort>
		</cfif>		
		<cfoutput>
			<h2>
				Details about 
				#userDetails.fname# 
				#userDetails.lname#
			</h2>
			<ul class="list-group">
				<li class="list-group-item">
					#userDetails.email#
				</li>
				<li class="list-group-item">
					#userDetails.fname#
				</li>
				<li class="list-group-item">
					#userDetails.lname#
				</li>
				<li class="list-group-item d-flex justify-content-between align-items-center">
					<a href='personalBugs.cfm?email=#userDetails.email#'>
						Opened bugs
					</a>
					<span class="badge badge-primary badge-pill">
						#userBugs.RecordCount#
					</span>
				</li>
			</ul>
			<cfif #userDetails.email# == #session.stLoggedInUser.userID#>
				<div class="d-flex justify-content-between">
					<button class="btn btn-lg btn-primary btn-block" name="updateUser" id="updateUser" 
					        value="Update" 
					        onclick="document.location = 'userProfile.cfm?email=#userDetails.email#'">
						Update
					</button>
				</div>
			</cfif>
		</cfoutput>
	</div>
</cf_template>