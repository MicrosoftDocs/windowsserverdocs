---
title: nfsshare
description: Reference article for the nfsshare command, which controls Network File System (NFS) shares.
ms.topic: reference
ms.assetid: 437a2615-335a-442f-9713-d50d5f3983a3
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# nfsshare

Controls Network File System (NFS) shares. Used without parameters, this command displays all Network File System (NFS) shares exported by Server for NFS.

## Syntax

```
nfsshare <sharename>=<drive:path> [-o <option=value>...]
nfsshare {<sharename> | <drive>:<path> | * } /delete
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -o anon=`{yes|no}` | Specifies whether anonymous (unmapped) users can access the share directory. |
| -o rw=`[<host>[:<host>]...]` | Provides read-write access to the shared directory by the hosts or client groups specified by *host*. You must separate host and group names with a colon (**:**). If *host* isn't specified, all hosts and client groups (except those specified with the **ro** option) get read-write access. If neither the **ro** nor the **rw** option is set, all clients have read-write access to the shared directory. |
| -o ro=`[<host>[:<host>]...]` | Provides read-only access to the shared directory by the hosts or client groups specified by *host*. You must separate host and group names with a colon (**:**). If *host* isn't specified, all clients (except those specified with the **rw** option) get read-only access. If the **ro** option is set for one or more clients, but the **rw** option isn't set, only the clients specified with the **ro** option have access to the shared directory. |
| -o encoding=`{euc-jp|euc-tw|euc-kr|shift-jis|Big5|Ksc5601|Gb2312-80|Ansi)` | Specifies the language encoding to configure on an NFS share. You can use only one language on the share. This value can include any of the following values:<ul><li>**euc-jp:** Japanese</li><li>**euc-tw:** Chinese</li><li>**euc-kr:** Korean</li><li>**shift-jis:** Japanese</li><li>**Big5:** Chinese</li><li>**Ksc5601:** Korean</li><li>**Gb2312-80:** Simplified Chinese</li><li>**Ansi:** ANSI-encoded</li></ul> |
| -o anongid=`<gid>` | Specifies that anonymous (unmapped) users access the share directory using *gid* as their group identifier (GID). The default is **-2**. The anonymous GID is used when reporting the owner of a file owned by an unmapped user, even if anonymous access is disabled. |
| -o  anonuid=`<uid>` | Specifies that anonymous (unmapped) users access the share directory using *uid* as their user identifier (UID). The default is **-2**. The anonymous UID is used when reporting the owner of a file owned by an unmapped user, even if anonymous access is disabled. |
| -o root=`[<host>[:<host>]...]` | Provides root access to the shared directory by the hosts or client groups specified by *host*. You must separate host and group names with a colon (**:**). If *host* isn't specified, all clients get root access. If the **root** option isn't set, no clients have root access to the shared directory. |
| /delete | If *sharename* or `<drive>:<path>` is specified, this parameter deletes the specified share. If a wildcard (*) is specified, this parameter deletes all NFS shares. |
| /? | Displays help at the command prompt. |

#### Remarks

- If *sharename* as the only parameter, this command lists the properties of the NFS share identified by *sharename*.

- If *sharename* and `<drive>:<path>` are used, this command exports the folder identified by `<drive>:<path>` as *sharename*. If you use the **/delete** option, the specified folder stops being available to NFS clients.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [Services for Network File System Command Reference](services-for-network-file-system-command-reference.md)

- [NFS cmdlets reference](/powershell/module/nfs)
