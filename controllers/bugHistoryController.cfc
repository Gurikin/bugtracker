component  output="false"
{
	// add history bug row 
	public boolean function addBug(required numeric bug_id)
	 output="true"
	{
		queryService = new query();		
		transaction {
			try {
				//===============================================================================================================
				//Insert Into bug_history table==================================================================================
				//===============================================================================================================
				sqlString="INSERT INTO `bug_tracker_test`.`bug_history` (`bug_id`, `action`, `action_date`, `action_comment`, `user_email`) VALUES (:bugId, :action, :changeStatusDate, :comment, :email)";
				queryService.setsql(sqlString);
				queryService.addParam(name = 'bugId', value=arguments.bug_id);
				queryService.addParam(name = 'action', value='new');
				queryService.addParam(name = 'changeStatusDate', value=DateTimeFormat(now(),"yyyy-mm-dd HH:nn:ss"));
				queryService.addParam(name = 'comment', value='Add bug to bugtracker list');
				queryService.addParam(name = 'email', value=session.stLoggedInUser.userID);
				queryService.execute().getResult();
				return true;
				transaction action="commit";
				return true;
			} catch (Exception e) {
				writeDump(e);
				transaction action="rollback";
				return false;
			}
		}
	}
	
	// add row to history table on change status of bug
	public boolean function changeStatus(required numeric bug_id, required string newStatus, required string comment)
	 output="false"
	{
		queryService = new query();
		transaction {
			try {
				//===============================================================================================================
				//Insert Into bug_history table==================================================================================
				//===============================================================================================================
				sqlString="INSERT INTO `bug_tracker_test`.`bug_history` (`bug_id`, `action`, `action_date`, `action_comment`, `user_email`) VALUES (:bugId, :action, :changeStatusDate, :comment, :email)";
				queryService.setsql(sqlString);
				queryService.addParam(name = 'bugId', value=arguments.bug_id);
				queryService.addParam(name = 'action', value=LCase(arguments.newStatus));
				queryService.addParam(name = 'changeStatusDate', value=DateTimeFormat(now(),"yyyy-mm-dd HH:nn:ss"));
				queryService.addParam(name = 'comment', value=arguments.comment);
				queryService.addParam(name = 'email', value=session.stLoggedInUser.userID);
				getAllBugsResult = queryService.execute().getResult();				
				transaction action="commit";
				return true;
			} catch (Exception e) {
				writeOutput(e);
				transaction action="rollback";
				return false;
			}	
		}			
	}
	
	// get all history about one specific bug
	public query function getBugHistory(required numeric bug_id) output='false'
	{
		queryService = new query();		
		try {
			sqlString="SELECT `action`, `action_date`, `action_comment`, `user_email` FROM `bug_tracker_test`.`bug_history` WHERE bug_id = :bug_id ORDER BY `action_date`";
			queryService.setsql(sqlString);
			queryService.addParam(name = 'bug_id', value=arguments.bug_id);
			getBugHistoryResult = queryService.execute().getResult();
			return getBugHistoryResult;
		} catch (exception e) {
			writeOutput (e);				
			return null;
		}		
	}
}