---
title: Deploying AD FS in the Account Partner Organization
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a5e98dad-bcce-4b6e-a71e-d1fa2a1bc584
---
# Deploying AD FS in the Account Partner Organization
An account partner in [!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)] represents the organization in the federation trust relationship that physically stores user accounts in a supported attribute store. For more information about which attribute stores are supported, see [The Role of Attribute Stores](The-Role-of-Attribute-Stores.md).

The [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] in the account partner organization authenticates local users and creates security tokens that are used by the resource partner in making authorization decisions. Relying parties such as Web sites and Web services are then able to easily register themselves with the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] and consume issued tokens for authentication and access control.

In scenarios in which you need to provide your users with access to multiple federated applications or services—when each application or service is hosted by a different organization—you can configure the account partner [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] so that you can deploy multiple relying parties.

For more information about how to set up and configure an account partner organization, see [Checklist: Configuring the Account Partner Organization](Checklist--Configuring-the-Account-Partner-Organization.md).

## In this section

-   [Review the Role of the Federation Server in the Account Partner](Review-the-Role-of-the-Federation-Server-in-the-Account-Partner.md)

-   [Review the Role of the Federation Server Proxy in the Account Partner](Review-the-Role-of-the-Federation-Server-Proxy-in-the-Account-Partner.md)

-   [Prepare Client Computers in the Account Partner](Prepare-Client-Computers-in-the-Account-Partner.md)


