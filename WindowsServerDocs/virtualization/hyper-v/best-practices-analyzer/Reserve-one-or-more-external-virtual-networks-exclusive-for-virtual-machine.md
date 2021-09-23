---
title: Reserve one or more external virtual networks for exclusive use by virtual machines
description: Learn what to do when all external virtual networks are configured for use by both the management operating system and virtual machines.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: f7732258-93f1-44e8-835b-5ad2d1c45cd9
ms.date: 8/16/2016
---
# Reserve one or more external virtual networks for exclusive use by virtual machines

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Best Practices Analyzer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759260(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Error|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue

*All external virtual networks are configured for use by both the management operating system and virtual machines.*

## Impact

*Networking performance may be degraded in the management operating system.*

## Resolution

*Use Virtual Switch Manager to stop sharing an external virtual network with the management operating system.*

#### To stop sharing the external virtual network with the management operating system

1.  Open Hyper-V Manager. Click **Start**, point to **Administrative Tools**, and then click **Hyper-V Manager**.

2.  From the **Actions** menu, click **Virtual Switch Manager**.

3.  Under **Virtual Switches**, click the name of the external virtual switch.

4.  In the **Connection type** area, under the name of the physical network adapter, clear the **Allow the management operating system to share this network adapter** check box.

5.  Click **OK**.
