---
title: Working with Web Application Proxy
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b607b717-2172-4271-98d1-fa8162e0bb2e
author: kgremban
---
# Working with Web Application Proxy
**This content is relevant for the on\-premises version of Web Application Proxy. To enable secure access to on\-premises applications over the cloud, see the [Azure AD Application Proxy content](https://azure.microsoft.com/en-us/documentation/articles/active-directory-application-proxy-get-started/).**  
  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] is a new Remote Access role service in [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)]. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] provides reverse proxy functionality for web applications inside your corporate network to allow users on any device to access them from outside the corporate network. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] preauthenticates access to web applications using [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], and also functions as an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] proxy.  
  
## <a name="AccessingApps"></a>Providing Access to Applications  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] provides organizations with the ability to provide selective access to applications running on servers inside the organization to end users located outside of the organization. The process to make the application available externally is known as publishing. Unlike traditional VPN solutions, when you publish applications through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] end users can gain access only to applications that you publish. However, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] can also be deployed with VPN as part of a Remote Access deployment in your organization. See Interoperability with other remote access products, below.  
  
### <a name="Publish"></a>Publishing Applications  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] publishing enables end users to access their organization’s applications from their own devices, so that users are not limited to corporate laptops to do their work, they can use their home computer, their tablet, or their smartphone. In addition, end users are not required to install any additional software on their device to access published applications. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] can be used on clients with a standard browser, an Office client or a rich client using OAuth \(for example Windows Store apps\). [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] serves as a reverse proxy for any application that is published through it and as such, the end user experience is the same as if the end user’s device connects directly to the application.  
  
### <a name="Access"></a>Accessing Applications  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] must always be deployed with [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]. This enables you to leverage the features of [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], such as, single sign\-on \(SSO\). This enables users to enter their credentials one time and on subsequent occasions, they will not be required to enter their credentials. SSO is supported by [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] for backend servers that use claims\-based authentication; for example SharePoint claims\-based applications, and Integrated Windows authentication using Kerberos constrained delegation. Integrated Windows authentication\-based applications can be defined in [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] as relying party trusts which can define rich authentication and authorization policies that are enforced in requests to the application.  
  
## <a name="Protecting"></a>Protecting Applications from External Threats  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] serves as a barrier between the Internet and your corporate applications. In many organizations, when you deploy [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] and publish applications through it, those applications will be available to external users on devices that are not joined to your domain; for example, personal laptops, tablets, or smartphones. These devices are not domain\-joined and as such, they are described as unmanaged devices, and are untrusted within the corporate network. Since you want your users to be able to access important information whenever and wherever they are located, you must mitigate the security risk of allowing users access to corporate resources from these unmanaged and untrusted devices. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] provides a number of security features to protect your corporate network from external threats. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] uses [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] for authentication and authorization to ensure that only users on devices who authenticate and are authorized can access your corporate applications.  
  
### <a name="DiD"></a>Defense in Depth  
In the recommended deployment, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] is deployed in a perimeter network between an Internet\-facing firewall and a corporate network firewall. However, in addition to the protection provided by the firewalls themselves, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] provides additional protection for your applications from external threats.  
  
-   When HTTPS traffic arrives that is directed to an address published by [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], it terminates the traffic and initiates new requests to the published applications. It therefore acts as a session\-level buffer between external devices and published applications. That is, when users access published applications, they do not directly access the application, instead, they access the application through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)].  
  
-   Any other traffic that arrives at [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] is dropped and not forwarded to the published applications. This includes any illegal HTTP or HTTPS requests that might be used as part of denial of service attacks, zero day attacks, SSL attacks, and so on.  
  
-   Any authenticated request that arrives at [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] containing an authentication token from [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] will be inspected to make sure that the token received was intended for the client sending the token. This is done by checking that the device \(through the Workplace Join certificate\) corresponds to the claim within the token that identified the device when authenticated to [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)].  
  
### <a name="AuthN_and_AuthZ"></a>Authentication and Authorization  
To protect access to applications in your organization, it is recommended to allow access only to authenticated and authorized users. When you publish applications through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], this is achieved through the use of [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], which provides authentication and enforces authorization for the published applications.  
  
> [!NOTE]  
> [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] also allows pass\-through preauthentication, which enables you to publish applications that do not require preauthentication or whose clients do not support the available authentication capabilities.  
  
#### <a name="AuthenticatingUsers"></a>Authenticating Users and Devices  
When you publish applications through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], the process by which users and devices are authenticated before they gain access to applications is known as preauthentication. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] supports two forms of preauthentication:  
  
-   [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] preauthentication—When using [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] for preauthentication, the user is required to authenticate to the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server before [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] redirects the user to the published web application. This ensures that all traffic to your published web applications is authenticated.  
  
-   Pass\-through preauthentication—Users are not required to enter credentials before they connect to published web applications.  
  
    > [!NOTE]  
    > Pass\-through preauthentication has no impact on whether an application requires users to provide credentials to the application. That is, an application configured with pass\-through preauthentication does not require users to enter credentials to get into the corporate network, but may require users to enter credentials to view the application content.  
  
To easily access applications published by [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], and to use [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] preauthentication end users should use one of the following clients:  
  
-   Any client that supports HTTP redirects; for example, a web browser. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] performs the appropriate action on the incoming request to redirect the user to an authentication address and back to the original web address, this time with the authentication proof.  
  
-   Rich clients that use HTTP basic, for example, Exchange ActiveSync.  
  
-   Any client that uses MSOFBA; for example, Word, Excel, or PowerPoint. In this case, a user attempts to access a document from their Recent Documents list that is stored on a server within the corporate network.  
  
-   Windows Store apps and RESTful applications with clients that use the Web Authentication Broker for authentication. A user can open an app on their device which obtains a token from [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] via the Web Authentication Broker, and includes that token in the HTTP Authorization header in subsequent requests to the app.  
  
> [!NOTE]  
> Depending on the client used to access the published application, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] decides how to process the request.  
  
#### <a name="AuthenticationCapabilities"></a>Authentication Capabilities  
When you use [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] for authentication, you also benefit from all of the features that [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] provides:  
  
-   Workplace Join—This is a new feature in [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. It allows users to join devices to the workplace that would not normally be domain\-joined; for example, personal laptops, tablets, and smartphones. When this feature is enabled, the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] administrator can configure all applications, or individual applications, to require devices to be registered before they can gain access to published applications. For more information, see [Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](../Topic/Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md).  
  
-   SSO—This allows users to enter credentials once and be authenticated to all supported published applications. See [Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](../Topic/Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md).  
  
-   Multifactor authentication \(MFA\)—[!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] can be configured to require users to authenticate with more than one authentication scheme; for example, a one\-time password or a smart card. See [Manage Risk with Additional Multi-Factor Authentication for Sensitive Applications](../Topic/Manage-Risk-with-Additional-Multi-Factor-Authentication-for-Sensitive-Applications.md).  
  
-   Multifactor access control—Access control in [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] is implemented with authorization claim rules that are used to issue a permit or deny claims that will determine whether a user or a group of users will be allowed to access [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]\-secured resources or not. Authorization rules can only be set on relying party trusts. All of the above features can be combined, as required, to provide stricter security for confidential applications, or ignored for less confidential applications. See [Manage Risk with Conditional Access Control](../Topic/Manage-Risk-with-Conditional-Access-Control.md).  
  
When you publish applications through [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] you are not required to configure the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] authentication features mentioned above. This allows you to provide access to devices that are not able to join the workplace, or provide additional factors of authentication, such as kiosks.  
  
## <a name="TechnicalOverview"></a>Web Application Proxy Technical Overview  
When you decide to use [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] in your organization, we recommend that you deploy your [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers behind a frontend firewall to separate it from the Internet, or between two firewalls; a frontend firewall to separate it from the Internet, and a backend firewall to separate it from the corporate network. In this topology, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] provides a protection layer against malicious users that may be coming from the Internet. No other servers are required to be located in this perimeter network; that is, your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers are located in the corporate network and can only be reached via [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] using its built\-in [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] proxy functionality.  
  
The following diagram shows a typical topology for deploying [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] in a perimeter network between two firewalls.  
  
![](../Image/WebApplicationProxyTopology.png)  
  
### <a name="ConfigStorage"></a>Web Application Proxy Configuration Storage  
The [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] configuration is stored on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers in your organization; therefore, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers require connectivity to the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers. In addition, after configuring the first [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, you can install additional [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers to create a cluster deployment. When you install the role service on the new server in the cluster, the configuration is automatically transferred to the new server after completing the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Configuration Wizard.  
  
Since [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] stores its configuration on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers it has no locally stored configuration information.  
  
### <a name="ADFSProxy"></a>AD FS Proxy Functionality  
The [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] role service is also an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] proxy. That is, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] listens to all of the end\-points that [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] listens to. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] also forwards any requests from the Internet to [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] and responses from [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] to the Internet. Note that the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] role service is a replacement for the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] proxy role.  
  
Creating a proxy in your organization for your Federation Service adds additional security layers to your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] deployment. Consider deploying [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] in your organization’s perimeter network when you want to:  
  
-   Prevent external client computers from directly accessing your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers. By deploying a [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server in your perimeter network, you effectively isolate your [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers do not have access to the private keys that are used to produce tokens.  
  
-   Provide a convenient way to differentiate the sign\-in experience for users who are coming from the Internet as opposed to users who are coming from your corporate network using Integrated Windows authentication.  
  
### <a name="Managing"></a>Managing Web Application Proxy  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] uses a number of tools and features provided by [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] to enable you to easily install, deploy, and manage it in your corporate deployments.  
  
-   [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] is a role service in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. This allows you to easily install [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] in your deployment using [!INCLUDE[sm](../Token/sm_md.md)] or [!INCLUDE[wps_2](../Token/wps_2_md.md)].  
  
-   [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] is integrated into the Remote Access Management console, allowing you to manage your [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers and other Remote Access technologies, such as DirectAccess and VPN from the same Remote Access Management console.  
  
-   [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] provides full functionality through a set of [!INCLUDE[wps_2](../Token/wps_2_md.md)] commands and a Windows Management Instrumentation \(WMI\) API.  
  
-   To aid troubleshooting, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]:  
  
    -   Writes events to the Windows Event log.  
  
    -   Exposes a number of performance counters.  
  
    -   Has a dedicated Best Practices Analyzer \(BPA\).  
  
### <a name="Interoperability"></a>Interoperability with Other Remote Access Products  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] is a role service of the Remote Access role in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. You can install [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] side\-by\-side with Remote Access in the following scenarios:  
  
|DirectAccess|VPN|[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]|  
|----------------|-------|-----------------------------------------------------------|  
|Single server deployment|Single server deployment|Single server deployment|  
|Multisite deployment|Multiple server deployment|Not supported on the same server|  
|Not supported on the same server|Multiple server deployment|Multiple server deployment|  
|Cluster deployment<sup>1</sup>|Multiple server deployment|Multiple server deployment<sup>2</sup>|  
  
> [!NOTE]  
> 1—In a pre\-existing DirectAccess cluster deployment, you can install [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] only using [!INCLUDE[wps_2](../Token/wps_2_md.md)].  
>   
> 2—In a pre\-existing multiple server [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] deployment, you can install DirectAccess only using [!INCLUDE[wps_2](../Token/wps_2_md.md)].  
  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] provides application publishing capabilities, similar to Forefront Unified Access Gateway \(UAG\). However, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] interacts with other servers and services to provide a more streamlined deployment. This helps you to concentrate on configuring only the necessary parts of your deployment. It is recommended that for any new deployments where you require application publishing capabilities for the scenarios described above, you should use [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)].  
  
## See Also  
[Planning to Publish Applications Using Web Application Proxy](../Topic/Planning-to-Publish-Applications-Using-Web-Application-Proxy.md)  
  
