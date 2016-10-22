---
title: Arp
description: "Windows Commands topic for **Arp** - Displays and modifies entries in the Address Resolution Protocol (ARP) cache used to store IP addresses and their resolved physical addresses.
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
ms.date: 10/12/2016
---
# Arp

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Displays and modifies entries in the Address Resolution Protocol (ARP) cache, which contains one or more tables that are used to store IP addresses and their resolved Ethernet or Token Ring physical addresses. There is a separate table for each Ethernet or Token Ring network adapter installed on your computer. Used without parameters, **arp** displays help.
## Syntax
```
arp [/a [<InetAddr>] [/n <IfaceAddr>]] [/g [<InetAddr>] [-n <IfaceAddr>]] [/d <InetAddr> [<IfaceAddr>]] [/s <InetAddr> <EtherAddr> [<IfaceAddr>]]
```
### Parameters
|Parameter|Description|
|-------|--------|
|/a [<InetAddr>] [/n <IfaceAddr>]|Displays current ARP cache tables for all interfaces. The /n parameter is case-sensitive.<br /><br />To display the ARP cache entry for a specific IP address, use **arp /a** with the *InetAddr* parameter, where *InetAddr* is an IP address. If *InetAddr* is not specified, the first applicable interface is used.<br /><br />To display the ARP cache table for a specific interface, use the **/n***IfaceAddr* parameter in conjunction with the **/a** parameter where *IfaceAddr* is the IP address assigned to the interface.|
|/g [<InetAddr>] [/n <IfaceAddr>]|Identical to **/a**.|
|[/d <InetAddr> [<IfaceAddr>]|Deletes an entry with a specific IP address, where *InetAddr* is the IP address.<br /><br />To delete an entry in a table for a specific interface, use the *IfaceAddr* parameter where *IfaceAddr* is the IP address assigned to the interface.<br /><br />To delete all entries, use the asterisk (\*) wildcard character in place of *InetAddr*.|
|/s <InetAddr> <EtherAddr> [<IfaceAddr>]|Adds a static entry to the ARP cache that resolves the IP address *InetAddr* to the physical address *EtherAddr*.<br /><br />To add a static ARP cache entry to the table for a specific interface, use the *IfaceAddr* parameter where *IfaceAddr* is an IP address assigned to the interface.|
|/?|Displays Help at the command prompt.|
## Remarks
-   The IP addresses for *InetAddr* and *IfaceAddr* are expressed in dotted decimal notation.
-   The physical address for *EtherAddr* consists of six bytes expressed in hexadecimal notation and separated by hyphens (for example, 00-AA-00-4F-2A-9C).
-   Entries added with the **/s** parameter are static and do not time out of the ARP cache. The entries are removed if the TCP/IP protocol is stopped and started. To create permanent static ARP cache entries, place the appropriate **arp** commands in a batch file and use Scheduled Tasks to run the batch file at startup.
## <a name="BKMK_Examples"></a>Examples
To display the ARP cache tables for all interfaces, type:
```
arp /a
```
To display the ARP cache table for the interface that is assigned the IP address 10.0.0.99, type:
```
arp /a /n 10.0.0.99
```
To add a static ARP cache entry that resolves the IP address 10.0.0.80 to the physical address 00-AA-00-4F-2A-9C, type:
```
arp /s 10.0.0.80 00-AA-00-4F-2A-9C 
```
## Additional references
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
