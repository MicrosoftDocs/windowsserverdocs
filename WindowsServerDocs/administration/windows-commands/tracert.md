---
title: tracert
description: Reference article for tracert, which determines the path taken to a destination, by sending Internet Control Message Protocol (ICMP) echo requests or ICMPv6 messages to the destination with incrementally increasing time to Live (TTL) field values.
ms.topic: reference
ms.assetid: 9032a032-2e5e-49d4-9e86-f821600e4ba6
ms.author: wscontent
author: JasonGerend
ms.date: 09/27/2023
---

# tracert

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This diagnostic tool determines the path taken to a destination by sending Internet Control Message Protocol (ICMP) echo Request or ICMPv6 messages to the destination with incrementally increasing time to live (TTL) field values. Each router along the path is required to decrement the TTL in an IP packet by at least 1 before forwarding it. Effectively, the TTL is a maximum link counter. When the TTL on a packet reaches 0, the router is expected to return an ICMP time Exceeded message to the source computer.

This command determines the path by sending the first echo Request message with a TTL of 1 and incrementing the TTL by 1 on each subsequent transmission until the target responds or the maximum number of hops is reached. The maximum number of hops is 30 by default and can be specified using the **/h** parameter.

The path is determined by examining the ICMP time Exceeded messages returned by intermediate routers and the echo Reply message returned by the destination. However, some routers don't return time Exceeded messages for packets with expired TTL values and are invisible to the **tracert** command. In this case, a row of asterisks (`*`) is displayed for that hop. The path displayed is the list of near/side router interfaces of the routers in the path between a source host and a destination. The near/side interface is the interface of the router that is closest to the sending host in the path.

> [!IMPORTANT]
> This command is available only if the Internet Protocol (TCP/IP) protocol is installed as a component in the properties of a network adapter in Network Connections.
>
> To trace a path and provide network latency and packet loss for each router and link in the path, use the [pathping command](pathping.md) command.

## Syntax

```
tracert [/d] [/h <maximumhops>] [/j <hostlist>] [/w <timeout>] [/R] [/S <srcaddr>] [/4][/6] <targetname>
```

### Parameters

| Parameter | Description |
|--|--|
| /d | Stops attempts to resolve the IP addresses of intermediate routers to their names. This can speed up the return of results. |
| /h `<maximumhops>` | Specifies the maximum number of hops in the path to search for the target (destination). The default is 30 hops. |
| /j `<hostlist>` | Specifies that echo Request messages use the Loose Source Route option in the IP header with the set of intermediate destinations specified in `<hostlist>`. With loose source routing, successive intermediate destinations can be separated by one or multiple routers. The maximum number of addresses or names in the list is *9*. The `<hostlist>` is a series of IP addresses (in dotted decimal notation) separated by spaces. Use this parameter only when tracing IPv4 addresses. |
| /w `<timeout>` | Specifies the amount of time in milliseconds to wait for the ICMP time Exceeded or echo Reply message corresponding to a given echo Request message to be received. If not received within the time-out, an asterisk (`*`) is displayed. The default time-out is 4000 (4 seconds). |
| /R | Specifies that the IPv6 Routing extension header be used to send an echo Request message to the local host, using the destination as an intermediate destination and testing the reverse route. |
| /S `<srcaddr>` | Specifies the source address to use in the echo Request messages. Use this parameter only when tracing IPv6 addresses. |
| /4 | Specifies that tracert.exe can use only IPv4 for this trace. |
| /6 | Specifies that tracert.exe can use only IPv6 for this trace. |
| `<targetname>` | Specifies the destination, identified either by IP address or host name. |
| /? | Displays help at the command prompt. |

## Examples

To trace the path to the host named `www.microsoft.com`, type:

```
tracert www.microsoft.com
```

Here's an example output:

```output
Tracing route to e13678.dscb.akamaiedge.net [23.216.93.114]
over a maximum of 30 hops:

 1     1 ms     1 ms    <1 ms  <devicename>.mshome.net [172.26.96.1]
 2    11 ms    13 ms     6 ms  192.168.191.20
 3    20 ms    11 ms    18 ms  192.168.1.1
 4    44 ms    41 ms    35 ms  10.228.0.1
 5    32 ms    31 ms    46 ms  10.41.0.49
 6    36 ms    39 ms    30 ms  10.41.0.221
 7    35 ms    36 ms    39 ms  10.41.0.225
 8    54 ms    45 ms    50 ms  204.111.0.147
 9    50 ms    52 ms    47 ms  ae-39.a02.atlnga05.us.bb.gin.ntt.net [128.241.219.117]
10    53 ms    51 ms    61 ms  ae-5.r24.atlnga05.us.bb.gin.ntt.net [129.250.4.192]
11    64 ms    45 ms    44 ms  ae-0.a03.atlnga05.us.bb.gin.ntt.net [129.250.2.20]
12    49 ms    67 ms    46 ms  ae-0.akamai-onnet.atlnga05.us.bb.gin.ntt.net [128.241.1.122]
13    67 ms   287 ms     *     ae20.r03.border101.atl02.fab.netarch.akamai.com [23.203.144.21]
14     *        *        *     Request timed out.
15     *        *        *     Request timed out.
16     *        *        *     Request timed out.
17   204 ms    58 ms    51 ms  a23-216-93-114.deploy.static.akamaitechnologies.com [23.216.93.114]

Trace complete.
```

The beginning column displays the hop number starting from 1 and incrementing with each hop along the route from your device to the destination. Each hop represents an intermediate device, such as a router, that the packet passes through while traveling to the final destination.

The three center columns display the round-trip time in milliseconds (ms) for a packet to travel from your device to the router, at that specific hop, and back to your device. It's known as the "ping time" or "ping latency" and measures the delay in milliseconds for data to travel to the router and return. Network latency can be affected by factors such as network congestion, the quality of network links, and the distance between hops.

The end column displays either the IP address or the hostname of the router or intermediate device at that specific hop in the network path. In most cases, you'll see the IP address, but if reverse DNS lookup is successful, it displays the hostnames, which can help identify routers by name.

To trace the path to the host named `www.microsoft.com` and prevent the resolution of each IP address to its name, type:

```
tracert /d www.microsoft.com
```

To trace the path to the host named `www.microsoft.com` and use the loose source route *10.12.0.1/10.29.3.1/10.1.44.1*, type:

```
tracert /j 10.12.0.1 10.29.3.1 10.1.44.1 www.microsoft.com
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [pathping command](pathping.md)
