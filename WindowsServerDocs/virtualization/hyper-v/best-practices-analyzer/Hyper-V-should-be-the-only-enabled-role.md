---
title: Hyper-V should be the only enabled role
description: "Gives instructions to resolve the issue reported by this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 5a0ed176-048f-40b1-b56c-8391b805fd37
author: KBDAzure
ms.date: 8/16/2016
---
# Hyper-V should be the only enabled role

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
  
*Roles other than Hyper-V are enabled on this server.*  
  
In most cases, it's not a good idea to install other roles on a server running the Hyper-V role. Remote Desktop Virtualization Host role service is an exception, because it's part of the Remote Desktop Services role and requires Hyper-V to be installed on the same server.  
  
## Impact  
  
*The Hyper-V role should be the only role enabled on a server.*  
  
This best practice helps keep the host operating system free of roles, features, and applications that aren't required to run Hyper-V. Following this best practice and running Hyper-V on Nano Server helps reduce the number of updates you'll need because only Nano Server, the Hyper-V service components, and the Windows hypervisor would be subject to software updates.  
  
## Resolution  
  
*Use Server Manager to remove all roles except Hyper-V.*  
  
Server Manager includes the Remove Roles Wizard. This wizard lets you remove more than one role at once. Before removing roles, the Remove Roles Wizard checks for dependencies to reduce the risk of removing software that other roles rely on. If dependencies are found, the wizard prompts you to approve the removal of other roles, role services, or software required by installed roles.   
  
To use Server Manager, you must be logged on to the computer as an administrator.  
  
#### To remove a role  
  
1.  Open Server Manager by using shortcuts on the **Start** menu, on the Windows taskbar, or in Administrative Tools.  
2.   In the **Roles Summary** area of the Server Manager main window, click **Remove Roles**. Follow the instructions in the wizard to remove the role.   
  
  
  


