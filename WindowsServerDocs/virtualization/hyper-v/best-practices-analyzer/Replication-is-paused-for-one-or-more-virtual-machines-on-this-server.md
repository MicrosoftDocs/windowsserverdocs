---
title: Replication is paused for one or more virtual machines on this server
description: Learn what to do when replication is paused for one or more of the virtual machines. While the primary virtual machine is paused, any changes that occur will be accumulated and will be sent to the Replica virtual machine once replication is resumed.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: e1119a40-eda3-4058-8648-7df81cbc6c29
ms.date: 8/16/2016
---
# Replication is paused for one or more virtual machines on this server

>Applies To: Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Operations|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue
*Replication is paused for one or more of the virtual machines. While the primary virtual machine is paused, any changes that occur will be accumulated and will be sent to the Replica virtual machine once replication is resumed.*

## Impact
*As long as replication is paused, accumulated changes occurring in the primary virtual machine will consume available disk space on the primary server. After replication is resumed, there might be a large burst of network traffic to the Replica server. This impacts the following virtual machines:*

\<list of virtual machines>

## Resolution
*Confirm that pausing replication was intended. If replication was paused to address low disk space or network connectivity, resume replication as soon as those issues are resolved.*