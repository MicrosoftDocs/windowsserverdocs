---
title: Dynamic Memory is enabled but not responding on some virtual machines
description: Learn what to do when one or more virtual machines are experiencing problems with the driver required for Dynamic Memory in the guest operating system.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 91b7f50f-a071-4ab6-beb1-1b29f92f52b6
ms.date: 8/16/2016
---
# Dynamic Memory is enabled but not responding on some virtual machines

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue
*One or more virtual machines are experiencing problems with the driver required for Dynamic Memory in the guest operating system.*

## Impact
*The guest operating system in the following virtual machines might not run or might run unreliably because Hyper-V cannot adjust the memory dynamically to respond to changes in memory demand. This impacts the following virtual machines:*

\<list of virtual machines>

## Resolution
*This is expected behavior if the virtual machine is booting. If the virtual machine is not booting, make sure that integration services are upgraded to the latest version and that the guest operating system supports Dynamic Memory.*

As of Windows Server 2016, integration services are delivered through Windows Update. Ensure the virtual machines are configured to receive updates to get the latest version of integration services.

Dynamic Memory works with specific versions of supported guests. See [Hyper-V Dynamic Memory Overview](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831766(v=ws.11)) for versions older than Windows Server 2016 and Windows 10.
