---
title: Offer all available integration services to virtual machines
description: "Gives instructions to resolve the issue reported by this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 2c4b2043-ad81-495e-aa7a-467f813bb3d2
author: KBDAzure
ms.date: 8/16/2016
---
# Offer all available integration services to virtual machines

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Best Practices Analyzer](https://go.microsoft.com/fwlink/?LinkId=122786).
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
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
  
1.  Open Hyper-V Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper-V Manager**.  
  
2.  In the results pane, under **Virtual Machines**, select the virtual machine that you want to configure.  
  
3.  In the **Action** pane, under the virtual machine name, click **Settings**.  
  
4.  Under **Management**, click **Integration Services**.  
  
5.  In the list of integration services, select the check box for each service you want to offer to the virtual machine. If a check box is unavailable, that particular integration service is not supported by the guest operating system that runs in the virtual machine.  
  


