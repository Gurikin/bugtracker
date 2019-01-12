component output="false"
{
	//get all users
	
	public query function getAllUsers(string filter='', string orderBy, string sortOrder) output="false"
	{
		ORMReload();
		users = EntityLoad('user', {}, arguments.orderBy & " " & arguments.sortOrder, {});
		getAllUsersResult = EntityToQuery(users);
		return getAllUsersResult;
	}
	
	//get specific user by email field
	
	public any function getUserByID(string email) output="false"
	{		
			ORMReload();
			userObj = EntityLoadByPK('user', arguments.email);
			if (isDefined("userObj")) {
				getUserResult = EntityToQuery(userObj);
				return getUserResult;
			} else {
				return false;
			}			
	}
	
	//update user profile info
	//simple password change whithout confirm
	
	public boolean function updateUserProfile(string email, string fname, string lname, string password) output="true"
	{
		try
		{			
			userObj = EntityLoadByPK('user', session.stLoggedInUser.userID);
			userObj.setEmail(arguments.email);
			userObj.setFName(arguments.fname);
			userObj.setLName(arguments.lname);
			userObj.setPassword(encrypt(arguments.password, application.sugar, "AES", "Base64"));			
			session.stLoggedInUser = {'userFirstName'=arguments.fName, 'userLastName'=arguments.lname, 
		                             'userID'=arguments.email};
			return true;
		}
		catch(Exception e)
		{
			writeOutput(e);
			return false;
		}
	}
	
	public boolean function addUser(required string email, required string fname,
									required string lname, required string password) output="false"
	{
		try
		{
			userObj = EntityNew('user');
			userObj.setEmail(arguments.email);
			userObj.setFName(arguments.fname);
			userObj.setLName(arguments.lname);
			userObj.setPassword(encrypt(arguments.password, application.sugar, "AES", "Base64"));
			EntitySave(userObj);
			ormflush();
			return true;
		}
		catch(Exception ex)
		{
			writeOutput(ex);
			return false;
		}
	}
	
}