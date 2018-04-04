#!/bin/bash

export DATE=$(date +%Y%m%d%H%M%S)

cat tableNames.txt | while read LINE
   do
   echo -e "$DATE - Table $LINE backep up to $LINE$DATE$1" >> HiveTableCountDdl.txt
   hive -e "select concat(count(*),' rows') from $LINE; show create table $LINE" >>  HiveTableCountDdl.txt
   echo  -e "\n" >> HiveTableCountDdl.txt
   done
