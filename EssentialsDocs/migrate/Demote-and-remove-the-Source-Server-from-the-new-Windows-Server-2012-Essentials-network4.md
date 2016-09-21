---
title: "Demote and remove the Source Server from the new Windows Server 2012 Essentials network4"
ms.custom: na
ms.date: 11/20/2012
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
H1: Demote and remove the Source Server from the new Windows Server 2012 Essentials network
applies_to: 
  - Windows Server 2016 Essentials
ms.assetid: 9ca50697-89a4-4d65-a230-3b18a7e01637
caps.latest.revision: 7
author: coreyp-at-msft
ms.author: coreyp

---
# Demote and remove the Source Server from the new Windows Server 2012 Essentials network4
After you finish installing  Windows Server 2012 Essentials and you complete the migration,   you must perform the following tasks:  
  

1.  [Uninstall Exchange Server 2010](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network4.md#BKMK_UninstallExchangeServer2010)  
  
2.  [Remove Active Directory Certificate Services](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network4.md#BKMK_ADCS)  
  
3.  [Disconnect printers that are directly connected to the Source Server](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network4.md#BKMK_PhysicallyDisconnect)  
  
4.  [Demote the Source Server](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network4.md#BKMK_DemoteTheSourceServer)  
  
5.  [Remove and repurpose the Source Server](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network4.md#BKMK_RemoveTheSourceServer)  

1.  [Uninstall Exchange Server 2010](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network4.md#BKMK_UninstallExchangeServer2010)  
  
2.  [Remove Active Directory Certificate Services](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network4.md#BKMK_ADCS)  
  
3.  [Disconnect printers that are directly connected to the Source Server](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network4.md#BKMK_PhysicallyDisconnect)  
  
4.  [Demote the Source Server](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network4.md#BKMK_DemoteTheSourceServer)  
  
5.  [Remove and repurpose the Source Server](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network4.md#BKMK_RemoveTheSourceServer)  

  
###  <a name="BKMK_UninstallExchangeServer2010"></a> Uninstall Exchange Server 2010  
 You must uninstall Exchange Server 2010 from the Source Server before you demote it. This removes all references in Active Directory Domain Services (AD DS) to Exchange Server on the Source Server. You must have your Exchange Server 2010 media to remove Exchange Server 2010.  
  
> [!IMPORTANT]
>  To remove Exchange Server 2010 from the Source Server, see [Modify or Remove Exchange 2010](http://go.microsoft.com/fwlink/?LinkId=270010).  
  
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
 Before you demote the Source Server, physically disconnect any printers that are directly connected to the Source Server and are shared through the Source Server. Ensure that no Active Directory objects remain for the printers that were directly connected to the Source Server. The printers can then be directly connected to the Destination Server and shared from  Windows Server 2012 Essentials.  
  
###  <a name="BKMK_DemoteTheSourceServer"></a> Demote the Source Server  
 Before you demote the Source Server from the role of the AD DS domain controller to the role of a domain member server, ensure that Group Policy settings are applied to all client computers, as described in the following procedure.  
  
> [!IMPORTANT]
>  The Source Server and the Destination Server must be connected to the network while the Group Policy changes are updated on the client computers.  
  
##### To force a Group Policy update on a client computer  
  
1.  Log on to the client computer as an administrator.  
  
2.  Open a command prompt window as an administrator.  
  
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
