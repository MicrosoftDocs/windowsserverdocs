---
title: Publish Applications using Pass-through Preauthentication
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0d4d613e-2785-4e02-bfee-5e02487d8d81
author: kgremban
---
# Publish Applications using Pass-through Preauthentication
**This content is relevant for the on\-premises version of Web Application Proxy. To enable secure access to on\-premises applications over the cloud, see the [Azure AD Application Proxy content](https://azure.microsoft.com/en-us/documentation/articles/active-directory-application-proxy-get-started/).**  
  
This topic describes how to publish applications through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] using pass\-through preauthentication. Before beginning the deployment steps, ensure that you have completed the planning steps described in [Plan to Publish Applications using Pass\-through Preauthentication \[WAP\]](assetId:///c8a3df4e-3ec5-4131-a2a1-975ef21f2387).  
  
> [!IMPORTANT]  
> When configuring the external URL and the backend server URL, you must enter a URL including the fully qualified domain name \(FQDN\), and not an IP address.  
  
> [!NOTE]  
> Applications that use pass\-through preauthentication cannot leverage the additional features that [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] provides; such as, Workplace Join, multifactor authentication \(MFA\), and multifactor access control.  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="BKMK_1.5"></a>Publish an Application using Pass\-Through Preauthentication  
The general pass\-through preauthentication flow is as follows:  
  
1.  The client device attempts to access a published web application on a particular resource URL.  
  
    The resource URL is a public address on which [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] listens for incoming HTTPS requests.  
  
2.  [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] forwards the HTTPS request directly to the backend server using either HTTP or HTTPS.  
  
3.  If required by the backend server, the user authenticates directly to the backend server.  
  
4.  After successfully authenticating, the client now has access to the published web application.  
  
This procedure describes how to publish an application that uses pass\-through preauthentication. Before you begin, make sure that you have done the following:  
  
-   Import the website certificate from the backend server, or verify that a certificate on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server is suitable for the application you want to publish.  
  
#### To publish an application using pass\-through preauthentication  
  
1.  On the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, in the Remote Access Management console, in the **Navigation** pane, click **[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]**, and then in the **Tasks** pane, click **Publish**.  
  
2.  On the **Publish New Application Wizard**, on the **Welcome** page, click **Next**.  
  
3.  On the **Preauthentication** page, click **Pass\-through**, and then click **Next**.  
  
4.  On the **Publishing Settings** page, do the following, and then click **Next**:  
  
    -   In the **Name** box, enter a friendly name for the application.  
  
        This name is used only in the list of published applications in the Remote Access Management console.  
  
    -   In the **External URL** box, enter the external URL for this application; for example, https:\/\/maps.contoso.com\/.  
  
    -   In the **External certificate** list, select a certificate whose subject covers the external URL.  
  
    -   In the **Backend server URL** box, enter the URL of the backend server. Note that this value is automatically entered when you enter the external URL and you should change it only if the backend server URL is different; for example, http:\/\/maps\/.  
  
        > [!NOTE]  
        > [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] can translate host names in URLs, but cannot translate path names. Therefore, you can enter different host names, but you must enter the same path name. For example, you can enter an external URL of https:\/\/apps.contoso.com\/app1\/ and a backend server URL of http:\/\/app\-server\/app1\/. However, you cannot enter an external URL of https:\/\/apps.contoso.com\/app1\/ and a backend server URL of https:\/\/apps.contoso.com\/internal\-app1\/.  
  
5.  On the **Confirmation** page, review the settings, and then click **Publish**. You can copy the PowerShell command to set up additional published applications.  
  
6.  On the **Results** page, make sure that the application published successfully, and then click **Close**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
Add-WebApplicationProxyApplication  
    -BackendServerURL 'https://maps.contoso.com/'  
    -ExternalCertificateThumbprint '1a2b3c4d5e6f1a2b3c4d5e6f1a2b3c4d5e6f1a2b'  
    -ExternalURL 'https://maps.contoso.com/'  
    -Name 'Maps (no preauthentication)'  
    -ExternalPreAuthentication PassThrough  
```  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 3: Publish Applications using AD FS Preauthentication](assetId:///1c2247f4-b24b-4385-9a47-11279a3b75ef)  
  
-   [Configure Publishing Applications through Web Application Proxy](assetId:///e75be34f-876d-4147-944b-8ab98285804e)  
  
-   [Planning to Publish Applications Using Web Application Proxy](../Topic/Planning-to-Publish-Applications-Using-Web-Application-Proxy.md)  
  
-   [Web Application Proxy Walkthrough Guide](../Topic/Web-Application-Proxy-Walkthrough-Guide.md)  
  
-   [Web Application Proxy Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/dn283404.aspx)  
  
-   [Add\-WebApplicationProxyApplication](http://technet.microsoft.com/library/dn283409.aspx)  
  
