component  output="false"
{
	//get all users
	public query function getAllUsers(string filter='', string orderBy, string sortOrder)
	 output="false"
	{
		queryService = new query();
		sqlString="SELECT email, fname, lname FROM user ORDER BY `"&arguments.orderBy&"` "&arguments.sortOrder;		
		queryService.setsql(sqlString);		
		getAllUsersResults = queryService.execute().getResult();
		return getAllUsersResults;
	}
	
	//get specific user by email field
	public query function getUserByID(string email)
	 output="false"
	{
		queryService = new query();
		queryService.addParam(name="email",value=arguments.email);	
		getBugQuery = queryService.execute(sql="SELECT user.email, user.fname, user.lname FROM user WHERE user.email = :email");		
		getBugResult = getBugQuery.getResult();
		return getBugResult;		
	}
	
	//update user profile info
	//simple password change
	public boolean function updateUserProfile(string email, string fname, string lname, string password)
	 output="true"
	{
		queryService = new query();
		sqlString="UPDATE `bug_tracker_test`.`user` SET `email`=:email, `fname`=:fname, `lname`=:lname, `password`=:password WHERE `email`=:emailOld";
		queryService.setsql(sqlString);
		queryService.addParam(name="email",value=arguments.email);
		queryService.addParam(name="fname",value=arguments.fname);
		queryService.addParam(name="lname",value=arguments.lname);
		queryService.addParam(name="password",value=encrypt(arguments.password, application.sugar, "AES", "Base64"));
		queryService.addParam(name="emailOld",value=session.stLoggedInUser.userID);						
		try {
			updateUserResult = queryService.execute().getResult();		
			session.stLoggedInUser = {'userFirstName' = arguments.fName, 'userLastName' = arguments.lname, 'userID' = arguments.email};
			return true;
		} catch (Exception e) {
			writeOutput (e);
			return false;
		}		
	}
}