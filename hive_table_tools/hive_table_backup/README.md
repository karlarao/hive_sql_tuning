
 
Create list of tables to backup and put it on tableNames.txt. The format should be <databasename>.<tablename>
	 
	﻿[raj_ops@sandbox ~]$ cat tableNames.txt
	hr.departments
	hr.employees
	 
 
Create the script hive_table_backup.sh
	 
	﻿#!/bin/bash
	export DATE=$(date +%Y%m%d%H%M%S)
	cat tableNames.txt | while read LINE
	   do
	   echo -e "$DATE - Table $LINE backep up to $LINE$DATE$1" >> HiveTableBackupLog.txt
	   hive -e "select concat(count(*),' rows') from $LINE; show create table $LINE; CREATE TABLE $LINE$DATE$1 ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS ORC AS SELECT * FROM $LINE" >>  HiveTableBackupLog.txt
	   echo  -e "\n" >> HiveTableBackupLog.txt  
	   done
	 
 
Run the script with optional parameter as identified of backup. By default it appends timestamp to the table name and the optional identifier. The backup also runs a count(*) and CREATE DDL of the table.
 
	 
	﻿[raj_ops@sandbox ~]$ sh hive_table_backup.sh krl
	 
 
Review the log HiveTableBackupLog.txt
	 
	﻿[raj_ops@sandbox ~]$ cat HiveTableBackupLog.txt | grep -A1 "\- Table"
	20180209070634 - Table hr.departments backep up to hr.departments20180209070634krl
	30 rows
	--
	20180209070634 - Table hr.employees backep up to hr.employees20180209070634krl
	45 rows
 
 
Review the full output of the HiveTableBackupLog.txt
 
	 
	﻿[raj_ops@sandbox ~]$ cat HiveTableBackupLog.txt
	20180209070634 - Table hr.departments backep up to hr.departments20180209070634krl
	30 rows
	CREATE TABLE `hr.departments`(
	  `department_id` int,
	  `department_name` varchar(30),
	  `manager_id` int,
	  `location_id` int)
	ROW FORMAT SERDE
	  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
	STORED AS INPUTFORMAT
	  'org.apache.hadoop.mapred.TextInputFormat'
	OUTPUTFORMAT
	  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
	LOCATION
	  'hdfs://sandbox.hortonworks.com:8020/apps/hive/warehouse/hr.db/departments'
	TBLPROPERTIES (
	  'COLUMN_STATS_ACCURATE'='{\"BASIC_STATS\":\"true\"}',
	  'numFiles'='30',
	  'numRows'='30',
	  'rawDataSize'='679',
	  'totalSize'='709',
	  'transient_lastDdlTime'='1518096058')
	 
	 
	20180209070634 - Table hr.employees backep up to hr.employees20180209070634krl
	45 rows
	CREATE TABLE `hr.employees`(
	  `employee_id` int,
	  `first_name` varchar(20),
	  `last_name` varchar(25),
	  `email` varchar(25),
	  `phone_number` varchar(20),
	  `hire_date` date,
	  `job_id` varchar(10),
	  `salary` int,
	  `commission_pct` int,
	  `manager_id` int,
	  `department_id` int)
	ROW FORMAT SERDE
	  'org.apache.hadoop.hive.serde2.lazy.LazySimpleSerDe'
	STORED AS INPUTFORMAT
	  'org.apache.hadoop.mapred.TextInputFormat'
	OUTPUTFORMAT
	  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
	LOCATION
	  'hdfs://sandbox.hortonworks.com:8020/apps/hive/warehouse/hr.db/employees'
	TBLPROPERTIES (
	  'COLUMN_STATS_ACCURATE'='{\"BASIC_STATS\":\"true\"}',
	  'numFiles'='45',
	  'numRows'='45',
	  'rawDataSize'='2886',
	  'totalSize'='2931',
	  'transient_lastDdlTime'='1516717147')
	 
 
To restore, truncate the main table or recreate from the CREATE DDL and do INSERT SELECT from the backup
	 
	--example command for non partitioned table
	insert into table hr.departments SELECT * FROM hr.departments20180209070634krl;
	 
	--example command for partitioned table
	insert into table hr.departments partition(processed_date) SELECT * FROM hr.departments20180209070634krl;
	 
