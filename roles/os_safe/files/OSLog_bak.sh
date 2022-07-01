#!/bin/bash
#filename: OSLog_bak.sh
#用途：备份操作系统日志/var/log，每天备份一天内变化的文件，每月1日全量备份/var/log目录；每周6删除超过60天的日志文件。文件备份至/data/OSLogs目录下
#使用定时任务执行，每天2:00执行

#获取主机名，日志备份文件以主机
HostName=`hostname`
#备份目录
OSLog_bakdir=/data/OSLogs

#每月1日全量备份/var/log
##判断是否为1日
TDay=`date +%d`
if [ $TDay  -eq '01' ]
then
	tar -zcvf ${OSLog_bakdir}/${HostName}_oslogfullbak_`date +%Y%m%d%H%M%S`.tar.gz  /var/log/
fi		
sleep 1
#每天备份一天内变化的系统日志文件
find /var/log/  -mtime -1 -type f > ${OSLog_bakdir}/tmpfile.lst
cat ${OSLog_bakdir}/tmpfile.lst|xargs tar -zcvf ${OSLog_bakdir}/${HostName}_osloginrbak_`date +%Y%m%d%H%M%S`.tar.gz
