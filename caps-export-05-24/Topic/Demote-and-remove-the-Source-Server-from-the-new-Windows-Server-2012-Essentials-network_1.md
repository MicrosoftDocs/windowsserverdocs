---
title: Demote and remove the Source Server from the new Windows Server 2012 Essentials network_1
ms.custom: na
ms.prod: windows-server-2012-r2-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a4bd55f2-ff66-4088-b83c-8bf3728b062c
---
# Demote and remove the Source Server from the new Windows Server 2012 Essentials network_1
After you finish installing [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)] and you complete the migration, you must perform the following tasks:  
  
1.  [Remove Active Directory Certificate Services](../Topic/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network_1.md#BKMK_ADCS)  
  
2.  [Disconnect printers that are directly connected to the Source Server](../Topic/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network_1.md#BKMK_PhysicallyDisconnect)  
  
3.  [Demote the Source Server](../Topic/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network_1.md#BKMK_DemoteTheSourceServer)  
  
4.  [Remove and repurpose the Source Server](../Topic/Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-2012-Essentials-network_1.md#BKMK_RemoveTheSourceServer)  
  
### <a name="BKMK_ADCS"></a>Remove Active Directory Certificate Services  
The procedure is slightly different if you have multiple Active Directory Certificate Services \(AD CS\) role services installed on a single server. You can use the following procedure to uninstall an AD CS role service and to retain other AD CS role services.  
  
To complete this procedure, you must log on with the same permissions as the user who installed the certification authority \(CA\). If you are uninstalling an enterprise CA, membership in Enterprise Admins or its equivalent is the minimum required to complete this procedure.  
  
##### To remove AD CS  
  
1.  Log on to the Source Server as a domain administrator.  
  
2.  Click **Start**, click **Administrative Tools**, and then click **Server Manager**.  
  
3.  Click **Continue** in the **User Account Control** dialog box.  
  
4.  In the **Roles Summary** section, click **Remove Roles**.  
  
5.  In the Remove Roles Wizard, click **Next**.  
  
6.  Clear the **Active Directory Certificate Services** check box, and then click **Next**.  
  
7.  On the **Confirm Removal Options** page, review the information, and then click **Remove**.  
  
    > [!NOTE]  
    > If Internet Information Services \(IIS\) is running, you are prompted to stop the service before proceeding. Click **OK**.  
  
8.  When the Remove Roles Wizard finishes, restart the server to complete the uninstallation process.  
  
    > [!IMPORTANT]  
    > Restart the server even if you are not prompted to do so.  
  
### <a name="BKMK_PhysicallyDisconnect"></a>Disconnect printers that are directly connected to the Source Server  
Before you demote the Source Server, physically disconnect any printers that are directly connected to the Source Server and are shared through the Source Server. Ensure that no Active Directory objects remain for the printers that were directly connected to the Source Server. The printers can then be directly connected to the Destination Server and shared from [!INCLUDE[sbs_sbs8web_2](../Token/sbs_sbs8web_2_md.md)].  
  
### <a name="BKMK_DemoteTheSourceServer"></a>Demote the Source Server  
Before you demote the Source Server from the role of the AD DS domain controller to the role of a domain member server, ensure that Group Policy settings are applied to all client computers, as described in the following procedure.  
  
> [!IMPORTANT]  
> The Source Server and the Destination Server must be connected to the network while the Group Policy changes are updated on the client computers.  
  
##### To force a Group Policy update on a client computer  
  
1.  Sign in to the client computer as an administrator.  
  
2.  Open a Command Prompt window as an administrator.  
  
3.  At the command prompt, type **gpupdate \/force**, and then press ENTER.  
  
4.  The process may require you to log off and log on again to finish. Click **Yes** to confirm.  
  
##### To demote the Source Server  
  
1.  On the Source Server, click **Start**, click **Run**, type **dcpromo**, and then click **OK**.  
  
2.  Click **Next** twice.  
  
    > [!NOTE]  
    > Do not select **This server is the last domain controller in the domain**.  
  
3.  Type a password for the new Administrator account on the server, and then click **Next**.  
  
4.  In the **Summary** dialog box, you are informed that AD DS will be removed from the computer and that the server will become a member of the domain. Click **Next**.  
  
5.  Click **Finish**. The Source Server restarts.  
  
6.  After the Source Server restarts, add the Source Server as a member of a workgroup before you disconnect it from the network.  
  
After you add the Source Server as a member of a workgroup and disconnect it from the network, you must remove it from AD DS on the Destination Server.  
  
##### To remove the Source Server from Active Directory  
  
1.  On the Destination Server, open **Active Directory Users and Computers**.  
  
2.  In the **Active Directory Users and Computers** navigation pane, expand the domain name, and then expand **Computers**.  
  
3.  Right\-click the Source Server name if it still exists in the list of servers, click **Delete**, and then click **Yes**.  
  
4.  Verify that the Source Server is not listed, and then close **Active Directory Users and Computers**.  
  
### <a name="BKMK_RemoveTheSourceServer"></a>Remove and repurpose the Source Server  
Turn off the Source Server and disconnect it from the network. We recommend that you do not reformat the Source Server for at least one week to ensure that all the necessary data migrated to the Destination Server. After you have verified that all the data has migrated, you can reinstall this server on the network as a secondary server for other tasks, if required.  
  
> [!NOTE]  
> After you demote and remove the Source Server, restart the Destination Server.  
  
After you demote the Source Server, it is not in a healthy state. If you want to repurpose the Source Server, the simplest way is to reformat it, install a server operating system, and then set it up for use as an additional server.  
  
