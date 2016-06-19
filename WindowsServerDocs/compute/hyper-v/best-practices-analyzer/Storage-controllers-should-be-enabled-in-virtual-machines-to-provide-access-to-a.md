---
title: Storage controllers should be enabled in virtual machines to provide access to attached storage
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 532548a1-8ffe-4b5b-902e-ed2f0819012b
author: KBDAzure
---
# Storage controllers should be enabled in virtual machines to provide access to attached storage
\[This information is preliminary and subject to change.\]  
  
*For more information about best practices and scans, see* [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
## Issue  
  
*One or more storage controllers may be disabled in a virtual machine.*  
  
## Impact  
  
*Virtual machines cannot use storage connected to a disabled storage controller. This impacts the following virtual machines:*  
  
\<list of virtual machine names>  
  
## Resolution  
  
*Use Device Manager in the guest operating system to enable all storage controllers. If the storage controller is not required, use Hyper\-V Manager to remove it from the virtual machine.*  
  
For instructions on how to use Device Manager, see Help in the guest operating system. For instructions on how to remove the storage controller, see the following procedure.  
  
#### To remove a SCSI storage controller from the virtual machine  
  
1.  Open Hyper\-V Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper\-V Manager**.  
  
2.  In the results pane, under **Virtual Machines**, select the virtual machine that you want to configure.  
  
3.  If the virtual machine is running, shut down the virtual machine. Right\-click the virtual machine and click **Shut down**.  
  
4.  In the **Action** pane, under the virtual machine name, click **Settings**.  
  
5.  In the left pane of the **Settings** dialog box, under **Hardware**, click **SCSI Controller**.  
  
6.  In the right pane, click **Remove**.  
  

