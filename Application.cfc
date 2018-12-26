component output="false" {	
	this.name = 'bugtracker';
	this.applicationTimeout = createtimespan(0, 0, 0, 30);
	this.datasource = 'bug_tracker_test';	
	this.customTagPaths = '\bugtracker\views\layout';
	this.sessionManagement = true;
	this.sessionTimeout = createTimespan(0, 0, 0, 30);

//	OnApplicationStart() method
	boolean function onApplicationStart() output="false" {		
		application.authServe = createObject("component",'bugtracker.components.authServe');
		application.authServe.myfoo();			
		return true;
	}
	boolean function onRequestStart(String required targetPage) output="false" {
		
		if (isDefined('url.restartApp')) {
			this.onApplicationStart();
		}
		
		if (not (listFind(CGI.SCRIPT_NAME,'signInForm.cfm', '/')) and (not isUserLoggedIn())) {
			location("/BugTracker/signInForm.cfm");
		}	
		
		return true;	
	}
}