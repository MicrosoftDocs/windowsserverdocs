---
title: nfsadmin
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7375b2cf-c6b8-45b5-abf6-6c10e462defd
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# nfsadmin

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can use **nfsadmin** to manage Server for NFS and Client for NFS.  
  
## Syntax  
**nfsadmin server** `[`*computerName*`] [`\-u *UserName*`[`\-p *Password*`]]` \-l  
  
**nfsadmin server** `[`*computerName*`] [`\-u *UserName* `[`\-p *Password*`]]` \-r `{`*client* `|` all`}`  
  
**nfsadmin server** `[`*computerName*`] [`\-u *UserName* `[`\-p *Password*`]] {`start `|` stop`}`  
  
**nfsadmin server** `[`*computerName*`] [`\-u *UserName* `[`\-p *Password*`]]` config *Option*`[...]`  
  
**nfsadmin server** `[`*computerName*`] [`\-u *UserName* `[`\-p *Password*`]]` creategroup *Name*  
  
**nfsadmin server** `[`*computerName*`] [`\-u *UserName* `[`\-p *Password*`]]` listgroups  
  
**nfsadmin server** `[`*computerName*`] [`\-u *UserName* `[`\-p *Password*`]]` deletegroup *Name*  
  
**nfsadmin server** `[`*computerName*`] [`\-u *UserName* `[`\-p *Password*`]]` renamegroup *OldName NewName*  
  
**nfsadmin server** `[`*computerName*`] [`\-u *UserName* `[`\-p *Password*`]]` addmembers *Name Host*`[...]`  
  
**nfsadmin server** `[`*computerName*`] [`\-u *UserName* `[`\-p *Password*`]]` listmembers  
  
**nfsadmin server** `[`*computerName*`] [`\-u *UserName* `[`\-p *Password*`]]` deletemembers *Group Host*`[...]`  
  
**nfsadmin client** `[`*computerName*`] [`\-u *UserName* `[`\-p *Password*`]] {`start `|` stop`}`  
  
**nfsadmin client** `[`*computerName*`] [`\-u *UserName* `[`\-p *Password*`]]` config *Option*`[...]`  
  
## Description  
The **nfsadmin** command\-line utility administers Server for NFS or Client for NFS on the local or remote computer running Microsoft Services for Network File System \(NFS\). If you are logged on with an account that does not have the required privileges, you can specify a user name and password of an account that does. The action performed by **nfsadmin** depends on the command arguments you supply.  
  
In addition to service\-specific command arguments and options, **nfsadmin** accepts the following:  
  
*computerName*  
Specifies the remote computer you want to administer. You can specify the computer using a Windows Internet Name Service \(WINS\) name or a Domain Name System \(DNS\) name, or by Internet Protocol \(IP\) address.  
  
**\-u** *UserName*  
Specifies the user name of the user whose credentials are to be used. It might be necessary to add the domain name to the user name in the form <em>domain</em>**\\**<em>UserName</em>  
  
**\-p** *Password*  
Specifies the password of the user specified using the **\-u** option. If you specify the **\-u** option but omit the **\-p** option, you are prompted for the user's password.  
  
#### Administering Server for NFS  
Use the **nfsadmin server** command to administer Server for NFS. The specific action that **nfsadmin server** takes depends on the command option or argument you specify:  
  
**\-l**  
lists all locks held by clients.  
  
**\-r** {*client* | **all**}  
Releases the locks held by a *client* or, if **all** is specified, by all clients.  
  
**start**  
starts the Server for NFS service.  
  
**stop**  
Stops the Server for NFS service.  
  
**config**  
Specifies general settings for Server for NFS. You must supply at least one of the following options with the **config** command argument:  
  
**mapsvr\=**<em>server</em>  
Sets *server* as the User Name Mapping server for Server for NFS. Although this option continues to be supported for compatibility with previous versions, you should use the **sfuadmin** utility instead.  
  
**auditlocation\=**{**eventlog** | **file** | **both** | **none**}  
Specifies whether events will be audited and where the events will be recorded. One of the following arguments is required.  
  
**eventlog**  
Specifies that audited events will be recorded only in the Event Viewer application log.  
  
**file**  
Specifies that audited events will be recorded only in the file specified by **config fname**.  
  
**both**  
Specifies that audited events will be recorded in the Event Viewer application log as well as the file specified by **config fname**.  
  
**none**  
Specifies that events will not be audited.  
  
**fname\=**<em>file</em>  
Sets the file specified by *file* as the audit file. The default is %sfudir%\\log\\nfssvr.log  
  
**fsize\=**\=*size*  
Sets *size* as the maximum size in megabytes of the audit file. The default maximum size is 7 MB.  
  
**audit\=**\[**\+**|**\-**\]**mount** \[**\+**|**\-**\]**read** \[**\+**|**\-**\]**write** \[**\+**|**\-**\]**create** \[**\+**|**\-**\]**delete** \[**\+**|**\-**\]**locking** \[**\+**|**\-**\]**all**  
Specifies the events to be logged. To start logging an event, type a plus sign \(**\+**\) before the event name; to stop logging an event, type a minus sign \(**\-**\) before the event name. If the sign is omitted, the plus sign is assumed. Do not use **all** with any other event name.  
  
**lockperiod\=**<em>seconds</em>  
Specifies the number of seconds that Server for NFS will wait to reclaim locks after a connection to Server for NFS has been lost and then reestablished or after the Server for NFS service has been restarted.  
  
Portmapprotocol\={TCP | UDP | TCP\+UDP  
Specifies which transport protocols Portmap supports. The default setting is **TCP\+UDP**.  
  
mountprotocol\={TCP | UDP | TCP\+UDP}  
Specifies which transport protocols mount supports. The default setting is **TCP\+UDP**.  
  
nfsprotocol\={TCP | UDP | TCP\+UDP}  
Specifies which transport protocols Network File System \(NFS\) supports. The default setting is **TCP\+UDP**  
  
nlmprotocol\={TCP | UDP | TCP\+UDP}  
Specifies which transport protocols Network Lock Manager \(NLM\) supports. The default setting is **TCP\+UDP**.  
  
nsmprotocol\={TCP | UDP | TCP\+UDP}  
Specifies which transport protocols Network Status Manager \(NSM\) supports. The default setting is **TCP\+UDP**.  
  
**enableV3\=**{**yes** | **no**}  
Specifies whether NFS version 3 protocols will be supported. The default setting is **yes**.  
  
**renewauth\=**{**yes** | **no**}  
Specifies whether client connections will be required to be reauthenticated after the period specified by **config renewauthinterval**. The default setting is **no**.  
  
**renewauthinterval\=**<em>seconds</em>  
Specifies the number of seconds that elapse before a client is forced to be reauthenticated if **config renewauth** is set to **yes**. The default value is 600 seconds.  
  
**dircache\=**<em>size</em>  
Specifies the size in kilobytes of the directory cache. The number specified as *size* must be a multiple of 4 between 4 and 128. The default directory\-cache size is 128 KB.  
  
**translationfile**\=\[file\]  
Specifies a file containing mapping information for replacing characters in the names of files when moving them from Windows\-based to UNIX\-based file systems. If *file* is not specified, then file name character translation is disabled. If the value of **translationfile** is changed, you must restart the server for the change to take effect.  
  
**dotfileshidden**\={**yes** | **no**}  
Specifies whether files that are created with names beginning with a period \(.\) will be marked as hidden in the Windows file system and consequently hidden from NFS clients. The default setting is **no**.  
  
**casesensitivelookups\=**{**yes** | **no**}  
Specifies whether directory lookups will be case sensitive \(requiring exact matching of character case\).  
  
You also need to disable Windows kernel case\-insensitivity in order for Server for NFS to support case\-sensitive file names. You can disable Windows kernel case\-insensitivity by clearing the following registry key to 0:  
  
HKLM\\SYSTEM\\CurrentControlSet\\Control\\Session Manager\\kernel  
  
DWOrd  obcaseinsensitive   
  
> [!IMPORTANT]  
> This section applies only to Windows Server 2008 R2, Windows Server 2008, and Windows Server 2003. This section does not apply to Windows Server 2012 R2 or Windows Server 2012.  
  
**ntfscase\=**{**lower** | **upper** | **preserve**}  
Specifies whether the case of characters in the names of files in the NTFS file system will be returned in lowercase, uppercase, or in the form stored in the directory. The default setting is **preserve**. This setting cannot be changed if **casesensitivelookups** is set to **yes**.  
  
**creategroup** *name*  
creates a new client group, giving it the specified *name*.  
  
**listgroups**  
Displays the names of all client groups.  
  
**deletegroup** *name*  
removes the client group specified by *name*.  
  
**renamegroup** *OldName NewName*  
changes the name of the client group specified by *OldName* to *NewName*  
  
**addmembers** *Name Host*\[...\]  
adds *Host* to the client group specified by *Name*.  
  
**listmembers** *Name*  
lists the host computers in the client group specified by *Name*.  
  
**deletemembers** *Group Host*\[...\]  
removes the client specified by *Host* from the client group specified by *Group*.  
  
if you do not specify a command option or argument, **nfsadmin server** displays the current Server for NFS configuration settings.  
  
#### Administering Client for NFS  
Use the **nfsadmin client** command to administer Client for NFS. The specific action that **nfsadmin client** takes depends on the command argument you specify:  
  
**start**  
starts the Client for NFS service.  
  
**stop**  
Stops the Client for NFS service.  
  
**config**  
Specifies general settings for Client for NFS. You must supply at least one of the following options with the **config** command argument:  
  
**fileaccess\=**<em>mode</em>  
-   Specifies the default permission mode for files created on Network File System \(NFS\) servers. The *mode* argument consists of a three digits from 0 to 7 \(inclusive\) representing the default permissions granted the user, group, and others \(respectively\). The digits translate to UNIX\-style permissions as follows: 0\=none, 1\=x, 2\=w, 3\=wx, 4\=r, 5\=rx, 6\=rw, and 7\=rwx. For example, **fileaccess\=750** gives rwx permission to the owner, rx permission to the group, and no access permission to others.  
  
**mapsvr\=**<em>server</em>  
Sets *server* as the User Name Mapping server for Client for NFS. Although this option continues to be supported for compatibility with previous versions, you should use the **sfuadmin** utility instead.  
  
**mtype\=**{**hard** | **soft**}  
Specifies the default mount type. For a hard mount, Client for NFS continues to retry a failed RPC until it succeeds. For a soft mount, Client for NFS returns failure to the calling application after retrying the call the number of times specified by the **retry** option.  
  
**retry\=**<em>number</em>  
Specifies the number of times to try to make a connection for a soft mount. This value must be from 1 to 10, inclusive. The default is 1.  
  
**timeout\=**<em>seconds</em>  
Specifies the number of seconds to wait for a connection \(remote procedure call\). This value must be 0.8, 0.9, or an integer from 1 to 60, inclusive. The default is 0.8.  
  
**Protocol\={TCP | UDP | TCP\+UDP}**  
Specifies which transport protocols the client supports. The default setting is **TCP\+UDP**  
  
**rsize\=**<em>size</em>  
Specifies the size, in kilobytes, of the read buffer. This value can be 0.5, 1, 2, 4, 8, 16, or 32. The default is 32.  
  
**wsize\=**<em>size</em>  
Specifies the size, in kilobytes, of the write buffer. This value can be 0.5, 1, 2, 4, 8, 16, or 32. The default is 32.  
  
**perf\=default**  
Restores the following performance settings to default values:  
  
-   **mtype**  
  
-   **retry**  
  
-   **timeout**  
  
-   **rsize**  
  
-   **wsize**  
  
**fileaccess\=**<em>mode</em>  
Specifies the default permission mode for files created on Network File System \(NFS\) servers. The *mode* argument consists of a three digits from 0 to 7 \(inclusive\) representing the default permissions granted the user, group, and others \(respectively\). The digits translate to UNIX\-style permissions as follows: 0\=none, 1\=x, 2\=w, 3\=wx, 4\=r, 5\=rx, 6\=rw, and 7\=rwx. For example, **fileaccess\=750** gives rwx permission to the owner, rx permission to the group, and no access permission to others.  
  
if you do not specify a command option or argument, **nfsadmin client** displays the current Client for NFS configuration settings.  
  

