---
title: Ensure that all mandatory virtual switch extensions are available
description: Learn what to do when one or more virtual network adapters are connected to a virtual switch with mandatory extensions that are disabled or not installed.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: 2f2f2698-f5ec-4cad-aa64-d6987e8142a1
ms.date: 8/16/2016
---
# Ensure that all mandatory virtual switch extensions are available

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
*One or more virtual network adapters are connected to a virtual switch with mandatory extensions that are disabled or not installed.*

## Impact
*Network traffic is blocked on one or more virtual network adapters on the following virtual machines:*

\<list of virtual machines>

## Resolution
*First, make sure that the mandatory extension has been installed on the host and install the extension if necessary. Then, if the mandatory extension is disabled, use Virtual Switch Manager or the Windows PowerShell cmdlet Enable-VMSwitchExtension to enable the extension.*
