---
title: "Step 1: Prepare your Source Server for Windows Server Essentials migration"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 244c8a06-04c6-4863-8b52-974786455373
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Step 1: Prepare your Source Server for Windows Server Essentials migration

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

This topic explains how to back up the Source Server, evaluate the Source Server system health, install the most recent service packs and fixes, and verify the network configuration.  

## To prepare for migration  
 Complete the following preliminary steps to ensure that the settings and data on your Source Server migrate successfully to the Destination Server.  

1.  [Back up your Source Server](Step-1--Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_BackUpYourSourceServerToPrepareForMigration)  

2.  [Install the most recent service packs](Step-1--Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_InstallTheMostRecentServicePacksToPrepareForMigration)  

3.  [Delete the Log on as a service account setting](Step-1--Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_DeleteSvcAcctSetting)  

4.  [Evaluate the health of the Source Server](Step-1--Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_EvaluateHealth)  

5.  [Create a plan to migrate line-of-business applications](Step-1--Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_MigrateLOB)  

###  <a name="BKMK_BackUpYourSourceServerToPrepareForMigration"></a> Back up your Source Server  
 Back up your Source Server before you begin the migration process. Making a backup helps protect your data from accidental loss if an unrecoverable error occurs during migration.  

##### To back up the Source Server  

1. Use one of the resources in the following table to guide you in performing a full backup of the Source Server.  

2. Verify that the backup ran successfully. To test the integrity of the backup, select random files from your backup, restore them to an alternate location, and then confirm that the restored files are the same as the original files.  

   |Product|Resource|
   |---|---|
   |Windows Small Business Server 2003|[Backing Up and Restoring Windows Small Business Server 2003](https://msdn.microsoft.com/library/cc875809.aspx) 
   |Windows Small Business Server 2008|[Backing Up and Restoring Data on Windows Small Business Server 2008](https://technet.microsoft.com/library/cc527505\(WS.10\).aspx)
   |Windows Server 2008 Foundation|[Backup and Recovery](https://technet.microsoft.com/library/cc754097\(WS.10\).aspx)  
   |Windows Small Business Server 2011 Essentials|[Learn more about setting up server backup](https://technet.microsoft.com/library/server-backup-support-1.aspx)
   |Windows Small Business Server 2011 Standard|[Managing Server Backup](https://technet.microsoft.com/library/cc527488.aspx)  
   |Windows Server Essentials|[Manage Backup and Restore in Windows Server Essentials](https://technet.microsoft.com/library/jj713536.aspx)

###  <a name="BKMK_InstallTheMostRecentServicePacksToPrepareForMigration"></a> Install the most recent service packs  
 You must install the latest updates and service packs on the Source Server prior to migration.  

###  <a name="BKMK_DeleteSvcAcctSetting"></a> Delete the Log on as a service account setting  
 If you're migrating from Windows Small Business Server 2003 or Windows Server 2003, delete the **Log on as a service** account setting from Group Policy.  

##### To delete the Log on as a service account setting  

1.  To open the **Group Policy Management** tool, click **Start**, click **Control Panel**, click **Administrative Tools**, and then click **Group Policy Management**.  

2.  Right-click **Default Domain Controllers Policy**, and then click **Edit**.  

3.  Navigate to **Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment**.  

4.  In the details pane, double-click **Log on as a service**.  

5.  Clear the **Define these policy settings** check box.  

6.  Delete \\\localhost\SYSVOL\\<domainname\>\scripts\SBS_LOGIN_SCRIPT.bat.  

###  <a name="BKMK_EvaluateHealth"></a> Evaluate the health of the Source Server  
 It is important to evaluate the health of your Source Server before you begin the migration. Use the following procedures to ensure that the updates are current, to generate a system health report, and to run the Windows Server Solutions Best Practice Analyzer (BPA).  

#### Download and install critical and security updates  
 Installing critical and security updates on the Source Server helps ensure that your migration will be successful and helps protect your network during the migration process.  

###### To check for the latest updates  

1.  From the Source Server, click **Start**, click **All Programs**, and then click **Windows Update**.  

2.  Click **Check for updates**.  

3.  If updates are found, click **Install updates**.  

#### Run the Best Practices Analyzer  
 You can run the Best Practices Analyzer (BPA) to verify that there are no issues on your server, network, or domain before you start the migration process. The BPA collects configuration information from the following sources:  

-   Active Directory Windows Management Instrumentation (WMI)  

-   The registry  

-   Internet Information Services (IIS)  

###### To use the BPA to analyze your Source Server  

1. The following table provides links to the Microsoft Download Center where you can download and install the Best Practices Analyzer (BPA) for the Source Server from.  


   |             If your Source Server is running             |                                                     you can get the BPA tools from                                                      |
   |----------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------|
   |                     Windows SBS 2003                     | [Microsoft Windows Small Business Server 2003 Best Practices Analyzer website](https://www.microsoft.com/download/details.aspx?id=5334) |
   |                     Windows SBS 2008                     | [Microsoft Windows Small Business Server 2008 Best Practices Analyzer website](https://www.microsoft.com/download/details.aspx?id=6231) |
   | Windows SBS 2011 Essentials or Windows SBS 2011 Standard |          [Windows Server Solutions Best Practices Analyzer website](https://www.microsoft.com/download/details.aspx?id=15556)           |
   |     Windows Server Essentials or Windows Server 2012     |                                                          The server dashboard                                                           |


2. After the download is complete, click **Start**, point to **All Programs**, and then click **SBS Best Practices Analyzer Tool**.  

   > [!NOTE]
   >  Check for updates before you scan the server.  

3. In the navigation pane, click **Start a scan**.  

    If your Source Server is running Windows Server Essentials, do the following:  

   1.  Log on to the Destination Server as an administrator, and then open the Dashboard.  

   2.  On the Dashboard, click the **Devices** tab.  

   3.  In the <**Server** >**Tasks** pane, click **Best Practices Analyzer**.  

4. In the details pane, type the scan label, and then click **Start scanning**. The scan label is the name of the scan report, for example, **SBS BPA Scan 1Jul2013**.  

5. After the scan finishes, click **View a report of this Best Practices scan**.  

   After the BPA tool collects information about server configuration, it verifies that the information is correct and then presents administrators with a list of information and issues sorted by severity. The list describes each issue and provides a recommendation or possible solution. Three report types are available:  

|Report type|Description
|-----------------|----------------- 
|List Reports|Displays reports in a one-dimensional list. 
|Tree Reports|Displays reports in a hierarchical list.

To view the description and the solutions for an issue, click the issue in the report. Not all of the issues that are reported by the BPA tool affect migration, but you should solve as many of the issues as possible to ensure that the migration is successful.  

####  <a name="BKMK_SynchronizeTheSourceServerTimeWithAnExternalTimeSource"></a> Synchronize the Source Server time with an external time source  
 The time on the Source Server must be set to within five minutes of the time on the Destination Server, and the date and time zone must be the same on both servers. If the Source Server is running in a virtual machine, the date, time, and time zone on the host server must match that of the Source Server and the Destination Server. To help ensure that  Windows Server Essentials is installed successfully, you must synchronize the Source Server time to the Network Time Protocol (NTP) server on the Internet.  

###### To synchronize the Source Server time with the NTP server  

1.  Sign on to the Source Server with a domain administrator account and password.  

2.  Click **Start**, click **Run**, type **cmd** in the text box, and then press ENTER.  

3.  At the command prompt, type w32tm /config /syncfromflags:domhier /reliable:no /update, and then press ENTER.  

4.  At the command prompt, type net stop w32time, and then press ENTER.  

5.  At the command prompt, type net start w32time, and then press ENTER.  

> [!IMPORTANT]
>  During the  Windows Server Essentials installation, you have an opportunity to verify the time on the Destination Server and change it, if necessary. Ensure that the time is within five minutes of the time that is set on the Source Server. When the installation finishes, the Destination Server synchronizes with the NTP. All domain-joined computers, including the Source Server, synchronize to the Destination Server, which assumes the role of the primary domain controller (PDC) emulator master.  

###  <a name="BKMK_MigrateLOB"></a> Create a plan to migrate line-of-business applications  
 A line-of-business (LOB) application is a critical computer application that is vital to running a business. LOB applications include accounting, supply-chain management, and resource-planning applications.  

 When you plan to migrate your LOB applications, consult with the LOB application providers to determine the appropriate method for migrating each application. You also must locate the media that is used to install the LOB applications on the Destination Server.  

> [!NOTE]
>  If you used the Windows Small Business Server 2011 Essentials SDK to develop a customized system health or alert add-In, and you want to continue to use the add-in with  Windows Server Essentials, you must also update the add-in and deploy it on the Destination Server.  


### Create a plan to migrate email hosted on Windows SBS 2011, Windows SBS 2008, and Windows SBS 2003  
 In Windows SBS 2011, Windows SBS 2008, and Windows SBS 2003, email is provided through the Microsoft Exchange Server. However,  Windows Server Essentials does not provide an inbox email service. If you are currently using a server running Windows SBS 2011, Windows SBS 2008, or Windows SBS 2003 to host your company s email, you need to migrate to an alternate on-premises or hosted solution.  

> [!NOTE]
>  After you update and prepare your Source Server for migration, we recommend that you create a backup of the updated server before you continue the migration process.  

#### Migrate email to Microsoft Office 365  
 If you have chosen to use Microsoft Office 365 as the email solution for your domain, follow the guidance in [Migrate All Mailboxes to the Cloud with a Cutover Exchange Migration](https://help.outlook.com/140/ms.exch.ecp.emailmigrationwizardexchangelearnmore.aspx) to start the email migration to Office 365. We recommend that you complete the email migration before you install  Windows Server Essentials.  

> [!NOTE]
>  The step to remove the on-premises Exchange Server on the Source Server is mandatory if you intend to integrate  Windows Server Essentials with Office 365. For information about how to migrate Exchange Server public folders to Office 365,  see the blog post [Microsoft Exchange 2013 Public Folders Migration Scripts for Office 365](https://blogs.technet.com/b/fmustafa/archive/2013/04/11/microsoft-exchange-2013-public-folders-migration-scripts-for-office-365.aspx).  
>   
>  After you complete the installation, you should turn on the Office 365 Integration feature in  Windows Server Essentials by running the **Integrate with Microsoft Office 365** task.  

> [!IMPORTANT]
>  To allow the Office 365 migration tool to connect to the Exchange Server that is running on the Source Server, you must enable RPC over HTTP on the Source Server. For information about how to enable RPC over HTTP, see [How to Deploy RPC over HTTP for the First Time in Small Business Server 2003 (Standard or Premium)](https://technet.microsoft.com/library/bb123622%28EXCHG.65%29.aspx). If you cannot successfully run the Office 365 migration tool after you enable RPC over HTTP, view the **ValidPorts** setting in the registry at HKEY_LOCAL_MACHINE\Software\Microsoft\Rpc\RpcProxy, and make sure that the fully qualified domain name (FQDN) for the Source Server is listed. If the FQDN is not listed, add it manually by using the following example:  
>   
>  remote. *contoso*.com:6001-6002;remote. *contoso*.com:6004 (replace *contoso* with the name of your domain).  

#### Migrate email to another on-premises Exchange Server  
 For information about how to migrate email to another on-premises Exchange Server, see [Integrate an On-Premises Exchange Server with Windows Server Essentials](https://technet.microsoft.com/library/jj200172.aspx). We recommend that you set up the new on-premises Exchange Server after you install  Windows Server Essentials, and then finish the email migration before demoting the Source Server.  

> [!NOTE]
>  The Windows Small Business Server POP3 Connector is not included with Exchange Server. After you migrate email data to another Exchange Server, you can no longer use the POP3 Connector feature.  

> [!NOTE]
>  After you update and prepare your Source Server for migration, you should create a backup of the updated server before you continue the migration process.  

## Next steps  
 You have prepared your Source Server for migration to  Windows Server Essentials.  Now go to [Step 2: Install Windows Server Essentials as a new replica domain controller](Step-2--Install-Windows-Server-Essentials-as-a-new-replica-domain-controller.md).  

To view all the steps, see [Migrate to Windows Server Essentials](Migrate-from-Previous-Versions-to-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md).

