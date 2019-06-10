---
title: "Move Windows SBS 2008 settings and data to the Destination Server for Windows Server Essentials migration"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4950469d-d800-430d-8d10-53bafc4a9932
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Move Windows SBS 2008 settings and data to the Destination Server for Windows Server Essentials migration

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

Move settings and data to the Destination Server as follows:

1. [Copy data to the Destination Server](#copy-data-to-the-destination-server)

2. [Import Active Directory user accounts to the Windows Server Essentials Dashboard (optional)](#import-active-directory-user-accounts-to-the-windows-server-essentials-dashboard)

3. [Move the DHCP Server role from the Source Server to the router](#move-the-dhcp-server-role-from-the-source-server-to-the-router)

4. [Configure the network](#configure-the-network)

5. [Remove legacy Active Directory Group Policy objects (optional)](#remove-legacy-active-directory-group-policy-objects)

6. [Map permitted computers to user accounts](#map-permitted-computers-to-user-accounts)

## Copy data to the Destination Server
Before you copy data from the Source Server to the Destination Server, perform the following tasks:

- Review the list of shared folders on the Source Server, including permissions for each folder. Create or customize the folders on the Destination Server to match the folder structure that you are migrating from the Source Server. 

- Review the size of each folder and ensure that the Destination Server has enough storage space. 

- Make the shared folders on the Source Server Read-only for all users so no writing can take place on the drive while you are copying files to the Destination Server.

#### To copy data from the Source Server to the Destination Server

1. Log on to the Destination Server as a domain administrator, and then open a command window. 

2. At the command prompt, type the following command, and then press ENTER: 

    `robocopy \\<SourceServerName> \<SharedSourceFolderName> \\<DestinationServerName> \<SharedDestinationFolderName> /E /B /COPY:DATSOU /LOG:C:\Copyresults.txt` 

 Where:
 - \<SourceServerName\> is the name of the Source Server
 - \<SharedSourceFolderName\> is the name of the shared folder on the Source Server
 - \<DestinationServerName\> is the name of the Destination Server,
 - \<SharedDestinationFolderName\> is the shared folder on the Destination Server to which the data will be copied. 

3. Repeat the previous step for each shared folder that you are migrating from the Source Server. 

## Import Active Directory user accounts to the Windows Server Essentials Dashboard
 By default, all user accounts created on the Source Server are automatically migrated to the Dashboard in Windows Server Essentials. However, automatic migration of an Active Directory user account will fail if some properties do not meet migration requirements. You can use the following Windows PowerShell cmdlet to import Active Directory users. 

#### To import an Active Directory user account to the Windows Server Essentials Dashboard 
 
1. Log on to the Destination Server as a domain administrator. 
 
2. Open Windows PowerShell as an administrator. 
 
3. Run the following cmdlet, where `[AD username]` is the name of the Active Directory user account that you want to import: 
 
 `Import-WssUser SamAccountName [AD username]` 
 
## Move the DHCP Server role from the Source Server to the router
 If your Source Server is running the DHCP role, perform the following steps to move the DHCP role to the router. 
 
#### To move the DHCP role from the Source Server to the router 
 
1. Turn off the DHCP service on the Source Server, as follows: 

    1. On the Source Server, Click **Start**, click **Administrative Tools**, and then click **Services**. 

    2. In the list of currently running services, right-click **DHCP Server**, and then click **Properties**. 

    3. For **Start type**, select **Disabled**.

    4. Stop the service.

2. Turn on the DHCP Role on your router.

    1. Follow the instructions in your router documentation to turn on the DHCP role on the router. 

    2. To ensure that IP addresses issued by the Source Server remain the same, follow the instructions in your router documentation to configure the DHCP range on the router to be the same as the DHCP range on the Source Server. 

 > [!IMPORTANT]
 > If you have not set up a static IP or DHCP reservations on the router for the Destination Server, and the DHCP range is not the same as the Source Server, it is possible that the router will issue a new IP address for Destination Server. If this happens, reset the port forwarding rules of the router to forward to the new IP address of the Destination Server. 

## Configure the network
 After you move the DHCP role to the router, configure the network settings on the Destination Server. 
 
#### To configure the network
 
1. On the Destination Server, open the Dashboard.
 
2. On the Dashboard **Home** page, click **SETUP**, click **Set up Anywhere Access**, and then choose the **Click to configure Anywhere Access** option. 
 
3. Complete the instructions in the wizard to configure your router and domain names. 
 
 If your router does not support the UPnP framework, or if the UPnP framework is disabled, a yellow warning icon may appear next to the router name. Ensure that the following ports are open and that they are directed to the IP address of the Destination Server: 
 
- Port 80: HTTP Web traffic 
 
- Port 443: HTTPS Web traffic 
 
> [!NOTE]
> If you have set up an on-premises Exchange server on a second server, you must ensure port 25 (for SMTP) is also open and that it is redirected to the IP address of the on-premises Exchange server.
 
## Remove legacy Active Directory Group Policy objects
The Group Policy objects (GPOs) are updated for Windows Server Essentials. They are a superset of the Windows SBS 2008 GPOs. For Windows Server Essentials, a number of the Windows SBS 2008 GPOs and Windows Management Instrumentation (WMI) filters must be manually deleted to prevent conflicts with the Windows Server Essentials GPOs and WMI filters. 
 
> [!NOTE]
> If you modified the original Windows SBS 2008 Group Policy objects, you should save copies of them in a different location, and then delete them from Windows SBS 2008. 
 
#### To remove old Group Policy objects from Windows SBS 2008 
 
1. Log on to the Source Server with an administrator account. 
 
2. Click **Start**, and then click **Server Management**. 
 
3. In the navigation pane, click **Advanced Management**, click **Group Policy Management**, and then click **Forest:***<YourDomainName\>*. 
 
4. Click **Domains**, click *<YourDomainName\>*, and then click **Group Policy Objects**. 
 
5. Right-click **Small Business Server Auditing Policy**, click **Delete**, and then click **OK**. 
 
6. Repeat step 5 to delete the following GPOs that apply to your network: 
 
 - Small Business Server Client Computer 
 
 - Small Business Server Domain Password Policy 
 
We recommend you configure the password policy in Windows Server Essentials to enforce strong passwords. To configure the password policy, use the Dashboard, which writes the configuration to the default domain policy. The password policy configuration is not written to the Small Business Server Domain Password Policy object, as it was in Windows SBS 2008. 
 
 - Small Business Server Internet Connection Firewall 
 
 - Small Business Server Lockout Policy 
 
 - Small Business Server Remote Assistance Policy 
 
 - Small Business Server Windows Firewall 
 
 - Small Business Server Update Services Client Computer Policy 
 
 This GPO will be present if you are migrating from Windows SBS 2008 R2. 
 
 - Small Business Server Update Services Common Settings Policy 
 
 This GPO will be present if you are migrating from Windows SBS 2008 R2. 
 
 - Small Business Server Update Services Server Computer Policy 
 
 This GPO will be present if you are migrating from Windows SBS 2008 R2. 
 
7. Confirm that all of the GPOs are deleted. 
 
#### To remove WMI filters from Windows SBS 2008
 
1. Log on to the Source Server with an administrator account. 
 
2. Click **Start**, and then click **Server Management**. 
 
3. In the navigation pane, click **Advanced Management**, click **Group Policy Management**, and then click **Forest:***<YourNetworkDomainName\>* 
 
4. Click **Domains**, click *<YourNetworkDomainName\>*, and then click **WMI Filters**. 
 
5. Right-click **PostSP2**, click **Delete**, and then click **Yes**. 
 
6. Right-click **PreSP2**, click **Delete**, and then click **Yes**. 
 
7. Confirm that these three WMI filters are deleted. 
 
## Map permitted computers to user accounts
In Windows SBS 2008, if a user connects to Remote Web Access, all the computers in the network are displayed. This may include computers that the user does not have permission to access. In Windows Server Essentials, a user must be explicitly assigned to a computer for it to be displayed in Remote Web Access. Each user account that is migrated from Windows SBS 2008 must be mapped to one or more computers. 
 
#### To map user accounts to computers 
 
1. Open the Windows Server Essentials Dashboard.
 
2. In the navigation bar, click **Users**.
 
3. In the list of user accounts, right-click a user account, and then click **View the account properties**.
 
4. Click the **Anywhere Access** tab, and then click **Allow Remote Web Access and access to web services applications.**.
 
5. Select **Shared Folders**, select **Computers**, select **Homepage links**, and then click **Apply**.
 
6. Click the **Computer access** tab, and then click the name of the computer to which you want to allow access.
 
7. Repeat steps 3, 4, 5, and 6 for each user account. 

> [!NOTE]
> You do not need to change the configuration of the client computer. It is configured automatically. 
>
> After you complete the migration, if you encounter an issue when you create the first new user account on the Destination Server, remove the user account that you added, and then create it again.
