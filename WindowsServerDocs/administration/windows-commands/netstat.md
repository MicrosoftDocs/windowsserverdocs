---
title: netstat
description: Reference article for the netstat command, which displays active TCP connections, ports on which the computer is listening, Ethernet statistics, the IP routing table, IPv4 statistics, and IPv6 statistics.
ms.topic: reference
ms.assetid: 60e2718f-93cc-4ceb-bf0e-58a6a6e4fc8b
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# netstat

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays active TCP connections, ports on which the computer is listening, Ethernet statistics, the IP routing table, IPv4 statistics (for the IP, ICMP, TCP, and UDP protocols), and IPv6 statistics (for the IPv6, ICMPv6, TCP over IPv6, and UDP over IPv6 protocols). Used without parameters, this command displays active TCP connections.

> [!IMPORTANT]
> This command is available only if the Internet Protocol (TCP/IP) protocol is installed as a component in the properties of a network adapter in Network Connections.

## Syntax

```
netstat [-a] [-b] [-e] [-n] [-o] [-p <Protocol>] [-r] [-s] [<interval>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -a | Displays all active TCP connections and the TCP and UDP ports on which the computer is listening. |
| -b | Displays the executable involved in creating each connection or listening port. In some cases well-known executables host multiple independent components, and in these cases the sequence of components involved in creating the connection or listening port is displayed. In this case the executable name is in [] at the bottom, on top is the component it called, and so forth until TCP/IP was reached. Note that this option can be time-consuming and will fail unless you have sufficient permissions.
| -e | Displays Ethernet statistics, such as the number of bytes and packets sent and received. This parameter can be combined with **-s**. |
| -n | Displays active TCP connections, however, addresses and port numbers are expressed numerically and no attempt is made to determine names. |
| -o | Displays active TCP connections and includes the process ID (PID) for each connection. You can find the application based on the PID on the Processes tab in Windows Task Manager. This parameter can be combined with **-a**, **-n**, and **-p**. |
| -p `<Protocol>` | Shows connections for the protocol specified by *Protocol*. In this case, the *Protocol* can be tcp, udp, tcpv6, or udpv6. If this parameter is used with **-s** to display statistics by protocol, *Protocol* can be tcp, udp, icmp, ip, tcpv6, udpv6, icmpv6, or ipv6. |
| -s | Displays statistics by protocol. By default, statistics are shown for the TCP, UDP, ICMP, and IP protocols. If the IPv6 protocol is installed, statistics are shown for the TCP over IPv6, UDP over IPv6, ICMPv6, and IPv6 protocols. The **-p** parameter can be used to specify a set of protocols. |
| -r | Displays the contents of the IP routing table. This is equivalent to the route print command. |
| `<interval>` | Redisplays the selected information every *interval* seconds. Press CTRL+C to stop the redisplay. If this parameter is omitted, this command prints the selected information only once. |
| /? | Displays help at the command prompt. |

#### Remarks

- The **netstat** command provides statistics for the following:

    | Parameter | Description |
    | --------- | ----------- |
    | Proto | The name of the protocol (TCP or UDP). |
    | Local address | The IP address of the local computer and the port number being used. The name of the local computer that corresponds to the IP address and the name of the port is shown unless the **-n** parameter is specified. If the port is not yet established, the port number is shown as an asterisk (*). |
    | Foreign address | The IP address and port number of the remote computer to which the socket is connected. The names that corresponds to the IP address and the port are shown unless the **-n** parameter is specified. If the port is not yet established, the port number is shown as an asterisk (*). |
    | State | Indicates the state of a TCP connection, including:<ul><li>CLOSE_WAIT</li><li>CLOSED</li><li>ESTABLISHED</li><li>FIN_WAIT_1</li><li>FIN_WAIT_2</li><li>LAST_ACK</li><li>LISTEN</li><li>SYN_RECEIVED</li><li>SYN_SEND</li><li>TIMED_WAIT</li></ul> |

### Examples

To display both the Ethernet statistics and the statistics for all protocols, type:

```
netstat -e -s
```

To display the statistics for only the TCP and UDP protocols, type:

```
netstat -s -p tcp udp
```

To display active TCP connections and the process IDs every 5 seconds, type:

```
netstat -o 5
```

To display active TCP connections and the process IDs using numerical form, type:

```
netstat -n -o
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
