#! /bin/bash
pids=`ps -ef | grep hexo | grep -v grep | awk '{print $2}'`
if [ -n "$pids" ]; then
	kill $pids
fi
