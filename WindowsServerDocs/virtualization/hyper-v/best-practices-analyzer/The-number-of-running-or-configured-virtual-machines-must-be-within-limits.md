---
title: The number of running or configured virtual machines must be within supported limits
description: "Gives instructions to resolve the issue reported by this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 9d3c4aa3-8416-46ec-a253-26dc98088d7b
author: KBDAzure
ms.date: 8/16/2016
---
# The number of running or configured virtual machines must be within supported limits

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Error  
|**Category**|Configuration|  
  
In the following sections, italics indicates text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*More virtual machines are running or configured than are supported.*  
  
## Impact  
*Microsoft does not support the current number of virtual machines running or configured on this server.*  
  
## Resolution  
*Move one or more virtual machines to another server.*  
  
For details about maximum supported configurations for Hyper-V, such as the number of running virtual machines, see [Plan for Hyper-V scalability in Windows Server 2016](../plan/Plan-for-Hyper-V-scalability-in-Windows-Server-2016.md).  
  
To move a virtual machine to another server, you can:  
  
- Export the virtual machine from the current server and then import it to a new server as described below.   
- Do a live migration:   
    - If this server belongs to a failover cluster, use the tools provided with the Failover Clustering feature. For instructions, see [Live Migrate, Quick Migrate, or Move a Virtual Machine from Node to Node](https://go.microsoft.com/fwlink/?LinkID=181519).  
    - If this is a standalone server, see instructions in [Configure Live Migration and Migrating Virtual Machines without Failover Clustering](https://technet.microsoft.com//library/jj134199(v=ws.11).aspx)  
  
### To export a virtual machine  
  
   > [!IMPORTANT]  
   > If the Hyper-V host you're exporting from belongs to a domain and you want to store the exported files on a remote location, the Hyper-V host must be configured for constrained delegation. A remote location might be a shared network folder or a folder on the host you're importing to. Constrained delegation lets the computer account of the Hyper-V host provide delegated credentials for the Common Internet File System (CIFS) service to the remote computer. For instructions on configuring constrained delegation, see the section following the export and import instructions, below.  
  
1.  Open Hyper-V Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper-V Manager**.  
  
2.  In the results pane, under **Virtual Machines**, right-click a virtual machine and then click **Export**.  
  
3.  In the **Export a Virtual Machine** dialog box, type or browse to a location that has enough free space to store all of the virtual machine resources. When you export a virtual machine, all virtual hard disks (.vhd files or .vhdx files), checkpoints (.avhd files), and saved state files associated with the virtual machine are copied to the specified folder.  
  
4.  Click **Export**.  
  
After exporting the virtual machines, import the virtual machines to the other server.  
  
### To import a virtual machine to another server  
  
1.  Connect to the server running Hyper-V and open Hyper-V Manager.  
  
2.  In the **Action** pane, click **Import Virtual Machine**.  
  
3.  In the **Import Virtual Machine** dialog box, specify the location where you exported the virtual machine. Unless you want to reimport this virtual machine, leave the import settings as they are.  
  
4.  Click **Import**.  
  
### To configure constrained delegation  
  
Membership in the **Domain Administrators** group is required to complete this procedure.  
  
1.  On a computer that has the Active Directory Domain Services Tools feature installed, in **Administrative Tools**, open **Active Directory Users and Computers**, and then navigate to the computer account for the computer running Hyper-V.  
  
    > [!NOTE]  
    > If **Active Directory Users and Computers** is not listed, install the Active Directory Domain Services Tools feature. For instructions, see [Installing Remote Server Administration Tools for AD DS](https://go.microsoft.com/fwlink/?LinkId=140463) (https://go.microsoft.com/fwlink/?LinkId=140463).  
  
2.  Right-click the computer account for the computer running Hyper-V, and then click **Properties**.  
  
3.  On the **Delegation** tab, click **Select this computer for delegation to specified services only**, and then click **Use any authentication protocol**.  
  
4.  To allow the Hyper-V computer account to present delegated credentials to the remote computer:  
  
    1.  Click **Add**.  
  
    2.  In the **Add Services** dialog box, click **Users or Computers**, select the remote computer, and then click **OK**.  
  
    3.  In the **Available services** list, select the **cifs** protocol (also known as the Server Message Block (SMB) protocol), and then click **Add**.  
  
  
  


