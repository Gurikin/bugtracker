component output="false" {	
	this.name = 'bugtracker';
	this.applicationTimeout = createtimespan(0, 2, 0, 0);
	this.datasource = 'bug_tracker_test';	
	this.customTagPaths = '\bugtracker\views\layout';
	this.sessionManagement = true;
	this.sessionTimeout = createTimespan(0, 0, 1, 0);

//	OnApplicationStart() method
	boolean function onApplicationStart() output="false" {		
		application.authServe = createObject("component",'bugtracker.components.authServe');					
		application.bugServe = createObject("component",'bugtracker.components.bugServe');
		application.utils = createObject("component",'bugtracker.components.utils');
		return true;
	}
	boolean function onRequestStart(String required targetPage) output="false" {
		
		var signInPage = 'signInForm.cfm';
		var signUpPage = 'signUpForm.cfm';
		
		if (isDefined('url.restartApp')) {
			this.onApplicationStart();
		}

		writeOutput(isUserLoggedIn());
		if (not isUserLoggedIn()) {
			if (not (listFind(CGI.SCRIPT_NAME,'signInForm.cfm', '/'))) {
				if (not (listFind(CGI.SCRIPT_NAME,'signUpForm.cfm', '/'))) {
					location("signInForm.cfm");					
				}				
			} 
		}
				
		if (isDefined('url.signOut')) {
			application.authServe.signOut();
		}	
		
		return true;	
	}
}