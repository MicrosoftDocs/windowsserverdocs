---
title: Install and Configure the Web Application Proxy Server
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fb207bb2-7c8f-47a9-98d9-d173b7bb926a
author: kgremban
---
# Install and Configure the Web Application Proxy Server
**This content is relevant for the on\-premises version of Web Application Proxy. To enable secure access to on\-premises applications over the cloud, see the [Azure AD Application Proxy content](https://azure.microsoft.com/en-us/documentation/articles/active-directory-application-proxy-get-started/).**  
  
This topic describes how to install the Remote Access role with the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] role service and how to configure the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server to connect to an [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] server. Before beginning the deployment steps, ensure that you have completed the planning steps described in [Plan the Web Application Proxy Server](assetId:///9020ad26-2952-4ef2-a746-d564376d2b93).  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="ConfigCAs"></a>Configure CAs and certificates  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers require the following certificates in the certificate store on each [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server:  
  
-   A certificate whose subject covers the federation service name. If you want to use Workplace Join, the certificate must also contain the following subject alternative names \(SANs\): <federation service name>.<domain> and enterpriseregistration.<domain>.  
  
-   A wildcard certificate, a subject alternative name \(SAN\) certificate, several SAN certificates, or several certificates whose subjects cover each web application.  
  
-   A copy of the certificate issued to external servers when using client certificate preauthentication.  
  
### <a name="ConfigCertTemp"></a>Configure certificate templates  
Depending on your deployment and authentication requirements, you might require additional certificate templates on your internal certification authority \(CA\).  
  
##### To configure a certificate template  
  
1.  On the internal CA, create a certificate template as described in [Creating Certificate Templates](http://technet.microsoft.com/library/cc731705(WS.10).aspx).  
  
2.  Deploy the certificate template as described in [Deploying Certificate Templates](http://technet.microsoft.com/library/cc770794(WS.10).aspx).  
  
### Configure web application certificates  
In an [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] deployment you require certificates for the published web applications, and for the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] proxy if your deployment provides [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] proxy functionality. For these required certificates, there are two options for the issuing CA:  
  
-   **Public**—Supplied by a 3rd party.  
  
    A website certificate used for server authentication. If the certificate subject is not a wildcard, it must be the externally resolvable fully qualified domain name \(FQDN\) URL that you configure on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server for the application.  
  
-   **Private**—The following are required, if they do not already exist:  
  
    -   A website certificate used for server authentication. The certificate subject should be an externally resolvable FQDN that is reachable from the Internet. The certificate can be based on the certificate template created in [Configuring certificate templates](#ConfigCertTemp).  
  
    -   A certificate revocation list \(CRL\) distribution point that is reachable from a publicly resolvable FQDN.  
  
Make sure that the website certificate used for server authentication meets the following requirements:  
  
-   The common name of the certificate should match the name that you configure for the external URL of the published web application, or the federation service name.  
  
-   For the Enhanced Key Usage field, use the Server Authentication object identifier \(OID\).  
  
-   For the CRL Distribution Points field, specify a CRL distribution point that is accessible by client devices that are connected to the Internet.  
  
-   The certificate must have a private key.  
  
-   The certificate must be imported directly into the personal store.  
  
-   Certificates can have wildcards in the name. A wildcard certificate with the subject name \*.contoso.com can be used for web applications in the domain contoso.com, for example, sharepoint.contoso.com and owa.contoso.com. This wildcard certificate cannot be used for the website sharepoint.internal.contoso.com.  
  
-   Certificates can be subject alternative name \(SAN\) certificates. For example, a SAN certificate with the names owa.contoso.com and crm.contoso.com can be used for only those two websites. It cannot be used for sharepoint.contoso.com.  
  
    > [!NOTE]  
    > For Workplace Join, a SAN certificate is required with the following SANs:  
    >   
    > -   <federation service name>.<domain>  
    >   
    >     For example, adfs1.contoso.com.  
    > -   enterpriseregistration.<domain>  
    >   
    >     For example, enterpriseregistration.contoso.com.  
  
## <a name="BKMK_Role"></a>Install the Remote Access role  
To deploy [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], you must install the Remote Access role with the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] role service on a server that will act as the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server.  
  
Repeat this procedure for all of the servers that you want to deploy as [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers.  
  
#### To install the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] role service  
  
1.  On the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, in the [!INCLUDE[sm](../Token/sm_md.md)] console, in the **Dashboard**, click **Add roles and features**.  
  
2.  In the **Add Roles and Features Wizard**, click **Next** three times to get to the server role selection screen.  
  
3.  On the **Select server roles** dialog, select **Remote Access**, and then click **Next**.  
  
4.  Click **Next** twice.  
  
5.  On the **Select role services** dialog, select **[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]**, click **Add Features**, and then click **Next**.  
  
6.  On the **Confirm installation selections** dialog, click **Install**.  
  
7.  On the **Installation progress** dialog, verify that the installation was successful, and then click **Close**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
```  
Install-WindowsFeature Web-Application-Proxy -IncludeManagementTools  
```  
  
See the instructional video for help [Installing the Web Application Proxy](http://go.microsoft.com/fwlink/?LinkID=386488&clcid=0x409)  
  
## <a name="BKMK_Configure"></a>Configure Web Application Proxy  
You must configure [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] to connect to an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server.  
  
Repeat this procedure for all of the servers that you want to deploy as [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers.  
  
#### To configure [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]  
  
1.  On the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, open the Remote Access Management console: [!INCLUDE[winblue_start](../Token/winblue_start_md.md)]**RAMgmtUI.exe**, and then press ENTER. [!INCLUDE[uac_confirm_action](../Token/uac_confirm_action_md.md)]  
  
2.  In the navigation pane, click **[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]**.  
  
3.  In the Remote Access Management console, in the middle pane, click **Run the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Configuration Wizard**.  
  
4.  On the **[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Configuration Wizard**, on the **Welcome** dialog, click **Next**.  
  
5.  On the **Federation Server** dialog, do the following, and then click **Next**:  
  
    -   In the **Federation service name** box, enter the fully qualified domain name \(FQDN\) of the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server; for example, fs.contoso.com.  
  
    -   In the **User name** and **Password** boxes, enter the credentials of a local administrator account on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers.  
  
6.  On the **AD FS Proxy Certificate** dialog, in the list of certificates currently installed on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, select a certificate to be used by [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] proxy functionality, and then click **Next**.  
  
    The certificate you choose here should be the one that whose subject is the Federation Service name, for example, fs.contoso.com. If you plan on using Workplace Join, this must be a SAN certificate with the SANs described in [2.1. Configure CAs and certificates](../Topic/Install-and-Configure-the-Web-Application-Proxy-Server.md#ConfigCAs).  
  
7.  On the **Confirmation** dialog, review the settings. If required, you can copy the PowerShell cmdlet to automate additional installations. Click **Configure**.  
  
8.  On the **Results** dialog, verify that the configuration was successful, and then click **Close**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
The following command will prompt you to enter credentials of a local administrator account on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers.  
  
```  
Install-WebApplicationProxy –CertificateThumbprint '1a2b3c4d5e6f1a2b3c4d5e6f1a2b3c4d5e6f1a2b' -FederationServiceName fs.contoso.com  
```  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 3: Publish Applications using AD FS Preauthentication](assetId:///1c2247f4-b24b-4385-9a47-11279a3b75ef)  
  
-   [Configure the Web Application Proxy Infrastructure](../Topic/Configure-the-Web-Application-Proxy-Infrastructure.md)  
  
-   [Configure Publishing Applications through Web Application Proxy](assetId:///e75be34f-876d-4147-944b-8ab98285804e)  
  
-   [Planning to Publish Applications Using Web Application Proxy](../Topic/Planning-to-Publish-Applications-Using-Web-Application-Proxy.md)  
  
-   [Web Application Proxy Walkthrough Guide](../Topic/Web-Application-Proxy-Walkthrough-Guide.md)  
  
-   [Web Application Proxy Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/dn283404.aspx)  
  
-   [Install\-WebApplicationProxy](http://technet.microsoft.com/library/dn283414.aspx)  
  
