#!/bin/bash

echo "all variables passed to the script: $@"
echo "number of variables: $#"
echo "script name: $0"
echo "current directory: $PWD"
echo "user running the script: $USER"
echo "home directory of user: $HOME"
echo "PID of the script: $$"
sleep 10 &
echo "PID of last background process: $!"
