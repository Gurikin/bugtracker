component  output="false"
{
	public boolean function addBug(required numeric bug_id,required date find_date,required string short_desc,required string full_desc,required string status = 'new',required string urgency = 'urgently',required string criticality="critical")
	 output="false"
	{

	}

	public boolean function deleteBug(required numeric bug_id)
	 output="false"
	{

	}
	
	public boolean function updateBug(required numeric bug_id,required date find_date,required string short_desc,required string full_desc,required string status = 'new',required string urgency = 'urgently',required string criticality="critical")
	 output="false"
	{

	}
	
	public boolean function updateBugHistory(required numeric bug_id, required string newStatus, required string comment)
	 output="true"
	{
		queryService = new query();
		try {
			date5 = LSDateFormat(now(), "d/m/yy");
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
			//===============================================================================================================
			//Update the bug table===========================================================================================
			//===============================================================================================================
			sqlString="UPDATE `bug_tracker_test`.`bug` SET `status`=:status WHERE `bug_id`=:bugId";
			queryService.setsql(sqlString);
			queryService.addParam(name = 'status', value=LCase(arguments.newStatus));
			queryService.addParam(name = 'bugId', value=arguments.bug_id);
			getAllBugsResult = queryService.execute().getResult();			
			return true;
		} catch (Exception e) {
			writeOutput(e);
			return false;
		}		
	}

	public query function getAllBugs(string filter='', string orderBy, string sortOrder)
	 output="false"
	{
		queryService = new query();
		sqlString="SELECT bug_id, find_date, short_desc, full_desc, status, urgency, criticality FROM bug WHERE status <> :status ORDER BY `"&arguments.orderBy&"` "&arguments.sortOrder;
		queryService.setsql(sqlString);
		queryService.addParam(name = 'status', value=arguments.filter,cfsqltype="cf_sql_varchar");				
		queryService.addParam(name = 'oBy', value=arguments.orderBy,cfsqltype="cf_sql_varchar"); //Can't catch bug: the queryService don't use this param
		queryService.addParam(name = 'sOrder', value=arguments.sortOrder,cfsqltype="cf_sql_varchar"); //Can't catch bug: the queryService don't use this param
		getAllBugsResult = queryService.execute().getResult();
		return getAllBugsResult;
	}
	
	public query function getBugByID(required numeric id)
	 output="false"
	{
		queryService = new query();
		queryService.addParam(name="bug_id",value=arguments.id,cfsqltype="cf_sql_varchar");	
		getBugQuery = queryService.execute(sql="SELECT bug_id, find_date, short_desc, full_desc, status, urgency, criticality FROM bug WHERE bug_id = :bug_id");
		getBugResult = getBugQuery.getResult();
		return getBugResult;
	}
	
	public array function getEnumStructs() output="false" {
		enumFields = ['status', 'urgency', 'criticality'];		
		queryService = new query();
		temp = [];
		result = [];
		regExp = "[\w+\s?\w+?]+";
		for (item in enumFields) {			
			queryService.addParam(name=item,value=item);			
            ArrayAppend(temp, queryService.execute(sql="show columns from bug where field = :" & item).getResult().type);			
		}	
		i = 1;
		j = 1;	
        for (item in temp) {
        	for (m in REFind(regExp, item,5,true,"all")) {
        		result[i][j] = m.MATCH[1];
				j++;
        	}
        	i++;
        }				
		return result;
	}
}