#!/bin/bash
while read line  
do   
   rm -f -r ${0%/*}/../$line
done < ${0%/*}/../.gitignore

exit 0

