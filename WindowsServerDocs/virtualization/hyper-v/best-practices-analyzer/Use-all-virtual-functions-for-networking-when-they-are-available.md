---
title: Use all virtual functions for networking when they are available
description: Learn what to do when some hardware acceleration capabilities are not being utilized.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: bf895484-6a0d-4aa4-9a42-9fac739e875d
ms.date: 8/16/2016
---
# Use all virtual functions for networking when they are available

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
*Some hardware acceleration capabilities are not being utilized*

## Impact
*This configuration might cause overall CPU utilization to be higher than necessary. Networking performance might not be optimal on the following virtual machines:*

\<list of virtual machines>

## Resolution
*Consider configuring the virtual network adapter for SR-IOV if the physical hardware supports SR-IOV and if this configuration does not conflict with the networking features required by the virtual machine.*
