---
title: How QoS Policy Works
description: This topic provides an overview of Quality of Service (QoS) Policy, which allows you to use Group Policy to prioritize network traffic bandwidth of specific applications and services in Windows Server 2016.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 25097cb8-b9b1-41c9-b3c7-3610a032e0d8
manager: brianlic
ms.author: lizross
author: eross-msft
---

# How QoS Policy Works

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

When starting up or obtaining updated user or computer configuration Group Policy settings for QoS, the following process occurs.

1. The Group Policy engine retrieves the user or computer configuration Group Policy settings from Active Directory.

2. The Group Policy engine informs the QoS Client-Side Extension that there were changes in QoS policies.

3. The QoS Client-Side Extension sends a QoS policy event notification to the QoS Inspection Module.

4. The QoS Inspection Module retrieves the user or computer QoS policies and stores them.

When a new Transport Layer endpoint \(TCP connection or UDP traffic\) is created, the following process occurs.

1. The Transport Layer component of the TCP/IP stack informs the QoS Inspection Module.

2. The QoS Inspection Module compares the parameters of the Transport Layer endpoint to the stored QoS policies.

3. If a match is found, the QoS Inspection Module contacts Pacer.sys to create a flow, a data structure containing the DSCP value and the traffic throttling settings of the matching QoS policy. If there are multiple QoS policies that match the parameters of the Transport Layer endpoint, the most specific QoS policy is used.

4. Pacer.sys stores the flow and returns a flow number corresponding to the flow to the QoS Inspection Module.

5. The QoS Inspection Module returns the flow number to the Transport Layer.

6. The Transport Layer stores the flow number with the Transport Layer endpoint.

When a packet corresponding to a Transport Layer endpoint marked with a flow number is sent, the following process occurs.

1. The Transport Layer internally marks the packet with the flow number.

2. The Network Layer queries Pacer.sys for the DSCP value corresponding to the flow number of the packet.

3. Pacer.sys returns the DSCP value to the Network Layer.

4. The Network Layer changes the IPv4 TOS field or IPv6 Traffic Class field to the DSCP value specified by Pacer.sys and, for IPv4 packets, calculates the final IPv4 header checksum.

5. The Network Layer hands the packet to the Framing Layer.

6. Because the packet has been marked with a flow number, the Framing Layer hands the packet to Pacer.sys through NDIS 6.x.

7. Pacer.sys uses the flow number of the packet to determine if the packet needs to be throttled, and if so, schedules the packet for sending.

8. Pacer.sys hands the packet either immediately \(if there is no traffic throttling\) or as scheduled \(if there is traffic throttling\) to NDIS 6.x for transmission over the appropriate network adapter.

These processes of Policy-based QoS provide the following advantages.

- The inspection of traffic to determine whether a QoS policy applies is done per-Transport Layer endpoint, rather than per-packet.

- There is no performance impact for traffic that does not match a QoS policy.

- Applications do not need to be modified to take advantage of DSCP-based differentiated service or traffic throttling.

- QoS policies can apply to traffic protected with IPsec.

For the next topic in this guide, see [QoS Policy Architecture](qos-policy-architecture.md).

For the first topic in this guide, see [Quality of Service (QoS) Policy](qos-policy-top.md).
