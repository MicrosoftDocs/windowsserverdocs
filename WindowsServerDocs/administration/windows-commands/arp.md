---
title: arp
description: "Windows Commands topic for **arp** - Displays and modifies entries in the address Resolution Protocol (arp) cache used to store IP addresses and their resolved physical addresses."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 827e96eb-1945-483f-980f-714703456f7c

author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# arp

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays and modifies entries in the Address Resolution Protocol (ARP) cache. The ARP cache contains one or more tables that are used to store IP addresses and their resolved Ethernet or Token Ring physical addresses. There is a separate table for each Ethernet or Token Ring network adapter installed on your computer. Used without parameters, **arp** displays help information.
## Syntax
```
arp [/a [<Inetaddr>] [/n <ifaceaddr>]] [/g [<Inetaddr>] [-n <ifaceaddr>]] [/d <Inetaddr> [<ifaceaddr>]] [/s <Inetaddr> <Etheraddr> [<ifaceaddr>]]
```
### Parameters

|                Parameter                |                                                                                                                                                                                                                                                               Description                                                                                                                                                                                                                                                               |
|-----------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    /a [<Inetaddr>] [/n <ifaceaddr>]     | Displays current arp cache tables for all interfaces. The /n parameter is case-sensitive.<br /><br />To display the arp cache entry for a specific IP address, use **arp /a** with the *Inetaddr* parameter, where *Inetaddr* is an IP address. If *Inetaddr* is not specified, the first applicable interface is used.<br /><br />To display the arp cache table for a specific interface, use the **/n***ifaceaddr* parameter in conjunction with the **/a** parameter where *ifaceaddr* is the IP address assigned to the interface. |
|    /g [<Inetaddr>] [/n <ifaceaddr>]     |                                                                                                                                                                                                                                                          Identical to **/a**.                                                                                                                                                                                                                                                           |
|      [/d <Inetaddr> [<ifaceaddr>]       |                                                                                           deletes an entry with a specific IP address, where *Inetaddr* is the IP address.<br /><br />To delete an entry in a table for a specific interface, use the *ifaceaddr* parameter where *ifaceaddr* is the IP address assigned to the interface.<br /><br />To delete all entries, use the asterisk (\*) wildcard character in place of *Inetaddr*.                                                                                           |
| /s <Inetaddr> <Etheraddr> [<ifaceaddr>] |                                                                                                                     adds a static entry to the arp cache that resolves the IP address *Inetaddr* to the physical address *Etheraddr*.<br /><br />To add a static arp cache entry to the table for a specific interface, use the *ifaceaddr* parameter where *ifaceaddr* is an IP address assigned to the interface.                                                                                                                     |
|                   /?                    |                                                                                                                                                                                                                                                  Displays help at the command prompt.                                                                                                                                                                                                                                                   |

## Remarks
- The IP addresses for *Inetaddr* and *ifaceaddr* are expressed in dotted decimal notation.
- The physical address for *Etheraddr* consists of six bytes expressed in hexadecimal notation and separated by hyphens (for example, 00-AA-00-4F-2A-9C).
- Entries added with the **/s** parameter are static and do not time out of the arp cache. The entries are removed if the TCP/IP protocol is stopped and started. To create permanent static arp cache entries, place the appropriate **arp** commands in a batch file and use Scheduled Tasks to run the batch file at startup.
  ## <a name="BKMK_Examples"></a>Examples
  To display the arp cache tables for all interfaces, type:
  ```
  arp /a
  ```
  To display the arp cache table for the interface that is assigned the IP address 10.0.0.99, type:
  ```
  arp /a /n 10.0.0.99
  ```
  To add a static arp cache entry that resolves the IP address 10.0.0.80 to the physical address 00-AA-00-4F-2A-9C, type:
  ```
  arp /s 10.0.0.80 00-AA-00-4F-2A-9C 
  ```
  ## additional references
- [Command-Line Syntax Key](command-line-syntax-key.md)
