---
title: The number of running or configured virtual machines must be within supported limits
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9d3c4aa3-8416-46ec-a253-26dc98088d7b
---
# The number of running or configured virtual machines must be within supported limits
\[This information is preliminary and subject to change.\]

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://go.microsoft.com/fwlink/p/?LinkID=223177).

|||
|-|-|
|**Operating System**|[!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]|
|**Product\/Feature**|Hyper\-V|
|**Severity**|Error
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue
*More virtual machines are running or configured than are supported.*

## Impact
*Microsoft does not support the current number of virtual machines running or configured on this server.*

## Resolution
*Move one or more virtual machines to another server.*

To move a virtual machine to another server, you can export the virtual machine from the current server and then import it to a new server as described below. Or, if this server belongs to a failover cluster, use the tools provided with the Failover Clustering feature to move the virtual machines. For instructions, see [Live Migrate, Quick Migrate, or Move a Virtual Machine from Node to Node](http://go.microsoft.com/fwlink/?LinkID=181519) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=181519\).

#### To export a virtual machine

1.  Open Hyper\-V Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper\-V Manager**.

2.  In the results pane, under **Virtual Machines**, right\-click a virtual machine and then click **Export**.

3.  In the **Export a Virtual Machine** dialog box, type or browse to a location that has enough free space to store all of the virtual machine resources. When you export a virtual machine, all virtual hard disks \(.vhd files\), snapshots \(.avhd files\), and saved state files associated with the virtual machine are copied to the specified folder.

    > [!IMPORTANT]
    > In a domain environment, if you specify a remote location such as a shared network folder or a folder on the server you want to import the virtual machine to, you must configure the server running Hyper\-V for constrained delegation. You need to do this so that the computer account of the server running Hyper\-V can present delegated credentials for the Common Internet File System \(CIFS\) service type. For instructions, see the following procedure.

4.  Click **Export**.

If you need to configure constrained delegation, complete the following procedure and then export the virtual machines. By default, membership in the **Domain Administrators** group is required to complete this procedure.

### To configure constrained delegation

1.  On a computer that has the Active Directory Domain Services Tools feature installed, in **Administrative Tools**, open **Active Directory Users and Computers**, and then navigate to the computer account for the computer running Hyper\-V.

    > [!NOTE]
    > If **Active Directory Users and Computers** is not listed, install the Active Directory Domain Services Tools feature. For instructions, see [Installing Remote Server Administration Tools for AD DS](http://go.microsoft.com/fwlink/?LinkId=140463) \(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=140463\).

2.  Right\-click the computer account for the computer running Hyper\-V, and then click **Properties**.

3.  On the **Delegation** tab, click **Select this computer for delegation to specified services only**, and then click **Use any authentication protocol**.

4.  To allow the Hyper\-V computer account to present delegated credentials to the remote computer:

    1.  Click **Add**.

    2.  In the **Add Services** dialog box, click **Users or Computers**, select the remote computer, and then click **OK**.

    3.  In the **Available services** list, select the **cifs** protocol \(also known as the Server Message Block \(SMB\) protocol\), and then click **Add**.

After exporting the virtual machines, import the virtual machines to the other server.

#### To import a virtual machine to another server

1.  Connect to the server running Hyper\-V and open Hyper\-V Manager.

2.  In the **Action** pane, click **Import Virtual Machine**.

3.  In the **Import Virtual Machine** dialog box, specify the location where you exported the virtual machine. Unless you want to reimport this virtual machine, leave the import settings as they are.

4.  Click **Import**.


