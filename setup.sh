#!/usr/bin/env bash
echo "HELLO!"
echo "Please enter your phone numnber:(eg:+1XXXXXXXXXX)"
read phonenumber

path=$(pwd)
FILE1="messages.scpt"

/bin/cat <<EOM >$FILE1
tell application "Messages"
	
	set myid to get id of first service
	set theBuddy to buddy "$phonenumber" of service id myid
	send "ICC Shopping slots available now :) enjoy" to theBuddy
	
end tell
EOM

chmod 777 messages.scpt
#!/bin/bash
echo "Please enter your phone email:"
read email

echo "Please enter your phone apikey:"
read apikey

echo "Please enter your phone authtoken:"
read authtoken

FILE2="icc.sh"

/bin/cat <<EOM >$FILE2
curl --request GET \
  --url https://partnersapi.gethomesome.com/user/basket \
  --header 'accept: application/json, text/plain, */*' \
  --header 'accept-language: en-US,en;q=0.5' \
  --header 'apikey: $apikey' \
  --header 'authtoken: $authtoken' \
  --header 'emailid: $email' \
  --header 'keep-: ' \
  --header 'origin: https://www.indiacashandcarry.com' > $path/icc.json
python $path/iccrun.py
EOM

FILE3="iccrun.py"

/bin/cat <<EOM >$FILE3
import os
import json
from datetime import datetime

with open('$path/icc.json') as json_file:
	data = json.load(json_file)
	now = datetime.now()
	print now
	times = data['orderFee']['delivery']['availableTimes']
	if len(times) != 0:
		os.system("osascript $path/messages.scpt")
		print "Its available"
		print "Its available"
		print "Its available"
		print "Its available"
		print "Its available"
		print "Its available"
		for x in range(5):
			os.system("afplay /System/Library/Sounds/Glass.aiff")
EOM

echo "Desired cronjob interval in min(1-60):"
read interval

chmod 777 icc.sh
chmod 777 iccrun.py
crontab -l > mycron
echo "*/$interval * * * * $path/icc.sh >> $path/script_output.log 2>&1" >> mycron
crontab mycron
rm mycron