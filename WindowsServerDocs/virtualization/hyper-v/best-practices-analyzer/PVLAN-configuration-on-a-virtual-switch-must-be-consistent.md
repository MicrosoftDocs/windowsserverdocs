---
title: PVLAN configuration on a virtual switch must be consistent
description: Learn what to do when the Private Virtual Local Area Network (PVLAN) is not configured correctly on one or more virtual network adapters.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 4db63bcc-7a54-4f19-98a6-c274c3956d51
ms.date: 8/16/2016
---
# PVLAN configuration on a virtual switch must be consistent

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

For more information about best practices and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831400(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Error|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## **Issue**
*Private Virtual Local Area Network (PVLAN) is not configured correctly on one or more virtual network adapters.*

## **Impact**
*PVLAN might not isolate network traffic between virtual machines correctly.*

## **Resolution**
*Use the Windows PowerShell cmdlet, Set-VMNetworkAdapterVlan, to configure PVLAN correctly.*
