---
ms.assetid: de054ac2-a386-43ec-a537-c0de21549741
title: Setting Site Link Properties
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Setting Site Link Properties

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Intersite replication occurs according to the properties of the connection objects. When the Knowledge Consistency Checker (KCC) creates connection objects, it derives the replication schedule from properties of the site link objects. Each site link object represents the wide area network (WAN) connection between two or more sites.  
  
Setting site link object properties includes the following steps:  
  
-   Determining the cost that is associated with that replication path. The KCC uses cost to determine the least expensive route for replication between two sites that replicate the same directory partition.  
  
-   Determining the schedule that defines the times during which intersite replication can occur.  
  
-   Determining the replication interval that defines how frequently replication should occur during the times when replication is allowed, as defined in the schedule.  
  
## In this guide  
  
-   [Determining the Cost](../../ad-ds/plan/Determining-the-Cost.md)  
  
-   [Determining the Schedule](../../ad-ds/plan/Determining-the-Schedule.md)  
  
-   [Determining the Interval](../../ad-ds/plan/Determining-the-Interval.md)  
  


