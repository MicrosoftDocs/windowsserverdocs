---
title: Windows Server 2012 AD FS Deployment Guide
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a987c9e5-910e-410f-a780-4c9630fe2809
author: billmath
---
# Windows Server 2012 AD FS Deployment Guide
  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure identity solutions](http://aka.ms/m2w274).<br /><br />Create a hybrid identity solution in Microsoft Azure:<br />\- [Integrate your on\-premises identities with Azure AD using Azure AD Connect.](http://aka.ms/f51oy5)|  
  
You can use Active Directory® Federation Services \(AD FS\) with the [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] operating system to build a federated identity management solution that extends distributed identification, authentication, and authorization services to Web\-based applications across organization and platform boundaries. By deploying [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], you can extend your organization’s existing identity management capabilities to the Internet.  
  
You can deploy [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] to:  
  
-   Provide your employees or customers with a Web\-based, single\-sign\-on \(SSO\) experience when they need remote access to internally hosted Web sites or services.  
  
-   Provide your employees or customers with a Web\-based, SSO experience when they access cross\-organizational Web sites or services from within the firewalls of your network.  
  
-   Provide your employees or customers with seamless access to Web\-based resources in any federation partner organization on the Internet without requiring employees or customers to log on more than once.  
  
-   Retain complete control over your employee or customer identities without using other sign\-on providers \(Windows Live ID, Liberty Alliance, and others\).  
  
## About this guide  
This guide is intended for use by system administrators and system engineers. It provides detailed guidance for deploying an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] design that has been preselected by you or an infrastructure specialist or system architect in your organization.  
  
If a design has not yet been selected, we recommend that you wait to follow the instructions in this guide until after you have reviewed the design options in the [AD FS Design Guide in Windows Server 2012](../Topic/AD-FS-Design-Guide-in-Windows-Server-2012.md) and you have selected the most appropriate design for your organization. For more information about using this guide with a design that has already been selected, see [Implementing Your AD FS Design Plan](../Topic/Implementing-Your-AD-FS-Design-Plan.md).  
  
After you select your design from the design guide and gather the required information about claims, token types, attribute stores, and other items, you can use this guide to deploy your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] design in your production environment. This guide provides steps for deploying either of the following primary [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] designs:  
  
-   Web SSO  
  
-   Federated Web SSO  
  
Use the checklists in [Implementing Your AD FS Design Plan](../Topic/Implementing-Your-AD-FS-Design-Plan.md) to determine how best to use the instructions in this guide to deploy your particular design. For information about hardware and software requirements for deploying [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], see the [Appendix A: Reviewing AD FS Requirements](../Topic/Appendix-A--Reviewing-AD-FS-Requirements.md) in the AD FS Design Guide.  
  
### What this guide does not provide  
This guide does not provide:  
  
-   Guidance regarding when and where to place [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)]s, [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] proxies, or Web servers in your existing network infrastructure. For this information, see [Planning Federation Server Placement](../Topic/Planning-Federation-Server-Placement.md) and [Planning Federation Server Proxy Placement](../Topic/Planning-Federation-Server-Proxy-Placement.md) in the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Design Guide.  
  
-   Guidance for using certification authorities \(CAs\) to set up [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]  
  
-   Guidance for setting up or configuring specific Web\-based applications  
  
-   Setup instructions that are specific to setting up a test lab environment.  
  
-   Information about how to customize federated logon screens, web.config files, or the configuration database.  
  
## In this guide  
  
-   [Planning to Deploy AD FS](../Topic/Planning-to-Deploy-AD-FS.md)  
  
-   [Implementing Your AD FS Design Plan](../Topic/Implementing-Your-AD-FS-Design-Plan.md)  
  
-   [Checklist: Implementing a Web SSO Design](../Topic/Checklist--Implementing-a-Web-SSO-Design.md)  
  
-   [Checklist: Implementing a Federated Web SSO Design](../Topic/Checklist--Implementing-a-Federated-Web-SSO-Design.md)  
  
-   [Configuring Partner Organizations](../Topic/Configuring-Partner-Organizations.md)  
  
-   [Configuring Claim Rules](../Topic/Configuring-Claim-Rules.md)  
  
-   [Deploying Federation Servers](../Topic/Deploying-Federation-Servers.md)  
  
-   [Deploying Federation Server Proxies_1](../Topic/Deploying-Federation-Server-Proxies_1.md)  
  
-   [Interoperating with AD FS 1.x](../Topic/Interoperating-with-AD-FS-1.x.md)  
  
## Acknowledgments  
Author: Nick Pierson  
  
Technical Reviewers: Matt Steele, Lu Zhao \(Migration\)  
  
Editor: Jim Becker  
  
