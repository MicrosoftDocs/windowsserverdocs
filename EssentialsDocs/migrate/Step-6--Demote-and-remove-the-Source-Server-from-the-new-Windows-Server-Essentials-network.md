---
title: "Step 6: Demote and remove the Source Server from the new Windows Server Essentials network"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/03/2016
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 86244c66-2c5e-488d-adb8-112e1ca3e2e1
author: nnamuhcs
ms.author: coreyp
manager: dongill
---

# Step 6: Demote and remove the Source Server from the new Windows Server Essentials network

>Applies To: Windows Server 2016 Essentials, Windows Server 2012 R2 Essentials, Windows Server 2012 Essentials

After you finish installing  Windows Server Essentials and you complete the migration, you must perform the following tasks:  
  
1.  [Remove Active Directory Certificate Services](Step-6--Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_ADCS)  
  
2.  [Disconnect printers that are directly connected to the Source Server](Step-6--Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_PhysicallyDisconnect)  
  
3.  [Demote the Source Server](Step-6--Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_DemoteTheSourceServer)  
  
4.  [Remove and repurpose the Source Server](Step-6--Demote-and-remove-the-Source-Server-from-the-new-Windows-Server-Essentials-network.md#BKMK_RemoveTheSourceServer)  
  
##  <a name="BKMK_ADCS"></a> Remove Active Directory Certificate Services  
 The procedure is slightly different if you have multiple Active Directory Certificate Services (AD CS) role services installed on a single server. You can use the following procedure to uninstall an AD CS role service and to retain other AD CS role services.  
  
 To complete this procedure, you must log on with the same permissions as the user who installed the certification authority (CA). If you are uninstalling an enterprise CA, membership in Enterprise Admins or its equivalent is the minimum required to complete this procedure.  
  
#### To remove AD CS  
  
1.  Log on to the Source Server as a domain administrator.  
  
2.  Click **Start**, click **Administrative Tools**, and then click **Server Manager**.  
  
3.  Click **Continue** in the **User Account Control** dialog box.  
  
4.  In the **Roles Summary** section, click **Remove Roles**.  
  
5.  In the Remove Roles Wizard, click **Next**.  
  
6.  Clear the **Active Directory Certificate Services** check box, and then click **Next**.  
  
7.  On the **Confirm Removal Options** page, review the information, and then click **Remove**.  
  
    > [!NOTE]
    >  If Internet Information Services (IIS) is running, you are prompted to stop the service before proceeding. Click **OK**.  
  
    > [!NOTE]
    >  First, you may need to remove **Certification Authority Web Enrollment**, if it is installed.  
  
8.  When the Remove Roles Wizard finishes, restart the server to complete the uninstallation process.  
  
    > [!IMPORTANT]
    >  Restart the server even if you are not prompted to do so.  
  
##  <a name="BKMK_PhysicallyDisconnect"></a> Disconnect printers that are directly connected to the Source Server  
 Before you demote the Source Server, physically disconnect any printers that are directly connected to the Source Server and are shared through the Source Server. Ensure that no Active Directory objects remain for the printers that were directly connected to the Source Server. The printers can then be directly connected to the Destination Server and shared from  Windows Server Essentials.  
  
##  <a name="BKMK_DemoteTheSourceServer"></a> Demote the Source Server  
 Before you demote the Source Server from the role of the AD DS domain controller to the role of a domain member server, ensure that Group Policy settings are applied to all client computers, as described in the following procedure.  
  
> [!IMPORTANT]
>  The Source Server and the Destination Server must be connected to the network while the Group Policy changes are updated on the client computers.  
  
#### To force a Group Policy update on a client computer  
  
1. Sign in to the client computer as an administrator.  
  
2. Open a Command Prompt window as an administrator.  
  
3. At the command prompt, type **gpupdate /force**, and then press ENTER.  
  
4. The process may require you to log off and log on again to finish. Click **Yes** to confirm.  
  
   If you are migrating from Windows Server Essentials or its previous versions, to demote the server, see [Remove Active Directory Domain Services](https://technet.microsoft.com/library/hh472163.aspx). After you add the Source Server as a member of a workgroup and disconnect it from the network, you must remove it from AD DS on the Destination Server.  
  
   If you are migrating from  Windows Server Essentials, use Server Manager to remove the Active Directory Domain Services role, thereby demoting the domain controller on the Source Server using the following procedure:  
  
#### To remove the Source Server from Active Directory  
  
1.  On the Destination Server, open **Active Directory Users and Computers**.  
  
2.  In the **Active Directory Users and Computers** navigation pane, expand the domain name, and then expand **Computers**.  
  
3.  If the Source Server still exists in the list of servers, right-click the Source Server name, click **Delete**, and then click **Yes**.  
  
4.  Verify that the Source Server is not listed, and then close **Active Directory Users and Computers**.  
  
##  <a name="BKMK_RemoveTheSourceServer"></a> Remove and repurpose the Source Server  
 Turn off the Source Server and disconnect it from the network. We recommend that you do not reformat the Source Server for at least one week to ensure that all the necessary data migrated to the Destination Server. After you have verified that all the data has migrated, you can reinstall this server on the network as a secondary server for other tasks, if required.  
  
> [!NOTE]
>  After you demote and remove the Source Server, restart the Destination Server.  
  
 After you demote the Source Server, it is not in a healthy state. If you want to repurpose the Source Server, the simplest way is to reformat it, install a server operating system, and then set it up for use as an additional server.  
  
## Next steps  
 You have demoted and removed the Source Server from the new  Windows Server Essentials network. Now go to [Step 7: Perform post-migration tasks for the Windows Server Essentials migration](Step-7--Perform-post-migration-tasks-for-the-Windows-Server-Essentials-migration.md).  
  

To view all the steps, see [Migrate to Windows Server Essentials](Migrate-from-Previous-Versions-to-Windows-Server-Essentials-or-Windows-Server-Essentials-Experience.md).

