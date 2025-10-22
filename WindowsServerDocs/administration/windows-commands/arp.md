---
title: arp
description: Reference article for the arp command, which displays and modifies entries in the Address Resolution Protocol (arp) cache used to store IP addresses and their resolved physical addresses in Windows.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 08/15/2025
---

# arp

The `arp` command displays and modifies entries in the Address Resolution Protocol (ARP) cache. The ARP cache contains one or more tables that are used to store IP addresses and their resolved Ethernet or Token Ring physical addresses. There's a separate table for each Ethernet or Token Ring network adapter installed on your computer.

## Syntax

```
arp -s [inet_addr] [eth_addr] [if_addr]
arp -d [inet_addr] [if_addr]
arp -a [inet_addr] [-N if_addr] [-v]
```

### Parameters

| Parameter | Description |
|--|--|
| `-a` | Displays the current ARP entries by querying the protocol data. If `inet_addr` is specified, only the ARP entry for that IP address is shown. If multiple network interfaces use ARP, entries for each interface are displayed. |
| `-g` | Functions identically to `-a`. |
| `-v` | Displays ARP entries in verbose mode, including additional details such as invalid entries and entries on the loopback interface. |
| `inet_addr` | Specifies the IP address to display, delete, or add to the ARP cache. In the context of `-s`, it's the IP you want to associate with a MAC address. |
| `-N if_addr` | Shows ARP entries for the network interface with the specified IP address (`if_addr`). This parameter is case-sensitive. |
| `-d` | Deletes the ARP entry for the specified `inet_addr`. Use `*` as a wildcard to delete all entries. |
| `-s` | Adds a static ARP entry, associating `inet_addr` with the physical address `eth_addr`. Optionally, specify `if_addr` to add the entry to a specific interface. The entry is permanent until the TCP/IP stack is restarted. |
| `eth_addr` | Specifies the physical (MAC) address to associate with the IP address when using `-s`. The format is six hexadecimal bytes separated by hyphens. |
| `if_addr` | Specifies the IP address of the network interface whose ARP table is to be modified, used optionally with `-s` and `-d`. If omitted, the first applicable interface is used. |
| `/?` | Displays help at the command prompt. |

### Remarks

- The IP addresses for `inetaddr` and `ifaceaddr` are expressed in dotted decimal notation (for example, 10.0.0.1).

- The physical MAC address for `etheraddr` consists of six bytes expressed in hexadecimal notation and separated by hyphens (for example, 00-AA-00-4F-2A-9C).

- Entries added with the `-s` parameter are removed if the TCP/IP protocol is stopped and started. To create permanent static arp cache entries, place the appropriate `arp` commands in a batch file and use Scheduled Tasks to run the batch file at startup.

## Examples

To display the arp cache tables for all interfaces, type:

```
arp -a
```

To display the arp cache table for the interface where the IP address *10.0.0.99* is assigned, type:

```
arp -a -N 10.0.0.99
```

To add a static arp cache entry that resolves the IP address *10.0.0.80* to the physical address *00-AA-00-4F-2A-9C*, type:

```
arp -s 10.0.0.80 00-AA-00-4F-2A-9C
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
