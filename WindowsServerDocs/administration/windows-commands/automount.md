---
title: automount
description: "Windows Commands topic for **automount** - Enables or disables the automount feature."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4635fc91-a477-4f17-8dcc-aa08854bfe45
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# automount

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Enables or disables the automount feature. When enabled (the default), Windows automatically mounts the file system for a new basic or dynamic volume when it is added to the system, and then assigns a drive letter to the volume.

## Syntax
```
automount [ { enable | disable | scrub } ] [noerr]
```
## Parameters
|Parameter|Description|
|-------|--------|
|enable|Enables Windows to automatically mount new basic and dynamic volumes that are added to the system and to assign them drive letters.|
|disable|Prevents Windows from automatically mounting any new basic and dynamic volumes that are added to the system. **Note:** Disabling automount can cause failover clusters to fail the storage portion of the **Validate a Configuration Wizard**.|
|scrub|removes volume mount point directories and registry settings for volumes that are no longer in the system. This prevents volumes that were previously in the system from being automatically mounted and given their former volume mount point(s) when they are added back to the system.|
|noerr|for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.|
## remarks
-   In storage area network (san) configurations, disabling automount prevents Windows from automatically mounting or assigning drive letters to any new basic volumes that are visible to the system.
## <a name="BKMK_examples"></a>Examples
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

