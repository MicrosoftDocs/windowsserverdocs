---
ms.assetid: c4d83dd3-2846-4658-8b9c-93901ee69766
title: Deploying Federation Servers
description:
author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
ms.author: billmath
---

# Deploying Federation Servers

To deploy federation servers in Active Directory Federation Services \(AD FS\), complete each of the tasks in [Checklist: Setting Up a Federation Server](Checklist--Setting-Up-a-Federation-Server.md).  
  
> [!NOTE]  
> When you use this checklist, we recommend that you first read the references to federation server planning in the [AD FS Design Guide in Windows Server 2012](https://technet.microsoft.com/library/dd807036.aspx) before you begin the procedures for configuring the servers. Following the checklist in this way provides a better understanding of the design and deployment process for federation servers.  
  
## About federation servers  
Federation servers are computers running  Windows Server 2008  with the AD FS software installed that have been configured to act in the federation server role. Federation servers authenticate or route requests from user accounts in other organizations and from client computers that can be located anywhere on the Internet.  
  
The act of installing the AD FS software on a computer and using the AD FS Federation Server Configuration Wizard to configure it for the federation server role makes that computer a federation server. It also makes the AD FS Management snap\-in available on that computer in the **Start\\Administrative Tools\\** menu so that you can specify the following:  
  
-   The AD FS host name where partner organizations and applications will send token requests and responses  
  
-   The AD FS identifier that partner organizations and applications will use to identify the unique name or location of your organization  
  
-   The token\-signing certificate that all federation servers in a server farm will use to issue and sign tokens  
  
-   The location of customized ASP.NET Web pages for client logon, logoff, and account partner discovery that will enhance the client experience  
  
    > [!NOTE]  
    > The majority of these core user interface \(UI\) settings are contained in the web.config file on each federation server. The AD FS host name and AD FS identifier values are not specified in the web.config file.  
  
Federation servers host a claims issuance engine that issues tokens based on the credentials \(for example, user name and password\) that are presented to it. A security token is a cryptographically signed data unit that expresses one or more claims. A claim is a statement that a server makes \(for example, name, identity, key, group, privilege, or capability\) about a client. After the credentials are verified on the federation server \(through the user logon process\), claims for the user are collected through examination of the user attributes that are stored in the specified attribute store.  
  
In Federated Web Single\-Sign\-On \(SSO\) designs \(AD FS designs in which two or more organizations are involved\), claims can be modified by claim rules for a specific relying party. The claims are built into a token that is sent to a federation server in the resource partner organization. After a federation server in the resource partner receives the claims as incoming claims, it executes the claims issuance engine to run a set of claim rules to filter, pass through, or transform those claims. The claims are then built into a new token that is sent to the Web server in the resource partner.  
  
In the Web SSO design \(an AD FS design in which only one organization is involved\), a single federation server can be used so that employees can log on once and still access multiple applications.  
  
