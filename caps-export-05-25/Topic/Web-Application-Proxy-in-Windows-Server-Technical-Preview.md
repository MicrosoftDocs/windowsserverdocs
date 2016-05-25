---
title: Web Application Proxy in Windows Server Technical Preview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 31e5931b-6a4c-4c28-b4ab-438915cef6dc
author: kgremban
---
# Web Application Proxy in Windows Server Technical Preview
**This content is relevant for the on\-premises version of Web Application Proxy. To enable secure access to on\-premises applications over the cloud, see the [Azure AD Application Proxy content](https://azure.microsoft.com/en-us/documentation/articles/active-directory-application-proxy-get-started/).**  
  
The content in this section describes what's new and changed in the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] for [!INCLUDE[winthreshold_server_1](../Token/winthreshold_server_1_md.md)]. The new features and changes listed here are the ones most likely to have the greatest impact as you work with the Preview.  
  
## Web Application Proxy New Features  
  
-   Preauthentication for HTTP Basic application publishing  
  
    HTTP Basic is the authorization protocol used by many protocols, including ActiveSync, to connect rich clients, including smartphones, with your Exchange mailbox. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] traditionally interacts with [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] using redirections which is not supported on ActiveSync clients. This new version of [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] provides support to publish an app using HTTP basic by enabling the HTTP app to receive a non\-claims relying party trust for the application to the Federation Service.  
  
    For more information on HTTP basic publishing, see [Publishing Applications using AD FS Preauthentication](../Topic/Publishing-Applications-using-AD-FS-Preauthentication.md)  
  
-   Wildcard domain publishing of applications  
  
    To support scenarios such as SharePoint 2013, the external URL for the application can now include a wildcard to enable you to publish multiple applications from within a specific domain, for example, https:\/\/\*.sp\-apps.contoso.com. This will simplify publishing of SharePoint apps.  
  
-   HTTP to HTTPS redirection  
  
    In order to make sure your users can access your app, even if they neglect to type HTTPS in the URL, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] now supports HTTP to HTTPS redirection.  
  
-   HTTP Publishing  
  
    It is now possible to publish HTTP applications using pass\-through preauthentication  
  
-   Publishing of Remote Desktop Gateway apps  
  
    For more information on RDG in [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], see [Publishing Applications with SharePoint, Exchange and RDG](../Topic/Publishing-Applications-with-SharePoint,-Exchange-and-RDG.md)  
  
-   New debug log for better troubleshooting and improved service log for complete audit trail and improved error handling  
  
    For more information on troubleshooting, see [Troubleshooting Web Application Proxy](../Topic/Troubleshooting-Web-Application-Proxy.md)  
  
-   Administrator Console UI improvements  
  
-   Propagation of client IP address to backend applications  
  
## See Also  
  
-   [What's New in Windows Server 2016 Technical Preview 4](../Topic/What-s-New-in-Windows-Server-2016-Technical-Preview-4.md)  
  
-   [Publishing Applications using AD FS Preauthentication](../Topic/Publishing-Applications-using-AD-FS-Preauthentication.md)  
  
-   [Troubleshooting Web Application Proxy](../Topic/Troubleshooting-Web-Application-Proxy.md)  
  
