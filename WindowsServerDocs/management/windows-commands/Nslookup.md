---
title: Nslookup
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 41516932-7833-434a-aa92-b4cf0f9a7ef7
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Nslookup
Displays information that you can use to diagnose Domain Name System (DNS) infrastructure. Before using this tool, you should be familiar with how DNS works. The Nslookup command-line tool is available only if you have installed the TCP/IP protocol.
## Syntax
```
Nslookup [<-SubCommand ...>] [{<ComputerToFind> | -<Server>}]
Nslookup /exit
Nslookup /finger [<UserName>] [{[>] <FileName>|[>>] <FileName>}]
Nslookup /{help | ?}
Nslookup /ls [<Option>] <DNSDomain> [{[>] <FileName>|[>>] <FileName>}]
Nslookup /lserver <DNSDomain> 
Nslookup /root 
Nslookup /server <DNSDomain>
Nslookup /set <KeyWord>[=<Value>]
Nslookup /set all 
Nslookup /set class=<Class>
Nslookup /set [no]d2
Nslookup /set [no]debug
Nslookup /set [no]defname
Nslookup /set domain=<DomainName>
Nslookup /set [no]ignore
Nslookup /set port=<Port>
Nslookup /set querytype=<ResourceRecordType>
Nslookup /set [no]recurse
Nslookup /set retry=<Number>
Nslookup /set root=<RootServer>
Nslookup /set [no]search
Nslookup /set srchlist=<DomainName>[/...]
Nslookup /set timeout=<Number>
Nslookup /set type=<ResourceRecordType>
Nslookup /set [no]vc
Nslookup /view <FileName>
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|[Nslookup exit Command](Nslookup-exit-Command.md)|Exits **nslookup**.|
|[Nslookup finger Command](Nslookup-finger-Command.md)|Connects with the finger server on the current computer.|
|[Nslookup help](Nslookup-help.md)|Displays a short summary of **nslookup** subcommands.|
|[Nslookup ls](Nslookup-ls.md)|Lists information for a DNS domain.|
|[Nslookup lserver](Nslookup-lserver.md)|Changes the default server to the specified DNS domain.|
|[Nslookup root](Nslookup-root.md)|Changes the default server to the server for the root of the DNS domain name space.|
|[Nslookup server](Nslookup-server.md)|Changes the default server to the specified DNS domain.|
|[Nslookup set](Nslookup-set.md)|Changes configuration settings that affect how lookups function.|
|[Nslookup set all](Nslookup-set-all.md)|Prints the current values of the configuration settings.|
|[Nslookup set class](Nslookup-set-class.md)|Changes the query class. The class specifies the protocol group of the information.|
|[Nslookup set d2](Nslookup-set-d2.md)|Turns exhaustive Debugging Mode on or off. All fields of every packet are printed.|
|[Nslookup set debug](Nslookup-set-debug.md)|Turns Debugging Mode on or off.|
|[Nslookup /set defname](assetId:///755ed486-d04d-4b6c-85f0-66ddb8ab6dab)|Appends the default DNS domain name to a single component lookup request. A single component is a component that contains no periods.|
|[Nslookup set domain](Nslookup-set-domain.md)|Changes the default DNS domain name to the name specified.|
|[Nslookup /set ignore](assetId:///7ebc431b-cc44-4cee-b520-0d6879071275)|Ignores packet truncation errors.|
|[Nslookup set port](Nslookup-set-port.md)|Changes the default TCP/UDP DNS name server port to the value specified.|
|[Nslookup set querytype](Nslookup-set-querytype.md)|Changes the resource record type for the query.|
|[Nslookup set recurse](Nslookup-set-recurse.md)|Tells the DNS name server to query other servers if it does not have the information.|
|[Nslookup set retry](Nslookup-set-retry.md)|Sets the number of retries.|
|[Nslookup set root](Nslookup-set-root.md)|Changes the name of the root server used for queries.|
|[Nslookup set search](Nslookup-set-search.md)|Appends the DNS domain names in the DNS domain search list to the request until an answer is received. This applies when the set and the lookup request contain at least one period, but do not end with a trailing period.|
|[Nslookup set srchlist](Nslookup-set-srchlist.md)|Changes the default DNS domain name and search list.|
|[Nslookup set timeout](Nslookup-set-timeout.md)|Changes the initial number of seconds to wait for a reply to a request.|
|[Nslookup set type](Nslookup-set-type.md)|Changes the resource record type for the query.|
|[Nslookup set vc](Nslookup-set-vc.md)|Specifies to use or not use a virtual circuit when sending requests to the server.|
|[Nslookup view](Nslookup-view.md)|Sorts and lists the output of the previous **ls** subcommand or commands.|
## Remarks
-   If *ComputerToFind* is an IP address and the query is for an A or PTR resource record type, the name of the computer is returned. If *ComputerToFind* is a name and does not have a trailing period, the default DNS domain name is appended to the name. This behavior depends on the state of the following **set** subcommands: **domain**, **srchlist**, **defname**, and **search**.
-   If you type a hyphen (-) instead of *ComputerToFind*, the command prompt changes to **nslookup** interactive mode.
-   The command-line length must be less than 256 characters.
-   **Nslookup** has two modes: interactive and noninteractive.
    If you need to look up only a single piece of data, use noninteractive mode. For the first parameter, type the name or IP address of the computer that you want to look up. For the second parameter, type the name or IP address of a DNS name server. If you omit the second argument, **nslookup** uses the default DNS name server.
    If you need to look up more than one piece of data, you can use interactive mode. Type a hyphen (-) for the first parameter and the name or IP address of a DNS name server for the second parameter. Or, omit both parameters and **nslookup** uses the default DNS name server. Following are some tips about working in interactive mode:
    -   To interrupt interactive commands at any time, press CTRL+B.
    -   To exit, type **exit**.
    -   To treat a built-in command as a computer name, precede it with the escape character (\\).
    -   An unrecognized command is interpreted as a computer name.
-   If the lookup request fails, **nslookup** prints an error message. The following table lists possible error messages.
    |**Error message**|**Description**|
    |---------------------|-------------------|
    |`Timed out`|The server did not respond to a request after a certain amount of time and a certain number of retries. You can set the time-out period with the **set timeout** subcommand. You can set the number of retries with the **set retry** subcommand.|
    |`No response from server`|No DNS name server is running on the server computer.|
    |`No records`|The DNS name server does not have resource records of the current query type for the computer, although the computer name is valid. The query type is specified with the **set querytype** command.|
    |`Nonexistent domain`|The computer or DNS domain name does not exist.|
    |`Connection refused`<br /><br />-or-<br /><br />`Network is unreachable`|The connection to the DNS name server or finger server could not be made. This error commonly occurs with **ls** and **finger** requests.|
    |`Server failure`|The DNS name server found an internal inconsistency in its database and could not return a valid answer.|
    |`Refused`|The DNS name server refused to service the request.|
    |`Format error`|The DNS name server found that the request packet was not in the proper format. It may indicate an error in **nslookup**.|
-   For more information about the **nslookup** command and DNS, see the following resources:
    -   Lee, T., Davies, J. 2000. *Microsoft Windows 2000 TCP/IP Protocols and Services Technical Reference*. Redmond, Washington: Microsoft Press.
    -   Albitz, P., Loukides, M. and C. Liu. 2001. *DNS and BIND, Fourth Edition*. Sebastopol, California: O'Reilly and Associates, Inc.
    -   Larson, M. and C. Liu. 2001. *DNS on Windows 2000*. Sebastopol, California: O'Reilly and Associates, Inc.
#### Examples
Each command-line option consists of a hyphen (-) followed immediately by the command name and, in some cases, an equal sign (=) and then a value. For example, to change the default query type to host (computer) information and the initial time-out to 10 seconds, type:
**nslookup -querytype=hinfo -timeout=10**
## See Also
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
