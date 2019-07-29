---
title: Step 1 Plan DirectAccess Infrastructure
description: This topic is part of the guide Add DirectAccess to an Existing Remote Access (VPN) Deployment for Windows Server 2016
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-da
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4ca50ea8-6987-4081-acd5-5bf9ead62acd
ms.author: pashort
author: shortpatti
---
# Step 1 Plan DirectAccess Infrastructure

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

The first step of planning for a basic Remote Access deployment on a single server is to perform planning for the infrastructure required for the deployment. This topic describes the infrastructure planning steps:  
  
|Task|Description|  
|----|--------|  
|Plan network topology and settings|Decide where to place the Remote Access server (at the edge, or behind a Network Address Translation (NAT) device or firewall), and plan IP addressing and routing.|  
|Plan firewall requirements|Plan for allowing Remote Access through edge firewalls.|  
|Plan certificate requirements|Remote Access can use Kerberos or certificates for client authentication. In this basic Remote Access deployment, Kerberos is automatically configured and authentication is accomplished using a self-signed certificate issued automatically by the Remote Access server.|  
|Plan DNS requirements|Plan DNS settings for the Remote Access server, infrastructure servers, local name resolution options, and client connectivity.|  
|Plan Active Directory|Plan your domain controllers and Active Directory requirements.|  
|Plan Group Policy Objects|Decide what GPOs are required in your organization and how to create or edit the GPOs.|  
  
The planning tasks do not need to be done in a specific order.  
  
## Plan network topology and settings  
  
### Plan network adapters and IP addressing  
  
1. Identify the network adapter topology you want to use. Remote Access can be set up with either of the following:  
  
    - With two network adapters: Either at the edge with one network adapter connected to the Internet and the other to the internal network, or behind a NAT, firewall, or router device, with one network adapter connected to a perimeter network and the other to the internal network.  
  
    - Behind a NAT device with one network adapter: The Remote Access server is installed behind a NAT device, and the single network adapter is connected to the internal network.  
  
2. Identity your IP addressing requirements:  
  
    DirectAccess uses IPv6 with IPsec to create a secure connection between DirectAccess client computers and the internal corporate network. However, DirectAccess does not necessarily require connectivity to the IPv6 Internet or native IPv6 support on internal networks. Instead, it automatically configures and uses IPv6 transition technologies to tunnel IPv6 traffic across the IPv4 Internet (6to4, Teredo, IP-HTTPS) and across your IPv4-only intranet (NAT64 or ISATAP). For an overview of these transition technologies, see the following resources:  
  
    - [IPv6 Transition Technologies](https://technet.microsoft.com/library/bb726951.aspx)  
  
    - [IP-HTTPS Tunneling Protocol Specification](https://msdn.microsoft.com/library/dd358571.aspx)  
  
3. Configure required adapters and addressing according to the following table. For deployments behind a NAT device using a single network adapter, configure your IP addresses using only the 'Internal network adapter' column.  
  
    |IP address type|External network adapter|Internal network adapter|Routing requirements|  
    |-|--------------|--------------------|------------|  
    |IPv4 intranet and IPv4 Internet|Configure the following:<br/><br/>-   One static public IPv4 address with the appropriate subnet masks.<br/>-   A default gateway IPv4 address of your Internet firewall or local Internet service provider (ISP) router.|Configure the following:<br/><br/>-   An IPv4 intranet address with the appropriate subnet mask.<br/>-   A connection-specific DNS suffix of your intranet namespace. The DNS Server must also be configured on the Internal interface.<br/>-   Do not configure a default gateway on any intranet interfaces.|To configure the Remote Access server to reach all subnets on the internal IPv4 network do the following:<br/><br/>1.  List the IPv4 address spaces for all the locations on your intranet.<br/>2.  Use the **route add -p** or **netsh interface ipv4 add route** commands to add the IPv4 address spaces as static routes in the IPv4 routing table of the Remote Access server.|  
    |IPv6 Internet and IPv6 intranet|Configure the following:<br/><br/>-   Use the autoconfigured address configuration provided by your ISP.<br/>-   Use the **route print** command to ensure that a default IPv6 route pointing to the ISP router exists in the IPv6 routing table.<br/>-   Determine whether the ISP and intranet routers are using default router preferences described in RFC 4191, and using a higher default preference than your local intranet routers. If both of these are true, no other configuration for the default route is required. The higher preference for the ISP router ensures that the active default IPv6 route of the Remote Access server points to the IPv6 Internet.<br/><br/>Because the Remote Access server is an IPv6 router, if you have a native IPv6 infrastructure, the Internet interface can also reach the domain controllers on the intranet. In this case, add packet filters to the domain controller in the perimeter network that prevent connectivity to the IPv6 address of the Internet-facing interface of the Remote Access server.|Configure the following:<br/><br/>-   If you are not using default preference levels, configure your intranet interfaces with the **netsh interface ipv6 set InterfaceIndex ignoredefaultroutes=enabled** command. This command ensures that additional default routes pointing to intranet routers will not be added to the IPv6 routing table. You can obtain the InterfaceIndex of your intranet interfaces from the display of the netsh interface show interface command.|If you have an IPv6 intranet, to configure the Remote Access server to reach all of the IPv6 locations, do the following:<br/><br/>1.  List the IPv6 address spaces for all the locations on your intranet.<br/>2.  Use the **netsh interface ipv6 add route** command to add the IPv6 address spaces as static routes in the IPv6 routing table of the Remote Access server.|  
    |IPv6 Internet and IPv4 intranet|The Remote Access server forwards default IPv6 route traffic using the Microsoft 6to4 Adapter interface to a 6to4 relay on the IPv4 Internet. You can configure a Remote Access server for the IPv4 address of the Microsoft 6to4 relay on the IPv4 Internet (used when native IPv6 is not deployed in the corporate network) with the following command : netsh interface ipv6 6to4 set relay name=192.88.99.1 state=enabled command.|||  
  
    > [!NOTE]
    > 1. If the DirectAccess client has been assigned a public IPv4 address, it will use the 6to4 transition technology to connect to the intranet. If the DirectAccess client cannot connect to the DirectAccess server with 6to4, it will use IP-HTTPS.  
    > 2. Native IPv6 client computers can connect to the Remote Access server over native IPv6, and no transition technology is required.  
  
### Plan firewall requirements

If the Remote Access server is behind an edge firewall, the following exceptions will be required for Remote Access traffic when the Remote Access server is on the IPv4 Internet:  
  
- 6to4 traffic -IP Protocol 41 inbound and outbound.  
  
- IP-HTTPS -Transmission Control Protocol (TCP) destination port 443, and TCP source port 443 outbound.  
  
- If you are deploying Remote Access with a single network adapter, and installing the network location server on the Remote Access server, TCP port 62000 should also be exempted.  
  
The following exceptions will be required for Remote Access traffic when the Remote Access server is on the IPv6 Internet:  
  
- IP Protocol 50  
  
- UDP destination port 500 inbound, and UDP source port 500 outbound.  
  
When using additional firewalls, apply the following internal network firewall exceptions for Remote Access traffic:  
  
- ISATAP -Protocol 41 inbound and outbound  
  
- TCP/UDP for all IPv4/IPv6 traffic  
  
### Plan certificate requirements

Certificate requirements for IPsec include a computer certificate used by DirectAccess client computers when establishing the IPsec connection between the client and the Remote Access server, and a computer certificate used by Remote Access servers to establish IPsec connections with DirectAccess clients. For DirectAccess in Windows Server 2012 the use of these IPsec certificates is not mandatory. The Enable DirectAccess Wizard configures the Remote Access server to act as a Kerberos proxy to perform IPsec authentication without requiring certificates.  
  
1. **IP-HTTPS server**: When you configure Remote Access, the Remote Access server is automatically configured to act as the IP-HTTPS web listener. The IP-HTTPS site requires a website certificate, and client computers must be able to contact the certificate revocation list (CRL) site for the certificate. The Enable DirectAccess wizard tries to use the SSTP VPN certificate. If SSTP is not configured, it checks if a certificate for IP-HTTPS is present in the machine personal store. If none is available, it automatically creates a self-signed certificate.  
  
2. **Network location server**: The network location server is a website used to detect whether      client computers are located in the corporate network. The network location server requires a       website certificate. DirectAccess clients must be able to contact the CRL site for the        certificate. The Enable DirectAccess wizard checks if a certificate for Network Location Server      is present in  the machine personal store. If not present, it automatically creates a self-signed       certificate.  
  
The certification requirements for each of these are summarized in the following table:  
  
|IPsec authentication|IP-HTTPS server|Network location server|  
|------------|----------|--------------|  
|An internal CA is required to issue computer certificates to the Remote Access server and clients for IPsec authentication when you don't use the Kerberos proxy for authentication|Public CA: We recommend using a public CA to issue the IP-HTTPS certificate, this ensures that the CRL distribution point is available externally.|Internal CA: You can use an internal CA to issue the network location server website certificate. Make sure that the CRL distribution point is highly available from the internal network.|  
||Internal CA: You can use an internal CA to issue the IP-HTTPS certificate; however, you must make sure that the CRL distribution point is available externally.|Self-signed certificate: You can use a self-signed certificate for the network location server website; however, you cannot use a self-signed certificate in multisite deployments.|  
||Self-signed certificate: You can use a self-signed certificate for the IP-HTTPS server; however, you must make sure that the CRL distribution point is available externally. A self-signed certificate cannot be used in a multisite deployment.||  
  
#### Plan certificates for IP-HTTPS

The Remote Access server acts as an IP-HTTPS listener, and you must manually install an HTTPS website certificate on the server. Note the following when planning:  
  
- Using a public CA is recommended, so that CRLs are readily available.  
  
- In the subject field, specify either the IPv4 address of the Internet adapter of Remote Access server, or the FQDN of the IP-HTTPS URL (the ConnectTo address). If the Remote Access server is located behind a NAT device, the public name or address of the NAT device should be specified.  
  
- The common name of the certificate should match the name of the IP-HTTPS site.  
  
- For the Enhanced Key Usage field, use the Server Authentication object identifier (OID).  
  
- For the CRL Distribution Points field, specify a CRL distribution point that is accessible by DirectAccess clients that are connected to the Internet.  
  
- The IP-HTTPS certificate must have a private key.  
  
- The IP-HTTPS certificate must be imported directly into the personal store.  
  
- IP-HTTPS certificates can have wildcards in the name.  
  
#### Plan website certificates for the network location server

When planning for the network location server website, note the following:  
  
- In the Subject field, specify either an IP address of the intranet interface of the network location server or the FQDN of the network location URL.  
  
- For the Enhanced Key Usage field, use the Server Authentication OID.  
  
- For the CRL Distribution Points field, a CRL distribution point that is accessible by DirectAccess clients that are connected to the intranet. This CRL distribution point should not be accessible from outside the internal network.  
  
- If you are later planning to configure a multisite or cluster deployment, the name of the certificate should not match the internal name of the Remote Access server.  

    > [!NOTE]  
    > Ensure that the certificates for IP-HTTPS and network location server have a **Subject Name**. If the certificate does not have a **Subject Name** but has an **Alternative Name**, then it will not be accepted by the Remote Access wizard.  
  
#### Plan DNS requirements

In a Remote Access deployment, DNS is required for the following:  
  
- **DirectAccess client requests**: DNS is used to resolve requests from DirectAccess client computers that are not located on the internal network. DirectAccess clients attempt to connect to the DirectAccess network location server in order to determine whether they are located on the Internet, or on the corporate network: If the connection is successful, then clients are determined to be on the intranet and DirectAccess is not used, and client requests are resolved using the DNS server configured on the network adapter of the client computer. If the connection does not succeed, clients are assumed to be on the Internet. DirectAccess clients will use the name resolution policy table (NRPT) to determine which DNS server to use when resolving name requests. You can specify that clients should use DirectAccess DNS64 to resolve names, or an alternative internal DNS server. When performing name resolution, the NRPT is used by DirectAccess clients to identify how to handle a request. Clients request an FQDN or single-label name such as <https://internal>. If a single-label name is requests, a DNS suffix is appended to make an FQDN. If the DNS query matches an entry in the NRPT, and DNS4 or an intranet DNS server is specified for the entry, then the query is sent for name resolution using the specified server. If a match exists but no DNS server is specified, then this indicates an exemption rule and normal name resolution is applied.  
  
    Note that when a new suffix is added to the NRPT in the Remote Access Management console, the default DNS servers for the suffix can be automatically discovered by clicking the **Detect** button. Auto detection works as follows:  
  
    1. If the corporate network is IPv4-based, or IPv4 and IPv6, the default address is the DNS64 address of the internal adapter on the Remote Access server.  
  
    2. If the corporate network is IPv6-based, the default address is the IPv6 address of DNS servers in the corporate network.  
  
-  **Infrastructure servers**  
  
    1. **Network location server**: DirectAccess clients attempt to reach the network location server to determine if they are on the internal network. Clients on the internal network must be able to resolve the name of the network location server, but must be prevented from resolving the name when they are located on the Internet. To ensure this occurs, by default, the FQDN of the network location server is added as an exemption rule to the NRPT. In addition, when you configure Remote Access, the following rules are created automatically:  
  
        1. A DNS suffix rule for root domain or the domain name of the Remote Access server, and the IPv6 addresses corresponding to the intranet DNS servers configured on the Remote Access server. For example, if the Remote Access server is a member of the corp.contoso.com domain, a rule is created for the corp.contoso.com DNS suffix.  
  
        2. An exemption rule for the FQDN of the network location server. For example, if the network location server URL is <https://nls.corp.contoso.com>, an exemption rule is created for the FQDN nls.corp.contoso.com.  
  
        **IP-HTTPS server**: The Remote Access server acts as an IP-HTTPS listener and uses its server certificate to authenticate to IP-HTTPS clients. The IP-HTTPS name must be resolvable by DirectAccess clients using public DNS servers.  
  
        **Connectivity verifiers**: Remote Access creates a default web probe that is used by DirectAccess client computers use to verify connectivity to the internal network. To ensure the probe works as expected the following names must be registered manually in DNS:  
  
        1.  directaccess-webprobehost should resolve to the internal IPv4 address of the Remote Access server, or to the IPv6 address in an IPv6-only environment.  
  
        2.  directaccess-corpconnectivityhost should resolve to localhost (loopback) address. A and AAAA record should be created, A record with value 127.0.0.1 and AAAA record with value constructed out of NAT64 prefix with the last 32 bits as 127.0.0.1. The NAT64 prefix can be retrieved by running the cmdlet get-netnattransitionconfiguration.  
  
            > [!NOTE]  
            > This is valid only in an IPv4-only environment. In an IPv4+IPv6, or IPv6-only environment, only a AAAA record should be created with the loopback IP address ::1.  
  
        You can create additional connectivity verifiers using other web addresses over HTTP or PING. For each connectivity verifier, a DNS entry must exist.  
  
#### DNS server requirements  
  
- For DirectAccess clients, you must use either a DNS server running Windows Server 2003,  Windows Server 2008 ,  Windows Server 2008 R2 ,  Windows Server 2012 , or any DNS server that supports IPv6.  
  
### Plan Active Directory

Remote Access uses Active Directory and Active Directory Group Policy Objects as follows:  
  
- **Authentication**: Active Directory is used for authentication. The intranet tunnel uses Kerberos authentication for the user to access internal resources.  
  
- **Group policy objects**: Remote Access gathers configuration settings into group policy objects that are applied to Remote Access servers, clients, and internal application servers.  
  
- **Security groups**: Remote Access uses security groups to gather together and identify DirectAccess client computers, and Remote Access servers. The group policies are applied to the required security group.  
  
- **Extended IPsec policies**: Remote Access can use IPsec authentication and encryption between clients and the Remote Access server. You can extend IPsec authentication and encryption through to specified internal application servers.   
  
#### Active Directory Requirements  
  
When planning Active Directory for a Remote Access deployment, the following is required:  
  
- At least one domain controller installed on the  Windows Server 2012 ,  Windows Server 2008 R2  Windows Server 2008 , or Windows Server 2003 operating systems.  
  
    If the domain controller is on a perimeter network (and therefore reachable from the Internet-facing network adapter of Remote Access server) prevent the Remote Access server from reaching it by adding packet filters on the domain controller, to prevent connectivity to the IP address of the Internet adapter.  
  
- The Remote Access server must be a domain member.  
  
- DirectAccess clients must be domain members. Clients can belong to:  
  
    - Any domain in the same forest as the Remote Access server.  
  
    - Any domain that has a two-way trust with the Remote Access server domain.  
  
    - Any domain in a forest that has a two-way trust with the forest to which the Remote Access domain belongs.  
  
> [!NOTE]  
> - The Remote Access server cannot be a domain controller.  
> - The Active Directory domain controller used for Remote Access must not be reachable from the external Internet adapter of the Remote Access server (the adapter must not be in the domain profile of Windows Firewall).  
  
### Plan Group Policy Objects

DirectAccess settings configured when you configure Remote Access are collected into Group Policy Objects (GPO). Three different GPOs are populated with DirectAccess settings, and distributed as follows:  
  
- **DirectAccess client GPO**: This GPO contains client settings, including IPv6 transition technology settings, NRPT entries, and Windows Firewall with Advanced Security connection security rules. The GPO is applied to the security groups specified for the client computers.  
  
- **DirectAccess server GPO**: This GPO contains the DirectAccess configuration settings that are applied to any server configured as a Remote Access server in your deployment. It also contains Windows Firewall with Advanced Security connection security rules.  
  
- **Application servers GPO**: This GPO contains settings for selected application servers to which you optionally extend authentication and encryption from DirectAccess clients. If authentication and encryption are not extended then this GPO is not used.  
  
GPOs are created automatically by the Enable DirectAccess Wizard and a default name is specified for each GPO.  
  
> [!CAUTION]  
> Use the following procedure to backup all Remote Access Group Policy Objects before executing DirectAccess cmdlets: [Back up and Restore Remote Access Configuration](https://go.microsoft.com/fwlink/?LinkID=257928)  
  
GPOs can be configured in two ways:  
  
1. **Automatically**: You can specify that they are created automatically. A default name is specified for each GPO.  
  
2. **Manually**: You can use GPOs that have been predefined by the Active Directory        administrator.  
  
Note that once DirectAccess is configured to use specific GPOs, it cannot be configured to use different GPOs.  
  
#### Automatically-created GPOs

Note the following when using automatically-created GPOs:  
  
Automatically created GPOS are applied according to the location and link target parameter, as follows:  
  
- For the DirectAccess server GPO, both the location and link parameters point to the domain containing the Remote Access server.  
  
- When client GPOs are created, the location is set to a single domain in which the GPO will be created. The GPO name is looked up in each domain, and filled with DirectAccess settings if it exists. The link target is set to the root of the domain in which the GPO was created. A GPO is created for each domain that contains client computers or application servers, and the GPO is linked to the root of its respective domain.  
  
When using automatically created GPOs, to apply DirectAccess settings, the Remote Access server administrator requires the following permissions:  
  
- GPO create permissions for each domain.  
  
- Link permissions for all the selected client domain roots.  
  
- Link permissions for the server GPO domain roots.  
  
- Create, edit, delete, and modify security permissions are required for the GPOs.  
  
- It is recommended that the Remote Access administrator has GPO read permissions for each required domain. This enables Remote Access to verify that GPOs with duplicate names do not exist when creating GPOs.  
  
Note that if the correct permissions for linking GPOs do not exist, a warning is issued. The Remote Access operation will continue but linking will not occur. If this warning is issued links will not be created automatically, even after the permissions are in place. Instead the administrator will need to create the links manually.  
  
#### Manually-created GPOs

Note the following when using manually-created GPOs:  
  
- The GPOs should exist before running the Remote Access Setup wizard.  
  
- When using manually-created GPOs, to apply DirectAccess settings the Remote Access administrator requires full GPO permissions (Edit, Delete, Modify security) on the manually-created GPOs.  
  
- When using manually created GPOs a search is made for a link to the GPO in the entire domain. If the GPO is not linked in the domain then a link is automatically created in the domain root. If the required permissions to create the link are not available a warning is issued.  
  
Note that if the correct permissions for linking GPOs do not exist, a warning is issued. The Remote Access operation will continue but linking will not occur. If this warning is issued links will not be created automatically, even when the permissions are added later. Instead the administrator will need to create the links manually.  
  
#### Recovering from a deleted GPO

If a Remote Access server, client, or application server GPO has been deleted by accident and there is no backup available, you must remove the configuration settings and re-configure again. If a backup is available, you can restore the GPO from the backup.  
  
**Remote Access Management** will display the following error message: **GPO (GPO name) cannot be found**. To remove the configuration settings, take the following steps:  
  
1. Run the PowerShell cmdlet **Uninstall-remoteaccess**.  
  
2. Reopen **Remote Access Management**.  
  
3. You will see an error message that the GPO is not found. Click **Remove configuration settings**. After completion, the server will be restored to an un-configured state.  

