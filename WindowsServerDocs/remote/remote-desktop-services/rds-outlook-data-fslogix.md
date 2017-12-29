---
title: Dealing with Outlook search in non-persistent environments
description: Learn about your options for managing Outlook data stored to a user profile disk.
ms.custom: na
ms.prod: windows-server-threshold
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 08/24/2017
ms.tgt_pltfrm: na
ms.topic: article
author: haley-rowland
---
# Dealing with Outlook search in non-persistent environments

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

A common issue customers face with their non-persistent (pooled) Remote Desktop Services environments is handling users' Outlook data. When Outlook is running in cached exchange mode, the .OST storing a user's Outlook data must follow the user as they roam from host to host. Windows Search Service indexes the .OST and creates an index catalog to enable search functionality in Outlook. In non-persistent RDS environments, the index catalog doesn't roam with user data and must be rebuilt every time the user signs into a new PC, which could potentially be every sign-on. Until the Windows Search Service finishes indexing the .OST, users get limited or incomplete search functionality. 

According to a published report from [RDS Gurus](http://rdsgurus.com), [FSLogix](https://fslogix.com/) (a third party solution provider) has a solution that aims to solve this issue: [FSLogix’s Office 365 Container](https://fslogix.com/products/office-365-container) roams a user's Outlook data as well as their search index catalog, giving users access to their emails and enabling users to search in Outlook, even when they roam between sessions on different hosts within a collection.  

RDS Gurus performed testing on FSLogix's Offic 365 Container, comparing it with RDS’s native User Profile Disk roaming solution. The test scenarios covered both on-premise and Azure RDS environments for non-persistent sessions on an RD session host (RDSH). Tests also included pooled VMs on RD virtualization host (RDVH), only for on-premise (RDVH is not available in Azure). RDS Gurus primarily focused on the user experience when there are "noisy neighbors," or other users logged on to the same session host running similar workloads on the system. 

The performance counters collected in these tests revealed similar resource usage (CPU, RAM, network activity) with both UPD and FSLogix. This is because Windows Search Service throttles its CPU usage when indexing. When it comes to user experience, RDS Gurus found that FSLogix's Office 365 Container exceeds UPD in Outlook search functionality. In the UPD case, search does not return results or returns incomplete results as Windows Search Service indexes the .OST. Because FSLogix roams the index catalog, users see search results immediately. RDS Gurus observed a significant improvement in user experience when searching in Outlook in non-persistent RDS environments using FSLogix. 

Read more about the results and conclusions on the [RDS Gurus blog](http://www.rdsgurus.com/outlook-performance-in-non-persistent-environments-using-fslogixs-office-365-containers/). 