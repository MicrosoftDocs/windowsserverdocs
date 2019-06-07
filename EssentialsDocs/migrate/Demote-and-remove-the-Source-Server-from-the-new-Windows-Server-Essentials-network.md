---
title: "Demote and remove the Source Server from the new Windows Server Essentials network1"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d9f18b29-8e03-439e-bdf0-1dac5e4f70c5
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Demote and remove the Source Server from the new Windows Server Essentials network1

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

After you finish installing  Windows Server Essentials and you complete the tasks in the Migration Wizard, you must perform the following tasks:  
  

1.  [Uninstall Exchange Server 2003](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_UninstallExchangeServer2003).  
  
2.  [Disconnect printers that are directly connected to the Source Server](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_PhysicallyDisconnect).  
  
3.  [Demote the Source Server](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_DemoteTheSourceServer).  
  
4.  [Move the DHCP Server role from the Source Server to the router](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_MoveTheDHCPRole).  
  
5.  [Remove and repurpose the Source Server](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_RemoveTheSourceServer).  

1.  [Uninstall Exchange Server 2003](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_UninstallExchangeServer2003).  
  
2.  [Disconnect printers that are directly connected to the Source Server](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_PhysicallyDisconnect).  
  
3.  [Demote the Source Server](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_DemoteTheSourceServer).  
  
4.  [Move the DHCP Server role from the Source Server to the router](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_MoveTheDHCPRole).  
  
5.  [Remove and repurpose the Source Server](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_RemoveTheSourceServer).  

  
###  <a name="BKMK_UninstallExchangeServer2003"></a> Uninstall Exchange Server 2003  
  
> [!IMPORTANT]
>  If you add user accounts after you move mailboxes to the Destination Server and before you uninstall Exchange Server 2003 from the Source Server, the mailboxes are added on the Source Server. This is by design. You must move the mailboxes to the Destination Server for all user accounts that are added during this time. Repeat the instructions in Move Exchange Server mailboxes and settings for  Windows Server Essentials migration before you uninstall Exchange Server 2003.  
  
 You must uninstall Exchange Server 2003 from the Source Server before you demote it. This removes all references in Active Directory Domain Services (AD DS) to Exchange Server on the Source Server. You must have your Windows Small Business Server 2003 media to remove Exchange Server 2003.  
  
##### To Uninstall Exchange Server 2003 from the Source Server  
  
1. Log on to the Source Server as an administrator  
  
2. Click **Start**, click **Control Panel**, and then click **Add or Remove Programs**.  
  
3. In the list of programs, select **Windows Small Business Server 2003**, and then click **Change/Remove**.  
  
4. In the Setup Wizard, click **Next** until the **Component Selection** page appears.  
  
5. On the Component Selection page, expand **Exchange Server**, and then choose **Remove**.  
  
   > [!NOTE]
   > 
   >  Exchange Server will check to make sure that there are no mailboxes or public folders on the server. If any data remains, an error message appears when you click **Remove**. To avoid this issue, make sure that you have completed all of the procedures in the topic [Move SBS 2003 settings and data to the Destination Server](Move-Windows-SBS-2003-settings-and-data-to-the-Destination-Server-for-Windows-Server-Essentials-migration.md).  
   > 
   >  Exchange Server will check to make sure that there are no mailboxes or public folders on the server. If any data remains, an error message appears when you click **Remove**. To avoid this issue, make sure that you have completed all of the procedures in the topic [Move SBS 2003 settings and data to the Destination Server](../migrate/Move-Windows-SBS-2003-settings-and-data-to-the-Destination-Server-for-Windows-Server-Essentials-migration.md).  

  
6. Click **Next**.  
  
7. When prompted, insert Windows Small Business Server 2003 CD#3, and follow the onscreen instructions.  
  
###  <a name="BKMK_PhysicallyDisconnect"></a> Disconnect printers that are directly connected to the Source Server  
 Before you demote the Source Server, physically disconnect any printers that are directly connected to the Source Server and are shared through the Source Server. Ensure that no Active Directory objects remain for the printers that were directly connected to the Source Server. The printers can then be directly connected to the Destination Server and shared from  Windows Server Essentials.  
  
###  <a name="BKMK_DemoteTheSourceServer"></a> Demote the Source Server  
 Before you demote the Source Server from the role of the AD DS domain controller to the role of a domain member server, ensure that Group Policy settings are applied to all client computers, as described in the following procedure.  
  
> [!IMPORTANT]
>  The Source Server and the Destination Server must be connected to the network while the Group Policy changes are updated on the client computers.  
  
##### To force a Group Policy update on a client computer  
  
1.  Log on to the client computer as an administrator.  
  
2.  Open a Command Prompt window as an administrator.  
  
3.  At the command prompt, type **gpupdate /force**, and then press ENTER.  
  
4.  The process may require you to log off and log on again to finish. Click **Yes** to confirm.  
  
##### To demote the Source Server  
  
1. On the Source Server, click **Start**, click **Run**, type **dcpromo**, and then click **OK**.  
  
2. Click **Next** twice.  
  
   > [!NOTE]
   >  Do not select **This server is the last domain controller in the domain**.  
  
3. Type a password for the new Administrator account on the server, and then click **Next**.  
  
4. In the **Summary** dialog box, you are informed that AD DS will be removed from the computer and that the server will become a member of the domain. Click **Next**.  
  
5. Click **Finish**. The Source Server restarts.  
  
6. After the Source Server restarts, add the Source Server as a member of a workgroup before you disconnect it from the network.  
  
   After you add the Source Server as a member of a workgroup and disconnect it from the network, you must remove it from AD DS on the Destination Server.  
  
##### To remove the Source Server from Active Directory  
  
1.  On the Destination Server, open **Active Directory Users and Computers**.  
  
2.  In the **Active Directory Users and Computers** navigation pane, expand the domain name, and then expand **Computers**.  
  
3.  Right-click the Source Server name if it still exists in the list of servers, click **Delete**, and then click **Yes**.  
  
4.  Verify that the Source Server is not listed, and then close **Active Directory Users and Computers**.  
  
###  <a name="BKMK_MoveTheDHCPRole"></a> Move the DHCP Server role from the Source Server to the router  
  
> [!NOTE]
> 
>  If you already performed this task before you started the migration process, continue with the section [Remove and repurpose the Source Server](Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_RemoveTheSourceServer).  
> 
>  If you already performed this task before you started the migration process, continue with the section [Remove and repurpose the Source Server](../migrate/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_RemoveTheSourceServer).  

  
 If your Source Server is running the DHCP role, perform the following steps to move the DHCP role to the router.  
  
##### To move the DHCP role from the Source Server to the router  
  
1.  Turn off the DHCP service on the Source Server, as follows:  
  
    1.  On the Source Server, Click **Start**, click **Administrative Tools**, and then click **Services**.  
  
    2.  In the list of currently running services, right-click the **Windows Server**, and then click **Properties**.  
  
    3.  For **Start type**, select **Disabled**.  
  
    4.  Stop the service.  
  
2.  Turn on the DHCP Role on your router  
  
    1.  Follow the instructions in your router documentation to turn on the DHCP role on the router.  
  
    2.  To ensure that IP addresses issued by the Source Server remain the same, follow the instructions in your router documentation to configure the DHCP range on the router to be the same as the DHCP range on the Source Server.  
  
    > [!IMPORTANT]
    >  If you have not set up a static IP or DHCP reservations on the router for the Destination Server, and the DHCP range is not the same as the Source Server, it is possible that the router will issue a new IP address for Destination Server. If this happens, reset the port forwarding rules of the router to forward to the new IP address of the Destination Server.  
  
###  <a name="BKMK_RemoveTheSourceServer"></a> Remove and repurpose the Source Server  
 Turn off the Source Server and disconnect it from the network. We recommend that you do not reformat the Source Server for at least one week to ensure that all the necessary data migrated to the Destination Server. After you have verified that all the data has migrated, you can reinstall this server on the network as a secondary server for other tasks, if required.  
  
> [!NOTE]
>  After you demote and remove the Source Server, restart the Destination Server.  
  
 After you demote the Source Server, it is not in a healthy state. If you want to repurpose the Source Server, the simplest way is to reformat it, install a server operating system, and then set it up for use as an additional server.
