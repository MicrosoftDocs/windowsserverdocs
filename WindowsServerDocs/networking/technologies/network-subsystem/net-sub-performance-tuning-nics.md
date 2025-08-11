---
title: Network Adapter Performance Tuning in Windows Server
description: Learn how to tune network adapter performance in Windows Server. Optimize throughput, configure offload features, and improve network performance with proven tuning techniques.
ms.topic: concept-article
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 07/07/2025
---

# Network adapter performance tuning in Windows Server

This article describes how to optimize network adapter performance in Windows Server environments. Network adapter performance tuning can significantly improve throughput, reduce latency, and maximize resource utilization for your server workloads.

The correct tuning settings for your network adapters depend on the following variables:

- The network adapter and its feature set
- The type of workload that the server performs
- The server hardware and software resources
- Your performance goals for the server

The optimal tuning settings depend on your specific hardware configuration, workload requirements, and performance objectives. Before implementing changes, evaluate your current network performance and identify areas for improvement. Some features and settings might vary between versions.

The following sections describe some of your performance tuning options.

## Offload features

Network offload features transfer processing tasks from the CPU to the network adapter hardware, reducing system overhead and improving overall network performance. Common offload features include TCP checksum offload, Large Send Offload (LSO), and Receive Side Scaling (RSS).

Enabling network adapter offload features is usually beneficial. However, the network adapter might not be powerful enough to handle the offload capabilities with high throughput. For example, consider a network adapter with limited hardware resources. In that case, enabling segmentation offload features might reduce the maximum sustainable throughput of the adapter. However, if the reduced throughput is acceptable, you should enable the segmentation offload features.

Some network adapters require you to enable offload features independently for the send and receive paths.

> [!IMPORTANT]
> Don't use the offload features **IPsec Task Offload** or **TCP Chimney Offload**. These technologies are deprecated in Windows Server 2016, and might adversely affect server and networking performance. In addition, Microsoft might not support these technologies in the future.

## Receive-side scaling (RSS) for web servers

RSS can improve web scalability and performance when there are fewer network adapters than logical processors on the server. When all the web traffic is going through the RSS-capable network adapters, the server can process incoming web requests from different connections simultaneously across different CPUs.

> [!IMPORTANT]
> Avoid using both non-RSS network adapters and RSS-capable network adapters on the same server. Because of the load distribution logic in RSS and Hypertext Transfer Protocol (HTTP), performance might be severely degraded if a non-RSS-capable network adapter accepts web traffic on a server that has one or more RSS-capable network adapters. In this circumstance, you should use RSS-capable network adapters or disable RSS on the network adapter properties **Advanced Properties** tab.
>
> To determine whether a network adapter is RSS-capable, you can view the RSS information on the network adapter properties **Advanced Properties** tab.

### RSS profiles and RSS queues

The default RSS predefined profile is `NUMAStatic`. Before you start using RSS profiles, review the available profiles to understand when they're beneficial and how they apply to your network environment and hardware.

For example, open **Task Manager** and review the logical processors on your server. If they seem to be underutilized for receive traffic, you can try increasing the number of RSS queues from the default of two to the maximum that your network adapter supports. Your network adapter might have options to change the number of RSS queues as part of the driver.

## Network adapter resources

For network adapters that allow you to manually configure resources such as receive and send buffers, you should increase the allocated resources.

Some network adapters set their receive buffers low to conserve allocated memory from the host. The low value results in dropped packets and decreased performance. Therefore, for receive-intensive scenarios, we recommend that you increase the receive buffer value to the maximum.

If a network adapter doesn't expose manual resource configuration, either it dynamically configures the resources, or the resources are set to a fixed value that can't be changed.

### Interrupt moderation

To control interrupt moderation, some network adapters expose different interrupt moderation levels, different buffer coalescing parameters (sometimes separately for send and receive buffers), or both.

You should consider interrupt moderation for CPU-bound workloads. When using interrupt moderation, consider the trade-off between the host CPU savings and latency versus the increased host CPU savings because of more interrupts and less latency. If the network adapter doesn't perform interrupt moderation, but it does expose buffer coalescing, you can improve performance by increasing the number of coalesced buffers to allow more buffers per send or receive.

## Low-latency packet processing

Many network adapters provide options to optimize operating system-induced latency. Latency is the elapsed time between the network driver processing an incoming packet and the network driver sending the packet back. This time is usually measured in microseconds. For comparison, the transmission time for packet transmissions over long distances is usually measured in milliseconds (an order of magnitude larger). This tuning doesn't reduce the time a packet spends in transit.

The following list provides some performance tuning suggestions for microsecond-sensitive networks:

- If your BIOS supports it, set the computer BIOS to **High Performance**, with `C-states` disabled. Some systems provide higher performance if the operating system controls power management. You can check and adjust your power management settings from power settings or by using the `powercfg` command. For more information, see [Powercfg Command-Line Options](/windows-hardware/design/device-experiences/powercfg-command-line-options).

- Set the operating system power management profile to **High Performance System**. This setting doesn't work properly if the system BIOS is set to disable operating system control of power management.

- Enable static offloads. For example, enable the UDP Checksums, TCP Checksums, and Send Large Offload (LSO) settings.

- If the traffic is multi-streamed, such as when receiving high-volume multicast traffic, enable RSS.

- Disable the **Interrupt Moderation** setting for network card drivers that require the lowest possible latency. Remember, this configuration can use more CPU time and it represents a tradeoff.

- Handle network adapter interrupts and DPCs on a core processor that shares CPU cache with the core that is being used by the program (user thread) that is handling the packet. CPU affinity tuning can be used to direct a process to certain logical processors with RSS configuration. Using the same core for the interrupt, DPC, and user mode thread exhibits worse performance as load increases because the ISR, DPC, and thread contend for the use of the core.

## System management interrupts

Many hardware systems use System Management Interrupts (SMI) for various maintenance functions, such as reporting error correction code (ECC) memory errors, maintaining legacy USB compatibility, controlling the fan, and managing BIOS-controlled power settings.

The SMI is the highest-priority interrupt on the system, and places the CPU in a management mode. This mode preempts all other activity while SMI runs an interrupt service routine, typically contained in BIOS. Unfortunately, this behavior can result in latency spikes of 100 microseconds or more.

If you need to achieve the lowest latency, you should request a BIOS version from your hardware provider that reduces SMIs to the lowest degree possible. These BIOS versions are frequently referred to as *low latency BIOS* or *SMI free BIOS*. In some cases, it isn't possible for a hardware platform to eliminate SMI activity altogether because it's used to control essential functions such as cooling fans.

The operating system can't control SMIs because the logical processor is running in a special maintenance mode, which prevents operating system intervention.

## TCP receive window autotuning

The Windows network stack uses a feature that is named *TCP receive window autotuning level* to negotiate the TCP receive window size. This feature can negotiate a defined receive window size for every TCP communication during the TCP Handshake and can improve the performance of TCP connections.

Previously the Windows network stack used a fixed-size receive window of 65,535 bytes that limited the overall potential throughput for connections. The total achievable throughput of TCP connections could limit network usage scenarios. The TCP receive window autotuning  enables these scenarios to fully use the network.

For a TCP receive window that has a particular size, you can use the following equation to calculate the total throughput of a single connection:

> *Total achievable throughput in bytes* = *TCP receive window size in bytes* \* (1 / *connection latency in seconds*)

For example, for a 1Gbps connection that has a latency of 10 ms, the total achievable throughput is only 51 Mbps. This value is reasonable for a large corporate network infrastructure. However, by using autotuning to adjust the receive window, the connection can achieve the full line rate of 1 Gbps.

Some applications define the size of the TCP receive window. If the application doesn't define the receive window size, the link speed determines the size as follows:

| Link speed | Receive window size |
|------------|-------------|
| Less than 1 Mbps | 8 KB |
| 1 Mbps to 100 Mbps | 17 KB |
| 100 Mbps to 10 Gbps | 64 KB |
| 10 Gbps or faster | 128 KB |

For example, on a computer that has a 1 Gbps network adapter installed, the window size should be 64 KB.

This feature also makes full use of other features to improve network performance. These features include the rest of the TCP options that are defined in [RFC 1323](https://tools.ietf.org/html/rfc1323). Windows-based computers can use these features to negotiate TCP receive window sizes that are smaller but are scaled at a defined value, depending on the configuration. This behavior makes the sizes easier to handle for networking devices.

> [!NOTE]
> You might experience an issue in which the network device isn't compliant with the **TCP window scale option**, as defined in [RFC 1323](https://tools.ietf.org/html/rfc1323) and, therefore, doesn't support the scale factor. In such cases, contact your network device vendor.

### Autotuning levels

You can set TCP receive window autotuning to any of five levels. The default level is **Normal**. The following table describes the levels.

| Level | Hexadecimal value | Comments |
|--|--|--|
| Normal (default) | 0x8 (scale factor of 8) | Set the TCP receive window to grow to accommodate almost all scenarios. |
| Disabled | No scale factor available | Set the TCP receive window at its default value. |
| Restricted | 0x4 (scale factor of 4) | Set the TCP receive window to grow beyond its default value, but limit such growth in some scenarios. |
| Highly Restricted | 0x2 (scale factor of 2) | Set the TCP receive window to grow beyond its default value, but do so very conservatively. |
| Experimental | 0xE (scale factor of 14) | Set the TCP receive window to grow to accommodate extreme scenarios. |

If you use an application to capture network packets, the application should report data that resembles the following examples for different window autotuning level settings.

#### Autotuning level: Normal (default state)

This example shows the output of a packet capture tool when the TCP receive window autotuning level is set to **Normal**. The scale factor is 8.

```output
Frame: Number = 492, Captured Frame Length = 66, MediaType = ETHERNET
+ Ethernet: Etype = Internet IP (IPv4),DestinationAddress:[D8-FE-E3-65-F3-FD],SourceAddress:[C8-5B-76-7D-FA-7F]
+ Ipv4: Src = 192.169.0.5, Dest = 192.169.0.4, Next Protocol = TCP, Packet ID = 2667, Total IP Length = 52
- Tcp: [Bad CheckSum]Flags=......S., SrcPort=60975, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=4075590425, Ack=0, Win=64240 ( Negotiating scale factor 0x8 ) = 64240
SrcPort: 60975
DstPort: Microsoft-DS(445)
SequenceNumber: 4075590425 (0xF2EC9319)
AcknowledgementNumber: 0 (0x0)
+ DataOffset: 128 (0x80)
+ Flags: ......S. ---------------------------------------------------------> SYN Flag set
Window: 64240 ( Negotiating scale factor 0x8 ) = 64240 ---------> TCP Receive Window set as 64K as per NIC Link bitrate. Note it shows the 0x8 Scale Factor.
Checksum: 0x8182, Bad
UrgentPointer: 0 (0x0)
- TCPOptions:
+ MaxSegmentSize: 1
+ NoOption:
+ WindowsScaleFactor: ShiftCount: 8 -----------------------------> Scale factor, defined by AutoTuningLevel
+ NoOption:
+ NoOption:
+ SACKPermitted:
```

#### Autotuning level: Disabled

This example shows the output of a packet capture tool when the TCP receive window autotuning level is set to **Disabled**. The scale factor isn't used.

```output
Frame: Number = 353, Captured Frame Length = 62, MediaType = ETHERNET
+ Ethernet: Etype = Internet IP (IPv4),DestinationAddress:[D8-FE-E3-65-F3-FD],SourceAddress:[C8-5B-76-7D-FA-7F]
+ Ipv4: Src = 192.169.0.5, Dest = 192.169.0.4, Next Protocol = TCP, Packet ID = 2576, Total IP Length = 48
- Tcp: [Bad CheckSum]Flags=......S., SrcPort=60956, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=2315885330, Ack=0, Win=64240 ( ) = 64240
SrcPort: 60956
DstPort: Microsoft-DS(445)
SequenceNumber: 2315885330 (0x8A099B12)
AcknowledgementNumber: 0 (0x0)
+ DataOffset: 112 (0x70)
+ Flags: ......S. ---------------------------------------------------------> SYN Flag set
Window: 64240 ( ) = 64240 ----------------------------------------> TCP Receive Window set as 64K as per NIC Link bitrate. Note there is no Scale Factor defined. In this case, Scale factor is not being sent as a TCP Option, so it will not be used by Windows.
Checksum: 0x817E, Bad
UrgentPointer: 0 (0x0)
- TCPOptions:
+ MaxSegmentSize: 1
+ NoOption:
+ NoOption:
+ SACKPermitted:
```

#### Autotuning level: Restricted

This example shows the output of a packet capture tool when the TCP receive window autotuning level is set to **Restricted**. The scale factor is 4.

```output
Frame: Number = 3, Captured Frame Length = 66, MediaType = ETHERNET
+ Ethernet: Etype = Internet IP (IPv4),DestinationAddress:[D8-FE-E3-65-F3-FD],SourceAddress:[C8-5B-76-7D-FA-7F]
+ Ipv4: Src = 192.169.0.5, Dest = 192.169.0.4, Next Protocol = TCP, Packet ID = 2319, Total IP Length = 52
- Tcp: [Bad CheckSum]Flags=......S., SrcPort=60890, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=1966088568, Ack=0, Win=64240 ( Negotiating scale factor 0x4 ) = 64240
SrcPort: 60890
DstPort: Microsoft-DS(445)
SequenceNumber: 1966088568 (0x75302178)
AcknowledgementNumber: 0 (0x0)
+ DataOffset: 128 (0x80)
+ Flags: ......S. ---------------------------------------------------------> SYN Flag set
Window: 64240 ( Negotiating scale factor 0x4 ) = 64240 ---------> TCP Receive Window set as 64K as per NIC Link bitrate. Note it shows the 0x4 Scale Factor.
Checksum: 0x8182, Bad
UrgentPointer: 0 (0x0)
- TCPOptions:
+ MaxSegmentSize: 1
+ NoOption:
+ WindowsScaleFactor: ShiftCount: 4 -------------------------------> Scale factor, defined by AutoTuningLevel.
+ NoOption:
+ NoOption:
+ SACKPermitted:
```

#### Autotuning level: Highly restricted

This example shows the output of a packet capture tool when the TCP receive window autotuning level is set to **Highly Restricted**. The scale factor is 2.

```output
Frame: Number = 115, Captured Frame Length = 66, MediaType = ETHERNET
+ Ethernet: Etype = Internet IP (IPv4),DestinationAddress:[D8-FE-E3-65-F3-FD],SourceAddress:[C8-5B-76-7D-FA-7F]
+ Ipv4: Src = 192.169.0.5, Dest = 192.169.0.4, Next Protocol = TCP, Packet ID = 2388, Total IP Length = 52
- Tcp: [Bad CheckSum]Flags=......S., SrcPort=60903, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=1463725706, Ack=0, Win=64240 ( Negotiating scale factor 0x2 ) = 64240
SrcPort: 60903
DstPort: Microsoft-DS(445)
SequenceNumber: 1463725706 (0x573EAE8A)
AcknowledgementNumber: 0 (0x0)
+ DataOffset: 128 (0x80)
+ Flags: ......S. ---------------------------------------------------------> SYN Flag set
Window: 64240 ( Negotiating scale factor 0x2 ) = 64240 ---------> TCP Receive Window set as 64K as per NIC Link bitrate. Note it shows the 0x2 Scale Factor.
Checksum: 0x8182, Bad
UrgentPointer: 0 (0x0)
- TCPOptions:
+ MaxSegmentSize: 1
+ NoOption:
+ WindowsScaleFactor: ShiftCount: 2 ------------------------------> Scale factor, defined by AutoTuningLevel
+ NoOption:
+ NoOption:
+ SACKPermitted:
```

#### Autotuning level: Experimental

This example shows the output of a packet capture tool when the TCP receive window autotuning level is set to **Experimental**. The scale factor is 14.

```output
Frame: Number = 238, Captured Frame Length = 66, MediaType = ETHERNET
+ Ethernet: Etype = Internet IP (IPv4),DestinationAddress:[D8-FE-E3-65-F3-FD],SourceAddress:[C8-5B-76-7D-FA-7F]
+ Ipv4: Src = 192.169.0.5, Dest = 192.169.0.4, Next Protocol = TCP, Packet ID = 2490, Total IP Length = 52
- Tcp: [Bad CheckSum]Flags=......S., SrcPort=60933, DstPort=Microsoft-DS(445), PayloadLen=0, Seq=2095111365, Ack=0, Win=64240 ( Negotiating scale factor 0xe ) = 64240
SrcPort: 60933
DstPort: Microsoft-DS(445)
SequenceNumber: 2095111365 (0x7CE0DCC5)
AcknowledgementNumber: 0 (0x0)
+ DataOffset: 128 (0x80)
+ Flags: ......S. ---------------------------------------------------------> SYN Flag set
Window: 64240 ( Negotiating scale factor 0xe ) = 64240 ---------> TCP Receive Window set as 64K as per NIC Link bitrate. Note it shows the 0xe Scale Factor.
Checksum: 0x8182, Bad
UrgentPointer: 0 (0x0)
- TCPOptions:
+ MaxSegmentSize: 1
+ NoOption:
+ WindowsScaleFactor: ShiftCount: 14 -----------------------------> Scale factor, defined by AutoTuningLevel
+ NoOption:
+ NoOption:
+ SACKPermitted:
```

### Review and configure TCP receive window autotuning level

You can use either Windows PowerShell cmdlets or the `netsh` Windows command to review or change the TCP receive window autotuning level.

> [!NOTE]
> Starting with Windows Server 2019, you can no longer use the registry to configure the TCP receive window size. For more information about the deprecated settings, see [Deprecated TCP parameters](#deprecated-tcp-parameters).

# [PowerShell](#tab/powershell)

You can use the `Get-NetTCPSetting` cmdlet to review or modify the autotuning level. To review and change the current setting:

1. Open PowerShell as an administrator and run the following cmdlet:

   ```PowerShell
   Get-NetTCPSetting | Select SettingName,AutoTuningLevelLocal
   ```

   The output is similar to the following example:

   ```output
   SettingName          AutoTuningLevelLocal
   -----------          --------------------
   Automatic
   InternetCustom       Normal
   DatacenterCustom     Normal
   Compat               Normal
   Datacenter           Normal
   Internet             Normal
   ```

1. To change the setting, run the following command. Be sure to set `<value>` to your desired autotuning level. For more information, see [Set-NetTCPSetting](/powershell/module/nettcpip/set-nettcpsetting).

   ```PowerShell
   Set-NetTCPSetting -AutoTuningLevelLocal <value>
   ```

# [netsh](#tab/netsh)

You can use netsh to review or modify the autotuning level. To review and change the current setting:

1. Open a Command Prompt window as an administrator and run the following command:

   ```cmd
   netsh interface tcp show global
   ```

   The output is similar to the following example:

   ```output
   Querying active state...
   
   TCP Global Parameters
   -----
   Receive-Side Scaling State : enabled
   Chimney Offload State : disabled
   Receive Window Auto-Tuning Level : normal
   Add-On Congestion Control Provider : default
   ECN Capability : disabled
   RFC 1323 Timestamps : disabled
   Initial RTO : 3000
   Receive Segment Coalescing State : enabled
   Non Sack Rtt Resiliency : disabled
   Max SYN Retransmissions : 2
   Fast Open : enabled
   Fast Open Fallback : enabled
   Pacing Profile : off
   ```

1. To change the setting, run the following command. Be sure to set `<value>` to your desired autotuning level from one of the following values: `disabled`, `highlyrestricted`, `restricted`, `normal`, or `experimental`.

   ```cmd
   netsh interface tcp set global autotuninglevel=<value>
   ```

---

## Windows Filtering Platform

Windows Filtering Platform (WFP), introduced in Windows Server 2008, provides APIs to non-Microsoft independent software vendors (ISVs) to create packet processing filters. WFP allows third-party software to inspect, modify, or filter network traffic at various layers of the network stack. While this functionality is essential for security applications, it can introduce performance overhead if not implemented correctly. Examples include firewall and antivirus software.

A poorly written WFP filter can significantly decrease a server's networking performance. For more information, see [Porting Packet-Processing Drivers and Apps to WFP](/windows-hardware/drivers/network/porting-packet-processing-drivers-and-apps-to-wfp) in the Windows Dev Center.

## Deprecated TCP parameters

The following registry settings from Windows Server 2003 are no longer supported, and are ignored in later versions.

- **TcpWindowSize**
- **NumTcbTablePartitions**
- **MaxHashTableSize**

All of these settings were located in the following registry subkey: `HKEY_LOCAL_MACHINE\System\CurrentControlSet\Services\Tcpip\Parameters`
