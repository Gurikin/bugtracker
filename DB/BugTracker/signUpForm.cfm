<cf_template pagename="Authentication page">
	<cfif structKeyExists(#form#, 'submitSignup')>
		<cfset application.isUserLoggedIn = application.authServe.signUp(form.field_userEmail, form.field_userName, form.field_userSoname, form.field_userPassword)>
	</cfif>	
	<div class="container col-5">
		<cfform class="form-signin" id="formSignup" preservedata="true">
			<fieldset>
			<legend>
				Sign up
			</legend>
			<cfif structKeyExists(variables, 'aErrorMessages') AND NOT ArrayIsEmpty(aErrorMessages)>
				<cfoutput>
					<cfloop array="#aErrorMessages#" item="message">
						<p class="errorMessage">
							#message#
						</p>
					</cfloop>
				</cfoutput>
			</cfif>
			<cfif structKeyExists(variables, 'isUserLoggedIn') AND isUserLoggedIn EQ false>
				<p class="errorMessage">
					User not found. Please try again!
				</p>
			</cfif>
			<cfif structKeyExists(variables, 'isUserLoggedIn') AND (application.isUserLoggedIn EQ true)>
				<!---Locate to index page--->
				<cflocation url="/BugTracker/index.cfm"/>
			<cfelse>
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
				<div class="form-label-group">
					<cfinput class="form-control" placeholder="Name" type="text" name="field_userName"
					         id="field_userName" required="true" validateat="onSubmit" 
					         message="Please, provide a name"/>
					<label for="field_userPassword">
						Your name
					</label>
				</div>
				<div class="form-label-group">
					<cfinput class="form-control" placeholder="Soname" type="text" name="field_userSoname"
					         id="field_userSoname" required="true" validateat="onSubmit" 
					         message="Please, provide a name"/>
					<label for="field_userPassword">
						Your soname
					</label>
				</div>
				
				<div class="d-flex justify-content-between">
					<cfinput class="btn btn-lg btn-primary btn-block" type="submit" name="submitSignup" 
					         id="submitSignup" value="SignUp"/>
				</div>
			</cfif>
		</cfform>
	</div>	
</cf_template>