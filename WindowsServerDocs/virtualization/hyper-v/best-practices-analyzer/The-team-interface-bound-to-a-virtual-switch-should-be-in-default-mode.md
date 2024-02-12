---
title: The team interface bound to a virtual switch should be in default mode
description: Learn what to do when some virtual switches are bound to a team interface but the team interface doesn't pass traffic on all VLANs to the virtual switches.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 8c118e1e-865f-4cff-acdc-7c35e45d5da9
ms.date: 8/16/2016
---
# The team interface bound to a virtual switch should be in default mode

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
*Some virtual switches are bound to a team interface but the team interface doesn't pass traffic on all VLANs to the virtual switches.*

## **Impact**
*The following virtual switches cannot have access to all VLANs: \n{0}*

## **Resolution**
*Use Server Manager or the Windows PowerShell cmdlet Set-NetLbfoTeamNic to reset the team interface to the default mode.*
