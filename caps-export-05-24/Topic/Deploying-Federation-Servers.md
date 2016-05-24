---
title: Deploying Federation Servers
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a86d79b3-3f7b-4d2b-81e1-ba69cb5ae766
author: billmath
---
# Deploying Federation Servers
To deploy [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s in [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], complete each of the tasks in [Checklist: Setting Up a Federation Server](../Topic/Checklist--Setting-Up-a-Federation-Server.md).  
  
> [!NOTE]  
> When you use this checklist, we recommend that you first read the references to [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] planning in the [AD FS Design Guide in Windows Server 2012](../Topic/AD-FS-Design-Guide-in-Windows-Server-2012.md) before you begin the procedures for configuring the servers. Following the checklist in this way provides a better understanding of the design and deployment process for [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s.  
  
## About federation servers  
Federation servers are computers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] with the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] software installed that have been configured to act in the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] role. Federation servers authenticate or route requests from user accounts in other organizations and from client computers that can be located anywhere on the Internet.  
  
The act of installing the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] software on a computer and using the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Federation Server Configuration Wizard to configure it for the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] role makes that computer a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]. It also makes the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management snap\-in available on that computer in the **Start\\Administrative Tools\\** menu so that you can specify the following:  
  
-   The [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] host name where partner organizations and applications will send token requests and responses  
  
-   The [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] identifier that partner organizations and applications will use to identify the unique name or location of your organization  
  
-   The token\-signing certificate that all [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s in a server farm will use to issue and sign tokens  
  
-   The location of customized ASP.NET Web pages for client logon, logoff, and account partner discovery that will enhance the client experience  
  
    > [!NOTE]  
    > The majority of these core user interface \(UI\) settings are contained in the web.config file on each [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]. The [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] host name and [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] identifier values are not specified in the web.config file.  
  
Federation servers host a claims issuance engine that issues tokens based on the credentials \(for example, user name and password\) that are presented to it. A security token is a cryptographically signed data unit that expresses one or more claims. A claim is a statement that a server makes \(for example, name, identity, key, group, privilege, or capability\) about a client. After the credentials are verified on the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] \(through the user logon process\), claims for the user are collected through examination of the user attributes that are stored in the specified attribute store.  
  
In Federated Web Single\-Sign\-On \(SSO\) designs \([!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] designs in which two or more organizations are involved\), claims can be modified by claim rules for a specific relying party. The claims are built into a token that is sent to a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in the resource partner organization. After a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in the resource partner receives the claims as incoming claims, it executes the claims issuance engine to run a set of claim rules to filter, pass through, or transform those claims. The claims are then built into a new token that is sent to the Web server in the resource partner.  
  
In the Web SSO design \(an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] design in which only one organization is involved\), a single [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] can be used so that employees can log on once and still access multiple applications.  
  
