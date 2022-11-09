---
title: A team bound to a virtual switch should only have one exposed team interface
description: Learn what to do when one or more virtual switches are bound to a team that has multiple team interfaces.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 1074f086-1a2e-42e1-b58c-f55e657d5ce1
ms.date: 8/16/2016
---
# A team bound to a virtual switch should only have one exposed team interface

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
*One or more virtual switches are bound to a team that has multiple team interfaces.*

## Impact
*The following virtual switches might not have access to VLANs and bandwidth used by other team interfaces:*

\<list of virtual switches>

## Resolution
*Use the Windows PowerShell cmdlet Remove-NetLbfoTeamNic to remove all team interfaces from the team other than the default team interface.*
