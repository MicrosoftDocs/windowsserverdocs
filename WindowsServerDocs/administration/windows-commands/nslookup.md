---
title: nslookup
description: Reference article for the nslookup command, which displays information that you can use to diagnose Domain Name System (DNS) infrastructure.
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

The nslookup command-line tool has two modes: interactive and noninteractive.

If you need to look up only a single piece of data, we recommend using the non-interactive mode. For the first parameter, type the name or IP address of the computer that you want to look up. For the second parameter, type the name or IP address of a DNS name server. If you omit the second argument, **nslookup** uses the default DNS name server.

If you need to look up more than one piece of data, you can use interactive mode. Type a hyphen (-) for the first parameter and the name or IP address of a DNS name server for the second parameter. If you omit both parameters, the tool uses the default DNS name server. While using the interactive mode, you can:

- Interrupt interactive commands at any time, by pressing CTRL+B.

- Exit, by typing **exit**.

- Treat a built-in command as a computer name, by preceding it with the escape character (\). An unrecognized command is interpreted as a computer name.

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
| [nslookup set recurse](nslookup-set-recurse.md) | Tells the DNS name server to query other servers if it doesn't have the information. |
| [nslookup set retry](nslookup-set-retry.md) | Sets the number of retries. |
| [nslookup set root](nslookup-set-root.md) | Changes the name of the root server used for queries. |
| [nslookup set search](nslookup-set-search.md) | Appends the DNS domain names in the DNS domain search list to the request until an answer is received. This applies when the set and the lookup request contain at least one period, but do not end with a trailing period. |
| [nslookup set srchlist](nslookup-set-srchlist.md) | Changes the default DNS domain name and search list. |
| [nslookup set timeout](nslookup-set-timeout.md) | Changes the initial number of seconds to wait for a reply to a request. |
| [nslookup set type](nslookup-set-type.md) | Changes the resource record type for the query. |
| [nslookup set vc](nslookup-set-vc.md) | Specifies to use or not use a virtual circuit when sending requests to the server. |
| [nslookup view](nslookup-view.md) | Sorts and lists the output of the previous **ls** subcommand or commands. |

### Remarks

- If *computerTofind* is an IP address and the query is for an **A** or **PTR** resource record type, the name of the computer is returned.

- If *computerTofind* is a name and doesn't have a trailing period, the default DNS domain name is appended to the name. This behavior depends on the state of the following **set** subcommands: **domain**, **srchlist**, **defname**, and **search**.

- If you type a hyphen (-) instead of *computerTofind*, the command prompt changes to **nslookup** interactive mode.

- If the lookup request fails, the command-line tool provides an error message, including:

  | Error message | Description |
  | ------------- | ----------- |
  | timed out |The server didn't respond to a request after a certain amount of time and a certain number of retries. You can set the time-out period with the [nslookup set timeout](nslookup-set-timeout.md) command. You can set the number of retries with the [nslookup set retry](nslookup-set-retry.md) command. |
  | No response from server | No DNS name server is running on the server computer. |
  | No records | The DNS name server doesn't have resource records of the current query type for the computer, although the computer name is valid. The query type is specified with the [nslookup set querytype](nslookup-set-querytype.md) command. |
  | Nonexistent domain | The computer or DNS domain name doesn't exist. |
  | Connection refused or Network is unreachable | The connection to the DNS name server or finger server could not be made. This error commonly occurs with the **ls** and **finger** requests. |
  | Server failure | The DNS name server found an internal inconsistency in its database and could not return a valid answer. |
  | Refused | The DNS name server refused to service the request. |
  | format error | The DNS name server found that the request packet was not in the proper format. It may indicate an error in **nslookup**. |

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
