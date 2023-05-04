---
title: san
description: Reference article for the san command that displays or sets the storage area network (SAN) policy for the operating system.
ms.topic: reference
ms.author: jgerend
author: JasonGerend
ms.date: 04/01/2023
---

# san

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays or sets the storage area network (san) policy for the operating system. If used without parameters, the current san policy is displayed.

## Syntax

```
san [policy={onlineAll | offlineAll | offlineShared}] [noerr]
```

### Parameters

| Parameter | Description |
|--|--|
| policy={onlineAll\|offlineAll\|offlineShared}] | Sets the san policy for the currently booted operating system. The san policy determines whether a newly discovered disk is brought online or remains offline, and whether it becomes read/write or remains read-only. When a disk is offline, the disk layout can be read, but no volume devices are surfaced through Plug and Play. When offline no file system can be mounted on the disk. When a disk is online, one or more volume devices are installed for the disk. The following parameter can be set:<ul><li>**onlineAll**. Specifies that all newly discovered disks are online and made read/write. **IMPORTANT:** Specifying **onlineAll** on a server that shares disks could lead to data corruption. Therefore, you shouldn't set this policy if disks are shared among servers unless the server is part of a cluster.</li><li>**offlineAll**. Specifies that all newly discovered disks except the startup disk are offline and read-only by default.</li><li>**offlineShared**. Specifies that all newly discovered disks that don't reside on a shared bus (such as SCSI and iSCSI) are brought online and made read-write. Disks that are left offline are read-only by default.</li></ul>For more information, see [VDS_san_POLICY Enumeration](/windows/win32/api/vds/ne-vds-vds_san_policy). |
| noerr | Used for scripting only. When an error is encountered, DiskPart continues to process commands as if the error didn't occur. Without this parameter, an error causes DiskPart to exit with an error code. |

## Examples

To view the current policy, type:

```
san
```

To make all newly discovered disks, except the startup disk, offline and read-only by default, type:

```
san policy=offlineAll
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)