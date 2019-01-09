<cfif thistag.executionMode EQ 'start'>
	<cfparam name="attributes.title" default="BugTracker - Welcome!" />
	<cfparam name="attributes.pageName"/>	
	<!DOCTYPE html>
	<html lang="en">
	<head>
		<meta charset="utf-8">
		<meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
		<title>
			<cfoutput>#attributes.title#</cfoutput>
		</title>
		
		<!--- Bootstrap core CSS --->
		<link href="/BugTracker/assets/css/bootstrap.min.css" rel="stylesheet">
		
		<!--- Custom styles for this template --->		
		<link href="/BugTracker/assets/css/dashboard.css" rel="stylesheet">
		<link href="/BugTracker/assets/css/bugtracker.css" rel="stylesheet">
	</head>
	<body>
	<!---Include header here--->
	<cfinclude template="header.cfm"/>
	<div class="container-fluid">
		<div class="row">
	<!---And include sidebar too--->
	<cfinclude template="sidebar.cfm"/>
	<!---end of header and sidebar--->
	<main role="main" class="col-md-9 ml-sm-auto col-lg-10 px-4">
		<div class="chartjs-size-monitor" style="position: absolute; left: 0px; top: 0px; right: 0px; bottom: 0px; overflow: hidden; pointer-events: none; visibility: hidden; z-index: -1;"><div class="chartjs-size-monitor-expand" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:1000000px;height:1000000px;left:0;top:0"></div></div><div class="chartjs-size-monitor-shrink" style="position:absolute;left:0;top:0;right:0;bottom:0;overflow:hidden;pointer-events:none;visibility:hidden;z-index:-1;"><div style="position:absolute;width:200%;height:200%;left:0; top:0"></div></div></div>
      <div class="d-flex justify-content-between flex-wrap flex-md-nowrap align-items-center pt-3 pb-2 mb-3 border-bottom">
        <h1 class="h2"><cfoutput>#attributes.pageName#</cfoutput></h1>
        <div class="btn-toolbar mb-2 mb-md-0">
          
        </div>
      </div>
<cfelse>      
    </main>
    </div>
    </div>

	<!---include js assets here --->
	<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
    <script src="/BugTracker/assets/js/bootstrap.bundle.min.js"></script>
    </body>	
</cfif>
</htlm>