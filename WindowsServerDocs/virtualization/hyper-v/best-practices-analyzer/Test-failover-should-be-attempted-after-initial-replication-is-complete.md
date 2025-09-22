---
title: Test failover should be attempted after initial replication is complete
description: Learn what to do when there has been no test failover after the initial replication is complete.
ms.author: mosagie
author: meaghanlewis
ms.topic: best-practice
ms.date: 8/16/2016
---
# Test failover should be attempted after initial replication is complete

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Operations|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Problem
*There has been no test failover in at least one month.*

## Impact
*There is no confirmation that a planned or unplanned failover will succeed or workload operations will continue properly after a failover. This impacts the following virtual machines:*

\<list of virtual machines>

## Resolution
*Use Hyper-V Manager to conduct a test failover.*
