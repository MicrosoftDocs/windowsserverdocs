---
title: Step 1 Configure the Remote Access Infrastructure
description: This topic is part of the guide Manage DirectAccess Clients Remotely in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0e7d1f5b-c939-47ca-892f-5bb285027fbc
ms.author: pashort
author: shortpatti
---
# Step 1 Configure the Remote Access Infrastructure

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

**Note:** Windows Server 2012 combines DirectAccess and Routing and Remote Access Service (RRAS) into a single Remote Access role.  
  
This topic describes how to configure the infrastructure that is required for an advanced Remote Access deployment using a single Remote Access server in a mixed IPv4 and IPv6 environment. Before beginning the deployment steps, ensure that you have completed the planning steps described in [Step 1: Plan the Remote Access Infrastructure](../plan/Step-1-Plan-the-Remote-Access-Infrastructure.md).  
  
|Task|Description|  
|----|--------|  
|Configure server network settings|Configure the server network settings on the Remote Access server.|  
|Configure routing in the corporate network|Configure routing in the corporate network to make sure traffic is appropriately routed.|  
|Configure firewalls|Configure additional firewalls, if required.|  
|Configure CAs and certificates|Configure a certification authority (CA), if required, and any other certificate templates required in the deployment.|  
|Configure the DNS server|Configure DNS settings for the Remote Access server.|  
|Configure Active Directory|Join client computers and the Remote Access server to the Active Directory domain.|  
|Configure GPOs|Configure Group Policy Objects (GPOs) for the deployment, if required.|  
|Configure security groups|Configure security groups that will contain DirectAccess client computers, and any other security groups that are required in the deployment.|  
|Configure the network location server|Configure the network location server, including installing the network location server website certificate.|  
  
> [!NOTE]  
> This topic includes sample Windows PowerShell cmdlets that you can use to automate some of the procedures described. For more information, see [Using Cmdlets](https://go.microsoft.com/fwlink/p/?linkid=230693).  
  
## <a name="BKMK_ConfigNetworkSettings"></a>Configure server network settings  
Depending on if you decide to place the Remote Access server at the edge or behind a Network Address Translation (NAT) device, the following network interface address settings are required for a single server deployment in an environment with IPv4 and IPv6. All IP addresses are configured by using **Change adapter settings** in the **Windows Networking and Sharing Center**.  
  
**Edge topology**:  
  
Requires the following:  
  
-   Two Internet-facing consecutive public static IPv4 or IPv6 addresses.  
  
    > [!NOTE]  
    > Two consecutive public IPv4 addresses are required for Teredo. If you are not using Teredo, you can configure a single public static IPv4 address.  
  
-   A single internal static IPv4 or IPv6 address.  
  
**Behind NAT device (two network adapters)**:  
  
Requires a single internal network-facing static IPv4 or IPv6 address.  
  
**Behind NAT device (one network adapter)**:  
  
Requires a single static IPv4 or IPv6 address.  
  
If the Remote Access server has two network adapters (one for the domain profile and the other for a public or private profile), but you are using a single network adapter topology, the recommendation is as follows:  
  
1.  Ensure that the second network adapter is also classified in the domain profile.  
  
2.  If the second network adapter cannot be configured for the domain profile for any reason, the DirectAccess IPsec policy must be manually scoped to all profiles by using the following Windows PowerShell command:  
  
    ```  
    $gposession = Open-NetGPO -PolicyStore <Name of the server GPO>  
    Set-NetIPsecRule -DisplayName <Name of the IPsec policy> -GPOSession $gposession -Profile Any  
    Save-NetGPO -GPOSession $gposession  
    ```  
  
    The names of the IPsec policies to use in this command are **DirectAccess-DaServerToInfra** and **DirectAccess-DaServerToCorp**.  
  
## <a name="BKMK_ConfigRouting"></a>Configure routing in the corporate network  
Configure routing in the corporate network as follows:  
  
-   When native IPv6 is deployed in the organization, add a route so that the routers on the internal network route IPv6 traffic back through the Remote Access server.  
  
-   Manually configure organization IPv4 and IPv6 routes on the Remote Access servers. Add a published route so that all traffic with an (/48) IPv6 prefix is forwarded to the internal network. In addition, for IPv4 traffic, add explicit routes so that IPv4 traffic is forwarded to the internal network.  
  
## <a name="BKMK_ConfigFirewalls"></a>Configure firewalls  
Depending on the network settings you chose, when you use additional firewalls in your deployment, apply the following firewall exceptions for Remote Access traffic:  
  
### Remote Access server on IPv4 Internet  
Apply the following Internet-facing firewall exceptions for Remote Access traffic when the Remote Access server is on the IPv4 Internet:  
  
-   **Teredo traffic**  
  
    User Datagram Protocol (UDP) destination port 3544 inbound, and UDP source port 3544 outbound. Apply this exemption for both of the Internet-facing consecutive public IPv4 addresses on the Remote Access server.  
  
-   **6to4 traffic**  
  
    IP Protocol 41 inbound and outbound. Apply this exemption for both of the Internet-facing consecutive public IPv4 addresses on the Remote Access server.  
  
-   **IP-HTTPS traffic**  
  
    Transmission Control Protocol (TCP) destination port 443, and TCP source port 443 outbound. When the Remote Access server has a single network adapter, and the network location server is on the Remote Access server, then TCP port 62000 is also required. Apply these exemptions only for the address to which the external name of the server resolves.  
  
    > [!NOTE]  
    > This exemption is configured on the Remote Access server. All the other exemptions are configured on the edge firewall.  
  
### Remote Access server on IPv6 Internet  
Apply the following Internet-facing firewall exceptions for Remote Access traffic when the Remote Access server is on the IPv6 Internet:  
  
-   IP Protocol 50  
  
-   UDP destination port 500 inbound, and UDP source port 500 outbound.  
  
-   Internet Control Message Protocol for IPv6 (ICMPv6) traffic inbound and outbound - for Teredo implementations only.  
  
### Remote Access traffic  
Apply the following internal network firewall exceptions for Remote Access traffic:  
  
-   ISATAP: Protocol 41 inbound and outbound  
  
-   TCP/UDP for all IPv4 or IPv6 traffic  
  
-   ICMP for all IPv4 or IPv6 traffic  
  
## <a name="BKMK_ConfigCAs"></a>Configure CAs and certificates  
With Remote Access in  Windows Server 2012 , you to choose between using certificates for computer authentication or using a built-in Kerberos authentication that uses user names and passwords. You must also configure an IP-HTTPS certificate on the Remote Access server. This section explains how to configure these certificates.  
  
For information about setting up a public key infrastructure (PKI), see [Active Directory Certificate Services](https://technet.microsoft.com/library/cc770357.aspx).  
  
### <a name="BKMK_ConfigIPsec"></a>Configure IPsec authentication  
A certificate is required on the Remote Access server and all DirectAccess clients so that they can use IPsec authentication. The certificate must be issued by an internal certification authority (CA). Remote Access servers and DirectAccess clients must trust the CA that issues the root and intermediate certificates.  
  
##### To configure IPsec authentication  
  
1.  On the internal CA, decide if you will use the default computer certificate template, or if you will create a new certificate template as described in [Creating Certificate Templates](https://technet.microsoft.com/library/cc731705.aspx).  
  
    > [!NOTE]  
    > If you create a new template, it must be configured for client authentication.  
  
2.  Deploy the certificate template if required. For more information, see [Deploying Certificate Templates](https://technet.microsoft.com/library/cc770794.aspx).  
  
3.  Configure the template for autoenrollment if required.  
  
4.  Configure certificate autoenrollment if required. For more information, see [Configure Certificate Autoenrollment](https://technet.microsoft.com/library/cc731522.aspx).  
  
### <a name="BKMK_ConfigCertTemp"></a>Configure certificate templates  
When you use an internal CA to issue certificates, you must configure certificate templates for the IP-HTTPS certificate and the network location server website certificate.  
  
##### To configure a certificate template  
  
1.  On the internal CA, create a certificate template as described in [Creating Certificate Templates](https://technet.microsoft.com/library/cc731705.aspx).  
  
2.  Deploy the certificate template as described in [Deploying Certificate Templates](https://technet.microsoft.com/library/cc770794.aspx).  
  
After you prepare your templates, you can use them to configure the certificates. See the following procedures for details:  
  
-   [Configure the IP-HTTPS certificate](#BKMK_IPHTTPS)  
  
-   [Configure the network location server](#BKMK_ConfigNLS)  
  
### <a name="BKMK_IPHTTPS"></a>Configure the IP-HTTPS certificate  
Remote Access requires an IP-HTTPS certificate to authenticate IP-HTTPS connections to the Remote Access server. There are three certificate options for the IP-HTTPS certificate:  
  
-   **Public**  
  
    Supplied by a third party.  
  
-   **Private**  
  
    The certificate is based on the certificate template that you created in [Configuring certificate templates](assetId:///6a5ec5c1-d653-47b1-a567-cc485004e7bc#ConfigCertTemp). It requires, a certificate revocation list (CRL) distribution point that is reachable from a publicly resolvable FQDN.  
  
-   **Self-signed**  
  
    This certificate requires a CRL distribution point that is reachable from a publicly resolvable FQDN.  
  
    > [!NOTE]  
    > Self-signed certificates cannot be used in multisite deployments.  
  
Make sure that the website certificate used for IP-HTTPS authentication meets the following requirements:  
  
-   The certificate subject name should be the externally resolvable fully qualified domain name (FQDN) of the IP-HTTPS URL (the ConnectTo address) that is used only for the Remote Access server IP-HTTPS connections.  
  
-   The common name of the certificate should match the name of the IP-HTTPS site.  
  
-   In the subject field, specify the IPv4 address of the external-facing adapter of the Remote Access server or the FQDN of the IP-HTTPS URL.  
  
-   For the **Enhanced Key Usage** field, use the Server Authentication object identifier (OID).  
  
-   For the **CRL Distribution Points** field, specify a CRL distribution point that is accessible by DirectAccess clients that are connected to the Internet.  
  
-   The IP-HTTPS certificate must have a private key.  
  
-   The IP-HTTPS certificate must be imported directly into the personal store.  
  
-   IP-HTTPS certificates can have wildcard characters in the name.  
  
##### To install the IP-HTTPS certificate from an internal CA  
  
1.  On the Remote Access server: On the **Start** screen, type**mmc.exe**, and then press ENTER.  
  
2.  In the MMC console, on the **File** menu, click **Add/Remove Snap-in**.  
  
3.  In the **Add or Remove Snap-ins** dialog box, click **Certificates**, click **Add**, click **Computer account**, click **Next**, click **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the Certificates snap-in, open **Certificates (Local Computer)\Personal\Certificates**.  
  
5.  Right-click **Certificates**, point to **All Tasks**, click **Request New Certificate**, and then click **Next** twice..  
  
6.  On the **Request Certificates** page, select the check box for the certificate template that you created in Configuring certificate templates, and if required, click **More information is required to enroll for this certificate**.  
  
7.  In the **Certificate Properties** dialog box, on the **Subject** tab, in the **Subject name** area, in **Type**, select **Common Name**.  
  
8.  In **Value**, specify the IPv4 address of the external-facing adapter of the Remote Access server, or the FQDN of the IP-HTTPS URL, and then click **Add**.  
  
9. In the **Alternative name** area, in **Type**, select **DNS**.  
  
10. In **Value**, specify the IPv4 address of the external-facing adapter of the Remote Access server, or the FQDN of the IP-HTTPS URL, and then click **Add**.  
  
11. On the **General** tab, in **Friendly name**, you can enter a name that will help you identify the certificate.  
  
12. On the **Extensions** tab, next to **Extended Key Usage**, click the arrow, and make sure that Server Authentication is in the **Selected options** list.  
  
13. Click **OK**, click **Enroll**, and then click **Finish**.  
  
14. In the details pane of the Certificates snap-in, verify that the new certificate was enrolled with the intended purpose of server authentication.  
  
## <a name="BKMK_ConfigDNS"></a>Configure the DNS server  
You must manually configure a DNS entry for the network location server website for the internal network in your deployment.  
  
### <a name="NLS_DNS"></a>To add the network location server and web probe  
  
1.  On the internal network DNS server: On the **Start** screen, type**dnsmgmt.msc**, and then press ENTER.  
  
2.  In the left pane of the **DNS Manager** console, expand the forward lookup zone for your domain. Right-click the domain, and click **New Host (A or AAAA)**.  
  
3.  In the **New Host** dialog box, in the **Name (uses parent domain name if blank)** box, enter the DNS name for the network location server website (this is the name the DirectAccess clients use to connect to the network location server). In the **IP address** box, enter the IPv4 address of the network location server, and click **Add Host**, and then click **OK**.  
  
4.  In the **New Host** dialog box, in the **Name (uses parent domain name if blank)** box, enter the DNS name for the web probe (the name for the default web probe is directaccess-webprobehost). In the **IP address** box, enter the IPv4 address of the web probe, and then click **Add Host**.  
  
5.  Repeat this process for directaccess-corpconnectivityhost and any manually created connectivity verifiers. In the **DNS** dialog box, click **OK**.  
  
6.  Click **Done**.  
  
![Windows PowerShell](../../../../media/Step-1-Configure-the-Remote-Access-Infrastructure/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
Add-DnsServerResourceRecordA -Name <network_location_server_name> -ZoneName <DNS_zone_name> -IPv4Address <network_location_server_IPv4_address>  
Add-DnsServerResourceRecordAAAA -Name <network_location_server_name> -ZoneName <DNS_zone_name> -IPv6Address <network_location_server_IPv6_address>  
```  
  
You must also configure DNS entries for the following:  
  
-   **The IP-HTTPS server**  
  
    DirectAccess clients must be able to resolve the DNS name of the Remote Access server from the Internet.  
  
-   **CRL revocation checking**  
  
    DirectAccess uses certificate revocation checking for the IP-HTTPS connection between DirectAccess clients and the Remote Access server, and for the HTTPS-based connection between the DirectAccess client and the network location server. In both cases, DirectAccess clients must be able to resolve and access the CRL distribution point location.  
  
-   **ISATAP**  
  
    Intrasite Automatic Tunnel Addressing Protocol (ISATAP) uses tunnels to enable DirectAccess clients to connect to the Remote Access server over the IPv4 Internet, encapsulating IPv6 packets within an IPv4 header. It is used by Remote Access to provide IPv6 connectivity to ISATAP hosts across an intranet. In a non-native IPv6 network environment, the Remote Access server configures itself automatically as an ISATAP router. Resolution support for the ISATAP name is required.  
  
## <a name="BKMK_ConfigAD"></a>Configure Active Directory  
The Remote Access server and all DirectAccess client computers must be joined to an Active Directory domain. DirectAccess client computers must be a member of one of the following domain types:  
  
-   Domains that belong in the same forest as the Remote Access server.  
  
-   Domains that belong to forests with a two-way trust with the Remote Access server forest.  
  
-   Domains that have a two-way domain trust to the Remote Access server domain.  
  
#### To join the Remote Access server to a domain  
  
1.  In Server Manager, click **Local Server**. In the details pane, click the link next to **Computer name**.  
  
2.  In the **System Properties** dialog box, click the **Computer Name** tab, and then click **Change**.  
  
3.  In the **Computer Name** box, type the name of the computer if you are also changing the computer name when joining the server to the domain. Under **Member of**, click **Domain**, and then type the name of the domain to which you want to join the server, (for example, corp.contoso.com), and then click **OK**.  
  
4.  When you are prompted for a user name and password, enter the user name and password of a user with permissions to join computers to the domain, and then click **OK**.  
  
5.  When you see a dialog box welcoming you to the domain, click **OK**.  
  
6.  When you are prompted that you must restart the computer, click **OK**.  
  
7.  In the **System Properties** dialog box, click **Close**.  
  
8.  When you are prompted to restart the computer, click **Restart Now**.  
  
#### To join client computers to the domain  
  
1.  On the **Start** screen, type**explorer.exe**, and then press ENTER.  
  
2.  Right-click the Computer icon, and then click **Properties**.  
  
3.  On the **System** page, click **Advanced system settings**.  
  
4.  In the **System Properties** dialog box, on the **Computer Name** tab, click **Change**.  
  
5.  In the **Computer name** box, type the name of the computer if you are also changing the computer name when joining the server to the domain. Under **Member of**, click **Domain**, and then type the name of the domain to which you want to join the server (for example, corp.contoso.com), and then click **OK**.  
  
6.  When you are prompted for a user name and password, enter the user name and password of a user with permissions to join computers to the domain, and then click **OK**.  
  
7.  When you see a dialog box welcoming you to the domain, click **OK**.  
  
8.  When you are prompted that you must restart the computer, click **OK**.  
  
9. In the **System Properties** dialog box, click Close.  
  
10. Click **Restart Now** when prompted.  
  
![Windows PowerShell](../../../../media/Step-1-Configure-the-Remote-Access-Infrastructure/PowerShellLogoSmall.gif)***<em>Windows PowerShell equivalent commands</em>***  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
> [!NOTE]  
> You must supply domain credentials after you enter the following command.  
  
```  
Add-Computer -DomainName <domain_name>  
Restart-Computer  
```  
  
## <a name="BKMK_ConfigGPOs"></a>Configure GPOs  
To deploy Remote Access, you require a minimum of two Group Policy Objects. One Group Policy Object contains settings for the Remote Access server, and one contains settings for DirectAccess client computers. When you configure Remote Access, the wizard automatically creates the required Group Policy Objects. However, if your organization enforces a naming convention, or you do not have the required permissions to create or edit Group Policy Objects, they must be created prior to configuring Remote Access.  
  
To create Group Policy Objects, see [Create and Edit a Group Policy Object](https://technet.microsoft.com/library/cc754740.aspx).  
  
An administrator can manually link the DirectAccess Group Policy Objects to an organizational unit (OU). Consider the following:  
  
1.  Link the created GPOs to the respective OUs before you configure DirectAccess.  
  
2.  When you configure DirectAccess, specify a security group for the client computers.  
  
3.  The GPOs are configured automatically, regardless of if the administrator has permissions to link the GPOs to the domain.  
  
4.  If the GPOs are already linked to an OU, the links will not be removed, but they are not linked to the domain.  
  
5.  For server GPOs, the OU must contain the server computer object-otherwise, the GPO will be linked to the root of the domain.  
  
6.  If the OU has not been linked previously by running the DirectAccess Setup Wizard, after the configuration is complete, the administrator can link the DirectAccess GPOs to the required OUs, and remove the link to the domain.  
  
    For more information, see [Link a Group Policy Object](https://technet.microsoft.com/library/cc732979.aspx).  
  
> [!NOTE]  
> If a Group Policy Object was created manually, it is possible that the Group Policy Object will not be available during the DirectAccess configuration. The Group Policy Object may not have been replicated to the domain controller closest to the management computer. The administrator can wait for replication to complete or force the replication.  
  
## <a name="BKMK_ConfigSGs"></a>Configure security groups  
The DirectAccess settings that are contained in the client computer Group Policy Object are applied only to computers that are members of the security groups that you specify when configuring Remote Access.  
  
### <a name="Sec_Group"></a>To create a security group for DirectAccess clients  
  
1.  On the **Start** screen, type**dsa.msc**, and then press ENTER.  
  
2.  In the **Active Directory Users and Computers** console, in the left pane, expand the domain that will contain the security group, right-click **Users**, point to **New**, and then click **Group**.  
  
3.  In the **New Object - Group** dialog box, under **Group name**, enter the name for the security group.  
  
4.  Under **Group scope**, click **Global**, and under **Group type**, click **Security**, and then click **OK**.  
  
5.  Double-click the DirectAccess client computers security group, and in the **Properties** dialog box, click the **Members** tab.  
  
6.  On the **Members** tab, click **Add**.  
  
7.  In the **Select Users, Contacts, Computers, or Service Accounts** dialog box, select the client computers that you want to enable for DirectAccess, and then click **OK**.  
  
![Windows PowerShell](../../../../media/Step-1-Configure-the-Remote-Access-Infrastructure/PowerShellLogoSmall.gif)**Windows PowerShell equivalent commands**  
  
The following Windows PowerShell cmdlet or cmdlets perform the same function as the preceding procedure. Enter each cmdlet on a single line, even though they may appear word-wrapped across several lines here because of formatting constraints.  
  
```  
New-ADGroup -GroupScope global -Name <DirectAccess_clients_group_name>  
Add-ADGroupMember -Identity DirectAccess_clients_group_name -Members <computer_name>  
```  
  
## <a name="BKMK_ConfigNLS"></a>Configure the network location server  
The network location server should be on a server with high availability, and it needs a valid Secure Sockets Layer (SSL) certificate that is trusted by the DirectAccess clients.  
  
> [!NOTE]  
> If the network location server website is located on the Remote Access server, a website will be created automatically when you configure Remote Access and it is bound to the server certificate that you provide.  
  
There are two certificate options for the network location server certificate:  
  
-   **Private**  
  
    > [!NOTE]  
    > The certificate is based on the certificate template that you created in [Configuring certificate templates](assetId:///6a5ec5c1-d653-47b1-a567-cc485004e7bc#ConfigCertTemp).  
  
-   **Self-signed**  
  
    > [!NOTE]  
    > Self-signed certificates cannot be used in multisite deployments.  
  
Whether you use a private certificate or a self-signed certificate, they require the following:  
  
-   A website certificate that is used for the network location server. The certificate subject should be the URL of the network location server.  
  
-   A CRL distribution point that has high availability on the internal network.  
  
#### To install the network location server certificate from an internal CA  
  
1.  On the server that will host the network location server website: On the **Start** screen, type**mmc.exe**, and then press ENTER.  
  
2.  In the MMC console, on the **File** menu, click **Add/Remove Snap-in**.  
  
3.  In the **Add or Remove Snap-ins** dialog box, click **Certificates**, click **Add**, click **Computer account**, click **Next**, click **Local computer**, click **Finish**, and then click **OK**.  
  
4.  In the console tree of the Certificates snap-in, open **Certificates (Local Computer)\Personal\Certificates**.  
  
5.  Right-click **Certificates**, point to **All Tasks**, click **Request New Certificate**, and then click **Next** twice.  
  
6.  On the **Request Certificates** page, select the check box for the certificate template that you created in Configuring certificate templates, and if required, click **More information is required to enroll for this certificate**.  
  
7.  In the **Certificate Properties** dialog box, on the **Subject** tab, in the **Subject name** area, in **Type**, select **Common Name**.  
  
8.  In **Value**, enter the FQDN of the network location server website, and then click **Add**.  
  
9. In the **Alternative name** area, in **Type**, select **DNS**.  
  
10. In **Value**, enter the FQDN of the network location server website, and then click **Add**.  
  
11. On the **General** tab, in **Friendly name**, you can enter a name that will help you identify the certificate.  
  
12. Click **OK**, click **Enroll**, and then click **Finish**.  
  
13. In the details pane of the Certificates snap-in, verify that new certificate was enrolled with the intended purpose of server authentication.  
  
#### To configure the network location server  
  
1.  Set up a website on a high availability server. The website does not require any content, but when you test it, you might define a default page that provides a message when clients connect.  
  
    This step is not required if the network location server website is hosted on the Remote Access server.  
  
2.  Bind an HTTPS server certificate to the website. The common name of the certificate should match the name of the network location server site. Ensure that DirectAccess clients trust the issuing CA.  
  
    This step is not required if the network location server website is hosted on the Remote Access server.  
  
3.  Set up a CRL site that hass high availability on the internal network.  
  
    CRL distribution points can be accessed through:  
  
    -   Web servers that use an HTTP-based URL, such as: https://crl.corp.contoso.com/crld/corp-APP1-CA.crl  
  
    -   File servers that are accessed through a universal naming convention (UNC) path, such as \\\crl.corp.contoso.com\crld\corp-APP1-CA.crl  
  
    If the internal CRL distribution point is reachable only over IPv6, you must configure a Windows Firewall with Advanced Security connection security rule. This exempts IPsec protection from the IPv6 address space of your intranet to the IPv6 addresses of your CRL distribution points.  
  
4.  Ensure that DirectAccess clients on the internal network can resolve the name of the network location server, and that DirectAccess clients on the Internet cannot resolve the name.  
  
## <a name="BKMK_Links"></a>See also  
  
-   [Step 2: Configure the Remote Access Server](Step-2-Configure-the-Remote-Access-Server.md)

