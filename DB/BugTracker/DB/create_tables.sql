create table user (email varchar(100) not null unique, fName varchar(255) not null, lname varchar(255) not null, password varchar(255) not null, primary key (email));
insert into user (email, fName, lname, password) values ('vano@gmail.com', 'Ivan', 'Bunin', '123');
create table bug 
	(bug_id int not null auto_increment, 
	find_date date not null, 
	short_desc varchar(255) not null, 
	full_desc text, 
	status ENUM('new', 'opened', 'solved', 'closed') default 'new', 
	urgency ENUM('immediately', 'urgently', 'unrushed', 'completly unrushed') default 'urgently', 
	criticality ENUM ('crash', 'critical', 'dont critical', 'change request') default 'critical', 
	primary key (bug_id));
insert into bug (find_date, short_desc, full_desc, status, urgency, criticality)
	VALUES (:find_date_sql_param, 
			:short_desc_sql_param,
			:full_desc_sql_param,
			:status_sql_param, 
			:urgency_sql_param, 
			:criticality_sql_param);