---
title: automount
description: Reference article for the automount command, which enables or disables the automount feature.
ms.topic: reference
ms.assetid: 4635fc91-a477-4f17-8dcc-aa08854bfe45
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# automount

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

- [Command-Line Syntax Key](command-line-syntax-key.md)

> [!IMPORTANT]
> In storage area network (SAN) configurations, disabling automount prevents Windows from automatically mounting or assigning drive letters to any new basic volumes that are visible to the system.

## Syntax

automount [ { enable | disable | scrub } ] [noerr]

### Parameters

| Parameter | Description |
| --------- | ----------- |
| enable | Enables Windows to automatically mount new basic and dynamic volumes that are added to the system and to assign them drive letters. |
| disable | Prevents Windows from automatically mounting any new basic and dynamic volumes that are added to the system.<p>**Note**: Disabling automount can cause failover clusters to fail the storage portion of the Validate a Configuration Wizard. |
| scrub | Removes volume mount point directories and registry settings for volumes that are no longer in the system. This prevents volumes that were previously in the system from being automatically mounted and given their former volume mount point(s) when they are added back to the system. |
| noerr | For scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To see if the automount feature is enabled, type the following commands from within the diskpart command:

```
automount
```

To enable the automount feature, type:

```
automount enable
```

To disable the automount feature, type:

```
automount disable
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [diskpart commands](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc770877(v%3dws.11))
