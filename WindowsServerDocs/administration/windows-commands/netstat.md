---
title: netstat
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 60e2718f-93cc-4ceb-bf0e-58a6a6e4fc8b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# netstat

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays active TCP connections, ports on which the computer is listening, Ethernet statistics, the IP routing table, IPv4 statistics (for the IP, ICMP, TCP, and UDP protocols), and IPv6 statistics (for the IPv6, ICMPv6, TCP over IPv6, and UDP over IPv6 protocols). Used without parameters, **netstat** displays active TCP connections. 

## Syntax
```
netstat [-a] [-e] [-n] [-o] [-p <Protocol>] [-r] [-s] [<Interval>]
```

### Parameters

|   Parameter   |                                                                                                                                              Description                                                                                                                                              |
|---------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|      -a       |                                                                                                   Displays all active TCP connections and the TCP and UDP ports on which the computer is listening.                                                                                                   |
|      -e       |                                                                                 Displays Ethernet statistics, such as the number of bytes and packets sent and received. This parameter can be combined with **-s**.                                                                                  |
|      -n       |                                                                               Displays active TCP connections, however, addresses and port numbers are expressed numerically and no attempt is made to determine names.                                                                               |
|      -o       |                          Displays active TCP connections and includes the process ID (PID) for each connection. You can find the application based on the PID on the Processes tab in Windows Task Manager. This parameter can be combined with **-a**, **-n**, and **-p**.                           |
| -p <Protocol> |               Shows connections for the protocol specified by *Protocol*. In this case, the *Protocol* can be tcp, udp, tcpv6, or udpv6. If this parameter is used with **-s** to display statistics by protocol, *Protocol* can be tcp, udp, icmp, ip, tcpv6, udpv6, icmpv6, or ipv6.                |
|      -s       | Displays statistics by protocol. By default, statistics are shown for the TCP, UDP, ICMP, and IP protocols. If the IPv6 protocol is installed, statistics are shown for the TCP over IPv6, UDP over IPv6, ICMPv6, and IPv6 protocols. The **-p** parameter can be used to specify a set of protocols. |
|      -r       |                                                                                                     Displays the contents of the IP routing table. This is equivalent to the route print command.                                                                                                     |
|  <Interval>   |                                                        Redisplays the selected information every *Interval* seconds. Press CTRL+C to stop the redisplay. If this parameter is omitted, **netstat** prints the selected information only once.                                                         |
|      /?       |                                                                                                                                 Displays help at the command prompt.                                                                                                                                  |

## Remarks
-   Parameters used with this command must be prefixed with a hyphen (**-**) rather than a slash (**/**).
-   **netstat** provides statistics for the following:
    -   Proto
        The name of the protocol (TCP or UDP).
    -   Local address
        The IP address of the local computer and the port number being used. The name of the local computer that corresponds to the IP address and the name of the port is shown unless the **-n** parameter is specified. If the port is not yet established, the port number is shown as an asterisk (*).
    -   foreign address
        The IP address and port number of the remote computer to which the socket is connected. The names that corresponds to the IP address and the port are shown unless the **-n** parameter is specified. If the port is not yet established, the port number is shown as an asterisk (*).
    -   (state)
        Indicates the state of a TCP connection. The possible states are as follows:
        CLOSE_WAIT
        CLOSED
        ESTABLISHED
        FIN_WAIT_1
        FIN_WAIT_2
        LAST_ACK
        listEN
        SYN_RECEIVED
        SYN_SEND
        timeD_WAIT
        for more information about the states of a TCP connection, see Rfc 793.
-   This command is available only if the Internet Protocol (TCP/IP) protocol is installed as a component in the properties of a network adapter in Network Connections.

## <a name="BKMK_Examples"></a>Examples
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

## additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)
