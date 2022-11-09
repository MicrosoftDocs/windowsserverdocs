---
title: Compression is recommended for replication traffic
description: Learn what to do when the replication traffic sent across the network from the primary server to the Replica server is uncompressed.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: cf8be6e9-2909-4e4a-bb63-d1e1ebbc6930
ms.date: 8/16/2016
---
# Compression is recommended for replication traffic

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
*The replication traffic sent across the network from the primary server to the Replica server is uncompressed.*

## Impact
*Replication traffic will use more bandwidth than necessary. This impacts the following virtual machines:*

\<list of virtual machines>

## Resolution
*Configure Hyper-V Replica to compress the data transmitted over the network in the settings for the virtual machine in Hyper-V Manager. You can also use tools outside of Hyper-V to perform compression.*
