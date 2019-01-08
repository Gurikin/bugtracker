component output="false" {	
	this.name = 'bugtracker';
	this.applicationTimeout = createtimespan(0, 2, 0, 0);
	this.datasource = 'bug_tracker_test';	
	this.customTagPaths = '\bugtracker\views\layout';
	this.sessionManagement = true;
	this.cookieManagement = true;
	this.sessionTimeout = createTimespan(0, 2, 0, 0);

	//	OnApplicationStart() method
	boolean function onApplicationStart() output="false" {		
		application.authController = createObject("component",'bugtracker.controllers.authController');					
		application.bugController = createObject("component",'bugtracker.controllers.bugController');
		application.bugHistoryController = createObject("component",'bugtracker.controllers.bugHistoryController');
		application.userController = createObject("component",'bugtracker.controllers.userController');
		application.utils = createObject("component",'bugtracker.controllers.utils');
		return true;
	}
	
	//Action on request start
	boolean function onRequestStart(String required targetPage) output="false" {		
		
		if (isDefined('url.restartApp')) {
			this.onApplicationStart();
		}
		
		if (not isUserLoggedIn() and (not structKeyExists(session, 'stLoggedInUser'))) {
			if (not (listFind(CGI.SCRIPT_NAME,'signInForm.cfm', '/'))) {
				if (not (listFind(CGI.SCRIPT_NAME,'signUpForm.cfm', '/'))) {
					location("/BugTracker/signInForm.cfm");					
				}				
			} 
		}
				
		if (isDefined('url.signOut')) {
			application.authController.signOut();
		}	
		
		return true;	
	}
}