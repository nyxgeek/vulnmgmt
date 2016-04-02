#!/bin/bash

# 2016 @nyxgeek

# OVERVIEW:
# 1. check to see if new .mail files have been downloaded by our python script
# 2. if the mail files exist, then check to see if any of them match a keyword in our match_list
# 3. if a match is detected, send an email


if [ `ls -la *.mail 2>/dev/null | wc -l` -gt 0 ]; then
	MATCHES="$(grep -f match_list.txt -l -i  *.*.mail)"

	for email in $MATCHES; do

		MATCHTERM=`grep -f match_list.txt -o -i $email`
		echo "" >> $email
		echo "Match detected for: $MATCHTERM"  >> $email
		echo "-------EOF-------" >> $email
		dos2unix $email
		mail -s "NEW VULN DETECTED - keyword match $MATCHTERM" -r alerts_inbox@mydomain.com  nyxgeek@gmail.com < $email

	done
fi
