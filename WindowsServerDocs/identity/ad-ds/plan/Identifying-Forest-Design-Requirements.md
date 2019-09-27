---
ms.assetid: 7d957ebb-3476-49d8-b00b-6e93b4a94778
title: Identifying Forest Design Requirements
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/07/2018
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---
# Identifying Forest Design Requirements

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

To create a forest design for your organization, you must identify the business requirements that your directory structure needs to accommodate. This involves determining how much autonomy the groups in your organization need to manage their network resources and whether or not each group needs to isolate their resources on the network from other groups.  
  
Active Directory Domain Services (AD DS) enables you to design a directory infrastructure that accommodates multiple groups within an organization that have unique management requirements and to achieve structural and operational independence between groups as needed.  
  
Groups in your organization might have some of the following types of requirements:  
  
-   **Organizational structure requirements**. Parts of an organization might participate in a shared infrastructure to save costs but require the ability to operate independently from the rest of the organization. For example, a research group within a large organization might need to maintain control over all of their own research data.  
  
-   **Operational requirements**. One part of an organization might place unique constraints on the directory service configuration, availability, or security, or use applications that place unique constraints on the directory. For example, individual business units within an organization might deploy directory-enabled applications that modify the directory schema that are not deployed by other business units. Because the directory schema is shared between all the domains in the forest, creating multiple forests is one solution for such a scenario. Other examples are found in the following organizations and scenarios:  
  
    -   Military organizations  
  
    -   Hosting scenarios  
  
    -   Organizations that maintain a directory that is available both internally and externally (such as those that are publicly accessible by users on the Internet)  
  
-   **Legal requirements**. Some organizations have legal requirements to operate in a specific way, for example, restricting access to certain information as specified in a business contract. Some organizations have security requirements to operate on isolated internal networks. Failure to meet these requirements can result in loss of the contract and possibly legal action.  
  
Part of identifying your forest design requirements involves identifying the degree to which groups in your organization can trust the potential forest owners and their service administrators and identifying the autonomy and isolation requirements for each group in your organization.  
  
The design team must document the isolation and autonomy requirements for service and data administration for each group in the organization that intends to use AD DS. The team must also note any areas of limited connectivity that might affect the deployment of AD DS.  
  
The design team must document the isolation and autonomy requirements for service and data administration for each group in the organization that intends to use AD DS. The team must also note any areas of limited connectivity that might affect the deployment of AD DS. For a worksheet to assist you in documenting the regions you identified, download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip from [Job Aids for Windows Server 2003 Deployment Kit](https://go.microsoft.com/fwlink/?LinkID=102558) and open "Forest Design Requirements" (DSSLOGI_2.doc).  
  
## In this section  
  
-   [Service Administrator Scope of Authority](../../ad-ds/plan/Service-Administrator-Scope-of-Authority.md)  
  
-   [Autonomy vs. Isolation](../../ad-ds/plan/Autonomy-vs.-Isolation.md)  
