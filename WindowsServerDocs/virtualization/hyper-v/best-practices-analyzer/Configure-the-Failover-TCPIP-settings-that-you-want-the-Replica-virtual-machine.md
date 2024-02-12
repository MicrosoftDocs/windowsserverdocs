---
title: Configure the Failover TCP/IP settings that you want the Replica virtual machine to use in the event of a failover
description: Learn what to do when replica virtual machines configured with a static IP address should be configured to use a different IP address from their primary virtual machine counterpart in the event of failover.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.date: 8/16/2016
---
# Configure the Failover TCP/IP settings that you want the Replica virtual machine to use in the event of a failover

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
*Replica virtual machines configured with a static IP address should be configured to use a different IP address from their primary virtual machine counterpart in the event of failover.*

## Impact
*Clients using the workload supported by the primary virtual machine might not be able to connect to the Replica virtual machine after a failover. Also, the primary virtual machine's original IP address will not be valid in the Replica virtual machine network topology. This impacts the following virtual machines:*

\<list of virtual machines>

## Resolution
*Use Hyper-V Manager to configure the IP address that the Replica virtual machine should use in the event of failover.*
