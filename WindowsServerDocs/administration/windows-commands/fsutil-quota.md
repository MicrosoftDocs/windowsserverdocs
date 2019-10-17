---
ms.assetid: 21225c11-7c72-4ea2-96bd-e63d4beb3be5
title: Fsutil quota
ms.prod: windows-server
manager: dmoss
ms.author: toklima
author: toklima
ms.technology: storage
audience: "IT Pro"
ms.topic: article
ms.date: 10/16/2017
---
# Fsutil quota
>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows 7

Manages disk quotas on NTFS volumes to provide more precise control of network-based storage.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
fsutil quota [disable] <VolumePath>
fsutil quota [enforce] <VolumePath>
fsutil quota [modify] <VolumePath> <Threshold> <Limit> <UserName>
fsutil quota [query] <VolumePath>
fsutil quota [track] <VolumePath>
fsutil quota [violations]
```

## Parameters

|   Parameter   |                                                                                    Description                                                                                    |
|---------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    disable    |                                                         Disables quota tracking and enforcement on the specified volume.                                                          |
|    enforce    |                                                                   Enforces quota usage on the specified volume.                                                                   |
|    modify     |                                                              Modifies an existing disk quota or creates a new quota.                                                              |
|     query     |                                                                            Lists existing disk quotas.                                                                            |
|     track     |                                                                    Tracks disk usage on the specified volume.                                                                     |
|  violations   | Searches the system and application logs and displays a message to indicate that quota violations have been detected or that a user has reached a quota threshold or quota limit. |
| \<VolumePath> |                                  Required. Specifies the drive name followed by a colon or the GUID in the format **Volume{**<em>GUID</em>**}**.                                  |
| \<Threshold>  |                            Sets the limit (in bytes) at which warnings are issued. This parameter is required for the **fsutil quota modify** command.                            |
|   \<Limit>    |                                Sets the maximum allowed disk usage (in bytes). This parameter is required for the **fsutil quota modify** command.                                |
|  \<UserName>  |                                      Specifies the domain or user name. This parameter is required for the **fsutil quota modify** command.                                       |

## Remarks

-   Disk quotas are implemented on a per-volume basis, and they enable both hard and soft storage limits to be implemented on a per-user basis.

-   You can use write scripts that use **fsutil quota** to set the quota limits every time you add a new user or to automatically track quota limits, compile them into a report, and automatically send them to the system administrator in e-mail.

### <a name="BKMK_examples"></a>Examples
To list existing disk quotas for a disk volume that is specified with the GUID, {928842df-5a01-11de-a85c-806e6f6e6963}, type:

```
fsutil quota query Volume{928842df-5a01-11de-a85c-806e6f6e6963}
```

To list existing disk quotas for a disk volume that is specified with the drive letter, **C:**, type:

```
Fsutil quota query C:
```

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Fsutil](Fsutil.md)


