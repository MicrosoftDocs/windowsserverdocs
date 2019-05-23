---
ms.assetid: c87dc32d-ab33-44d2-a46f-f9f878b4e5b4
title: Planning to Deploy AD FS
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---

# Planning to Deploy AD FS


After you collect information about your environment and you decide on an Active Directory Federation Services \(AD FS\) design by following the guidance in the [AD FS Design Guide in Windows Server 2012](https://technet.microsoft.com/library/dd807036.aspx), you can begin to plan the deployment of your organization's AD FS design. With the completed design and the information in this topic, you can determine which tasks to perform to deploy AD FS in your organization.  
  
## Reviewing your AD FS design  
If the design team that constructed the original AD FS design for your organization is different from the deployment team that will actually implement the deployment, make sure that the deployment team reviews the final design with the design team. Review the following points regarding the design:  
  
-   The design team's strategy to determine the best physical topology for the placement of federation servers in your corporate network or perimeter network. The deployment team can refer to documentation about this subject by reviewing the following topics in the AD FS Design Guide:  
  
    -   [The Role of the AD FS Configuration Database](../../ad-fs/technical-reference/The-Role-of-the-AD-FS-Configuration-Database.md)  
  
    -   [Planning Federation Server Placement](https://technet.microsoft.com/library/dd807069.aspx)  
  
    -   [Planning Federation Server Proxy Placement](https://technet.microsoft.com/library/dd807130.aspx)  
  
    It is possible that the design team might leave the subject of federation server or federation server proxy placement for the deployment team. The deployment team is then responsible for documenting and implementing the physical topology of the servers.  
  
-   The business reasons for your organization's designation as a claims provider, relying party, or both, within the scope of the documented AD FS design. Ensure that members of the deployment team understand the reasons why AD FS is being deployed and what other companies or organizations are involved in the federation partnership. Ensure that members of the deployment team also understand the constraints that exist for the other companies or organizations \(limited hardware, no extranet environment, and so forth\) that may limit the scope of the design in some way. For more information about partner organizations, see [Planning Your Deployment](https://technet.microsoft.com/library/dd807083.aspx).  
  
After the design teams and deployment teams agree on these issues, they can proceed with the deployment of the AD FS design. For more information, see [Implementing Your AD FS Design Plan](Implementing-Your-AD-FS-Design-Plan.md).  
