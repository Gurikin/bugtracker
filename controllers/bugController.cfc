component  output="false"
{
	//add bug to the DB
	public boolean function addBug(required struct form)
	 output="true"
	{
		try
		{			
			bugObj = EntityNew('bug');
			bugObj.setFind_date(arguments.form.field_findDate);
			bugObj.setShort_desc(arguments.form.field_shortDesc);
			bugObj.setFull_desc(arguments.form.field_fullDesc);
			bugObj.setStatus('new');
			bugObj.setUrgency(arguments.form.urgency);			
			bugObj.setCriticality(arguments.form.criticality);
			bugObj.setUsr_email(session.stLoggedInUser.userID);
			EntitySave(bugObj);
			ormFlush();
			return true;
		}
		catch(Exception e)
		{
			writeOutput(e);
			return false;
		}
	}

	// update bug info
	public boolean function updateBug(required struct form, bug_id)
	 output="false"
	{
		try
		{
			bugObj = EntityLoadByPK('bug', arguments.bug_id);			
			bugObj.setShort_desc(arguments.form.field_shortDesc);
			bugObj.setFull_desc(arguments.form.field_fullDesc);			
			bugObj.setUrgency(arguments.form.urgency);			
			bugObj.setCriticality(arguments.form.criticality);			
			return true;
		}
		catch(Exception e)
		{
			writeOutput(e);
			return false;
		}		
	}
	
	// change the status of bug
	public boolean function changeStatus(required numeric bug_id, required string newStatus) {
		try
		{
			bugObj = EntityLoadByPK('bug', arguments.bug_id);			
			bugObj.setStatus(arguments.newStatus);
			return true;
		}
		catch(Exception e)
		{
			writeOutput(e);
			return false;
		}
	}	

	// get list of all bugs with filter by status field
	public array function getAllBugs(string filter='', string orderBy, string sortOrder)
	 output="false"
	{
		ORMReload();    	
    	bugs = ormExecuteQuery( "SELECT bug_id, find_date, short_desc, full_desc, status, urgency, criticality, usr_email FROM bug WHERE status <> :status ORDER BY "&arguments.orderBy&" "&arguments.sortOrder, { status: arguments.filter })
		return bugs;
	}
	
	// get one specific bug by bug_id field
	public query function getBugByID(required numeric id)
	 output="false"
	 {
		ORMReload();
    	bug = EntityLoadByPK('bug',arguments.id);
		getBugResult = EntityToQuery(bug);		
		return getBugResult;
	}
	
	// get all opened bugs for specific user
	public any function getOpenedBugsByUserID(required string email, string orderBy = 'find_date', string sortOrder = 'DESC')
	 output="false"
	 {
//	 	try {
//	 		ORMReload();    	
//    		openedBugs = ormExecuteQuery("SELECT bug.bug_id, bug.find_date, bug.short_desc, bug.full_desc,
//													bug.status, bug.urgency, bug.criticality, bug.usr_email FROM bug_tracker_test.bug
//													INNER JOIN user on bug.usr_email = user.email
//													INNER JOIN bug_history on bug_history.bug_id = bug.bug_id
//													WHERE user.email = :email AND bug.status = 'opened' GROUP BY bug.bug_id
//													ORDER BY "&arguments.orderBy&" "&arguments.sortOrder, { email: arguments.email });
//			return openedBugs;
//	 	} catch (Exception ex) {
//	 		writeOutput (ex);			  
//			return false;
//	 	}

		queryService = new query();
		try {		
			queryService.addParam(name="email",value=arguments.email);	
			getBugQuery = queryService.execute(sql="SELECT bug.bug_id, bug.find_date, bug.short_desc, bug.full_desc,
													bug.status, bug.urgency, bug.criticality, bug.usr_email FROM bug_tracker_test.bug
													INNER JOIN user on bug.usr_email = user.email
													INNER JOIN bug_history on bug_history.bug_id = bug.bug_id
													WHERE user.email = :email AND bug.status = 'opened' GROUP BY bug.bug_id
													ORDER BY `"&arguments.orderBy&"` "&arguments.sortOrder);			
			getBugResult = getBugQuery.getResult();			  
			return getBugResult;
		} catch (Exception e) {
			writeOutput (e);			  
			return null;
		}		
	}
	
	// get available values for enums fields of bug table
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