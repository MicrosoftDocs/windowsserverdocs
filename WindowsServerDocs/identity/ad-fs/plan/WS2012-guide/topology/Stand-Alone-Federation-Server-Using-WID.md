---
title: Stand-Alone Federation Server Using WID
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6ebd0b61-a270-473b-ba1e-062c88a31bc2
author: billmath
---
# Stand-Alone Federation Server Using WID
A stand\-alone federation server in Active Directory Federation Services \(AD FS\) consists of a single server that hosts a Federation Service configured to use the Windows Internal Database \(WID\). This AD FS topology is for test labs. We do not recommend it for production environments because it has a limit of only one federation server, and it cannot be used to scale up to more servers.  
  
If you want to add additional federation servers to your test lab, you must rebuild the Federation Service from scratch by deploying any of the other topologies mentioned later in this section. Therefore, we recommend that you use this topology for a test lab or a proof\-of\-concept environment in your private testing network in which a single federation server is adequate, as shown in the following illustration.  
  
![](media/FedServerWID.gif)  
  
## Test lab considerations  
This section describes various considerations about the intended audience, benefits, and limitations that are associated with this topology for test lab environments.  
  
### Who should use this topology?  
  
-   Information technology \(IT\) professionals or IT architects who want to evaluate or develop a proof of concept for this technology  
  
### What are the benefits of using this topology?  
  
-   Easy to set up in a test lab environment  
  
### What are the limitations of using this topology?  
  
-   Only one federation server per Federation Service \(no capability to scale up to a farm\)  
  
-   Not redundant \(only a single instance of the AD FS configuration database exists\)  
  

