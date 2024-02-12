---
title: Certificate-based authentication is recommended for replication
description: Learn what to do when one or more virtual machines selected for replication are configured for Kerberos authentication.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: d931cc57-414f-4bdf-9ebd-08fd5e22b19d
ms.date: 8/16/2016
---
# Certificate-based authentication is recommended for replication

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
*One or more virtual machines selected for replication are configured for Kerberos authentication.*

## **Impact**
*The replication network traffic from the primary server to the replication server is unencrypted. This impacts the following virtual machines:*

\<list of virtual machines>

## **Resolution**
*If another method is being used to perform encryption, you can ignore this. Otherwise, modify the virtual machine settings to choose certificate-based authentication.*
