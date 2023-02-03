---
title: import diskshadow
description: Reference article for the import command, which imports a transportable shadow copy from a loaded metadata file into the system.
ms.topic: reference
ms.assetid: 7bd78d76-0560-4d47-944c-fe960be2c10b
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# import (diskshadow)

Imports a transportable shadow copy from a loaded metadata file into the system.

> [IMPORTANT]
> Before you can use this command, you must use the [load metadata command](load-metadata.md) to load a DiskShadow metadata file.

## Syntax

```
import
```

#### Remarks

- Transportable shadow copies aren't stored on the system immediately. Their details are stored in a Backup Components Document XML file, which DiskShadow automatically requests and saves in a .cab metadata file in the working directory. Use the [set metadata command](set-metadata.md) to change the path and name of this XML file.

## Examples

The following is a sample DiskShadow script that demonstrates the use of the **import** command:

```
#Sample DiskShadow script demonstrating IMPORT
SET CONTEXT PERSISTENT
SET CONTEXT TRANSPORTABLE
SET METADATA transHWshadow_p.cab
#P: is the volume supported by the Hardware Shadow Copy provider
ADD VOLUME P:
CREATE
END BACKUP
#The (transportable) shadow copy is not in the system yet.
#You can reset or exit now if you wish.

LOAD METADATA transHWshadow_p.cab
IMPORT
#The shadow copy will now be loaded into the system.
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [diskshadow command](diskshadow.md)