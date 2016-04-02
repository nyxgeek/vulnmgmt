#!/usr/bin/env python

# 2016 @nyxgeek

# note: parts of this were shamelessly taken from
# https://stackoverflow.com/questions/348630/how-can-i-download-all-emails-with-attachments-from-gmail



import getpass
import imaplib
import email
import time
import re
from subprocess import call

from email.parser import HeaderParser

emailaddress = "emailaccount@DOMAIN.COM"
password = "yoursupersecretpasswordinplaintext"



M = imaplib.IMAP4_SSL("SERVER.DOMAIN.COM", 993)
M.login(emailaddress, password)

M.select()



typ, data = M.search(None, "ALL")

for num in data[0].split():
    typ, data = M.FETCH(num, '(RFC822)')
    mail = email.message_from_string(data[0][1])


    for part in mail.walk():
       # multipart are just containers, so we skip them
      if part.get_content_maintype() == 'multipart':
          continue

      # we are interested only in the simple text messages
      if part.get_content_subtype() != 'plain':
        continue

      emailsubject = mail['subject']
      emailfrom = mail['from']

      body = part.get_payload(decode=True)
      print body

      #now that we have a match we want to save it
      timestamp = str(time.time())
      filename = timestamp + '.mail'
      target = open(filename, 'a')

      target.write("SUBJECT: " + emailsubject + "\n")
      target.write("FROM: " + emailfrom + "\n\n")
      target.write(body)
      target.write("\n")

      target.close()


      M.copy(num, 'archive')
      M.store(num, '+FLAGS', '\\Deleted')
      M.expunge()
