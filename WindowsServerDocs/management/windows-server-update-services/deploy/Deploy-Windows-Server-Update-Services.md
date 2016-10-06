---
title: Deploy Windows Server Update Services
description: "Windows Server Update Service"
ms.prod: windows-server-threshold
ms.reviewer: na
ms.technology: manage-wsus
ms.topic: get-started-article
ms.assetid: 2708f6b2-4252-4b8f-9b7e-84c9b4222075
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Deploy

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Windows Server Update Services (WSUS) enables information technology administrators to deploy the latest Microsoft product updates. WSUS is a Windows Server server role that can be installed to manage and distribute updates. A WSUS server can be the update source for other WSUS servers within the organization. The WSUS server that acts as an update source is called an upstream server.  

In a WSUS implementation, at least one WSUS server in the network must connect to Microsoft Update to get available update information. You can determine, based on network security and configuration, how many other servers connect directly to Microsoft Update.  

This guide provides conceptual information for planning and deploying Windows Server Update Service.  

-   [Plan for Your WSUS Deployment](../plan/Plan-Your-WSUS-Deployment.md)  

-   [Step 1: Install the WSUS Server Role](1--Install-the-WSUS-Server-Role.md)  

-   [Step 2: Configure WSUS](2--Configure-WSUS.md)  

-   [Step 3: Approve and Deploy Updates in WSUS](3--Approve-and-Deploy-Updates-in-WSUS.md)  

-   [Step 4: Configure Group Policy Settings for Automatic Updates](4--Configure-Group-Policy-Settings-for-Automatic-Updates.md)  
