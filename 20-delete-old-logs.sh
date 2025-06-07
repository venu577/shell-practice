#!/bin/bash

USERID=$(id -u)
# Check if the script is run with root access
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
LOGS_FOLDER="/var/log/shellscript-logs" 
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
# Extract the script name without the extension
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
SOURCE_DIR=/home/ec2-user/app-logs

mkdir -p $LOGS_FOLDER
echo "script started executing at: $(date)" &>>$LOG_FILE

if [ $USERID -ne 0 ]

then
    echo -e "$R error: run with root access $N" &>>$LOG_FILE
    exit 1
else 
    echo -e "$G you are running with root access $N" &>>$LOG_FILE
fi

VALIDATE(){
    if [ $1 -eq 0 ]
    then 
         echo -e "installing $2 is $G successfull $N" | tee -a $LOG_FILE
    else 
         echo -e "installing $2 is $R not successfull $N" | tee -a $LOG_FILE
         exit 1
    fi
}

FILES_TO_DELETE=$(find $SOURCE_DIR -name "*.log" -mtime +14)

while IFS= read -r filepath
do
  echo "deleting file: $filepath" | tee -a $LOG_FILE
  rm -rf $filepath
done <<< "$FILES_TO_DELETE"
# Check if any files were deleted and <<< symbol is used to read command of own script

echo "script executed successfully"

