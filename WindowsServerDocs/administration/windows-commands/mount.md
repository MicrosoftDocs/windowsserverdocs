---
title: mount
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: dd9d7ecb-ef00-4aaa-bcd0-423fa636e34a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# mount



You can use **mount** to mount Network File System (NFS) network shares.

## Syntax

```
mount [-o <Option>[...]] [-u:<UserName>] [-p:{<Password> | *}] {\\<ComputerName>\<ShareName> | <ComputerName>:/<ShareName>} {<DeviceName> | *}
```

## Description

The **mount** command-line utility mounts the file system identified by *ShareName* exported by the NFS server identified by *ComputerName* and associates it with the drive letter specified by *DeviceName* or, if an asterisk (**&#42;**) is used, by the first available driver letter. Users can then access the exported file system as though it were a drive on the local computer. When used without options or arguments, **mount** displays information about all mounted NFS file systems.

The **mount** utility is available only if Client for NFS is installed.

The following options and arguments can be used with the **mount** utility.


|          Term          |                                                                                                                                                                                                                                                Definition                                                                                                                                                                                                                                                |
|------------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| -o rsize=\<buffersize> |                                                                                                                                                                                            Sets the size in kilobytes of the read buffer. Acceptable values are 1, 2, 4, 8, 16, and 32; the default is 32 KB.                                                                                                                                                                                            |
| -o wsize=\<buffersize> |                                                                                                                                                                                           Sets the size in kilobytes of the write buffer. Acceptable values are 1, 2, 4, 8, 16, and 32; the default is 32 KB.                                                                                                                                                                                            |
| -o timeout=\<seconds>  |                                                                                                                                                                       Sets the time-out value in seconds for a remote procedure call (RPC). Acceptable values are 0.8, 0.9, and any integer in the range 1-60; the default is 0.8.                                                                                                                                                                       |
|   -o retry=\<number>   |                                                                                                                                                                                             Sets the number of retries for a soft mount. Acceptable values are integers in the range 1-10; the default is 1.                                                                                                                                                                                             |
|     -o mtype={soft     |                                                                                                                                                                                                                                                  hard}                                                                                                                                                                                                                                                   |
|        -o anon         |                                                                                                                                                                                                                                       Mounts as an anonymous user.                                                                                                                                                                                                                                       |
|       -o nolock        |                                                                                                                                                                                                                                Disables locking (default is **enabled**).                                                                                                                                                                                                                                |
|    -o casesensitive    |                                                                                                                                                                                                                         Forces file lookups on the server to be case sensitive.                                                                                                                                                                                                                          |
| -o fileaccess=\<mode>  | Specifies the default permission mode of new files created on the NFS share. Specify *mode* as a three-digit number in the form *ogw*, where *o*, *g*, and *w* are each a digit representing the access granted the file's owner, group, and the world, respectively. The digits must be in the range 0-7 with the following meaning:</br>-   0: No access</br>-   1: x (execute access)</br>-   2: w (write access)</br>-   3: wx</br>-   4: r (read access)</br>-   5: rx</br>-   6: rw</br>-   7: rwx |
|    -o lang={euc-jp     |                                                                                                                                                                                                                                                  euc-tw                                                                                                                                                                                                                                                  |
|     -u:\<UserName>     |                                                                                                                                                                             Specifies the user name to use for mounting the share. If *username* is not preceded by a backslash (**\\**), it is treated as a UNIX user name.                                                                                                                                                                             |
|     -p:\<Password>     |                                                                                                                                                                                          The password to use for mounting the share. If you use an asterisk (**&#42;**), you will be prompted for the password.                                                                                                                                                                                          |

> [!NOTE]
