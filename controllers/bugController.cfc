component  output="false"
{
	//add bug to the DB
	public boolean function addBug(required struct form)
	 output="true"
	{
		queryService = new query();		
		transaction {
			try {
				//===============================================================================================================
				//Insert Into the bug table======================================================================================
				//===============================================================================================================
				sqlString="INSERT INTO `bug_tracker_test`.`bug` (`find_date`, `short_desc`, `full_desc`, `status`, `urgency`, `criticality`, `usr_email`) VALUES (:find_date, :short_desc, :full_desc, :status, :urgency, :criticality, :usr_email)";
				queryService.setsql(sqlString);
				queryService.addParam(name = 'find_date', value=arguments.form.field_findDate);
				queryService.addParam(name = 'short_desc', value=arguments.form.field_shortDesc);
				queryService.addParam(name = 'full_desc', value=arguments.form.field_fullDesc);
				queryService.addParam(name = 'status', value='new');
				queryService.addParam(name = 'urgency', value=arguments.form.urgency);
				queryService.addParam(name = 'criticality', value=arguments.form.criticality);			
				queryService.addParam(name = 'usr_email', value=session.stLoggedInUser.userID);
				insQuery = queryService.execute();
				bug_id = insQuery.getPrefix().generatedkey;
				//===============================================================================================================
				//Insert Into bug_history table==================================================================================
				//===============================================================================================================
				application.bugHistoryController.addBug(bug_id);
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

	// update bug info
	public boolean function updateBug(required struct form, bug_id)
	 output="false"
	{
		queryService = new query();
		transaction {
			try {
				sqlString="UPDATE `bug_tracker_test`.`bug` SET `short_desc`=:short_desc, `full_desc`=:full_desc, `urgency`=:urgency, `criticality`=:criticality WHERE `bug_id`=:bugId";
				queryService.setsql(sqlString);
				queryService.addParam(name = 'short_desc', value=arguments.form.field_shortDesc);
				queryService.addParam(name = 'full_desc', value=arguments.form.field_fullDesc);			
				queryService.addParam(name = 'urgency', value=arguments.form.urgency);
				queryService.addParam(name = 'criticality', value=arguments.form.criticality);
				queryService.addParam(name = 'bugId', value=arguments.bug_id);
				queryService.execute().getResult();
				transaction action="commit";  
				return true;
			} catch (Exception e) {
				writeOutput(e);
				transaction action="rollback";
				return false;
			}	
		}			
	}
	
	// change the status of bug
	public boolean function changeStatus(required numeric bug_id, required string newStatus) {
		transaction {
			try {
				//===============================================================================================================
				//Update the bug table===========================================================================================
				//===============================================================================================================
				sqlString="UPDATE `bug_tracker_test`.`bug` SET `status`=:status WHERE `bug_id`=:bugId";
				queryService.setsql(sqlString);
				queryService.addParam(name = 'status', value=LCase(arguments.newStatus));
				queryService.addParam(name = 'bugId', value=arguments.bug_id);
				queryService.execute().getResult();
				transaction action="commit";
				return true;  
			} catch (Exception e) {
				writeOutput(e);
				transaction action="rollback";
				return false;
			}
		}
	}	

	// get list of all bugs with filter by status field
	public query function getAllBugs(string filter='', string orderBy, string sortOrder)
	 output="false"
	{		
		queryService = new query();		
		try {
			sqlString="SELECT bug_id, find_date, short_desc, full_desc, status, urgency, criticality, usr_email FROM bug WHERE status <> :status ORDER BY `"&arguments.orderBy&"` "&arguments.sortOrder;
			queryService.setsql(sqlString);
			queryService.addParam(name = 'status', value=arguments.filter,cfsqltype="cf_sql_varchar");				
			queryService.addParam(name = 'oBy', value=arguments.orderBy,cfsqltype="cf_sql_varchar"); //Can't catch bug: the queryService don't use this param
			queryService.addParam(name = 'sOrder', value=arguments.sortOrder,cfsqltype="cf_sql_varchar"); //Can't catch bug: the queryService don't use this param
			getAllBugsResult = queryService.execute().getResult();				  
			return getAllBugsResult;
		} catch (exception e) {
			writeOutput (e);				
			return null;
		}		
	}
	
	// get one specific bug by bug_id field
	public query function getBugByID(required numeric id)
	 output="false"
	 {
		queryService = new query();
		try {		
			queryService.addParam(name="bug_id",value=arguments.id,cfsqltype="cf_sql_varchar");	
			getBugQuery = queryService.execute(sql="SELECT bug_id, find_date, short_desc, full_desc, status, urgency, criticality, usr_email FROM bug WHERE bug_id = :bug_id");
			getBugResult = getBugQuery.getResult();			  
			return getBugResult;
		} catch (Exception e) {
			writeOutput (e);			  
			return null;
		}		
	}
	
	// get all opened bugs for specific user
	public query function getOpenedBugsByUserID(required string email, string orderBy = 'find_date', string sortOrder = 'DESC')
	 output="false"
	 {
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