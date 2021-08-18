---
title: Storage controllers should be enabled in virtual machines to provide access to attached storage
description: Learn what to do when one or more storage controllers may be disabled in a virtual machine.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 532548a1-8ffe-4b5b-902e-ed2f0819012b
ms.date: 8/16/2016
---
# Storage controllers should be enabled in virtual machines to provide access to attached storage

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Best Practices Analyzer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759260(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue

*One or more storage controllers may be disabled in a virtual machine.*

## Impact

*Virtual machines cannot use storage connected to a disabled storage controller. This impacts the following virtual machines:*

\<list of virtual machine names>

## Resolution

*Use Device Manager in the guest operating system to enable all storage controllers. If the storage controller is not required, use Hyper-V Manager to remove it from the virtual machine.*

For instructions on how to use Device Manager, see Help in the guest operating system. For instructions on how to remove the storage controller, see the following procedure.

#### To remove a SCSI storage controller from the virtual machine

1.  Open Hyper-V Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper-V Manager**.

2.  In the results pane, under **Virtual Machines**, select the virtual machine that you want to configure.

3.  If the virtual machine is running, shut down the virtual machine. Right-click the virtual machine and click **Shut down**.

4.  In the **Action** pane, under the virtual machine name, click **Settings**.

5.  In the left pane of the **Settings** dialog box, under **Hardware**, click **SCSI Controller**.

6.  In the right pane, click **Remove**.
