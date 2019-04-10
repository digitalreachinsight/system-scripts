#!/bin/sh

# Change these two lines:
sender=$1
recepient=$2
#sender="itadmin@digitalreach.com.au"
#recepient="itadmin@digitalreach.com.au"

if [ "$PAM_TYPE" != "close_session" ]; then
    host="`hostname`"
    subject="SSH Login: $PAM_USER from $PAM_RHOST on $host"
    # Message to send, e.g. the current environment variables.
    message="`env`"
    echo "$message" | mailx -r "$sender" -s "$subject" "$recepient"
fi
