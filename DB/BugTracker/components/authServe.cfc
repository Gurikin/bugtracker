component output="false"
{		
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
	
	public boolean function signUp(required string email, required string fname, required string lname, 
	                             required string password) output="false"
	{
		queryService = new query();
		queryService.setName("signUpResult");
		queryService.addParam(name="email_sql_param",value=arguments.email,cfsqltype="cf_sql_varchar");
		queryService.addParam(name="fname_sql_param",value=arguments.fname,cfsqltype="cf_sql_varchar"); 
		queryService.addParam(name="lname_sql_param",value=arguments.lname,cfsqltype="cf_sql_varchar");
		queryService.addParam(name="password_sql_param",value=arguments.password,cfsqltype="cf_sql_varchar");
		result = queryService.execute(sql="SELECT count(*) as cnt FROM user WHERE email = :email_sql_param");
		if (result.getResult().cnt == 0) {
			signUpResult = queryService.execute(sql="INSERT INTO user (email, fName, lname, password) values (:email_sql_param, :fname_sql_param, :lname_sql_param, :password_sql_param)");
			return this.signIn (arguments.email, arguments.password);
		} else {
			aErrorMessages = ArrayNew(1);
			arrayAppend(aErrorMessages,'Sorry, we already find user with this email. Please, try again.');
			return aErrorMessages;
		}				
	}
	
	public boolean function signIn(required string email, required string password) output="false"
	{
		application.isUserLoggedIn = false;
		queryService = new query();
		queryService.setName("signInResult");
		queryService.addParam(name="email_sql_param",value=arguments.email,cfsqltype="cf_sql_varchar");		
		queryService.addParam(name="password_sql_param",value=arguments.password,cfsqltype="cf_sql_varchar");
		result = queryService.execute(sql="SELECT email, fName, lname, password FROM user WHERE email = :email_sql_param and password = :password_sql_param");
		signInResult = result.getResult();
		if (signInResult.recordCount EQ 1) {
			cflogin() {
				 cfloginuser(name=signInResult.email, password=signInResult.password, roles="user");
			 }
			 session.stLoggedInUser = {'userFirstName' = signInResult.fName, 'userLastName' = signInResult.lname, 'userID' = signInResult.email};
			 application.isUserLoggedIn = true;
		}
		return application.isUserLoggedIn;
	}
	
	public void function signOut() output="false"
	{
		structdelete(session,'stLoggedInUser');
	}	
}
