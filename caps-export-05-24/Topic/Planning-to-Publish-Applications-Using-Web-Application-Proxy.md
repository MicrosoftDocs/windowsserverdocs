---
title: Planning to Publish Applications Using Web Application Proxy
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a0d4c023-e75b-4140-b0aa-0fdb7f28a59d
author: kgremban
---
# Planning to Publish Applications Using Web Application Proxy
**This content is relevant for the on\-premises version of Web Application Proxy. To enable secure access to on\-premises applications over the cloud, see the [Azure AD Application Proxy content](https://azure.microsoft.com/en-us/documentation/articles/active-directory-application-proxy-get-started/).**  
  
This section describes planning steps that can be taken when you use [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] – a Remote Access role service \- to provide reverse proxy functionality for corporate web applications and services. When you use [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] with [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)], you can manage the risk of exposing your applications to the Internet by configuring features provided by [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], including: Workplace Join, multifactor authentication \(MFA\), and multifactor access control.  
  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] also functions as an [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] proxy.  
  
The following diagram shows the topology used in this scenario for [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] to publish Microsoft applications and other line\-of\-business \(LOB\) applications.  
  
![](../Image/WebApplicationProxyTopology.png)  
  
## <a name="AccesstoApps"></a>Providing Access to Applications and Services  
This scenario demonstrates how to plan and deploy [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] in your organization to provide selective access to applications running on servers inside the organization to end users located outside of the organization. The process to make the application available externally is known as publishing. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] publishing enables end users to access their organization’s applications from their own devices, so that users are not limited to corporate laptops to do their work, they can use their home computer, their tablet, or their smartphone. [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] serves as a reverse proxy for any application that is published through it and as such, the end user experience is the same as if the end user’s device connects directly to the application.  
  
## <a name="Roles_Features"></a>Roles and Features Included in this Scenario  
The following table lists the roles and features that are part of this scenario and describes how they support it.  
  
|Role\/feature|How it supports this scenario|  
|-----------------|---------------------------------|  
|[Active Directory Domain Services Overview](../Topic/Active-Directory-Domain-Services-Overview.md)|[!INCLUDE[ad_adds_1](../Token/ad_adds_1_md.md)] is required as a prerequisite before you can deploy [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]. It is also required for [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] deployments that use Kerberos constrained delegation.|  
|[Active Directory Federation Services Overview](../Topic/Active-Directory-Federation-Services-Overview.md)|[!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] is required to provide authentication and authorization services to [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] and to store the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] configuration.|  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
Hardware requirements for this scenario include the following:  
  
-   A computer that meets the hardware requirements for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] running one of the following server editions: Essentials, Standard, or Datacenter.  
  
-   The server must have at least one network adapter installed, enabled, and connected to the internal network either directly, or through a firewall or NAT device. When two adapters are used, there should be one adapter connected to the internal corporate network, and one connected to the external network \(Internet, or private network\).  
  
## <a name="BKMK_SOFT"></a>Software requirements  
Software requirements for this scenario include the following:  
  
-   If the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server is located behind an edge firewall or NAT device, the device must be configured to allow traffic to and from the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server.  
  
-   The person deploying [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] on the server requires local administrator permissions on the server. In addition, when you connect the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server to the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server, you require the credentials of the local administrator on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers.  
  
-   You must deploy [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] on a server running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] in your organization before you can deploy [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)].  
  
-   If you want to remotely manage [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers, you must enable remote PowerShell management on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers. See [Running Remote Commands](http://technet.microsoft.com/library/dd819505.aspx).  
  
## <a name="BKMK_Location"></a>Plan Network Location  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] can be deployed in several topologies. For example, you can deploy [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] behind a frontend firewall to separate it from the Internet, or between two firewalls; a frontend firewall to separate it from the Internet, a backend firewall to separate it from the corporate network. In both topologies, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] provides a protection layer against malicious HTTP requests that originate from the Internet through the following features:  
  
-   Preauthentication—Make sure that only authenticated traffic can get into the corporate network.  
  
-   Network Isolation—Incoming web traffic cannot directly access backend servers.  
  
-   Selective Publishing—Only specific applications and paths within these applications are accessible.  
  
-   DDoS Protection—Incoming traffic arrives at [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] before entering the corporate network. Because [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] acts as a buffer, many DDoS attacks can be prevented from reaching the backend servers.  
  
### Plan Firewalls  
Deploying [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] behind a firewall adds network level protection and reduces the attack surface of the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers. If the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server is located in front of a firewall that separates it from the corporate network, you must make sure that the firewall does not block traffic to URLs configured for the backend servers. This could be over HTTP or HTTPS and on any specified port. Note that if you deploy [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] on a domain\-joined server, it must have connectivity to the domain controller, see [1.3. Plan Active Directory](assetId:///8dfd483f-faf5-4a99-a590-0081623cad08#BKMK_AD).  
  
All firewall servers must be configured to allow HTTPS traffic because the firewall servers must publish [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] using port 443 so that [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] in the perimeter network can access the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] in the corporate network. Port 443 is also required for device registration using Workplace Join.  
  
> [!NOTE]  
> All [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] communications to and from client devices also occur over HTTPS.  
  
In the federated world of [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)], client requests are typically made to a specific URL, for example, a [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] identifier URL such as https:\/\/fs.fabrikam.com. Because these client requests originate from the Internet, the Internet\-facing firewall server must be configured to publish the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)] identifier URL for each [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server that is deployed in the perimeter network.  
  
If you want to use client certificate authentication, you must also configure the firewall to allow traffic on port 49443.  
  
## <a name="BKMK_DNS"></a>Plan DNS  
DNS planning requirements include the following:  
  
-   [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] requires internal name resolution to resolve the names of backend servers, and of infrastructure servers such as the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server.  
  
-   When publishing web applications via [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], every web application you publish requires an external URL. For clients to reach these web applications, a public DNS server must be able to resolve each external URL that you configure. Note that the external URL must resolve to the external IP address of the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, or the external IP address of a firewall or load\-balancer placed in front of the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server.  
  
## <a name="BKMK_LB"></a>Plan Load Balancing  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] does not include integrated load\-balancing functionality. If you plan to deploy multiple [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers, you should consider deploying a load\-balancer to ensure that the external traffic is distributed evenly between [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers. You can use any hardware or software load\-balancer that supports HTTP and HTTPS, including Windows Network Load Balancing.  
  
You can also configure a load\-balancer for published web applications. That is, you can deploy a load\-balancer between the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers and the published web application. You can use any hardware or software load\-balancer that supports HTTP and HTTPS, including Windows Network Load Balancing.  
  
> **alert tag is not supported!!!!**  
> A cluster must be either completely domain joined or not domain joined.  
  
## <a name="BKMK_AD"></a>Plan Active Directory  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] can be deployed without joining the server to an [!INCLUDE[ad_adds_3](../Token/ad_adds_3_md.md)] domain or by joining the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server to a standalone domain in a perimeter network.  
  
You can deploy [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] with a read\-only domain controller. However, if you want to deploy [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] and DirectAccess on the same server, you cannot use a read\-only domain controller.  
  
### <a name="IWA_KCD"></a>Plan Integrated Windows authentication and Kerberos constrained delegation  
When publishing applications that use Integrated Windows authentication, the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server uses Kerberos constrained delegation to authenticate users to the published application.  
  
The following diagram shows the connections from [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] to the domain controller to get the Kerberos ticket, and the connection from [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] to the backend server to perform Integrated Windows authentication.  
  
![](../Image/WebApplicationProxyIWAtopology.png)  
  
To use Integrated Windows authentication, the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server must be joined to an [!INCLUDE[ad_adds_3](../Token/ad_adds_3_md.md)] domain. The following lists the domain and forest requirements for a deployment using Integrated Windows authentication with Kerberos constrained delegation.  
  
1.  Deployments where users, resources, and [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers are all in the same forest are supported.  
  
2.  In deployments with multiple forests where there is a user forest, a resource forest, and an [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] forest, the following deployments are supported:  
  
    1.  Users, resources, and [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers are all in different forests.  
  
    2.  Users and [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers are in the same forest, but resources are in a different forest.  
  
    3.  Resources and [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers are in the same forest, but users are in a different forest.  
  
In multi\-forest deployments:  
  
1.  The user forest must trust the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] forest, and the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] forest must trust the resource forest.  
  
2.  All of the Active Directory domains in a multi\-forest deployment must have at least one [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] or higher domain controller. For more information, see [Kerberos Constrained Delegation across Domains](http://go.microsoft.com/fwlink/?LinkId=389630)  
  
## <a name="BKMK_ADFS"></a>Plan Active Directory Federation Services  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] can use [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] for preauthentication; that is, when you configure web applications to use [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] preauthentication, unauthenticated client requests are redirected to the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server for authentication and authorization before forwarding the request to the published web application.  
  
### AD FS Requirements  
When planning [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] for [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] deployments, the following is required:  
  
-   At least one [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server installed on the [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] operating system.  
  
## <a name="BKMK_AuthN"></a>Plan Preauthentication  
[!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] enables you to use two forms of preauthentication:  
  
-   [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)]—When using [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] preauthentication, you can also use Integrated Windows authentication. See [Plan to Publish Applications using AD FS Preauthentication \[WAP\]](assetId:///4ba7b98c-0d64-42c9-913d-616e329e2ead).  
  
-   Pass\-through preauthentication—When using pass\-through preauthentication, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] does not authenticate users before they are allowed to connect to published web applications. See [Plan to Publish Applications using Pass\-through Preauthentication \[WAP\]](assetId:///c8a3df4e-3ec5-4131-a2a1-975ef21f2387).  
  
## <a name="BKMK_2.1"></a>Plan the Web Application Proxy Role Service Installation  
The following table describes the supported Remote Access role service deployments.  
  
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
  
> [!IMPORTANT]  
> If you deploy DirectAccess and [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] on the same server, you cannot use a read\-only domain controller.  
  
You can deploy the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] role service on a server that is also running the Internet Information Services \(IIS\) role. However, in this type of deployment, you must make sure that IIS is configured to only listen, or be bound, to URLs that are not configured as external URLs on [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)].  
  
## <a name="Cluster"></a>Plan Multiple Servers  
The [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] configuration is stored on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers in your organization. After configuring the first [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, you can install additional [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers to create a multiple server deployment. When you install the role service on the new server in the multiple server deployment, the configuration is automatically transferred to the new server after completing the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] Configuration Wizard.  
  
## <a name="BKMK_Certs"></a>Plan Certificates  
The following table describes the certificates that are required when deploying [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], and any other requirements when using those certificates.  
  
|Certificate purpose and location<sup>1</sup>|Certificate issuer<sup>2</sup>|Notes|  
|------------------------------------------------|----------------------------------|---------|  
|Server authentication for the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server.<br /><br />Import the certificate to the Personal Certificates store on all [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers.|Public CA<br /><br />&<br /><br />Enterprise CA \(internal\)|-   For clients to be able to connect to published web applications using HTTPS, [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] must present a certificate that is trusted by clients. Because clients are not required to be included in your PKI, this usually requires you to acquire a certificate from an external certification authority \(CA\).<br />-   It is not recommended to use an Enterprise CA if users are allowed to use their own devices to access published applications.<br />-   You can use single name certificates, subject alternative name \(SAN\) certificates, or wildcard certificates.<br />-   You may require more than one certificate to successfully publish all the required applications.|  
|Server authentication for the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)].<br /><br />Import the certificate to the Personal Certificates store on all [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers.|Public CA<br /><br />&<br /><br />Enterprise CA \(internal\)|This certificate is required for [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] proxy functionality.<br /><br /><ul><li>The subject of this certificate must match the Federation Service name value that is specified in the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management console. To locate this value, open the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management console, click **Service**, in the **Actions** pane, click **Edit Federation Service Properties**, and then find the value in the **Federation Service name** text box.</li><li>For Workplace Join, the certificate must have the following subject alternative names \(SANs\):<br /><br /><ul><li><federation service name>.<domain><br /><br />        For example, adfs1.contoso.com.</li><li>enterpriseregistration.<domain><br /><br />        For example, enterpriseregistration.contoso.com.</li></ul></li></ul> **Note:** Only one certificate is required for server authentication for the [!INCLUDE[adfs2_fs](../Token/adfs2_fs_md.md)].|  
  
> [!NOTE]  
> 1—If any certificate that you use has certificate revocation lists \(CRLs\), the server with the configured certificate must be able to contact the server that distributes the CRLs; the CRL distribution point \(CDP\). Clients must be able to reach the CDP. The type of CRL determines what ports are used.  
>   
> 2—In all cases, the client must trust the issuing CA and any intermediate CAs.  
  
## <a name="BKMK_2.2"></a>Plan NTP  
When using [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] preauthentication, the time of all [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers must be identical to the time of the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers so that the timestamps on claims match. The time of all [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers must be identical to the time of the applications servers when using Kerberos constrained delegation. It is recommended to enable Network Time Protocol \(NTP\) on all [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] and [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers.  
  
## Plan for Client Certificate Preauthentication  
  
-   Plan the external servers:  
  
    To use client certificate preauthentication, the external servers must have a certificate issued by a public certification authority \(CA\). For information about requesting and configuring this certificate, see the documentation for your server. All of the external servers that you use to connect to the published web application must have the same certificate.  
  
    The certificate can be issued by any trusted certification authority, and you must be able to obtain the certificate thumbprint.  
  
-   Plan applications that work with client certificate preauthentication:  
  
    To publish an application using client certificate preauthentication, you do not require a relying party trust for the application.  
  
    > [!NOTE]  
    > Applications that use client certificate preauthentication cannot leverage the additional features that [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] provides; such as, Workplace Join, multifactor authentication \(MFA\), and multifactor access control.  
  
## <a name="BKMK_KI"></a>Known issues  
The following are known issues when configuring [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)]:  
  
-   When the token\-signing certificate is updated in the Federation Service, the public key of the certificate is not automatically updated on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers. To resolve this issue, you must manually import the new token\-signing certificate to the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] servers.  
  
-   When you configure the Device Registration Service on your Federation Service, you can also enable device authentication for all relying parties with the following PowerShell command:  
  
    ```  
    Set-AdfsGlobalAuthenticationPolicy –DeviceAuthenticationEnabled $true  
    ```  
  
    When you publish applications with [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], you can publish more than one application using the same host name. You can also configure each application to authenticate the certificate presented by client devices. To validate client certificates for an application, use the following PowerShell command:  
  
    ```  
    Set-WebApplicationProxyApplication -id <Published Application ID> -ClientCertificateAuthenticationBindingMode ValidateCertificate  
    ```  
  
    Because [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] uses the HTTP protocol stack \(http.sys\), this configuration setting must be identical for all applications that use the same host name.  
  
