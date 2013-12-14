#!/bin/bash

jflist=`find  -name "*.java" -print`
for jf in $jflist
do
     echo "sed $jf"
	sed -i  's/now\.add(Calendar\.MONTH, 1);/now\.add(Calendar\.YEAR, 1);/g' $jf
done
