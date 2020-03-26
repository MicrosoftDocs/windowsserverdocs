---
title: "Move Windows SBS 2011 Essentials settings and data to the Destination Server for Windows Server Essentials migration"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 47548994-9fa0-42e0-afa4-c2ccbd063acb
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Move Windows SBS 2011 Essentials settings and data to the Destination Server for Windows Server Essentials migration

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

Move settings and data to the Destination Server as follows:  
  

1.  [Copy data to the Destination Server](Move-Windows-SBS-2011-Essentials-to-the-Destination-Server-for-migration.md#BKMK_CopyData)  
  
2.  [Import Active Directory user accounts to the Windows Server Essentials Dashboard (optional)](Move-Windows-SBS-2011-Essentials-to-the-Destination-Server-for-migration.md#BKMK_ImportADaccounts)  
  
3.  [Configure the network](Move-Windows-SBS-2011-Essentials-to-the-Destination-Server-for-migration.md#BKMK_Network)  
  
4.  [Map permitted computers to user accounts](Move-Windows-SBS-2011-Essentials-to-the-Destination-Server-for-migration.md#BKMK_MapPermittedComputers)  
 
##  <a name="BKMK_CopyData"></a> Copy data to the Destination Server  
 Before you copy data from the Source Server to the Destination Server, perform the following tasks:  
  
-   Review the list of shared folders on the Source Server, including permissions for each folder. Create or customize the folders on the Destination Server to match the folder structure that you are migrating from the Source Server.  
  
-   Review the size of each folder and ensure that the Destination Server has enough storage space.  
  
-   Make the shared folders on the Source Server Read-only for all users so no writing can take place on the drive while you are copying files to the Destination Server.  
  
#### To copy data from the Source Server to the Destination Server  
  
1.  Sign in to the Destination Server as a domain administrator, and then open a command window.  
  
2.  At the command prompt, type the following command, and then press ENTER:  
  
    `robocopy \\<SourceServerName> \<SharedSourceFolderName> \\<DestinationServerName> \<SharedDestinationFolderName> /E /B /COPY:DATSOU /LOG:C:\Copyresults.txt`  
  
     Where:
     - \<SourceServerName\> is the name of the Source Server
     - \<SharedSourceFolderName\> is the name of the shared folder on the Source Server
     - \<DestinationServerName\> is the name of the Destination Server,
     - \<SharedDestinationFolderName\> is the shared folder on the Destination Server to which the data will be copied.  
        
3.  Repeat the previous step for each shared folder that you are migrating from the Source Server.  
  
##  <a name="BKMK_ImportADaccounts"></a> Import Active Directory user accounts to the Windows Server Essentials Dashboard (optional)  
 By default, all user accounts created on the Source Server are automatically migrated to the Dashboard in Windows Server Essentials. However, automatic migration of an Active Directory user account will fail if all properties do not meet migration requirements. You can use the following Windows PowerShell cmdlet to import Active Directory users.  
  
#### To import an Active Directory user account to the Windows Server Essentials Dashboard  
  
1.  Log on to the Destination Server as a domain administrator.  
  
2.  Open Windows PowerShell as an administrator.  
  
3.  Run the following cmdlet, where `[AD username]` is the name of the Active Directory user account that you want to import:  
  
     `Import-WssUser  SamAccountName [AD username]`  
  
##  <a name="BKMK_Network"></a> Configure the network  
  
#### To configure the network  
  
1. On the Destination Server, open the Dashboard.  
  
2. On the Dashboard **Home** page, click **SETUP**, click **Set up Anywhere Access**, and then choose the **Click to configure Anywhere Access** option.  
  
3. Complete the instructions in the wizard to configure your router and domain names.  
  
   If your router does not support the UPnP framework, or if the UPnP framework is disabled, a yellow warning icon may appear next to the router name. Ensure that the following ports are open and that they are directed to the IP address of the Destination Server:  
  
-   Port 80: HTTP Web traffic  
  
-   Port 443: HTTPS Web traffic  
  
##  <a name="BKMK_MapPermittedComputers"></a> Map permitted computers to user accounts  
 Each user account that is migrated from Windows Small Business Server 2011 Essentials must be mapped to one or more computers.  
  
#### To map user accounts to computers  
  
1.  Open the  Windows Server Essentials Dashboard.  
  
2.  In the navigation bar, click **Users**.  
  
3.  In the list of user accounts, right-click a user account, and then click **View the account properties**.  
  
4.  Click the **Anywhere Access** tab, and then click **Allow Remote Web Access and access to web services applications**.  
  
5.  Select **Shared Folders**, select **Computers**, select **Homepage links**, and then click **Apply**.  
  
6.  Click the **Computer access** tab, and then click the name of the computer to which you want to allow access.  
  
7.  Repeat steps 3, 4, 5, and 6 for each user account.  
  
> [!NOTE]
>  You do not need to change the configuration of the client computer. It is configured automatically.  
  
> [!NOTE]
>  After you complete the migration, if you encounter an issue when you create the first new user account on the Destination Server, remove the user account that you added, and then create it again.
