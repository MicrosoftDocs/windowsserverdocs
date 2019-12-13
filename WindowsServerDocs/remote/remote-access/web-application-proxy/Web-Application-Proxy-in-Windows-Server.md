---
ms.assetid: 0b3587b2-219f-43d8-88b4-1254eaa8b910
title: Web Application Proxy in Windows Server
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.service: 
ms.suite: na
ms.technology: web-app-proxy
ms.tgt_pltfrm: na
ms.topic: article
author: kgremban
---
# Web Application Proxy in Windows Server

>Applies To: Windows Server&reg; 2016

**This content is relevant for the on-premises version of Web Application Proxy. To enable secure access to on-premises applications over the cloud, see the [Azure AD Application Proxy content](https://azure.microsoft.com/documentation/articles/active-directory-application-proxy-get-started/).**  
  
The content in this section describes what's new and changed in the Web Application Proxy for Windows Server 2016. The new features and changes listed here are the ones most likely to have the greatest impact as you work with the Preview.  
  
## Web Application Proxy New Features  
  
- Preauthentication for HTTP Basic application publishing  
  
  HTTP Basic is the authorization protocol used by many protocols, including ActiveSync, to connect rich clients, including smartphones, with your Exchange mailbox. Web Application Proxy traditionally interacts with AD FS using redirections which is not supported on ActiveSync clients. This new version of Web Application Proxy provides support to publish an app using HTTP basic by enabling the HTTP app to receive a non-claims relying party trust for the application to the Federation Service.  
  
  For more information on HTTP basic publishing, see [Publishing Applications using AD FS Preauthentication](../web-application-proxy/../web-application-proxy/Publishing-Applications-using-AD-FS-Preauthentication.md)  
  
- Wildcard domain publishing of applications  
  
  To support scenarios such as SharePoint 2013, the external URL for the application can now include a wildcard to enable you to publish multiple applications from within a specific domain, for example, https://*.sp-apps.contoso.com. This will simplify publishing of SharePoint apps.  
  
- HTTP to HTTPS redirection  
  
  In order to make sure your users can access your app, even if they neglect to type HTTPS in the URL, Web Application Proxy now supports HTTP to HTTPS redirection.  
  
- HTTP Publishing  
  
  It is now possible to publish HTTP applications using pass-through preauthentication  
  
- Publishing of Remote Desktop Gateway apps  
  
  For more information on RDG in Web Application Proxy, see [Publishing Applications with SharePoint, Exchange and RDG](../web-application-proxy/Publishing-Applications-with-SharePoint,-Exchange-and-RDG.md)  
  
- New debug log for better troubleshooting and improved service log for complete audit trail and improved error handling  
  
  For more information on troubleshooting, see [Troubleshooting Web Application Proxy](https://technet.microsoft.com/library/dn770156.aspx)  
  
- Administrator Console UI improvements  
  
- Propagation of client IP address to backend applications  
  
## See Also  
  
-   [What's New in Windows Server 2016](https://technet.microsoft.com/library/dn765472.aspx)  
  
-   [Publishing Applications using AD FS Preauthentication](../web-application-proxy/Publishing-Applications-using-AD-FS-Preauthentication.md)  
  
-   [Troubleshooting Web Application Proxy](https://technet.microsoft.com/library/dn770156.aspx)  
  


