---
title: Certificate-based authentication is configured, but the specified certificate is not installed on the Replica server or failover cluster nodes
description: Learn what to do when the security certificate that Hyper-V Replica has been configured to use to provide certificate-based replication is not installed on the Replica server (or any failover cluster nodes).
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 4cabbce3-9367-4ddc-a108-1e5e1ab2bcff
ms.date: 8/16/2016
---
# Certificate-based authentication is configured, but the specified certificate is not installed on the Replica server or failover cluster nodes

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016



*For more information about best practices and scans, see* [Best Practices Analyzer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759260(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Error|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue

*The security certificate that Hyper-V Replica has been configured to use to provide certificate-based replication is not installed on the Replica server (or any failover cluster nodes).*

## Impact

*In the event of a cluster failover or move to another node, Hyper-V replication will pause if the new node does not also have the appropriate certificate installed. This impacts the following nodes:*

\<list of nodes>

## Resolution

*Install the configured certificate on the Replica server (and all associated nodes in the failover cluster, if any).*
