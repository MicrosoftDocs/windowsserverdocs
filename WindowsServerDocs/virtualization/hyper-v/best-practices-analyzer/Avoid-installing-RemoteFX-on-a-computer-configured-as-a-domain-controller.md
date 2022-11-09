---
title: Avoid installing RemoteFX on a computer that is configured as an Active Directory domain controller
description: Learn what to do when RemoteFX is installed on a domain controller.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: da58694e-91f6-45d8-a599-18966db165f4
ms.date: 8/16/2016
---
# Avoid installing RemoteFX on a computer that is configured as an Active Directory domain controller

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
*RemoteFX is installed on a domain controller.*

## **Impact**
*Virtual computers configured for RemoteFX cannot be used on these computers.*

## **Resolution**
*Decide if you want this server to be configured either with RemoteFX for Hyper-V or as an Active Directory Domain Controller, then reconfigure the server as necessary.*
