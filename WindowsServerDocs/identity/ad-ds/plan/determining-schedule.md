---
title: Determining the Schedule
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.assetid: afeaea89-8ca0-43ed-bd44-4c822d653508
author: Femila
---
# Determining the Schedule
You can control site link availability by setting a schedule for site links. When replication between two sites traverses multiple site links, the intersection of the replication schedules on all the relevant links determines the connection schedule between the two sites.  
  
To plan for setting the site link schedule, create two overlapping schedules between site links that contain domain controllers that directly replicate with each other. Use the default \(100\-percent available\) schedule on those links unless you want to block replication traffic during peak hours. By blocking replication, you give priority to other traffic, but you also increase replication latency.  
  
Domain controllers store time in Coordinated Universal Time \(UTC\). Time settings in site link object schedules conform to the local time of the site and computer on which the schedule is set. When a domain controller contacts a computer that is in a different site and time zone, the schedule on the domain controller displays the time setting according to the local time for the site of the computer.  
  

