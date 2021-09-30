---
title: Authorization entries should have distinct trust group names for primary servers with virtual machines that are not part of the same trust group
description: Learn what to do when the server will accept replication requests for the replica virtual machine from any of the servers in the authorization list associated with the same replication tag as the virtual machine.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 8827a3a7-9f3c-4f51-826a-8e2ec43e01df
ms.date: 8/16/2016
---
# Authorization entries should have distinct trust group names for primary servers with virtual machines that are not part of the same trust group

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## **Issue**
*The server will accept replication requests for the replica virtual machine from any of the servers in the authorization list associated with the same replication tag as the virtual machine.*

## **Impact**
*There might be privacy and security concerns with a virtual machine accepting replication from primary servers belonging to different authorization entries. This impacts the following authorization entries: \<list of authorization entries>*

## **Resolution**
*Use different tags in the authorization entries for primary servers with virtual machines that are not part of the same security group. Modify the Hyper-V settings to configure the replication tags.*
