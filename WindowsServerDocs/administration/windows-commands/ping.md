---
title: ping
description: Reference article for the ping command, which verifies network connectivity.
ms.topic: reference
ms.assetid: 49272671-2eec-4fa5-881f-65c24cfbef52
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 09/15/2023
---

# ping

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Verifies IP-level connectivity to another TCP/IP computer by sending Internet Control Message Protocol (ICMP) echo Request messages. The receipt of the corresponding echo Reply messages is displayed, along with round-trip times. ping is the primary TCP/IP command used to troubleshoot connectivity, reachability, and name resolution. Used without parameters, this command displays Help content.

You can also use this command to test both the computer name and the IP address of the computer. If pinging the IP address is successful, but pinging the computer name isn't, you might have a name resolution problem. In this case, make sure the computer name you're specifying can be resolved through the local Hosts file, by using Domain Name System (DNS) queries, or through NetBIOS name resolution techniques.

> [!NOTE]
> This command is available only if the Internet Protocol (TCP/IP) is installed as a component in the properties of a network adapter in Network Connections.

## Syntax

```
ping [/t] [/a] [/n <count>] [/l <size>] [/f] [/I <TTL>] [/v <TOS>] [/r <count>] [/s <count>] [{/j <hostlist> | /k <hostlist>}] [/w <timeout>] [/R] [/S <Srcaddr>] [/4] [/6] <targetname>
```

### Parameters

| Parameter | Description |
|:--:|---|
| /t | Specifies ping continue sending echo Request messages to the destination until interrupted. To interrupt and display statistics, press CTRL+ENTER. To interrupt and quit this command, press CTRL+C. |
| /a | Specifies reverse name resolution be performed on the destination IP address. If this operation is successful, ping displays the corresponding host name. |
| /n `<count>` | Specifies the number of echo Request messages be sent. The default is 4. |
| /l `<size>` | Specifies the length, in bytes, of the **Data** field in the echo Request messages. The default is 32. The maximum size is 65,500. |
| /f | Specifies that echo Request messages are sent with the **Do not Fragment** flag in the IP header set to 1 (available on IPv4 only). The echo Request message can't be fragmented by routers in the path to the destination. This parameter is useful for troubleshooting path Maximum Transmission Unit (PMTU) problems. |
| /I `<TTL>` | Specifies the value of the Time To Live (TTL) field in the IP header for echo Request messages sent. The default is the default TTL value for the host. The maximum *TTL* is 255. |
| /v `<TOS>` | Specifies the value of the Type Of Service (TOS) field in the IP header for echo Request messages sent (available on IPv4 only). The default is 0. *TOS* is specified as a decimal value from 0 through 255. |
| /r `<count>` | Specifies the **Record Route** option in the IP header is used to record the path taken by the echo Request message and corresponding echo Reply message (available on IPv4 only). Each hop in the path uses an entry in the **Record Route** option. If possible, specify a *count* equal to or greater than the number of hops between the source and destination. The *count* must be a minimum of 1 and a maximum of 9. |
| /s `<count>` | Specifies that the **Internet timestamp** option in the IP header is used to record the time of arrival for the echo Request message and corresponding echo Reply message for each hop. The *count* must be a minimum of 1 and a maximum of 4. This parameter is required for link-local destination addresses. |
| /j `<hostlist>` | Specifies the echo Request messages use the **Loose Source Route** option in the IP header with the set of intermediate destinations specified in *hostlist* (available on IPv4 only). With loose source routing, successive intermediate destinations can be separated by one or multiple routers. The maximum number of addresses or names in the host list is 9. The host list is a series of IP addresses (in dotted decimal notation) separated by spaces. |
| /k `<hostlist>` | Specifies the echo Request messages use the **Strict Source Route** option in the IP header with the set of intermediate destinations specified in *hostlist* (available on IPv4 only). With strict source routing, the next intermediate destination must be directly reachable (it must be a neighbor on an interface of the router). The maximum number of addresses or names in the host list is 9. The host list is a series of IP addresses (in dotted decimal notation) separated by spaces. |
| /w `<timeout>` | Specifies the amount of time, in milliseconds, to wait for the echo Reply message corresponding to a given echo Request message. If the echo Reply message isn't received within the time-out, the "Request timed out" error message is displayed. The default time-out is 4000 (4 seconds). |
| /R | Specifies the round-trip path is traced (available on IPv6 only). |
| /S `<Srcaddr>` | Specifies the source address to use (available on IPv6 only). |
| /4 | Specifies IPv4 used to ping. This parameter isn't required to identify the target host with an IPv4 address. It's only required to identify the target host by name. |
| /6 | Specifies IPv6 used to ping. This parameter isn't required to identify the target host with an IPv6 address. It's only required to identify the target host by name. |
| `<targetname>` | Specifies the host name or IP address of the destination. |
| /? | Displays help at the command prompt. |

### Example of the ping command output

```
C:\>ping example.microsoft.com
    pinging example.microsoft.com [192.168.239.132] with 32 bytes of data:
    Reply from 192.168.239.132: bytes=32 time=101ms TTL=124
    Reply from 192.168.239.132: bytes=32 time=100ms TTL=124
    Reply from 192.168.239.132: bytes=32 time=120ms TTL=124
    Reply from 192.168.239.132: bytes=32 time=120ms TTL=124
```

### Examples

To ping the destination 10.0.99.221 and resolve 10.0.99.221 to its host name, type:

```
ping /a 10.0.99.221
```

To ping the destination 10.0.99.221 with 10 echo Request messages, each of which has a Data field of 1000 bytes, type:

```
ping /n 10 /l 1000 10.0.99.221
```

To ping the destination 10.0.99.221 and record the route for 4 hops, type:

```
ping /r 4 10.0.99.221
```

To ping the destination 10.0.99.221 and specify the loose source route of 10.12.0.1-10.29.3.1-10.1.44.1, type:

```
ping /j 10.12.0.1 10.29.3.1 10.1.44.1 10.0.99.221
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
