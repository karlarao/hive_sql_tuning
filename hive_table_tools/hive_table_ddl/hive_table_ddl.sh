#!/bin/bash

export DATE=$(date +%Y%m%d%H%M%S)

cat tableNames.txt | while read LINE
   do
   echo -e "$DATE - DDL for $LINE" >> HiveTableDdlLog.txt
   hive -e "show create table $LINE" >>  HiveTableDdlLog.txt
   echo  -e "\n" >> HiveTableDdlLog.txt   
   done
