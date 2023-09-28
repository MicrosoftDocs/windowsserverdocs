---
title: mount
description: Reference article for the mount command, which mounts Network File System (NFS) network shares.
ms.topic: reference
ms.assetid: dd9d7ecb-ef00-4aaa-bcd0-423fa636e34a
ms.author: wscontent
author: xelu86
ms.date: 09/27/2023
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
| -o lang=`{euc-jp|euc-tw|euc-kr|shift-jis|Big5|Ksc5601|Gb2312-80|Ansi}` | Specifies the language encoding to configure on an NFS share. You can use only one language on the share. This value can include any of the following values:<ul><li>**euc-jp:** Japanese</li><li>**euc-tw:** Chinese</li><li>**euc-kr:** Korean</li><li>**shift-jis:** Japanese</li><li>**Big5:** Chinese</li><li>**Ksc5601:** Korean</li><li>**Gb2312-80:** Simplified Chinese</li><li>**Ansi:** ANSI-encoded</li></ul> |
| -o fileaccess=`<mode>` | Specifies the default permission mode of new files created on the NFS share. Specify *mode* as a three-digit number in the form *ogw*, where *o*, *g*, and *w* are each a digit representing the access granted the file's owner, group, and the world, respectively. The digits must be in the range 0-7, including:<ul><li>**0:** No access</li><li>**1:** x (execute access)</li><li>**2:** w (write access)</li><li>**3:** wx (write and execute access)</li><li>**4:** r (read access)</li><li>**5:** rx (read and execute access)</li><li>**6:** rw (read and write access)</li><li>**7:** rwx (read, write, and execute access)</li></ul> |
| -o anon | Mounts as an anonymous user. |
| -o nolock | Disables locking (default is **enabled**). |
| -o casesensitive | Forces file lookups on the server to be case sensitive. |
| -o sec=`{sys|krb5|krb5i|krb5p}`| Specifies the security mechanism for mounting an NFS share. This value can include any of the following:<ul><li>**sec=sys:** No authentication or security checks are performed. Data transfers aren't encrypted. </li><li>**sec=krb5:** Specifies Kerberos authentication for mounting the NFS share. </li><li>**sec=krb5i:** Extends Kerberos security by adding data integrity checks between the client and server hasn't been tampered. </li><li>**sec=krb5p:** Enhances Kerberos security by enabling data privacy, which encrypts data exchanged between the client and server. |
| -u:`<username>` | Specifies the user name to use for mounting the share. If *username* isn't preceded by a backslash ( **\\** ), it's treated as a UNIX user name. |
| -p:`<password>` | The password to use for mounting the share. If you use an asterisk (**&#42;**), you're prompted for the password. |
| `<computername>` | Specifies the name of the NFS server. |
| `<sharename>` | Specifies the name of the file system. |
| `<devicename>` | Specifies the drive letter and name of the device. If you use an asterisk (**&#42;**) this value represents the first available driver letter. |

### Examples

To mount the NFS share anonymously on network drive Z, type:

```cmd
mount -o anon \\ServerIP\ShareName Z:
```

> [!NOTE]
> In order for this parameter to function as intended, the NFS server must allow anonymous access.

To mount the NFS share and disable file locking for network drive Z, type:

```cmd
mount -o nolock \\ServerIP\ShareName Z:
```

To mount the NFS share with permissions for the *ogw* set as rwx, rw, r, and to continuously reconnect to the NFS server if the connection is lost for network drive Z, type:

```cmd
mount -o fileaccess=764 mtype=hard \\ServerIP\ShareName Z:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
