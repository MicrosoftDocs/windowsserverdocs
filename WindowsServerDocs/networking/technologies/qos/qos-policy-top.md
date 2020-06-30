---
title: Quality of Service (QoS) Policy
description: This topic provides an overview of Quality of Service (QoS) Policy, which allows you to use Group Policy to prioritize network traffic bandwidth of specific applications and services in Windows Server 2016.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 16918506-102c-482e-89d3-004ad8d6aabe
manager: brianlic
ms.author: lizross
author: eross-msft
---

# Quality of Service \(QoS\) Policy

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use QoS Policy as a central point of network bandwidth management across your entire Active Directory infrastructure by creating QoS profiles, whose settings are distributed with Group Policy.

>[!NOTE]
>  In addition to this topic, the following QoS Policy documentation is available.  
>   
>  - [Getting Started with QoS Policy](qos-policy-get-started.md)
>  - [Manage QoS Policy](qos-policy-manage.md)
>  - [QoS Policy Frequently Asked Questions](qos-policy-faq.md)

QoS policies are applied to a user login session or a computer as part of a Group Policy object \(GPO\) that you have linked to an Active Directory container, such as a domain, site, or organizational unit \(OU\).

QoS traffic management occurs below the application layer, which means that your existing applications do not need to be modified to benefit from the advantages that are provided by QoS policies.

## Operating Systems that Support QoS Policy

You can use QoS policy to manage bandwidth for computers or users with the following Microsoft operating systems.

- Windows Server 2016
- Windows 10
- Windows Server 2012 R2
- Windows 8.1
- Windows Server 2012
- Windows 8
- Windows Server 2008 R2
- Windows 7
- Windows Server 2008
- Windows Vista

### Location of QoS Policy in Group Policy

In Windows Server 2016 Group Policy Management Editor, the path to QoS Policy for Computer Configuration is the following.

**Default Domain Policy | Computer Configuration | Policies | Windows Settings | Policy\-based QoS**

This path is illustrated in the following image.

![Location of QoS Policy in Group Policy](../../media/QoS/QoS-Gp.jpg)

In Windows Server 2016 Group Policy Management Editor, the path to QoS Policy for User Configuration is the following.

**Default Domain Policy | User Configuration | Policies | Windows Settings | Policy\-based QoS**

By default no QoS policies are configured.

## Why Use QoS Policy?
  
As traffic increases on your network, it is increasingly important for you to balance network performance with the cost of service - but network traffic is not normally easy to prioritize and manage.

On your network, mission\-critical and latency\-sensitive applications must compete for network bandwidth against lower priority traffic. At the same time, some users and computers with specific network performance requirements might require differentiated service levels.

The challenges of providing cost-effective, predictable network performance levels often first appear over wide area network \(WAN\) connections or with latency-sensitive applications, like voice over IP \(VoIP\) and video streaming. However, the end-goal of providing predictable network service levels applies to any network environment \(for example, an Enterprises' local area network\), and to more than VoIP applications, such as your company's custom line\-of\-business applications.
  
Policy-based QoS is the network bandwidth management tool that provides you with network control -  based on applications, users, and computers. 

When you use QoS Policy, your applications do not need to be written for specific application programming interfaces \(APIs\). This gives you the ability to use QoS with existing applications. Additionally, Policy-based QoS takes advantage of your existing management infrastructure, because Policy-based QoS is built into Group Policy.

## Define QoS Priority Through a Differentiated Services Code Point \(DSCP\)
  
You can create QoS policies that define network traffic priority with a Differentiated Services Code Point \(DSCP\) value that you assign to different types of network traffic. 

The DSCP allows you to apply a value \(0–63\) within the Type of Service \(TOS\) field in an IPv4 packet's header, and within the Traffic Class field in IPv6. 

The DSCP value provides network traffic classification at the Internet Protocol \(IP\) level, which routers use to decide traffic queuing behavior. 

For example, you can configure routers to place packets with specific DSCP values into one of three queues: high priority, best effort, or lower than best effort. 

Mission-critical network traffic, which is in the high priority queue, has preference over other traffic.

### Limit Network Bandwidth Use Per Application with Throttle Rate

You can also limit an application's outbound network traffic by specifying a throttle rate in QoS Policy.

A QoS policy that defines throttling limits determines the rate of outbound network traffic. For example, to manage WAN costs, an IT department might implement a service level agreement that specifies that a file server can never provide downloads beyond a specific rate.  

### Use QoS Policy to Apply DSCP Values and Throttle Rates

You can also use QoS Policy to apply DSCP values and throttle rates for outbound network traffic to the following:

- Sending application and directory path

- Source and destination IPv4 or IPv6 addresses or address prefixes

- Protocol - Transmission Control Protocol \(TCP\) and User Datagram Protocol \(UDP\)

- Source and destination ports and port ranges \(TCP or UDP\)

- Specific groups of users or computers through deployment in Group Policy

By using these controls, you can specify a QoS policy with a DSCP value of 46 for a VoIP application, enabling routers to place VoIP packets in a low-latency queue, or you can use a QoS policy to throttle a set of servers' outbound traffic to 512 kilobytes per second \(KBps\) when sending from TCP port 443.

You can also apply QoS policy to a particular application that has special bandwidth requirements. For more information, see [QoS Policy Scenarios](qos-policy-scenarios.md).
  
## Advantages of QoS Policy

With QoS Policy, you can configure and enforce QoS policies that cannot be configured on routers and switches. QoS Policy provides the following advantages.
  
1. **Level of detail:** It is difficult to create user-level QoS policies on routers or switches, especially if the user's computer is either configured by using dynamic IP address assignment or if the computer is not connected to fixed switch or router ports, as is frequently the case with portable computers. In contrast, QoS Policy  makes it easier to configure a user\-level QoS policy on a domain controller and propagate the policy to the user's computer.
2. **Flexibility**. Regardless of where or how a computer connects to the network, QoS policy is applied - the computer can connect using WiFi or Ethernet from any location. For user\-level QoS policies, the QoS policy is applied on any compatible device at any location where the user logs on.
3. **Security:** If your IT department encrypts users' traffic from end to end by using Internet Protocol security \(IPsec\), you cannot classify the traffic on routers based on any information above the IP layer in the packet \(for example, a TCP port\). However, by using QoS Policy, you can classify packets at the end device to indicate the priority of the packets in the IP header before the IP payloads are encrypted and the packets are sent.
4. **Performance:** Some QoS functions, such as throttling, are better performed when they are closer to the source. QoS Policy moves such QoS functions closest to the source.
5. **Manageability:** QoS Policy enhances network manageability in two ways:

    **a**. Because it is based on Group Policy, you can use QoS Policy to configure and manage a set of user/computer QoS policies whenever necessary, and on one central domain-controller computer.

    **b**. QoS Policy facilitates user/computer configuration by providing a mechanism to specify policies by Uniform Resource Locator \(URL\) instead of specifying policies based on the IP addresses of each of the servers where QoS policies need to be applied. For example, assume your network has a cluster of servers that share a common URL. By using QoS Policy, you can create one policy based on the common URL, instead of creating one policy for each server in the cluster, with each policy based on the IP address of each server.

For the next topic in this guide, see [Getting Started with QoS Policy](qos-policy-get-started.md).

