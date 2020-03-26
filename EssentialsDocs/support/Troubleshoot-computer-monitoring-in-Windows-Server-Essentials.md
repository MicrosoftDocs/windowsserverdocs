---
title: "Troubleshoot computer monitoring in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f1e6b377-4a24-4d28-9b25-05910914826b
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Troubleshoot computer monitoring in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

This topic provides troubleshooting for issues encountered while monitoring the health status of computers in the Alert Viewer and through email notifications in  Windows Server Essentials.  
  
> [!NOTE]
>  For the most current troubleshooting information from the  Windows Server Essentials community, we suggest that you visit the [Windows Server Essentials Forum](https://social.technet.microsoft.com/Forums/winserveressentials/threads). The Windows Server Essentials Forum is a great place to search for help, or to ask a question.  
  
##  <a name="BKMK_TS"></a> Troubleshooting email notifications for alerts  
 This section lists various issues that you might encounter when using email notifications for alerts.  
  
### Cannot send the test email for the alert  
 **Issue** You get an error message that says, Cannot send the test email for alert.  
  
 **Cause** This error might occur due to any of the following issues in the settings for alert notifications:  
  
- An incorrect SMTP server name or port number.  
  
- It was incorrectly specified that the SMTP server requires a Single Sockets Layer (SSL) connection.  
  
- The SMTP server requires authentication, and incorrect credentials were entered.  
  
  **Solutions** Correct any errors in your email notification settings.  
  
##### To identify issues in your email notification settings  
  
-   Ask your Internet service provider (ISP) for the correct SMTP server name, port number, and SSL usage.  
  
-   Review the log files for email notifications for the alert on the server, in this location:  
  
     %ProgramData%\Microsoft\Windows Server\Logs\SharedServiceHost-AlertServiceConfig.log  
  
    > [!TIP]
    >  To see the ProgramData folder, you must have hidden items displayed. If you don't see the ProgramData folder, on the ribbon's **View** tab, in the **Show/hide** group, select the **Hidden items** text box.  
  
##### To update your email notification setup for alerts  
  
1.  On the Dashboard, click any alert icon in the top right corner to open the Alert Viewer.  
  
2.  At the bottom of the Alert Viewer, click **Set up email notification for alerts**.  
  
3.  In the **Set up email notification for alerts** dialog box, click **Enable**.  
  
4.  In the **SMTP Settings** dialog box, update the SMTP settings, and then click **OK**.  
  
5.  To test your updated settings, click **Apply and send email**.  
  
6.  After you verify that the test email was successful, click **OK** to save your updated settings.  
  
### Test email notification does not list any alerts  
 **Issue** The test email notifications for alerts does not display any alerts even though there are alerts listed in the Alert Viewer.  
  
 **Solution** Not all alerts that are reported in the Alert Viewer generate an email notification. Only the alerts that are configured to be escalated as an email notification within their health definition files are sent as emails to the specified email recipients.  
  
 When you click **Apply and send email**, typically you will receive a sample email notification with no health alerts listed. However, if a health alert that is configured to send email notifications is identified during this test process, that alert is included in the test email.  
  
### Active alerts are displayed for an uninstalled application  
 **Issue** Active alerts for an application are displayed even though the application and its health definition file have been uninstalled.  
  
 **Solution** You must manually delete the active alerts of the uninstalled application. To delete an alert, do the following.  
  
##### To delete an alert from the server by using the Dashboard  
  
1.  From the server, open the Dashboard.  
  
2.  In the navigation pane, click any displayed alert icon (Critical, Warning, or Informational). This launches the Alert Viewer.  
  
3.  In the Alert Viewer, right-click the alert that you want to delete, and then click **Delete this alert**.
