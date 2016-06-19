---
title: Offer all available integration services to virtual machines
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2c4b2043-ad81-495e-aa7a-467f813bb3d2
author: KBDAzure
---
# Offer all available integration services to virtual machines
\[This information is preliminary and subject to change.\]  
  
For more information about best practices and scans, see* [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).  
  
|||  
|-|-|  
|**Operating System**|Windows Server 2016 Technical Preview|  
|**Product\/Feature**|Hyper\-V|  
|**Severity**|Warning|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
  
*One or more available integration services are not enabled on virtual machines.*  
  
## Impact  
  
*Some capabilities will not be available to the following virtual machines:*  
  
\<list of virtual machine names>  
  
## Resolution  
  
*If this is intentional, no further action is required. Otherwise, consider offering all integration services in the settings of these virtual machines.*  
  
The availability of some integration services can be managed through the virtual machine settings.   
  
#### To manage the availability of integration services to a virtual machine  
  
1.  Open Hyper\-V Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper\-V Manager**.  
  
2.  In the results pane, under **Virtual Machines**, select the virtual machine that you want to configure.  
  
3.  In the **Action** pane, under the virtual machine name, click **Settings**.  
  
4.  Under **Management**, click **Integration Services**.  
  
5.  In the list of integration services, select the check box for each service you want to offer to the virtual machine. If a check box is unavailable, that particular integration service is not supported by the guest operating system that runs in the virtual machine.  
  

