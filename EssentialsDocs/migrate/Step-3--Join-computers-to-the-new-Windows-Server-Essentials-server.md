---
title: "Step 3: Join computers to the new Windows Server Essentials server"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a0e07d1a-8409-429b-87d7-0f4a7e14d668
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Step 3: Join computers to the new Windows Server Essentials server

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

The next step in the migration process is to connect client computers to the new server running  Windows Server Essentials.  
  
> [!NOTE]
>  You can skip this step for computers that are running the Windows XP or Windows Vista operating systems. The Windows Server Connector software does not support computers that are running Windows XP or Windows Vista.  
  
 Before you can join a client computer to the new  Windows Server Essentials server, you must disconnect it from the Source Server by uninstalling the Windows Server Connector software on the client computer.  
  
### To uninstall Windows Server Connector on a client computer  
  
1.  From a client computer, open Control Panel, and then open **Programs and Features**.  
  
2.  In the list of programs, right-click the Connector application that is running on your computer.  
  
    > [!NOTE]
    >  The Connector application can be **Windows Small Business Server 2011 Essentials Connector**, or **Windows Server Essentials Connector**, depending on which version of Windows Server Essentials the client computer was connected to.  
  
3.  Click **Uninstall**.  
  
### To reconnect a client computer to the server  
  
1.  Sign in to the computer that you want to connect to the server.  
  
    > [!NOTE]
    >  If this computer has multiple user accounts, sign in by using the user account that has documents, pictures, and personal preferences you want to keep after you connect the computer to the server.  
  
2.  Open an Internet browser, such as Internet Explorer.  
  
3.  In the address bar, type **http://<servername\>/Connect**, and then press ENTER.  
  
4.  Follow the onscreen instructions to join the client computer to the new  Windows Server Essentials server.  
  
## Next steps  
 You have joined your client computers to the new server running  Windows Server Essentials. Now go to [Step 4: Move settings and data to the Destination Server for Windows Server Essentials migration](Step-4--Move-settings-and-data-to-the-Destination-Server-for-Windows-Server-Essentials-migration.md).  
  

To view all the steps, see [Migrate to Windows Server Essentials](Migrate-from-Previous-Versions-to-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md).

