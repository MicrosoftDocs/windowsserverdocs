---
title: "Prepare your Source Server for Windows Server 2012 Essentials migration2"
ms.custom: na
ms.date: 11/20/2012
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
H1: Prepare your Source Server for Windows Server 2012 Essentials migration
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: c6e25f9e-1018-42d2-ac20-0b08ca4f4630
caps.latest.revision: 7
author: DonGill
manager: stevenka

---
# Prepare your Source Server for Windows Server 2012 Essentials migration2
Complete the following preliminary steps to ensure that the settings and data on your Source Server migrate successfully to the Destination Server.  
  
#### To prepare for migration  
  
<<<<<<< HEAD
1.  [Back up your Source Server](Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration2.md#BKMK_BackUpYourSourceServerToPrepareForMigration)  
  
2.  [Install the most recent service packs](Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration2.md#BKMK_InstallTheMostRecentServicePacksToPrepareForMigration)  
  
3.  [Verify the network configuration](Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration2.md#BKMK_Verify)  
  
4.  [Evaluate the health of the Source Server](Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration2.md#BKMK_UseWindowsBestPracticeAnalyzer)  
  
5.  [Run the Migration Preparation Tool on the Source Server](Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration2.md#BKMK_MPT)  
  
6.  [Create a plan to migrate line-of-business applications](Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration2.md#BKMK_PlanToMigrateLineOfBusinessApplications)  
=======
1.  [Back up your Source Server](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration2.md#BKMK_BackUpYourSourceServerToPrepareForMigration)  
  
2.  [Install the most recent service packs](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration2.md#BKMK_InstallTheMostRecentServicePacksToPrepareForMigration)  
  
3.  [Verify the network configuration](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration2.md#BKMK_Verify)  
  
4.  [Evaluate the health of the Source Server](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration2.md#BKMK_UseWindowsBestPracticeAnalyzer)  
  
5.  [Run the Migration Preparation Tool on the Source Server](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration2.md#BKMK_MPT)  
  
6.  [Create a plan to migrate line-of-business applications](../migrate/Prepare-your-Source-Server-for-Windows-Server-2012-Essentials-migration2.md#BKMK_PlanToMigrateLineOfBusinessApplications)  
>>>>>>> 4bac1739fd0378146de6c9af26f683b8076754b8
  
###  <a name="BKMK_BackUpYourSourceServerToPrepareForMigration"></a> Back up your Source Server  
 Back up your Source Server before you begin the migration process. Making a backup helps protect your data from accidental loss if an unrecoverable error occurs during migration.  
  
##### To back up the Source Server  
  
1.  Perform a full backup of the Source Server. For more information about backing up Windows Server 2008 Foundation, see [Backup and Recovery](http://technet.microsoft.com/library/cc754097\(WS.10\).aspx).  
  
2.  Verify that the backup ran successfully. To test the integrity of the backup, select random files from your backup, restore them to an alternate location, and then confirm that the restored files are the same as the original files.  
  
###  <a name="BKMK_InstallTheMostRecentServicePacksToPrepareForMigration"></a> Install the most recent service packs  
 Before you begin the migration, you should install the latest updates and service packs on the Source Server.  
  
###  <a name="BKMK_Verify"></a> Verify the network configuration  
 Before you can migrate your network to  Windows Server 2012 Essentials, you must install and configure a router on your network and configure the Source Server to use one network adapter. When you are done, your network will look like the following figure.  
  
<<<<<<< HEAD
 ![Example small business network](media/WSE_Network.png "WSE_Network")  
=======
 ![Example small business network](../migrate/media/WSE_Network.png "WSE_Network")  
>>>>>>> 4bac1739fd0378146de6c9af26f683b8076754b8
  
#### Disable the VPN on the Source Server  
 If you are using a VPN on the Source Server, disable it.  
  
####  <a name="BKMK_VerifyTheDHCPSettings"></a> Verify the settings for the DHCP Server role  
  Windows Server 2012 Essentials does not run the DHCP Server role by default. During migration, you can manage the DHCP Server role from the Source Server or from the router, depending on your current network configuration:  
  
-   If you are running the DHCP Server role on the Source Server, we recommend that you continue to run this role from the Source Server during migration. After you have removed the Source Server from the network, move the DHCP Server role to the router.  
  
-   If your network already runs the DHCP Server role from the router, and it is running without issues, we recommend that you continue to run the DHCP Server role from the router during migration.  
  
> [!NOTE]
>  Ensure that your Source Server is in a healthy state before you proceed by performing the procedures in the following section.  
  
###  <a name="BKMK_UseWindowsBestPracticeAnalyzer"></a> Evaluate the health of the Source Server  
 It is important to evaluate the health of your Source Server before you begin the migration. Use the following procedures to ensure that the Source Server is in good health for migration.  
  
#### Download and install critical and security updates  
 Installing critical and security updates on the Source Server helps ensure that your migration will be successful and helps protect your network during the migration process.  
  
###### To check for the latest updates  
  
1.  From the Source Server, click **Start**, click **All Programs**, and then click **Windows Update**.  
  
2.  Click **Check online for updates from Microsoft Update**.  
  
3.  If updates are found, click **Install updates**.  
  
####  <a name="BKMK_SynchronizeTheSourceServerTimeWithAnExternalTimeSource"></a> Synchronize the Source Server time with an external time source  
 The time on the Source Server must be set to within five minutes of the time on the Destination Server, and the date and time zone must be the same on both servers. If the Source Server is running in a virtual machine, the date, time, and time zone on the host server must match that of the Source Server and the Destination Server. To help ensure that  Windows Server 2012 Essentials is installed successfully, you must synchronize the Source Server time to the Network Time Protocol (NTP) server on the Internet.  
  
###### To synchronize the Source Server time with the NTP server  
  
1.  Sign on to the Source Server with a domain administrator account and password.  
  
2.  Click **Start**, click **Run**, type **cmd** in the text box, and then press ENTER.  
  
3.  At the command prompt, type **w32tm /config /syncfromflags:domhier /reliable:no /update**, and then press ENTER.  
  
4.  At the command prompt, type **net stop w32time**, and then press ENTER.  
  
5.  At the command prompt, type **net start w32time**, and then press ENTER.  
  
> [!IMPORTANT]
>  During the  Windows Server 2012 Essentials installation, you have an opportunity to verify the time on the Destination Server and change it, if necessary. Ensure that the time is within five minutes of the time that is set on the Source Server. When the installation finishes, the Destination Server synchronizes with the NTP. All domain-joined computers, including the Source Server, synchronize to the Destination Server, which assumes the role of the primary domain controller (PDC) emulator master.  
  
###  <a name="BKMK_MPT"></a> Run the Migration Preparation Tool on the Source Server  
 You cannot perform a migration mode installation without first running the Migration Preparation Tool on your Source Server. This tool is designed to prepare your Source Server and domain to be migrated to  Windows Server 2012 Essentials.  
  
> [!IMPORTANT]
>  Back up your Source Server before you run the Migration Preparation Tool. All changes that the Migration Preparation Tool makes to the schema are irreversible. If you experience issues during the migration, the only way to return the Source Server to the state it was in before you ran the tool is to restore the server from a system backup.  
  
 To run the Migration Preparation Tool, you must be a member of the Enterprise Admins group, the Schema Admins group, and the Domain Admins group.  
  
##### To verify that you have the appropriate permissions to run the tool on the Source Server  
  
1.  On the Source Server, click **Start**, click **Administrative Tools**, and then click **Active Directory Users and Computers**.  
  
2.  In the console tree, click to expand your domain, and then click **Users**.  
  
3.  Right-click the administrator account that you are using for the migration, and then click **Properties**.  
  
4.  Click the **Member Of** tab, and then verify that Enterprise Admins, Schema Admins, and Domain Admins are listed in the **Member of** text box.  
  
5.  If the groups are not listed, click **Add**, and then add each group that is not listed.  
  
    > [!NOTE]
    >  -   You might receive a permission error if the Netlogon service is not started.  
    > -   You must log off and log back on the server for the changes to take effect.  
  
     You can use the latest version of the Windows Update Agent to ensure that the server update process works properly.  
  
     Before you can install Windows Update Agent on the Source Server, you must first install Windows PowerShell 2.0 and Microsoft Baseline Configuration Analyzer 2.0.  
  
 You can use the latest version of the Windows Update Agent to ensure that the server update process works properly.  
  
 Before you can install Windows Update Agent on the Source Server, you must first install Windows PowerShell 2.0 and Microsoft Baseline Configuration Analyzer 2.0.  
  
-   To download and install Windows PowerShell 2.0, see [article 968929](http://go.microsoft.com/fwlink/p/?LinkId=241483) in the Microsoft Knowledge Base.  
  
-   To download and install Microsoft Baseline Configuration Analyzer 2.0, see [Microsoft Baseline Configuration Analyzer 2.0](http://go.microsoft.com/fwlink/p/?LinkId=241484) at the Microsoft Download Center.  
  
-   To download and install the latest version of Windows Update Agent, see [article 949104](http://go.microsoft.com/fwlink/p/?LinkId=237493) in the Microsoft Knowledge Base.  
  
##### To install and run the Migration Preparation Tool on the Source Server  
  
1.  Insert  Windows Server 2012 Essentials DVD1 in the DVD drive on the Source Server.  
  
2.  Open Windows Explorer, browse to the **\support\tools** folder of the DVD, and then double-click the **sourcetool.msi** file.  
  
    > [!NOTE]
    >  -   If the Migration Preparation Tool is already installed on the server, run the tool from the **Start** menu.  
    > -   To ensure that you are prepared for the best possible migration experience, it is recommended that you always choose to install the most recent update.  
  
     The wizard installs the Migration Preparation Tool on the Source Server. When the installation is complete, the Migration Preparation Tool runs automatically and installs the latest updates.  
  
3.  In the **Migration Preparation Tool**, select **I have a backup and am ready to proceed**, and then click **Next**.  
  
    > [!NOTE]
    >  If you receive an error message relating to hotfix installation, see “Method 2: Rename the Catroot2 Folder�? in [article 822798](http://go.microsoft.com/FWLink/p/?LinkID=118672) in the Microsoft Knowledge Base.  
  
     The Migration Preparation Tool prepares the source domain for migration by extending the Active Directory schema. After the task is completed, click **Next** to continue.  
  
4.  After preparing the source domain, the Migration Preparation Tool scans the Source Server to identify two types of potential issues.  
  
    -   **Errors** Issues found on the Source Server that can block the migration or cause the migration to fail. Follow the instructions in the error message to fix the issues, and then click **Scan Again**.  
  
    -   **Warnings** Issues found on the Source Server that can cause functional problems during migration. It is strongly recommended that you follow the instructions in the error message to fix issues before proceeding with the migration.  
  
     After you fix or acknowledge all of the issues, click **Next**.  
  
5.  In the Migration Preparation Tool, click **Finish**.  
  
6.  When the Migration Preparation Tool finishes, you may be prompted to restart the Source Server before you can begin migrating to  Windows Server 2012 Essentials.  
  
> [!NOTE]
>  You must complete a successful run of the Migration Preparation Tool on the Source Server within two weeks of installing  Windows Server 2012 Essentials on the Destination Server. Otherwise, installation of  Windows Server 2012 Essentials on the Destination Server will be blocked. If this occurs, you must run the Migration Preparation Tool on the Source Server again.  
  
###  <a name="BKMK_PlanToMigrateLineOfBusinessApplications"></a> Create a plan to migrate line-of-business applications  
 A line-of-business (LOB) application is a critical computer application that is vital to running a business. LOB applications include accounting, supply-chain management, and resource-planning applications.  
  
 When you plan to migrate your LOB applications, consult with the LOB application providers to determine the appropriate method for migrating each application. You also must locate the media that is used to install the LOB applications on the Destination Server.  
  
> [!NOTE]
>  If you used the Windows Server 2008 Foundation SDK to develop a customized system health or alert add-In, and you want to continue to use the add-in with  Windows Server 2012 Essentials, you must also update the add-in and deploy it on the Destination Server.  
  
 You can fill in the following table as you collect LOB application information. A good place to start collecting information is to open Windows Control Panel, click **Add/Remove Programs**, and look in the **Program Files (x86)** and the **Program Files** folders.  
  
|Application or general data folder name|Path to data|Notes|  
|---------------------------------------------|------------------|-----------|  
||||  
||||  
||||
