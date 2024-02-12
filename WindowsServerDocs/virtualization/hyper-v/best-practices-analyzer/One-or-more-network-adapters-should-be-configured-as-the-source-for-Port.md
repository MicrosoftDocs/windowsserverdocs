---
title: One or more network adapters should be configured as the source for Port Mirroring
description: Learn what to do when one or more virtual machines have a network adapter configured as a destination for Port Mirroring, but there is no corresponding source on the virtual switch.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 147fd00f-1440-44d1-94e3-3a8af63aa7ed
ms.date: 8/16/2016
---
# One or more network adapters should be configured as the source for Port Mirroring

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
*One or more virtual machines have a network adapter configured as a destination for Port Mirroring, but there is no corresponding source on the virtual switch.*

## **Impact**
*Port Mirroring will not operate correctly for the following virtual switches and virtual machines:*

\<list of virtual machines>

## **Resolution**
*Use Windows PowerShell or Hyper-V Manager to complete or correct the Port Mirroring configuration.*
