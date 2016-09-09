---
title: "Step 2: Install Windows Server 2012 R2 Essentials as a new replica domain controller"
ms.custom: na
ms.date: 08/20/2013
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: c7ccfc34-63fd-436b-a1cd-e05810f60bfe
caps.latest.revision: 14
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
# Step 2: Install Windows Server 2012 R2 Essentials as a new replica domain controller
This section describes how to install --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 R2 Essentials and --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 R2 Standard (with the Windows Server Essentials Experience role enabled) as a domain controller.  
  
 For environments with up to 25 users and 50 devices, you can follow the steps in this guide to migrate from previous versions of Windows SBS to --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 R2 Essentials. For environments with up to 100 users and 200 devices, you can follow the same guidance to migrate to the Standard and Datacenter editions of --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 R2 with the --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server Essentials Experience role installed. Both scenarios are covered in this documentation.  
  
> [!WARNING]
>  If you migrate to --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 R2 Essentials, the following error message is added to the event log each day during the 21-day grace period until you remove the Source Server from your network: **The FSMO Role Check detected a condition in your environment that is out of compliance with the licensing policy. The Management Server must hold the primary domain controller and domain naming master Active Directory roles. Please move the Active Directory roles to the Management Server now. This server will be automatically shut down if the issue is not corrected in 21 days from the time this condition was first detected**. After the 21-day grace period, the Source Server will shut down.  
  
#### Install Windows Server 2012 R2 Essentials or Windows Server 2012 R2 Standard on the Destination Server  
  
1.  Install --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 R2 Essentials or --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 R2 Standard with the Windows Server Essentials Experience role enabled by following the instructions in [Install and Configure Windows Server 2012 R2 Essentials](../install/Install-and-Configure-Windows-Server-2012-R2-Essentials-or-Windows-Server-Essentials-Experience.md).  
  
    > [!NOTE]
    >  If the Configure Windows Server Essentials Wizard launches, cancel it.  
  
2.  To install Windows Server Essentials as a replica --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 R2 domain controller in an existing domain as global catalog, follow instructions in [Install a Replica Windows Server 2012 Domain Controller in an Existing Domain (Level 200)](assetId:///58d7ad85-007c-4b72-a07f-b7a13dcc4d07).  
  
3.  Transfer the FSMO roles from your Source Server.  
  
    > [!NOTE]
    >  If --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 R2 Essentials is the only domain controller in the domain, the FSMO role is automatically moved to the server running --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 R2 Essentials when you demote the Source Server.  
  
4.  Open Server Manager and run the Add Roles and Features wizard.  
  
5.  If not installed, add the Windows Server Essentials Experience role.  
  
6.  After you install the Windows Server Essentials Experience role, the Configure Windows Server Essentials task appears in the notification area. Click the task to launch   the Configure Windows Server Essentials wizard.  
  
7.  Follow the instructions to complete the configuration of Windows Server Essentials. Before you run the wizard, do the following:  
  
    -   Change the server name if needed, because you cannot change the name after you have completed the Configure Windows Server Essentials Wizard.  
  
    -   Ensure that the server’s time and settings are correct.  
  
8.  Verify the installation as follows:  
  
    1.  Open the Dashboard.  
  
    2.  Click to **Users** tab, and verify that the user accounts in your Active Directory are listed.  
  
### Transfer the operations master roles  
 The operations master (also called flexible single master operations or FSMO) roles must be transferred from the Source Server to the Destination Server within 21 days of installing --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 R2 Essentials on the Destination Server.  
  
##### To transfer the operations master roles  
  
1.  On the Destination Server, open a Command Prompt window as an administrator. See [To open a Command Prompt window as an Administrator](http://technet.microsoft.com/library/cc947813\(v=WS.10\).aspx).  
  
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
>  From any server on the network, you can verify that the operations master roles have been transferred to the Destination Server. Open a Command Prompt window as an administrator (for more information, see [To open a Command Prompt window as an Administrator](http://technet.microsoft.com/library/cc947813\(v=WS.10\).aspx)). Type **netdom query fsmo**, and then press ENTER.  
  
## Next steps  
 You have installed --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 R2 Essentials as a new replica domain controller. Now go to [Step 3: Join computers to the new Windows Server 2012 R2 Essentials server](../Topic/Step%203:%20Join%20computers%20to%20the%20new%20Windows%20Server%202012%20R2%20Essentials%20server.md).  
  
<<<<<<< HEAD
 To view all the steps, see [Migrate to Windows Server 2012 R2 Essentials](Migrate-from-Previous-Versions-to-Windows-Server-2012-R2-Essentials-or-Windows-Server-Essentials-Experience.md).
=======
 To view all the steps, see [Migrate to Windows Server 2012 R2 Essentials](../migrate/Migrate-from-Previous-Versions-to-Windows-Server-2012-R2-Essentials-or-Windows-Server-Essentials-Experience.md).
>>>>>>> 4bac1739fd0378146de6c9af26f683b8076754b8
