---
title: Avoid pausing a virtual machine
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 930f927c-e414-4a36-9786-028941e886e4
author: KBDAzure
---
# Avoid pausing a virtual machine
\[This information is preliminary and subject to change.\]  
  
*For more information about best practices and scans, see* [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|[!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
## Issue  
  
*This server has one or more virtual machines in a paused state.*  
  
## Impact  
  
*Depending on the amount of available memory, you might not be able to run additional virtual machines.*  
  
Paused virtual machines don't release their allocated memory, which means that memory isn't available to start other virtual machines.  
  
## Resolution  
  
*If this is intentional, no further action is required. Otherwise, consider resuming these virtual machines or shutting them down.*  
  
#### Use Hyper\-V Manager to resume the virtual machine  
  
1.  Open Hyper\-V Manager. \(From the **Tools** menu of Server Manager, click **Hyper\-V Manager**.\)  
  
2.  From the **Virtual Machines** list, find the virtual machines with a state of **Paused**.  
  
    > [!IMPORTANT]  
    > A state of **Paused\-critical** occurs when there is very little free space remaining on the physical storage for that virtual machine. Before you attempt to resume a virtual machine in this state, free up available space on the physical storage.  
  
3.  Right\-click each virtual machine name, then click **Resume**. This returns the virtual machine to a running state. After that, if you want to shut down the virtual machine,  right\-click it again and choose **Shut down**.  
  
#### Use Windows PowerShell to resume the virtual machine  
  
You can do this in one command by using filtering and the pipeline after you get all virtual machines on the host. Type:  
  
```  
get-vm | where state -eq 'paused' | resume-vm  
```  
  

