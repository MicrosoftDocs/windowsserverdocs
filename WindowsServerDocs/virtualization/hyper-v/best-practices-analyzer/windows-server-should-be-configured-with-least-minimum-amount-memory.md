---
title: Windows Server 2016 should be configured with at least the minimum amount of memory
description: Learn what to do when a virtual machine running Windows Server 2016 is configured with less than the minimum amount of RAM, which is 512 MB.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: d324af73-af73-40b0-bd5b-8003ba3e921b
ms.date: 8/16/2016
---
# Windows Server 2016 should be configured with at least the minimum amount of memory

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Error|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## **Issue**
*A virtual machine running Windows Server 2016 is configured with less than the minimum amount of RAM, which is 512 MB.*

## **Impact**
*The guest operating system on the following virtual machines might not run or might run unreliably:*

\<list of virtual machines>

## **Resolution**
*Use Hyper-V Manager to increase the memory allocated to this virtual machine to at least 512 MB.*

#### Increase the memory using Hyper-V Manager

1.  Open Hyper-V Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper-V Manager**.

2.  In the results pane, under **Virtual Machines**, select the virtual machine that you want to configure. The state of the virtual machine should be listed as **Off**. If it is not, right-click the virtual machine and then click **Shut Down**.

3.  In the **Action** pane, under the virtual machine name, click **Settings**.

4.  In the navigation pane, click **Memory**.

5.  On the **Memory** page, set the **Startup RAM** to at least 512 MB and then click **OK**.

### Increase the memory using Windows PowerShell

1.  Open Windows PowerShell. (From the desktop, click **Start** and start typing **Windows PowerShell**.)

2.  Right-click **Windows PowerShell** and click **Run as administrator**.

3.  Run this command after replacing \<MyVM> with the name  of your virtual machine:

```
Set-VMMemory <MyVM> -StartupBytes 512MB
```

## See Also
[Set-VMMemory](/powershell/module/hyper-v/set-vmmemory)