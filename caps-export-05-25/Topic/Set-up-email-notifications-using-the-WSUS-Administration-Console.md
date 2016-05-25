---
title: Set up email notifications using the WSUS Administration Console
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d6937260-c35f-4f57-a8a9-88e8dc5423cf
author: britw
---
# Set up email notifications using the WSUS Administration Console
You can configure [!INCLUDE[wsus_firstref_30SP2](../Token/wsus_firstref_30SP2_md.md)] 3.0 SP2 to send status reports and email notifications about new updates. Update notifications are sent every time that the WSUS server synchronizes new updates. Status reports can be sent daily or weekly. Email notifications do not include rolled\-up computer status data from replica servers.  
  
## <a name="notifications"></a>  
#### To set up WSUS email notifications  
  
1.  [Open the WSUS Administration Console](../Topic/Configure-WSUS-by-Using-the-WSUS-Administration-Console.md#opencon).  
  
2.  In the left pane of the WSUS Administration Console, expand the server name, and then click **Options**.  
  
3.  In the **Options** pane, click **E\-Mail Notifications**.  
  
4.  On the **General** tab, select the **Send e\-mail notification when new updates are synchronized** check box and configure the following settings:  
  
    1.  In the **Recipients**field, type the email addresses of the people who should receive update notifications. Separate the names with semicolons.  
  
    2.  To set up status reports, select the **Send status reports** check box.  
  
    3.  In the **Frequency** field, select **Daily** or **Weekly**.  
  
    4.  In the **Send reports at** field, set the time at which you want status reports to be sent.  
  
    5.  In the **Recipients** field type the email addresses of the people who should receive status reports, delimited by semicolons.  
  
    6.  Select the language in which the status reports should be sent from the **Language** drop\-down menu.  
  
5.  Click **Apply** to save these settings.  
  
6.  Click the **E\-Mail Server** tab and configure the following settings:  
  
    1.  In the **Outgoing email server \(SMTP\)** field, type the name of the SMTP server.  
  
    2.  In the **Port number** field, type the email server's SMTP port. By default, port 25 is used.  
  
    3.  In the **Sender name** field, type the sender's email display name. This is typically the name of the WSUS administrator.  
  
    4.  In the **Email address** field, type the sender's email address.  
  
    5.  If the SMTP server requires logon information, select the **My SMTP server requires authentication** check box.  
  
    6.  Enter the required logon user name and password in the respective boxes.  
  
        > [!NOTE]  
        > You can change authentication credentials on a WSUS server, but not from a non\-WSUS server that runs the WSUS Administration Console.  
  
7.  Click **Apply** to save the settings.  
  
8.  After saving the email server information, click **Test** to test the configuration.  
  
## See Also  
[Use Reports in Windows Server Update Services 3.0 SP2](../Topic/Use-Reports-in-Windows-Server-Update-Services-3.0-SP2.md)  
[Issues with Email Notifications](../Topic/Issues-with-Email-Notifications.md)  
  
