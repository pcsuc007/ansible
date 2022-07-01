#!/bin/bash
#清理超过60天的备份文件
find ${OSLog_bakdir}/ -name "*.tar.gz"  -mtime +60 -type f |xargs rm -rf
