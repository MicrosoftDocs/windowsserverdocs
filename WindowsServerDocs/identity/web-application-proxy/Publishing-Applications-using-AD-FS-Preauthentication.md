---
title: Publishing Applications using AD FS Preauthentication
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.service: active-directory
ms.suite: na
ms.technology: 
  - active-directory-domain-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c11fe09d-22d4-4bb2-9d06-d63f0c227abf
author: kgremban
---
# Publishing Applications using AD FS Preauthentication
**This content is relevant for the on\-premises version of Web Application Proxy. To enable secure access to on\-premises applications over the cloud, see the [Azure AD Application Proxy content](https://azure.microsoft.com/en-us/documentation/articles/active-directory-application-proxy-get-started/).**  
  
This topic describes how to publish applications through [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] using [!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)] preauthentication.  
  
For all types of application that you can publish using [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] preauthentication, you must add a [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] relying party trust to the Federation Service.  
  
The general [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] preauthentication flow is as follows:  
  
> [!NOTE]  
> This authentication flow is not applicable for clients that use Windows Store apps.  
  
1.  The client device attempts to access a published web application on a particular resource URL; for example https:\/\/app1.contoso.com\/.  
  
    The resource URL is a public address on which [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] listens for incoming HTTPS requests.  
  
    If HTTP to HTTPS redirection is enabled, [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] will also listen for incoming HTTP requests.  
  
2.  [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] redirects the HTTPS request to the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server with URL encoded parameters, including the resource URL and the appRealm \(a relying party identifier\).  
  
    The user authenticates using the authentication method required by the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server; for example, user name and password, two\-factor authentication with a one\-time password, and so on.  
  
3.  After the user is authenticated, the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server issues a security token, the ‘edge token’, containing the following information and redirects the HTTPS request back to the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] server:  
  
    -   The resource identifier that the user attempted to access.  
  
    -   The user’s identity as a user principal name \(UPN\).  
  
    -   The expiry of the access grant approval; that is, the user is granted access for a limited period of time, after which they are required to authenticate again.  
  
    -   Signature of the information in the edge token.  
  
4.  [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] receives the redirected HTTPS request from the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server with the edge token and validates and uses the token as follows:  
  
    -   Validates that the edge token signature is from the federation service that is configured in the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] configuration.  
  
    -   Validates that the token was issued for the correct application.  
  
    -   Validates that the token has not expired.  
  
    -   Uses the user identity when required; for example to obtain a Kerberos ticket if the backend server is configured to use Integrated Windows authentication.  
  
5.  If the edge token is valid, [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] forwards the HTTPS request to the published web application using either HTTP or HTTPS.  
  
6.  The client now has access to the published web application; however, the published application may be configured to require the user to perform additional authentication. If, for example, the published web application is a SharePoint site and does not require additional authentication, the user will see the SharePoint site in the browser.  
  
7.  [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] saves a cookie on the client device. The cookie is used by [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] to identify that this session has already been preauthenticated and that no further preauthentication is required.  
  
> [!IMPORTANT]  
> When configuring the external URL and the backend server URL, make sure you include the fully qualified domain name \(FQDN\), and not an IP address.  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](includes/wps_howtorun_md.md)]  
  
## <a name="BKMK_1.1"></a>Publish a Claims\-based Application for Web Browser Clients  
To publish an application that uses claims for authentication, you must add a relying party trust for the application to the Federation Service.  
  
When publishing claims\-based applications and accessing the application from a browser, the general authentication flow is as follows:  
  
1.  The client attempts to access a claims\-based application using a web browser; for example, https:\/\/appserver.contoso.com\/claimapp\/.  
  
2.  The web browser sends an HTTPS request to the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] server which redirects the request to the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server.  
  
3.  The [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server authenticates the user and the device and redirects the request back to [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)]. The request now contains the edge token. The [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server adds a single sign\-on \(SSO\) cookie to the request because the user has already performed authentication against the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server.  
  
4.  [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] validates the token, adds its own cookie, and forwards the request to the backend server.  
  
5.  The backend server redirects the request to the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server to get the application security token.  
  
6.  The request is redirected to the backend server by the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server. The request now contains the application token and the SSO cookie. The user is granted access to the application and is not required to enter a user name or password.  
  
This procedure describes how to publish a claims\-based application, such as a SharePoint site, that will be accessed by web browser clients. Before you begin, make sure that you have done the following:  
  
-   Created a relying party trust for the application in the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] Management console.  
  
-   Verified that a certificate on the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] server is suitable for the application you want to publish.  
  
[Do this step using Windows PowerShell](assetId:///1c2247f4-b24b-4385-9a47-11279a3b75ef#BKMK_PSstep1)  
  
#### To publish a claims\-based application  
  
1.  On the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] server, in the Remote Access Management console, in the **Navigation** pane, click **[!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)]**, and then in the **Tasks** pane, click **Publish**.  
  
2.  On the **Publish New Application Wizard**, on the **Welcome** page, click **Next**.  
  
3.  On the **Preauthentication** page, click **[!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)]**, and then click **Next**.  
  
4.  On the **Supported Clients** page, select **Web and MSOFBA**, and then click **Next**.  
  
5.  On the **Relying Party** page, in the list of relying parties select the relying party for the application that you want to publish, and then click **Next**.  
  
6.  On the **Publishing Settings** page, do the following, and then click **Next**:  
  
    -   In the **Name** box, enter a friendly name for the application.  
  
        This name is used only in the list of published applications in the Remote Access Management console.  
  
    -   In the **External URL** box, enter the external URL for this application; for example, https:\/\/sp.contoso.com\/app1\/.  
  
    -   In the **External certificate** list, select a certificate whose subject covers the external URL.  
  
    -   In the **Backend server URL** box, enter the URL of the backend server. Note that this value is automatically entered when you enter the external URL and you should change it only if the backend server URL is different; for example, http:\/\/sp\/app1\/.  
  
        > [!NOTE]  
        > [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] can translate host names in URLs, but cannot translate path names. Therefore, you can enter different host names, but you must enter the same path name. For example, you can enter an external URL of https:\/\/apps.contoso.com\/app1\/ and a backend server URL of http:\/\/app\-server\/app1\/. However, you cannot enter an external URL of https:\/\/apps.contoso.com\/app1\/ and a backend server URL of https:\/\/apps.contoso.com\/internal\-app1\/.  
  
7.  On the **Confirmation** page, review the settings, and then click **Publish**. You can copy the PowerShell command to set up additional published applications.  
  
8.  On the **Results** page, make sure that the application published successfully, and then click **Close**.  
  
![](media/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](includes/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](includes/wps_proc_intro_md.md)]  
  
```  
Add-WebApplicationProxyApplication  
    -BackendServerURL 'https://sp.contoso.com/app1/'  
    -ExternalCertificateThumbprint '1a2b3c4d5e6f1a2b3c4d5e6f1a2b3c4d5e6f1a2b'  
    -ExternalURL 'https://sp.contoso.com/app1/'  
    -Name 'SP'  
    -ExternalPreAuthentication ADFS  
    -ADFSRelyingPartyName 'SP_Relying_Party'  
```  
  
## <a name="BKMK_1.2"></a>Publish an Integrated Windows authenticated\-based Application for Web Browser Clients  
[!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] can be used to publish applications that uses Integrated Windows authentication; that is, [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] performs preauthentication as required, and can then perform SSO to the published application that uses Integrated Windows authentication. To publish an application that uses Integrated Windows authentication you must add a non\-claims\-aware relying party trust for the application to the Federation Service.  
  
To allow [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] to perform single sign\-on \(SSO\) and to perform credentials delegation using Kerberos constrained delegation, the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] server must be joined to a domain. See [Plan Active Directory](assetId:///a0d4c023-e75b-4140-b0aa-0fdb7f28a59d#BKMK_AD).  
  
To allow users to access applications that use Integrated Windows authentication, the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] server must be able to provide delegation for users to the published application. You can do this on the domain controller for any application. You can also do this on the backend server if it is running on [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]. For more information, see [What's New in Kerberos Authentication](http://technet.microsoft.com/library/hh831747.aspx).  
  
For a walkthrough of how to configure [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] to publish an application using Integrated Windows authentication, see [Configure a site to use Integrated Windows authentication](assetId:///b0788958-627f-450f-877c-209b1bd0db52).  
  
When using Integrated Windows authentication to backend servers, the authentication between [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] and the published application is not claims\-based, instead it uses Kerberos constrained delegation to authenticate end users to the application. The general flow is described below:  
  
1.  The client attempts to access a non\-claims\-based application using a web browser; for example, https:\/\/appserver.contoso.com\/nonclaimapp\/.  
  
2.  The web browser sends an HTTPS request to the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] server which redirects the request to the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server.  
  
3.  The [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server authenticates the user and redirects the request back to [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)]. The request now contains the edge token.  
  
4.  [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] validates the token.  
  
5.  If the token is valid, [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] obtains a Kerberos ticket from the domain controller on behalf of the user.  
  
6.  [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] adds the Kerberos ticket to the request as part of the Simple and Protected GSS\-API Negotiation Mechanism \(SPNEGO\) token, and forwards the request to the backend server. The request contains the Kerberos ticket; therefore, the user is granted access to the application without the need for further authentication.  
  
This procedure describes how to publish an application that uses Integrated Windows authentication, such as Outlook Web App, that will be accessed by web browser clients. Before you begin, make sure that you have done the following:  
  
-   Created a non\-claims\-aware relying party trust for the application in the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] Management console.  
  
-   Configured the backend server to support Kerberos constrained delegation on the domain controller or by using the Set\-ADUser cmdlet with the \-PrincipalsAllowedToDelegateToAccount parameter. Note that if the backend server is running on [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], you can also run this PowerShell command on the backend server.  
  
-   Made sure that the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] servers are configured for delegation to the service principal names of the backend servers.  
  
-   Verified that a certificate on the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] server is suitable for the application you want to publish.  
  
[Do this step using Windows PowerShell](assetId:///1c2247f4-b24b-4385-9a47-11279a3b75ef#BKMK_PSstep2)  
  
#### To publish a non\-claims\-based application  
  
1.  On the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] server, in the Remote Access Management console, in the **Navigation** pane, click **[!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)]**, and then in the **Tasks** pane, click **Publish**.  
  
2.  On the **Publish New Application Wizard**, on the **Welcome** page, click **Next**.  
  
3.  On the **Preauthentication** page, click **[!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)]**, and then click **Next**.  
  
4.  On the **Supported Clients** page, select **Web and MSOFBA**, and then click **Next**.  
  
5.  On the **Relying Party** page, in the list of relying parties select the relying party for the application that you want to publish, and then click **Next**.  
  
6.  On the **Publishing Settings** page, do the following, and then click **Next**:  
  
    -   In the **Name** box, enter a friendly name for the application.  
  
        This name is used only in the list of published applications in the Remote Access Management console.  
  
    -   In the **External URL** box, enter the external URL for this application; for example, https:\/\/owa.contoso.com\/.  
  
    -   In the **External certificate** list, select a certificate whose subject covers the external URL.  
  
    -   In the **Backend server URL** box, enter the URL of the backend server. Note that this value is automatically entered when you enter the external URL and you should change it only if the backend server URL is different; for example, http:\/\/owa\/.  
  
        > [!NOTE]  
        > [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] can translate host names in URLs, but cannot translate path names. Therefore, you can enter different host names, but you must enter the same path name. For example, you can enter an external URL of https:\/\/apps.contoso.com\/app1\/ and a backend server URL of http:\/\/app\-server\/app1\/. However, you cannot enter an external URL of https:\/\/apps.contoso.com\/app1\/ and a backend server URL of https:\/\/apps.contoso.com\/internal\-app1\/.  
  
    -   In the **Backend server SPN** box, enter the service principal name for the backend server; for example, HTTP\/owa.contoso.com.  
  
7.  On the **Confirmation** page, review the settings, and then click **Publish**. You can copy the PowerShell command to set up additional published applications.  
  
8.  On the **Results** page, make sure that the application published successfully, and then click **Close**.  
  
![](media/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](includes/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](includes/wps_proc_intro_md.md)]  
  
```  
Add-WebApplicationProxyApplication  
    -BackendServerAuthenticationSpn 'HTTP/owa.contoso.com'  
    -BackendServerURL 'https://owa.contoso.com/'  
    -ExternalCertificateThumbprint '1a2b3c4d5e6f1a2b3c4d5e6f1a2b3c4d5e6f1a2b'  
    -ExternalURL 'https://owa.contoso.com/'  
    -Name 'OWA'  
    -ExternalPreAuthentication ADFS  
    -ADFSRelyingPartyName 'Non-Claims_Relying_Party'  
```  
  
## <a name="BKMK_1.3"></a>Publish an Application that uses MS\-OFBA  
[!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] supports access from Microsoft Office clients such as Microsoft Word that access documents and data on backend servers. The only difference between these applications and a standard browser is that the redirection to the STS is done not via regular HTTP redirection but with special MS\-OFBA headers as specified in: [http://msdn.microsoft.com/library/dd773463(v=office.12).aspx](http://msdn.microsoft.com/library/dd773463(v=office.12).aspx). Backend application may be claims or IWA.   
To publish an application for clients that use MS\-OFBA, you must add a relying party trust for the application to the Federation Service. Depending on the application, you can use claims\-based authentication or Integrated Windows authentication. Therefore, you must add the relevant relying party trust depending on the application.  
  
To allow [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] to perform single sign\-on \(SSO\) and to perform credentials delegation using Kerberos constrained delegation, the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] server must be joined to a domain. See [Plan Active Directory](assetId:///a0d4c023-e75b-4140-b0aa-0fdb7f28a59d#BKMK_AD).  
  
There are no additional planning steps if the application uses claims\-based authentication. If the application used Integrated Windows authentication, see [Publish an Integrated Windows authenticated-based Application for Web Browser Clients](Publishing-Applications-using-AD-FS-Preauthentication.md#BKMK_1.2).  
  
The authentication flow for clients that use the MS\-OFBA protocol using claims\-based authentication is described below. The authentication for this scenario can either use the application token in the URL, or in the body.  
  
1.  The user is working in an Office program, and from the **Recent Documents** list, opens a file on a SharePoint site.  
  
2.  The Office program shows a window with a browser control that requires the user to enter credentials.  
  
    > [!NOTE]  
    > In some cases, the window may not appear because the client is already authenticated.  
  
3.  [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] redirects the request to the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server, which performs the authentication.  
  
4.  The [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server redirects the request back to [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)]. The request now contains the edge token.  
  
5.  The [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server adds a single sign\-on \(SSO\) cookie to the request because the user has already performed authentication against the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server.  
  
6.  [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] validates the token and forwards the request to the backend server.  
  
7.  The backend server redirects the request to the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server to get the application security token.  
  
8.  The request is redirected to the backend server. The request now contains the application token and the SSO cookie. The user is granted access to the SharePoint site and is not required to enter a user name or password to view the file.  
  
The steps to publish an application that uses MS\-OFBA are identical to the steps for a claims\-based application or a non\-claims\-based application. For claims\-based applications, see [Publish a Claims-based Application for Web Browser Clients](Publishing-Applications-using-AD-FS-Preauthentication.md#BKMK_1.1), for non\-claims\-based applications, see [Publish an Integrated Windows authenticated-based Application for Web Browser Clients](Publishing-Applications-using-AD-FS-Preauthentication.md#BKMK_1.2). [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] automatically detects the client and will authenticate the user as required.  
  
## Publish an Application that uses HTTP Basic  
HTTP Basic is the authorization protocol used by many protocols, including ActiveSync, to connect rich clients, including smartphones, with your Exchange mailbox. For more information on HTTP Basic, see [RFC 2617](http://www.ietf.org/rfc/rfc2617.txt). [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] traditionally interacts with [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] using redirections which is not supported on ActiveSync clients; most rich clients don’t support cookies or state management. Publishing an app using HTTP basic provides support for ActiveSync clients in [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] by caching the token that is received from AD FS and serving the token from the cache to overcome this limitation and avoid a high load on AD FS. In this way [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] enables the HTTP app to receive a non\-claims relying party trust for the application to the Federation Service. See [Plan Active Directory](assetId:///a0d4c023-e75b-4140-b0aa-0fdb7f28a59d#BKMK_AD).  
  
The authentication flow for clients that use HTTP Basic is described below and in this diagram:  
  
![](media/WebApplicationProxy_httpBasicflow.png)  
  
1.  The user attempts to access a published web application a telephone client.  
  
2.  The app sends an HTTPS request to the URL published by [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)].  
  
3.  If the request does not contain credentials, [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] returns an HTTP 401 response to the app containing the URL of the authenticating [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server.  
  
4.  The user sends the HTTPS request to the app again with authorization set to Basic and user name and Base 64 encrypted password of the user in the www\-authenticate request header.  
  
5.  Because the device cannot be redirected to [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)], the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] sends an authentication request to [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] with the credentials that it has: username, password and, if available, device certificate. The token is acquired on behalf of the device.  
  
6.  In order to minimize the number of requests sent to the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)], [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)], validates subsequent client requests using cached tokens for as long as the token is valid. [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] periodically cleans the cache. You can view the size of the cache using the performance counter.  
  
7.  If the token is valid, [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] forwards the request to the backend server and the user is granted access to the published web application.  
  
The following procedure explains how to publish HTTP basic applications.  
  
#### To publish an HTTP Basic application  
  
1.  On the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] server, in the Remote Access Management console, in the **Navigation** pane, click **[!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)]**, and then in the **Tasks** pane, click **Publish**.  
  
2.  On the **Publish New Application Wizard**, on the **Welcome** page, click **Next**.  
  
3.  On the **Preauthentication** page, click **[!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)]**, and then click **Next**.  
  
4.  On the **Supported Clients** page, select **HTTP Basic** and then click **Next**.  
  
    If you wish to enable access to the Exchange only from workplace joined devices, select the **Enable access only for workplace joined devices** box. For more information see [Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](http://technet.microsoft.com/library/dn280945.aspx).  
  
5.  On the **Relying Party** page, in the list of relying parties select the relying party for the application that you want to publish, and then click **Next**. Note that this list contains only on\-claims relying parties.  
  
6.  On the **Publishing Settings** page, do the following, and then click **Next**:  
  
    -   In the **Name** box, enter a friendly name for the application.  
  
        This name is used only in the list of published applications in the Remote Access Management console.  
  
    -   In the **External URL** box, enter the external URL for this application; for example, mail.contoso.com  
  
    -   In the **External certificate** list, select a certificate whose subject covers the external URL.  
  
    -   In the **Backend server URL** box, enter the URL of the backend server. Note that this value is automatically entered when you enter the external URL and you should change it only if the backend server URL is different; for example, mail.contoso.com.  
  
7.  On the **Confirmation** page, review the settings, and then click **Publish**. You can copy the PowerShell command to set up additional published applications.  
  
8.  On the **Results** page, make sure that the application published successfully, and then click **Close**.  
  
![](media/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](includes/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](includes/wps_proc_intro_md.md)]  
  
This Windows PowerShell script enables preauthentication for all devices, not just workplace joined devices.  
  
```  
Add-WebApplicationProxyApplication  
     -BackendServerUrl 'https://mail.contoso.com'   
     -ExternalCertificateThumbprint '697F4FF0B9947BB8203A96ED05A3021830638E50'   
     -ExternalUrl 'https://mail.contoso.com'   
     -Name 'Exchange ActiveSync'   
     -ExternalPreAuthentication ADFSforRichClients  
     -ADFSRelyingPartyName 'EAS_Relying_Party'  
```  
  
The following preauthenticates only workplace joined devices:  
  
```  
Add-WebApplicationProxyApplication  
     -BackendServerUrl 'https://mail.contoso.com'   
     -ExternalCertificateThumbprint '697F4FF0B9947BB8203A96ED05A3021830638E50'   
     -EnableHTTPRedirect:$true   
     -ExternalUrl 'https://mail.contoso.com'   
     -Name 'Exchange ActiveSync'   
     -ExternalPreAuthentication ADFSforRichClients  
     -ADFSRelyingPartyName 'EAS_Relying_Party'  
     -ADFSUserCertificateStore ‘AdfsTrustedDevices’  
```  
  
## <a name="BKMK_1.4"></a>Publish an Application that uses OAuth2 such as a Windows Store App  
To publish an application for Windows Store apps, you must add a relying party trust for the application to the Federation Service.  
  
To allow [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] to perform single sign\-on \(SSO\) and to perform credentials delegation using Kerberos constrained delegation, the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] server must be joined to a domain. See [Plan Active Directory](assetId:///a0d4c023-e75b-4140-b0aa-0fdb7f28a59d#BKMK_AD).  
  
> [!NOTE]  
> [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] supports publishing only for Windows Store apps that use the OAuth 2.0 protocol.  
  
In the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] Management console, you must make sure that the OAuth endpoint is proxy enabled. To check if the OAuth endpoint is proxy enabled, open the AD FS Management console, expand **Service**, click **Endpoints**, in the **Endpoints** list, locate the OAuth endpoint and make sure that the value in the **Proxy Enabled** column is **Yes**.  
  
The authentication flow for clients that use Windows Store apps is described below:  
  
> [!NOTE]  
> The [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] redirects to the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server for authentication. Because Windows Store apps do not support redirects, if you use Windows Store apps, it is necessary to set the URL of the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server using the Set\-WebApplicationProxyConfiguration cmdlet and the OAuthAuthenticationURL parameter.  
>   
> Windows Store apps can be published only using [!INCLUDE[wps_2](includes/wps_2_md.md)].  
  
1.  The client attempts to access a published web application using a Windows Store app.  
  
2.  The app sends an HTTPS request to the URL published by [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)].  
  
3.  [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] returns an HTTP 401 response to the app containing the URL of the authenticating [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server. This process is known as ‘discovery’.  
  
    > [!NOTE]  
    > If the app knows the URL of the authenticating [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server and already has a combo token containing the OAuth token and the edge token, steps 2 and 3 are skipped in this authentication flow.  
  
4.  The app sends an HTTPS request to the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server.  
  
5.  The app uses the web authentication broker to generate a dialog box in which the user enters credentials to authenticate to the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server. For information about web authentication broker, see [Web authentication broker](http://msdn.microsoft.com/library/windows/apps/hh750287.aspx).  
  
6.  After successful authentication, the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] server creates a combo token that contains the OAuth token and the edge token and sends the token to the app.  
  
7.  The app sends an HTTPS request containing the combo token to the URL published by [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)].  
  
8.  [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] splits the combo token into its two parts and validates the edge token.  
  
9. If the edge token is valid, [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] forwards the request to the backend server with only the OAuth token. The user is granted access to the published web application.  
  
This procedure describes how to publish an application for OAuth2. This type of application can be published only using [!INCLUDE[wps_2](includes/wps_2_md.md)]. Before you begin, make sure that you have done the following:  
  
-   Created a relying party trust for the application in the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] Management console.  
  
-   Made sure that the OAuth endpoint is proxy enabled in the [!INCLUDE[nextref_adfs2](includes/nextref_adfs2_md.md)] Management console and make a note of the URL Path.  
  
-   Verified that a certificate on the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] server is suitable for the application you want to publish.  
  
#### To publish and OAuth2 app  
  
1.  On the [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] server, in the Remote Access Management console, in the **Navigation** pane, click **[!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)]**, and then in the **Tasks** pane, click **Publish**.  
  
2.  On the **Publish New Application Wizard**, on the **Welcome** page, click **Next**.  
  
3.  On the **Preauthentication** page, click **[!INCLUDE[firstref_adfs2](includes/firstref_adfs2_md.md)]**, and then click **Next**.  
  
4.  On the **Supported Clients** page, select **OAuth2** and then click **Next**.  
  
5.  On the **Relying Party** page, in the list of relying parties select the relying party for the application that you want to publish, and then click **Next**.  
  
6.  On the **Publishing Settings** page, do the following, and then click **Next**:  
  
    -   In the **Name** box, enter a friendly name for the application.  
  
        This name is used only in the list of published applications in the Remote Access Management console.  
  
    -   In the **External URL** box, enter the external URL for this application; for example, https:\/\/server1.contoso.com\/app1\/.  
  
    -   In the **External certificate** list, select a certificate whose subject covers the external URL.  
  
        In order to make sure your users can access your app, even if they neglect to type HTTPS in the URL, select the **Enable HTTP to HTTPS Redirection** box.  
  
    -   In the **Backend server URL** box, enter the URL of the backend server. Note that this value is automatically entered when you enter the external URL and you should change it only if the backend server URL is different; for example, http:\/\/sp\/app1\/.  
  
        > [!NOTE]  
        > [!INCLUDE[adfs_webproxy](includes/adfs_webproxy_md.md)] can translate host names in URLs, but cannot translate path names. Therefore, you can enter different host names, but you must enter the same path name. For example, you can enter an external URL of https:\/\/apps.contoso.com\/app1\/ and a backend server URL of http:\/\/app\-server\/app1\/. However, you cannot enter an external URL of https:\/\/apps.contoso.com\/app1\/ and a backend server URL of https:\/\/apps.contoso.com\/internal\-app1\/.  
  
7.  On the **Confirmation** page, review the settings, and then click **Publish**. You can copy the PowerShell command to set up additional published applications.  
  
8.  On the **Results** page, make sure that the application published successfully, and then click **Close**.  
  
Enter each cmdlet on a single line, even though they may appear word\-wrapped across several lines here because of formatting constraints.  
  
To set the OAuth authentication URL for a [!INCLUDE[adfs2_fs](includes/adfs2_fs_md.md)] address of fs.contoso.com and a URL path of \/adfs\/oauth2\/:  
  
```  
Set-WebApplicationProxyConfiguration –OAuthAuthenticationURL 'https://fs.contoso.com/adfs/oauth2/'  
```  
  
To publish the application:  
  
```  
Add-WebApplicationProxyApplication  
    -BackendServerURL 'https://storeapp.contoso.com/'  
    -ExternalCertificateThumbprint '1a2b3c4d5e6f1a2b3c4d5e6f1a2b3c4d5e6f1a2b'  
    -ExternalURL 'https://storeapp.contoso.com/'  
    -Name 'Windows Store app Server'  
    -ExternalPreAuthentication ADFS  
    -ADFSRelyingPartyName 'Store_app_Relying_Party'  
    -UseOAuthAuthentication  
```  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Troubleshooting Web Application Proxy](Troubleshooting-Web-Application-Proxy.md)  
  
-   [Publish Applications through Web Application Proxy [WAP]](assetId:///e75be34f-876d-4147-944b-8ab98285804e)  
  
-   [Planning to Publish Applications Using Web Application Proxy](assetId:///a0d4c023-e75b-4140-b0aa-0fdb7f28a59d)  
  
-   [Web Application Proxy Walkthrough Guide](assetId:///ad72afff-bbb0-4c37-b4d8-2f68f790db70)  
  
-   [Web Application Proxy Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/dn283404.aspx)  
  
-   [Add-WebApplicationProxyApplication](http://technet.microsoft.com/library/dn283409.aspx)  
  
-   [Set-WebApplicationProxyConfiguration](http://technet.microsoft.com/library/dn283406.aspx)  
  

