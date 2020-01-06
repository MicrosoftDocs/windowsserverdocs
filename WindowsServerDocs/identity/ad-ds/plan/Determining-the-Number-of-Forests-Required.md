---
ms.assetid: 173b72c1-ac83-4f42-abab-cf58f43769f0
title: Determining the Number of Forests Required
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Determining the Number of Forests Required

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

To determine the number of forests that you must deploy, you need to carefully identify and evaluate the isolation and autonomy requirements for each group in your organization and map those requirements to the appropriate forest design models.  
  
When determining the number of forests to deploy for your organization, consider the following:  
  
-   Isolation requirements limit your design choices. Therefore, if you identify isolation requirements, make sure that the groups actually require data isolation and that data autonomy is not sufficient for their needs. Ensure that the various groups in your organization clearly understand the concepts of isolation and autonomy.  
  
-   Negotiating the design can be a lengthy process. It can be difficult for groups to come to an agreement about ownership and uses for available resources. Make sure that you allow enough time for the groups in your organization to conduct adequate research to identify their needs. Set firm deadlines for design decisions and get consensus from all parties on the established deadlines.  
  
-   Determining the number of forests to deploy involves balancing costs against benefits. A single-forest model is the most cost-effective option and requires the least amount of administrative overhead. Although a group in the organization might prefer autonomous service operations, it might be more cost-effective for the organization to subscribe to service delivery from a centralized and trusted information technology (IT) group. This allows the group to own data management without creating the added costs of service management. Balancing costs against benefits might require input from the executive sponsor.  
  
    A single forest is the easiest configuration to manage. It allows for maximum collaboration within the environment because:  
  
    -   All objects in a single forest are listed in the global catalog. Therefore, no synchronization across forests is required.  
  
    -   Management of a duplicate infrastructure is not required.  
  
-   We do not recommend co-ownership of a single forest by two separate and autonomous IT organizations. In the future, the goals of the two IT groups might change, so that they can no longer accept shared control.  
  
-   We do not recommend outsourcing service administration to more than one outside partner. Multinational organizations that have groups in different countries or regions might choose to outsource service administration to a different outside partner for each country or region. Because multiple outside partners cannot be isolated from one another, the actions of one partner can affect the service of the other, which makes it difficult to hold the partners accountable to their service level agreements.  
  
-   Only one instance of an Active Directory domain should exist at any time. Microsoft does not support cloning, splitting, or copying domain controllers from one domain in an attempt to establish a second instance of the same domain. For more information about this limitation, see the following section.  
  
## Restructuring limitations  
When a company acquires another company, business unit, or product line, the purchasing company might also want to acquire corresponding IT assets from the seller. Specifically, the buyer might want to acquire some or all of the domain controllers that host the user accounts, computer accounts, and security groups that correspond to the business assets that are to be acquired. The only supported methods for the buyer to acquire the IT assets that are stored in the seller's Active Directory forest are as follows:  
  
1.  Acquire the only instance of the forest, including all domain controllers and directory data in the seller's entire forest.  
  
2.  Migrate the needed directory data from the seller's forest or domains to one or more of the buyer's domains. The target for such a migration might be an entirely new forest or one or more existing domains that are already deployed in the buyer's forest.  
  
This support limitation exists because:  
  
-   Each domain in an Active Directory forest is assigned a unique identity during the creation of the forest. Copying domain controllers from an original domain to a cloned domain compromises the security of both the domains and the forest. Threats to the original domain and the cloned domain include the following:  
  
    -   Sharing of passwords that can be used to gain access to resources  
  
    -   Insight regarding privileged user accounts and groups  
  
    -   Mapping of IP addresses to computer names  
  
    -   Additions, deletions, and modifications of directory information if domain controllers in a cloned domain ever establish network connectivity with domain controllers from the original domain  
  
-   Cloned domains share a common security identity; therefore, trust relationships cannot be established between them, even if one or both of the domains have been renamed.  
  
## In this section  
  
-   [Forest Design Models](https://technet.microsoft.com/library/cc770439.aspx)  
  
-   [Mapping Design Requirements to Forest Design Models](Forest-Design-Models.md)  
  
-   [Using the Organizational Domain Forest Model](../../ad-ds/plan/Using-the-Organizational-Domain-Forest-Model.md)  
  


