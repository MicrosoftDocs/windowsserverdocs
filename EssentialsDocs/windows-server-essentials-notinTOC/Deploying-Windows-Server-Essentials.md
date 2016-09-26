---
title: "Deploying Windows Server Essentials"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 04f680d2-8d3a-42ac-a916-82634e5f5154
author: nnamuhcs
ms.author: coreyp
---

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, and Windows Server 2012


# Deploying Windows Server Essentials
 This topic applies to a server running Windows Server Essentials, or to a server running Windows Server 2012 R2 Standard or Windows Server 2012 R2 Datacenter with the Windows Server Essentials Experience role installed.  
  
## UI Help  
  

-   [What should I know before I personalize my server?](Deploying-Windows-Server-Essentials.md#BKMK_Personalize)  
  
-   [Which options should I choose for update settings?](Deploying-Windows-Server-Essentials.md#BKMK_Update)  
  
-   [Why are the data and time settings important?](Deploying-Windows-Server-Essentials.md#BKMK_DateTime)  
  
-   [How do I connect my computers to my server?](Deploying-Windows-Server-Essentials.md#BKMK_ConnectComputer)  
  
-   [Support information](Deploying-Windows-Server-Essentials.md#BKMK_Support)  
  
-   [Troubleshoot Windows Server Essentials installation](Deploying-Windows-Server-Essentials.md#BKMK_Troubleshoot)  

-   [What should I know before I personalize my server?](Deploying-Windows-Server-Essentials.md#BKMK_Personalize)  
  
-   [Which options should I choose for update settings?](Deploying-Windows-Server-Essentials.md#BKMK_Update)  
  
-   [Why are the data and time settings important?](Deploying-Windows-Server-Essentials.md#BKMK_DateTime)  
  
-   [How do I connect my computers to my server?](Deploying-Windows-Server-Essentials.md#BKMK_ConnectComputer)  
  
-   [Support information](Deploying-Windows-Server-Essentials.md#BKMK_Support)  
  
-   [Troubleshoot Windows Server Essentials installation](Deploying-Windows-Server-Essentials.md#BKMK_Troubleshoot)  

  
##  <a name="BKMK_Personalize"></a> What should I know before I personalize my server?  
 To distinguish and help secure your server on your network, you should identify your company name, choose a unique internal domain name, and give your server a unique name.  
  
### Company name  
 Your company name is used to associate your server with your company and to customize your company reports. You can type up to 254 characters for your company name.  
  
### Internal domain name  
 An internal domain groups together your server and client computers so that they can share a common database of user names, passwords, and other common information. Your users see this name when they log on to their computers. It is used internally only, and it is not the same as an Internet domain name. Your internal domain name must meet the following criteria:  
  
-   Can be up to 15 characters long  
  
-   Can contain letters, numbers, and hyphens (-)  
  
-   Must not start with a hyphen  
  
-   Must not contain any spaces  
  
-   Must not contain only numbers  
  
### Server name  
 Your server name uniquely identifies your server on your network. Your server name must meet the following criteria:  
  
-   Can be up to 15 characters long  
  
-   Can contain letters, numbers and hyphens (-)  
  
-   Must not start with a hyphen  
  
-   Must not contain any spaces  
  
-   Must not contain only numbers  
  
### Reserved words  
 Some words are used by the operating system. These are called reserved words. If you attempt to use a reserved word when you name your server, you will receive an error message. For non-English installations, do not use the English or localized (reserved) words.  
  
 Reserved words include:  
  
-   Anonymous  
  
-   Authenticated User  
  
-   Batch  
  
-   Builtin  
  
-   Creator Group  
  
-   Creator Group Server  
  
-   Creator Owner  
  
-   Creator Owner Server  
  
-   Dialup  
  
-   Digest Auth  
  
-   Interactive  
  
-   Internet  
  
-   Local  
  
-   Local System  
  
-   Network  
  
-   Network Service  
  
-   NT Authority  
  
-   NT Domain  
  
-   NTLM Auth  
  
-   Null  
  
-   Proxy  
  
-   Remote Interactive  
  
-   Restricted  
  
-   SChannel Auth  
  
-   Self  
  
-   Server  
  
-   Service  
  
-   System  
  
-   Terminal Server  
  
-   This Organization  
  
-   Users  
  
-   World  
  
##  <a name="BKMK_Update"></a> Which options should I choose for update settings?  
 You can select how you want to receive updates for your server.  
  
### Use recommended settings  
 To keep your server updated automatically, click **Use recommended settings**. When you choose **Use recommended settings**, the following features are turned on:  
  
#### Install important and recommended updates  
 When you use the recommended settings, Windows Update automatically downloads and installs important and recommended updates to your server software as Microsoft releases them. Any update to the server that requires a corresponding update to a client computer occurs automatically. Optional updates are not downloaded or installed automatically.  
  
 Important updates provide significant benefits, such as improved security and reliability. Recommended updates can address non-critical issues and can enhance your computing experience.  
  
 For more information about updates, see the [Update Services Privacy Statement](http://go.microsoft.com/fwlink/?linkid=81204).  
  
#### Find solutions to issues online  
 If problems occur in your Windows operating system or in programs that are designed to work with the Microsoft Error Reporting Service, Windows automatically sends information to Microsoft to help identify each problem and to check for a solution.  
  
 In some instances, reports might unintentionally contain personal information. If a report does contain personal information, a message is displayed that asks if you want to send the report. Microsoft does not use the information in these reports to identify you or to contact you. When solutions are available, they are offered as steps to help you solve the problem that you reported or as updates to install. Because some problems may not have solutions available, the information that you send can also help Microsoft research issues and create new solutions.  
  
#### Help Microsoft improve Windows  
 By participating in the Customer Experience Improvement Program (CEIP), you can help Microsoft improve your server software. CEIP collects information about how customers use Microsoft programs and about some of the issues that customers encounter. Microsoft uses this information to improve the products and features that customers use most often and to help create solutions to common issues. Participation in the program is voluntary, and the end results are software improvements to better meet the needs of our customers. When you participate in the program, we collect basic information about how you use your programs, your computer, and your connected devices. We also collect information about how each of these is set up and performing.  
  
##  <a name="BKMK_DateTime"></a> Why are the data and time settings important?  
 Computers keep the time on their internal clocks, which allows them to perform any function that requires the date or time. For scheduling purposes, however, the clocks must be set to the correct date and time, and they must be synchronized with the other clocks in the network. With time synchronization, computers set their clocks automatically to match another computer's clock.  Windows Server Essentials maintains very accurate time, and then all other computers set their clocks to match the server™s time. In this way, you can set an accurate time on all computers.  
  
  Windows Server Essentials uses the time synchronization service to synchronize the date and time of computers running in a  Windows Server Essentials network. Synchronized time is critical because the default authentication protocol uses the server™s time as part of the authentication process. For example, if the clock on a client computer is not synchronized to the correct date and time,  Windows Server Essentials authentication might falsely interpret a logon request as an intrusion attempt and deny access to the user.  
  
#### To verify the date and time settings on your computer  
  
1.  Hover the mouse cursor in the lower left corner of your screen, and click when the thumbnail of the **Start** screen appears.  
  
2.  On the **Start** screen, click **Control Panel**.  
  
3.  In the Control Panel, click **Clock, Language, and Region**, and then click **Date and Time**.  
  
4.  In the **Date and Time** dialog box, verify that the date, time, and time zone are correct, and change them if they are not correct.  
  
5.  To change the time zone, click **Change the time zone**, and then in the **Time Zone Settings** dialog box, click your current time zone in the drop-down list.  
  
    > [!NOTE]
    >  If your time zone observes daylight saving time and you want the computer clock to be adjusted automatically when daylight saving time changes, make sure the **Automatically adjust clock for Daylight Saving Time** check box is selected.  
  
6.  Click **OK** to close the **Time Zone Settings** dialog box.  
  
7.  To change the date or time, click **Change date and time**, and then in the **Date and Time Settings** dialog box, do one or more of the following:  
  
    1.  To change the hour, double-click the hour, and then click the arrows to increase or decrease the value.  
  
    2.  To change the minutes, double-click the minutes, and then click the arrows to increase or decrease the value.  
  
    3.  To change the seconds, double-click the seconds, and then click the arrows to increase or decrease the value.  
  
8.  Click **OK** to close the **Date and Time Settings** dialog box.  
  
9. Click **OK** to close the **Date and Time** dialog box.  
  
##  <a name="BKMK_ConnectComputer"></a> How do I connect my computers to my server?  
 When you connect a computer to the server running  Windows Server Essentials,  Windows Server 2012 R2 with the Windows Server Essentials Experience role installed, make sure your client computer has a valid connection to the Internet. In addition, you need the following information:  
  
-   The user name and password of the person who will use the computer on the new network.  
  
-   The user name and password of the computer™s local administrator account.  
  
> [!NOTE]
>  Complete the following procedure on all client computers to connect them to your server.  
  
#### To connect a client computer to the server  
  
1.  Log on to the computer that you want to connect to the server.  
  
    > [!NOTE]
    >  If this computer has multiple user accounts, log on by using the user account that has documents, pictures, and personal preferences you want to keep after you connect the computer to the server.  
  
2.  Open an Internet browser, such as Internet Explorer.  
  
3.  In the address bar, type **http://<servername\>/Connect**, and then press ENTER.  
  
    > [!NOTE]
    >  If your computer is at a remote location outside of the Windows Server Essentials network, to run the Connect a Computer to the Server Wizard, type **http://<domainname\>/connect** in the address bar of your web browser (where <domain\> is the domain name of your organization). You can get your domain name information from your network administrator.  
  
4.  The **Connect your computer to the server** page appears. Do one of the following:  
  
    -   For a computer running the Windows operating system, click **Download software for Windows**.  
  
    -   For a computer running the Mac operating system, click **Download software for Mac**.  
  
5.  In the file download security warning message, click **Run**.  
  
6.  If the User Account Control message appears, click **Yes** or type the local user name and password, if prompted.  
  
7.  The Connect a Computer to the Server Wizard appears. Do the following to complete the wizard:  
  
    1.  On the **Find my server** page, auto-detect the server in the local networks and select the server that you want to connect to. Or, if you have the information, you can manually input your server™s name or domain address.  
  
    2.  On the **Type your new network user name and password** page, do the following:  
  
        -   If this is the first computer that you are connecting to the server, and if this is the computer that you will be using to administer the server, use the administrator account that you created during setup.  
  
        -   For all other computers, first create a network user account on the server by using the Dashboard. Create the user account with Administrator or Standard user rights, based on the tasks that are performed by the person who is using the computer.  
  
    3.  If your computer is running  Windows 8 or  Windows 8.1, skip this step. If your computer is running Windows 7, and if you have documents, pictures, or personal preferences (such as desktop backgrounds, screen savers, or Internet Explorer favorites) that you want to keep after you join the computer to the new network, on the **Choose if you want to move your existing data and settings** page of the wizard, select the **Move my data and settings to my new network user account**.  
  
    4.  Choose if you want to automatically wake the computer to create a backup on the **Choose if you want to wake this computer to create its backup** page.  
  
    5.  Follow the remaining instructions in the wizard to join your computer to the network.  
  
8.  After you join your computer to the network, use your new user name and password to log on to the computer.  
  
    > [!NOTE]
    >  When you log on to a computer that is running  Windows 8 for the first time by using your network account, after it connects to the server, instructions for migrating files and applications from the old user account appear. Follow the instructions on the **How do I migrate files and applications from my old user account?** page to migrate all files and applications to the network user account.  
  
9. After the computer is successfully connected to the server, shortcuts to the Connector Tray app and the server Dashboard appear on the Start menu, which can be used as follows:  
  
    > [!NOTE]
    >  If your computer is running  Windows 8 or  Windows 8.1, the Dashboard and the Connector TrayApp will be searchable as applications.  
  
    1.  From the Connector TrayApp, you can enable or disable the **Keep me remotely connected** feature. You can also double-click the Connector Tray app to start the Launchpad. From the Launchpad, you can access the Shared folders shortcut, configure computer backups, address alerts, and open Remote Web Access.  
  
    2.  From the **Dashboard** link, you can administer your server.  
  
##  <a name="BKMK_Support"></a> Support information  
 For help resolving issues in  Windows Server Essentials, you can post your questions on the [Windows Server Essentials Forums](http://social.technet.microsoft.com/Forums/windowsserver/home?forum=winserveressentials) website.  
  
##  <a name="BKMK_Troubleshoot"></a> Troubleshoot Windows Server Essentials installation  
 Troubleshooting information that is related to a  Windows Server Essentials installation is currently not available. For help resolving installation issues, you can post your questions on the [Windows Server Essentials Forums](http://social.technet.microsoft.com/Forums/windowsserver/home?forum=winserveressentials) website.  
  
## See also  
  
-   [Install and Configure Windows Server Essentials](../install/Install-and-Configure-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md)  
  
-   [Windows Server Essentials and Windows Server Essentials](../Windows-Server-Essentials-Overview.md)
