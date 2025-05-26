#!/bin/bash

USERID=$(id -u)
# Check if the script is run with root access
R="\e[31m"
G="\e[32m"
Y="\e[33m"
N="\e[0m"
#colours R is for error G is for success Y is for installation N is for normal text

if [ $USERID -ne 0 ]

then
    echo -e "$R error: run with root access $N"
    exit 1
    else 
    echo "you are running with root access"
    fi

    VALIDATE(){
        if [ $1 -eq 0 ]
        then 
         echo "installing $2 is $G successfull $N"
         else 
         echo "installing $2 is $R not successfull $N"
         exit 1
         fi
        }

dnf list installed mysql
 if [ $? -ne 0 ]
   then 
   echo "mysql is not installed going to install it"
    dnf install mysql -y
   VALIDATE $? "mysql"
    else 
    echo "mysql is $Y already installed $N nothing to do"
    fi

dnf list installed python3
if [ $? -ne 0 ]
  then
    echo "python3 is not installed going to install it"
    dnf install python3 -y
    VALIDATE $? "python3"
     else 
     echo "python3 is $Y already installed $N nothing to do"
       fi

 dnf list installed nginx
 if [ $? -ne 0 ]
  then 
   echo "nginx is not installed going to install it"
   dnf install nginx -y
   VALIDATE $? "nginx"
    else
    echo "nginx is $Y already installed $N nothing to do"
    fi       

      