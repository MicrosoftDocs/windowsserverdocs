---
title: To participate in replication, servers in failover clusters must have a Hyper-V Replica Broker configured
description: Learn what to do when for failover clusters, Hyper-V Replica requires the use of a Hyper-V Replica Broker name instead of an individual server name.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 5ec88ce5-a8b2-4ece-9062-366523c8b17f
ms.date: 8/16/2016
---
# To participate in replication, servers in failover clusters must have a Hyper-V Replica Broker configured

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
*For failover clusters, Hyper-V Replica requires the use of a Hyper-V Replica Broker name instead of an individual server name.*

## Impact
*If the virtual machine is moved to a different failover cluster node, replication cannot continue.*

## Resolution
*Use Failover Cluster Manager to configure the Hyper-V Replica Broker. In Hyper-V Manager, ensure that the replication configuration uses the Hyper-V Replica Broker name as the server name.*
