---
title: nslookup
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 41516932-7833-434a-aa92-b4cf0f9a7ef7
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# nslookup

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information that you can use to diagnose Domain Name System (DNS) infrastructure. Before using this tool, you should be familiar with how DNS works. The nslookup command-line tool is available only if you have installed the TCP/IP protocol.
## Syntax

```
nslookup [<-SubCommand ...>] [{<computerTofind> | -<Server>}]
nslookup /exit
nslookup /finger [<UserName>] [{[>] <FileName>|[>>] <FileName>}]
nslookup /{help | ?}
nslookup /ls [<Option>] <DNSDomain> [{[>] <FileName>|[>>] <FileName>}]
nslookup /lserver <DNSDomain> 
nslookup /root 
nslookup /server <DNSDomain>
nslookup /set <KeyWord>[=<Value>]
nslookup /set all 
nslookup /set class=<Class>
nslookup /set [no]d2
nslookup /set [no]debug
nslookup /set [no]defname
nslookup /set domain=<DomainName>
nslookup /set [no]ignore
nslookup /set port=<Port>
nslookup /set querytype=<ResourceRecordtype>
nslookup /set [no]recurse
nslookup /set retry=<Number>
nslookup /set root=<RootServer>
nslookup /set [no]search
nslookup /set srchlist=<DomainName>[/...]
nslookup /set timeout=<Number>
nslookup /set type=<ResourceRecordtype>
nslookup /set [no]vc
nslookup /view <FileName>
```

## Parameters

|                       Parameter                       |                                                                                                         Description                                                                                                         |
|-------------------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   [nslookup exit Command](nslookup-exit-command.md)   |                                                                                                     exits **nslookup**.                                                                                                     |
| [nslookup finger Command](nslookup-finger-command.md) |                                                                                  Connects with the finger server on the current computer.                                                                                   |
|           [nslookup help](nslookup-help.md)           |                                                                                    Displays a short summary of **nslookup** subcommands.                                                                                    |
|             [nslookup ls](nslookup-ls.md)             |                                                                                             lists information for a DNS domain.                                                                                             |
|        [nslookup lserver](nslookup-lserver.md)        |                                                                                   changes the default server to the specified DNS domain.                                                                                   |
|           [nslookup root](nslookup-root.md)           |                                                                     changes the default server to the server for the root of the DNS domain name space.                                                                     |
|         [nslookup server](nslookup-server.md)         |                                                                                   changes the default server to the specified DNS domain.                                                                                   |
|            [nslookup set](nslookup-set.md)            |                                                                              changes configuration settings that affect how lookups function.                                                                               |
|        [nslookup set all](nslookup-set-all.md)        |                                                                                  prints the current values of the configuration settings.                                                                                   |
|      [nslookup set class](nslookup-set-class.md)      |                                                                     changes the query class. The class specifies the protocol group of the information.                                                                     |
|         [nslookup set d2](nslookup-set-d2.md)         |                                                                     Turns exhaustive Debugging mode on or off. All fields of every packet are printed.                                                                      |
|      [nslookup set debug](nslookup-set-debug.md)      |                                                                                               Turns Debugging mode on or off.                                                                                               |
|                 nslookup /set defname                 |                                            appends the default DNS domain name to a single component lookup request. A single component is a component that contains no periods.                                            |
|     [nslookup set domain](nslookup-set-domain.md)     |                                                                                 changes the default DNS domain name to the name specified.                                                                                  |
|                 nslookup /set ignore                  |                                                                                              Ignores packet truncation errors.                                                                                              |
|       [nslookup set port](nslookup-set-port.md)       |                                                                          changes the default TCP/UDP DNS name server port to the value specified.                                                                           |
|  [nslookup set querytype](nslookup-set-querytype.md)  |                                                                                       changes the resource record type for the query.                                                                                       |
|    [nslookup set recurse](nslookup-set-recurse.md)    |                                                                    Tells the DNS name server to query other servers if it does not have the information.                                                                    |
|      [nslookup set retry](nslookup-set-retry.md)      |                                                                                                 Sets the number of retries.                                                                                                 |
|       [nslookup set root](nslookup-set-root.md)       |                                                                                    changes the name of the root server used for queries.                                                                                    |
|     [nslookup set search](nslookup-set-search.md)     | appends the DNS domain names in the DNS domain search list to the request until an answer is received. This applies when the set and the lookup request contain at least one period, but do not end with a trailing period. |
|   [nslookup set srchlist](nslookup-set-srchlist.md)   |                                                                                    changes the default DNS domain name and search list.                                                                                     |
|    [nslookup set timeout](nslookup-set-timeout.md)    |                                                                           changes the initial number of seconds to wait for a reply to a request.                                                                           |
|       [nslookup set type](nslookup-set-type.md)       |                                                                                       changes the resource record type for the query.                                                                                       |
|         [nslookup set vc](nslookup-set-vc.md)         |                                                                     Specifies to use or not use a virtual circuit when sending requests to the server.                                                                      |
|           [nslookup view](nslookup-view.md)           |                                                                          sorts and lists the output of the previous **ls** subcommand or commands.                                                                          |

## Remarks
- if *computerTofind* is an IP address and the query is for an A or PTR resource record type, the name of the computer is returned. If *computerTofind* is a name and does not have a trailing period, the default DNS domain name is appended to the name. This behavior depends on the state of the following **set** subcommands: **domain**, **srchlist**, **defname**, and **search**.
- if you type a hyphen (-) instead of *computerTofind*, the command prompt changes to **nslookup** interactive mode.
- The command-line length must be less than 256 characters.
- **nslookup** has two modes: interactive and noninteractive.
  if you need to look up only a single piece of data, use noninteractive mode. For the first parameter, type the name or IP address of the computer that you want to look up. For the second parameter, type the name or IP address of a DNS name server. If you omit the second argument, **nslookup** uses the default DNS name server.
  if you need to look up more than one piece of data, you can use interactive mode. type a hyphen (-) for the first parameter and the name or IP address of a DNS name server for the second parameter. Or, omit both parameters and **nslookup** uses the default DNS name server. Following are some tips about working in interactive mode:
  -   To interrupt interactive commands at any time, press CTRL+B.
  -   To exit, type **exit**.
  -   To treat a built-in command as a computer name, precede it with the escape character (\\).
  -   An unrecognized command is interpreted as a computer name.
- if the lookup request fails, **nslookup** prints an error message. The following table lists possible error messages.
  |**Error message**|**Description**|
  |-----------|----------|
  |`timed out`|The server did not respond to a request after a certain amount of time and a certain number of retries. You can set the time-out period with the **set timeout** subcommand. You can set the number of retries with the **set retry** subcommand.|
  |`No response from server`|No DNS name server is running on the server computer.|
  |`No records`|The DNS name server does not have resource records of the current query type for the computer, although the computer name is valid. The query type is specified with the **set querytype** command.|
  |`Nonexistent domain`|The computer or DNS domain name does not exist.|
  |`Connection refused`<br /><br />-or-<br /><br />`Network is unreachable`|The connection to the DNS name server or finger server could not be made. This error commonly occurs with **ls** and **finger** requests.|
  |`Server failure`|The DNS name server found an internal inconsistency in its database and could not return a valid answer.|
  |`Refused`|The DNS name server refused to service the request.|
  |`format error`|The DNS name server found that the request packet was not in the proper format. It may indicate an error in **nslookup**.|
- for more information about the **nslookup** command and DNS, see the following resources:
  - Lee, T., Davies, J. 2000. *Microsoft Windows 2000 TCP/IP Protocols and Services Technical Reference*. Redmond, Washington: Microsoft Press.
  - Albitz, P., Loukides, M. and C. Liu. 2001. *DNS and BIND, Fourth edition*. Sebastopol, California: O'Reilly and associates, Inc.
  - Larson, M. and C. Liu. 2001. *DNS on Windows 2000*. Sebastopol, California: O'Reilly and associates, Inc.
    #### Examples
    Each command-line option consists of a hyphen (-) followed immediately by the command name and, in some cases, an equal sign (=) and then a value. For example, to change the default query type to host (computer) information and the initial time-out to 10 seconds, type:
    **nslookup -querytype=hinfo -timeout=10**
    ## See Also
    [Command-Line Syntax Key](command-line-syntax-key.md)
