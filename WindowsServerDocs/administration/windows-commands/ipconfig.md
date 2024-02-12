---
title: ipconfig
description: Reference article for the ipconfig command, which displays all current TCP/IP network configuration values and refreshes Dynamic Host Configuration Protocol (DHCP) and Domain Name System (DNS) settings.
ms.topic: reference
ms.assetid: 15071c2c-4815-4893-93b2-ab30232e312e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ipconfig

Displays all current TCP/IP network configuration values and refreshes Dynamic Host Configuration Protocol (DHCP) and Domain Name System (DNS) settings. Used without parameters, **ipconfig** displays Internet Protocol version 4 (IPv4) and IPv6 addresses, subnet mask, and default gateway for all adapters.

## Syntax

```
ipconfig [/allcompartments] [/all] [/renew [<adapter>]] [/release [<adapter>]] [/renew6[<adapter>]] [/release6 [<adapter>]] [/flushdns] [/displaydns] [/registerdns] [/showclassid <adapter>] [/setclassid <adapter> [<classID>]]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| /all | Displays the full TCP/IP configuration for all adapters. Adapters can represent physical interfaces, such as installed network adapters, or logical interfaces, such as dial-up connections. |
| /displaydns | Displays the contents of the DNS client resolver cache, which includes both entries preloaded from the local Hosts file and any recently obtained resource records for name queries resolved by the computer. The DNS Client service uses this information to resolve frequently queried names quickly, before querying its configured DNS servers. |
| /flushdns | Flushes and resets the contents of the DNS client resolver cache. During DNS troubleshooting, you can use this procedure to discard negative cache entries from the cache, as well as any other entries that have been added dynamically. |
| /registerdns | Initiates manual dynamic registration for the DNS names and IP addresses that are configured at a computer. You can use this parameter to troubleshoot a failed DNS name registration or resolve a dynamic update problem between a client and the DNS server without rebooting the client computer. The DNS settings in the advanced properties of the TCP/IP protocol determine which names are registered in DNS. |
| /release `[<adapter>]` | Sends a DHCPRELEASE message to the DHCP server to release the current DHCP configuration and discard the IP address configuration for either all adapters (if an adapter is not specified) or for a specific adapter if the *adapter* parameter is included. This parameter disables TCP/IP for adapters configured to obtain an IP address automatically. To specify an adapter name, type the adapter name that appears when you use **ipconfig** without parameters. |
| /release6`[<adapter>]` | Sends a DHCPRELEASE message to the DHCPv6 server to release the current DHCP configuration and discard the IPv6 address configuration for either all adapters (if an adapter is not specified) or for a specific adapter if the *adapter* parameter is included. This parameter disables TCP/IP for adapters configured to obtain an IP address automatically. To specify an adapter name, type the adapter name that appears when you use **ipconfig** without parameters. |
| /renew `[<adapter>]` | Renews DHCP configuration for all adapters (if an adapter is not specified) or for a specific adapter if the *adapter* parameter is included. This parameter is available only on computers with adapters that are configured to obtain an IP address automatically. To specify an adapter name, type the adapter name that appears when you use **ipconfig** without parameters. |
| /renew6 `[<adapter>]` | Renews DHCPv6 configuration for all adapters (if an adapter is not specified) or for a specific adapter if the *adapter* parameter is included. This parameter is available only on computers with adapters that are configured to obtain an IPv6 address automatically. To specify an adapter name, type the adapter name that appears when you use **ipconfig** without parameters. |
| /setclassid `<adapter>[<classID>]` | Configures the DHCP class ID for a specified adapter. To set the DHCP class ID for all adapters, use the asterisk (**&#42;**) wildcard character in place of *adapter*. This parameter is available only on computers with adapters that are configured to obtain an IP address automatically. If a DHCP class ID is not specified, the current class ID is removed. |
| /showclassid `<adapter>` | Displays the DHCP class ID for a specified adapter. To see the DHCP class ID for all adapters, use the asterisk (**&#42;**) wildcard character in place of *adapter*. This parameter is available only on computers with adapters that are configured to obtain an IP address automatically. |
| /? | Displays Help at the command prompt. |

#### Remarks

- This command is most useful on computers that are configured to obtain an IP address automatically. This enables users to determine which TCP/IP configuration values have been configured by DHCP, Automatic Private IP Addressing (APIPA), or an alternate configuration.

- If the name you supply for *adapter* contains any spaces, use quotation marks around the adapter name (for example, "adapter name").

- For adapter names, **ipconfig** supports the use of the asterisk (*) wildcard character to specify either adapters with names that begin with a specified string or adapters with names that contain a specified string. For example, `Local*` matches all adapters that start with the string Local and `*Con*` matches all adapters that contain the string Con.

### Examples

To display the basic TCP/IP configuration for all adapters, type:

```
ipconfig
```

To display the full TCP/IP configuration for all adapters, type:

```
ipconfig /all
```

To renew a DHCP-assigned IP address configuration for only the Local Area Connection adapter, type:

```
ipconfig /renew Local Area Connection
```

To flush the DNS resolver cache when troubleshooting DNS name resolution problems, type:

```
ipconfig /flushdns
```

To display the DHCP class ID for all adapters with names that start with Local, type:

```
ipconfig /showclassid Local*
```

To set the DHCP class ID for the Local Area Connection adapter to TEST, type:

```
ipconfig /setclassid Local Area Connection TEST
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
