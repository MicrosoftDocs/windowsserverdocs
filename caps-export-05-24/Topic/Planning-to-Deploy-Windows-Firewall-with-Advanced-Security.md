---
title: Planning to Deploy Windows Firewall with Advanced Security
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0c77d2f9-a68b-4e28-9470-3abe3769d066
author: vhorne
---
# Planning to Deploy Windows Firewall with Advanced Security
After you collect information about your environment and decide on a design by following the guidance in the [Windows Firewall with Advanced Security Design Guide](../Topic/Windows-Firewall-with-Advanced-Security-Design-Guide.md), you can begin to plan the deployment of your design. With the completed design and the information in this topic, you can determine which tasks to perform to deploy [!INCLUDE[wfas](../Token/wfas_md.md)] in your organization.  
  
## Reviewing your Windows Firewall with Advanced Security Design  
If the design team that created the [!INCLUDE[wfas](../Token/wfas_md.md)] design for your organization is different from the deployment team that will implement it, make sure that the deployment team reviews the final design with the design team. Review the following points:  
  
-   The design team's strategy for determining how WMI and security group filters attached to the GPOs will determine which computers apply to which GPO. The deployment team can refer to the following topics in the [!INCLUDE[wfas](../Token/wfas_md.md)] Design Guide:  
  
    -   [Planning Isolation Groups for the Zones](../Topic/Planning-Isolation-Groups-for-the-Zones.md)  
  
    -   [Planning the GPOs](../Topic/Planning-the-GPOs.md)  
  
    -   [Planning GPO Deployment](../Topic/Planning-GPO-Deployment.md)  
  
-   The communication to be allowed between members of each of the zones in the isolated domain and computers that are not part of the isolated domain or members of the isolated domain's exemption list.  
  
-   The recommendation that domain controllers are exempted from IPsec authentication requirements. If they are not exempt and authentication fails, then domain clients might not be able to receive Group Policy updates to the IPsec connection security rules from the domain controllers.  
  
-   The rationale for configuring all IPsec authentication rules to request, not require, authentication until the successful negotiation of IPsec has been confirmed. If the rules are set to require authentication before confirming that authentication is working correctly, then communications between computers might fail. If the rules are set to request authentication only, then an IPsec authentication failure results in fall\-back\-to\-clear behavior, so communications can continue while the authentication failures are investigated.  
  
-   The requirement that all computers that must communicate with each other share a common set of:  
  
    -   Authentication methods  
  
    -   Main mode key exchange algorithms  
  
    -   Quick mode data integrity algorithms  
  
    If at least one set of each does not match between two computers, then the computers cannot successfully communicate.  
  
After the design and deployment teams agree on these issues, they can proceed with the deployment of the [!INCLUDE[wfas](../Token/wfas_md.md)] design. For more information, see [Implementing Your Windows Firewall with Advanced Security Design Plan](../Topic/Implementing-Your-Windows-Firewall-with-Advanced-Security-Design-Plan.md).  
  
