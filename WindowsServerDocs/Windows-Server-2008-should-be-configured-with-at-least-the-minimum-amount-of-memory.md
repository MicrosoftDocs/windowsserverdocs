---
title: Windows Server 2008 should be configured with at least the minimum amount of memory
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b5065a3f-364d-4aa9-8703-eafa7a46b575
---
# Windows Server 2008 should be configured with at least the minimum amount of memory
\[This information is preliminary and subject to change.\]

*For more information about best practices and scans, see* [Best Practices Analyzer](http://go.microsoft.com/fwlink/?LinkId=122786).

|||
|-|-|
|**Operating System**|[!INCLUDE[winthreshold_server_2](includes/winthreshold_server_2_md.md)]|
|**Product\/Feature**|Hyper\-V|
|**Severity**|Error|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue

*A virtual machine running Windows Server 2008 is configured with less than the minimum amount of RAM, which is 512 MB.*

## Impact

*The guest operating system on the following virtual machines might not run or might run unreliably:*

\<list of virtual machine names>


## Resolution

*Use Hyper\-V Manager to increase the memory allocated to this virtual machine to at least 512 MB.*

### To increase the memory using Hyper\-V Manager

1.  Open [!INCLUDE[nextref_virtualname](includes/nextref_virtualname_md.md)] Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper\-V Manager**.

2.  In the results pane, under **Virtual Machines**, select the virtual machine that you want to configure. The state of the virtual machine should be listed as **Off**. If it is not, right\-click the virtual machine and then click **Shut Down**.

3.  In the **Action** pane, under the virtual machine name, click **Settings**.

4.  In the navigation pane, click **Memory**.

5.  On the **Memory** page, set the **Startup RAM** to at least 512 MB and then click **OK**.

### Increase the memory using Windows PowerShell

1.  Open Windows PowerShell. \(From the desktop, click **Start** and start typing **[!INCLUDE[wps_2](includes/wps_2_md.md)]**.\)

2.  Right\-click **[!INCLUDE[wps_2](includes/wps_2_md.md)]** and click **Run as administrator**.

3.  Run this command after replacing \<MyVM> with the name  of your virtual machine:

```
Set-VMMemory <MyVM> -StartupBytes 512MB
```

## See Also
[Set-VMMemory](https://technet.microsoft.com/library/hh848572.aspx)


