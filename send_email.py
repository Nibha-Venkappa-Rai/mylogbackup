#login to https://myaccount.google.com/apppasswords and give app name as anything for ex: EC2 SMTP and google will provide a 16 letter password you can use that in the below python script

import smtplib
from email.message import EmailMessage

msg = EmailMessage()
msg.set_content("Your log size has exceeded the threshold.")
msg["Subject"] = "Log Alert"
msg["From"] = "nibhavrai@gmail.com"
msg["To"] = "nibhavrai@gmail.com"

with smtplib.SMTP_SSL("smtp.gmail.com", 465) as smtp:
    smtp.login("nibhavrai@gmail.com", "lnfh rzsa ojgt mekh")
    smtp.send_message(msg)

