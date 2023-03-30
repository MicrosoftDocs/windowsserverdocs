---
title: nslookup set
description: Reference article for the nslookup set command, which changes configuration settings affecting how lookups behave.
ms.topic: reference
ms.assetid: 1fe5b36d-e93e-468b-abca-43b0204b32d1
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# nslookup set

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Changes configuration settings that affect how lookups function.

## Syntax

```
set all [class | d2 | debug | domain | port | querytype | recurse | retry | root | search | srchlist | timeout | type | vc] [options]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| [nslookup set all](nslookup-set-all.md) | Lists all current settings. |
| [nslookup set class](nslookup-set-class.md) | Changes the query class, which specifies the protocol group of the information. |
| [nslookup set d2](nslookup-set-d2.md) | Turns the verbose debugging mode on or off. |
| [nslookup set debug](nslookup-set-debug.md) | Turns off debugging mode completely. |
| [nslookup set domain](nslookup-set-domain.md) | Changes the default Domain Name System (DNS) domain name to the specified name. |
| [nslookup set port](nslookup-set-port.md) | Changes the default TCP/UDP Domain Name System (DNS) name server port to the specified value.
| [nslookup set querytype](nslookup-set-querytype.md) | Changes the resource record type for the query. |
| [nslookup set recurse](nslookup-set-recurse.md) | Tells the Domain Name System (DNS) name server to query other servers if it doesn't find any information. |
| [nslookup set retry](nslookup-set-retry.md) | Sets the number of retries. |
| [nslookup set root](nslookup-set-root.md) | Changes the name of the root server used for queries. |
| [nslookup set search](nslookup-set-search.md) | Appends the Domain Name System (DNS) domain names in the DNS domain search list to the request until an answer is received. |
| [nslookup set srchlist](nslookup-set-srchlist.md) | Changes the default Domain Name System (DNS) domain name and search list. |
| [nslookup set timeout](nslookup-set-timeout.md) | Changes the initial number of seconds to wait for a reply to a lookup request. |
| [nslookup set type](nslookup-set-type.md) | Changes the resource record type for the query. |
| [nslookup set vc](nslookup-set-vc.md) | Specifies whether to use a virtual circuit when sending requests to the server. |

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
