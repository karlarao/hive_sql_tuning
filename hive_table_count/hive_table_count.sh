#!/bin/bash
rm -f HiveTableCount.txt
wait
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
