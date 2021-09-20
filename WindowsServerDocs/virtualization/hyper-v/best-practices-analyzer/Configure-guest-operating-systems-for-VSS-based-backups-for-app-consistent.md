---
title: Configure guest operating systems for VSS-based backups to enable application-consistent snapshots for Hyper-V Replica
description: Learn what to do when Application-consistent snapshots require that Volume Shadow Copy Services (VSS) is enabled and configured in the guest operating systems of virtual machines participating in replication. 
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 7638e996-d42d-47b8-a670-1e09e7183850
ms.date: 8/16/2016
---
# Configure guest operating systems for VSS-based backups to enable application-consistent snapshots for Hyper-V Replica

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Error|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue
*Application-consistent snapshots requires that Volume Shadow Copy Services (VSS) is enabled and configured in the guest operating systems of virtual machines participating in replication.*

## Impact
*Even if application-consistent snapshots are specified in the replication configuration, Hyper-V will not use them unless VSS is configured. This impacts the following virtual machines:*

\<list of virtual machines>

## Resolution
*Use Virtual Machine Connection to install integration services in the virtual machine.*
