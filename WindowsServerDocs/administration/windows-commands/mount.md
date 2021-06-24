---
title: mount
description: Reference article for the mount command, which mounts Network File System (NFS) network shares.
ms.topic: reference
ms.assetid: dd9d7ecb-ef00-4aaa-bcd0-423fa636e34a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# mount

A command-line utility that mounts Network File System (NFS) network shares. When used without options or arguments, **mount** displays information about all mounted NFS file systems.

> [!NOTE]
> This utility is available only if **Client for NFS** is installed.

## Syntax

```
mount [-o <option>[...]] [-u:<username>] [-p:{<password> | *}] {\\<computername>\<sharename> | <computername>:/<sharename>} {<devicename> | *}
```

### Parameters

| Parameter  | Description |
| ---------- | ----------- |
| -o rsize=`<buffersize>` | Sets the size in kilobytes of the read buffer. Acceptable values are 1, 2, 4, 8, 16, and 32; the default is 32 KB. |
| -o wsize=`<buffersize>` | Sets the size in kilobytes of the write buffer. Acceptable values are 1, 2, 4, 8, 16, and 32; the default is 32 KB. |
| -o timeout=`<seconds>` | Sets the time-out value in seconds for a remote procedure call (RPC). Acceptable values are 0.8, 0.9, and any integer in the range 1-60; the default is 0.8. |
| -o retry=`<number>` | Sets the number of retries for a soft mount. Acceptable values are integers in the range 1-10; the default is 1. |
| -o mtype=`{soft|hard}` | Sets the mount type for your NFS share. By default, Windows uses a soft mount. Soft mounts time out more easily when there are connection issues; however, to reduce I/O disruption during NFS server reboots, we recommend using a hard mount.|
| -o anon | Mounts as an anonymous user. |
| -o nolock | Disables locking (default is **enabled**). |
| -o casesensitive | Forces file lookups on the server to be case sensitive. |
| -o fileaccess=`<mode>` | Specifies the default permission mode of new files created on the NFS share. Specify *mode* as a three-digit number in the form *ogw*, where *o*, *g*, and *w* are each a digit representing the access granted the file's owner, group, and the world, respectively. The digits must be in the range 0-7, including:<ul><li>**0:** No access</li><li>**1:** x (execute access)</li><li>**2:** w (write access)</li><li>**3:** wx (write and execute access)</li><li>**4:** r (read access)</li><li>**5:** rx (read and execute access)</li><li>**6:** rw (read and write access)</li><li>**7:** rwx (read, write, and execute access)</li></ul> |
| -o lang=`{euc-jp|euc-tw|euc-kr|shift-jis|Big5|Ksc5601|Gb2312-80|Ansi)` | Specifies the language encoding to configure on an NFS share. You can use only one language on the share. This value can include any of the following values:<ul><li>**euc-jp:** Japanese</li><li>**euc-tw:** Chinese</li><li>**euc-kr:** Korean</li><li>**shift-jis:** Japanese</li><li>**Big5:** Chinese</li><li>**Ksc5601:** Korean</li><li>**Gb2312-80:** Simplified Chinese</li><li>**Ansi:** ANSI-encoded</li></ul> |
| -u:`<username>` | Specifies the user name to use for mounting the share. If *username* isn't preceded by a backslash ( **\\** ), it's treated as a UNIX user name. |
| -p:`<password>` | The password to use for mounting the share. If you use an asterisk (**&#42;**), you'll be prompted for the password. |
| `<computername>` | Specifies the name of the NFS server. |
| `<sharename>` | Specifies the name of the file system. |
| `<devicename>` | Specifies the drive letter and name of the device. If you use an asterisk (**&#42;**) this value represents the first available driver letter. |

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
