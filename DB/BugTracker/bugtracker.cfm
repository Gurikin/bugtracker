<cf_template pagename="Bug tracker">
	<cfset bugList = application.bugServe.getAllActiveBugs()>
	<table class="table table-hover table-dark">
			<thead>
				<th scope="col">
					Дата обнаружения
				</th>
				<th>
					Короткое описание
				</th>
				<th>
					Статус
				</th>
				<th>
					Срочность
				</th>
				<th>
					Значимость
				</th>
			</thead>
			<tbody>			
			<cfoutput query="bugList">											
				<tr class="#application.utils.getBugTrClass(bugList.criticality)#">					
					<td>#bugList.find_date#</td>
					<td>#bugList.short_desc#</td>
					<td>#bugList.status#</td>
					<td>#bugList.urgency#</td>
					<td>#bugList.criticality#</td>
				</tr>				
			</cfoutput>
			</tbody>
		</table>	
</cf_template>

