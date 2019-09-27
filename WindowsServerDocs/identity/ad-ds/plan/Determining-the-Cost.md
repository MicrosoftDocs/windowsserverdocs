---
ms.assetid: e3ea1f67-60d4-4566-b24c-37faa95c3b2a
title: Determining the Cost
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Determining the Cost

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You assign cost values to site links to favor inexpensive connections over expensive connections. Certain applications and services, such as Domain Controller Locator (DCLocator) and Distributed File System Namespaces (DFSN), also use cost information to locate the nearest resources. Site link cost can be used to determine which domain controller is contacted by clients in one site if the domain controller for the specified domain does not exist at that site. The client contacts the domain controller by using the site link that has the lowest cost assigned to it.  
  
We recommend that the cost value be defined on a site-wide basis. Cost is usually based not only on the total bandwidth of the link but also on the availability, latency, and monetary cost of the link.  
  
To determine the costs to place on site links, document the connection speed for each site link. Refer to the "Geographic Locations and Communication Links" (DSSTOPO_1.doc) worksheet in [Collecting Network Information](../../ad-ds/plan/Collecting-Network-Information.md) for information about the connection speed that you identified.  
  
The following table lists the speeds for different types of networks.  
  
|Network type|Speed|  
|----------------|---------|  
|Very slow|56 kilobits per second (Kbps)|  
|Slow|64 Kbps|  
|Integrated Services Digital Network (ISDN)|64 Kbps or 128 Kbps|  
|Frame relay|Variable rate, commonly between 56 Kbps and 1.5 megabits per second (Mbps)|  
|T1|1.5 Mbps|  
|T3|45 Mbps|  
|10BaseT|10 Mbps|  
|Asynchronous transfer mode (ATM)|Variable rate, commonly between 155 Mbps and 622 Mbps|  
|100BaseT|100 Mbps|  
|Gigabit Ethernet|1 gigabit per second (Gbps)|  
  
Use the following table to calculate the cost of each site link based on wide area network speed (WAN) link speed. For WAN link speed that is not listed in the table, you can calculate a relative cost factor by dividing 1,024 by the log of the available bandwidth, as measured in Kbps.  
  
|Available bandwidth (Kbps)|Cost|  
|--------------------------------|--------|  
|9.6|1,042|  
|19.2|798|  
|38.4|644|  
|56|586|  
|64|567|  
|128|486|  
|256|425|  
|512|378|  
|1,024|340|  
|2,048|309|  
|4,096|283|  
  
These costs do not reflect differences in reliability between network links. Set higher costs on any failure-prone network links so that you do not have to rely on those links for replication. By setting higher site link costs, you can control replication failover when a site link fails.  
  


