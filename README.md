# vulnmgmt
Be alerted ONLY on new vulnerabilities discovered in software you use


###DESCRIPTION
Instead of wading through the million bugtraq emails, these scripts will grep out only
the mail that is pertinent to you, and forward it on to an email of your choosing.

###REQUIREMENTS
* a server with sendmail set up (you should be able to use the mail command)
* an IMAP email account that is subscribed to bugtraq mailing list (http://www.securityfocus.com/archive)


###OVERVIEW OF SETUP
1. Configure mailkeeper.py with your imap credentials and server info
2. Configure mailnotifier.sh with the addresses you want to send to
3. Create your list of keywords in match_list.txt -- some examples are provided
4. Schedule mailController.sh to run every 15 minutes via crontab

---

#####Configuring mailkeeper.py
Change the following lines:
```
emailaddress = "emailaccount@DOMAIN.COM"
password = "yoursupersecretpasswordinplaintext"

M = imaplib.IMAP4_SSL("SERVER.DOMAIN.COM", 993)
```

If you want to save copies of all processed mail on the IMAP server, create an IMAP folder
named 'archive' and uncomment the following line:

```
#      M.copy(num, 'archive')
```


#####Configuring mailnotifier.sh
Edit the following line:
```
mail -s "NEW VULN DETECTED - keyword match $MATCHTERM" -r alerts_inbox@mydomain.com  nyxgeek@gmail.com < $email
```

