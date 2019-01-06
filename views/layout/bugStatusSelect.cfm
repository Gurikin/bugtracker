<cfif thistag.executionMode EQ 'start'>
	<cfparam name="attributes.enumName"/>
	<cfparam name="attributes.enumIndex"/>
	<cfparam name="attributes.bugColumn"/>
	<cfparam name="attributes.bugDetail"/>
<div class="form-label-group">
	<cfselect size="1" name="#attributes.enumName#" class="custom-select">
		<cfloop collection="#attributes.bugColumn[attributes.enumIndex]#" item="itm">
			<cfset enumItem = "#attributes.bugColumn[attributes.enumIndex][itm]#">
			<cfif (attributes.enumName EQ enumItem)>
				<option class="#application.utils.getBugTrClass(enumItem)#" value="#enumItem#" selected>
					<cfoutput>
						#enumItem#
					</cfoutput>
				</option>
			<cfelse>
				<option class="#application.utils.getBugTrClass(enumItem)#" value="#enumItem#">
					<cfoutput>
						#enumItem#
					</cfoutput>
				</option>
			</cfif>
		</cfloop>
	</cfselect>
	<label for="#attributes.enumName#">
		Select the #attributes.enumName# of bug 
	</label>
</div>
</cfif>