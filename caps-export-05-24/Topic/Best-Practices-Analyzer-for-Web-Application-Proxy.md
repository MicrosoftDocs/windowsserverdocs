---
title: Best Practices Analyzer for Web Application Proxy
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - web-app-proxy
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 995f5cea-e334-4ce6-a14c-6a2d03c0c79a
author: kgremban
robots: noindex,nofollow
---
# Best Practices Analyzer for Web Application Proxy
In Windows management, *best practices* are guidelines that are considered the ideal way, under normal circumstances, to configure a server as defined by experts. For example, it is considered a best practice for most server technologies to keep open only those ports required for the technologies to communicate with other networked computers, and block unused ports. While best practice violations, even critical ones, are not necessarily problematic, they indicate server configurations that can result in poor performance, poor reliability, unexpected conflicts, increased security risks, or other potential problems.  
  
Topics in this section can help you bring [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] running on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] into compliance with best practices. Content in this section is most valuable to administrators who have completed a [!INCLUDE[bpa](../Token/bpa_md.md)] scan of [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], and who want information about how to interpret and resolve scan results that identify areas of [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] that are noncompliant with best practices.  
  
For more information about [!INCLUDE[bpa](../Token/bpa_md.md)] and scans, see [Run Best Practices Analyzer Scans and Manage Scan Results](http://technet.microsoft.com/library/hh831400.aspx).  
  
## More information about [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] enables you to publish selected HTTP\- and HTTPS\-based applications from your corporate network to client devices outside of the corporate network. It can use [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] to ensure that users are authenticated before they gain access to published applications. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] also provides proxy functionality for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers.  
  
## Topics in this section  
  
-   [Web Application Proxy must be configured before it is used](../Topic/Web-Application-Proxy-must-be-configured-before-it-is-used.md)  
  
-   [Web Application Proxy: The external and backend server URLs are different and URL translation is disabled](../Topic/Web-Application-Proxy--The-external-and-backend-server-URLs-are-different-and-URL-translation-is-disabled.md)  
  
-   [Web Application Proxy: The service is not configured to run automatically](../Topic/Web-Application-Proxy--The-service-is-not-configured-to-run-automatically.md)  
  
-   [Web Application Proxy: The AD FS Proxy service is not configured to run automatically](../Topic/Web-Application-Proxy--The-AD-FS-Proxy-service-is-not-configured-to-run-automatically.md)  
  
-   [Web Application Proxy: This server is not included in the ConnectedServersName list](../Topic/Web-Application-Proxy--This-server-is-not-included-in-the-ConnectedServersName-list.md)  
  
-   [Web Application Proxy: The ConfigurationChangesPollingIntervalSec value is high](../Topic/Web-Application-Proxy--The-ConfigurationChangesPollingIntervalSec-value-is-high.md)  
  
-   [Web Application Proxy: Application is using an external certificate that is not yet valid](../Topic/Web-Application-Proxy--Application-is-using-an-external-certificate-that-is-not-yet-valid.md)  
  
-   [Web Application Proxy: Application is using an external certificate that is about to expire](../Topic/Web-Application-Proxy--Application-is-using-an-external-certificate-that-is-about-to-expire.md)  
  
-   [Web Application Proxy: Application is using an external certificate that has no private key](../Topic/Web-Application-Proxy--Application-is-using-an-external-certificate-that-has-no-private-key.md)  
  
-   [Web Application Proxy: Application is using an external certificate that has expired](../Topic/Web-Application-Proxy--Application-is-using-an-external-certificate-that-has-expired.md)  
  
-   [Web Application Proxy: Application is configured to use an external certificate that is not present on this server](../Topic/Web-Application-Proxy--Application-is-configured-to-use-an-external-certificate-that-is-not-present-on-this-server.md)  
  
-   [Web Application Proxy: Some applications are configured to perform backend authentication using Integrated Windows authentication but the server is not joined to a domain](../Topic/Web-Application-Proxy--Some-applications-are-configured-to-perform-backend-authentication-using-Integrated-Windows-authentication-but-the-server-is-not-joined-to-a-domain.md)  
  
-   [Web Application Proxy: A cluster of Web Application Proxy servers is deployed and DirectAccess is also installed](../Topic/Web-Application-Proxy--A-cluster-of-Web-Application-Proxy-servers-is-deployed-and-DirectAccess-is-also-installed.md)  
  
