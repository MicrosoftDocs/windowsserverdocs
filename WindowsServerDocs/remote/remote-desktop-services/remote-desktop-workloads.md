---
title: Remote Desktop workloads
description: A brief overview of different types of workloads for virtual machines managed by Remote Desktop.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: helohr
ms.date: 12/02/2019
ms.tgt_pltfrm: na
ms.topic: article
author: Heidilohr
manager: lizross
---
# Remote Desktop workloads

Users can run different types of workloads on the virtual machines managed by Remote Desktop Services or Windows Virtual Desktop. Scale your deployment depending on the expected need of each type of user. The following table provides examples of a range of workload types to help you estimate what size your virtual machines need to be. After you set up your virtual machines, you should continually monitor their actual usage and adjust their size accordingly. If you end up needing a bigger or smaller virtual machine, you can easily scale your existing deployment up or down in Azure.

The following table describes each workload. "Example users" are the types of users that might find each workload most helpful. "Example apps" are the kinds of apps that work best for each workload.

| Workload type | Example users | Example apps |
| --- | --- | --- |
| Light | Users doing basic data entry tasks | Database entry applications, command-line interfaces |
| Medium | Consultants and market researchers | Database entry applications, command-line interfaces, Microsoft Word, static web pages |
| Heavy | Software engineers, content creators | Database entry applications, command-line interfaces, Microsoft Word, static web pages, Microsoft Outlook, Microsoft PowerPoint, dynamic web pages |
| Power | Graphic designers, 3D model makers, machine learning researchers | Database entry applications, command-line interfaces, Microsoft Word, static web pages, Microsoft Outlook, Microsoft PowerPoint, dynamic web pages, Adobe Photoshop, Adobe Illustrator, computer-aided design (CAD), computer-aided manufacturing (CAM) |

For information about sizing recommendations, see [Virtual machine sizing guidance](virtual-machine-recs.md).
