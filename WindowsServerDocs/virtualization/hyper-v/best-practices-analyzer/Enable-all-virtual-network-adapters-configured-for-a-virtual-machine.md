---
title: Enable all virtual network adapters configured for a virtual machine
description: Learn what to do when one or more network adapters may be disabled in a virtual machine.
ms.author: daknappe
author: dknappettmsft
ms.topic: best-practice
ms.date: 8/16/2016
---
# Enable all virtual network adapters configured for a virtual machine

For more information about best practices and scans, see [Best Practices Analyzer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759260(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue

*One or more network adapters may be disabled in a virtual machine.*

## Impact

*The following virtual machines might not have network connectivity:*

\<list of virtual machine names>

## Resolution

*Use Device Manager in the guest operating system to enable all virtual network adapters. If the adapter is not required, use Hyper-V Manager to remove it from the virtual machine.*


