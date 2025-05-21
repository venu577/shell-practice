#!/bin/bash

USERID=$(id -u)
#checks if user have root access or not if user has id 0 then user is root other than 0 user don't have root access
 
 if [ $USERID -ne 0 ]
   then
       echo "error: please run with root access"
     else
        echo "you are running with root access"

    fi      
