---
title: pathping
description: "Learn how to get network latency and loss information using the pathping command."
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ec430125-b1dc-4aad-a7c9-b70f486d9e3c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 07/11/2018
---

# pathping

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Provides information about network latency and network loss at intermediate hops between a source and destination. **pathping** sends multiple echo Request messages to each router between a source and destination over a period of time and then computes results based on the packets returned from each router. Because **pathping** displays the degree of packet loss at any given router or link, you can determine which routers or subnets might be having network problems. 

**pathping** performs the equivalent of the **tracert** command by identifying which routers are on the path. It then sends pings periodically to all of the routers over a specified time period and computes statistics based on the number returned from each. Used without parameters, **pathping** displays help. 

## Syntax
```
pathping [/n] [/h] [/g <Hostlist>] [/p <Period>] [/q <NumQueries> [/w <timeout>] [/i <IPaddress>] [/4 <IPv4>] [/6 <IPv6>][<TargetName>]
```
### Parameters
|Parameter|Description|
|-------|--------|
|/n|Prevents **pathping** from attempting to resolve the IP addresses of intermediate routers to their names. This might expedite the display of **pathping** results.|
|/h \<MaximumHops>|Specifies the maximum number of hops in the path to search for the target (destination). The default is 30 hops.|
|/g \<Hostlist>|Specifies that the echo Request messages use the Loose Source Route option in the IP header with the set of intermediate destinations specified in *Hostlist*. With loose source routing, successive intermediate destinations can be separated by one or multiple routers. The maximum number of addresses or names in the host list is 9. The *Hostlist* is a series of IP addresses (in dotted decimal notation) separated by spaces.|
|/p \<Period>|Specifies the number of milliseconds to wait between consecutive pings. The default is 250 milliseconds (1/4 second).|
|/q \<NumQueries>|Specifies the number of echo Request messages sent to each router in the path. The default is 100 queries.|
|/w \<timeout>|Specifies the number of milliseconds to wait for each reply. The default is 3000 milliseconds (3 seconds).|
|/i \<IPaddress>|Specifies the source address.|
|/4 \<IPv4>|Specifies that pathping uses IPv4 only.|
|/6 \<IPv6>|Specifies that pathping uses IPv6 only.|
|\<TargetName>|Specifies the destination, which is identified either by IP address or host name.|
|/?|Displays help at the command prompt.|

## Remarks
-   **pathping** parameters are case-sensitive.
-   To avoid network congestion, pings should be sent at a sufficiently slow pace.
-   To minimize the effects of burst losses, do not send pings too frequently.
-   When using the **/p** parameter, pings are sent individually to each intermediate hop. Because of this, the interval between two pings sent to the same hop is *period* multiplied by the number of hops.
-   When using the **/w** parameter, multiple pings can be sent in parallel. Because of this, the amount of time specified in the *timeout* parameter is not bounded by the amount of time specified in the *Period* parameter for waiting between pings.
-   This command is available only if the Internet Protocol (TCP/IP) protocol is installed as a component in the properties of a network adapter in Network Connections.

## <a name="BKMK_Examples"></a>Examples

The following example shows **pathping** command output:

```
D:\>pathping /n corp1
Tracing route to corp1 [10.54.1.196]
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
When **pathping** is run, the first results list the path. This is the same path that is shown using the **tracert** command. Next, a busy message is displayed for approximately 90 seconds (the time varies by hop count). During this time, information is gathered from all routers previously listed and from the links between them. at the end of this period, the test results are displayed.

In the sample report above, the **This Node/Link**, **Lost/Sent = Pct** and **address** columns show that the link between 172.16.87.218 and 192.168.52.1 is dropping 13 percent of the packets. The routers at hops 2 and 4 also are dropping packets addressed to them, but this loss does not affect their ability to forward traffic that is not addressed to them.

The loss rates displayed for the links, identified as a vertical bar (**|**) in the **address** column, indicate link congestion that is causing the loss of packets that are being forwarded on the path. The loss rates displayed for routers (identified by their IP addresses) indicate that these routers might be overloaded.

## Additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)