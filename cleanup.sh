#!/bin/bash
echo "Deleting cronjob"
crontab -l |sed  '/script_output.log/d' >mycron.txt
crontab -r
crontab mycron.txt
rm -rf mycron.txt messages.scpt iccrun.py icc.sh icc.json script_output.log

