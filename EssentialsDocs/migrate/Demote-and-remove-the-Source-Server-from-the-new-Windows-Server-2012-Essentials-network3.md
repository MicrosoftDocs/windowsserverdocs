---
title: "Demote and remove the Source Server from the new Windows Server 2012 Essentials network3"
ms.custom: na
ms.date: 02/28/2013
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
H1: Demote and remove the Source Server from the new Windows Server 2012 Essentials network
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: a3ea2800-658b-46d0-bcbc-b821eb5f81f3
caps.latest.revision: 6
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
# Demote and remove the Source Server from the new Windows Server 2012 Essentials network3
After you finish installing --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials and you complete the Migration, you must perform the following tasks:  
  
<<<<<<< HEAD
1.  [Remove Active Directory Certificate Services](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md#BKMK_ADCS)  
  
2.  [Disconnect printers that are directly connected to the Source Server](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md#BKMK_PhysicallyDisconnect)  
  
3.  [Demote the Source Server](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md#BKMK_DemoteTheSourceServer)  
  
4.  [Remove and repurpose the Source Server](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md#BKMK_RemoveTheSourceServer)  
=======
1.  [Remove Active Directory Certificate Services](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md#BKMK_ADCS)  
  
2.  [Disconnect printers that are directly connected to the Source Server](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md#BKMK_PhysicallyDisconnect)  
  
3.  [Demote the Source Server](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md#BKMK_DemoteTheSourceServer)  
  
4.  [Remove and repurpose the Source Server](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md#BKMK_RemoveTheSourceServer)  
>>>>>>> 4bac1739fd0378146de6c9af26f683b8076754b8
  
###  <a name="BKMK_ADCS"></a> Remove Active Directory Certificate Services  
 The procedure is slightly different if you have multiple Active Directory Certificate Services (AD CS) role services installed on a single server. You can use the following procedure to uninstall an AD CS role service and to retain other AD CS role services.  
  
 To complete this procedure, you must log on with the same permissions as the user who installed the certification authority (CA). If you are uninstalling an enterprise CA, membership in Enterprise Admins or its equivalent is the minimum required to complete this procedure.  
  
##### To remove AD CS  
  
1.  Log on to the Source Server as a domain administrator.  
  
2.  On the **Start** screen, click **Administrative Tools**, and then double-click **Server Manager**.  
  
3.  Click **Continue** in the **User Account Control** dialog box.  
  
4.  In Server Manager, click **Manage**, and then click **Remove Roles and Features**.  
  
5.  In the Remove Roles and Features Wizard, click **Next**.  
  
6.  On the **Select destination server** page, select the local server, and then click **Next**.  
  
7.  On the **Remove server roles** page, expand **Active Directory Certificate Services**, clear the **Certification Authority Web Enrollment** check box, and then click **Next**.  
  
8.  After removing the Certification Authority Web Enrollment role, close the Remove Roles and Features wizard, and return to Server Manager.  
  
9. In Server Manager, click **Manage**, and then click **Remove Roles and Features**.  
  
10. In the Remove Roles and Features Wizard, click **Next**.  
  
11. On the **Select destination server** page, select the local server, and then click **Next**.  
  
12. On the **Remove server roles** page, expand **Active Directory Certificate Services**, clear the **Active Directory Certificate Services** check box, and then click **Next**.  
  
13. On the **Confirm Removal Options** page, review the information, and then click **Remove**.  
  
    > [!NOTE]
    >  If Internet Information Services (IIS) is running, you are prompted to stop the service before proceeding. Click **OK**.  
  
14. When the Remove Roles Wizard finishes, restart the server to complete the uninstallation process.  
  
    > [!IMPORTANT]
    >  Restart the server even if you are not prompted to do so.  
  
###  <a name="BKMK_PhysicallyDisconnect"></a> Disconnect printers that are directly connected to the Source Server  
 Before you demote the Source Server, physically disconnect any printers that are directly connected to the Source Server and are shared through the Source Server. Ensure that no Active Directory objects remain for the printers that were directly connected to the Source Server. The printers can then be directly connected to the Destination Server and shared from --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials.  
  
###  <a name="BKMK_DemoteTheSourceServer"></a> Demote the Source Server  
 Before you demote the Source Server from the role of the AD DS domain controller to the role of a domain member server, ensure that Group Policy settings are applied to all client computers, as described in the following procedure.  
  
> [!IMPORTANT]
>  The Source Server and the Destination Server must be connected to the network while the Group Policy changes are updated on the client computers.  
  
##### To force a Group Policy update on a client computer  
  
1.  Log on to the client computer as an administrator.  
  
<<<<<<< HEAD
2.  Open a Command Prompt window as an administrator. For more information, see [To open a Command Prompt window as an Administrator](Migrate-Windows-Server-2012-Essentials-to-New-Hardware.md#BKMK_OpenACommandPromptAsAdmin).  
=======
2.  Open a Command Prompt window as an administrator. For more information, see [To open a Command Prompt window as an Administrator](../migrate/Migrate-Windows-Server-2012-Essentials-to-New-Hardware.md#BKMK_OpenACommandPromptAsAdmin).  
>>>>>>> 4bac1739fd0378146de6c9af26f683b8076754b8
  
3.  At the command prompt, type **gpupdate /force**, and then press ENTER.  
  
4.  The process may require you to log off and log on again to finish. Click **Yes** to confirm.  
  
##### To demote the Source Server  
  
1.  Log on to the Source Server as a domain administrator.  
  
2.  On the **Start** screen, click **Administrative Tools**, and then double-click **Server Manager**.  
  
3.  In Server Manager, click **Manage**, and then click **Remove Roles and Features**.  
  
4.  On the **Before you begin** screen, click **Next**.  
  
5.  On the **Server Selection** screen, select **Local Server**, and then click **Next**.  
  
6.  On the **Server Roles** screen, clear the **Active Directory Domain Services** check box.  
  
7.  Click **Remove Features** in the dialog box.  
  
8.  Click **Demote this domain controller** in the next dialog box.  
  
9. On the **Credentials** screen, do not select the **Last domain controller in the domain** check box. Click **Next**.  
  
10. On the **Warnings** screen, select the **Proceed with removal** check box. Click **Next**.  
  
11. On **Removal Options** screen, click **Next**.  
  
12. On the **Review Options** screen, click **Demote**.  
  
     When the demotion is finished, the server will restart automatically.  
  
 After you add the Source Server as a member of a workgroup and disconnect it from the network, you must remove it from AD DS on the Destination Server.  
  
##### To remove the Source Server from Active Directory  
  
1.  On the Destination Server, open **Active Directory Users and Computers**.  
  
2.  In the **User Account Control** window, click **Continue** if prompted.  
  
3.  In the **Active Directory Users and Computers** navigation pane, expand the domain name, and then expand **Computers**.  
  
4.  Right-click the Source Server name if it still exists in the list of servers, click **Delete**, and then click **Yes**.  
  
5.  Verify that the Source Server is not listed, and then close **Active Directory Users and Computers**.  
  
###  <a name="BKMK_RemoveTheSourceServer"></a> Remove and repurpose the Source Server  
 Turn off the Source Server and disconnect it from the network. We recommend that you do not reformat the Source Server for at least one week to ensure that all the necessary data migrated to the Destination Server. After you have verified that all the data has migrated, you can reinstall this server on the network as a secondary server for other tasks, if required.  
  
> [!NOTE]
>  After you demote and remove the Source Server, restart the Destination Server.  
  
 After you demote the Source Server, it is not in a healthy state. If you want to repurpose the Source Server, the simplest way is to reformat it, install a server operating system, and then set it up for use as an additional server.
