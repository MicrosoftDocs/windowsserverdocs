---
title: Setting Site Link Properties
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: 
ms.suite: na
ms.technology: identity-adds
ms.author: markvi
  
ms.tgt_pltfrm: na
ms.assetid: 4628cb02-0114-43bf-852e-e9c772f22c61
author: Femila
---
# Setting Site Link Properties

>Applies To: Windows Server Technical Preview

Intersite replication occurs according to the properties of the connection objects. When the Knowledge Consistency Checker (KCC) creates connection objects, it derives the replication schedule from properties of the site link objects. Each site link object represents the wide area network (WAN) connection between two or more sites.  
  
Setting site link object properties includes the following steps:  
  
-   Determining the cost that is associated with that replication path. The KCC uses cost to determine the least expensive route for replication between two sites that replicate the same directory partition.  
  
-   Determining the schedule that defines the times during which intersite replication can occur.  
  
-   Determining the replication interval that defines how frequently replication should occur during the times when replication is allowed, as defined in the schedule.  
  
## In this guide  
  
-   [Determining the Cost](../../ad-ds/plan/Determining-the-Cost.md)  
  
-   [Determining the Schedule](../../ad-ds/plan/Determining-the-Schedule.md)  
  
-   [Determining the Interval](../../ad-ds/plan/Determining-the-Interval.md)  
  


