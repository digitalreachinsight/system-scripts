#!/bin/bash

# Change these two lines:
sender=$1
recepient=$2
#sender="itadmin@digitalreach.com.au"
#recepient="itadmin@digitalreach.com.au"
#PAM_RHOST='45.76.114.210'
NOTIFY_EMAIL="true"
if [ "$PAM_TYPE" != "close_session" ]; then
    host="`hostname`"
    subject="SSH Login: $PAM_USER from $PAM_RHOST on $host"
    # Message to send, e.g. the current environment variables.
    message="`env`"
#    notify="true"
    echo $PAM_RHOST
    while read line
    do
         echo $line;
         if [ "$PAM_RHOST" == "$line" ]; then
             echo "FALSE";
             NOTIFY_EMAIL="false"
             echo "$NOTIFY_EMAIL"
         fi
         #echo "$line"
    done < <(cat /etc/sshguard/whitelist | grep -v '/' | grep -v "#" | grep -v "^$")
    echo "$NOTIFY_EMAIL";
    if [ "$NOTIFY_EMAIL" == "true" ]; then
        echo "TRUE"
       echo "$message" | mailx -r "$sender" -s "$subject" "$recepient"
    fi
fi
