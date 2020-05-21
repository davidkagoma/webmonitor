#!/bin/bash

# This script is for checking heart beat of the Web Server
# If web server responds with a status which is not pure success [200], then 
# an auto-restart command for the entire server is issued
#
#
# HOW TO USE
# ==========
# 1. Update end point of the server, which is normally reachable via curl, and returns 
#    a 200 status. Use curl command `curl -I FQDN/file_path`, and not the full line of http 
#    status, including http version.
# 2. Upload the script to the server.
# 3. Make the script executable `chmod +x /path_to_the_file/webmonitor.sh`
# 4. Install the script via crontab, `crontab -e`
# 5. Inside crontab, set running scheme `*/5 * * * *  /full_path_to_script/webmonitor.sh  >> /var/log/cron.webmonitor.log 2>&1 ` 
#

status = (curl -I https://pfmis.org/live/login.php)

if [[ $status ~= "HTTP/2 200" ]]
then 
	echo "Server is live"
else
	echo "Server not reachable. Server restart command to be issued promptly"
	reboot 
fi
