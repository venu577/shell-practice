#!/bin/bash

USERID=$(id -u)
SOURCE_DIR=$1
DEST_DIR=$2
DAYS=${3:-14} # Default to 14 days if not provided

LOGS_FOLDER="/var/log/shellscript-logs" 
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"

check_root(){
    if [ $USERID -ne 0 ]
    then
        echo -e "$R error: run with root access $N" &>>$LOG_FILE
        exit 1
    else 
        echo -e "$G you are running with root access $N" &>>$LOG_FILE
    fi
}

VALIDATE(){
    if [ $1 -eq 0 ]
    then 
         echo -e "installing $2 is $G successfull $N" | tee -a $LOG_FILE
    else 
         echo -e "installing $2 is $R not successfull $N" | tee -a $LOG_FILE
         exit 1
    fi
}

check_root
mkdir -p $LOGS_FOLDER

USAGE(){
    echo -e "$R USAGE: $N sh 21-backup.sh <source-directory> <destination-directory> <days>"
}

if [ $# -lt 2 ]
then 
    USAGE  
fi