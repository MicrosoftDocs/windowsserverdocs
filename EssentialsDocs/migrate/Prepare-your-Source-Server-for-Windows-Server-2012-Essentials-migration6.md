---
title: "Prepare your Source Server for Windows Server 2012 Essentials migration6"
ms.custom: na
ms.date: 10/03/2012
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
H1: Prepare your Source Server for Windows Server 2012 Essentials migration
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: 2d0c6d68-fc5b-4b30-95cf-a7205e66839b
caps.latest.revision: 2
author: DonGill
manager: stevenka
translation.priority.ht: 
  - de-at
  - de-de
  - es-es
  - fr-be
  - fr-fr
  - it-ch
  - it-it
  - ja-jp
  - ko-kr
  - pt-br
  - ru-ru
  - zh-cn
  - zh-tw
---
# Prepare your Source Server for Windows Server 2012 Essentials migration6
Complete the following preliminary steps to ensure that the settings and data on your Source Server migrate successfully to the Destination Server.  
  
#### To prepare for migration  
  
1.  [Back up your Source Server](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration3.md#BKMK_BackUpYourSourceServerToPrepareForMigration)  
  
2.  [Install the most recent service packs](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration3.md#BKMK_InstallTheMostRecentServicePacksToPrepareForMigration)  
  
3.  [Verify the network configuration](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration3.md#BKMK_Verify)  
  
4.  [Evaluate the health of the Source Server](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration3.md#BKMK_UseWindowsBestPracticeAnalyzer)  
  
5.  [Run the Migration Preparation Tool on the Source Server](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration3.md#BKMK_MPT)  
  
6.  [Synchronize the Source Server time with an external time source](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration6.md#BKMK_SynchronizeTheSourceServerTimeWithAnExternalTimeSource)  
  
7.  [Create a plan to migrate line-of-business applications](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration3.md#BKMK_PlanToMigrateLineOfBusinessApplications)  
  
###  <a name="BKMK_BackUpYourSourceServerToPrepareForMigration"></a> Back up your Source Server  
 Back up your Source Server before you begin the migration process. Making a backup helps protect your data from accidental loss if an unrecoverable error occurs during migration.  
  
##### To back up the Source Server  
  
1.  Perform a full backup of the Source Server. For more information about backing up [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)], see [Manage Backup and Restore](../manage/Manage-Backup-and-Restore-in-Windows-Server-Essentials.md).  
  
2.  Verify that the backup ran successfully. To test the integrity of the backup, select random files from your backup, restore them to an alternate location, and then confirm that the restored files are the same as the original files.  
  
###  <a name="BKMK_InstallTheMostRecentServicePacksToPrepareForMigration"></a> Install the most recent service packs  
 To help prevent issues with compatibility, you should install the latest updates and service packs on the Source Server prior to migration.  
  
###  <a name="BKMK_Verify"></a> Disable the VPN on the Source Server  
 If you are using a VPN on the Source Server, disable it.  
  
##### To disable the VPN on the Source Server  
  
1.  Log on to the Source Server as an administrator, and then open the [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)] Dashboard.  
  
2.  On the Dashboard **Home** page, click **Settings**, click **Anywhere Access**, and then click **Configure**.  
  
3.  On the first page of the **Set up Anywhere Access** wizard, click **Next** to accept the current setting.  
  
4.  On the **Choose Anywhere Access features to enable** page, clear the check box for the **Virtual private network (VPN)** feature, and then click **Next**.  
  
5.  Follow the remaining steps in the wizard to complete the configuration change.  
  
###  <a name="BKMK_UseWindowsBestPracticeAnalyzer"></a> Evaluate the health of the Source Server  
 It is important to evaluate the health of your Source Server before you begin the migration. Use the following procedures to ensure that the Source Server is in good health for migration.  
  
#### Download and install critical and security updates  
 Installing critical and security updates on the Source Server helps ensure that your migration will be successful and helps protect your network during the migration process.  
  
###### To check for the latest updates  
  
1.  From the Source Server, open Control Panel, click **System and Security**, and then click **Check for updates**.  
  
2.  On the Windows Update page, click **Check for updates**.  
  
3.  If updates are found, click **Install updates**.  
  
> [!NOTE]
>  Alternately, you can update the Windows Server Update Services (WSUS) server to review, approve and install available updates.  
  
#### Check the alert viewer critical errors  
 You can open the alert viewer on the Dashboard to check for critical errors.  
  
#### Run the Windows Server 2012 Essentials Best Practices Analyzer  
 You can run the [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)] Best Practices Analyzer (BPA) to verify that there are no issues on your server, network, or domain before you start the migration process. The BPA collects configuration information from the following sources:  
  
-   Active Directory® Windows Management Instrumentation (WMI)  
  
-   The registry  
  
-   The Internet Information Services (IIS) metabase  
  
###### To use the Windows Server 2012 Essentials BPA to analyze your Source Server  
  
1.  Log on to the Source Server as an administrator, and then open the [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)] Dashboard.  
  
2.  In the Dashboard, click **Devices**.  
  
    > [!NOTE]
    >  In the **Server Tasks** pane, click **Best Practices Analyzer**.  
  
3.  Review each BPA message, and follow the instructions to resolve issues if necessary.  
  
 Not all of the issues that are reported by the [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)] BPA affect migration, but you should solve as many of the issues as possible to ensure that the migration is successful.  
  
####  <a name="BKMK_SynchronizeTheSourceServerTimeWithAnExternalTimeSource"></a> Synchronize the Source Server time with an external time source  
 The time on the Source Server must be set to within five minutes of the time on the Destination Server, and the date and time zone must be the same on both servers. If the Source Server is running in a virtual machine, the date, time, and time zone on the host server must match that of the Source Server and the Destination Server. To help ensure that [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)] is installed successfully, you must synchronize the Source Server time to the Network Time Protocol (NTP) server on the Internet.  
  
###### To synchronize the Source Server time with the NTP server  
  
1.  Log on to the Source Server with a domain administrator account and password.  
  
2.  Open a command prompt.  
  
3.  At the command prompt, type w32tm /config /syncfromflags:domhier /reliable:no /update, and then press ENTER.  
  
4.  At the command prompt, type net stop w32time, and then press ENTER.  
  
5.  At the command prompt, type net start w32time, and then press ENTER.  
  
> [!IMPORTANT]
>  During the [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)] installation, you have an opportunity to verify the time on the Destination Server and change it, if necessary. Ensure that the time is within five minutes of the time that is set on the Source Server. When the installation finishes, the Destination Server synchronizes with the NTP. All domain-joined computers, including the Source Server, synchronize to the Destination Server, which assumes the role of the primary domain controller (PDC) emulator master.  
  
###  <a name="BKMK_PlanToMigrateLineOfBusinessApplications"></a> Create a plan to migrate line-of-business applications  
 A line-of-business (LOB) application is a critical computer application that is vital to running a business. LOB applications include accounting, supply-chain management, and resource-planning applications.  
  
 When you plan to migrate your LOB applications, consult with the LOB application providers to determine the appropriate method for migrating each application. You also must locate the media that is used to install the LOB applications on the Destination Server.  
  
> [!NOTE]
>  If you used the [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)] SDK to develop a customized system health or alert add-In, and you want to continue to use the add-in with [!INCLUDE[sbs_sbs8web_2](../install/includes/sbs_sbs8web_2_md.md)], you must also update the add-in and deploy it on the destination server.  
  
 You can fill in the following table as you collect LOB application information. A good place to start collecting information is to review the programs listed on the **Programs and Features** page of Control Panel. You can also view the programs that are installed in the **Program Files (x86)** and the **Program Files** folders of the system drive.  
  
|Application or general data folder name|Path to data|Notes|  
|---------------------------------------------|------------------|-----------|  
||||  
||||  
||||