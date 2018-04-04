#!/bin/bash

cat tableNames.txt |while read LINE
   do
   echo -e $LINE >> HiveTableCount.txt
   hive -e "select count(*) from $LINE" >>HiveTableCount.txt
   echo  -e "\n" >> HiveTableCount.txt
   done

sed '/^$/d' HiveTableCount.txt  > combinecount.txt
awk '!(NR%2){print$0p}{p=" "$0}' combinecount.txt > finalcount.txt

echo "Table Count Done..."
cat finalcount.txt


# cat hivesize.sql
# describe formatted restou_derived.dc_exceptions_mapping;
# describe formatted restou_derived.wdt_delayed_bill;
# describe formatted restou_derived.wdt_delayed_bill;


# less hivesize.txt | egrep -i "location|totalsize"
# Location:               hdfs://dev/sdge/derived/restou/dc_exceptions_mapping
#         totalSize               76873
# Location:               hdfs://dev/sdge/derived/wdt/delayed_bill
#         totalSize               946983
# Location:               hdfs://dev/sdge/derived/wdt/delayed_bill
#         totalSize               946983
