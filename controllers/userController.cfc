component  output="false"
{
	public query function getAllUsers(string filter='', string orderBy, string sortOrder)
	 output="false"
	{
		queryService = new query();
		sqlString="SELECT email, fname, lname FROM user ORDER BY `"&arguments.orderBy&"` "&arguments.sortOrder;		
		queryService.setsql(sqlString);		
		getAllUsersResults = queryService.execute().getResult();
		return getAllUsersResults;
	}
	
	public query function getUserByID(string email)
	 output="false"
	{
		queryService = new query();
		queryService.addParam(name="email",value=arguments.email);	
		getBugQuery = queryService.execute(sql="SELECT user.email, user.fname, user.lname, count(bug.bug_id) AS bug_count
		FROM user INNER JOIN users_bugs ON users_bugs.user_email = user.email
		INNER JOIN bug ON users_bugs.bug_id = bug.bug_id WHERE user.email = :email");		
		getBugResult = getBugQuery.getResult();
		return getBugResult;
	}
	
	public boolean function updateUserProfile(string email, string fname, string lname, string password)
	 output="true"
	{
		queryService = new query();
		sqlString="UPDATE `bug_tracker_test`.`user` SET `email`=:email, `fname`=:fname, `lname`=:lname, `password`=:password WHERE `email`=:emailOld";
		queryService.setsql(sqlString);
		queryService.addParam(name="email",value=arguments.email);
		queryService.addParam(name="fname",value=arguments.fname);
		queryService.addParam(name="lname",value=arguments.lname);
		queryService.addParam(name="password",value=arguments.password);
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