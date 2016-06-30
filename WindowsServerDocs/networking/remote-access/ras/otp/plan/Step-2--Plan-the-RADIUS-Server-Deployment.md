---
title: Step 2 Plan the RADIUS Server Deployment
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2d6ad863-02a5-49b0-9aff-d189e78b2b80
author: coreyp
---
# Step 2 Plan the RADIUS Server Deployment

>Applies To: Windows Server Technical Preview

After deploying a single Remote Access server, plan for the one-time password (OTP) authentication server.  
  
|Task|Description|  
|--------|---------------|  
|2.1 Plan the RADIUS server|For the OTP authentication server, Remote Access in Windows Server® 2016 Technical Preview and Windows Server® 2012 supports any RADIUS-enabled OTP server that supports the password authentication protocol (PAP).|  
  
## <a name="BKMK_1.1"></a>2.1 Plan the RADIUS server  
Note the following when planning a RADIUS server for OTP authentication:  
  
-   For most types of OTP deployments, you must configure the Remote Access server as a RADIUS agent. For more information, see the OTP vendor documentation.  
  
-   For all OTP deployments, you must synchronize your Active Directory users with your RADIUS server.  
  
-   The RADIUS server does not need to be a domain member.  
  
-   When you deploy the RADIUS server, you configure a shared secret and the port number for RADIUS traffic. Make a note of these details; they are required when you configure the Remote Access server.  
  
You can view an example test lab guide that sets up OTP authentication with an RSA SecurID server in [Test Lab Guide: Demonstrate DirectAccess with OTP authentication and RSA SecurID](assetId:///616db45d-f151-4abe-aecf-5f5060095a67).  
  
  
  


