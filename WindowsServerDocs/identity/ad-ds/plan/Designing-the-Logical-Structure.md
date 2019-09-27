---
ms.assetid: 9ad81367-f3fe-4b2e-bd7c-5900b2b9f77f
title: Designing the Logical Structure
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Designing the Logical Structure

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Active Directory Domain Services (AD DS) enables organizations to create a scalable, secure, and manageable infrastructure for user and resource management. It also enables them to support directory-enabled applications.  
  
A well-designed Active Directory logical structure provides the following benefits:  
  
-   Simplified management of Microsoft Windows-based networks that contain large numbers of objects  
  
-   A consolidated domain structure and reduced administration costs  
  
-   The ability to delegate administrative control over resources, as appropriate  
  
-   Reduced impact on network bandwidth  
  
-   Simplified resource sharing  
  
-   Optimal search performance  
  
-   Low total cost of ownership  
  
A well-designed Active Directory logical structure facilitates the efficient integration of such features as Group Policy; desktop lockdown; software distribution; and user, group, workstation, and server administration into your system. In addition, a carefully designed logical structure facilitates the integration of Microsoft and non-Microsoft applications and services, such as Microsoft Exchange Server, public key infrastructure (PKI), and a domain-based distributed file system (DFS).  
  
When you design an Active Directory logical structure before you deploy AD DS, you can optimize your deployment process to best take advantage of Active Directory features. To design the Active Directory logical structure, your design team first identifies the requirements for your organization and, based on this information, decides where to place the forest and domain boundaries. Then, the design team decides how to configure the Domain Name System (DNS) environment to meet the needs of the forest. Finally, the design team identifies the organizational unit (OU) structure that is required to delegate the management of resources in your organization.  
  
## In this guide  
  
-   [Understanding the Active Directory Logical Model](../../ad-ds/plan/Understanding-the-Active-Directory-Logical-Model.md)  
  
-   [Identifying the Deployment Project Participants](../../ad-ds/plan/Identifying-the-Deployment-Project-Participants.md)  
  
-   [Creating a Forest Design](../../ad-ds/plan/Creating-a-Forest-Design.md)  
  
-   [Creating a Domain Design](../../ad-ds/plan/Creating-a-Domain-Design.md)  
  
-   [Creating a DNS Infrastructure Design](../../ad-ds/plan/Creating-a-DNS-Infrastructure-Design.md)  
  
-   [Creating an Organizational Unit Design](../../ad-ds/plan/Creating-an-Organizational-Unit-Design.md)  
  
-   [Appendix A: DNS Inventory](../../ad-ds/plan/Appendix-A--DNS-Inventory.md)  
  


