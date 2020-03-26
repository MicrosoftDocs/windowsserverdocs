---
title: "Step 2: Install Windows Server Essentials as a new replica domain controller"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c7ccfc34-63fd-436b-a1cd-e05810f60bfe
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Step 2: Install Windows Server Essentials as a new replica domain controller

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

This section describes how to install  Windows Server Essentials and  Windows Server 2012 R2 Standard (with the Windows Server Essentials Experience role enabled) as a domain controller.  
  
 For environments with up to 25 users and 50 devices, you can follow the steps in this guide to migrate from previous versions of Windows SBS to  Windows Server Essentials. For environments with up to 100 users and 200 devices, you can follow the same guidance to migrate to the Standard and Datacenter editions of  Windows Server 2012 R2 with the  Windows Server Essentials Experience role installed. Both scenarios are covered in this documentation.  
  
> [!IMPORTANT]
>  If you migrate to  Windows Server Essentials, the following error message is added to the event log each day during the 21-day grace period until you remove the Source Server from your network. After the 21-day grace period, the Source Server will shut down. <br> **The FSMO Role Check detected a condition in your environment that is out of compliance with the licensing policy. The Management Server must hold the primary domain controller and domain naming master Active Directory roles. Please move the Active Directory roles to the Management Server now. This server will be automatically shut down if the issue is not corrected in 21 days from the time this condition was first detected**.   
  
#### Install Windows Server Essentials or Windows Server 2012 R2 Standard on the Destination Server  
  
1.  Install  Windows Server Essentials or  Windows Server 2012 R2 Standard with the Windows Server Essentials Experience role enabled by following the instructions in [Install and Configure Windows Server Essentials](../install/Install-and-Configure-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md).  
  
    > [!NOTE]
    >  If the Configure Windows Server Essentials Wizard launches, cancel it.  
  
2.  Transfer the FSMO roles from your Source Server.  
  
    > [!NOTE]
    >  If  Windows Server Essentials is the only domain controller in the domain, the FSMO role is automatically moved to the server running  Windows Server Essentials when you demote the Source Server.  
  
3.  Open Server Manager and run the Add Roles and Features wizard.  
  
4.  If not installed, add the Windows Server Essentials Experience role.  
  
5.  After you install the Windows Server Essentials Experience role, the Configure Windows Server Essentials task appears in the notification area. Click the task to launch   the Configure Windows Server Essentials wizard.  
  
6.  Follow the instructions to complete the configuration of Windows Server Essentials. Before you run the wizard, do the following:  
  
    -   Change the server name if needed, because you cannot change the name after you have completed the Configure Windows Server Essentials Wizard.  
  
    -   Ensure that the server's time and settings are correct.  
  
7.  Verify the installation as follows:  
  
    1.  Open the Dashboard.  
  
    2.  Click to **Users** tab, and verify that the user accounts in your Active Directory are listed.  
  
### Transfer the operations master roles  
 The operations master (also called flexible single master operations or FSMO) roles must be transferred from the Source Server to the Destination Server within 21 days of installing  Windows Server Essentials on the Destination Server.  
  
##### To transfer the operations master roles  
  
1.  On the Destination Server, open a Command Prompt window as an administrator. See [To open a Command Prompt window as an Administrator](https://technet.microsoft.com/library/cc947813\(v=WS.10\).aspx).  
  
2.  At the command prompt, type **NETDOM QUERY FSMO**, and then press ENTER.  
  
3.  At the command prompt, type **ntdsutil**, and then press ENTER.  
  
4.  At the **ntdsutil** command prompt, enter the following commands:  
  
    1.  Type **activate instance NTDS**, and then press ENTER.  
  
    2.  Type **roles**, and then press ENTER.  
  
    3.  Type **connections**, and then press ENTER.  
  
    4.  Type **connect to server** *<ServerName\>* (where *<ServerName\>* is the name of the Destination Server), and then press ENTER.  
  
    5.  At the command prompt, type **q**, and then press ENTER.  
  
        1.  Type **transfer PDC**, press ENTER, and then click **Yes** in the **Role Transfer Confirmation** dialog box.  
  
        2.  Type **transfer infrastructure master**, press ENTER, and then click **Yes** in the **Role Transfer Confirmation** dialog box.  
  
        3.  Type **transfer naming master**, press ENTER, and then click **Yes** in the **Role Transfer Confirmation** dialog box.  
  
        4.  Type **transfer RID master**, press ENTER, and then click **Yes** in the **Role Transfer Confirmation** dialog box.  
  
        5.  Type **transfer schema master**, press ENTER, and then click **Yes** in the **Role Transfer Confirmation** dialog box.  
  
    6.  Type **q**, and then press ENTER until you return to the command prompt.  
  
> [!NOTE]
>  From any server on the network, you can verify that the operations master roles have been transferred to the Destination Server. Open a Command Prompt window as an administrator (for more information, see [To open a Command Prompt window as an Administrator](https://technet.microsoft.com/library/cc947813\(v=WS.10\).aspx)). Type **netdom query fsmo**, and then press ENTER.  
  
## Next steps  
 You have installed  Windows Server Essentials as a new replica domain controller. Now go to [Step 3: Join computers to the new Windows Server Essentials server](Step-3--Join-computers-to-the-new-Windows-Server-Essentials-server.md).  
  
To view all the steps, see [Migrate to Windows Server Essentials](Migrate-from-Previous-Versions-to-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md).

