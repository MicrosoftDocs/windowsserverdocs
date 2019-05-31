---
title: "Step 4: Move settings and data to the Destination Server for Windows Server Essentials migration"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e143df43-e227-4629-a4ab-9f70d9bf6e84
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Step 4: Move settings and data to the Destination Server for Windows Server Essentials migration

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

This section provides information about migrating data and settings from the Source Server. Move settings and data to the Destination Server as follows:  
  
-   [Copy data to the Destination Server](Step-4--Move-settings-and-data-to-the-Destination-Server-for-Windows-Server-Essentials-migration.md#BKMK_CopyData)  
  
-   [Configure the network](Step-4--Move-settings-and-data-to-the-Destination-Server-for-Windows-Server-Essentials-migration.md#BKMK_Network)  
  
-   [Map permitted computers to user accounts](Step-4--Move-settings-and-data-to-the-Destination-Server-for-Windows-Server-Essentials-migration.md#BKMK_MapPermittedComputers)  
  
##  <a name="BKMK_CopyData"></a> Copy data to the Destination Server  
 Before you copy data from the Source Server to the Destination Server, perform the following tasks:  
  
-   Review the list of shared folders on the Source Server, including permissions for each folder. Create or customize the folders on the Destination Server to match the folder structure that you are migrating from the Source Server.  
  
-   Review the size of each folder and ensure that the Destination Server has enough storage space.  
  
-   Make the shared folders on the Source Server Read-only for all users so that no writing can take place on the hard drive while you are copying files to the Destination Server.  
  
-   The **Client Computer Backup** folder cannot be migrated to the Destination Server. Before the server migration, make sure that all the client computers are healthy. After the server migration, it is recommended that you configure and start client computer backups to ensure that the data is backed up for all your important client computers.  
  
-   The **File History Backups** folder cannot be directly migrated to the Destination Server due to the folder structure and backup metadata changes in  Windows Server Essentials. However, it is possible to migrate the **File History Backups** folder for a specific user on a specific computer. To do so, you should locate the **Data** folder in the **File History Backups** folder for that user and computer, then copy that **Data** folder to the **File History Backups** folder on the Destination Server.  
  
#### To copy data from the Source Server to the Destination Server  
  
1. Sign in to the Destination Server as a domain administrator, and then open a Command Prompt window or a Windows PowerShell command prompt.  
  
2. If you use the Command Prompt window, type the following command, and then press ENTER:  
  
   `robocopy \\<SourceServerName>\<SharedSourceFolderName> "<PathOfTheDestination>\<SharedDestinationFolderName>" /E /B /COPY:DATSOU /LOG:C:\Copyresults.txt`
  
    Where:  
  
   - \<SourceServerName\> is the name of the Source Server  
  
   - \<SharedSourceFolderName\> is the name of the shared folder on the Source Server  
  
   - \<PathOfTheDestination\> is the absolute path where you want to move the folder  
  
   - \<SharedDestinationFolderName\> is the folder on the Destination Server to which the data will be copied  
  
     For example,  `robocopy \\sourceserver\MyData "d:\ServerFolders\MyData" /E /B /COPY:DATSOU /LOG:C:\Copyresults.txt`.  
  
3. If you use Windows PowerShell, type the following command, and then press ENTER.  
  
    `Add-Wssfolder  Path \ -Name  -KeepPermission`  
  
4. Repeat this process for each shared folder that you are migrating from the Source Server.  
  
##  <a name="BKMK_Network"></a> Configure the network  
  
#### To configure the network  
  
1. On the Destination Server, open the Dashboard.  
  
2. On the Dashboard **Home** page, click **Setup**, click **Set up Anywhere Access**, and then choose the **Click to configure Anywhere Access** option.  
  
3. The Set up Anywhere Access Wizard appears. Complete the instructions in the wizard to configure your router and domain names.  
  
   If your router does not support the UPnP framework, or if the UPnP framework is disabled, a yellow warning icon may appear next to the router name. Ensure that the following ports are open and that they are directed to the IP address of the Destination Server:  
  
-   Port 80: HTTP Web traffic  
  
-   Port 443: HTTPS Web traffic  
  
> [!NOTE]
>  If you want to configure a public domain name on the Destination Server, you must release the domain name from your Source Server to avoid competition of dynamic DNS update.  
  
##  <a name="BKMK_MapPermittedComputers"></a> Map permitted computers to user accounts  
 Each user account that is migrated from previous versions of Windows Small Business Server or Windows Server Essentials must be mapped to one or more computers.  
  
#### To map user accounts to computers  
  
1.  Open the  Windows Server Essentials Dashboard.  
  
2.  In the navigation bar, click **Users**.  
  
3.  In the list of user accounts, right-click a user account, and then click **View the account properties**.  
  
4.  Click the **Anywhere Access** tab, and then click **Allow Remote Web Access and access to web services applications**.  
  
5.  Click **Shared Folders**, click**Computers**, click **Homepage links**, and then click **Apply**.  
  
6.  Click the **Computer access** tab, and then click the name of the computer to which you want to allow access.  
  
7.  Repeat steps 3, 4, 5, and 6 for each user account.  
  
> [!NOTE]
>  You do not need to change the configuration of the client computer. It is configured automatically.  
  
> [!NOTE]
>  After you complete the migration, if you encounter an issue when you create the first new user account on the Destination Server, remove the user account that you added, and then create it again.  
  
## Next steps  
 You have moved your settings and data to the Destination Server. Now go to [Step 5: Enable folder redirection on the Destination Server for Windows Server Essentials migration](Step-5--Enable-folder-redirection-on-the-Destination-Server-for-Windows-Server-Essentials-migration.md).  
  

To view all the steps, see [Migrate to Windows Server Essentials](Migrate-from-Previous-Versions-to-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md).

