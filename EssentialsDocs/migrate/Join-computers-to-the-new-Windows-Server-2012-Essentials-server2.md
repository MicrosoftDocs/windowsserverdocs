---
title: "Join computers to the new Windows Server 2012 Essentials server2"
ms.custom: na
ms.date: 11/20/2012
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
H1: Join computers to the new Windows Server 2012 Essentials server
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: 7f8a0435-41ba-42f0-9d8a-3ea31cfda519
caps.latest.revision: 4
author: DonGill
manager: stevenka

---
# Join computers to the new Windows Server 2012 Essentials server2
The next step in the migration process is to connect client computers to the new  Windows Server 2012 Essentials server.  
  
> [!NOTE]
>  You can skip this step for computers that are running the Windows XP or Windows Vista operating systems. The Windows Server Connector software does not support computers that are running Windows XP or Windows Vista.  
  
 Before you can join a client computer to the new  Windows Server 2012 Essentials server, you must first disconnect it from the Source Server by uninstalling the Windows Server Connector software on the client computer.  
  
### To uninstall the Windows Server Connector on a client computer  
  
1.  From a client computer, open Control Panel, and then open **Programs and Features**.  
  
2.  In the list of programs, right-click **Windows Small Business Server 2011 Essentials Connector**, and then click **Uninstall**.  
  
### To reconnect a client computer to the server  
  
1.  Sign on to the computer that you want to connect to the server.  
  
    > [!NOTE]
    >  If this computer has multiple user accounts, then sign on by using the user account that has documents, pictures, and personal preferences you want to keep after you connect the computer to the server.  
  
2.  Open an Internet browser, such as Internet Explorer.  
  
3.  In the address bar, type **http://<servername\>/Connect**, and then press ENTER.  
  
4.  Follow the onscreen instructions to join the client computer to the new  Windows Server 2012 Essentials server.
