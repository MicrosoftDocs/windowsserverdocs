---
title: Connect to Applications and Services from Anywhere with Web Application Proxy
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9c9c4e8f-6635-4774-b6e1-f144b5d7ded8
author: kgremban
---
# Connect to Applications and Services from Anywhere with Web Application Proxy
  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure identity solutions](http://aka.ms/m2w274).<br /><br />Create a hybrid virtualization solution in Microsoft Azure:<br />\- [Publish applications with Application Proxy](http://aka.ms/jgttif)|  
  
This scenario describes how you can use [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] – a new Remote Access role service in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] – to provide access to a sample web application using claims\-based authentication and a sample website using Integrated Windows authentication, both websites use [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] preauthentication. This scenario also uses the following [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] features:  
  
-   **Workplace Join**—Joining devices to the workplace connects these devices with Active Directory in your workplace. When you join personal devices to your workplace they become known devices and will provide seamless second factor authentication and single\-sign\-on to workplace resources and applications.  
  
    This scenario configures the device registration service \(DRS\) to enable you to join the client device to the workplace.  
  
-   **Multifactor authentication**—This enables you to require users to provide more than one form of authentication when connecting to published applications and services. For example, using one\-time passwords or smart cards. You can configure [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] and [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] to use multifactor authentication for all authentication requests, or per\-application. In addition, configuring [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] to allow access to only registered devices creates two\-factor seamless authentication because the user must provide credentials, and the device must be registered.  
  
    This scenario uses certificate authentication to provide the additional factor when authenticating.  
  
-   **Multifactor access control**—Access control in [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] is implemented with authorization claim rules that are used to issue a permit or deny claims that will determine whether a user or a group of users will be allowed to access [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]\-secured resources or not. In [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], access control is enhanced with multiple factors, including user, device, location, and authentication data. This is made possible by a greater variety of claim types available for the authorization claim rules.  
  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] also provides built\-in [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] proxy capabilities. The following diagram shows the topology used in this scenario for [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] to publish Microsoft applications and other line\-of\-business \(LOB\) applications.  
  
![](../Image/WebApplicationProxyTopology.png)  
  
-   [Providing Access to Applications and Services](#AccesstoApps)  
  
-   [Using Active Directory Federation Services](#UsingADFS)  
  
-   [AD FS Proxy](#ADFSProxy)  
  
-   [Roles and Features Included in this Scenario](#Roles_Features)  
  
-   [Scenario Steps](#Steps)  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure identity solutions](http://aka.ms/m2w274).<br /><br />Create a hybrid virtualization solution in Microsoft Azure:<br />\- [Publish applications with Application Proxy](https://azure.microsoft.com/en-us/documentation/articles/active-directory-application-proxy-configure/)|  
  
## <a name="AccesstoApps"></a>Providing Access to Applications and Services  
This scenario demonstrates how to plan and deploy [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] in your organization to provide end users located outside of an organization access to applications and services running on servers inside the organization. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] publishing enables end users to access their organization’s applications from their own devices, so that users are not limited to corporate laptops to do their work, they can use their home computer, their tablet, or their smartphone. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] can be used on clients with a standard browser, an Office client or a rich client using OAuth \(for example Windows Store apps\). [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] serves as a reverse proxy for any application that is published through it and as such, the end user experience is the same as if the end user’s device connects directly to the application.  
  
## <a name="UsingADFS"></a>Using Active Directory Federation Services  
This scenario describes the additions and changes that you must make to your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers to provide the following functionality:  
  
-   Application publishing—For all applications and services that you want to publish through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], you must configure a relying party on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server.  
  
-   Authentication—No specific configuration is required to provide authentication for published applications. However, to use workplace join, MFA, or multifactor access control in your deployment, you must perform additional configuration as described in the following guides:  
  
    -   Workplace Join—[Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](../Topic/Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md)  
  
    -   MFA—[Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](../Topic/Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md)  
  
    -   Multifactor access control—[Manage Risk with Conditional Access Control](../Topic/Manage-Risk-with-Conditional-Access-Control.md).  
  
## <a name="ADFSProxy"></a>AD FS Proxy  
This scenario does not describe using [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] as a proxy for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]. However, this functionality is enabled by default when you install the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] role service. Any [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] endpoint that is enabled for proxy publishing is automatically published by [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] after completing the Web Application Proxy Configuration Wizard.  
  
## <a name="Roles_Features"></a>Roles and Features Included in this Scenario  
The following table lists the roles and features that are part of this scenario and describes how they support it.  
  
|Role\/feature|How it supports this scenario|  
|-----------------|---------------------------------|  
|[Active Directory Federation Services Overview](../Topic/Active-Directory-Federation-Services-Overview.md)|[!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] is required to provide authentication and authorization services to [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] and to store the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] configuration.|  
|[Web Application Proxy](../Topic/Web-Application-Proxy.md)|Web Application Proxy is the technology that can be used to publish applications and services running on servers inside the organization so they can then be accessed by end users located outside of an organization.|  
|[Active Directory Domain Services Overview](../Topic/Active-Directory-Domain-Services-Overview.md)|[!INCLUDE[ad_adds_1](../Token/ad_adds_1_md.md)] is required as a prerequisite before you can deploy [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)].|  
|[Web Server \(IIS\) overview](assetId:///c7443e73-2b39-4b12-b48a-2b00ab0abb0a)|The Web Server \(IIS\) role is used in this scenario to host a sample application that can be published by [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)].|  
  
## <a name="Steps"></a>Scenario Steps  
This scenario contains the following steps:  
  
-   [Set up the lab environment for AD FS in Windows Server 2012 R2](../Topic/Set-up-the-lab-environment-for-AD-FS-in-Windows-Server-2012-R2.md)  
  
-   [Walkthrough Guide: Connect to Applications and Services from Anywhere with Web Application Proxy](../Topic/Walkthrough-Guide--Connect-to-Applications-and-Services-from-Anywhere-with-Web-Application-Proxy.md)—This walkthrough contains the following steps:  
  
    -   [Step 1: Attempt to access the web application from an Internet client](../Topic/Walkthrough-Guide--Connect-to-Applications-and-Services-from-Anywhere-with-Web-Application-Proxy.md#BKMK_1.1)  
  
    -   [Step 2: Configure the Web Application Proxy server and publish the application](../Topic/Walkthrough-Guide--Connect-to-Applications-and-Services-from-Anywhere-with-Web-Application-Proxy.md#BKMK_1.2)  
  
    -   [Step 3: Configure and test accessing a site using Integrated Windows authentication](../Topic/Walkthrough-Guide--Connect-to-Applications-and-Services-from-Anywhere-with-Web-Application-Proxy.md#BKMK_3)  
  
    -   [Step 4: Demonstrate accessing an application using Workplace Join, MFA, and multifactor access control](../Topic/Walkthrough-Guide--Connect-to-Applications-and-Services-from-Anywhere-with-Web-Application-Proxy.md#BKMK_4)  
  
## See Also  
[Web Application Proxy Walkthrough Guide](../Topic/Web-Application-Proxy-Walkthrough-Guide.md)  
  
