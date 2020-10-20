---
title: Packet Monitor (Pktmon) 
description: This topic provides an overview of the Packet Monitor (Pktmon) network diagnostics tool.
ms.topic: overview
author: khdownie
ms.author: v-kedow
ms.date: 10/20/2020
---

# Packet Monitor \(Pktmon\)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows 10, Azure Stack HCI, Azure Stack Hub, Azure

Packet Monitor (Pktmon) is an in-box, cross-component network diagnostics tool for Windows. It can be used for packet capture, packet drop detection, packet filtering and counting. The tool is especially helpful in virtualization scenarios, like container networking and SDN, because it provides visibility within the networking stack. It is available in-box via the pktmon.exe command and via Windows Admin Center extensions. 

## Overview

Any machine that communicates over the network has at least one network adapter. All the components between this adapter and an application form a networking stack: a set of networking components that process and move networking traffic. In traditional scenarios, the networking stack is small, and all the packet routing and switching happens in external devices.

<center>

:::image type="content" source="media/networking-stack.png" alt-text="Networking stack in traditional scenarios" border="false":::

</center>

However, with the advent of network virtualization, the size of the networking stack has multiplied. This extended networking stack now includes components like the Virtual Switch that handle packet processing and switching. Such a flexible environment allows for much better resource utilization and security isolation, but it also leaves more room for configuration mistakes that can be hard to diagnose. Packet Monitor provides the enhanced visibility within the networking stack that is often needed to pinpoint these mistakes.

<center>

:::image type="content" source="media/packet-capture.png" alt-text="PacketMon's cross-component packet capture" border="false":::

</center>

Packet Monitor intercepts packets at multiple locations throughout the networking stack, exposing the packet route. If a packet was dropped by a supported component in the networking stack, Packet Monitor will report that packet drop. This allows users to differentiate between a component that is the intended destination for a packet and a component that is interfering with a packet. Additionally, Packet Monitor will report drop reasons; for example, MTU Mistmatch, or Filtered VLAN, etc. These drop reasons provide the root cause of the issue without the need to exhaust all the possibilities. Packet Monitor also provides packet counters for each intercept point, enabling a high-level packet flow examination without the need for time-consuming log analysis.

<center>

:::image type="content" source="media/drop-detection.png" alt-text="PacketMon's drop detection" border="false":::

</center>

## Functionality

Packet Monitor's functionality has evolved through Windows releases. The table below shows its major capabilities and corresponding Windows release.

| Capability                                                                  | RS5 (17763) | 19H1 (18362) | Vibranium (19041) |
|:---------------------------------------------------------------------------:|:-----------:|:------------:|:-----------------:|
| Packet monitoring and counting at multiple locations along networking stack | &#x2611;    | &#x2611;     | &#x2611;          |
| Packets drop detection at multiple stack locations                          | &#x2611;    | &#x2611;     | &#x2611;          |
| Flexible runtime packet filtering                                           | &#x2611;    | &#x2611;     | &#x2611;          |
| Encapsulation support                                                       | &#x2610;    | &#x2611;     | &#x2611;          |
| Network analysis based on TcpDump packet parsing                            | &#x2610;    | &#x2611;     | &#x2611;          |
| Packet metadata (OOB) analysis                                              | &#x2610;    | &#x2610;     | &#x2611;          |
| Real-time on-screen packet monitoring                                       | &#x2610;    | &#x2610;     | &#x2611;          |
| High volume in-memory logging                                               | &#x2610;    | &#x2610;     | &#x2611;          |
| Wireshark and Network Monitor format support                                | &#x2610;    | &#x2610;     | &#x2611;          |

>[!NOTE]
>Azure Stack HCI and Azure Stack Hub customers should expect the Vibranium functionality.

## Limitations

Below are some of Packet Monitor's most significant limitations.

- Wireless media support is available on Iron builds only
- No firewall integration
- Drop reporting is only available for integrated components

## Get started with Packet Monitor

The following resources are available to help you get started using Packet Monitor.

### Pktmon command syntax and formatting

Packet Monitor is available in-box via pktmon.exe command on Vibranium OS (build 19041). You can [use this topic](pktmon-syntax.md) to learn how to understand pktmon syntax, commands, formatting, and output.

### Packet Monitoring extension in Windows Admin Center

The Packet Monitoring extension allows you to operate and consume Packet Monitor through Windows Admin Center. The extension helps you diagnose your network by capturing and displaying network traffic through the networking stack in a log that is easy to follow and manipulate. You can use this topic to learn how to operate the tool and understand its output.

### SDN data path diagnostics extension in Windows Admin Center

SDN Data Path Diagnostics is a tool within the SDN monitoring extension of Windows Admin Center. The tool automates Packet Monitor-based packet captures according to various SDN scenarios, and presents the output in a single view that is easy to follow and manipulate. You can use this topic to learn how to operate the tool and understand its output.

### Microsoft Network Monitor (Netmon) support

Packet Monitor generates logs in ETL format. These logs can be analyzed using Microsoft Network Monitor (Netmon) by using special parsers. This topic explains how to analyze Packet Monitor-generated ETL files within Netmon.

### WireShark (pcapng Format) support

Packet Monitor can convert logs to pcapng format. These logs can be analyzed using WireShark (or any pcapng analyzer). This topic explains the expected output and how to take advantage of it.

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
