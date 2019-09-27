---
title: diskperf
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f06916e8-069b-4ec8-a6eb-59f1d9f77111
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# diskperf



In Windows 2000, physical and logical disk performance counters are not enabled by default.

**Diskperf** is included in Windows XP, Windows Server 2003, Windows Server 2008, Windows Vista, Windows Server 2008 R2, and Windows 7 so that it can be used to remotely enable or disable physical or logical disk performance counters on computers running Windows 2000.

## Syntax

```
diskperf [-Y[D|V] | -N[D|V]] [\\computername]
```

## Options

|Option|Description|
|------|-----------|
|-?|Displays context sensitive help.|
|-Y|Start all disk performance counters when the computer restarts.|
|-YD|Enable disk performance counters for physical drives when the computer restarts.|
|-YV|Enable disk performance counters for logical drives or storage volumes when the computer restarts.|
|-N|Disable all disk performance counters when the computer restarts.|
|-ND|Disable disk performance counters for physical drives when the computer restarts.|
|-NV|Disable disk performance counters for logical drives or storage volumes when the computer restarts.|
|\\\\*\<computername>*|Specify the name of the computer where you want to enable or disable disk performance counters.|