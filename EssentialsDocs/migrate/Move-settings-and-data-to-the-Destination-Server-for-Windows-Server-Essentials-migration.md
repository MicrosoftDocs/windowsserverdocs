---
title: "Move settings and data to the Destination Server for Windows Server Essentials migration"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2b882e87-347a-4010-b7fd-9599d61198dd
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Move settings and data to the Destination Server for Windows Server Essentials migration

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

Move settings and data to the Destination Server as follows:

1. [Copy data to the Destination Server](#copy-data-to-the-destination-server)

2. [Configure the network](#configure-the-network) 

3. [Map permitted computers to user accounts](#map-permitted-computers-to-user-accounts)
 
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
 
## Configure the network
 After you move the DHCP role to the router, configure the network settings on the Destination Server. 
 
#### To configure the network 
 
1. On the Destination Server, open the Dashboard. 
 
2. On the Dashboard **Home** page, click **SETUP**, click **Set up Anywhere Access**, and then choose the **Click to configure Anywhere Access** option. 
 
3. Complete the instructions in the wizard to configure your router and domain names. 
 
 If your router does not support the UPnP framework, or if the UPnP framework is disabled, a yellow warning icon may appear next to the router name. Ensure that the following ports are open and that they are directed to the IP address of the Destination Server: 
 
- Port 80: HTTP Web traffic 
 
- Port 443: HTTPS Web traffic 
 
## Map permitted computers to user accounts
 Each user account that is migrated from the Source Server must be mapped to one or more computers. 
 
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
