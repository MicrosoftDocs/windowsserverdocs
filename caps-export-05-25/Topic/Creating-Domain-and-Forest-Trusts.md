---
title: Creating Domain and Forest Trusts
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 8063428c-2459-456b-be98-2ec207292f80
author: Femila
---
# Creating Domain and Forest Trusts
  In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], there are four trust types that must be created manually. External trusts, realm trusts, and forest trusts help provide interoperability with realms or with domains outside your forest. Shortcut trusts optimize access to resources and logons that are made between domain trees in the same forest.  
  
 This section includes the following tasks for creating domain and forest trusts:  
  
-   [Creating External Trusts](../Topic/Creating-External-Trusts.md)  
  
-   [Creating Shortcut Trusts](../Topic/Creating-Shortcut-Trusts.md)  
  
-   [Creating Forest Trusts](../Topic/Creating-Forest-Trusts.md)  
  
-   [Creating Realm Trusts](../Topic/Creating-Realm-Trusts.md)  
  
    > [!NOTE]  
    >  A trust does not inherently allow users in a trusted domain to have access to resources in a trusting domain. Users have access when they are assigned the appropriate permissions. In some cases, users in trusted domains may have implicit access if the resources are assigned to members of the Authenticated Users group.  
  
 Before you use the procedures in these tasks, review the issues in [Known Issues for Creating Domain and Forest Trusts](../Topic/Known-Issues-for-Creating-Domain-and-Forest-Trusts.md).  
  
## New Trust Wizard terminology  
 You create trusts in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] with the New Trust Wizard. Before you use the New Trust Wizard, review the following terminology. Each highlighted term represents the exact term as it is used in the wizard:  
  
-   **This domain:** The domain from which you launch the New Trust Wizard. When you start the wizard, it immediately verifies your administrative credentials in the domain for which you are the administrator. Therefore, the wizard uses the term “this domain” to represent the domain that you are currently logged on to.  
  
-   **Local domain \/ Local forest:** The domain or forest where you start the New Trust Wizard.  
  
-   **Specified domain \/ Specified forest:** The other domain or forest that this local domain or local forest will trust. Although the New Trust Wizard is aware of the domain context in which it is running, it does not have knowledge of the other domain that you want to create the relationship with. After you type the name of the other domain or forest in the **Trust Name** page, that name is used whenever the wizard refers to the specified domain or specified forest.  
  
-   **Two\-way trust:** A trust relationship between two domains in which both domains trust each other. For example, domain A trusts domain B, and domain B trusts domain A. All parent\-child trusts are two\-way trusts.  
  
-   **One\-way: incoming trust:** A one\-way trust relationship between two domains in which the direction of the trust points toward the domain from which you start the New Trust Wizard \(and which is identified in the wizard as **This domain**\). When the direction of the trust points toward your domain, users in your domain can access resources in the specified domain. For example, if you are the domain administrator in domain A and you create a one\-way, incoming trust to domain B, this provides a relationship through which users who are located in domain A can access resources in domain B. Because this relationship is one way, users in domain B cannot access resources in domain A.  
  
-   **One\-way: outgoing trust:** A one\-way trust relationship between two domains in which the direction of the trust points toward the domain that is identified as **Specified domain** in the New Trust Wizard. When the direction of trust points toward the specified domain, users in the specified domain can access resources in your domain. For example, if you are the domain administrator in domain A and you create a one\-way, outgoing trust to domain B, this action provides a relationship through which users who are located in domain B can access resources in domain A. Because this relationship is one way, users in domain A cannot access resources in domain B.  
  
-   **Both sides of the trust:** When you create external trusts, shortcut trusts, or forest trusts, you have the option to create each side of the trust separately or both sides of the trust simultaneously. If you choose to create each side of the trust separately, you must run the New Trust Wizard twice—once for each domain. When you create trusts separately, you must supply the same trust password for each domain. As a security best practice, all trust passwords should be strong passwords.  
  
-   **Domain\-wide authentication:** An authentication setting that permits unrestricted access by any users in the specified domain to all available shared resources that are located in the local domain. This is the default authentication setting for external trusts.  
  
-   **Forest\-wide authentication:** An authentication setting that permits unrestricted access by any users in the specified forest to all available shared resources that are located in any of the domains in the local forest. This is the default authentication setting for forest trusts.  
  
-   **Selective authentication:** An authentication setting that restricts access over an external trust or forest trust to only those users in a specified domain or specified forest who have been explicitly given authentication permissions to computer objects \(resource computers\) that reside in the local domain or the local forest. This authentication setting must be enabled manually.  
  
-   **Trust password:** An option in which both domains in a trust relationship share a password, which is stored in the trusted domain object \(TDO\) object in Active Directory Domain Services \(AD DS\). When you choose this option, a strong trust password is generated automatically for you. You must use the same password when you create a trust relationship in the specified domain. If you choose to create both sides of the trust simultaneously, you run the New Trust Wizard once.  
  
  