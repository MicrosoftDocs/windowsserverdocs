---
title: san
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d57c2df1-eb82-4b81-b8cd-e30564c6a929
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# san

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays or sets the storage area network (san) policy for the operating system.
> [!NOTE]
> This command is only applicable to Windows 7 and Windows Server 2008 R2.

## Syntax
```
san [policy={onlineAll | offlineAll | offlineShared}] [noerr]
```
### Parameters

|                          Parameter                           |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           Description                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            |
|--------------------------------------------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| policy={ onlineAll &#124; offlineAll &#124; offlineShared }] | Sets the san policy for the currently booted operating system. The san policy determines whether a newly discovered disk is brought online or remains offline, and whether it becomes read/write or remains read-only. When a disk is offline, the disk layout can be read, but no volume devices are surfaced through Plug and Play. This means that no file system can be mounted on the disk. When a disk is online, one or more volume devices are installed for the disk. The following is an explanation of each parameter:<br /><br />-   **onlineAll**. Specifies that all newly discovered disks will be brought online and made read/write. **IMPORTANT:**     Specifying **onlineAll** on a server that shares disks could lead to data corruption. Therefore, you should not set this policy if disks are shared among servers unless the server is part of a cluster.<br />-   **offlineAll**. Specifies that all newly discovered disks except the startup disk will be offline andread-only by default.<br />-   **offlineShared**. Specifies that all newly discovered disks that do not reside on a shared bus (such as SCSI and iSCSI) are brought online and made read-write. Disks that are left offline will be read-only by default.<br /><br />for more information, see [VDS_san_POLICY Enumeration](https://go.microsoft.com/fwlink/?LinkId=203815) (<https://go.microsoft.com/fwlink/?LinkId=203815>). |
|                            noerr                             |                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            Used for scripting only. When an error is encountered, DiskPart continues to process commands as if the error did not occur. Without this parameter, an error causes DiskPart to exit with an error code.                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             |

## Remarks
- if the command is given with no parameters, the current san policy is displayed.
  ## <a name="BKMK_Examples"></a>Examples
  To view the current policy, type:
  ```
  san
  ```
  To make all newly discovered disks, except the startup disk, offline and read-only by default, type:
  ```
  san policy=offlineAll
  ```
  ## additional references
- [Command-Line Syntax Key](command-line-syntax-key.md)
