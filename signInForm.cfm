<cf_template pagename="Authentication page">
	<!---If form is submitted--->
	<cfif structKeyExists(#form#, 'submitSignin')>
		<cfset application.isUserLoggedIn = application.authController.signIn(form.field_userEmail, 
		                                                                      form.field_userPassword)>
		<cfif not isUserLoggedIn()>
			<p class="text-danger">
				Wrong email and/or password. Please try again!
			</p>
		</cfif>
	</cfif>
	<!--- sign in form --->
	<div class="container col-5">
		<cfform class="form-signin" id="formSignin" preservedata="true">
			<fieldset>
			<legend>
				Sign in
			</legend>
			<div class="form-label-group">
				<cfinput class="form-control" placeholder="Email" type="email" name="field_userEmail"
				         id="field_userEmail" required="true" validate="email" validateat="onSubmit"
				         message="Please, enter a valid e-mail Address"/>
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
			<div class="d-flex justify-content-between">
				<cfinput class="btn btn-lg btn-primary btn-block" type="submit" name="submitSignin" 
				         id="submitSignin" value="SignIn"/>
			</div>
		</cfform>
	</div>
</cf_template>