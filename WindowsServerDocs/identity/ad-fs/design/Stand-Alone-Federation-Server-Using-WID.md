---
ms.assetid: 33b80a3f-67f3-4da7-ac4a-7fd2232fbd5d
title: Stand-Alone Federation Server Using WID
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Stand-Alone Federation Server Using WID

A stand\-alone federation server in Active Directory Federation Services \(AD FS\) consists of a single server that hosts a Federation Service configured to use the Windows Internal Database \(WID\). This AD FS topology is for test labs. We do not recommend it for production environments because it has a limit of only one federation server, and it cannot be used to scale up to more servers.  
  
If you want to add additional federation servers to your test lab, you must rebuild the Federation Service from scratch by deploying any of the other topologies mentioned later in this section. Therefore, we recommend that you use this topology for a test lab or a proof\-of\-concept environment in your private testing network in which a single federation server is adequate, as shown in the following illustration.  
  
![server using WID](media/FedServerWID.gif)  
  
## Test lab considerations  
This section describes various considerations about the intended audience, benefits, and limitations that are associated with this topology for test lab environments.  
  
### Who should use this topology?  
  
-   Information technology \(IT\) professionals or IT architects who want to evaluate or develop a proof of concept for this technology  
  
### What are the benefits of using this topology?  
  
-   Easy to set up in a test lab environment  
  
### What are the limitations of using this topology?  
  
-   Only one federation server per Federation Service \(no capability to scale up to a farm\)  
  
-   Not redundant \(only a single instance of the AD FS configuration database exists\)  
  

## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
