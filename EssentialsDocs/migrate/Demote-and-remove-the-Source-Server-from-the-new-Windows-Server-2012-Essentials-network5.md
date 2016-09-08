---
title: "Demote and remove the Source Server from the new Windows Server 2012 Essentials network5"
ms.custom: na
ms.date: 10/03/2012
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
H1: Demote and remove the Source Server from the new Windows Server 2012 Essentials network
applies_to: 
  - Windows Server 2012 Essentials
  - Windows Server 2012 R2 Essentials
ms.assetid: 78d4325f-e587-4c19-ba21-d34b603768fa
caps.latest.revision: 4
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
# Demote and remove the Source Server from the new Windows Server 2012 Essentials network5
After you finish installing --- translation.priority.ht:    - cs-cz   - de-at   - de-de   - es-es   - fr-be   - fr-fr   - hu-hu   - it-ch   - it-it   - ja-jp   - ko-kr   - nl-be   - nl-nl   - pl-pl   - pt-br   - pt-pt   - ru-ru   - sv-se   - tr-tr   - zh-cn   - zh-tw --- Windows Server 2012 Essentials and you complete the Migration, you must perform the following tasks:  
  
1.  [Uninstall Exchange Server 2007](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md#BKMK_UninstallExchangeServer2003)  
  
2.  [Remove Active Directory Certificate Services](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md#BKMK_ADCS)  
  
3.  [Disconnect printers that are directly connected to the Source Server](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md#BKMK_PhysicallyDisconnect)  
  
4.  [Demote the Source Server](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md#BKMK_DemoteTheSourceServer)  
  
5.  [Remove and repurpose the Source Server](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network5.md#BKMK_RemoveTheSourceServer)  
  
###  <a name="BKMK_UninstallExchangeServer2003"></a> Uninstall Exchange Server 2007  
 You must uninstall Exchange Server 2007 from the Source Server before you demote it. This removes all references in Active Directory Domain Services (AD DS) to Exchange Server on the Source Server. You must have your Exchange Server 2007 media to remove Exchange Server 2007.  
  
> [!IMPORTANT]
>  To remove Exchange Server 2007 from the Source Server, follow the instructions in [How to Completely Remove Exchange 2007 from a Server](http://go.microsoft.com/fwlink/p/?LinkId=248921).  
  
###  <a name="BKMK_ADCS"></a> Remove Active Directory Certificate Services  
 The procedure is slightly different if you have multiple Active Directory Certificate Services (AD CS) role services installed on a single server. You can use the following procedure to uninstall an AD CS role service and to retain other AD CS role services.  
  
 To complete this procedure, you must log on with the same permissions as the user who installed the certification authority (CA). If you are uninstalling an enterprise CA, membership in Enterprise Admins or its equivalent is the minimum required to complete this procedure.  
  
##### To remove AD CS  
  
1.  Log on to the Source Server as a domain administrator.  
  
2.  Click **Start**, click **Administrative Tools**, and then click **Server Manager**.  
  
3.  Click **Continue** in the **User Account Control** dialog box.  
  
4.  In the **Roles Summary** section, click **Remove Roles**.  
  
5.  In the Remove Roles Wizard, click **Next**.  
  
6.  Clear the **Active Directory Certificate Services** check box, and then click **Next**.  
  
7.  On the **Confirm Removal Options** page, review the information, and then click **Remove**.  
  
    > [!NOTE]
    >  If Internet Information Services (IIS) is running, you are prompted to stop the service before proceeding. Click **OK**.  
  
8.  When the Remove Roles Wizard finishes, restart the server to complete the uninstallation process.  
  
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
  
2.  Open a Command Prompt window as an administrator. For more information, see [To open a Command Prompt window on the Source Server as an administrator](../migrate/Migrate-Windows-Small-Business-Server-2003-to-Windows-Server-2012-Essentials.md#BKMK_OpenACommandPromptAsAdmin).  
  
3.  At the command prompt, type **gpupdate /force**, and then press ENTER.  
  
4.  The process may require you to log off and log on again to finish. Click **Yes** to confirm.  
  
##### To demote the Source Server  
  
1.  On the Source Server, click **Start**, click **Run**, type **dcpromo**, and then click **OK**.  
  
2.  Click **Next** twice.  
  
    > [!NOTE]
    >  Do not select **This server is the last domain controller in the domain**.  
  
3.  Type a password for the new Administrator account on the server, and then click **Next**.  
  
4.  In the **Summary** dialog box, you are informed that AD DS will be removed from the computer and that the server will become a member of the domain. Click **Next**.  
  
5.  Click **Finish**. The Source Server restarts.  
  
6.  After the Source Server restarts, add the Source Server as a member of a workgroup before you disconnect it from the network.  
  
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
