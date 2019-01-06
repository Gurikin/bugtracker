component
{
	
	public void function getBugTrClass(required string status_urgency_critical)
	{
		
		switch(status_urgency_critical)
		{
				//============Status====================
			case "new":
				writeOutput("text-danger");
				break;
			case "opened":
				writeOutput("text-warning");
				break;
			case "solved":
				writeOutput("text-success");
				break;
			case "closed":
				writeOutput("text-info");
				//============Urgency====================
				break;
			case "immediately":
				writeOutput("text-danger");
				break;
			case "urgently":
				writeOutput("text-warning");
				break;
			case "unrushed":
				writeOutput("text-primary");
				break;
			case "completly unrushed":
				writeOutput("text-info");
				//============Criticality====================
				break;
			case "crash":
				writeOutput("bg-danger");
				break;
			case "critical":
				writeOutput("bg-warning text-dark");
				break;
			case "dont critical":
				writeOutput("bg-primary");
				break;
			case "change request":
				writeOutput("bg-info");
				break;
			default:
				break;
		}		
	}
	
	public array function changeStatusButton(string currentStatus) {
		result = [];
		switch (arguments.currentStatus) {
			case "new":
				result[1] = "Opened";
				break;
			case "opened":
				result[1] = "Solved";
				break;
			case "solved":
				result[1] = "Opened";
				result[2] = "Closed";				
				break;
			default:				
				break;
		}
		return result;
	}
	
}