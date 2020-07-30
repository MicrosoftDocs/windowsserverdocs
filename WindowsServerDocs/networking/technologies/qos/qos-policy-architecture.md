---
title: QoS Policy Architecture
description: This topic provides an overview of Quality of Service (QoS) Policy, which allows you to use Group Policy to prioritize network traffic bandwidth of specific applications and services in Windows Server 2016.
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 25097cb8-b9b1-41c9-b3c7-3610a032e0d8
manager: brianlic
ms.author: lizross
author: eross-msft
---

# QoS Policy Architecture

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to learn about the architecture of QoS Policy.

The following figure shows the architecture of Policy-based QoS.

![Architecture of QoS Policy](../../media/QoS/QoS-Policy-Architecture.jpg)

The architecture of Policy-based QoS consists of the following components:

- **Group Policy Client Service**. A Windows service that manages user and computer configuration Group Policy settings.

- **Group Policy engine**. A component of the Group Policy Client Service that retrieves user and computer configuration Group Policy settings from Active Directory upon startup and periodically checks for changes \(by default, every 90 minutes\). If changes are detected, the Group Policy engine retrieves the new Group Policy settings. The Group Policy engine processes the incoming GPOs and informs the QoS Client Side Extension when the QoS policies are updated.

- **QoS Client Side Extension**. A component of the Group Policy Client Service that waits for an indication from the Group Policy engine that the QoS policies have changed and informs the QoS Inspection Module.

- **TCP/IP Stack**. The TCP/IP stack that includes integrated support for IPv4 and IPv6 and supports Windows Filtering Platform. 

- **QoS Inspection**. Module A component within the TCP/IP stack that waits for indications of QoS policy changes from the QoS Client Side Extension, retrieves the QoS policy settings, and interacts with the Transport Layer and Pacer.sys to internally mark traffic that matches the QoS policies.

- **NDIS 6.x**. A standard interface between kernel-mode network drivers and the operating system in Windows Server and Client operating systems. NDIS 6.x supports lightweight filters, which is a simplified driver model for NDIS intermediate drivers and miniport drivers that provides better performance.

- **QoS Network Provider Interface \(NPI\)**. An interface for kernel-mode drivers to interact with Pacer.sys.

- **Pacer.sys**. An NDIS 6.x lightweight filter driver that controls packet scheduling for Policy-based QoS and for the traffic of applications that use the Generic QoS \(GQoS\) and Traffic Control \(TC\) APIs. Pacer.sys replaced Psched.sys in Windows Server 2003 and Windows XP. Pacer.sys is installed with the QoS Packet Scheduler component from the properties of a network connection or adapter.

For the next topic in this guide, see [QoS Policy Scenarios](qos-policy-scenarios.md).

For the first topic in this guide, see [Quality of Service (QoS) Policy](qos-policy-top.md).

