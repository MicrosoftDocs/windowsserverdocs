---
title: "Prepare your Source Server for Windows Server Essentials migration1"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f5861ae9-77cb-4d37-b4c5-8f0757213385
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Prepare your Source Server for Windows Server Essentials migration1

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

Complete the following preliminary steps to ensure that the settings and data on your Source Server migrate successfully to the Destination Server.  
  
#### To prepare for migration  
  

1.  [Back up your Source Server](Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_BackUpYourSourceServerToPrepareForMigration)  
  
2.  [Install the most recent service packs](Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_InstallTheMostRecentServicePacksToPrepareForMigration)  
  
3.  [Evaluate the health of the Source Server](Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_UseWindowsBestPracticeAnalyzer)  
  
4.  [Run the Migration Preparation Tool on the Source Server](Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_MPT)  
  
5.  [Create a plan to migrate line-of-business applications](Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_PlanToMigrateLineOfBusinessApplications)  

1.  [Back up your Source Server](../migrate/Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_BackUpYourSourceServerToPrepareForMigration)  
  
2.  [Install the most recent service packs](../migrate/Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_InstallTheMostRecentServicePacksToPrepareForMigration)  
  
3.  [Evaluate the health of the Source Server](../migrate/Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_UseWindowsBestPracticeAnalyzer)  
  
4.  [Run the Migration Preparation Tool on the Source Server](../migrate/Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_MPT)  
  
5.  [Create a plan to migrate line-of-business applications](../migrate/Prepare-your-Source-Server-for-Windows-Server-Essentials-migration.md#BKMK_PlanToMigrateLineOfBusinessApplications)  

  
###  <a name="BKMK_BackUpYourSourceServerToPrepareForMigration"></a> Back up your Source Server  
 Back up your Source Server before you begin the migration process. Making a backup helps protect your data from accidental loss if an unrecoverable error occurs during migration.  
  
##### To back up the Source Server  
  
1.  Perform a full backup of the Source Server. For more information about backing up Windows Small Business Server 2011 Essentials, see [Learn more about setting up server backup](https://technet.microsoft.com/library/server-backup-support-1.aspx).  
  
2.  Verify that the backup ran successfully. To test the integrity of the backup, select random files from your backup, restore them to an alternate location, and then confirm that the restored files are the same as the original files.  
  
###  <a name="BKMK_InstallTheMostRecentServicePacksToPrepareForMigration"></a> Install the most recent service packs  
 You must install the latest updates and service packs on the Source Server prior to migration.  
  
###  <a name="BKMK_UseWindowsBestPracticeAnalyzer"></a> Evaluate the health of the Source Server  
 It is important to evaluate the health of your Source Server before you begin the migration. Use the following procedures to ensure that the updates are current, to generate a system health report, and to run the Windows Server Solutions Best Practice Analyzer (BPA).  
  
#### Download and install critical and security updates  
 Installing critical and security updates on the Source Server helps ensure that your migration will be successful and helps protect your network during the migration process.  
  
###### To check for the latest updates  
  
1.  From the Source Server, click **Start**, click **All Programs**, and then click **Windows Update**.  
  
2.  Click **Check for updates**.  
  
3.  If updates are found, click **Install updates**.  
  
#### Check the alert viewer for critical errors  
 You can check the alert viewer on the Dashboard for any critical errors.  
  
#### Run the Windows Server Solutions Best Practices Analyzer  
 You can run the Windows Server Solutions Best Practices Analyzer (BPA) to verify that there are no issues on your server, network, or domain before you start the migration process. The BPA collects configuration information from the following sources:  
  
-   Active Directory® Windows Management Instrumentation (WMI)  
  
-   The registry  
  
-   The Internet Information Services (IIS) metabase  
  
###### To use the Windows Server Solutions BPA to analyze your Source Server  
  
1. Download and install the [Windows Server Solutions Best Practices Analyzer](https://www.microsoft.com/en-us/download/details.aspx?id=15556) at the Microsoft Download Center.  
  
2. After the download is complete, click **Start**, point to **All Programs**, and then click **SBS Best Practices Analyzer Tool**.  
  
   > [!NOTE]
   >  Check for updates before you scan the server.  
  
3. In the navigation pane, click **Start a scan**.  
  
4. In the details pane, type the scan label, and then click **Start scanning**. The scan label is the name of the scan report, for example, **SBS BPA Scan 1Jul2012**.  
  
5. After the scan finishes, click **View a report of this Best Practices scan**.  
  
   After collecting information about server configuration, the Windows Server Solutions BPA verifies that the information is correct and then presents administrators with a list of information and issues sorted by severity. The list describes each issue and provides a recommendation or possible solution. Three report types are available:  
  
|Report Type|Description|  
|-----------------|-----------------|  
|List Reports|Displays reports in a one-dimensional list.|  
|Tree Reports|Displays reports in a hierarchical list.|  
|Other Reports|Displays reports such as a Run-Time Log.|  
  
 To view the description and the solutions for an issue, click the issue in the report. Not all of the issues that are reported by the Windows SBS 2011 Essentials BPA affect migration, but you should solve as many of the issues as possible to ensure that the migration is successful.  
  
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
  
###  <a name="BKMK_MPT"></a> Run the Migration Preparation Tool on the Source Server  
 You cannot perform a migration mode installation without first running the Migration Preparation Tool on your Source Server. This tool is designed to prepare your Source Server and domain to be migrated to  Windows Server Essentials.  
  
> [!IMPORTANT]
>  Back up your Source Server before you run the Migration Preparation Tool. All changes that the Migration Preparation Tool makes to the schema are irreversible. If you experience issues during the migration, the only way to return the Source Server to the state it was in before you ran the tool is to restore the server from a system backup.  
  
 To run the Migration Preparation Tool, you must be a member of the Enterprise Admins group, the Schema Admins group, and the Domain Admins group.  
  
##### To verify that you have the appropriate permissions to run the tool on the Source Server  
  
1. On the Source Server, click **Start**, click **Administrative Tools**, and then click **Active Directory Users and Computers**.  
  
2. In the console tree, click to expand your domain, and then click **Users**.  
  
3. Right-click the administrator account that you are using for the migration, and then click **Properties**.  
  
4. Click the **Member Of** tab, and then verify that Enterprise Admins, Schema Admins, and Domain Admins are listed in the **Member of** text box.  
  
5. If the groups are not listed, click **Add**, and then add each group that is not listed.  
  
   > [!NOTE]
   > - You might receive a permission error if the Netlogon service is not started.  
   >   -   You must log off and log back on the server for the changes to take effect.  
  
    You can use the latest version of the Windows Update Agent to ensure that the server update process works properly.  
  
   You can use the latest version of the Windows Update Agent to ensure that the server update process works properly.  
  
   Before you can install Windows Update Agent on the Source Server, you must first install Windows PowerShell 2.0 and Microsoft Baseline Configuration Analyzer 2.0.  
  
-   To download and install Windows PowerShell 2.0, see [article 968929](https://go.microsoft.com/fwlink/p/?LinkId=241483) in the Microsoft Knowledge Base.  
  
-   To download and install Microsoft Baseline Configuration Analyzer 2.0, see the [Microsoft Baseline Configuration Analyzer 2.0](https://go.microsoft.com/fwlink/p/?LinkId=241484) at the Microsoft Download Center.  
  
-   To download and install the latest version of Windows Update Agent, see [article 949104](https://go.microsoft.com/fwlink/p/?LinkId=237493) in the Microsoft Knowledge Base.  
  
##### To install and run the Migration Preparation Tool on the Source Server  
  
1. Insert  Windows Server Essentials DVD1 in the DVD drive on the Source Server.  
  
2. Open Windows Explorer, browse to the **\support\tools** folder of the DVD, and then double-click the **sourcetool.msi** file.  
  
   > [!NOTE]
   > - If the Migration Preparation Tool is already installed on the server, run the tool from the **Start** menu.  
   >   -   To ensure that you are prepared for the best possible migration experience, it is recommended that you always choose to install the most recent update.  
  
    The wizard installs the Migration Preparation Tool on the Source Server. When the installation is complete, the Migration Preparation Tool runs automatically and installs the latest updates.  
  
3. In the Migration Preparation Tool, select **I have a backup and am ready to proceed**, and then click **Next**.  
  
   > [!WARNING]
   >  If you receive an error message relating to a hotfix installation, see Method 2: Rename the Catroot2 Folder in [article 822798](https://go.microsoft.com/FWLink/p/?LinkID=118672) in the Microsoft Knowledge Base.  
  
    The Migration Preparation Tool prepares the source domain for migration by extending the Active Directory schema. After the task is completed, click **Next** to continue.  
  
4. After preparing the source domain, the Migration Preparation Tool scans the Source Server to identify two types of potential issues.  
  
   - **Errors** Issues found on the Source Server that can block the migration or cause the migration to fail. Follow the instructions in the error message to fix the issues, and then click **Scan Again**.  
  
   - **Warnings** Issues found on the Source Server that can cause functional problems during migration. It is strongly recommended that you follow the instructions in the error message to fix issues before proceeding with the migration.  
  
     After you fix or acknowledge all of the issues, click **Next**.  
  
5. In the Migration Preparation Tool, click **Finish**.  
  
6. When the Migration Preparation Tool finishes, you may be prompted to restart the Source Server before you can begin migrating to  Windows Server Essentials.  
  
> [!NOTE]
>  You must complete a successful run of the Migration Preparation Tool on the Source Server within two weeks of installing  Windows Server Essentials on the Destination Server. Otherwise, installation of  Windows Server Essentials on the Destination Server will be blocked. If this occurs, you must run the Migration Preparation Tool on the Source Server again.  
  
###  <a name="BKMK_PlanToMigrateLineOfBusinessApplications"></a> Create a plan to migrate line-of-business applications  
 A line-of-business (LOB) application is a critical computer application that is vital to running a business. LOB applications include accounting, supply-chain management, and resource-planning applications.  
  
 When you plan to migrate your LOB applications, consult with the LOB application providers to determine the appropriate method for migrating each application. You also must locate the media that is used to install the LOB applications on the Destination Server.  
  
> [!NOTE]
>  If you used the Windows Small Business Server 2011 Essentials SDK to develop a customized system health or alert add-In, and you want to continue to use the add-in with  Windows Server Essentials, you must also update the add-in and deploy it on the Destination Server.  
  
