#!/bin/bash

USERID=$(id -u)
#checks if user have root access or not if user has id 0 then user is root other than 0 user don't have root access
 
 if [ $USERID -ne 0 ]
    then
       echo "error: please run with root access"
       exit 1
     else
        echo "you are running with root access"

    fi 

  dnf install mysql -y
#we don't know if mysql is installed properly or not so we check the exit status of the last command

 if [ $? -eq 0 ]
   then 
      echo "installing mysql is successfull"
   else 
      echo "installing mysql is not successfull"
      exit 1 
fi 