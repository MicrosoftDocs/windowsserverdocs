---
title: Configure the server with a sufficient amount of dynamic MAC addresses
description: Learn what to do when the number of available dynamic MAC addresses is low.
ms.author: benarm
author: BenjaminArmstrong
ms.topic: article
ms.assetid: a2804519-9790-4006-80b6-e990a8f505fe
ms.date: 8/16/2016
---
# Configure the server with a sufficient amount of dynamic MAC addresses

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

*This topic is intended to address a specific issue identified by a Best Practices Analyzer scan. You should apply the information in this topic only to computers that have had the Hyper-V Best Practices Analyzer run against them and are experiencing the issue addressed by this topic. For more information about best practices and scans, see* [Best Practices Analyzer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759260(v=ws.11)).

|Property|Details|
|-|-|
|**Operating System**|Windows Server 2016|
|**Product/Feature**|Hyper-V|
|**Severity**|Warning|
|**Category**|Configuration|

In the following sections, italics indicates UI text that appears in the Best Practices Analyzer tool for this issue.

## Issue

*The number of available dynamic MAC addresses is low.*

## Impact

*When no dynamic MAC addresses are available, virtual machines configured to use a dynamic MAC address cannot be started.*

## Resolution

*Use Virtual Switch Manager to view and extend the range of dynamic addresses.*
