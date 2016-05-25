---
title: Deploy IPAM Server
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6cf9b2c8-41b8-493e-add5-f09ef72fa01d
---
# Deploy IPAM Server
At least one IPAM server is required to deploy IPAM. In order for a computer to function as an IPAM server, it must be a domain member computer running [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] or later, and the IPAM Server feature must be installed and configured. You cannot install IPAM Server on a domain controller.  
  
## Configuring an IPAM server  
Before you install and configure an IPAM server, be sure that you have reviewed the following conceptual topics in the Understanding IP Address Management \(IPAM\) Guide:  
  
-   [What is IPAM?](../Topic/What-is-IPAM-.md): Information about the key features and capabilities of IPAM.  
  
-   [IPAM Terminology](../Topic/IPAM-Terminology.md): Terms and concepts used to refer to IPAM are defined.  
  
-   [Getting Started with IPAM](../Topic/Getting-Started-with-IPAM.md): IPAM deployment is summarized.  
  
-   [IPAM Architecture](../Topic/IPAM-Architecture.md): IPAM client, IPAM server, and managed servers are discussed.  
  
-   [IPAM Deployment Planning](../Topic/IPAM-Deployment-Planning.md): Deployment topologies, hardware and software requirements, specifications, and best practices.  
  
After you have reviewed these topics, complete the tasks in [Checklist: Deploy IPAM Server](../Topic/Checklist--Deploy-IPAM-Server.md). Depending on your IPAM design choices, you will also be required to configure and deploy managed server access settings on IP infrastructure servers \(domain controllers, NPS, DHCP, and DNS servers\) to enable a functional IPAM environment.  
  
## See Also  
[Deploy IPAM Client](../Topic/Deploy-IPAM-Client.md)  
  
