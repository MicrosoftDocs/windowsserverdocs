---
title: Configure a virtual machine with a SCSI controller to be able to hot plug and hot unplug storage
description: Learn what to do when a virtual machine was found that is not configured with a SCSI controller.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 511e1172-aeef-463d-b5dd-2bffae411ff1
ms.date: 8/16/2016
---
# Configure a virtual machine with a SCSI controller to be able to hot plug and hot unplug storage

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

*A virtual machine was found that is not configured with a SCSI controller.*

## Impact

*You will not be able to hot plug or hot unplug storage for the following virtual machines:*

\<list of virtual machine names>

The ability to hot plug or hot unplug storage makes it easier to manage the storage needs of a virtual machine without requiring downtime. Virtual machines without SCSI controllers must be shut down before you can add or remove storage.

## Resolution

*If you do not need to hot plug or hot unplug storage for this virtual machine, no action is required. Otherwise, shut down the virtual machine and add a SCSI controller to the configuration.*

To use a SCSI controller to hot plug and hot unplug storage, the guest operating system must be running the current version of integration services.
