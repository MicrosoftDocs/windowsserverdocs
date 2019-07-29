---
ms.assetid: d04dd17e-a843-46fd-8711-0039918f92d9
title: Implementing Your AD FS Design Plan
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---

# Implementing Your AD FS Design Plan

The following environmental conditions and requirements are important factors in the implementation of your Active Directory Federation Services \(AD FS\) design plan:  
  
-   **Supported partners:** You usually use AD FS to work with partner organizations. To establish identity federation, determine the organizations with which you want to form a partnership. After a baseline AD FS deployment is in place, operating with partners involves adding partners, deleting partners, and updating partner information. Changes to partnerships may occur for a variety of reasons. For example, your AD FS deployment might require partnership updates if your partner changes its business significantly, your organization becomes part of a larger organization or a federation of organizations, or your organization is acquired by a different company. In any scenario in which you federate identities from multiple domains, you will need to know the domains \(partners\) that you are currently supporting and all the additional domains that represent potential partners.  
  
-   **Supported application and service types:** Some applications and services require access to operating system resources, while others are "claims aware." It is important to understand the types of applications and services that AD FS supports so that you can formulate administration requirements.  
  
-   **Logical and physical architectural diagrams or deployment topology:** You will need to know:  
  
    -   Whether federation servers will function in a set of farmed servers or on a single server.  
  
    -   Where your network deploys firewalls and proxies.  
  
    -   The location of resources and whether users are accessing resources from within your organization, outside the organization, or both.  
  
## How to implement your AD FS design using this guide  
The next step in implementing your design is to determine in what order each deployment task must be performed. This guide uses checklists to help you walk through the various server and application deployment tasks that are required to implement your design plan. Parent and child checklists are used as necessary to represent the order in which tasks for a specific AD FS design must be processed.  
  
Use the following parent checklists in this section of the guide to become familiar with the deployment tasks for implementing your organization's preferred AD FS design:  
  
-   [Checklist: Implementing a Web SSO Design](Checklist--Implementing-a-Web-SSO-Design.md)  
  
-   [Checklist: Implementing a Federated Web SSO Design](Checklist--Implementing-a-Federated-Web-SSO-Design.md)  
