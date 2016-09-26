---
title: "Scaling-up to larger environments"
description: "Describes how to use Windows Server Essentials"
ms.custom: na
ms.date: 10/01/2016
ms.prod: windows-server-2016-essentials
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid:
author: nnamuhcs
ms.author: coreyp
---

>Applies To: Windows Server 2016 Essentials

Scaling-up to larger environments
=================================

By making the Windows Server Essentials Experience server role available in the Standard and Datacenter versions of Windows Server, we opened-up the value of the Windows Server Essentials features to larger, more complex environments. While this was a great win for customers deploying Windows Server Standard, it also highlighted some areas we needed to improve to ensure the experience scaled-up appropriately.

Support for environments with multiple domains and domain controllers
---------------------------------------------------------------------

Deployment was by default blocked in environments that had more than one domain in the 2012 R2 release of the Windows Server Essentials experience role. For the standalone version of Windows Server 2012 R2 Essentials, a single domain is requirement along with the Windows Server Essentials server being the root of the forest. While this is still the case for the vNext release of the standalone version of Windows Server Essentials, deployment of the Windows Server Essentials server role on a Standard or Datacenter server is likely.

Even more common than environments with multiple domains are environments with more than one domain controller. In the 2012 R2 version of Windows Server Essentials, deployment of any services that leverage Azure Active Directory (such as Office 365) would be blocked in environments that had more than one Domain Controller. This was due to the problems associated with account and password synchronization between the local domain controllers and Azure Active Directory that could lead to account credentials with passwords that are out of sync.

In the Windows Server Essentials Experience server role for vNext, both of these issues are addressed to enable seamless deployment into environments larger than single domain, single domain controller, which was typical in the past for SBS and Windows Server Essentials small business customers.

In addition to removing these deployment blockers, the ability to choose a designated domain controller has been added to ensure quick retrieval of Active Directory domain objects as well as coordinating synchronization of account change across other domain controllers in the domain.

The default designated Domain Controller will be the same server that is running the Windows Server Essentials Experience server role. If the server running the Windows Server Essentials Experience role is a member server, meaning it is not a domain controller, then the default designated domain controller will be automatically determined based on testing which domain controller in the domain has the lowest network latency to the server running the Windows Server Experience Server role. If the administrator wants to manually change which server is the designated domain controller, he can do so through the Settings control panel in the Windows Server Essentials dashboard as shown in Figure.

<img src="./media/image1.PNG" width="453" height="348" />

A screenshot showing the Settings control panel in the foreground and the Windows Server Essentials dashboard in the background. The Designated Domain Controller page of the Settings control panel is currently selected.

Support for 500 users and 500 devices
-------------------------------------

In Windows Server 2012 R2 Essentials, the maximum number of supported users was 25 with 50 devices. With the introduction of the Windows Server Essentials Experience server role, that limit was increased to 100 users and 200 devices. This upper limit for the server role is a technical limit rather than a licensing limit as is the case in the standalone version of Windows Server 2012 R2 Essentials. The reason this technical limit was put in place is due to many factors, primarily around the user experience of rendering large lists of Active Directory user or device objects in the Windows Server Essentials dashboard.

In the vNext version of the Windows Server Essentials Experience server role, not only has the provider framework and object list controls been updated to cache and quickly render large user and device object lists, but in addition a search and filter feature has been added to quickly find the user or device you may be looking for (see Figure 5-2). Search and filter functionality have been implemented in the Windows Server Essentials dashboard, Remote Web Access as well as the Windows and Windows Phone store My Server applications.

<img src="./media/image2.png" width="333" height="147" />

A screenshot showing the use of the Search feature of the Windows Server Essentials dashboard to search for the string "d5c". The results of this search include two files and folders and two users.

Note While the supported user and device limit has increased for Windows Server Essentials Server role, the supported limit for client back-up remains at 75.
