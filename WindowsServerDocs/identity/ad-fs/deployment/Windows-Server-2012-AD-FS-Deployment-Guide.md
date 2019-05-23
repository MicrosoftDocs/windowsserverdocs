---
ms.assetid: e2ad9e80-a036-4bac-a4fb-afa83756aa1f
title: Windows Server 2012 AD FS Deployment Guide
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Windows Server 2012 AD FS Deployment Guide


You can use Active Directory® Federation Services \(AD FS\) with the Windows Server® 2012 operating system to build a federated identity management solution that extends distributed identification, authentication, and authorization services to Web\-based applications across organization and platform boundaries. By deploying AD FS, you can extend your organization’s existing identity management capabilities to the Internet.  
  
You can deploy AD FS to:  
  
-   Provide your employees or customers with a Web\-based, single\-sign\-on \(SSO\) experience when they need remote access to internally hosted Web sites or services.  
  
-   Provide your employees or customers with a Web\-based, SSO experience when they access cross\-organizational Web sites or services from within the firewalls of your network.  
  
-   Provide your employees or customers with seamless access to Web\-based resources in any federation partner organization on the Internet without requiring employees or customers to log on more than once.  
  
-   Retain complete control over your employee or customer identities without using other sign\-on providers \(Windows Live ID, Liberty Alliance, and others\).  
  
## About this guide  
This guide is intended for use by system administrators and system engineers. It provides detailed guidance for deploying an AD FS design that has been preselected by you or an infrastructure specialist or system architect in your organization.  
  
If a design has not yet been selected, we recommend that you wait to follow the instructions in this guide until after you have reviewed the design options in the [AD FS Design Guide in Windows Server 2012](https://technet.microsoft.com/library/dd807036.aspx) and you have selected the most appropriate design for your organization. For more information about using this guide with a design that has already been selected, see [Implementing Your AD FS Design Plan](Implementing-Your-AD-FS-Design-Plan.md).  
  
After you select your design from the design guide and gather the required information about claims, token types, attribute stores, and other items, you can use this guide to deploy your AD FS design in your production environment. This guide provides steps for deploying either of the following primary AD FS designs:  
  
-   Web SSO  
  
-   Federated Web SSO  
  
Use the checklists in [Implementing Your AD FS Design Plan](Implementing-Your-AD-FS-Design-Plan.md) to determine how best to use the instructions in this guide to deploy your particular design. For information about hardware and software requirements for deploying AD FS, see the [Appendix A: Reviewing AD FS Requirements](https://technet.microsoft.com/library/ff678034.aspx) in the AD FS Design Guide.  
  
### What this guide does not provide  
This guide does not provide:  
  
-   Guidance regarding when and where to place federation servers, federation server proxies, or Web servers in your existing network infrastructure. For this information, see [Planning Federation Server Placement](https://technet.microsoft.com/library/dd807069.aspx) and [Planning Federation Server Proxy Placement](https://technet.microsoft.com/library/dd807130.aspx) in the AD FS Design Guide.  
  
-   Guidance for using certification authorities \(CAs\) to set up AD FS  
  
-   Guidance for setting up or configuring specific Web\-based applications  
  
-   Setup instructions that are specific to setting up a test lab environment.  
  
-   Information about how to customize federated logon screens, web.config files, or the configuration database.  
  
## In this guide  
  
-   [Planning to Deploy AD FS](Planning-to-Deploy-AD-FS.md)  
  
-   [Implementing Your AD FS Design Plan](Implementing-Your-AD-FS-Design-Plan.md)  
  
-   [Checklist: Implementing a Web SSO Design](Checklist--Implementing-a-Web-SSO-Design.md)  
  
-   [Checklist: Implementing a Federated Web SSO Design](Checklist--Implementing-a-Federated-Web-SSO-Design.md)  
  
-   [Configuring Partner Organizations](Configuring-Partner-Organizations.md)  
  
-   [Configuring Claim Rules](Configuring-Claim-Rules.md)  
  
-   [Deploying Federation Servers](Deploying-Federation-Servers.md)  
  
-   [Deploying Federation Server Proxies](Deploying-Federation-Server-Proxies.md)  
  
-   [Interoperating with AD FS 1.x](Interoperating-with-AD-FS-1.x.md)  
