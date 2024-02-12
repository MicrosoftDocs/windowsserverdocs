---
title: VMQ should be enabled on VMQ-capable physical network adapters bound to an external virtual switch
description: Learn what to do when the following network adapters are capable of virtual machine queue (VMQ) but the capability is disabled.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 93d1b155-bf44-46b0-bb69-d34d5b30e574
ms.date: 8/16/2016
---
# VMQ should be enabled on VMQ-capable physical network adapters bound to an external virtual switch

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## **Issue**
*The following network adapters are capable of virtual machine queue (VMQ) but the capability is disabled.*

## **Impact**
*Windows is unable to take full advantage of available hardware offloads on the following network adapters:*

\<list of network adapters>

## **Resolution**
*Enable VMQ using the Enable-NetAdapterVmq Windows PowerShell cmdlet or using the Advanced Properties user interface for the network adapter.*
