---
title: Publish Applications using Client Certificate Preauthentication
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 17d37be6-226e-4072-9e3f-3bc65531234b
author: kgremban
---
# Publish Applications using Client Certificate Preauthentication
**This content is relevant for the on\-premises version of Web Application Proxy. To enable secure access to on\-premises applications over the cloud, see the [Azure AD Application Proxy content](https://azure.microsoft.com/en-us/documentation/articles/active-directory-application-proxy-get-started/).**  
  
This topic describes how to publish applications through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] using client certificate preauthentication. Before beginning the deployment steps, ensure that you have completed the planning steps described in [Plan to Publish Applications using Client Certificate Preauthentication \[WAP\]](assetId:///525fc276-abb5-42e2-b981-a6b443a797f7).  
  
> [!IMPORTANT]  
> When configuring the external URL and the backend server URL, you must enter a URL. You cannot enter an IP address.  
  
Client certificate preauthentication is used in scenarios where a small group of external servers connect to an on\-premises server through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]. Client certificate preauthentication should not be used for client devices connecting to published applications.  
  
The general client certificate preauthentication flow is as follows:  
  
1.  An external server makes a request to the published resource URL.  
  
    The resource URL is a public address on which [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] listens for new HTTPS requests.  
  
2.  [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] authenticates the external server using the certificate thumbprint of a certificate configured on the external server.  
  
3.  After the external server is authenticated, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] forwards the HTTPS request to the corporate network to the published web application using either HTTP or HTTPS.  
  
4.  The published web application responds to the request from the external server.  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="BKMK_1.4"></a>Publish an Application using Client Certificate Preauthentication  
This procedure describes how to publish an application using client certificate authentication. This type of application can be published only using [!INCLUDE[wps_2](../Token/wps_2_md.md)]. Before you begin, make sure that you have done the following:  
  
-   Import the website certificate from the backend server, or verify that a certificate on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server is suitable for the application you want to publish.  
  
-   Import the certificate from the external server.  
  
Enter each cmdlet on a single line, even though they may appear word\-wrapped across several lines here because of formatting constraints.  
  
To publish the application:  
  
```  
Add-WebApplicationProxyApplication  
    -BackendServerURL 'https://clientcertapp.contoso.com/'  
    -ExternalCertificateThumbprint '1a2b3c4d5e6f1a2b3c4d5e6f1a2b3c4d5e6f1a2b'  
    -ExternalURL 'https://clientcertapp.contoso.com/'  
    -Name 'Client certificate preauthentication application'  
    -ExternalPreAuthentication ClientCertificate  
    -ClientCertificatePreauthenticationThumbprint '123456abcdef123456abcdef123456abcdef12ab'  
```  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Publish Applications using Pass-through Preauthentication](../Topic/Publish-Applications-using-Pass-through-Preauthentication.md)  
  
-   [Step 3: Publish Applications using AD FS Preauthentication](assetId:///1c2247f4-b24b-4385-9a47-11279a3b75ef)  
  
-   [Configure Publishing Applications through Web Application Proxy](assetId:///e75be34f-876d-4147-944b-8ab98285804e)  
  
-   [Planning to Publish Applications Using Web Application Proxy](../Topic/Planning-to-Publish-Applications-Using-Web-Application-Proxy.md)  
  
-   [Web Application Proxy Walkthrough Guide](../Topic/Web-Application-Proxy-Walkthrough-Guide.md)  
  
-   [Web Application Proxy Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/dn283404.aspx)  
  
-   [Add\-WebApplicationProxyApplication](http://technet.microsoft.com/library/dn283409.aspx)  
  
