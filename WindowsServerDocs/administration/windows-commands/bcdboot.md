---
title: bcdboot
description: "Windows Commands topic for **bcdboot** - Quickly set up a system partition, or repair the boot environment located on the system partition."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e62a250e-08e9-47f6-89d1-e6002560ab57
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# bcdboot

> Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables you to quickly set up a system partition, or to repair the boot environment located on the system partition. The system partition is set up by copying a simple set of Boot Configuration Data (BCD) files to an existing empty partition.

For more information about BCDboot, including information on where to find BCDboot and examples of how to use this command, see the [BCDboot Command-Line Options](http://technet.microsoft.com/library/hh824874.aspx) topic.

## Syntax

```
bcdboot <source> [/l] [/s]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|source|Specifies the location of the Windows directory to use as the source for copying boot environment files.|
|/l|Specifies the locale. The default locale is US English.|
|/s|Specifies the volume letter of the system partition. The default is the system partition identified by the firmware.|

## <a name="BKMK_examples"></a>Examples

For more examples of how to use this command, see the [BCDboot Command-Line Options](http://technet.microsoft.com/library/hh824874.aspx) topic.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)