#!/bin/sh

DBDIR="`pwd`"

if [ -z $1 ] ; then
	echo "load-pay [HostName] [Date] [Password]"
	echo "[HostName Null]"
	exit 1
fi

if [ -z $2 ] ; then
      echo "load-pay [HostName] [Date] [Password]"
      echo "[Date Null]"
      exit 1
fi

if [ -z $3 ] ; then
	echo "load-pay [HostName] [Date] [Password]"
	echo "[Password Null]"
	exit 1
fi

HEXT=$1
DEXT=$2
PASSWORD=$3

LoadDatabases() {
mysql -uroot -p$PASSWORD << FLAG
set FOREIGN_KEY_CHECKS=0;

DROP DATABASE IF EXISTS payBranch;
DROP DATABASE IF EXISTS payShared;
DROP DATABASE IF EXISTS payFrameWork;

CREATE DATABASE payFrameWork;
use payFrameWork;
source payFrameWork-d.$HEXT.$DEXT.sql;
source payFrameWork-t.$HEXT.$DEXT.sql;

CREATE DATABASE payShared;
use payShared;
source payShared-d.$HEXT.$DEXT.sql;
source payShared-t.$HEXT.$DEXT.sql;

CREATE DATABASE payBranch;
use payBranch;
source payBranch-d.$HEXT.$DEXT.sql;
source payBranch-t.$HEXT.$DEXT.sql;

set FOREIGN_KEY_CHECKS=1;
FLAG
}

if [ ! -d $DEXT ] ; then
mkdir $DEXT
fi

cd $DEXT
LoadDatabases
