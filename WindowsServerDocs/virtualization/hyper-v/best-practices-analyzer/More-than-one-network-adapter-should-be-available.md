---
title: More than one network adapter should be available
description: Learn what to do when the server is configured with one network adapter, which must be shared by the management operating system and all virtual machines that require access to a physical network.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 59940e56-e06a-490f-90ea-cf30d9f80b09
ms.date: 8/16/2016
---
# More than one network adapter should be available

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

*This server is configured with one network adapter, which must be shared by the management operating system and all virtual machines that require access to a physical network.*

## Impact

*Networking performance may be degraded in the management operating system.*

## Resolution

*Add more network adapters to this computer. To reserve one network adapter for exclusive use by the management operating system, do not configure it for use with an external virtual network.*

For information about adding a network adapter to the computer, consult the documentation for the computer or the network adapter. Then, to reserve it exclusively for the management operating system, don't connect it to a virtual switch.
