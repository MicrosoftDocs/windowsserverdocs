---
title: Test failovers should be carried out at least monthly to verify that failover will succeed and that virtual machine workloads will operate as expected after failover
description: Learn what to do when there has been no test failover in at least one month.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 57a8aa50-e59e-4a4b-8571-1099d5a8eee4
ms.date: 8/16/2016
---
# Test failovers should be carried out at least monthly to verify that failover will succeed and that virtual machine workloads will operate as expected after failover

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Operations|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue
*There has been no test failover in at least one month.*

## Impact
*There is no confirmation that a planned or unplanned failover will succeed or workload operations will continue properly after a failover. This impacts the following virtual machines:*

\<list of virtual machines>

## Resolution
*Use Hyper-V Manager to conduct a test failover.*
