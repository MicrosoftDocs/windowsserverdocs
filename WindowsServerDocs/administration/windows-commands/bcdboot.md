---
title: bcdboot
description: Reference article for the bcdboot command, which quickly set up a system partition, or repair the boot environment located on the system partition.
ms.topic: reference
ms.assetid: e62a250e-08e9-47f6-89d1-e6002560ab57
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# bcdboot

Enables you to quickly set up a system partition, or to repair the boot environment located on the system partition. The system partition is set up by copying a simple set of Boot Configuration Data (BCD) files to an existing empty partition.

## Syntax

```
bcdboot <source> [/l] [/s]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| source | Specifies the location of the Windows directory to use as the source for copying boot environment files. |
| /l | Specifies the locale. The default locale is US English. |
| /s | Specifies the volume letter of the system partition. The default is the system partition identified by the firmware. |

## Examples

For information about where to find BCDboot and examples of how to use this command, see the [BCDboot Command-Line Options](/previous-versions/windows/it-pro/windows-8.1-and-8/hh824874(v=win.10)) topic.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
