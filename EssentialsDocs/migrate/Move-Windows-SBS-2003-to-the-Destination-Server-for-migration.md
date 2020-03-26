---
title: "Move Windows SBS 2003 settings and data to the Destination Server for Windows Server Essentials migration"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 67087ccb-d820-4642-8ca2-7d2d38714014
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Move Windows SBS 2003 settings and data to the Destination Server for Windows Server Essentials migration

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

Move settings and data to the Destination Server as follows:

1. [Copy data to the Destination Server](#copy-data-to-the-destination-server)

2. [Import Active Directory user accounts to the Windows Server Essentials Dashboard (optional)](#import-active-directory-user-accounts-to-the-windows-server-essentials-dashboard)

3. [Remove old logon scripts (optional)](#remove-old-logon-scripts)

4. [Remove legacy Active Directory Group Policy Objects (optional)](#remove-legacy-active-directory-group-policy-objects) 

5. [Configure the network](#configure-the-network) 

6. [Map permitted computers to user accounts](#map-permitted-computers-to-user-accounts)

## Copy data to the Destination Server
Before you copy data from the Source Server to the Destination Server, perform the following tasks: 

- Review the list of shared folders on the Source Server, including permissions for each folder. Create or customize the folders on the Destination Server to match the folder structure that you are migrating from the Source Server. 

- Review the size of each folder and ensure that the Destination Server has enough storage space. 

- Make the shared folders on the Source Server Read-only for all users so no writing can take place on the drive while you are copying files to the Destination Server. 

#### To copy data from the Source Server to the Destination Server 

1. Log on to the Destination Server as a domain administrator. 

2. Click **Start**, type **cmd** in the search box, and then press ENTER. 

3. At the command prompt, type the following command, and then press ENTER: 

    `robocopy \\<SourceServerName> \<SharedSourceFolderName> \\<DestinationServerName> \<SharedDestinationFolderName> /E /B /COPY:DATSOU /LOG:C:\Copyresults.txt` 

Where:
 - \<SourceServerName\> is the name of the Source Server
 - \<SharedSourceFolderName\> is the name of the shared folder on the Source Server
 - \<DestinationServerName\> is the name of the Destination Server,
 - \<SharedDestinationFolderName\> is the shared folder on the Destination Server to which the data will be copied. 

4. Repeat the previous step for each shared folder that you are migrating from the Source Server.

## Import Active Directory user accounts to the Windows Server Essentials Dashboard
 By default, all user accounts created on the Source Server are automatically migrated to the Dashboard in Windows Server Essentials. However, automatic migration of an Active Directory user account will fail if some properties do not meet migration requirements. You can use the following Windows PowerShell cmdlet to import Active Directory users.

#### To import an Active Directory user account to the Windows Server Essentials Dashboard

1. Log on to the Destination Server as a domain administrator.

2. Open Windows PowerShell as an administrator.

3. Run the following cmdlet, where `[AD username]` is the name of the Active Directory user account that you want to import:

    `Import-WssUser SamAccountName [AD username]`

## Remove old logon scripts
Windows SBS 2003 uses logon scripts for tasks such as installing software and customizing desktops. Windows Server Essentials replaces the Windows SBS 2003 logon scripts with a combination of logon scripts and Group Policy Objects.

> [!NOTE]
> If you modified the Windows SBS 2003 logon scripts, you should rename the scripts to preserve your customizations.
>
> Windows SBS 2003 logon scripts apply only to user accounts that were added by using the **Add New Users Wizard**.

#### To remove the Windows SBS 2003 logon scripts 

1. Click **Start**, point to **Administrative Tools**, and then click **Active Directory Users and Computers**.

2. In **Active Directory Users and Computers**, Expand your network, and then click **Users**.

3. Right-click a user name, click **Properties**, and then click the **Profile** tab.

4. Delete the contents of the **Logon script** text box, and then click **OK**.

5. Repeat steps 3 and 4 for each user.

## Remove legacy Active Directory Group Policy Objects
The Group Policy Objects (GPOs) are updated for Windows Server Essentials. They are a superset of the Windows SBS 2003 GPOs. For Windows Server Essentials, a number of the Windows SBS 2003 GPOs and Windows Management Instrumentation (WMI) filters must be manually deleted to prevent conflicts with the Windows Server Essentials GPOs and WMI filters. 

> [!NOTE]
> If you modified the original Windows SBS 2003 Group Policy Objects, you should save copies of them in a different location, and then delete them from Windows SBS 2003.

#### To remove old Group Policy Objects from Windows SBS 2003 

1. Log on to the Source Server with an administrator account. 

2. Click **Start**, and then click **Server Management**. 

3. In the navigation pane, click **Advanced Management**, click **Group Policy Management**, and then click **Forest:**_<YourDomainName\>_. 

4. Click **Domains**, click *<YourDomainName\>*, and then click **Group Policy Objects**. 

5. Right-click **Small Business Server Auditing Policy**, click **Delete**, and then click **OK**. 

6. Repeat step 5 to delete the following GPOs that apply to your network: 

 - Small Business Server Client Computer 

 - Small Business Server Domain Password Policy 

We recommend you configure the password policy in Windows Server Essentials to enforce strong passwords. To configure the password policy, use the Dashboard, which writes the configuration to the default domain policy. The password policy configuration is not written to the Small Business Server Domain Password Policy Object, like it was in Windows SBS 2003. 

 - Small Business Server Internet Connection Firewall 

 - Small Business Server Lockout Policy 

 - Small Business Server Remote Assistance Policy 

 - Small Business Server Windows Firewall 

 - Small Business Server Update Services Client Computer Policy 

 This GPO will be present if you are migrating from Windows SBS 2003 R2. 

 - Small Business Server Update Services Common Settings Policy 

 This GPO will be present if you are migrating from Windows SBS 2003 R2. 
 
 - Small Business Server Update Services Server Computer Policy 
 
 This GPO will be present if you are migrating from Windows SBS 2003 R2.

7. Confirm that all of the GPOs are deleted.

#### To remove WMI filters from Windows SBS 2003

1. Log on to the Source Server with an administrator account.

2. Click **Start**, and then click **Server Management**.

3. In the navigation pane, click **Advanced Management**, click **Group Policy Management**, and then click **Forest:**_<YourNetworkDomainName\>_

4. Click **Domains**, click *<YourNetworkDomainName\>*, and then click **WMI Filters**.

5. Right-click **PostSP2**, click **Delete**, and then click **Yes**.

6. Right-click **PreSP2**, click **Delete**, and then click **Yes**.

7. Confirm that these three WMI filters are deleted.

## Configure the network

#### To configure the network 

1. On the Destination Server, open the Dashboard. 

2. On the Dashboard **Home** page, click **SETUP**, click **Set up Anywhere Access**, and then choose the **Click to configure Anywhere Access** option. 

3. Follow the instructions in the **Set up Anywhere Access** wizard to configure your router and domain name.

 If your router does not support the UPnP framework, or if the UPnP framework is disabled, a yellow warning icon may appear next to the router name. Ensure that the following ports are open and that they are directed to the IP address of the Destination Server:

- Port 80: HTTP Web traffic

- Port 443: HTTPS Web traffic

> [!NOTE]
> If you have set up an on-premises Exchange server on a second server, you must ensure port 25 (for SMTP) is also open and that it is redirected to the IP address of the on-premises Exchange server.

## Map permitted computers to user accounts
 In Windows SBS 2003, if a user connects to Remote Web Access, all the computers in the network are displayed. This may include computers that the user does not have permission to access. In Windows Server Essentials, a user must be explicitly assigned to a computer for it to be displayed in Remote Web Access. Each user account that is migrated from Windows SBS 2003 must be mapped to one or more computers. 

#### To map user accounts to computers 

1. On the Destination Server, open the Windows Server Essentials Dashboard. 

2. In the navigation bar, click **Users**. 

3. In the list of user accounts, right-click a user account, and then click **View the account properties**. 

4. Click the **Anywhere Access** tab, and then click **Allow Remote Web Access and access to web services applications.**. 

5. Click **Shared Folders**, click **Computers**, click **Homepage links**, and then click **Apply**. 

6. Click the **Computer access** tab, and click the name of the computer to which you want to allow access. 

7. Repeat steps 3, 4, 5, and 6 for each user account. 

> [!NOTE]
> You do not need to change the configuration of the client computer. It is configured automatically.
>
> After you complete the migration, if you encounter an issue when you create the first new user account on the Destination Server, remove the user account that you added, and then create it again.
