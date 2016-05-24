---
title: Planning to Deploy AD FS
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1edf59c3-aed1-4389-96aa-ff64965fa271
author: billmath
---
# Planning to Deploy AD FS
After you collect information about your environment and you decide on an [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] design by following the guidance in the [AD FS Design Guide in Windows Server 2012](../Topic/AD-FS-Design-Guide-in-Windows-Server-2012.md), you can begin to plan the deployment of your organization's AD FS design. With the completed design and the information in this topic, you can determine which tasks to perform to deploy [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] in your organization.  
  
## Reviewing your AD FS design  
If the design team that constructed the original [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] design for your organization is different from the deployment team that will actually implement the deployment, make sure that the deployment team reviews the final design with the design team. Review the following points regarding the design:  
  
-   The design team's strategy to determine the best physical topology for the placement of federation servers in your corporate network or perimeter network. The deployment team can refer to documentation about this subject by reviewing the following topics in the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Design Guide:  
  
    -   [The Role of the AD FS Configuration Database](../Topic/The-Role-of-the-AD-FS-Configuration-Database.md)  
  
    -   [Planning Federation Server Placement](../Topic/Planning-Federation-Server-Placement.md)  
  
    -   [Planning Federation Server Proxy Placement](../Topic/Planning-Federation-Server-Proxy-Placement.md)  
  
    It is possible that the design team might leave the subject of federation server or federation server proxy placement for the deployment team. The deployment team is then responsible for documenting and implementing the physical topology of the servers.  
  
-   The business reasons for your organization's designation as a claims provider, relying party, or both, within the scope of the documented AD FS design. Ensure that members of the deployment team understand the reasons why [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] is being deployed and what other companies or organizations are involved in the federation partnership. Ensure that members of the deployment team also understand the constraints that exist for the other companies or organizations \(limited hardware, no extranet environment, and so forth\) that may limit the scope of the design in some way. For more information about partner organizations, see [Planning Your Deployment](../Topic/Planning-Your-Deployment.md).  
  
After the design teams and deployment teams agree on these issues, they can proceed with the deployment of the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] design. For more information, see [Implementing Your AD FS Design Plan](../Topic/Implementing-Your-AD-FS-Design-Plan.md).  
  
