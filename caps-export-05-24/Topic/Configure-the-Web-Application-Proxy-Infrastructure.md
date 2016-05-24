---
title: Configure the Web Application Proxy Infrastructure
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 58aecda5-f547-48e9-8807-4f8fb58be835
author: kgremban
---
# Configure the Web Application Proxy Infrastructure
**This content is relevant for the on\-premises version of Web Application Proxy. To enable secure access to on\-premises applications over the cloud, see the [Azure AD Application Proxy content](https://azure.microsoft.com/en-us/documentation/articles/active-directory-application-proxy-get-started/).**  
  
This topic describes how to configure the infrastructure required for an [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] deployment. Before beginning the deployment steps, ensure that you have completed the planning steps described in [Plan the Web Application Proxy Infrastructure \[WAP\]](assetId:///8dfd483f-faf5-4a99-a590-0081623cad08).  
  
|Task|Description|  
|--------|---------------|  
|[1.1. Configure server network settings](../Topic/Configure-the-Web-Application-Proxy-Infrastructure.md#ConfigNetworkSettings)|Configure the server network settings on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server.|  
|[1.2. Configure firewalls](../Topic/Configure-the-Web-Application-Proxy-Infrastructure.md#ConfigFirewalls)|Configure additional firewalls, if required.|  
|[1.3. Configure DNS](../Topic/Configure-the-Web-Application-Proxy-Infrastructure.md#ConfigDNS)|Configure DNS settings for the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] deployment.|  
|[1.4. Configure Active Directory](../Topic/Configure-the-Web-Application-Proxy-Infrastructure.md#ConfigAD)|Join the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server to the Active Directory domain, if required.|  
|[1.5. Configure Active Directory Federation Services](../Topic/Configure-the-Web-Application-Proxy-Infrastructure.md#ConfigADFS)|Configure [!INCLUDE[firstref_adfs2](../Token/firstref_adfs2_md.md)] servers for authentication and authorization.|  
  
> [!NOTE]  
> [!INCLUDE[wps_howtorun](../Token/wps_howtorun_md.md)]  
  
## <a name="ConfigNetworkSettings"></a>Configure server network settings  
Network interface settings on the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server are configured by using **Change adapter settings** in the **Windows Networking and Sharing Center**. Specific IP address requirements depend on the topology and any other organizational requirements.  
  
## <a name="ConfigFirewalls"></a>Configure firewalls  
When the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] is separated from client devices or from the internal network by a firewall, you must configure the firewalls to allow traffic for the protocol and port number used by the published web applications. You must also configure the firewall to allow HTTPS traffic on port 443 for clients to communicate with the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server.  
  
Configure the backend firewall to enable connectivity to backend servers, including:  
  
1.  A rule to allow connectivity to the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] on port 443  
  
2.  Open the port on which you are running your apps  
  
3.  Connectivity to Active Directory  
  
For more information on backend server configuration, see [Active Directory and Active Directory Domain Services Port Requirements](http://technet.microsoft.com/library/dd772723(v=ws.10).aspx).  
  
## <a name="ConfigDNS"></a>Configure DNS  
Configure DNS servers internally and externally as required by your published web applications.  
  
-   [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] requires internal name resolution to resolve the names of backend servers, and infrastructure servers such as the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] servers.  
  
-   When publishing web applications via [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], every web application you publish requires an external URL. For clients to reach these web applications, a public DNS server must be able to resolve each external URL that you configure. Note that the external URL must resolve to the same IP address as the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, or the external IP address of a firewall or load\-balancer placed in front of the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server.  
  
## <a name="ConfigAD"></a>Configure Active Directory  
If your deployment uses Integrated Windows authentication, the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server must be joined to an [!INCLUDE[ad_adds_3](../Token/ad_adds_3_md.md)] domain. For information about domain and forest trusts when deploying [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], see [1.4. Plan Active Directory](assetId:///8dfd483f-faf5-4a99-a590-0081623cad08#BKMK_AD).  
  
#### To join the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server to a domain  
  
1.  In [!INCLUDE[sm](../Token/sm_md.md)], click **Local Server**. In the details pane, click the link next to **Computer name**.  
  
2.  On the **System Properties** dialog box, click the **Computer Name** tab. On the **Computer Name** tab, click **Change**.  
  
3.  In **Computer Name**, type the name of the computer if you are also changing the computer name when joining the server to the domain. Under **Member of**, click **Domain**, and then type the name of the domain to which you want to join the server; for example, corp.contoso.com, and then click **OK**.  
  
4.  When you are prompted for a user name and password, enter the user name and password of a user with rights to join computers to the domain, and then click **OK**.  
  
5.  When you see a dialog box welcoming you to the domain, click **OK**.  
  
6.  When you are prompted that you must restart the computer, click **OK**.  
  
7.  On the **System Properties** dialog box, click **Close**.  
  
8.  When you are prompted to restart the computer, click **Restart Now**.  
  
![](../Image/PowerShellLogoSmall.gif)**[!INCLUDE[wps_proc_title](../Token/wps_proc_title_md.md)]**  
  
[!INCLUDE[wps_proc_intro](../Token/wps_proc_intro_md.md)]  
  
Note that you must supply domain credentials after entering the Add\-Computer command below.  
  
```  
Add-Computer -DomainName <domain_name>  
Restart-Computer  
```  
  
### <a name="Kerberos"></a>Configure Kerberos constrained delegation  
To allow users to access applications that use Integrated Windows authentication, the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server must be able to provide delegation for users to the published application.  
  
> [!TIP]  
> This procedure assumes that the Web Application Proxy server is named EDGE1 and the domain is contoso.com.  
  
##### To configure Kerberos constrained delegation  
  
1.  On the domain controller, open [!INCLUDE[sm](../Token/sm_md.md)]. To do this, click **[!INCLUDE[sm](../Token/sm_md.md)]** on the **Start** screen, or **[!INCLUDE[sm](../Token/sm_md.md)]** in the taskbar on the desktop.  
  
2.  Click **Tools**, and then click **ADSI Edit**.  
  
3.  On the **Action** menu, click **Connect To**, and then on the **Connection Settings** dialog box, accept the default settings to connect to the default naming context, and then click **OK**.  
  
4.  In the left pane, expand **Default naming context**, expand **DC\=contoso,DC\=com**, expand **CN\=Computers**, right\-click **CN\=EDGE1**, and then click **Properties**.  
  
5.  On the **CN\=EDGE1 Properties** dialog box, on the **Attribute Editor** tab, in the **Attributes** list, select **servicePrincipalName**, and then click **Edit**.  
  
6.  On the **Multi\-valued String Editor** dialog box, in **Value to add**, enter **HTTP\/EDGE1.contoso.com** and click **Add**. Then enter **HTTP\/EDGE1** and click **Add**.  
  
    The **Values** list now contains two new entries; for example, **HTTP\/EDGE1.contoso.com** and **HTTP\/EDGE1**.  
  
7.  On the **Multi\-valued String Editor** dialog box, click **OK**.  
  
8.  On the **CN\=EDGE1 Properties** dialog box, click **OK**.  
  
9. In [!INCLUDE[sm](../Token/sm_md.md)], click **Tools**, and then click **Active Directory Users and Computers**.  
  
10. In the navigation pane, under **contoso.com**, click **Computers**. In the details pane, right\-click the [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)] server, and then click **Properties**.  
  
11. On the **EDGE1 Properties** dialog box, on the **Delegation** tab, click **Trust this computer for delegation to specified services only**, and then click **Use any authentication protocol**.  
  
12. Click **Add**, and on the **Add Services** dialog box, click **Users or Computers**.  
  
13. On the **Select Users or Computers** dialog box, in **Enter the object names to select**, enter the name of the web servers that use Integrated Windows authentication; for example, WebServ1, and then click **OK**.  
  
14. On the **Add Services** dialog box, in the **Available services** list, select the **http** service type, and then click **OK**.  
  
15. On the **EDGE1 Properties** dialog box, click **OK**.  
  
## <a name="ConfigADFS"></a>Configure Active Directory Federation Services  
Configuring [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] is described in detail in the [Windows Server 2012 AD FS Deployment Guide](../Topic/Windows-Server-2012-AD-FS-Deployment-Guide.md).  
  
For all web applications that you intend to publish using [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] preauthentication, you must configure a relying party trust for each application on the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] server. See [Create a Relying Party Trust Using Federation Metadata](../Topic/Create-a-Relying-Party-Trust-Using-Federation-Metadata.md).  
  
For all [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] endpoints that you require to be published by [!INCLUDE[adfs_webproxy](../Token/adfs_webproxy_md.md)], in the [!INCLUDE[nextref_adfs2](../Token/nextref_adfs2_md.md)] Management console, you must set the endpoint to be **Proxy Enabled**.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Install and Configure the Web Application Proxy Server](../Topic/Install-and-Configure-the-Web-Application-Proxy-Server.md)  
  
-   [Configure Publishing Applications through Web Application Proxy](assetId:///e75be34f-876d-4147-944b-8ab98285804e)  
  
-   [Planning to Publish Applications Using Web Application Proxy](../Topic/Planning-to-Publish-Applications-Using-Web-Application-Proxy.md)  
  
-   [Web Application Proxy Walkthrough Guide](../Topic/Web-Application-Proxy-Walkthrough-Guide.md)  
  
