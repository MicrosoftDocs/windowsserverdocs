---
title: When to Create a Federation Server
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c5eb15d0-976d-48db-8854-2e9e61521340
author: billmath
---
# When to Create a Federation Server
When you create a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]in [!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)], you provide a means by which your organization can:  
  
-   Engage in Web single\-sign\-on \(SSO\)–based communication with another organization \(that also has at least one [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]\) and, when necessary, with the employees in your own organization \(who need access over the Internet\).  
  
-   Enable front end services to impersonate users to infrastructure services using identity delegation. For more information, see [When to Use Identity Delegation](When-to-Use-Identity-Delegation.md).  
  
The following sections describe some of the key decisions for determining when and where to create one or more [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]s.  
  
## Determine the organizational role for the federation server  
To make an informed decision regarding when to create a new [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)], you must first determine in which organization the server will reside. The role that a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] plays in an organization depends on whether you place the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] in the account partner organization or in the resource partner organization.  
  
When a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] is placed in the corporate network of the account partner, its role is to authenticate the user credentials of browser, Web service, or identity selector clients and send security tokens to the clients. For more information, see [Review the Role of the Federation Server in the Account Partner](Review-the-Role-of-the-Federation-Server-in-the-Account-Partner.md).  
  
When a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] is placed in the corporate network of the resource partner, its role is to authenticate users, based on a security token that is issued by a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] in the resource partner organization, or its role is to redirect token requests from configured Web applications or Web services to the account partner organization that the client belongs to. For more information, see [Review the Role of the Federation Server in the Resource Partner](Review-the-Role-of-the-Federation-Server-in-the-Resource-Partner.md).  
  
## Determine which AD FS design to deploy  
You create [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]s in your organization whenever you want to deploy any of the following [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] designs:  
  
-   [Web SSO Design](Web-SSO-Design.md)  
  
-   [Federated Web SSO Design](Federated-Web-SSO-Design.md)  
  
If necessary, an organization that deploys a Federated Web SSO design can configure a single [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] so that it acts in both the account partner role and in the resource partner role. In this case, the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] may produce Security Assertion Markup Language \(SAML\) tokens, based on user accounts in its own organization, or reroute token requests to the organization, based on where the users' accounts reside.  
  
> [!NOTE]  
> For the Federated Web SSO design, there must be at least one [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] in the account partner and at least one [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] in the resource partner.  
  
## Differences between a federation server and a federation server proxy  
A [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] can serve out Web pages for sign\-in, policy, authentication, and discovery in the same way that a [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] does. The primary differences between a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] and a [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] have to do with what operations a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] can perform that a [!INCLUDE[adfs2_fsp](includes/adfs2_fsp_md.md)] cannot perform.  
  
The following are the operations that only a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] can perform:  
  
-   The [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] performs the cryptographic operations that produce the token. Although [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies cannot produce tokens, they can be used to route or redirect the tokens to clients and, when necessary, back to the [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]. For more information about using [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)]s, see [When to Create a Federation Server Proxy](When-to-Create-a-Federation-Server-Proxy.md).  
  
-   Federation servers support the use of Windows Integrated Authentication for clients on the corporate network; [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] proxies do not. For more information about using Windows Integrated Authentication with [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)], see [When to Create a Federation Server Farm](When-to-Create-a-Federation-Server-Farm.md).  
  
> [!CAUTION]  
> Communication between federation servers and SQL Server configuration databases, SQL Server attribute stores, domain controllers, and AD LDS instances is not integrity or confidentiality protected by default. To mitigate this, consider protecting the communication channel between these servers using IPSEC or using a physically secure connection between all of these servers. For communication between federation servers and SQL servers, consider using SSL protection in the connection string. For connections between federation servers and domain controllers, consider turning on Kerberos signing and encryption. For LDAP, LDAP\/S is not supported for AD LDS\/AD DS.  
  
## How to create a federation server  
You can create a federation server using the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] Federation Server Configuration Wizard or the Fsconfig.exe command\-line tool. When you use either of these tools, you can select any of the following options to create a federation server.  
  
-   Create a stand\-alone federation server  
  
    For more information about how to set up a stand\-alone federation server, see [Create a Stand-Alone Federation Server](Create-a-Stand-Alone-Federation-Server.md).  
  
-   Create the first federation server in a federation server farm  
  
    For more information about how to set up the first federation server or add a federation server to a farm, see [Create the First Federation Server in a Federation Server Farm](Create-the-First-Federation-Server-in-a-Federation-Server-Farm.md).  
  
-   Add a federation server to a federation server farm  
  
    For more information about how to add a federation server to a farm, see [Add a Federation Server to a Federation Server Farm](Add-a-Federation-Server-to-a-Federation-Server-Farm.md).  
  
For more detailed information about how each of these options work, see [The Role of the AD FS Configuration Database](The-Role-of-the-AD-FS-Configuration-Database.md).  
  
For more information about how to set up all the prerequisites necessary to deploy a federation server, see [Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md).  
  

