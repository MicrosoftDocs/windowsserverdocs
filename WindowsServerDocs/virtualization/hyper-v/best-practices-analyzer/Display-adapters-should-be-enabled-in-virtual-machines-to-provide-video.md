---
title: Display adapters should be enabled in virtual machines to provide video capabilities
description: Learn what to do when the Microsoft Virtual Machine Bus Video Device may be disabled in a virtual machine.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: ac5992e6-3c0b-46c2-a48e-6ef37b679228
ms.date: 8/16/2016
---
# Display adapters should be enabled in virtual machines to provide video capabilities

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016



*For more information about best practices and scans, see* [Best Practices Analyzer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759260(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue

*The Microsoft Virtual Machine Bus Video Device may be disabled in a virtual machine.*

Microsoft Virtual Machine Bus Video Device is a virtual video adapter optimized for use with Hyper-V virtual machines. When a virtual machine isn't configured to use the Microsoft Virtual Machine Bus Video Device, a legacy video adapter is used. Microsoft Virtual Machine Bus Video Device performs better than a legacy video adapter.

## Impact

*Video performance for the following virtual machines will be degraded:*

\<list of virtual machine names>

## Resolution

*Use Device Manager in the guest operating system to enable the Microsoft Virtual Machine Bus Video Device.*

The steps required to use Device Manager vary depending on the operating system. For instructions, see Help in the guest operating system.
