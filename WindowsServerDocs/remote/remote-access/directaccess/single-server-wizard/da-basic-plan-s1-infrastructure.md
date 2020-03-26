---
title: Step 1 Plan the Basic DirectAccess Infrastructure
description: This topic is part of the guide Deploy a Single DirectAccess Server Using the Getting Started Wizard for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 
ms.author: lizross
author: eross-msft
---
# Step 1 Plan the Basic DirectAccess Infrastructure
The first step for a basic DirectAccess deployment on a single server is to perform planning for the infrastructure required for the deployment. This topic describes the infrastructure planning steps:  
  
|Task|Description|  
|----|--------|  
|Plan network topology and settings|Decide where to place the DirectAccess server \(at the edge, or behind a Network Address Translation \(NAT\) device or firewall\), and plan IP addressing and routing.|  
|Plan firewall requirements|Plan for allowing DirectAccess through edge firewalls.|  
|Plan certificate requirements|DirectAccess can use Kerberos or certificates for client authentication. In this basic DirectAccess deployment a Kerberos Proxy is automatically configured and authentication is accomplished using Active Directory credentials.|  
|Plan DNS requirements|Plan DNS settings for the DirectAccess server, infrastructure servers, and client connectivity.|  
|Plan Active Directory|Plan your domain controllers and Active Directory requirements.|  
|Plan Group Policy Objects|Decide what GPOs are required in your organization and how to create or edit the GPOs.|  
  
The planning tasks do not need to be done in a specific order.  
  
## <a name="bkmk_1_1_Network_svr_top_settings"></a>Plan network topology and settings  
  
### Plan network adapters and IP addressing  
  
1.  Identify the network adapter topology you want to use. DirectAccess can be set up with either of the following:  
  
    -   With two network adapters - Either at the edge with one network adapter connected to the Internet and the other to the internal network, or behind a NAT, firewall, or router device, with one network adapter connected to a perimeter network and the other to the internal network.  
  
    -   Behind a NAT device with one network adapter - The DirectAccess server is installed behind a NAT device, and the single network adapter is connected to the internal network.  
  
2.  Identity your IP addressing requirements:  
  
    DirectAccess uses IPv6 with IPsec to create a secure connection between DirectAccess client computers and the internal corporate network. However, DirectAccess does not necessarily require connectivity to the IPv6 Internet or native IPv6 support on internal networks. Instead, it automatically configures and uses IPv6 transition technologies to tunnel IPv6 traffic across the IPv4 Internet \(6to4, Teredo, IP\-HTTPS\) and across your IPv4\-only intranet \(NAT64 or ISATAP\). For an overview of these transition technologies, see the following resources:  
  
    -   [IPv6 Transition Technologies](https://technet.microsoft.com/library/bb726951.aspx)  
  
    -   [IP-HTTPS Tunneling Protocol Specification](https://msdn.microsoft.com/library/dd358571(PROT.10).aspx)  
  
3.  Configure required adapters and addressing according to the following table. For deployments behind a NAT device using a single network adapter, configure your IP addresses using only the **Internal network adapter** column.  
  
    ||External network adapter|Internal network adapter<sup>1</sup>|Routing requirements|  
    |-|--------------|--------------------|------------|  
    |IPv4 intranet and IPv4 Internet|Configure the following:<br /><br />-   One static public IPv4 address with the appropriate subnet mask.<br />-   A default gateway IPv4 address of your Internet firewall or local Internet service provider \(ISP\) router.|Configure the following:<br /><br />-   An IPv4 intranet address with the appropriate subnet mask.<br />-   A connection\-specific DNS suffix of your intranet namespace. A DNS server must also be configured on the internal interface.<br />-   Do not configure a default gateway on any intranet interfaces.|To configure the DirectAccess server to reach all subnets on the internal IPv4 network do the following:<br /><br />1.  List the IPv4 address spaces for all the locations on your intranet.<br />2.  Use the **route add \-p** or **netsh interface ipv4 add route** commands to add the IPv4 address spaces as static routes in the IPv4 routing table of the DirectAccess server.|  
    |IPv6 Internet and IPv6 intranet|Configure the following:<br /><br />-   Use the autoconfigured address configuration provided by your ISP.<br />-   Use the **route print** command to ensure that a default IPv6 route pointing to the ISP router exists in the IPv6 routing table.<br />-   Determine whether the ISP and intranet routers are using default router preferences described in RFC 4191, and using a higher default preference than your local intranet routers. If both of these are true, no other configuration for the default route is required. The higher preference for the ISP router ensures that the active default IPv6 route of the DirectAccess server points to the IPv6 Internet.<br /><br />Because the DirectAccess server is an IPv6 router, if you have a native IPv6 infrastructure, the Internet interface can also reach the domain controllers on the intranet. In this case, add packet filters to the domain controller in the perimeter network that prevent connectivity to the IPv6 address of the Internet\-facing interface of the DirectAccess server.|Configure the following:<br /><br />-   If you are not using default preference levels, configure your intranet interfaces with the **netsh interface ipv6 set InterfaceIndex ignoredefaultroutes\=enabled** command. This command ensures that additional default routes pointing to intranet routers will not be added to the IPv6 routing table. You can obtain the InterfaceIndex of your intranet interfaces from the display of the netsh interface show interface command.|If you have an IPv6 intranet, to configure the DirectAccess server to reach all of the IPv6 locations, do the following:<br /><br />1.  List the IPv6 address spaces for all the locations on your intranet.<br />2.  Use the **netsh interface ipv6 add route** command to add the IPv6 address spaces as static routes in the IPv6 routing table of the DirectAccess server.|  
    |IPv4 Internet and IPv6 intranet|The DirectAccess server forwards default IPv6 route traffic using the Microsoft 6to4 Adapter interface to a 6to4 relay on the IPv4 Internet. You can configure a DirectAccess server for the IPv4 address of the Microsoft 6to4 relay on the IPv4 Internet \(used when native IPv6 is not deployed in the corporate network\) with the following command : netsh interface ipv6 6to4 set relay name\=192.88.99.1 state\=enabled command.|||  
  
    > [!NOTE]  
    > Note the following:  
    >   
    > 1.  If the DirectAccess client has been assigned a public IPv4 address, it will use the 6to4 transition technology to connect to the intranet. If the DirectAccess client cannot connect to the DirectAccess server with 6to4, it will use IP\-HTTPS.  
    > 2.  Native IPv6 client computers can connect to the DirectAccess server over native IPv6, and no transition technology is required.  
  
### <a name="ConfigFirewalls"></a>Plan firewall requirements  
If the DirectAccess server is behind an edge firewall, the following exceptions will be required for DirectAccess traffic when the DirectAccess server is on the IPv4 Internet:  
  
-   6to4 traffic - IP Protocol 41 inbound and outbound.  
  
-   IP\-HTTPS-Transmission Control Protocol \(TCP\) destination port 443, and TCP source port 443 outbound.  
  
-   If you are deploying DirectAccess with a single network adapter, and installing the network location server on the DirectAccess server, TCP port 62000 should also be exempted.  
  
    > [!NOTE]  
    > This exemption is on the DirectAccess server. All the other exceptions are on the edge firewall.  
  
The following exceptions will be required for DirectAccess traffic when the DirectAccess server is on the IPv6 Internet:  
  
-   IP Protocol 50  
  
-   UDP destination port 500 inbound, and UDP source port 500 outbound.  
  
When using additional firewalls, apply the following internal network firewall exceptions for DirectAccess traffic:  
  
-   ISATAP - Protocol 41 inbound and outbound  
  
-   TCP\/UDP for all IPv4\/IPv6 traffic  
  
### <a name="bkmk_1_2_CAs_and_certs"></a>Plan certificate requirements  
Certificate requirements for IPsec include a computer certificate used by DirectAccess client computers when establishing the IPsec connection between the client and the DirectAccess server, and a computer certificate used by DirectAccess servers to establish IPsec connections with DirectAccess clients. For DirectAccess in Windows Server 2012 R2 and Windows Server 2012, the use of these IPsec certificates is not mandatory. The Getting Started Wizard configures the DirectAccess server to act as a Kerberos proxy to perform IPsec authentication without requiring certificates.
  
1.  **IP\-HTTPS server**. When you configure DirectAccess, the DirectAccess server is automatically configured to act as the IP\-HTTPS web listener. The IP\-HTTPS site requires a website certificate, and client computers must be able to contact the certificate revocation list \(CRL\) site for the certificate. The Enable DirectAccess wizard tries to use the SSTP VPN certificate. If SSTP is not configured, it checks if a certificate for IP\-HTTPS is present in the machine personal store. If none is available, it automatically creates a self\-signed certificate.
  
2.  **Network location server**. The network location server is a website used to detect whether client computers are located in the corporate network. The network location server requires a web site certificate. DirectAccess clients must be able to contact the CRL site for the certificate. The Enable Remote Access wizard checks if a certificate for Network Location Server is present in  the machine personal store. If not present, it automatically creates a self\-signed certificate.
  
The certification requirements for each of these are summarized in the following table:  
  
|IPsec authentication|IP\-HTTPS server|Network location server|  
|------------|----------|--------------|  
|An internal CA is required to issue computer certificates to the DirectAccess server and clients for IPsec authentication when you don't use the Kerberos proxy for authentication|Public CA - It is recommended to use a public CA to issue the IP\-HTTPS certificate, this ensures that the CRL distribution point is available externally.|Internal CA - You can use an internal CA to issue the network location server website certificate. Make sure that the CRL distribution point is highly available from the internal network.|  
||Internal CA - You can use an internal CA to issue the IP\-HTTPS certificate; however, you must make sure that the CRL distribution point is available externally.|Self\-signed certificate - You can use a self\-signed certificate for the network location server website; however, you cannot use a self\-signed certificate in multisite deployments.|  
||Self\-signed certificate - You can use a self\-signed certificate for the IP\-HTTPS server; however, you must make sure that the CRL distribution point is available externally. A self\-signed certificate cannot be used in a multisite deployment.||  
  
#### <a name="bkmk_website_cert_IPHTTPS"></a>Plan certificates for IP\-HTTPS and network location server  
If you want to provision a certificate for these purposes, refer to [Deploy a Single DirectAccess Server with Advanced Settings](../single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md). If no certificates are available, the Getting Started wizard automatically creates self\-signed certificates for these purposes.
  
> [!NOTE]
> If you provision certificates for IP\-HTTPS and the network location server manually, ensure that the certificates have a subject name. If the certificate does not have a subject name, but does have an alternative name, it will not be accepted by the DirectAccess wizard.  
  
#### Plan DNS requirements  
In a DirectAccess deployment, DNS is required for the following:  
  
-   **DirectAccess client requests**. DNS is used to resolve requests from DirectAccess client computers that are not located on the internal network. DirectAccess clients attempt to connect to the DirectAccess network location server in order to determine whether they are located on the Internet, or on the corporate network: If the connection is successful, then clients are determined to be on the intranet and DirectAccess is not used, and client requests are resolved using the DNS server configured on the network adapter of the client computer. If the connection does not succeed, clients are assumed to be on the Internet. DirectAccess clients will use the name resolution policy table \(NRPT\) to determine which DNS server to use when resolving name requests. You can specify that clients should use DirectAccess DNS64 to resolve names, or an alternative internal DNS server. When performing name resolution, the NRPT is used by DirectAccess clients to identify how to handle a request. Clients request an FQDN or single\-label name such as http:\/\/internal. If a single\-label name is requests, a DNS suffix is appended to make an FQDN. If the DNS query matches an entry in the NRPT, and DNS4 or an intranet DNS server is specified for the entry, then the query is sent for name resolution using the specified server. If a match exists but no DNS server is specified, then this indicates an exemption rule and normal name resolution is applied.  
  
    When a new suffix is added to the NRPT in the DirectAccess Management console, the default DNS servers for the suffix can be automatically discovered by clicking the **Detect** button. Auto detection works as follows:  
  
    1.  If the corporate network is IPv4\-based, or IPv4 and IPv6, the default address is the DNS64 address of the internal adapter on the DirectAccess server.  
  
    2.  If the corporate network is IPv6\-based, the default address is the IPv6 address of DNS servers in the corporate network.  
  
-   **Infrastructure servers**
  
    1.  **Network location server**. DirectAccess clients attempt to reach the network location server to determine if they are on the internal network. Clients on the internal network must be able to resolve the name of the network location server, but must be prevented from resolving the name when they are located on the Internet. To ensure this occurs, by default, the FQDN of the network location server is added as an exemption rule to the NRPT. In addition, when you configure DirectAccess, the following rules are created automatically:  
  
        1.  A DNS suffix rule for root domain or the domain name of the DirectAccess server, and the IPv6 addresses corresponding to the intranet DNS servers configured on the DirectAccess server. For example, if the DirectAccess server is a member of the corp.contoso.com domain, a rule is created for the corp.contoso.com DNS suffix.  
  
        2.  An exemption rule for the FQDN of the network location server. For example, if the network location server URL is https:\/\/nls.corp.contoso.com, an exemption rule is created for the FQDN nls.corp.contoso.com.  
  
        **IP\-HTTPS server**. The DirectAccess server acts as an IP\-HTTPS listener and uses its server certificate to authenticate to IP\-HTTPS clients. The IP\-HTTPS name must be resolvable by DirectAccess clients using public DNS servers.  
  
        **Connectivity verifiers**. DirectAccess creates a default web probe that is used by DirectAccess client computers use to verify connectivity to the internal network. To ensure the probe works as expected the following names must be registered manually in DNS:  
  
        1.  directaccess\-webprobehost - should resolve to the internal IPv4 address of the DirectAccess server, or to the IPv6 address in an IPv6\-only environment.  
  
        2.  directaccess\-corpconnectivityhost - should resolve to localhost \(loopback\) address. A and AAAA record should be created, A record with value 127.0.0.1 and AAAA record with value constructed out of NAT64 prefix with the last 32 bits as 127.0.0.1. The NAT64 prefix can be retrieved by running the cmdlet get\-netnattransitionconfiguration.  
  
        You can create additional connectivity verifiers using other web addresses over HTTP or PING. For each connectivity verifier, a DNS entry must exist.  
  
#### DNS server requirements  
  
-   For DirectAccess clients, you must use a DNS server that is running Windows Server 2008, Windows Server 2008 R2, Windows Server 2012, Windows Server 2012 R2,  Windows Server 2016, or any DNS server that supports IPv6.  
  
> [!NOTE]  
> It is not recommended that you use DNS servers that are running Windows Server 2003 when you are deploying DirectAccess. Although Windows Server 2003 DNS servers do support IPv6 records, Windows Server 2003 is no longer supported by Microsoft. In addition, you should not deploy DirectAccess if your domain controllers are running Windows Server 2003 due to an issue with the File Replication Service. For more information, see [DirectAccess Unsupported Configurations](../DirectAccess-Unsupported-Configurations.md).  
  
### <a name="bkmk_1_4_NLS"></a>Plan the network location server  
The network location server is a website used to detect whether DirectAccess clients are located in the corporate network. Clients in the corporate network do not use DirectAccess to reach internal resources, but instead connect directly.  
  
The Getting Started Wizard automatically sets up network location server on the DirectAccess server and the website is created automatically when you deploy DirectAccess. This allows for a simple installation without the use of a certificate infrastructure.
  
If you want to deploy a Network Location Server and not use self\-signed certificates, refer to [Deploy a Single DirectAccess Server with Advanced Settings](../single-server-advanced/Deploy-a-Single-DirectAccess-Server-with-Advanced-Settings.md).
  
### <a name="bkmk_1_6_AD"></a>Plan Active Directory  
DirectAccess uses Active Directory and Active Directory Group policy objects as follows:
  
-   **Authentication**. Active Directory is used for authentication. The DirectAccess tunnel uses Kerberos authentication for the user to access internal resources.
  
-   **Group policy objects**. DirectAccess gathers configuration settings into group policy objects that are applied to DirectAccess servers, and clients.
  
-   **Security groups**. DirectAccess uses security groups to gather together and identify DirectAccess client computers, and DirectAccess servers. The group policies are applied to the required security group.

**Active Directory Requirements**  
  
When planning Active Directory for a DirectAccess deployment, the following is required:  
  
-   At least one domain controller installed on  Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008. 
  
    If the domain controller is on a perimeter network \(and therefore reachable from the Internet\-facing network adapter of DirectAccess server\) prevent the DirectAccess server from reaching it by adding packet filters on the domain controller, to prevent connectivity to the IP address of the Internet adapter.  
  
-   The DirectAccess server must be a domain member.  
  
-   DirectAccess clients must be domain members. Clients can belong to:  
  
    -   Any domain in the same forest as the DirectAccess server.  
  
    -   Any domain that has a two\-way trust with the DirectAccess server domain.  
  
    -   Any domain in a forest that has a two\-way trust with the forest to which the DirectAccess domain belongs.  
  
> [!NOTE]
> - The DirectAccess server cannot be a domain controller.  
> - The Active Directory domain controller used for DirectAccess must not be reachable from the external Internet adapter of the DirectAccess server \(the adapter must not be in the domain profile of Windows Firewall\).  
  
### <a name="bkmk_1_7_GPOs"></a>Plan Group Policy Objects  
DirectAccess settings configured when you configure DirectAccess are collected into Group policy objects \(GPO\). Two different GPOs are populated with DirectAccess settings, and distributed as follows:  
  
-   **DirectAccess client GPO**. This GPO contains client settings, including IPv6 transition technology settings, NRPT entries, and Windows Firewall with Advanced Security connection security rules. The GPO is applied to the security groups specified for the client computers.  
  
-   **DirectAccess server GPO**. This GPO contains the DirectAccess configuration settings that are applied to any server configured as a DirectAccess server in your deployment. It also contains Windows Firewall with Advanced Security connection security rules.  
  
GPOs can be configured in two ways:  
  
1.  **Automatically**. You can specify that they are created automatically. A default name is specified for each GPO. GPOs are created automatically by the Getting Started Wizard.
  
2.  **Manually**. You can use GPOs that have been predefined by the Active Directory        administrator.
  
Note that once DirectAccess is configured to use specific GPOs, it cannot be configured to use different GPOs.
  
> [!IMPORTANT]
> Whether you are using automatically or manually configured GPOs, you will need to add a policy for slow link detection if your clients will use 3G. The Group Policy path for **Policy: Configure Group Policy slow link detection** is: **Computer configuration \/ Polices \/ Administrative Templates \/ System \/ Group Policy**.  
  
> [!CAUTION]  
> Use the following procedure to backup all DirectAccess Group Policy Objects before executing DirectAccess cmdlets: [Back up and Restore DirectAccess Configuration](https://go.microsoft.com/fwlink/?LinkID=257928)  
  
#### Automatically\-created GPOs  
Note the following when using automatically\-created GPOs:  
  
Automatically created GPOS are applied according to the location and link target parameter, as follows:  
  
-   For the DirectAccess server GPO, both the location and link parameters point to the domain containing the DirectAccess server.  
  
-   When client GPOs are created, the location is set to a single domain in which the GPO will be created. The GPO name is looked up in each domain, and filled with DirectAccess settings if it exists. The link target is set to the root of the domain in which the GPO was created. A GPO is created for each domain that contains client computers, and the GPO is linked to the root of its respective domain.  
  
When using automatically created GPOs, to apply DirectAccess settings, the DirectAccess server administrator requires the following permissions:  
  
-   GPO create permissions for each domain.  
  
-   Link permissions for all the selected client domain roots.  
  
-   Link permissions for the server GPO domain roots.  
  
-   Create, edit, delete, and modify security permissions are required for the GPOs.  
  
-   It is recommended that the DirectAccess administrator has GPO read permissions for each required domain. This enables DirectAccess to verify that GPOs with duplicate names do not exist when creating GPOs.  
  
Note that if the correct permissions for linking GPOs do not exist, a warning is issued. The DirectAccess operation will continue but linking will not occur. If this warning is issued links will not be created automatically, even after the permissions are added later. Instead the administrator will need to create the links manually.  
  
#### Manually\-created GPOs  
Note the following when using manually\-created GPOs:  
  
-   The GPOs should exist before running the Remote Access Getting Started wizard.  
  
-   When using manually\-created GPOs, to apply DirectAccess settings the DirectAccess administrator requires full GPO permissions \(Edit, Delete, Modify security\) on the manually\-created GPOs.  
  
-   When using manually created GPOs a search is made for a link to the GPO in the entire domain. If the GPO is not linked in the domain then a link is automatically created in the domain root. If the required permissions to create the link are not available a warning is issued.  
  
Note that if the correct permissions for linking GPOs do not exist, a warning is issued. The DirectAccess operation will continue but linking will not occur. If this warning is issued links will not be created automatically, even when the permissions are added later. Instead the administrator will need to create the links manually.  
  
#### Recovering from a deleted GPO  
If a DirectAccess server, client, or application server GPO has been deleted by accident and there is no backup available, you must remove the configuration settings and re\-configure again. If a backup is available, you can restore the GPO from the backup.  
  
**DirectAccess Management** will display the following error message: **GPO <GPO name> cannot be found**. To remove the configuration settings, take the following steps:  
  
1.  Run the PowerShell cmdlet **Uninstall\-remoteaccess**.  
  
2.  Re\-open **DirectAccess Management**.  
  
3.  You will see an error message that the GPO is not found. Click **Remove configuration settings**. After completion, the server will be restored to an un\-configured state.  
  
### <a name="BKMK_Links"></a>Next step  
  
-   [Step 2: Plan the Basic DirectAccess Deployment](da-basic-plan-s2-deployment.md)  
  
