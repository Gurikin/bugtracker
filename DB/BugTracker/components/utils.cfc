component
{
	
	public void function getBugTrClass(required string criticalClass)
	{		
		switch(criticalClass)
		{
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
				default: break;
		}
	}
	
}