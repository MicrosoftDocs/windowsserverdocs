---
title: pathping
description: Reference article for the pathping command, which gets info about network latency and network loss at intermediate hops between a source and a destination.
ms.topic: reference
ms.assetid: ec430125-b1dc-4aad-a7c9-b70f486d9e3c
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 07/11/2018
---

# pathping

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Provides information about network latency and network loss at intermediate hops between a source and destination. This command sends multiple echo Request messages to each router between a source and destination, over a period of time, and then computes results based on the packets returned from each router. Because this command displays the degree of packet loss at any given router or link, you can determine which routers or subnets might be having network problems. Used without parameters, this command displays help.

> [!NOTE]
> This command is available only if the Internet Protocol (TCP/IP) protocol is installed as a component in the properties of a network adapter in Network Connections.
>
> Additionally, this command identifies which routers are on the path, same as using the [tracert command](tracert.md). Howevever, this command also sends pings periodically to all of the routers over a specified time period and computes statistics based on the number returned from each.

## Syntax

```
pathping [/n] [/h <maximumhops>] [/g <hostlist>] [/p <Period>] [/q <numqueries> [/w <timeout>] [/i <IPaddress>] [/4 <IPv4>] [/6 <IPv6>][<targetname>]
```

### Parameters

| Parameter | Description |
|--|--|
| /n | Prevents **pathping** from attempting to resolve the IP addresses of intermediate routers to their names. This might expedite the display of **pathping** results. |
| /h `<maximumhops>` | Specifies the maximum number of hops in the path to search for the target (destination). The default is 30 hops. |
| /g `<hostlist>` | Specifies that the echo Request messages use the **Loose Source Route** option in the IP header with the set of intermediate destinations specified in *hostlist*. With loose source routing, successive intermediate destinations can be separated by one or multiple routers. The maximum number of addresses or names in the host list is **9**. The *hostlist* is a series of IP addresses (in dotted decimal notation) separated by spaces. |
| /p `<period>` | Specifies the number of milliseconds to wait between consecutive pings. The default is 250 milliseconds (1/4 second). This parameter sends individual pings to each intermediate hop. Because of this, the interval between two pings sent to the same hop is *period* multiplied by the number of hops. |
| /q `<numqueries>` | Specifies the number of echo Request messages sent to each router in the path. The default is 100 queries. |
| /w `<timeout>` | Specifies the number of milliseconds to wait for each reply. The default is 3000 milliseconds (3 seconds). This parameter sends multiple pings in parallel. Because of this, the amount of time specified in the *timeout* parameter isn't bounded by the amount of time specified in the *period* parameter for waiting between pings. |
| /i `<IPaddress>` | Specifies the source address. |
| /4 `<IPv4>` | Specifies that pathping uses IPv4 only. |
| /6 `<IPv6>` | Specifies that pathping uses IPv6 only. |
| `<targetname>` | Specifies the destination, which is identified either by IP address or host name. |
| /? | Displays help at the command prompt. |

#### Remarks

- All parameters are case-sensitive.

- To avoid network congestion and to minimize the effects of burst losses, pings should be sent at a sufficiently slow pace.

### Example of the pathping command output

```
D:\>pathping /n contoso1
Tracing route to contoso1 [10.54.1.196]
over a maximum of 30 hops:
  0  172.16.87.35
  1  172.16.87.218
  2  192.168.52.1
  3  192.168.80.1
  4  10.54.247.14
  5  10.54.1.196
computing statistics for 125 seconds...
            Source to Here   This Node/Link
Hop  RTT    Lost/Sent = Pct  Lost/Sent = Pct  address
  0                                           172.16.87.35
                                0/ 100 =  0%   |
  1   41ms     0/ 100 =  0%     0/ 100 =  0%  172.16.87.218
                               13/ 100 = 13%   |
  2   22ms    16/ 100 = 16%     3/ 100 =  3%  192.168.52.1
                                0/ 100 =  0%   |
  3   24ms    13/ 100 = 13%     0/ 100 =  0%  192.168.80.1
                                0/ 100 =  0%   |
  4   21ms    14/ 100 = 14%     1/ 100 =  1%  10.54.247.14
                                0/ 100 =  0%   |
  5   24ms    13/ 100 = 13%     0/ 100 =  0%  10.54.1.196
Trace complete.
```

When **pathping** is run, the first results list the path. Next, a busy message is displayed for approximately 90 seconds (the time varies by hop count). During this time, information is gathered from all routers previously listed and from the links between them. At the end of this period, the test results are displayed.

In the above sample report, the **This Node/Link**, **Lost/Sent = Pct** and **address** columns show that the link between *172.16.87.218* and *192.168.52.1* is dropping 13% of the packets. The routers at hops 2 and 4 are also dropping packets addressed to them, but this loss doesn't affect their ability to forward traffic that isn't addressed to them.

The loss rates displayed for the links, identified as a vertical bar (**|**) in the **address** column, indicate link congestion that is causing the loss of packets that are being forwarded on the path. The loss rates displayed for routers (identified by their IP addresses) indicate that these routers might be overloaded.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [tracert command](tracert.md)
