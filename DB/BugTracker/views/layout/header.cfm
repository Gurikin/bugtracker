<cfif NOT isuserloggedin()>
	<cfset sign = "signUp">
	<cfset signPage = "signUpForm.cfm">
<cfelse>
	<cfset sign = "signOut">
	<cfset signPage = "signInForm.cfm?#sign#">
</cfif>
<nav class="navbar navbar-dark fixed-top bg-dark flex-md-nowrap p-0 shadow">
	<a class="navbar-brand col-sm-3 col-md-2 mr-0" href="/BugTracker">
		BIV
	</a>
	<input class="form-control form-control-dark w-100" type="text" placeholder="Search" 
	       aria-label="Search">
	<ul class="navbar-nav px-3">
		<li class="nav-item text-nowrap">
			<a class="nav-link" href="<cfoutput>#signPage#</cfoutput>">
				<cfoutput>#sign#</cfoutput>
			</a>
		</li>
	</ul>
</nav>