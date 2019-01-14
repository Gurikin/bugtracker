component output="false"
{
	//validate form fields		
	public array function validateUser(required string email, required string password) output="false"
	{
		aErrorMessages = ArrayNew(1);
		if (!isValid('email', arguments.email)) {
			arrayAppend(aErrorMessages,'Please, provide a valid email');
		}
		if (password == '') {
			arrayAppend(aErrorMessages,'Please, provide a password');
		}
		return aErrorMessages;
	}
	
	// add user to the db 
	public boolean function signUp(required string email, required string fname, required string lname, 
	                             required string password) output="true"
	{
		result = application.userController.getUserByID(arguments.email);		
		if (result == false) {
			application.userController.addUser(arguments.email,arguments.fname,arguments.lname,arguments.password);
			return this.signIn (arguments.email, arguments.password);
		} else {
			writeOutput('Sorry, we already find user with this email. Please, try again.');
			return false;
		}				
	}
	
	// try find user in DB
	public void function signIn(required string email, required string password) output="false"
	{
		application.isUserLoggedIn = false;
		structDelete(session,'stLoggedInUser');
		queryService = new query();
		queryService.setName("signInResult");
		queryService.addParam(name="email_sql_param",value=arguments.email,cfsqltype="cf_sql_varchar");		
		queryService.addParam(name="password_sql_param",value=encrypt(arguments.password, application.sugar, "AES", "Base64"),cfsqltype="cf_sql_varchar");
		result = queryService.execute(sql="SELECT email, fName, lname, password FROM user WHERE email = :email_sql_param and password = :password_sql_param");
		signInResult = result.getResult();
		if (signInResult.recordCount EQ 1) {
			cflogin() {
				cfloginuser(name=signInResult.email, password=signInResult.password, roles="user");
			}
		 	session.stLoggedInUser = {'userFirstName' = signInResult.fName, 'userLastName' = signInResult.lname, 'userID' = signInResult.email};
		 	application.isUserLoggedIn = true;
		 	location("bugtracker.cfm");			
		}
	}
	
	// user sign out handle
	public void function signOut() output="false"
	{
		structdelete(session,'stLoggedInUser');
		application.isUserLoggedIn = false;
		cflogout();
	}	
}
