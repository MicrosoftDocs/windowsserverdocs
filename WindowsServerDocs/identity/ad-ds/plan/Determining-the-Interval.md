---
ms.assetid: 96a6749c-6c9f-4f2f-ad0a-51272d282ace
title: Determining the Interval
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Determining the Interval

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You must set the site link replication interval property to indicate how frequently you want replication to occur during the times when the schedule allows replication. For example, if the schedule allows replication between 02:00 hours and 04:00 hours, and the replication interval is set for 30 minutes, replication can occur up to four times during the scheduled time. The default replication interval is 180 minutes, or 3 hours. The minimum interval is 15 minutes.  
  
Consider the following criteria to determine how often replication occurs within the schedule window:  
  
-   A small interval decreases latency but increases the amount of wide area network (WAN) traffic.  
  
-   To keep domain directory partitions up to date, low latency is preferred.  
  
With a store-and-forward replication strategy, it is difficult to determine just how long a directory update might take to be replicated to every domain controller. To provide a conservative estimate of maximum latency, perform these tasks:  
  
-   Create a table of all the sites on your network, as shown in the following example:  
  
    |Sites|Seattle|Boston|Los Angeles|New York|Washington, D.C.|  
    |---------|-----------|----------|---------------|------------|--------------------|  
    |Seattle|0.25|||||  
    |Boston||0.25||||  
    |Los Angeles|||0.25|||  
    |New York||||0.25||  
    |Washington, D.C.|||||0.25|  
  
    A worst-case latency within a site is estimated to be 15 minutes.  
  
-   From the replication schedule, determine the maximum replication latency that is possible on any site link that connects two hub sites.  
  
    For example, if replication occurs between Seattle and New York every three hours, the maximum delay for replication between these sites is three hours. If the replication delay between New York and Seattle is the longest scheduled delay among all hub sites, the maximum latency between all hubs is three hours.  
  
-   For each hub site, create a table of the maximum latencies between the hub site and any of its satellite sites.  
  
    For example, if replication occurs between New York and Washington, D.C., every four hours and this is the longest replication delay between New York and any of its satellite sites, the maximum latency between New York and its satellites is four hours.  
  
-   Combine these maximum latencies to determine the maximum latency for the entire network.  
  
    For example, if the maximum latency between Seattle and its satellite site in Los Angeles is one day, the maximum replication latency for this set of links (Washington, D.C.-New York-Seattle-Los Angeles) is 31 hours, that is, 4 (Washington, D.C.-New York) + 3 (New York-Seattle) + 24 (Seattle-Los Angeles), as shown in the following table.  
  
    |Sites|Seattle|Boston|Los Angeles|New York|Washington, D.C.|  
    |---------|-----------|----------|---------------|------------|--------------------|  
    |Seattle|0.25|4+3|24.00|3.00|4+3|  
    |Boston||0.25|4+3+24|4.00|4.00|  
    |Los Angeles|||0.25|24 + 3|24+3+4|  
    |New York||||0.25|4.00|  
    |Washington, D.C.|||||0.25|  
  


