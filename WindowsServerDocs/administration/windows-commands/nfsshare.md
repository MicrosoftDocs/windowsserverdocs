---
title: nfsshare
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 437a2615-335a-442f-9713-d50d5f3983a3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# nfsshare

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can use **nfsshare** to control Network File System (NFS) shares.
## Syntax
nfsshare <Sharename>=<Drive:path> [-o <Option=value>...]
nfsshare {<Sharename> | <Drive>:<path> | * } /delete
## Description
Without arguments, the **nfsshare** command-line utility lists all Network File System (NFS) shares exported by Server for NFS. With *Sharename* as the only argument, **nfsshare** lists the properties of the NFS share identified by *Sharename*. When *Sharename* and *Drive***:***path* are provided, **nfsshare** exports the folder identified by *Drive***:***path* as *Sharename*. When the **/delete** option is used, the specified folder is no longer made available to NFS clients.
## Options
The **nfsshare** command accepts the following options and arguments:
|Term|Definition|
|----|-------|
|-o anon={yes &#124; no}|Specifies whether anonymous (unmapped) users can access the shared directory. The default is **no**.|
|-o rw[=<Host>[:<Host>]...]|Provides read-write access to the shared directory by the hosts or client groups specified by *Host*. Separate host and group names with a colon (**:**). If *Host* is not specified, all hosts and client groups (except those specified with the **ro** option) have read-write access. If neither the **ro** nor the **rw** option is set, all clients have read-write access to the shared directory.|
|-o ro[=<Host>[:<Host>]...]|Provides read-only access to the shared directory by the hosts or client groups specified by *Host*. Separate host and group names with a colon (**:**). If *Host* is not specified, all clients (except those specified with the **rw** option) have read-only access. If the **ro** option is set for one or more clients, but the **rw** option is not set, only the clients specified with the **ro** option have access to the shared directory.|
|-o encoding={big5&#124;euc-jp&#124;euc-kr&#124;euc-tw&#124;gb2312-80&#124;ksc5601&#124;shift-jis}|Specifies the default encoding used for file and directory names and, if used, must be set to one of the following:<br /><br />-   **big5** (Chinese)<br />-   **euc-jp** (Japanese)<br />-   **euc-kr** (Korean)<br />-   **euc-tw** (Chinese)<br />-   **gb2312-80** (Simplified Chinese)<br />-   **ksc5601** (Korean)<br />-   **shift-jis** (Japanese)<br /><br />if this is option is not set, the default encoding scheme is ANSI or, on systems configured for non-English locales, the default encoding scheme for the locale. The following are the default encoding schemes for the indicated locales:<br /><br />-   Japanese: shift-JIS<br />-   Korean: KS_C_5601-1987<br />-   Simplified Chinese: GB2312-80<br /><br />Traditional Chinese: BIG5|
|-o anongid=<gid>|Specifies that anonymous (unmapped) users will access the share directory using *gid* as their group identifier (GID). The default is -2. The anonymous GID will be used when reporting the owner of a file owned by an unmapped user, even if anonymous access is disabled.|
|-o  anonuid=<uid>|Specifies that anonymous (unmapped) users will access the share directory using *uid* as their user identifier (UID). The default is -2. The anonymous UID will be used when reporting the owner of a file owned by an unmapped user, even if anonymous access is disabled.|
|-o root[=<Host>[:<Host>]...]|Provides root access to the shared directory by the hosts or client groups specified by *Host*. Separate host and group names with a colon (**:**). If *Host* is not specified, all clients have root access. If the **root** option is not set, no clients have root access to the shared directory.|
|/delete|if *Sharename* or *Drive***:***path* is specified, deletes the specified share. If * is specified, deletes all NFS shares.|
> [!NOTE]
> To view the complete syntax for this command, at a command prompt, type:
> 
> **nfsshare /?**
## See Also
[Services for Network File System Command Reference](services-for-network-file-system-command-reference.md)
