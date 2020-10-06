---
title: Packet Monitor (PacketMon) 
description: This topic provides an overview of the Packet Monitor (PacketMon) network diagnostics tool.
ms.topic: overview
author: khdownie
ms.author: v-kedow
ms.date: 10/6/2020
---

# Packet Monitor \(PacketMon\)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

Packet Monitor (PacketMon) is an in-box cross-component network diagnostics tool for Windows. It can be used for packet capture, packet drop detection, packet filtering and counting. The tool is especially helpful in virtualization scenarios, like container networking and SDN, since it provides visibility within the networking stack. It is available in-box via the pktmon.exe command, and via Windows Admin Center extensions. 

## How Packet Monitor works

Any machine that communicates over the network has at least one network adapter. All the components between this adapter and an application form a networking stack. A networking stack is a set of networking components that process and move networking traffic. In traditional scenarios, the networking stack is small, and all the packet routing and switching happens in external devices. 

:::image type="content" source="media/networking-stack.png" alt-text="Networking stack in traditional scenarios":::

However, with the advent of network virtualization, the size of the networking stack has multiplied. This extended networking stack now includes components, like the Virtual Switch, that handle packet processing and switching. Such flexible environment allows for much better resource utilization and security isolation, but it also leaves more room for configuration mistakes that are hard to diagnose. Accordingly, a visibility within the networking stack is needed to pinpoint these mistakes, and PacketMon provides that visibility.

:::image type="content" source="media/packet-capture.png" alt-text="PacketMon's cross-component packet capture":::

PacketMon intercepts packets at multiple locations throughout the networking stack, exposing the packet route. If a packet was dropped by a supported component in the networking stack, PacketMon will report that packet drop. This allows users to differentiate between a component that is the intended destination for a packet and a component that is interfering with a packet. Additionally, PacketMon will report drop reasons; for example, MTU Mistmatch, or Filtered VLAN, etc. These drop reasons provide the root cause of the issue without the need to exhaust all the possibilities. PacketMon also provides packet counters for each intercept point to allow a high-level packet flow examination without the need for time-consuming log analysis.

:::image type="content" source="media/drop-detection.png" alt-text="PacketMon's drop detection":::

## Packet Monitor functionality

Packetmon's functionality has been evolving through Windows releases. The table below shows PacketMon's major capabilities and its corresponding Windows release.

## Get started with Packet Monitor

The following resources are available to help you get started using Packet Monitor.
