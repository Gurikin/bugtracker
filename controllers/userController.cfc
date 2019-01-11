component  output="false"
{
	//get all users
	public query function getAllUsers(string filter='', string orderBy, string sortOrder)
	 output="false"
	{	
		ORMReload();
    	users = EntityLoad('user',{},arguments.orderBy & " " & arguments.sortOrder,{});
		getAllUsersResult = EntityToQuery(users);		
		return getAllUsersResult;
	}
	
	//get specific user by email field
	public query function getUserByID(string email)
	 output="false"
	{
		ORMReload();
    	user = EntityLoadByPK('user',arguments.email);
		getUserResult = EntityToQuery(user);		
		return getUserResult;
	}
	
	//update user profile info
	//simple password change whithout confirm
	public boolean function updateUserProfile(string email, string fname, string lname, string password)
	 output="true"
	{
		try {
			ORMReload();
	    	user = EntityLoadByPK('user',session.stLoggedInUser.userID);
	    	user.setEmail(arguments.email);
	    	user.setFName(arguments.fname);
	    	user.setLName(arguments.lname);
	    	user.setPassword(encrypt(arguments.password, application.sugar, "AES", "Base64"));
			session.stLoggedInUser = {'userFirstName' = arguments.fName, 'userLastName' = arguments.lname, 'userID' = arguments.email};
			return true;
		} catch (Exception e) {
			writeOutput (e);
			return false;
		}
	}
}