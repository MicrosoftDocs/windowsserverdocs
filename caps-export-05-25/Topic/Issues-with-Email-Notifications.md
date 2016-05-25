---
title: Issues with Email Notifications
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5e57aba2-da75-465b-88bb-03d5390ea2cb
author: britw
---
# Issues with Email Notifications
If you are not receiving email notifications after you set up your WSUS server to send them, you should check the WSUS server's email setup and the SMTP configuration on the email server.  
  
## Troubleshooting the WSUS email setup  
In the WSUS administration console, click **Options**, and then click **E\-Mail Notifications**. On the **E\-Mail Server** tab, check the SMTP server name and port, the sender name and address, and the SMTP server authentication. You can use the **Test** button to verify your settings.  
  
## Troubleshooting the SMTP server  
For more information about troubleshooting issues with the SMTP server, see [SMTP: Troubleshooting the TCP\/IP Layer of the Mail Gateway](http://go.microsoft.com/fwlink/?LinkId=81082) .  
  
If your email notification is not working properly, check the SoftwareDistribution.log file \(found in your WSUS directory, usually …\\Program Files\\Update Services\\LogFiles\). One error message that is symptomatic of an incorrect SMTP configuration is the following:  
  
`EmailNotificationAgent.WakeUpWorkerThreadProc Exception occurred when sending email of type Summary: System.Net.Mail.SmtpException: Failure sending mail. ---> System.IO.IOException: Unable to read data from the transport connection: net_io_connectionclosed`.  
  
Investigate your SMTP email server configuration to resolve this problem.  
  
