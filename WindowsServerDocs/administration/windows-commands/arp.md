---
title: arp
description: Reference article for the arp command, which displays and modifies entries in the address Resolution Protocol (arp) cache used to store IP addresses and their resolved physical addresses.
ms.topic: reference
ms.assetid: 827e96eb-1945-483f-980f-714703456f7c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---
# arp

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays and modifies entries in the Address Resolution Protocol (ARP) cache. The ARP cache contains one or more tables that are used to store IP addresses and their resolved Ethernet or Token Ring physical addresses. There is a separate table for each Ethernet or Token Ring network adapter installed on your computer. Used without parameters, **arp** displays help information.

## Syntax

```
arp [/a [<inetaddr>] [/n <ifaceaddr>]] [/g [<inetaddr>] [-n <ifaceaddr>]] [/d <inetaddr> [<ifaceaddr>]] [/s <inetaddr> <etheraddr> [<ifaceaddr>]]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `[/a [<inetaddr>] [/n <ifaceaddr>]` | Displays current arp cache tables for all interfaces. The **/n** parameter is case-sensitive. To display the arp cache entry for a specific IP address, use **arp /a** with the **inetaddr** parameter, where **inetaddr** is an IP address. If **inetaddr** is not specified, the first applicable interface is used. To display the arp cache table for a specific interface, use the **/n ifaceaddr** parameter in conjunction with the **/a** parameter where **inetaddr** is the IP address assigned to the interface. |
| `[/g [<inetaddr>] [/n <ifaceaddr>]` | Identical to **/a**. |
| `[/d <inetaddr> [<ifaceaddr>]` | Deletes an entry with a specific IP address, where **inetaddr** is the IP address. To delete an entry in a table for a specific interface, use the **ifaceaddr** parameter where **ifaceaddr** is the IP address assigned to the interface. To delete all entries, use the asterisk (*) wildcard character in place of **inetaddr**. |
| `[/s <inetaddr> <etheraddr> [<ifaceaddr>]` | Adds a static entry to the arp cache that resolves the IP address **inetaddr** to the physical address **etheraddr**. To add a static arp cache entry to the table for a specific interface, use the **ifaceaddr** parameter where **ifaceaddr** is an IP address assigned to the interface. |
| /? | Displays help at the command prompt. |

### Remarks

- The IP addresses for **inetaddr** and **ifaceaddr** are expressed in dotted decimal notation.

- The physical address for **etheraddr** consists of six bytes expressed in hexadecimal notation and separated by hyphens (for example, 00-AA-00-4F-2A-9C).

- Entries added with the **/s** parameter are static and do not time out of the arp cache. The entries are removed if the TCP/IP protocol is stopped and started. To create permanent static arp cache entries, place the appropriate **arp** commands in a batch file and use Scheduled Tasks to run the batch file at startup.

## Examples

To display the arp cache tables for all interfaces, type:

```
arp /a
```

To display the arp cache table for the interface that is assigned the IP address *10.0.0.99*, type:

```
arp /a /n 10.0.0.99
```

To add a static arp cache entry that resolves the IP address *10.0.0.80* to the physical address *00-AA-00-4F-2A-9C*, type:

```
arp /s 10.0.0.80 00-AA-00-4F-2A-9C
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
