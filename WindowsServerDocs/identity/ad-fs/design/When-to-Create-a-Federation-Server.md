---
ms.assetid: 824005ae-c3c1-459b-9baa-1660158918ab
title: When to Create a Federation Server
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# When to Create a Federation Server

When you create a federation serverin Active Directory Federation Services \(AD FS\), you provide a means by which your organization can:  
  
-   Engage in Web single\-sign\-on \(SSO\)–based communication with another organization \(that also has at least one federation server\) and, when necessary, with the employees in your own organization \(who need access over the Internet\).  
  
-   Enable front end services to impersonate users to infrastructure services using identity delegation. For more information, see [When to Use Identity Delegation](When-to-Use-Identity-Delegation.md).  
  
The following sections describe some of the key decisions for determining when and where to create one or more federation servers.  
  
## Determine the organizational role for the federation server  
To make an informed decision regarding when to create a new federation server, you must first determine in which organization the server will reside. The role that a federation server plays in an organization depends on whether you place the federation server in the account partner organization or in the resource partner organization.  
  
When a federation server is placed in the corporate network of the account partner, its role is to authenticate the user credentials of browser, Web service, or identity selector clients and send security tokens to the clients. For more information, see [Review the Role of the Federation Server in the Account Partner](Review-the-Role-of-the-Federation-Server-in-the-Account-Partner.md).  
  
When a federation server is placed in the corporate network of the resource partner, its role is to authenticate users, based on a security token that is issued by a federation server in the resource partner organization, or its role is to redirect token requests from configured Web applications or Web services to the account partner organization that the client belongs to. For more information, see [Review the Role of the Federation Server in the Resource Partner](Review-the-Role-of-the-Federation-Server-in-the-Resource-Partner.md).  
  
## Determine which AD FS design to deploy  
You create federation servers in your organization whenever you want to deploy any of the following AD FS designs:  
  
-   [Web SSO Design](Web-SSO-Design.md)  
  
-   [Federated Web SSO Design](Federated-Web-SSO-Design.md)  
  
If necessary, an organization that deploys a Federated Web SSO design can configure a single federation server so that it acts in both the account partner role and in the resource partner role. In this case, the federation server may produce Security Assertion Markup Language \(SAML\) tokens, based on user accounts in its own organization, or reroute token requests to the organization, based on where the users' accounts reside.  
  
> [!NOTE]  
> For the Federated Web SSO design, there must be at least one federation server in the account partner and at least one federation server in the resource partner.  
  
## Differences between a federation server and a federation server proxy  
A federation server can serve out Web pages for sign\-in, policy, authentication, and discovery in the same way that a federation server proxy does. The primary differences between a federation server and a federation server proxy have to do with what operations a federation server can perform that a federation server proxy cannot perform.  
  
The following are the operations that only a federation server can perform:  
  
-   The federation server performs the cryptographic operations that produce the token. Although federation server proxies cannot produce tokens, they can be used to route or redirect the tokens to clients and, when necessary, back to the federation server. For more information about using federation servers, see [When to Create a Federation Server Proxy](When-to-Create-a-Federation-Server-Proxy.md).  
  
-   Federation servers support the use of Windows Integrated Authentication for clients on the corporate network; federation server proxies do not. For more information about using Windows Integrated Authentication with federation server, see [When to Create a Federation Server Farm](When-to-Create-a-Federation-Server-Farm.md).  
  
> [!CAUTION]  
> Communication between federation servers and SQL Server configuration databases, SQL Server attribute stores, domain controllers, and AD LDS instances is not integrity or confidentiality protected by default. To mitigate this, consider protecting the communication channel between these servers using IPSEC or using a physically secure connection between all of these servers. For communication between federation servers and SQL servers, consider using SSL protection in the connection string. For connections between federation servers and domain controllers, consider turning on Kerberos signing and encryption. For LDAP, LDAP\/S is not supported for AD LDS\/AD DS.  
  
## How to create a federation server  
You can create a federation server using the AD FS Federation Server Configuration Wizard or the Fsconfig.exe command\-line tool. When you use either of these tools, you can select any of the following options to create a federation server.  
  
-   Create a stand\-alone federation server  
  
    For more information about how to set up a stand\-alone federation server, see [Create a Stand-Alone Federation Server](../../ad-fs/deployment/Create-a-Stand-Alone-Federation-Server.md).  
  
-   Create the first federation server in a federation server farm  
  
    For more information about how to set up the first federation server or add a federation server to a farm, see [Create the First Federation Server in a Federation Server Farm](../../ad-fs/deployment/Create-the-First-Federation-Server-in-a-Federation-Server-Farm.md).  
  
-   Add a federation server to a federation server farm  
  
    For more information about how to add a federation server to a farm, see [Add a Federation Server to a Federation Server Farm](../../ad-fs/deployment/Add-a-Federation-Server-to-a-Federation-Server-Farm.md).  
  
For more detailed information about how each of these options work, see [The Role of the AD FS Configuration Database](../../ad-fs/technical-reference/The-Role-of-the-AD-FS-Configuration-Database.md).  
  
For more information about how to set up all the prerequisites necessary to deploy a federation server, see [Checklist: Setting Up a Federation Server](../../ad-fs/deployment/Checklist--Setting-Up-a-Federation-Server.md).  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)

