---
title: Step 2: Plan the RADIUS Server Deployment_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 913954de-8be6-4fb8-82f5-fa9c0944a959
author: vhorne
---
# Step 2: Plan the RADIUS Server Deployment_1
After deploying a single Remote Access server, plan for the one\-time password \(OTP\) authentication server.  
  
|Task|Description|  
|--------|---------------|  
|2.1 Plan the RADIUS server|For the OTP authentication server, Remote Access in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] supports any RADIUS\-enabled OTP server that supports the password authentication protocol \(PAP\).|  
  
## <a name="BKMK_1.1"></a>2.1 Plan the RADIUS server  
Note the following when planning a RADIUS server for OTP authentication:  
  
-   For most types of OTP deployments, you must configure the Remote Access server as a RADIUS agent. For more information, see the OTP vendor documentation.  
  
-   For all OTP deployments, you must synchronize your Active Directory users with your RADIUS server.  
  
-   The RADIUS server does not need to be a domain member.  
  
-   When you deploy the RADIUS server, you configure a shared secret and the port number for RADIUS traffic. Make a note of these details; they are required when you configure the Remote Access server.  
  
You can view an example test lab guide that sets up OTP authentication with an RSA SecurID server in [Test Lab Guide: Demonstrate DirectAccess with OTP Authentication and RSA SecurID](../Topic/Test-Lab-Guide--Demonstrate-DirectAccess-with-OTP-Authentication-and-RSA-SecurID.md).  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 3: Plan OTP Certificate Deployment](../Topic/Step-3--Plan-OTP-Certificate-Deployment.md)  
  
