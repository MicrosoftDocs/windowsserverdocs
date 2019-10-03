---
ms.assetid: 5f733510-c96e-4d3a-85d2-4407de95926e
title: Publishing Applications using AD FS Preauthentication
description:
author: kgremban
manager: femila
ms.date: 07/13/2016
ms.topic: article
ms.prod: windows-server

ms.technology: web-app-proxy
---

# Publishing Applications using AD FS Preauthentication

>Applies To: Windows Server 2016

**This content is relevant for the on-premises version of Web Application Proxy. To enable secure access to on-premises applications over the cloud, see the [Azure AD Application Proxy content](https://azure.microsoft.com/documentation/articles/active-directory-application-proxy-get-started/).**  
  
This topic describes how to publish applications through Web Application Proxy using Active Directory Federation Services (AD FS) preauthentication.  
  
For all types of application that you can publish using AD FS preauthentication, you must add a AD FS relying party trust to the Federation Service.  
  
The general AD FS preauthentication flow is as follows:  
  
> [!NOTE]  
> This authentication flow is not applicable for clients that use Microsoft Store apps.  
  
1.  The client device attempts to access a published web application on a particular resource URL; for example https://app1.contoso.com/.  
  
    The resource URL is a public address on which Web Application Proxy listens for incoming HTTPS requests.  
  
    If HTTP to HTTPS redirection is enabled, Web Application Proxy will also listen for incoming HTTP requests.  
  
2.  Web Application Proxy redirects the HTTPS request to the AD FS server with URL encoded parameters, including the resource URL and the appRealm (a relying party identifier).  
  
    The user authenticates using the authentication method required by the AD FS server; for example, user name and password, two-factor authentication with a one-time password, and so on.  
  
3.  After the user is authenticated, the AD FS server issues a security token, the 'edge token', containing the following information and redirects the HTTPS request back to the Web Application Proxy server:  
  
    -   The resource identifier that the user attempted to access.  
  
    -   The user's identity as a user principal name (UPN).  
  
    -   The expiry of the access grant approval; that is, the user is granted access for a limited period of time, after which they are required to authenticate again.  
  
    -   Signature of the information in the edge token.  
  
4.  Web Application Proxy receives the redirected HTTPS request from the AD FS server with the edge token and validates and uses the token as follows:  
  
    -   Validates that the edge token signature is from the federation service that is configured in the Web Application Proxy configuration.  
  
    -   Validates that the token was issued for the correct application.  
  
    -   Validates that the token has not expired.  
  
    -   Uses the user identity when required; for example to obtain a Kerberos ticket if the backend server is configured to use Integrated Windows authentication.  
  
5.  If the edge token is valid, Web Application Proxy forwards the HTTPS request to the published web application using either HTTP or HTTPS.  
  
6.  The client now has access to the published web application; however, the published application may be configured to require the user to perform additional authentication. If, for example, the published web application is a SharePoint site and does not require additional authentication, the user will see the SharePoint site in the browser.  
  
7.  Web Application Proxy saves a cookie on the client device. The cookie is used by Web Application Proxy to identify that this session has already been preauthenticated and that no further preauthentication is required.  
  
> [!IMPORTANT]  
> When configuring the external URL and the backend server URL, make sure you include the fully qualified domain name (FQDN), and not an IP address.  
  
> [!NOTE]  
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [Using Cmdlets](https://go.microsoft.com/fwlink/p/?linkid=230693).  
  
## <a name="BKMK_1.1"></a>Publish a Claims-based Application for Web Browser Clients  
To publish an application that uses claims for authentication, you must add a relying party trust for the application to the Federation Service.  
  
When publishing claims-based applications and accessing the application from a browser, the general authentication flow is as follows:  
  
1.  The client attempts to access a claims-based application using a web browser; for example, https://appserver.contoso.com/claimapp/.  
  
2.  The web browser sends an HTTPS request to the Web Application Proxy server which redirects the request to the AD FS server.  
  
3.  The AD FS server authenticates the user and the device and redirects the request back to Web Application Proxy. The request now contains the edge token. The AD FS server adds a single sign-on (SSO) cookie to the request because the user has already performed authentication against the AD FS server.  
  
4.  Web Application Proxy validates the token, adds its own cookie, and forwards the request to the backend server.  
  
5.  The backend server redirects the request to the AD FS server to get the application security token.  
  
6.  The request is redirected to the backend server by the AD FS server. The request now contains the application token and the SSO cookie. The user is granted access to the application and is not required to enter a user name or password.  
  
This procedure describes how to publish a claims-based application, such as a SharePoint site, that will be accessed by web browser clients. Before you begin, make sure that you have done the following:  
  
-   Created a relying party trust for the application in the AD FS Management console.  
  
-   Verified that a certificate on the Web Application Proxy server is suitable for the application you want to publish.  
  

  
#### To publish a claims-based application  
  
1.  On the Web Application Proxy server, in the Remote Access Management console, in the **Navigation** pane, click **Web Application Proxy**, and then in the **Tasks** pane, click **Publish**.  
  
2.  On the **Publish New Application Wizard**, on the **Welcome** page, click **Next**.  
  
3.  On the **Preauthentication** page, click **Active Directory Federation Services (AD FS)**, and then click **Next**.  
  
4.  On the **Supported Clients** page, select **Web and MSOFBA**, and then click **Next**.  
  
5.  On the **Relying Party** page, in the list of relying parties select the relying party for the application that you want to publish, and then click **Next**.  
  
6.  On the **Publishing Settings** page, do the following, and then click **Next**:  
  
    -   In the **Name** box, enter a friendly name for the application.  
  
        This name is used only in the list of published applications in the Remote Access Management console.  
  
    -   In the **External URL** box, enter the external URL for this application; for example, https://sp.contoso.com/app1/.  
  
    -   In the **External certificate** list, select a certificate whose subject covers the external URL.  
  
    -   In the **Backend server URL** box, enter the URL of the backend server. Note that this value is automatically entered when you enter the external URL and you should change it only if the backend server URL is different; for example, https://sp/app1/.  
  
        > [!NOTE]  
        > Web Application Proxy can translate host names in URLs, but cannot translate path names. Therefore, you can enter different host names, but you must enter the same path name. For example, you can enter an external URL of https://apps.contoso.com/app1/ and a backend server URL of https://app-server/app1/. However, you cannot enter an external URL of https://apps.contoso.com/app1/ and a backend server URL of https://apps.contoso.com/internal-app1/.  
  
7.  On the **Confirmation** page, review the settings, and then click **Publish**. You can copy the PowerShell command to set up additional published applications.  
  
8.  On the **Results** page, make sure that the application published successfully, and then click **Close**.  
  
![](../../media/Publishing-Applications-using-AD-FS-Preauthentication/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Add-WebApplicationProxyApplication  
    -BackendServerURL 'https://sp.contoso.com/app1/'  
    -ExternalCertificateThumbprint '1a2b3c4d5e6f1a2b3c4d5e6f1a2b3c4d5e6f1a2b'  
    -ExternalURL 'https://sp.contoso.com/app1/'  
    -Name 'SP'  
    -ExternalPreAuthentication ADFS  
    -ADFSRelyingPartyName 'SP_Relying_Party'  
```  
  
## <a name="BKMK_1.2"></a>Publish an Integrated Windows authenticated-based Application for Web Browser Clients  
Web Application Proxy can be used to publish applications that uses Integrated Windows authentication; that is, Web Application Proxy performs preauthentication as required, and can then perform SSO to the published application that uses Integrated Windows authentication. To publish an application that uses Integrated Windows authentication you must add a non-claims-aware relying party trust for the application to the Federation Service.  
  
To allow Web Application Proxy to perform single sign-on (SSO) and to perform credentials delegation using Kerberos constrained delegation, the Web Application Proxy server must be joined to a domain. See [Plan Active Directory](https://technet.microsoft.com/library/dn383648.aspx#BKMK_AD).  
  
To allow users to access applications that use Integrated Windows authentication, the Web Application Proxy server must be able to provide delegation for users to the published application. You can do this on the domain controller for any application. You can also do this on the backend server if it is running on  Windows Server 2012 R2  or  Windows Server 2012 . For more information, see [What's New in Kerberos Authentication](https://technet.microsoft.com/library/hh831747.aspx).  
  
For a walkthrough of how to configure Web Application Proxy to publish an application using Integrated Windows authentication, see [Configure a site to use Integrated Windows authentication](https://technet.microsoft.com/library/dn280943.aspx#BKMK_3).  
  
When using Integrated Windows authentication to backend servers, the authentication between Web Application Proxy and the published application is not claims-based, instead it uses Kerberos constrained delegation to authenticate end users to the application. The general flow is described below:  
  
1.  The client attempts to access a non-claims-based application using a web browser; for example, https://appserver.contoso.com/nonclaimapp/.  
  
2.  The web browser sends an HTTPS request to the Web Application Proxy server which redirects the request to the AD FS server.  
  
3.  The AD FS server authenticates the user and redirects the request back to Web Application Proxy. The request now contains the edge token.  
  
4.  Web Application Proxy validates the token.  
  
5.  If the token is valid, Web Application Proxy obtains a Kerberos ticket from the domain controller on behalf of the user.  
  
6.  Web Application Proxy adds the Kerberos ticket to the request as part of the Simple and Protected GSS-API Negotiation Mechanism (SPNEGO) token, and forwards the request to the backend server. The request contains the Kerberos ticket; therefore, the user is granted access to the application without the need for further authentication.  
  
This procedure describes how to publish an application that uses Integrated Windows authentication, such as Outlook Web App, that will be accessed by web browser clients. Before you begin, make sure that you have done the following:  
  
-   Created a non-claims-aware relying party trust for the application in the AD FS Management console.  
  
-   Configured the backend server to support Kerberos constrained delegation on the domain controller or by using the Set-ADUser cmdlet with the -PrincipalsAllowedToDelegateToAccount parameter. Note that if the backend server is running on  Windows Server 2012 R2  or  Windows Server 2012 , you can also run this PowerShell command on the backend server.  
  
-   Made sure that the Web Application Proxy servers are configured for delegation to the service principal names of the backend servers.  
  
-   Verified that a certificate on the Web Application Proxy server is suitable for the application you want to publish.  
  
 
  
#### To publish a non-claims-based application  
  
1.  On the Web Application Proxy server, in the Remote Access Management console, in the **Navigation** pane, click **Web Application Proxy**, and then in the **Tasks** pane, click **Publish**.  
  
2.  On the **Publish New Application Wizard**, on the **Welcome** page, click **Next**.  
  
3.  On the **Preauthentication** page, click **Active Directory Federation Services (AD FS)**, and then click **Next**.  
  
4.  On the **Supported Clients** page, select **Web and MSOFBA**, and then click **Next**.  
  
5.  On the **Relying Party** page, in the list of relying parties select the relying party for the application that you want to publish, and then click **Next**.  
  
6.  On the **Publishing Settings** page, do the following, and then click **Next**:  
  
    -   In the **Name** box, enter a friendly name for the application.  
  
        This name is used only in the list of published applications in the Remote Access Management console.  
  
    -   In the **External URL** box, enter the external URL for this application; for example, https://owa.contoso.com/.  
  
    -   In the **External certificate** list, select a certificate whose subject covers the external URL.  
  
    -   In the **Backend server URL** box, enter the URL of the backend server. Note that this value is automatically entered when you enter the external URL and you should change it only if the backend server URL is different; for example, https://owa/.  
  
        > [!NOTE]  
        > Web Application Proxy can translate host names in URLs, but cannot translate path names. Therefore, you can enter different host names, but you must enter the same path name. For example, you can enter an external URL of https://apps.contoso.com/app1/ and a backend server URL of https://app-server/app1/. However, you cannot enter an external URL of https://apps.contoso.com/app1/ and a backend server URL of https://apps.contoso.com/internal-app1/.  
  
    -   In the **Backend server SPN** box, enter the service principal name for the backend server; for example, HTTP/owa.contoso.com.  
  
7.  On the **Confirmation** page, review the settings, and then click **Publish**. You can copy the PowerShell command to set up additional published applications.  
  
8.  On the **Results** page, make sure that the application published successfully, and then click **Close**.  
  
![](../../media/Publishing-Applications-using-AD-FS-Preauthentication/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
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
  
## <a name="BKMK_1.3"></a>Publish an Application that uses MS-OFBA  
Web Application Proxy supports access from Microsoft Office clients such as Microsoft Word that access documents and data on backend servers. The only difference between these applications and a standard browser is that the redirection to the STS is done not via regular HTTP redirection but with special MS-OFBA headers as specified in: [https://msdn.microsoft.com/library/dd773463(v=office.12).aspx](https://msdn.microsoft.com/library/dd773463(v=office.12).aspx). Backend application may be claims or IWA.   
To publish an application for clients that use MS-OFBA, you must add a relying party trust for the application to the Federation Service. Depending on the application, you can use claims-based authentication or Integrated Windows authentication. Therefore, you must add the relevant relying party trust depending on the application.  
  
To allow Web Application Proxy to perform single sign-on (SSO) and to perform credentials delegation using Kerberos constrained delegation, the Web Application Proxy server must be joined to a domain. See [Plan Active Directory](https://technet.microsoft.com/library/dn383648.aspx#BKMK_AD).  
  
There are no additional planning steps if the application uses claims-based authentication. If the application used Integrated Windows authentication, see [Publish an Integrated Windows authenticated-based Application for Web Browser Clients](../web-application-proxy/../web-application-proxy/Publishing-Applications-using-AD-FS-Preauthentication.md#BKMK_1.2).  
  
The authentication flow for clients that use the MS-OFBA protocol using claims-based authentication is described below. The authentication for this scenario can either use the application token in the URL, or in the body.  
  
1.  The user is working in an Office program, and from the **Recent Documents** list, opens a file on a SharePoint site.  
  
2.  The Office program shows a window with a browser control that requires the user to enter credentials.  
  
    > [!NOTE]  
    > In some cases, the window may not appear because the client is already authenticated.  
  
3.  Web Application Proxy redirects the request to the AD FS server, which performs the authentication.  
  
4.  The AD FS server redirects the request back to Web Application Proxy. The request now contains the edge token.  
  
5.  The AD FS server adds a single sign-on (SSO) cookie to the request because the user has already performed authentication against the AD FS server.  
  
6.  Web Application Proxy validates the token and forwards the request to the backend server.  
  
7.  The backend server redirects the request to the AD FS server to get the application security token.  
  
8.  The request is redirected to the backend server. The request now contains the application token and the SSO cookie. The user is granted access to the SharePoint site and is not required to enter a user name or password to view the file.  
  
The steps to publish an application that uses MS-OFBA are identical to the steps for a claims-based application or a non-claims-based application. For claims-based applications, see [Publish a Claims-based Application for Web Browser Clients](../web-application-proxy/../web-application-proxy/Publishing-Applications-using-AD-FS-Preauthentication.md#BKMK_1.1), for non-claims-based applications, see [Publish an Integrated Windows authenticated-based Application for Web Browser Clients](../web-application-proxy/../web-application-proxy/Publishing-Applications-using-AD-FS-Preauthentication.md#BKMK_1.2). Web Application Proxy automatically detects the client and will authenticate the user as required.  
  
## Publish an Application that uses HTTP Basic  

HTTP Basic is the authorization protocol used by many protocols, to connect rich clients, including smartphones, with your Exchange mailbox. For more information on HTTP Basic, see [RFC 2617](https://www.ietf.org/rfc/rfc2617.txt). Web Application Proxy traditionally interacts with AD FS using redirections; most rich clients don't support cookies or state management. In this way Web Application Proxy enables the HTTP app to receive a non-claims relying party trust for the application to the Federation Service. See [Plan Active Directory](https://technet.microsoft.com/library/dn383648.aspx#BKMK_AD).  
  
The authentication flow for clients that use HTTP Basic is described below and in this diagram:  
  
![](../../media/Publishing-Applications-using-AD-FS-Preauthentication/WebApplicationProxy_httpBasicflow.png)  
  
1.  The user attempts to access a published web application a telephone client.  
  
2.  The app sends an HTTPS request to the URL published by Web Application Proxy.  
  
3.  If the request does not contain credentials, Web Application Proxy returns an HTTP 401 response to the app containing the URL of the authenticating AD FS server.  
  
4.  The user sends the HTTPS request to the app again with authorization set to Basic and user name and Base 64 encrypted password of the user in the www-authenticate request header.  
  
5.  Because the device cannot be redirected to AD FS, the Web Application Proxy sends an authentication request to AD FS with the credentials that it has including username and password. The token is acquired on behalf of the device.  
  
6.  In order to minimize the number of requests sent to the AD FS, Web Application Proxy, validates subsequent client requests using cached tokens for as long as the token is valid. Web Application Proxy periodically cleans the cache. You can view the size of the cache using the performance counter.  
  
7.  If the token is valid, Web Application Proxy forwards the request to the backend server and the user is granted access to the published web application.  
  
The following procedure explains how to publish HTTP basic applications.  
  
#### To publish an HTTP Basic application  
  
1.  On the Web Application Proxy server, in the Remote Access Management console, in the **Navigation** pane, click **Web Application Proxy**, and then in the **Tasks** pane, click **Publish**.  
  
2.  On the **Publish New Application Wizard**, on the **Welcome** page, click **Next**.  
  
3.  On the **Preauthentication** page, click **Active Directory Federation Services (AD FS)**, and then click **Next**.  
  
4.  On the **Supported Clients** page, select **HTTP Basic** and then click **Next**.  
  
    If you wish to enable access to the Exchange only from workplace joined devices, select the **Enable access only for workplace joined devices** box. For more information see [Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](https://technet.microsoft.com/library/dn280945.aspx).  
  
5.  On the **Relying Party** page, in the list of relying parties select the relying party for the application that you want to publish, and then click **Next**. Note that this list contains only on-claims relying parties.  
  
6.  On the **Publishing Settings** page, do the following, and then click **Next**:  
  
    -   In the **Name** box, enter a friendly name for the application.  
  
        This name is used only in the list of published applications in the Remote Access Management console.  
  
    -   In the **External URL** box, enter the external URL for this application; for example, mail.contoso.com  
  
    -   In the **External certificate** list, select a certificate whose subject covers the external URL.  
  
    -   In the **Backend server URL** box, enter the URL of the backend server. Note that this value is automatically entered when you enter the external URL and you should change it only if the backend server URL is different; for example, mail.contoso.com.  
  
7.  On the **Confirmation** page, review the settings, and then click **Publish**. You can copy the PowerShell command to set up additional published applications.  
  
8.  On the **Results** page, make sure that the application published successfully, and then click **Close**.  
  
![](../../media/Publishing-Applications-using-AD-FS-Preauthentication/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
This Windows PowerShell script enables preauthentication for all devices, not just workplace joined devices.  
  
```  
Add-WebApplicationProxyApplication  
     -BackendServerUrl 'https://mail.contoso.com'   
     -ExternalCertificateThumbprint '697F4FF0B9947BB8203A96ED05A3021830638E50'   
     -ExternalUrl 'https://mail.contoso.com'   
     -Name 'Exchange'   
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
     -Name 'Exchange'   
     -ExternalPreAuthentication ADFSforRichClients  
     -ADFSRelyingPartyName 'EAS_Relying_Party'  
```  
  
## <a name="BKMK_1.4"></a>Publish an Application that uses OAuth2 such as a Microsoft Store App  
To publish an application for Microsoft Store apps, you must add a relying party trust for the application to the Federation Service.  
  
To allow Web Application Proxy to perform single sign-on (SSO) and to perform credentials delegation using Kerberos constrained delegation, the Web Application Proxy server must be joined to a domain. See [Plan Active Directory](https://technet.microsoft.com/library/dn383648.aspx#BKMK_AD).  
  
> [!NOTE]  
> Web Application Proxy supports publishing only for Microsoft Store apps that use the OAuth 2.0 protocol.  
  
In the AD FS Management console, you must make sure that the OAuth endpoint is proxy enabled. To check if the OAuth endpoint is proxy enabled, open the AD FS Management console, expand **Service**, click **Endpoints**, in the **Endpoints** list, locate the OAuth endpoint and make sure that the value in the **Proxy Enabled** column is **Yes**.  
  
The authentication flow for clients that use Microsoft Store apps is described below:  
  
> [!NOTE]  
> The Web Application Proxy redirects to the AD FS server for authentication. Because Microsoft Store apps do not support redirects, if you use Microsoft Store apps, it is necessary to set the URL of the AD FS server using the Set-WebApplicationProxyConfiguration cmdlet and the OAuthAuthenticationURL parameter.  
>   
> Microsoft Store apps can be published only using Windows PowerShell.  
  
1.  The client attempts to access a published web application using a Microsoft Store app.  
  
2.  The app sends an HTTPS request to the URL published by Web Application Proxy.  
  
3.  Web Application Proxy returns an HTTP 401 response to the app containing the URL of the authenticating AD FS server. This process is known as 'discovery'.  
  
    > [!NOTE]  
    > If the app knows the URL of the authenticating AD FS server and already has a combo token containing the OAuth token and the edge token, steps 2 and 3 are skipped in this authentication flow.  
  
4.  The app sends an HTTPS request to the AD FS server.  
  
5.  The app uses the web authentication broker to generate a dialog box in which the user enters credentials to authenticate to the AD FS server. For information about web authentication broker, see [Web authentication broker](https://msdn.microsoft.com/library/windows/apps/hh750287.aspx).  
  
6.  After successful authentication, the AD FS server creates a combo token that contains the OAuth token and the edge token and sends the token to the app.  
  
7.  The app sends an HTTPS request containing the combo token to the URL published by Web Application Proxy.  
  
8.  Web Application Proxy splits the combo token into its two parts and validates the edge token.  
  
9. If the edge token is valid, Web Application Proxy forwards the request to the backend server with only the OAuth token. The user is granted access to the published web application.  
  
This procedure describes how to publish an application for OAuth2. This type of application can be published only using Windows PowerShell. Before you begin, make sure that you have done the following:  
  
-   Created a relying party trust for the application in the AD FS Management console.  
  
-   Made sure that the OAuth endpoint is proxy enabled in the AD FS Management console and make a note of the URL Path.  
  
-   Verified that a certificate on the Web Application Proxy server is suitable for the application you want to publish.  
  
#### To publish an OAuth2 app  
  
1.  On the Web Application Proxy server, in the Remote Access Management console, in the **Navigation** pane, click **Web Application Proxy**, and then in the **Tasks** pane, click **Publish**.  
  
2.  On the **Publish New Application Wizard**, on the **Welcome** page, click **Next**.  
  
3.  On the **Preauthentication** page, click **Active Directory Federation Services (AD FS)**, and then click **Next**.  
  
4.  On the **Supported Clients** page, select **OAuth2** and then click **Next**.  
  
5.  On the **Relying Party** page, in the list of relying parties select the relying party for the application that you want to publish, and then click **Next**.  
  
6.  On the **Publishing Settings** page, do the following, and then click **Next**:  
  
    -   In the **Name** box, enter a friendly name for the application.  
  
        This name is used only in the list of published applications in the Remote Access Management console.  
  
    -   In the **External URL** box, enter the external URL for this application; for example, https://server1.contoso.com/app1/.  
  
    -   In the **External certificate** list, select a certificate whose subject covers the external URL.  
  
        In order to make sure your users can access your app, even if they neglect to type HTTPS in the URL, select the **Enable HTTP to HTTPS Redirection** box.  
  
    -   In the **Backend server URL** box, enter the URL of the backend server. Note that this value is automatically entered when you enter the external URL and you should change it only if the backend server URL is different; for example, https://sp/app1/.  
  
        > [!NOTE]  
        > Web Application Proxy can translate host names in URLs, but cannot translate path names. Therefore, you can enter different host names, but you must enter the same path name. For example, you can enter an external URL of https://apps.contoso.com/app1/ and a backend server URL of https://app-server/app1/. However, you cannot enter an external URL of https://apps.contoso.com/app1/ and a backend server URL of https://apps.contoso.com/internal-app1/.  
  
7.  On the **Confirmation** page, review the settings, and then click **Publish**. You can copy the PowerShell command to set up additional published applications.  
  
8.  On the **Results** page, make sure that the application published successfully, and then click **Close**.  
  
Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
To set the OAuth authentication URL for a federation server address of fs.contoso.com and a URL path of /adfs/oauth2/:  
  
```  
Set-WebApplicationProxyConfiguration -OAuthAuthenticationURL 'https://fs.contoso.com/adfs/oauth2/'  
```  
  
To publish the application:  
  
```  
Add-WebApplicationProxyApplication  
    -BackendServerURL 'https://storeapp.contoso.com/'  
    -ExternalCertificateThumbprint '1a2b3c4d5e6f1a2b3c4d5e6f1a2b3c4d5e6f1a2b'  
    -ExternalURL 'https://storeapp.contoso.com/'  
    -Name 'Microsoft Store app Server'  
    -ExternalPreAuthentication ADFS  
    -ADFSRelyingPartyName 'Store_app_Relying_Party'  
    -UseOAuthAuthentication  
```  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Troubleshooting Web Application Proxy](https://technet.microsoft.com/library/dn770156.aspx)  
  
-   [Publish Applications through Web Application Proxy](https://technet.microsoft.com/library/dn383659.aspx)  
  
-   [Planning to Publish Applications Using Web Application Proxy](https://technet.microsoft.com/library/dn383650.aspx)  
  
-   [Web Application Proxy Walkthrough Guide](https://technet.microsoft.com/library/dn280944.aspx)  
  
-   [Web Application Proxy Cmdlets in Windows PowerShell](https://technet.microsoft.com/library/dn283404.aspx)  
  
-   [Add-WebApplicationProxyApplication](https://technet.microsoft.com/library/dn283409.aspx)  
  
-   [Set-WebApplicationProxyConfiguration](https://technet.microsoft.com/library/dn283406.aspx)  
  


