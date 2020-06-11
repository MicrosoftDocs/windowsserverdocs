---
title: nslookup
description: Reference topic for the nslookup command, which displays information that you can use to diagnose Domain Name System (DNS) infrastructure.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 41516932-7833-434a-aa92-b4cf0f9a7ef7
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# nslookup

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information that you can use to diagnose Domain Name System (DNS) infrastructure. Before using this tool, you should be familiar with how DNS works. The nslookup command-line tool is available only if you have installed the TCP/IP protocol.

## Syntax

```
nslookup [exit | finger | help | ls | lserver | root | server | set | view] [options]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| [nslookup exit](nslookup-exit-command.md) | Exits the nslookup command-line tool. |
| [nslookup finger](nslookup-finger-command.md) | Connects with the finger server on the current computer. |
| [nslookup help](nslookup-help.md) | Displays a short summary of subcommands. |
| [nslookup ls](nslookup-ls.md) | Lists information for a DNS domain. |
| [nslookup lserver](nslookup-lserver.md) | Changes the default server to the specified DNS domain. |
| [nslookup root](nslookup-root.md) | Changes the default server to the server for the root of the DNS domain name space. |
| [nslookup server](nslookup-server.md) | Changes the default server to the specified DNS domain. |
| [nslookup set](nslookup-set.md) | Changes configuration settings that affect how lookups function. |
| [nslookup set all](nslookup-set-all.md) | Prints the current values of the configuration settings. |
| [nslookup set class](nslookup-set-class.md) | Changes the query class. The class specifies the protocol group of the information. |
| [nslookup set d2](nslookup-set-d2.md) | Turns exhaustive Debugging mode on or off. All fields of every packet are printed. |
| [nslookup set debug](nslookup-set-debug.md) | Turns Debugging mode on or off. |
| [nslookup set domain](nslookup-set-domain.md) | Changes the default DNS domain name to the name specified. |
| [nslookup set port](nslookup-set-port.md) | Changes the default TCP/UDP DNS name server port to the value specified. |
| [nslookup set querytype](nslookup-set-querytype.md) | Changes the resource record type for the query. |
| [nslookup set recurse](nslookup-set-recurse.md) | Tells the DNS name server to query other servers if it does not have the information. |
| [nslookup set retry](nslookup-set-retry.md) | Sets the number of retries. |
| [nslookup set root](nslookup-set-root.md) | Changes the name of the root server used for queries. |
| [nslookup set search](nslookup-set-search.md) | Appends the DNS domain names in the DNS domain search list to the request until an answer is received. This applies when the set and the lookup request contain at least one period, but do not end with a trailing period. |
| [nslookup set srchlist](nslookup-set-srchlist.md) | Changes the default DNS domain name and search list. |
| [nslookup set timeout](nslookup-set-timeout.md) | Changes the initial number of seconds to wait for a reply to a request. |
| [nslookup set type](nslookup-set-type.md) | Changes the resource record type for the query. |
| [nslookup set vc](nslookup-set-vc.md) | Specifies to use or not use a virtual circuit when sending requests to the server. |
| [nslookup view](nslookup-view.md) | Sorts and lists the output of the previous **ls** subcommand or commands. |

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
