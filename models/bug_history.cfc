component output="false" hint="Bug history instanse" accessors="true" table="bug_history" persistent="true"{
	property name="id" column="id" fieldtype="id" type="numeric" generator="increment";
	property name="bug_id";	
	property name="action";
	property name="action_date";
	property name="action_comment";
	property name="user_email";	
}
