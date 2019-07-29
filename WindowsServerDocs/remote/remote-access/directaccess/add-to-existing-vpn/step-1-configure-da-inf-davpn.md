---
title: Step 1 Configure the DirectAccess Infrastructure
description: This topic is part of the guide Add DirectAccess to an Existing Remote Access (VPN) Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5dc529f7-7bc3-48dd-b83d-92a09e4055c4
ms.author: pashort
author: shortpatti
---
# Step 1 Configure the DirectAccess Infrastructure

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes how to configure the infrastructure required for enabling DirectAccess in an existing VPN deployment. Before beginning the deployment steps, ensure that you have completed the planning steps described in [Step 1: Plan DirectAccess Infrastructure](Step-1-Plan-DirectAccess-Infrastructure.md).  
  
|Task|Description|  
|----|--------|  
|Configure server network settings|Configure the server network settings on the Remote Access server.|  
|Configure routing in the corporate network|Configure routing in the corporate network to make sure traffic is appropriately routed.|  
|Configure firewalls|Configure additional firewalls, if required.|  
|Configure CAs and certificates|The Enable DirectAccess Wizard configures a built in Kerberos proxy that authenticates using user names and passwords. It also configures an IP-HTTPS certificate on the Remote Access server.|  
|Configure the DNS server|Configure DNS settings for the Remote Access server.|  
|Configure Active Directory|Join client computers to the Active Directory domain.|  
|Configure GPOs|Configure GPOs for the deployment, if required.|  
|Configure security groups|Configure security groups that will contain DirectAccess client computers, and any other security groups required in the deployment.|  
|Configure the network location server|The Enable DirectAccess Wizard configures the network location server on the DirectAccess server.|  
  
## <a name="ConfigNetworkSettings"></a>Configure server network settings  
The following network interface settings are required for a single server deployment in an environment with IPv4 and IPv6. All IP addresses are configured by using **Change adapter settings** in the **Windows Networking and Sharing Center**.  
  
-   Edge topology  
  
    -   One Internet-facing public static IPv4 or IPv6 address.  
  
    -   A single internal static IPv4 or IPv6 address.  
  
-   Behind NAT device (two network adapters)  
  
    -   A single internal network-facing static IPv4 or IPv6 address.  
  
-   Behind NAT device (one network adapter)  
  
    -   A single static IPv4 or IPv6 address.  
  
> [!NOTE]  
> In the event that the Remote Access server has two network adapters (one classified in the domain profile and the other in a public/private profile), but a single NIC topology will be used, then the recommendation is as follows:  
>   
> 1.  Ensure that the 2nd NIC is also classified in the domain profile - Recommended.  
> 2.  If the 2nd NIC cannot be configured for the domain profile for any reason, then the DirectAccess IPsec policy must be manually scoped to all profiles using the following Windows PowerShell commands:  
>   
>     ```  
>     $gposession = Open-NetGPO -PolicyStore <Name of the server GPO>  
>     Set-NetIPsecRule -DisplayName <Name of the IPsec policy> -GPOSession $gposession -Profile Any  
>     Save-NetGPO -GPOSession $gposession  
>     ```  
  
## <a name="ConfigRouting"></a>Configure routing in the corporate network  
Configure routing in the corporate network as follows:  
  
-   When native IPv6 is deployed in the organization, add a route so that the routers on the internal network route IPv6 traffic back through the Remote Access server.  
  
-   Manually configure organization IPv4 and IPv6 routes on the Remote Access servers. Add a published route so that all traffic with an organization (/48) IPv6 prefix is forwarded to the internal network. In addition, for IPv4 traffic, add explicit routes so that IPv4 traffic is forwarded to the internal network.  
  
## <a name="ConfigFirewalls"></a>Configure firewalls  
When using additional firewalls in your deployment, apply the following Internet-facing firewall exceptions for Remote Access traffic when the Remote Access server is on the IPv4 Internet:  
  
-   6to4 traffic-IP Protocol 41 inbound and outbound.  
  
-   IP-HTTPS-Transmission Control Protocol (TCP) destination port 443, and TCP source port 443 outbound. When the Remote Access server has a single network adapter, and the network location server is on the Remote Access server, then TCP port 62000 is also required.  
  
When using additional firewalls, apply the following Internet-facing firewall exceptions for Remote Access traffic when the Remote Access server is on the IPv6 Internet:  
  
-   IP Protocol 50  
  
-   UDP destination port 500 inbound, and UDP source port 500 outbound.  
  
When using additional firewalls, apply the following internal network firewall exceptions for Remote Access traffic:  
  
-   ISATAP-Protocol 41 inbound and outbound  
  
-   TCP/UDP for all IPv4/IPv6 traffic  
  
## <a name="ConfigCAs"></a>Configure CAs and certificates  
The Enable DirectAccess Wizard configures a built in Kerberos proxy that authenticates using user names and passwords. It also configures an IP-HTTPS certificate on the Remote Access server.  
  
### <a name="ConfigCertTemp"></a>Configure certificate templates  
When you use an internal CA to issue certificates, you must configure a certificate template for the IP-HTTPS certificate and the network location server website certificate.  
  
##### To configure a certificate template  
  
1.  On the internal CA, create a certificate template as described in [Creating Certificate Templates](https://technet.microsoft.com/library/cc731705.aspx).  
  
2.  Deploy the certificate template as described in [Deploying Certificate Templates](https://technet.microsoft.com/library/cc770794.aspx).  
  
### Configure the IP-HTTPS certificate  
Remote Access requires an IP-HTTPS certificate to authenticate IP-HTTPS connections to the Remote Access server. There are three certificate options for the IP-HTTPS certificate:  
  
-   **Public**-Supplied by a 3rd party.  
  
    A certificate used for IP-HTTPS authentication. In the case that the certificate subject name is not a wild card, then it must be the externally resolvable FQDN URL used only for the Remote Access server IP-HTTPS connections.  
  
-   **Private**-The following are required, if they do not already exist:  
  
    -   A website certificate used for IP-HTTPS authentication. The certificate subject should be an externally resolvable fully qualified domain name (FQDN) reachable from the Internet.  
  
    -   A certificate revocation list (CRL) distribution point that is reachable from a publicly resolvable FQDN.  
  
-   **Self-signed**-The following are required, if they do not already exist:  
  
    > [!NOTE]  
    > Self-signed certificates cannot be used in multisite deployments.  
  
    -   A website certificate used for IP-HTTPS authentication. The certificate subject should be an externally resolvable FQDN reachable from the Internet.  
  
    -   A CRL distribution point that is reachable from a publicly resolvable fully qualified domain name (FQDN).  
  
Make sure that the website certificate used for IP-HTTPS authentication meets the following requirements:  
  
-   The common name of the certificate should match the name of the IP-HTTPS site.  
  
-   In the subject field, specify either the IPv4 address of the external-facing adapter of the Remote Access server, or the FQDN of the IP-HTTPS URL.  
  
-   For the Enhanced Key Usage field, use the Server Authentication object identifier (OID).  
  
-   For the CRL Distribution Points field, specify a CRL distribution point that is accessible by DirectAccess clients that are connected to the Internet.  
  
-   The IP-HTTPS certificate must have a private key.  
  
-   The IP-HTTPS certificate must be imported directly into the personal store.  
  
-   IP-HTTPS certificates can have wildcards in the name.  
  
##### To install the IP-HTTPS certificate from an internal CA  
  
1.  On the Remote Access server: On the **Start** screen, type**mmc.exe**, and then press ENTER.  
  
2.  In the MMC console, on the **File** menu, click **Add/Remove Snap-in**.  
  
3.  On the **Add or Remove Snap-ins** dialog box, click **Certificates**, click **Add**, click **Computer account**, click **Next**, click **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the Certificates snap-in, open **Certificates (Local Computer)\Personal\Certificates**.  
  
5.  Right-click **Certificates**, point to **All Tasks**, and then click **Request New Certificate**.  
  
6.  Click **Next** twice.  
  
7.  On the **Request Certificates** page, select the check box for the certificate template, and if required, click **More information is required to enroll for this certificate**.  
  
8.  On the **Certificate Properties** dialog box, on the **Subject** tab, in the **Subject name** area, in **Type**, select **Common Name**.  
  
9. In **Value**, specify either the IPv4 address of the external-facing adapter of the Remote Access server, or the FQDN of the IP-HTTPS URL, and then click **Add**.  
  
10. In the **Alternative name** area, in **Type**, select **DNS**.  
  
11. In **Value**, specify either the IPv4 address of the external-facing adapter of the Remote Access server, or the FQDN of the IP-HTTPS URL, and then click **Add**.  
  
12. On the **General** tab, in **Friendly name**, you can enter a name that will help you identify the certificate.  
  
13. On the **Extensions** tab, next to **Extended Key Usage**, click the arrow, and make sure that Server Authentication is in the **Selected options** list.  
  
14. Click **OK**, click **Enroll**, and then click **Finish**.  
  
15. In the details pane of the Certificates snap-in, verify that new certificate was enrolled with Intended Purposes of Server Authentication.  
  
## <a name="ConfigDNS"></a>Configure the DNS server  
You must manually configure a DNS entry for the network location server website for the internal network in your deployment.  
  
### <a name="NLS_DNS"></a>To create the network location server and web probe DNS records  
  
1.  On the internal network DNS server: On the **Start** screen, type** dnsmgmt.msc**, and then press ENTER.  
  
2.  In the left pane of the **DNS Manager** console, expand the forward lookup zone for your domain. Right click the domain and click **New Host (A or AAAA)**.  
  
3.  On the **New Host** dialog box, in the **Name (uses parent domain name if blank)** box, enter the DNS name for the network location server website (this is the name the DirectAccess clients use to connect to the network location server). In the **IP address** box, enter the IPv4 address of the network location server, and then click **Add Host**. On the **DNS** dialog box, click **OK**.  
  
4.  On the **New Host** dialog box, in the **Name (uses parent domain name if blank)** box, enter the DNS name for the web probe (the name for the default web probe is directaccess-webprobehost). In the **IP address** box, enter the IPv4 address of the web probe, and then click **Add Host**. Repeat this process for directaccess-corpconnectivityhost and any manually created connectivity verifiers. On the **DNS** dialog box, click **OK**.  
  
5.  Click **Done**.  

![Windows PowerShell](../../../media/Step-1-Configure-the-DirectAccess-Infrastructure_3/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Add-DnsServerResourceRecordA -Name <network_location_server_name> -ZoneName <DNS_zone_name> -IPv4Address <network_location_server_IPv4_address>  
Add-DnsServerResourceRecordAAAA -Name <network_location_server_name> -ZoneName <DNS_zone_name> -IPv6Address <network_location_server_IPv6_address>  
```  
  
You must also configure DNS entries for the following:  
  
-   **The IP-HTTPS server**-DirectAccess clients must be able to resolve the DNS name of the Remote Access server from the Internet.  
  
-   **CRL revocation checking**-DirectAccess uses certificate revocation checking for the IP-HTTPS connection between DirectAccess clients and the Remote Access server, and for the HTTPS-based connection between the DirectAccess client and the network location server. In both cases, DirectAccess clients must be able to resolve and access the CRL distribution point location.  
  
## <a name="ConfigAD"></a>Configure Active Directory  
The Remote Access server and all DirectAccess client computers must be joined to an Active Directory domain. DirectAccess client computers must be a member of one of the following domain types:  
  
-   Domains that belong in the same forest as the Remote Access server.  
  
-   Domains that belong to forests with a two-way trust with the Remote Access server forest.  
  
-   Domains that have a two-way domain trust to the Remote Access server domain.  
  
#### To join client computers to the domain  
  
1.  On the **Start** screen, type **explorer.exe**, and then press ENTER.  
  
2.  Right-click the Computer icon, and then click **Properties**.  
  
3.  On the **System** page, click **Advanced system settings**.  
  
4.  On the **System Properties** dialog box, on the **Computer Name** tab, click **Change**.  
  
5.  In **Computer name**, type the name of the computer if you are also changing the computer name when joining the server to the domain. Under **Member of**, click **Domain**, and then type the name of the domain to which you want to join the server; for example, corp.contoso.com, and then click **OK**.  
  
6.  When you are prompted for a user name and password, enter the user name and password of a user with rights to join computers to the domain, and then click **OK**.  
  
7.  When you see a dialog box welcoming you to the domain, click **OK**.  
  
8.  When you are prompted that you must restart the computer, click **OK**.  
  
9. On the **System Properties** dialog box, click Close. Click **Restart Now** when prompted.  
  
![Windows PowerShell](../../../media/Step-1-Configure-the-DirectAccess-Infrastructure_3/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
Note that you must supply domain credentials after entering the Add-Computer command below.  
  
```  
Add-Computer -DomainName <domain_name>  
Restart-Computer  
```  
  
## <a name="ConfigGPOs"></a>Configure GPOs  
To deploy Remote Access, you require a minimum of two Group Policy Objects: one Group Policy Object contains settings for the Remote Access server and one contains settings for DirectAccess client computers. When you configure Remote Access, the wizard automatically creates the required Group Policy Objects. However, if your organization enforces a naming convention, or you do not have the required permissions to create or edit Group Policy Objects, they must be created prior to configuring Remote Access.  
  
To create Group Policy Objects, see [Create and Edit a Group Policy Object](https://technet.microsoft.com/library/cc754740.aspx).  
  
> [!IMPORTANT]  
> The administrator can manually link the DirectAccess Group Policy Objects to an Organizational Unit using these steps:  
>   
> 1.  Before configuring DirectAccess, link the created GPOs to the respective Organizational Units.  
> 2.  Configure DirectAccess, specifying a security group for the client computers.  
> 3.  The Remote Access administrator may or may not have permissions to link the Group Policy Objects to the domain. In either case, the Group Policy Objects will be configured automatically. If the GPOs are already linked to an OU, the links will not be removed, and the GPOs will not be linked to the domain. For a server GPO, the OU must contain the server computer object, or the GPO will be linked to the root of the domain.  
> 4.  If the linking to the OU has not been done before running the DirectAccess wizard, then after the configuration is complete, the domain administrator can link the DirectAccess Group Policy Objects to the required Organizational Units. The link to the domain can be removed. Steps for linking a Group Policy Object to an Organization Unit can be found [here](https://technet.microsoft.com/library/cc732979.aspx).  
  
> [!NOTE]  
> If a Group Policy Object was created manually, it is possible during the DirectAccess configuration that the Group Policy Object will not be available. The Group Policy Object may not have been replicated to the closest Domain Controller to the management computer. In this event, the administrator can wait for replication to complete, or force the replication.  
  
## <a name="ConfigSGs"></a>Configure security groups  
The DirectAccess settings contained in the client computer Group Policy Object are applied only to computers that are members of the security groups that you specify when configuring Remote Access. In addition, if you are using security groups to manage your application servers, create a security group for these servers.  
  
### <a name="Sec_Group"></a>To create a security group for DirectAccess clients  
  
1.  On the **Start** screen, type**dsa.msc**, and then press ENTER. In the **Active Directory Users and Computers** console, in the left pane, expand the domain that will contain the security group, right-click **Users**, point to **New**, and then click **Group**.  
  
2.  On the **New Object - Group** dialog box, under **Group name**, enter the name for the security group.  
  
3.  Under **Group scope**, click **Global**, under **Group type**, click **Security**, and then click **OK**.  
  
4.  Double-click the DirectAccess client computers security group, and on the properties dialog box, click the **Members** tab.  
  
5.  On the **Members** tab, click **Add**.  
  
6.  On the **Select Users, Contacts, Computers, or Service Accounts** dialog box, select the client computers that you want to enable for DirectAccess, and then click **OK**.  
  
![Windows PowerShell](../../../media/Step-1-Configure-the-DirectAccess-Infrastructure_3/PowerShellLogoSmall.gif)**Windows PowerShell equivalent commands**  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
New-ADGroup -GroupScope global -Name <DirectAccess_clients_group_name>  
Add-ADGroupMember -Identity DirectAccess_clients_group_name -Members <computer_name>  
```  
  
## <a name="ConfigNLS"></a>Configure the network location server  
The network location server should be on a server with high availability, and a valid SSL certificate trusted by the DirectAccess clients. There are two certificate options for the network location server certificate:  
  
-   **Private**-The following are required, if they do not already exist:  
  
    -   A website certificate used for the network location server. The certificate subject should be the URL of the network location server.   
  
    -   A CRL distribution point that is highly available from the internal network.  
  
-   **Self-signed**-The following are required, if they do not already exist:  
  
    > [!NOTE]  
    > Self-signed certificates cannot be used in multisite deployments.  
  
    -   A website certificate used for the network location server. The certificate subject should be the URL of the network location server.  
  
> [!NOTE]  
> If the network location server website is located on the Remote Access server, a website will be created automatically when configuring Remote Access that is bound to the server certificate that you provide.  
  
#### To install the network location server certificate from an internal CA  
  
1.  On the server that will host the network location server website: On the **Start** screen, type**mmc.exe**, and then press ENTER.  
  
2.  In the MMC console, on the **File** menu, click **Add/Remove Snap-in**.  
  
3.  On the **Add or Remove Snap-ins** dialog box, click **Certificates**, click **Add**, click **Computer account**, click **Next**, click **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the Certificates snap-in, open **Certificates (Local Computer)\Personal\Certificates**.  
  
5.  Right-click **Certificates**, point to **All Tasks**, and then click **Request New Certificate**.  
  
6.  Click **Next** twice.  
  
7.  On the **Request Certificates** page, select the check box for the certificate template, and if required, click **More information is required to enroll for this certificate**.  
  
8.  On the **Certificate Properties** dialog box, on the **Subject** tab, in the **Subject name** area, in **Type**, select **Common Name**.  
  
9. In **Value**, enter the FQDN of the network location server website, and then click **Add**.  
  
10. In the **Alternative name** area, in **Type**, select **DNS**.  
  
11. In **Value**, enter the FQDN of the network location server website, and then click **Add**.  
  
12. On the **General** tab, in **Friendly name**, you can enter a name that will help you identify the certificate.  
  
13. Click **OK**, click **Enroll**, and then click **Finish**.  
  
14. In the details pane of the Certificates snap-in, verify that new certificate was enrolled with Intended Purposes of Server Authentication.  
  

  


