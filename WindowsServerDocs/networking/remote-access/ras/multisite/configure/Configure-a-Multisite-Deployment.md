---
title: Configure a Multisite Deployment
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: cb84920e-7cf5-4266-b071-d09e3d5e1f10
ms.author: coreyp
author: coreyp-at-msft
---
# Configure a Multisite Deployment

>Applies To: Windows Server&reg; 2016

 Windows Server 2016 and Windows Server&reg; 2012 combine DirectAccess and Routing and Remote Access Service (RRAS) VPN into a single Remote Access role. This overview provides an introduction to the configuration steps required in order to deploy a single  Windows Server 2016 or  Windows Server 2012  Remote Access multisite deployment.  
  
-   [Step 1: Implement a single server Remote Access deployment](assetId:///a811b73d-56af-4457-aa82-0c23b4c57b4f)-Install and configure a single Remote Access server. The multisite deployment requires you to install a single server before configuring a multisite deployment. For instructions, see [Deploy a single Remote Access server with advanced settings](assetId:///3475e527-541f-4a34-b940-18d481ac59f6).  
  
-   [Step 2: Configure the multisite infrastructure](assetId:///b1960686-a81e-4f48-83f1-cc4ea484df43)-For a multisite deployment you must configure additional Active Directory sites and domain controllers. Additional security groups and Group Policy Objects (GPOs) are also required if you are not using automatically configured GPOs.  
  
-   [Step 3: Configure the multisite deployment](assetId:///2325da4a-3987-4132-b8d0-95c275f544b1)-Install the Remote Access role on additional Remote Access servers, enable the multisite deployment, and configure the additional servers as entry points for the deployment.  
  
-   [Step 4: Verify the multisite deployment](assetId:///9d278e9a-2e1f-49a9-a4b1-8b02de484c18).  
  


