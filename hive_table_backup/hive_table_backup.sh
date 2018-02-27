#!/bin/bash

export DATE=$(date +%Y%m%d%H%M%S)

cat tableNames.txt | while read LINE
   do
   echo -e "$DATE - Table $LINE backep up to $LINE$DATE$1" >> HiveTableBackupLog.txt
   hive -e "select concat(count(*),' rows') from $LINE; show create table $LINE; CREATE TABLE $LINE$DATE$1 ROW FORMAT DELIMITED FIELDS TERMINATED BY '|' STORED AS ORC AS SELECT * FROM $LINE" >>  HiveTableBackupLog.txt
   echo  -e "\n" >> HiveTableBackupLog.txt   
   done
