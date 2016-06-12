---
title: bcdboot
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e62a250e-08e9-47f6-89d1-e6002560ab57
---
# bcdboot
Enables you to quickly set up a system partition, or to repair the boot environment located on the system partition. The system partition is set up by copying a simple set of Boot Configuration Data \(Bcd\) files to an existing empty partition.

for more information about bcdboot, including information on where to find bcdboot and examples of how to use this command, see the [bcdboot Command\-Line Options](http://technet.microsoft.com/library/hh824874.aspx) topic.

## Syntax

```
bcdboot <source> [/l] [/s]
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|source|Specifies the location of the Windows directory to use as the source for copying boot environment files.|
|\/l|Specifies the locale. The default locale is US English.|
|\/s|Specifies the volume letter of the system partition. The default is the system partition identified by the firmware.|

## <a name="BKMK_examples"></a>Examples
for more examples of how to use this command, see the [bcdboot Command\-Line Options](http://technet.microsoft.com/library/hh824874.aspx) topic.

#### additional references
[Command-Line Syntax Key](commandline-syntax-key.md)


