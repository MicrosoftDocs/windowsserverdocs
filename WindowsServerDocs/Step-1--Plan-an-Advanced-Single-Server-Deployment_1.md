---
title: Step 1: Plan an Advanced Single Server Deployment_1
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 80761203-a998-41e1-9277-6f12d163f563
author: coreyp
---
# Step 1: Plan an Advanced Single Server Deployment_1
The first step in deploying Remote Access in a multisite topology is to plan and configure an advanced single server deployment, and then plan to add servers to each multisite entry point.  
  
## <a name="bkmk_1_1_Single_Server"></a>Plan a single server deployment  
Before you deploy Remote Access in a multisite topology, make sure that you have completed all the planning steps to deploy a single Remote Access server. See [Plan an advanced Remote Access deployment](assetId:///fc9ef16f-2f93-493a-9b55-c21df5e4b73d). Note the following:  
  
-   The single Remote Access server must be configured to use IPsec client certificate authentication. The option to use the Remote Access server as a Kerberos proxy for client authentication is not supported.  
  
-   The single server deployment should use a certification authority \(CA\) to issue the certificate for the network location server and IP\-HTTPS websites.  
  
If you have already deployed a single Remote Access without these settings, configure them before beginning the multisite deployment.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 2: Plan the multisite infrastructure](assetId:///bd7b4f5e-91b5-49ac-81bb-53c0008b7f4f)  
  

