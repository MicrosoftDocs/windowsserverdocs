---
title: Configure at least the required amount of memory for a virtual machine running Windows Server 2008 and enabled for Dynamic Memory
description: "Online version of the text for this Best Practices Analyzer rule."
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.author: kathydav
ms.topic: article
ms.assetid: 0aaa7138-ce83-4b17-add7-fdfa3d469bea
author: KBDAzure
ms.date: 8/16/2016
---
# Configure at least the required amount of memory for a virtual machine running Windows Server 2008 and enabled for Dynamic Memory

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](https://go.microsoft.com/fwlink/p/?LinkID=223177).  
  
|Property|Details|  
|-|-|  
|**Operating System**|Windows Server 2016|  
|**Product/Feature**|Hyper-V|  
|**Severity**|Error|  
|**Category**|Configuration|  
  
In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.  
  
## Issue  
*One or more virtual machines are configured to use Dynamic Memory with less than the amount of memory required for Windows Server 2008.*  
  
## Impact  
*The guest operating system on the following virtual machines might not run or might run unreliably:*  
  
\<list of virtual machines>  
  
## Resolution  
*Use Hyper-V Manager or Windows PowerShell to increase the minimum memory to at least 256 MB, and the startup memory and maximum memory to at least 512 MB.*  
  
### Increase memory using Hyper-V Manager  
  
1.  Open Hyper-V Manager. (From Server Manager, click **Tools** > **Hyper-V Manager**.)  
  
2.  From the list of virtual machines, right-click the one you want, then click **Settings**.  
  
3.  In the navigation pane, click **Memory**.  
  
4.  Change the **RAM** to at least 512 MB.  
  
5.  Under **Dynamic Memory**,  change the **Minimum RAM** to at least 256 MB and the **Maximum RAM** to 512 MB.  
  
6.  Click **OK**.  
  
### Increase memory using Windows PowerShell  
  
1.  Open Windows PowerShell. (From the desktop, click **Start** and start typing **Windows PowerShell**.)  
  
2.  Right-click **Windows PowerShell** and click **Run as administrator**.  
  
3.  Run a command similar to the following, replacing MyVM with the name  of your virtual machine and the memory values with at least the values shown below.  
  
```  
Get-VM MyVM | Set-VMMemory -DynamicMemoryEnabled $True -MaximumBytes 512MB -MinimumBytes 256MB -StartupBytes 512MB  
```  
  


