#!/bin/bash

USERID=$(id -u)
# Check if the script is run with root access
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
#colours R is for error G is for success Y is for installation N is for normal text

LOGS_FOLDER="/var/log/shellscript-logs" 
SCRIPT_NAME=$(echo $0 | cut -d "." -f1)
# Extract the script name without the extension
LOG_FILE="$LOGS_FOLDER/$SCRIPT_NAME.log"
# Define the log file path
# Create the logs folder if it doesn't exist
PACKAGES=("mysql" "python3" "nginx" "httpd") 

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

        for package in ${PACKAGES[@]}
        do
            dnf list installed $package &>>$LOG_FILE
            if [ $? -ne 0 ]
            then 
             echo "$package is not installed.. going to install it" | tee -a $LOG_FILE
             dnf install $package -y &>>$LOG_FILE
                VALIDATE $? "$package"
        else
            echo -e "nothing to do $package is $Y already installed $N" | tee -a $LOG_FILE
            fi
            done

