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

	public query function getAllActiveBugs()
	 output="false"
	{
		queryService = new query();
		queryService.setName("signInResult");
		getAllBugsQuery = queryService.execute(sql="SELECT find_date, short_desc, full_desc, status, urgency, criticality FROM bug WHERE status <> 'closed'");
		getAllBugsResult = getAllBugsQuery.getResult();
		return getAllBugsResult;
	}

	public boolean function updateBug(required numeric bug_id,required date find_date,required string short_desc,required string full_desc,required string status = 'new',required string urgency = 'urgently',required string criticality="critical")
	 output="false"
	{

	}

	public query function getBugByID(required numeric bug_id)
	 output="false"
	{

	}

}