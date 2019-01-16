component  output="false"
{
	// add history bug row 
	public boolean function addBug(required numeric bug_id)
	 output="true"
	{
		try
		{			
			bugHistoryObj = EntityNew('bug_history');
			bugHistoryObj.setBug_id(arguments.bug_id);
			bugHistoryObj.setAction('new');
			bugHistoryObj.setAction_date(DateTimeFormat(now(),"yyyy-mm-dd HH:nn:ss"));
			bugHistoryObj.setAction_comment('Add bug to bugtracker list');
			bugHistoryObj.setUser_email(session.stLoggedInUser.userID);		
			EntitySave(bugHistoryObj);
			ormFlush();
			return true;
		}
		catch(Exception e)
		{
			writeOutput(e);
			return false;
		}
	}
	
	// add row to history table on change status of bug
	public boolean function changeStatus(required numeric bug_id, required string newStatus, required string comment)
	 output="false"
	{
		try
		{			
			bugHistoryObj = EntityNew('bug_history');
			bugHistoryObj.setBug_id(arguments.bug_id);
			bugHistoryObj.setAction(LCase(arguments.newStatus));
			bugHistoryObj.setAction_date(DateTimeFormat(now(),"yyyy-mm-dd HH:nn:ss"));
			bugHistoryObj.setAction_comment(arguments.comment);
			bugHistoryObj.setUser_email(session.stLoggedInUser.userID);		
			EntitySave(bugHistoryObj);
			ormFlush();
			return true;
		}
		catch(Exception e)
		{
			writeOutput(e);
			return false;
		}
	}
	
//	// get all history about one specific bug
//	public query function getBugHistory(required numeric bug_id) output='false'
//	{
//		ORMReload();
//		bugHistory = EntityLoad('bug_history', {bug_id=arguments.bug_id}, "action_date", {});
//		getBugHistoryResult = EntityToQuery(bugHistory);
//		return getBugHistoryResult;
//	}
}