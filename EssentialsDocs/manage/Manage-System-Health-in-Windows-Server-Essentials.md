---
title: "Manage System Health in Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3043f83b-389c-4f37-a1ff-85afe99314fa
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Manage System Health in Windows Server Essentials

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials
 
 This topic discusses how to view and respond to all alerts in your network by using the Dashboard.  
  
> [!NOTE]
>  In  Windows Server Essentials and  Windows Server 2012 R2 with the  Windows Server Essentials Experience role installed, the health alerts for the server and client computers in the network are no longer displayed in the Alert Viewer, but instead can be viewed on the **Health Reports** tab of the **Home** page.  
  
 Windows Server Essentials actively monitors every computer that is connected to the server and alerts the administrator to issues related to the system's health, including critical updates, missing malware protection, out-of-date virus definitions on client computers, and other important issues that require action. These issues are displayed as alerts in the Alert Viewer, which can be launched from the server's Dashboard or the client computer's Launchpad in  Windows Server Essentials, or on the **Health Reports** tab in  Windows Server Essentials. By default, the alerts are refreshed every thirty minutes, but you can evaluate your network for alerts at any time by clicking **Refresh** in the Alert Viewer or on the **Health Reports** tab.  
  
 The following topics will help you understand, view, and respond to alerts in the Alert Viewer, and also provide instructions to configure your server to receive alert notifications in email:  
  
-   [About the Health Report Add-In](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_AddIn)  
  
-   [View alerts by using the Alert Viewer](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_View)  
  
-   [Organize alerts in the Alert Viewer](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_Organize)  
  
-   [Respond to alerts](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_Respond)  
  
-   [Set up email notifications for alerts](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_Email)  
  
-   [Potential computer alerts](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_Potential)  
  
##  <a name="BKMK_AddIn"></a> About the Health Report Add-In  
 The Health Report add-in for Windows Server Essentials provides you with consolidated information about the Windows Server Essentials network and enables you to distribute this information to other people. This information can be viewed on the **Reports** tab of the Dashboard. With the **Reports** tab, you can do the following:  
  
-   [Generate a report on demand or on schedule](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_Generate)  
  
-   [Customize the content of the report](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_Customize)  
  
-   [Email the report](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_emailreport)  
  
> [!NOTE]
>  **Windows Server Essentials:** You can download the Health Report add-in for  Windows Server Essentials from the [Microsoft Download Center](https://go.microsoft.com/fwlink/p/?LinkId=266342).  
>   
>  **Windows Server Essentials:** By default, the Health Report add-in is integrated with  Windows Server Essentials or  Windows Server 2012 R2 with the  Windows Server Essentials Experience role installed, and the health reports are displayed on the **Health Reports** tab of the Dashboard's **Home** page.  
  
###  <a name="BKMK_Generate"></a> Generate a report on demand or on schedule  
 After installing the Health Report add-in and restarting the Dashboard, a new tab, **Reports** is added to the Dashboard. You can generate a health report on demand at any time by clicking the **Generate a health report** task on the **Reports** tab.  
  
 After a health report is generated, a new item is created in the list pane, identified by the date and time the report was generated. To open an item, you can double-click it in the list pane, or you can select it and then click **Open the health report** in the task pane. The report is displayed in a new window in HTML format.  
  
 In addition to generating a report manually, you may also want the report to be generated automatically on a daily or hourly schedule. To do this, in the task pane, click **Customize health report settings**, and then click the **Schedule and Email** tab. The **Schedule** feature is off by default, and you can turn it on by selecting the **Generate a health report at its scheduled time** check box.  
  
###  <a name="BKMK_Customize"></a> Customize the content of the report  
 The health report contains the following:  
  
- **Critical alerts and warnings** This is consistent with the critical alerts and warnings that you see in the Alert Viewer on the Dashboard. Information alerts are not included in the health report.  
  
- **Critical errors in the event logs** Applications and service logs are scanned, and the errors that are logged in the last 24 hours will be presented in the **Details** section of the report.  
  
- **Server backup** The information about the last server backup is presented in the **Details** section of the report.  
  
- **Auto-start services not running** At the time the report is generated, if an auto-start service is not running, the information about this service will be listed in the **Details** section of the report.  
  
- **Updates** You can see the update status of the server and all the client computers in the **Details** section.  
  
- **Storage** The list of drives and their capacity is presented in the **Details** section.  
  
  In the Health Report, first view the **Summary**, and then for those items with a red error icon or a yellow warning icon, click the **Details** link on the same row to view the details about the item.  
  
  If you are not interested in some of the data points that are included in the report by default, you can customize the content of the report by clicking **Customize health report settings** in the task pane, and then clicking the **Content** tab. Clear the check boxes for the content that you don't want to see in the report. For example, if you have your own server backup plan and don't want to see the warnings about server backups, you could exclude server backups from the report by clearing the **Server backup** check box.  
  
###  <a name="BKMK_emailreport"></a> Email the report  
 Having to log on to the Dashboard to read reports is still inconvenient for some administrators, especially if they have more than one server to manage. With the email feature turned on, after a report is generated, an email will be sent to a list of specified email addresses with the content of the report. The administrator can easily view this report from any device or any client application, and ensure that the server is running at its best state.  
  
 In the **Customize Health Report Settings** dialog box, after you enable email, change the SMTP settings, and specify a list of email recipients, you will notice that a new task shows up in the task pane: **Email the health report**. For more information about SMTP Settings, see [Set up email notifications for alerts](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_Email).  
  
 You can select an existing report, and then click **Email the health report**. You can also generate a new report, and have it automatically sent to your Inbox. If you have configured a schedule for the report to be automatically generated, the report will be automatically delivered to your Inbox after being generated every day (or every hour) as scheduled.  
  
##  <a name="BKMK_View"></a> View alerts by using the Alert Viewer  
 This section discusses how to use the Dashboard or the Launchpad to open the Alert Viewer to view the health status of all the computers on the server network.  
  
#### To open the Alert Viewer by using the Dashboard  
  
1.  Open the Dashboard.  
  
2.  On the navigation pane, click any of the displayed alerts icons (Critical, Warning, or Informational). This opens the Alert Viewer.  
  
#### To open the Alert Viewer from the Launchpad  
  
1.  From a computer that is connected to the server, open the Launchpad. If asked, log on to the Launchpad with your user name and password.  
  
2.  Click any of the displayed alert icons (critical, warning, and informational) at the bottom of the Launchpad to open the Alert Viewer, and then follow the instructions in the details pane of the Alert Viewer to resolve the alert.  
  
##  <a name="BKMK_Organize"></a> Organize alerts in the Alert Viewer  
 You can organize alerts in the Alert Viewer and have them displayed based on their severity (Critical, Warning, or Informational) or based on the computer name.  
  
#### To organize alerts in the Alert Viewer  
  
1.  Open the Dashboard.  
  
2.  In the navigation pane, click the any of the displayed alerts icons (Critical, Warning, or Informational). This opens the Alert Viewer.  
  
3.  Expand the **Organize** drop-down list, and then do one of the following:  
  
    1.  Select **Filter by computer**, and click the computer name for which you would like to view the alerts. This displays alerts in the Alert Viewer only for the selected computer.  
  
    2.  Select **Filter by alert type**, and click the alert type (Critical, Warning, or Informational) for which you would like to view the alerts. This displays only the selected alert type in the Alert Viewer.  
  
##  <a name="BKMK_Respond"></a> Respond to alerts  
 When you encounter an alert, you can opt to do one of the following:  
  
-   [Resolve an alert](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_Resolve)  
  
-   [Ignore an alert](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_3)  
  
-   [Enable an alert](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_5)  
  
-   [Delete an alert](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_4)  
  
###  <a name="BKMK_Resolve"></a> Resolve an alert  
 Follow the resolution instructions in the Alert Viewer to resolve the alert. After an alert is resolved, it is still displayed in the Alert Viewer until it is refreshed.  
  
###  <a name="BKMK_3"></a> Ignore an alert  
 You can choose to ignore an alert if you prefer to respond to it later. When you ignore an alert, it is still listed in the Alert Viewer, and but it is disabled and dimmed. An ignored alert is not included in the overall health assessment of the computer. To address an ignored alert, you first need to enable the alert.  
  
##### To ignore an alert  
  
1. From the computer that is connected to the Windows Server Essentials server, open the Launchpad.  
  
2. On the Launchpad, click the any of the displayed alert icons (critical, warning, and informational). This opens the Alert Viewer.  
  
3. In the Alert Viewer, select the alert that you want to ignore, and then in the **Tasks** section, click **Ignore the alert**.  
  
   To respond to a disabled alert, you will need to first enable the alert.  
  
###  <a name="BKMK_5"></a> Enable an alert  
 You can enable an alert that you chose to ignore earlier. After the alert is enabled, you can resolve it or delete it as needed. An alert appears as disabled when marked to be ignored. When you enable an alert that you have previously disabled, it becomes active and is again included in the overall health assessment of computers.  
  
##### To enable an alert  
  
1.  From the computer that is connected to the server, open the Launchpad.  
  
2.  On the Launchpad, click any of the displayed alert icons (critical, warning, and informational) to open the Alert Viewer.  
  
3.  In the Alert Viewer, right-click the alert that you want to enable, and then click **Enable the alert**.  
  
###  <a name="BKMK_4"></a> Delete an alert  
 You can delete an alert if you do not want to resolve or ignore it. You can use the Alert Viewer on the Launchpad to delete alerts generated for your computer. If you delete an alert and the server detects the problem again in the next network health evaluation cycle, it generates a new alert.  
  
##### To delete an alert  
  
1.  From the computer that is connected to the server, open the Launchpad.  
  
2.  On the Launchpad, click any of the displayed alert icons (critical, warning, and informational) to open the Alert Viewer.  
  
3.  In the Alert Viewer, right-click the alert that you want to delete, and then click **Delete the alert**.  
  
##  <a name="BKMK_Email"></a> Set up email notifications for alerts  
 You can configure your server to notify you through email about the occurrence of alerts. The email notifications for these alerts contain information about the network issues and its resolution steps, which is identical to the information that is displayed in the Alert Viewer. Some of the network health evaluations are made programmatically.  
  
 When you configure your server to send alert notifications in email, an email notification is sent for alerts that are found during the network health evaluation. However, not all alerts that are reported in the Alert Viewer are reported in email.  
  
 Every thirty minutes, the Alert Email Evaluation task runs on the server, which evaluates the network for alerts. An email notification is sent out if any alert that is set for email notification occurs. A second email is not sent if the alert is still active in the next evaluation cycle to avoid flooding your mailbox. However, if a new alert is detected within a future alert evaluation cycle, an email notification is sent, which includes the new and previous alerts.  
  
###  <a name="BKMK_list"></a> Alerts that result in email notifications  
 The following alerts in the Alert Viewer result in email notifications when you set up your server to send email notifications for alerts:  
  
-   Errors exist in a client computer backup.  
  
-   The server was restarted.  
  
-   One or more services are not running.  
  
-   The Windows Server Storage Service is not running.  
  
-   Your evaluation period is over.  
  
-   Activate now.  
  
-   Source Server is shutting down.  
  
-   BPA scan results contain Errors.  
  
-   BPA scan results contain Warnings.  
  
-   A certificate is not available for Anywhere Access.  
  
-   The certificate for Anywhere Access has expired.  
  
-   The router is not configured correctly.  
  
-   The Web Server is not configured correctly.  
  
-   Remote Desktop Services is not configured correctly.  
  
-   The firewall is not configured correctly.  
  
-   The Internet domain name has expired.  
  
-   The Internet domain name cannot be updated.  
  
-   License Error: Forest Trust Check.  
  
-   License Error: Domain Controller Check.  
  
-   License Error: FSMO Role Check.  
  
-   License Error: Enforcement FSMO Policies.  
  
-   License Error: Enforcement Load Policies.  
  
-   License Error: Active Directory Domain Services.  
  
-   Your Office 365 subscription has expired.  
  
-   Office 365 authentication did not succeed.  
  
-   The password policy is not correct.  
  
-   The Password Sync Service cannot synchronize a user password with Office 365.  
  
-   Change your Windows password.  
  
-   Your Office 365 password is not the same as your Windows password.  
  
-   Cannot connect to Exchange Server.  
  
-   Microsoft Exchange Server has a problem.  
  
-   One or more hard drives in Server Backup are not connected.  
  
-   The backup hard drive does not have enough free space for the Server Backup.  
  
-   Server Backup was not successful because a drive snapshot could not be taken.  
  
-   A scheduled backup did not finish successfully.  
  
-   One or more pre-defined server folders are missing.  
  
-   Free space is low on one or more server hard drives.  
  
-   The VSS Writer for Storage Service is not running.  
  
-   Low storage capacity on hard drives.  
  
-   One or more drives are not functioning and are offline.  
  
###  <a name="BKMK_SMTP"></a> Configuring SMTP on your server to send alert notifications by email in Windows Server Essentials  
 This section discusses how to configure your server to send email notifications for alerts.  
  
> [!NOTE]
>  You can download the Health Report add-in for  Windows Server Essentials from the [Microsoft Download Center](https://go.microsoft.com/fwlink/p/?LinkId=266342).  
  
##### To set up email notification for alerts  
  
1.  From the **Dashboard**, open the **Alert Viewer**.  
  
2.  In the **Alert Viewer**, click **Set up alert email notifications**.  
  
3.  In the **Set up email notification for alerts** window, click **Enable**.  
  
4.  In the **SMTP Settings** window, do the following:  
  
    1.  For **From email address**, type the email address that you want use for sending the email alerts from. This email address will be displayed as the sender's address in the alert notification.  
  
    2.  For **SMTP server name**, in the **From email address** text box, type the name of the SMTP server that you specified in step 4a. (Refer to Table 1 for a list of some SMTP server names).  
  
    3.  For **SMTP port**, type the port number that is used by the SMTP server to send and receive email. (Refer to Table 1 for the port numbers that are used by the some of the SMTP servers).  
  
    4.  Select **This server requires a secure connection (SSL)** if the SMTP server uses SSL (see Table 1).  
  
    5.  Select **This server requires authentication** if the SMTP server requires a user name and password information (see Table 1). If you select this check box, type the user name and password of the email address that you entered in the **From email address** field in step 4a, and then click **OK**.  
  
    > [!NOTE]
    >  You can obtain the information about the SMTP server name, port number, and SSL usage from your Internet Service provider.  
  
     **Table 1** Examples of SMTP server names, authentication and SSL encryption requirements, and port numbers  
  
    |SMTP Server|SSL Required|Authentication Required|Port Number|Account Name/Login Name|  
    |-----------------|------------------|-----------------------------|-----------------|------------------------------|  
    |smtp.gmail.com|Yes|Yes|587|Provide full email address with domain name and password for authentication.|  
    |smtp.live.com|Yes|Yes|587|Provide full email address with domain name and password for authentication.|  
    |smtp.comcast.net|Yes|No|587|Provide full email address with domain name and password for authentication.|  
    |smtp.mail.yahoo.com|No|Yes|25|Provide only the email address without a domain name for the user name.|  
  
5.  In **Set up notification for alerts**, for **Email recipients**, type the email addresses of the persons that you would like to receive alert notifications by email. Ensure that you separate each email address with a semicolon (;).  
  
6.  To verify that you have configured your SMTP server settings correctly to send email notifications for alerts, click **Apply and send email**.  
  
    > [!NOTE]
    >  When you click **Apply and send email**, typically you will receive a sample email notification with no health alerts listed. However, if a health alert that is configured to send an email notification is identified during this test process, this alert is included in the test email.  
  
### Configuring SMTP on your server to send health reports in Windows Server Essentials  
 This section discusses how to configure the SMTP settings for your server so that you can receive health reports via email.  
  
> [!NOTE]
>  By default, the Health Report add-in is integrated with  Windows Server Essentials or  Windows Server 2012 R2 with the  Windows Server Essentials Experience role installed, and the health reports are displayed on the **Health Reports** tab of the Dashboard's **Home** page.  
  
##### To set up email notification for health reports  
  
1.  From the **Dashboard**, click the **Reports** tab.  
  
2.  In the **Health Report Tasks** task pane, click **Customize health report settings**.  
  
3.  In the **Customize Health Report Settings** window, click the **Schedule and Email** tab.  
  
4.  In the **Schedule and Email** tab, in the **Email** section, do the following:  
  
    1.  Click **Enable**, and type the email address that you want use for sending the health reports from. This email address will be displayed as the sender's address in the health reports that are emailed.  
  
        1.  For **SMTP server name**, type the name of the SMTP server. (Refer to Table 1 for a list of some SMTP server names).  
  
        2.  For **SMTP port**, type the port number that is used by the SMTP server to send and receive email. (Refer to Table 1 for the port numbers that are used by the some of the SMTP servers).  
  
        3.  Select **This server requires a secure connection (SSL)** if the SMTP server uses SSL (see Table 1).  
  
        4.  Select **This server requires authentication** if the SMTP server requires a user name and password information (see Table 1). If you select this check box, type the user name and password of the email address that you entered in the **From email address** field in step 4a, and then click **OK**.  
  
            > [!NOTE]
            >  You can obtain the information about the SMTP server name, port number, and SSL usage from your Internet Service provider.  
  
            > [!NOTE]
            >  Microsoft strongly recommends that you to use SSL because the report might contain server status that could be used by malicious parties to detect vulnerabilities (for example: missing windows update). Enabling SSL will encrypt the data in transit and mitigate the risk of exposing server vulnerability.  
  
5.  After you enable email, the **Change SMTP settings** link is displayed. Also a new task, **Email the health report**, gets displayed in **Health Report Tasks**.  
  
     **Table 1** Examples of SMTP server names, authentication and SSL encryption requirements, and port numbers  
  
    |SMTP Server|SSL Required|Authentication Required|Port Number|Account Name/Login Name|  
    |-----------------|------------------|-----------------------------|-----------------|------------------------------|  
    |smtp.gmail.com|Yes|Yes|587|Provide full email address with domain name and password for authentication.|  
    |smtp.live.com|Yes|Yes|587|Provide full email address with domain name and password for authentication.|  
    |smtp.comcast.net|Yes|No|587|Provide full email address with domain name and password for authentication.|  
    |smtp.mail.yahoo.com|No|Yes|25|Provide only the email address without a domain name for the user name.|  
  
6.  In **Customize Health Report Settings**, for **Automatically send the health report to the following email recipients:**, type the email addresses of the persons that you would like to receive Health Reports by email. Ensure that you separate each email address with a semicolon (;).  
  
7.  To verify that you have configured your SMTP server settings correctly to send health reports via email, from the Helath Report tab on the Dashboard, select a report, and click **Email the health report** from the task pane.  
  
##  <a name="BKMK_Potential"></a> Potential computer alerts  
 This section discusses understanding and managing alerts that are specific to your computer that is connected to the server and that appear in the Launchpad of your computer.  
  
 The following table lists some of the computer alerts that can be generated and displayed on the Alert Viewer if they are applicable to your computer.  
  
|Alert Title|Alert Impact and Resolution|  
|-----------------|---------------------------------|  
|The current status of the Network Firewall provides reduced protection for this computer.|Unauthorized people or software might be able to access this computer if Windows Firewall is not turned on.|  
|Virus protection is turned off, not installed, or not up to date.|The data on your computer is at risk if the **Virus protection** security setting is turned off or not updated. [To protect your computer](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_Protect), follow the steps indicated.|  
|Spyware and unwanted software protection is turned off, not installed, or not up to date.|The data on your computer is at risk if the **Spyware and unwanted software protection** is turned off or not updated. [To protect your computer](Manage-System-Health-in-Windows-Server-Essentials.md#BKMK_Protect), follow the steps indicated.|  
|Windows Update is turned off.|You will not be able to benefit from the new and corrected functionality of updates unless Windows Update is turned on. To turn on Windows Update, in Alert Viewer, click **Open Windows Update**.<br /><br /> If the **Open Windows Update** task is not displayed, you are not logged on to the computer where the alert was raised. You must be logged on to the computer on which the alert was raised to run this task in Alert Viewer.|  
|Important updates should be installed.|You will not be able to benefit from the new and corrected functionality of updates unless Windows Update is turned on. To turn on Windows Update, in Alert Viewer, click **Open Windows Update**.<br /><br /> If the **Open Windows Update** task is not displayed, you are not logged on to the computer where the alert was raised. You must be logged on to the computer on which the alert was raised to run this task in Alert Viewer.|  
|Restart the computer to apply updates.|You will not be able to benefit from the new and corrected functionality of the updates until they are applied. Save all your data and restart the computer to apply the updates.|  
|Free space is low on hard drives.|If space is not made available, you will not be able to save additional information. To increase the free space on the computer, consider the following options:<br /><br /> - Add a new hard drive.<br /><br /> - Run **Disk Cleanup** to remove old and temporary files.<br /><br /> - Move your files to a shared folder on another computer.<br /><br /> - Archive files on removable media, such as a CD, DVD, or an external hard drive.|  
|The **File History** agent on the server is not properly configured to run on this computer.|File History backups cannot be created.|  
|One or more services are not running.||  
|Change your Windows password.||  
|Your Microsoft Office 365 password is not the same as your Windows password.||  
  
###  <a name="BKMK_Protect"></a> To protect your computer  
  
1.  Open Security Center.  
  
2.  Determine the status of the installed virus protection.  
  
3.  Perform one of the following tasks depending on the protection status:  
  
    -   If it is not enabled, enable it.  
  
    -   If it is not up to date, complete the process to update the signatures.  
  
    -   If virus protection is not installed, consider installing it.  
  
## See also  
  
-   [Use Windows Server Essentials](../use/Use-Windows-Server-Essentials.md)  
  
-   [Manage Windows Server Essentials](Manage-Windows-Server-Essentials.md)
