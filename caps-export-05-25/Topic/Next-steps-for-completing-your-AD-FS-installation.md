---
title: Next steps for completing your AD FS installation
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c66c7f4b-6b8f-4e44-8331-63fa85f858c2
author: femila
---
# Next steps for completing your AD FS installation
This topic covers additional steps to configure AD FS after you install the first federation server, including:  
  
-   [Opening the ADFS Management Snap\-in](../Topic/Next-steps-for-completing-your-AD-FS-installation.md#BKMK_ADFSSnapin)  
  
-   [Configuring Name Resolution for AD FS Services](../Topic/Next-steps-for-completing-your-AD-FS-installation.md#BKMK_ConfigureDNS)  
  
-   [Adding nodes to the farm](../Topic/Next-steps-for-completing-your-AD-FS-installation.md#BKMK_AddNodesToFarm)  
  
-   [Adding a Web Application Proxy](../Topic/Next-steps-for-completing-your-AD-FS-installation.md#BKMK_AddWebAppProxy)  
  
-   [Installing Device Registration Service](../Topic/Next-steps-for-completing-your-AD-FS-installation.md#BKMK_InstallDRS)  
  
For more information about how to deploy AD FS, see [How to deploy AD FS in Windows Server 2012 R2](assetId:///dccc483a-4df5-49bd-bc7a-39b6d42cee4c).  
  
## <a name="BKMK_ADFSSnapin"></a>Opening the ADFS Management Snap\-in  
The ADFS Management Snap\-in is used to configure AD FS settings, including Relying Party Trusts, Multifactor authentication, and multifactor access control. To open AD FS Management, in **Server Manager**, click **Tools**, and then click **AD FS Management**.  
  
## <a name="BKMK_ConfigureDNS"></a>Configuring Name Resolution for AD FS Services  
In order for AD FS to function, clients must be able to resolve the federation service name, such as fs.contoso.com, to the correct IP address: either the IP address of a federation server or farm \(for clients on the internal corporate network\), or to the IP address of a web application proxy or proxy farm \(for external clients\).  
  
The steps in this section describe how to configure DNS to resolve the federation service name and how to validate name resolution.  
  
### Create A or AAAA \(Host\) records for the Federation Service Name  
After you install a federation server or farm, and after you install a Web Application Proxy server or farm, create A Host records so DNS clients can locate the servers by their friendly names.  
  
If you deploy only one AD FS server, create a record that points to the IP address of the federation server. If you deploy a federation server farm, create a record that points to the IP address of a load balancer for the federation server farm.  
  
If you deploy only one AD FS server, create an A record that points to the name of the federation server. If you deploy a federation server farm, create an A record that points to the IP address of a load balancer for the federation server farm. The same holds true if you deploy a Web Application Proxy server or farm – create an A record that points to the IP address of the Web Application Proxy server or to the external IP address of the load balancer for the Web Application Proxy server farm.  
  
##### To create an A or AAAA \(Host\) record for the AD FS federation service name  
  
1.  Log on to a DNS server using an account that has permission to create resource records in the DNS zone, such as DNS administrator or if you have deployed Active Directory\-integrated DNS, a Domain Admin.  
  
2.  In **Server Manager**, click **Tools**, and then click **DNS**.  
  
3.  Expand the name of the DNS server, expand **Forward Lookup Zones**, right\-click the name of the zone \(for example, contoso.com\) where you want to create the record, and click **New Host \(A or AAAA\)**.  
  
4.  In **Name**, type the single\-label name of the AD FS services. For example, if the service is named FS.contoso.com, type **FS1**.  
  
5.  In **IP address**, type the IP address for the federation server or load balancer, for example, 192.168.1.4.  
  
6.  Click **Add Host**.  
  
### Create CNAME record for the Device Registration Service  
A CNAME record is required in order to enable name resolution for the Device Registration Service \(DRS\). A CNAME record is used as an alias for another type of record in DNS. The CNAME record helps DNS clients query for a service by its friendly name rather than by the fully qualified domain name of the host. The CNAME record for the DRS should use enterpriseregistration for the alias name and point to the name of the Host A or AAAA record created above for the federation service.  
  
##### To create a CNAME record for DRS  
  
1.  Log on to a DNS server using an account that has permission to create resource records in the DNS zone, such as DNS administrator or if you have deployed Active Directory\-integrated DNS, a Domain Admin.  
  
2.  In **Server Manager**, click **Tools**, and then click **DNS**.  
  
3.  Expand the name of the DNS server, expand **Forward Lookup Zones**, right\-click the name of the zone \(for example, contoso.com\) where you want to create the record, and click **New Alias \(CNAME\)**.  
  
4.  Under **Alias name:**, type **enterpriseregistration**.  
  
5.  Under **Fully qualified domain name \(FQDN\) for target host:**, type the FQDN of the Host A or AAAA record that you created for the federation server or service. For example, type **fs.contoso.com**.  
  
6.  Click **OK**.  
  
### Verify federation service name resolution  
After you create the DNS records, at a standard command line, type **ipconfig \/flushdns** to clear the DNS cache on each server and client. Then validate name resolution for the federation service and the IP address by using the following procedure.  
  
##### To verify federation service name resolution  
  
1.  Open a browser window and in the address bar, type the federation service name, and then append it with **federationmetadata\/2007\-06\/federationmetadata.xml** to browse to the federation service metadata endpoint. For example:  
  
    ```  
    https://fs.contoso.com/federationmetadata/2007-06/federationmetadata.xml  
    ```  
  
    You should see the federation server metadata.  If you have not imported the root CA certificate of your SSL certificate into the local computer trusted root certificates store on your client computer, you may see an SSL error or warning.  
  
2.  You can also browse to the AD FS sign\-in page \(your federation service name appended with **adfs\/ls\/idpinitiatedsignon.htm**. For example:  
  
    ```  
    https://fs.contoso.com/adfs/ls/idpinitiatedsignon.htm  
    ```  
  
    This displays the AD FS sign\-in page where you can sign in with domain administrator credentials.  
  
    > [!IMPORTANT]  
    > Make sure to configure your browser settings to trust the federation server role by adding your federation service name \(for example, **https:\/\/fs.contoso.com**\) to the browser’s local intranet zone.  This will enable seamless sign\-in using Windows Integrated Authentication.  
  
## <a name="BKMK_AddNodesToFarm"></a>Adding nodes to the farm  
You can add nodes to the AD FS farm by installing AD FS on additional servers in the domain. Adding nodes to the farm provides redundancy and fault tolerance to the AD FS deployment, and allows for load balancing client service requests.  
  
To add nodes to an existing farm, choose Add a federation server to a federation server farm on the Welcome page of the Active Directory Federation Services Configuration Wizard, or use the Add\-AdfsFarmNode Windows PowerShell cmdlet.  
  
After you add nodes to a farm, you should install a load balancer such as Network Load Balancing in Windows Server and create a Host record that maps the name of the load balancer to its IP address.  
  
For more information about adding nodes to the farm, see [How to deploy AD FS in Windows Server 2012 R2](assetId:///dccc483a-4df5-49bd-bc7a-39b6d42cee4c).  
  
## <a name="BKMK_AddWebAppProxy"></a>Adding a Web Application Proxy  
The Web Application Proxy can provide access to web applications from extranet clients using AD FS claims\-based authentication or Windows Integrated Authentication. The Web Application Proxy can be used in conjunction with Active Directory workplace join, multifactor authentication, or multifactor access control in order to enable more flexible and manageable resource access by users and devices outside of a company firewall.  
  
For more information about adding a Web Application Proxy, see [How to deploy AD FS in Windows Server 2012 R2](assetId:///dccc483a-4df5-49bd-bc7a-39b6d42cee4c).  
  
For a feature overview and more information about installing and configuring Web Application proxy, see the following topic:  
  
-   [Connect to Applications and Services from Anywhere with Web Application Proxy](../Topic/Connect-to-Applications-and-Services-from-Anywhere-with-Web-Application-Proxy.md)  
  
## <a name="BKMK_InstallDRS"></a>Enabling Device Registration Service  
To enable the Device Registration Service in the local forest, the following prerequisites must be met:  
  
-   The Active Directory schema must be at [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] level.  
  
-   You need to run Windows PowerShell cmdlets as a member of the Enterprise Admins group in order to enable DRS.  
  
-   The group managed service account that was specified for the AD FS configuration must be specified for the value of the **–ServiceAccountName** parameter in the format *domain*\\*account\_name*.  
  
For specific information about how to enable DRS after deploying AD FS in a forest, see [How to deploy AD FS in Windows Server 2012 R2](assetId:///dccc483a-4df5-49bd-bc7a-39b6d42cee4c).  
  
For a feature overview and more information about installing and configuring DRS, see the following topic:  
  
-   [Join to Workplace from Any Device for SSO and Seamless Second Factor Authentication Across Company Applications](../Topic/Join-to-Workplace-from-Any-Device-for-SSO-and-Seamless-Second-Factor-Authentication-Across-Company-Applications.md)  
  
