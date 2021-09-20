---
title: Ensure that the virtual function driver operates correctly when a virtual machine is configured to use SR-IOV
description: Learn what to do when the virtual function driver is not operating correctly in the guest operating system of one or more virtual machines.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: d21e4b93-29bf-423a-a635-71c6d48dc49e
ms.date: 8/16/2016
---
# Ensure that the virtual function driver operates correctly when a virtual machine is configured to use SR-IOV

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
*The virtual function driver is not operating correctly in the guest operating system of one or more virtual machines.*

## Impact
*Networking performance is not optimal on the following virtual machines:*

\<list of virtual machines>

## Resolution
*In the guest operating system, do the following: Verify that appropriate drivers are installed and all networking devices are enabled, and check the Event log for errors or warnings.*
