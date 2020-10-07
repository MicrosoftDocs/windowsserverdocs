---
title: Packet Monitor (PacketMon) 
description: This topic provides an overview of the Packet Monitor (PacketMon) network diagnostics tool.
ms.topic: overview
author: khdownie
ms.author: v-kedow
ms.date: 10/7/2020
---

# Packet Monitor \(PacketMon\)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

Packet Monitor (PacketMon) is an in-box cross-component network diagnostics tool for Windows. It can be used for packet capture, packet drop detection, packet filtering and counting. The tool is especially helpful in virtualization scenarios, like container networking and SDN, since it provides visibility within the networking stack. It is available in-box via the pktmon.exe command, and via Windows Admin Center extensions. 

## How Packet Monitor works

Any machine that communicates over the network has at least one network adapter. All the components between this adapter and an application form a networking stack. A networking stack is a set of networking components that process and move networking traffic. In traditional scenarios, the networking stack is small, and all the packet routing and switching happens in external devices. 

:::image type="content" align="center" source="media/networking-stack.png" alt-text="Networking stack in traditional scenarios" border="false":::

However, with the advent of network virtualization, the size of the networking stack has multiplied. This extended networking stack now includes components, like the Virtual Switch, that handle packet processing and switching. Such flexible environment allows for much better resource utilization and security isolation, but it also leaves more room for configuration mistakes that are hard to diagnose. Accordingly, a visibility within the networking stack is needed to pinpoint these mistakes, and PacketMon provides that visibility.

:::image type="content" source="media/packet-capture.png" alt-text="PacketMon's cross-component packet capture" border="false":::

PacketMon intercepts packets at multiple locations throughout the networking stack, exposing the packet route. If a packet was dropped by a supported component in the networking stack, PacketMon will report that packet drop. This allows users to differentiate between a component that is the intended destination for a packet and a component that is interfering with a packet. Additionally, PacketMon will report drop reasons; for example, MTU Mistmatch, or Filtered VLAN, etc. These drop reasons provide the root cause of the issue without the need to exhaust all the possibilities. PacketMon also provides packet counters for each intercept point to allow a high-level packet flow examination without the need for time-consuming log analysis.

:::image type="content" source="media/drop-detection.png" alt-text="PacketMon's drop detection" border="false":::

## Packet Monitor functionality

Packetmon's functionality has been evolving through Windows releases. The table below shows PacketMon's major capabilities and its corresponding Windows release.

| Capability                                                                  | RS5 (17763) | 19H1 (18362) | Vibranium (19041) |
|:---------------------------------------------------------------------------:|:-----------:|:------------:|:-----------------:|
| Packet monitoring and counting at multiple locations along networking stack | [x]         | [x]          | [x]               |
| Packets drop detection at multiple stack locations                          | [x]         | [x]          | [x]               |
| Flexible runtime packet filtering                                           | [x]         | [x]          | [x]               |
| Encapsulation support                                                       |             | [x]          | [x]               |
| Network analysis based on TcpDump packet parsing                            |             | [x]          | [x]               |
| Packet metadata (OOB) analysis                                              |             |              | [x]               |
| Real-time on-screen packet monitoring                                       |             |              | [x]               |
| High volume in-memory logging                                               |             |              | [x]               |
| Wireshark and Network Monitor format support                                |             |              | [x]               |

## Packet Monitor limitations

Below are some of PacketMon's most significant limitations. 

- Wireless media support is available on Iron builds only
- No firewall integration
- Drop reporting is only available for integrated components

## Get started with Packet Monitor

The following resources are available to help you get started using Packet Monitor.

### Pktmon - Vibranium OS

PacketMon is available in-box via pktmon.exe command on Vibranium OS (build 19041). You can use this topic to learn how to understand pktmon syntax, command , formatting, and output.

>[!NOTE]
>This same version is also going to be backported to Windows 10 and Windows Server version 1809 (RS5).

### Packet Monitor extension in Windows Admin Center

PacketMon is also available through a single server extension in Windows Admin Center: Packet monitoring. You can use this topic to learn how to operate the tool and understand its output. 

### SDN data path diagnostics extension in Windows Admin Center

PacketMon is available through a cluster extension in Windows Admin Center: SDN Data Path Diagnostics extension. SDN Data Path Diagnostics is a tool within SDN monitoring extension of Windows Admin Center. The tool that automates packet captures based on various SDN scenarios and presents the output in a single view that is easy to follow and manipulate. You can use this topic to learn how to operate the tool and understand its output. 

### PacketMon's Microsoft Network Monitor (Netmon) support

You can use this topic to learn how to parse and analyze PacketMon's etl logs in Netmon.

### PacketMon's WireShark (Pcapng Format) support

You can use this topic to learn how to parse PacketMon's logs in pcapng format to analyze them in WireShark, and learn more information about the output. 

## Provide feedback to engineering team

Report any bugs or give feedback through the feedback hub using the following steps:

1. Launch **Feedback Hub** through the **Start** menu.

1. Select either the **Report a problem** button or the **Suggest a feature** button.

1. Provide meaningful feedback title in **Summarize your issue** box.

1. Provide details and steps to reproduce the issue in the **Give us more detail** box.

1. Select **Network and Internet** as the top category, then **Packet Monitor (pktmon.exe)** as the sub-category.

1. To help us identify and fix the bug faster, capture screenshots, attach pktmon’s output log, and/or recreate the problem.

1. Click **Submit**.

After submitting the feedback/bug, the engineering team will be able to take a look at the feedback and address it.
