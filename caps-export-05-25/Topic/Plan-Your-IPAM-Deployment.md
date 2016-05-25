---
title: Plan Your IPAM Deployment
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 69ca50c1-2995-4927-b28e-d85fb3807583
---
# Plan Your IPAM Deployment
Consider the following when planning your IPAM deployment:  
  
-   **Deployment topology**: One or more IPAM servers can be deployed at every site in the organization, or a single IPAM server can be used to manage multiple sites. Choose a design that best fits your needs.  
  
-   **IPAM staging strategy**: You can deploy IPAM gradually in your environment by specifying the scope of discovery and selecting a subset of managed servers from the server inventory. Expand your IPAM deployment by including additional domains and servers to the management scope of existing IPAM servers, or by adding additional IPAM servers.  
  
-   **Scope of discovery**: Determine the domains that will be managed by each IPAM server. You must deploy more than one IPAM server to manage a multi\-forest environment.  
  
-   **Role management**: Determine the primary role of each IPAM server. Each IPAM server can perform IP address management, role\-specific server monitoring and management, and network audit for the domains you choose. Alternatively, each IPAM server can perform a subset of these functions.  
  
-   **Server placement**: Based on the scope of discovery and role management decisions you make, evaluate the best physical topology for placement of IPAM servers to optimally monitor and manage your network.  
  
-   **Training and administration**: Considering IPAM’s built\-in role\-based security groups, conduct training and assign specific permissions and tasks to administrators in your organization.  
  
If the IPAM design team is different from the IPAM deployment team, ensure that members of the deployment team understand the reasons the selected IPAM design is being deployed and how IPAM clients, IPAM servers, and managed servers will be affected. Ensure that members of the deployment team also understand the scope of the IPAM deployment, and what roles and responsibilities will be assigned to IPAM servers and administrators.  
  
## Reviewing IPAM concepts  
For more information about how IPAM works, also see the following resources:  
  
-   [What is IPAM?](../Topic/What-is-IPAM-.md)  
  
-   [IPAM Terminology](../Topic/IPAM-Terminology.md)  
  
-   [Getting Started with IPAM](../Topic/Getting-Started-with-IPAM.md)  
  
-   [IPAM Architecture](../Topic/IPAM-Architecture.md)  
  
-   [IPAM Deployment Planning](../Topic/IPAM-Deployment-Planning.md)  
  
-   [Walkthrough: Demonstrate IPAM in Windows Server 2012](../Topic/Walkthrough--Demonstrate-IPAM-in-Windows-Server-2012.md)  
  
