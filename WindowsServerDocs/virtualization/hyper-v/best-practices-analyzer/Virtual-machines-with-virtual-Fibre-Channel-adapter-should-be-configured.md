---
title: Virtual machines configured with a virtual Fibre Channel adapter should be configured for high availability to the Fibre Channel-based storage
description: Learn what to do when one or more virtual machines lack a highly available connection to Fibre Channel-based storage because those virtual machines are configured with a virtual Fibre Channel adapter that is connected to only one host bus adapter (HBA).
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 73127bdd-8086-4268-a93c-2fdf1623e91b
ms.date: 8/16/2016
---
# Virtual machines configured with a virtual Fibre Channel adapter should be configured for high availability to the Fibre Channel-based storage

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Information|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## **Issue**
*One or more virtual machines lack a highly available connection to Fibre Channel-based storage because those virtual machines are configured with a virtual Fibre Channel adapter that is connected to only one host bus adapter (HBA).*

## **Impact**
*A failure of the host bus adapter might block the Fibre Channel connection between the storage and the virtual machines. This impacts the following virtual machines:*

\<list of virtual machines>

## **Resolution**
*Add another connection from the virtual machine to the host bus adapter and configure multipath I/O (MPIO) in the guest operating system to establish redundant Fibre Channel connections.*
