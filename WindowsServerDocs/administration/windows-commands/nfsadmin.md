---
title: nfsadmin
description: Reference article for the nfsadmin command, which manages both Server for NFS and Client for NFS.
ms.topic: reference
ms.assetid: 7375b2cf-c6b8-45b5-abf6-6c10e462defd
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# nfsadmin

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

A command-line utility that administers Server for NFS or Client for NFS on the local or remote computer running Microsoft Services for Network File System (NFS). Used without parameters, nfsadmin server displays the current Server for NFS configuration settings and nfsadmin client displays the current Client for NFS configuration settings.

## Syntax

```
nfsadmin server [computername] [-u Username [-p Password]] -l
nfsadmin server [computername] [-u Username [-p Password]] -r {client | all}
nfsadmin server [computername] [-u Username [-p Password]] {start | stop}
nfsadmin server [computername] [-u Username [-p Password]] config option[...]
nfsadmin server [computername] [-u Username [-p Password]] creategroup <name>
nfsadmin server [computername] [-u Username [-p Password]] listgroups
nfsadmin server [computername] [-u Username [-p Password]] deletegroup <name>
nfsadmin server [computername] [-u Username [-p Password]] renamegroup <oldname> <newname>
nfsadmin server [computername] [-u Username [-p Password]] addmembers <hostname>[...]
nfsadmin server [computername] [-u Username [-p Password]] listmembers
nfsadmin server [computername] [-u Username [-p Password]] deletemembers <hostname><groupname>[...]
nfsadmin client [computername] [-u Username [-p Password]] {start | stop}
nfsadmin client [computername] [-u Username [-p Password]] config option[...]
```

### General Parameters

| Parameter | Description |
| --------- | ----------- |
| computername | Specifies the remote computer you want to administer. You can specify the computer using a Windows Internet Name Service (WINS) name or a Domain Name System (DNS) name, or by Internet Protocol (IP) address. |
| -u Username | Specifies the user name of the user whose credentials are to be used. It might be necessary to add the domain name to the user name in the form *domain\username*. |
| -p Password | Specifies the password of the user specified using the **-u** option. If you specify the **-u** option but omit the **-p** option, you are prompted for the user's password. |

### Server for NFS-related parameters

| Parameter | Description |
| --------- | ----------- |
| -l | Lists all locks held by clients. |
| -r `{client|all}` | Releases the locks held by a client or, if all is specified, by all clients. |
| start | Starts the Server for NFS service. |
| stop | Stops the Server for NFS service. |
| config | Specifies general settings for Server for NFS. You must supply at least one of the following options with the **config** command argument:<ul><li>**mapsvr=`<server>`** - Sets server as the User Name Mapping server for Server for NFS. Although this option continues to be supported for compatibility with previous versions, you should use the sfuadmin utility instead.</li><li>**auditlocation=`{eventlog|file|both|none}`** - Specifies whether events will be audited and where the events will be recorded. One of the following arguments is required:<ul><li>**eventlog** - Specifies that audited events will be recorded only in the Event Viewer application log.</li><li>**file** - Specifies that audited events will be recorded only in the file specified by `config fname`.</li><li>**both** - Specifies that audited events will be recorded in the Event Viewer application log as well as the file specified by `config fname`.</li><li>**none** - Specifies that events aren't audited.</li></ul><li>**fname=`<file>`** - Sets the file specified by file as the audit file. The default is **%sfudir%\log\\nfssvr.log**.</li><li>**fsize=`<size>`** - Sets size as the maximum size in megabytes of the audit file. The default maximum size is **7 MB**.</li><li>**`audit=[+|-]mount [+|-]read [+|-]write [+|-]create [+|-]delete [+|-]locking [+|-]all`** - Specifies the events to be logged. To start logging an event, type a plus sign (**+**) before the event name; to stop logging an event, type a minus sign (**-**) before the event name. If the sign is omitted, the **+** sign is assumed. Don't use **all** with any other event name.</li><li>**lockperiod=`<seconds>`** - Specifies the number of seconds that Server for NFS will wait to reclaim locks after a connection to Server for NFS has been lost and then reestablished or after the Server for NFS service has been restarted.</li><li>**portmapprotocol=`{TCP|UDP|TCP+UDP}`** - Specifies which transport protocols Portmap supports. The default setting is **TCP+UDP**.</li><li>**mountprotocol=`{TCP|UDP|TCP+UDP}`** - Specifies which transport protocols mount supports. The default setting is **TCP+UDP**.</li><li>**nfsprotocol=`{TCP|UDP|TCP+UDP}`** - Specifies which transport protocols Network File System (NFS) supports. The default setting is **TCP+UDP**</li><li>**nlmprotocol=`{TCP|UDP|TCP+UDP}`** - Specifies which transport protocols Network Lock Manager (NLM) supports. The default setting is **TCP+UDP**.</li><li>**nsmprotocol=`{TCP|UDP|TCP+UDP}`** - Specifies which transport protocols Network Status Manager (NSM) supports. The default setting is **TCP+UDP**.</li><li>**enableV3=`{yes|no}`** - Specifies whether NFS version 3 protocols will be supported. The default setting is **yes**.</li><li>**renewauth=`{yes|no}`** - Specifies whether client connections will be required to be reauthenticated after the period specified by config renewauthinterval. The default setting is **no**.</li><li>**renewauthinterval=`<seconds>`** - Specifies the number of seconds that elapse before a client is forced to be reauthenticated if `config renewauth` is set to **yes**. The default value is **600 seconds**.</li><li>**dircache=`<size>`** - Specifies the size in kilobytes of the directory cache. The number specified as size must be a multiple of 4 between 4 and 128. The default directory cache size is **128 KB**.</li><li>**translationfile=`<file>`** - Specifies a file containing mapping information for replacing characters in the names of files when moving them from Windows-based to UNIX-based file systems. If file is not specified, then file name character translation is disabled. If the value of **translationfile** is changed, you must restart the server for the change to take effect.</li><li>**dotfileshidden=`{yes|no}`** - Specifies whether files with names beginning with a period (.) are marked as hidden in the Windows file system, and consequently hidden from NFS clients. The default setting is **no**.</li><li>**casesensitivelookups=`{yes|no}`** - Specifies whether directory lookups are case sensitive (require exact matching of character case).<p>You must also disable Windows kernel case-insensitivity to support case-sensitive file names. To support case-sensitivity, change the **DWord** value of the registry key, `HKLM\SYSTEM\CurrentControlSet\Control\Session Manager\kernel`, to **0**.</li><li>**ntfscase=`{lower|upper|preserve}`** - Specifies whether the case of characters in the names of files in the NTFS file system will be returned in lowercase, uppercase, or in the form stored in the directory. The default setting is **preserve**. This setting can't be changed if **casesensitivelookups** is set to **yes**.</li></ul> |
| creategroup `<name>` | Creates a new client group, giving it the specified name. |
| listgroups | Displays the names of all client groups. |
| deletegroup `<name>` | Removes the client group specified by name. |
| renamegroup `<oldname>` `<newname>` | Changes the name of the client group specified by *oldname* to *newname*. |
| addmembers `<hostname>[...]` | Adds a *host* to the client group specified by *name*. |
| listmembers `<name>` | Lists the host computers in the client group specified by *name*. |
| deletemembers `<hostname><groupname>[...]` | Removes the client specified by *host* from the client group specified by *group*. |

### Client for NFS-related parameters

| Parameter | Description |
| --------- | ----------- |
| start | Starts the Client for NFS service. |
| stop | Stops the Client for NFS service. |
| config | Specifies general settings for Client for NFS. You must supply at least one of the following options with the **config** command argument:<ul><li>**fileaccess=`<mode>`** - Specifies the default permission mode for files created on Network File System (NFS) servers. The **mode** argument consists of a three digit number, from 0 to 7 (inclusive), which represent the default permissions granted the user, group, and others. The digits translate to UNIX-style permissions as follows: *0=none*, *1=x (execute)*, *2=w (write only)*, *3=wx (write and execute)*, *4=r (read only)*, *5=rx (read and execute)*, *6=rw (read and write)*, and *7=rwx (read, write, and execute)*. For example, `fileaccess=750` gives read, write, and execute permissions to the owner, read and execute permissions to the group, and no access permission to others.</li><li>**mapsvr=`<server>`** - Sets server as the User Name Mapping server for Client for NFS. Although this option continues to be supported for compatibility with previous versions, you should use the sfuadmin utility instead.</li><li>**mtype=`{hard|soft}`** - Specifies the default mount type. For a hard mount, Client for NFS continues to retry a failed RPC until it succeeds. For a soft mount, Client for NFS returns failure to the calling application after retrying the call the number of times specified by the retry option.</li><li>**retry=`<number>`** - Specifies the number of times to try to make a connection for a soft mount. This value must be from 1 to 10, inclusive. The default is **1**.</li><li>**timeout=`<seconds>`** - Specifies the number of seconds to wait for a connection (remote procedure call). This value must be *0.8*, *0.9*, or an integer from *1 to 60*, inclusive. The default is **0.8**.</li><li>**protocol=`{TCP|UDP|TCP+UDP}`** - Specifies which transport protocols the client supports. The default setting is **TCP+UDP**.</li><li>**rsize=`<size>`** -Specifies the size, in kilobytes, of the read buffer. This value can be *0.5, 1, 2, 4, 8, 16,* or *32*. The default is **32**.</li><li>**wsize=`<size>`** - Specifies the size, in kilobytes, of the write buffer. This value can be *0.5, 1, 2, 4, 8, 16,* or *32*. The default is **32**.</li><li>**perf=default** - Restores the following performance settings to default values, *mtype*, *retry*, *timeout*, *rsize*, or *wsize*. |

### Examples

To stop Server for NFS or Client for NFS, type:

```
nfsadmin server stop
nfsadmin client stop
```

To start Server for NFS or Client for NFS, type:

```
nfsadmin server start
nfsadmin client start
```

To set Server for NFS to not be case-sensitive, type:

```
nfsadmin server config casesensitive=no
```

To set Client for NFS to be case-sensitive, type:

```
nfsadmin client config casesensitive=yes
```

To display all the current Server for NFS or Client for NFS options, type:

```
nfsadmin server config
nfsadmin client config
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [NFS cmdlets reference](/powershell/module/nfs)
