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

# Check if source and destination directories are provided
USAGE(){
    echo -e "$R USAGE: $N sh 21-backup.sh <source-directory> <destination-directory> <days(optional)>"
}

if [ $# -lt 2 ]
then 
    USAGE  
fi

# Check if source directory and destination directory exists
if [ ! -d $SOURCE_DIR ]
then
    echo -e "$R Source directory $SOURCE_DIR does not exist $N" &>>$LOG_FILE
    exit 1
fi

if [ ! -d $DEST_DIR ]
then
    echo -e "$R Destination directory $DEST_DIR does not exist$N" &>>$LOG_FILE
    exit 1
fi

FILES=$(find $SOURCE_DIR -name "*.log" -mtime +$DAYS)

# Check any files are found if exist then zip them
if [ ! -z "$FILES" ]
then 
    echo "files to zip are: $FILES"
    TIMESTAMP=$(date +%F-%H-%M%-S)
    ZIP_FILE="$DEST_DIR/app-logs-$TIMESTAMP.zip"
    echo $FILES | zip -@ $ZIP_FILE

    if [ -f $ZIP_FILE ]
    then
        echo -e "successfully created zip file"
        while IFS= read -r filepath
        do
            echo "deleting file $filepath" 
            rm -rf $filepath
        done <<< $FILES
            echo -e "log files older than $DAYS from source directory removed successfully"
        else  
            echo -e "zip file creation failed"
            exit 1
        fi        

else
    echo -e "no log files found older than 14days"
fi    

