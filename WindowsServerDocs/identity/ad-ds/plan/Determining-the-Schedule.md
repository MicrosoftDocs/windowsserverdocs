---
ms.assetid: 28ecaf5c-9131-406c-b211-a230162e462e
title: Determining the Schedule
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Determining the Schedule

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You can control site link availability by setting a schedule for site links. When replication between two sites traverses multiple site links, the intersection of the replication schedules on all the relevant links determines the connection schedule between the two sites.  
  
To plan for setting the site link schedule, create two overlapping schedules between site links that contain domain controllers that directly replicate with each other. Use the default (100-percent available) schedule on those links unless you want to block replication traffic during peak hours. By blocking replication, you give priority to other traffic, but you also increase replication latency.  
  
Domain controllers store time in Coordinated Universal Time (UTC). Time settings in site link object schedules conform to the local time of the site and computer on which the schedule is set. When a domain controller contacts a computer that is in a different site and time zone, the schedule on the domain controller displays the time setting according to the local time for the site of the computer.  
  


