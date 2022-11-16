---
description: "Learn more about: Web Application Proxy in Windows Server"
ms.assetid: d8adcb68-18e0-41bf-a817-d57344bf2e7d
title: Web Application Proxy in Windows Server
ms.author: kgremban
author: JasonGerend
manager: femila
ms.date: 07/13/2016
ms.topic: article
---

# Web Application Proxy in Windows Server

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

**This content is relevant for the on-premises version of Web Application Proxy. To enable secure access to on-premises applications over the cloud, see the [Azure AD Application Proxy content](/azure/active-directory/manage-apps/application-proxy).**

The content in this section describes what's new and changed in the Web Application Proxy for Windows Server. The new features and changes listed here are the ones most likely to have the greatest impact as you work with the Preview.

## Web Application Proxy features

- Preauthentication for HTTP Basic application publishing

  HTTP Basic is the authorization protocol used by many protocols, including ActiveSync, to connect rich clients, including smartphones, with your Exchange mailbox. Web Application Proxy traditionally interacts with AD FS using redirections which is not supported on ActiveSync clients. This new version of Web Application Proxy provides support to publish an app using HTTP basic by enabling the HTTP app to receive a non-claims relying party trust for the application to the Federation Service.

  For more information on HTTP basic publishing, see [Publishing Applications using AD FS Preauthentication](Publishing-Applications-using-AD-FS-Preauthentication.md#publish-an-application-that-uses-http-basic)

- Wildcard domain publishing of applications

  To support scenarios such as SharePoint 2013, the external URL for the application can now include a wildcard to enable you to publish multiple applications from within a specific domain, for example, https://*.sp-apps.contoso.com. This will simplify publishing of SharePoint apps.

- HTTP to HTTPS redirection

  In order to make sure your users can access your app, even if they neglect to type HTTPS in the URL, Web Application Proxy now supports HTTP to HTTPS redirection.

- HTTP Publishing

  It is now possible to publish HTTP applications using pass-through preauthentication

- Publishing of Remote Desktop Gateway apps

  For more information on RDG in Web Application Proxy, see [Publishing Applications with SharePoint, Exchange and RDG](../web-application-proxy/Publishing-Applications-with-SharePoint,-Exchange-and-RDG.md)

- New debug log for better troubleshooting and improved service log for complete audit trail and improved error handling

  For more information on troubleshooting, see [Troubleshooting Web Application Proxy](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn770156(v=ws.11))

- Administrator Console UI improvements

- Propagation of client IP address to backend applications

## See Also

- [What's New in Windows Server](../../../get-started/whats-new-in-windows-server-2016.md)

- [Publishing Applications using AD FS Preauthentication](../web-application-proxy/Publishing-Applications-using-AD-FS-Preauthentication.md)

- [Troubleshooting Web Application Proxy](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn770156(v=ws.11))

