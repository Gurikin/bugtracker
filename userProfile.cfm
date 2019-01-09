<cf_template pagename="User profile update page">
	<!--- get and handle the user details info --->
	<cfset userDetails = application.userController.getUserByID(url.email)>
	<cfif userDetails.RecordCount EQ 0>
		<p class="text-danger">
			Sorry, we can't find user with this email. Please, try again.
		</p>
	</cfif>
	<!--- submit form handle --->
	<cfif structKeyExists(#form#, 'submitUpdateProfile')>
		<cfif application.userController.updateUserProfile(form.field_userEmail, form.field_userName, 
		                                                   form.field_userSoname,form.field_userPassword)>
			<cflocation url="userProfile.cfm?email=#session.stLoggedInUser.userID#">
		<cfelse>
			<p class="text-danger">
				Sorry, we have the exceptional situation. Please, try again.
			</p>
		</cfif>
	</cfif>
	<!--- user profile update form here --->
	<cfoutput>
		<div class="container col-5">
			<cfform id="formUserDetails" preservedata="true">
				<fieldset>
				<legend>
					Your profile details
				</legend>
				<div class="form-label-group">
					<cfinput class="form-control" placeholder="Email" type="email" name="field_userEmail"
					         id="field_userEmail" required="true" validate="email" validateat="onSubmit"
					         message="Please, enter a valid e-mail Address" value="#userDetails.email#"/>
					<label for="field_userEmail">
						E-mail address
					</label>
				</div>
				<div class="form-label-group">
					<cfinput class="form-control" placeholder="Password" type="password" name="field_userPassword"
					         id="field_userPassword" required="true" validateat="onSubmit" 
					         message="Please, provide a password"/>
					<label for="field_userPassword">
						Password
					</label>
				</div>
				<div class="form-label-group">
					<cfinput class="form-control" placeholder="Name" type="text" name="field_userName"
					         id="field_userName" required="true" validateat="onSubmit" 
					         message="Please, provide a name" value="#userDetails.fname#"/>
					<label for="field_userName">
						Your name
					</label>
				</div>
				<div class="form-label-group">
					<cfinput class="form-control" placeholder="Soname" type="text" name="field_userSoname"
					         id="field_userSoname" required="true" validateat="onSubmit" 
					         message="Please, provide a name" value="#userDetails.lname#"/>
					<label for="field_userSoname">
						Your soname
					</label>
				</div>
				<div class="d-flex justify-content-between">
					<cfinput class="btn btn-lg btn-primary btn-block" type="submit" name="submitUpdateProfile" 
					         id="submitUpdateProfile" value="Update profile"/>
				</div>
			</cfform>
		</div>
	</cfoutput>
</cf_template>