---
title: Configure a Multisite Deployment
description: This topic is part of the guide Deploy Multiple Remote Access Servers in a Multisite Deployment in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cb84920e-7cf5-4266-b071-d09e3d5e1f10
ms.author: lizross
author: eross-msft
---
# Configure a Multisite Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

 Windows Server 2016 combines DirectAccess and Remote Access Service (RAS) VPN into a single Remote Access role. This overview provides an introduction to the configuration steps required in order to deploy a single Windows Server 2016 or Windows Server 2012 Remote Access multisite deployment.  
  
-   Step 1: [Deploy a Single DirectAccess Server with Advanced Settings](https://technet.microsoft.com/windows-server-docs/networking/remote-access/directaccess/single-server-advanced/deploy-a-single-directaccess-server-with-advanced-settings). Install and configure a single Remote Access server. The multisite deployment requires you to install a single server before configuring a multisite deployment.  
  
-   [Step 2: Configure the multisite infrastructure](Step-2-Configure-the-Multisite-Infrastructure.md). For a multisite deployment you must configure additional Active Directory sites and domain controllers. Additional security groups and Group Policy Objects (GPOs) are also required if you are not using automatically configured GPOs.  
  
-   [Step 3: Configure the multisite deployment](Step-3-Configure-the-Multisite-Deployment.md)-Install the Remote Access role on additional Remote Access servers, enable the multisite deployment, and configure the additional servers as entry points for the deployment.  
  
-   [Step 4: Verify the multisite deployment](Step-4-Verify-the-Multisite-Deployment.md) 
  


