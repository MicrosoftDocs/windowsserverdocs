---
title: The number of running virtual machines configured for SR-IOV should not exceed the number of virtual functions available to the virtual machines
description: Learn what to do when there are not enough virtual functions available for the number of running virtual machines configured for single-root I/O virtualization (SR-IOV).
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 8bd4af5e-9e7d-4710-8950-39435a8bb373
ms.date: 8/16/2016
---
# The number of running virtual machines configured for SR-IOV should not exceed the number of virtual functions available to the virtual machines

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
*There are not enough virtual functions available for the number of running virtual machines configured for single-root I/O virtualization (SR-IOV).*

## Impact
*Networking performance might not be optimal on the following virtual machines:*

\<list of virtual machines>

## Resolution
*Consider disabling SR-IOV on one or more virtual machines that do not require an SR-IOV virtual function.*
