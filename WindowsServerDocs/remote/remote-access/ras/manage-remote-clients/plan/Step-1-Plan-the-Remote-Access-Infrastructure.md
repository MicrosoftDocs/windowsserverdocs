---
title: Step 1 Plan the Remote Access Infrastructure
description: This topic is part of the guide Manage DirectAccess Clients Remotely in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a1ce7af5-f3fe-4fc9-82e8-926800e37bc1
ms.author: lizross
author: eross-msft
---
# Step 1 Plan the Remote Access Infrastructure

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

> [!NOTE]
> Windows Server 2016 combines DirectAccess and Routing and Remote Access Service (RRAS) into a single Remote Access role.  
  
This topic describes the steps for planning an infrastructure that you can use to set up a single Remote Access server for remote management of DirectAccess clients. The following table lists the steps, but these planning tasks do not need to be done in a specific order.  
  
|Task|Description|  
|----|--------|  
|[Plan network topology and server settings](#plan-network-topology-and-settings)|Decide where to place the Remote Access server (at the edge or behind a Network Address Translation (NAT) device or firewall), and plan IP addressing and routing.|  
|[Plan firewall requirements](#plan-firewall-requirements)|Plan for allowing Remote Access through edge firewalls.|  
|[Plan certificate requirements](#plan-certificate-requirements)|Decide if you will use Kerberos protocol or certificates for client authentication, and plan your website certificates.<br/><br/>IP-HTTPS is a transition protocol that is used by DirectAccess clients to tunnel IPv6 traffic over IPv4 networks. Decide whether to authenticate IP-HTTPS for the server by using a certificate that is issued by a certification authority (CA), or by using a self-signed certificate that is issued automatically by the Remote Access server.|  
|[Plan DNS requirements](#plan-dns-requirements)|Plan the Domain Name System (DNS) settings for the Remote Access server, infrastructure servers, local name resolution options, and client connectivity.| 
|[Plan the network location server configuration](#plan-the-network-location-server-configuration)|Decide where to place the network location server website in your organization (on the Remote Access server or an alternative server), and plan the certificate requirements if the network location server will be located on the Remote Access server. **Note:** The network location server is used by DirectAccess clients to determine whether they are located on the internal network.|  
|[Plan management servers' configurations](#plan-management-servers-configuration)|Plan for management servers (such as update servers) that are used during remote client management. **Note:** Administrators can remotely manage DirectAccess client computers that are located outside the corporate network by using the Internet.|  
|[Plan Active Directory requirements](#plan-active-directory-requirements)|Plan your domain controllers, your Active Directory requirements, client authentication, and multiple domain structure.|  
|[Plan Group Policy Object creation](#plan-group-policy-object-creation)|Decide what GPOs are required in your organization and how to create and edit the GPOs.|  
  
## Plan network topology and settings  
When you plan your network, you need to consider the network adapter topology, settings for IP addressing, and requirements for ISATAP.  
  
### Plan network adapters and IP addressing  
  
1.  Identify the network adapter topology that you want to use. Remote Access can be set up with any of the following topologies:  
  
    -   With two network adapters: The Remote Access server is installed at the edge with one network adapter connected to the Internet and the other to the internal network.  
  
    -   With two network adapters: The Remote Access server is installed behind a NAT device, firewall, or router, with one network adapter connected to a perimeter network and the other to the internal network.  
  
    -   With one network adapter: The Remote Access server is installed behind a NAT device, and the single network adapter is connected to the internal network.  
  
2.  Identify your IP addressing requirements:  
  
    DirectAccess uses IPv6 with IPsec to create a secure connection between DirectAccess client computers and the internal corporate network. However, DirectAccess does not necessarily require connectivity to the IPv6 Internet or native IPv6 support on internal networks. Instead, it automatically configures and uses IPv6 transition technologies to tunnel IPv6 traffic across the IPv4 Internet (6to4, Teredo, or IP-HTTPS) and across your IPv4-only intranet (NAT64 or ISATAP). For an overview of these transition technologies, see the following resources:  
  
    -   [IPv6 Transition Technologies](https://technet.microsoft.com/library/bb726951.aspx)  
  
    -   [IP-HTTPS Tunneling Protocol Specification](https://msdn.microsoft.com/library/dd358571.aspx)  
  
3.  Configure required adapters and addressing according to the following table. For deployments that are behind a NAT device using a single network adapter, configure your IP addresses by using only the **Internal network adapter** column.  
  
    ||External network adapter|Internal network adapter<sup>1, above</sup>|Routing requirements|  
    |-|--------------|------------------------|------------|  
    |IPv4 Internet and IPv4 intranet|Configure the following:<br/><br/>-   Two static consecutive public IPv4 addresses with the appropriate subnet masks (required for Teredo only).<br/>-   A default gateway IPv4 address for your Internet firewall or local Internet service provider (ISP) router. **Note:** The Remote Access server requires two consecutive public IPv4 addresses so that it can act as a Teredo server and Windows-based Teredo clients can use the Remote Access server to detect the type of NAT device.|Configure the following:<br/><br/>-   An IPv4 intranet address with the appropriate subnet mask.<br/>-   A connection-specific DNS suffix for your intranet namespace. A DNS server should also be configured on the internal interface. **Caution:** Do not configure a default gateway on any intranet interfaces.|To configure the Remote Access server to reach all subnets on the internal IPv4 network, do the following:<br/><br/>-   List the IPv4 address spaces for all the locations on your intranet.<br/>-   Use the `route add -p` or `netsh interface ipv4 add route` commands to add the IPv4 address spaces as static routes in the IPv4 routing table of the Remote Access server.|  
    |IPv6 Internet and IPv6 intranet|Configure the following:<br/><br/>-   Use the autoconfigured address configuration provided by your ISP.<br/>-   Use the `route print` command to ensure that a default IPv6 route that points to the ISP router exists in the IPv6 routing table.<br/>-   Determine if the ISP and intranet routers are using default router preferences as described in RFC 4191, and if they are use a higher default preference than your local intranet routers. If both of these are true, no other configuration for the default route is required. The higher preference for the ISP router ensures that the active default IPv6 route of the Remote Access server points to the IPv6 Internet.<br/><br/>Because the Remote Access server is an IPv6 router, if you have a native IPv6 infrastructure, the Internet interface can also reach the domain controllers on the intranet. In this case, add packet filters to the domain controller in the perimeter network that prevent connectivity to the IPv6 address of the Internet interface of the Remote Access server.|Configure the following:<br/><br/>If you are not using default preference levels, configure your intranet interfaces by using the `netsh interface ipv6 set InterfaceIndex ignoredefaultroutes=enabled` command. This command ensures that additional default routes that point to intranet routers will not be added to the IPv6 routing table. You can obtain the InterfaceIndex of your intranet interfaces from the display of the `netsh interface show interface` command.|If you have an IPv6 intranet, to configure the Remote Access server to reach all of the IPv6 locations, do the following:<br/><br/>-   List the IPv6 address spaces for all the locations on your intranet.<br/>-   Use the `netsh interface ipv6 add route` command to add the IPv6 address spaces as static routes in the IPv6 routing table of the Remote Access server.|  
    |IPv4 Internet and IPv6 intranet|The Remote Access server forwards default IPv6 route traffic by using the Microsoft 6to4 adapter interface to a 6to4 relay on the IPv4 Internet. When native IPv6 is not deployed in the corporate network, you can use the following command to configure a Remote Access server for the IPv4 address of the Microsoft 6to4 relay on the IPv4 Internet: `netsh interface ipv6 6to4 set relay name=<ipaddress> state=enabled`.|||  
  
    > [!NOTE]  
    > -   If the DirectAccess client has been assigned a public IPv4 address, it will use the 6to4 relay technology to connect to the intranet. If the client is assigned a private IPv4 address, it will use Teredo. If the DirectAccess client cannot connect to the DirectAccess server with 6to4 or Teredo, it will use IP-HTTPS.  
    > -   To use Teredo, you must configure two consecutive IP addresses on the external facing network adapter.  
    > -   You cannot use Teredo if the Remote Access server has only one network adapter.  
    > -   Native IPv6 client computers can connect to the Remote Access server over native IPv6, and no transition technology is required.  
  
### Plan ISATAP requirements  
ISATAP is required for remote management of DirectAccessclients, so that DirectAccess management servers can connect to DirectAccess clients located on the Internet. ISATAP is not required to support connections that are initiated by DirectAccess client computers to IPv4 resources on the corporate network. NAT64/DNS64 is used for this purpose. If your deployment requires ISATAP, use the following table to identify your requirements.  
  
|ISATAP deployment scenario|Requirements|  
|---------------|--------|  
|Existing native IPv6 intranet (no ISATAP is required)|With an existing native IPv6 infrastructure, you specify the prefix of the organization during Remote Access deployment, and the Remote Access server does not configure itself as an ISATAP router. Do the following:<br/><br/>1.  To ensure that DirectAccess clients are reachable from the intranet, you must modify your IPv6 routing so that default route traffic is forwarded to the Remote Access server. If your intranet IPv6 address space uses an address other than a single 48-bit IPv6 address prefix, you must specify the relevant organization IPv6 prefix during deployment.<br/>2.  If you are currently connected to the IPv6 Internet, you must configure your default route traffic so that it is forwarded to the Remote Access server, and then configure the appropriate connections and routes on the Remote Access server, so that the default route traffic is forwarded to the device that is connected to the IPv6 Internet.|  
|Existing ISATAP deployment|If you have an existing ISATAP infrastructure, during deployment you are prompted for the 48-bit prefix of the organization, and the Remote Access server does not configure itself as an ISATAP router. To ensure that DirectAccess clients are reachable from the intranet, you must modify your IPv6 routing infrastructure so that default route traffic is forwarded to the Remote Access server. This change needs to be done on the existing ISATAP router to which the intranet clients must already be forwarding the default traffic.|  
|No existing IPv6 connectivity|When the Remote Access setup wizard detects that the server has no native or ISATAP-based IPv6 connectivity, it automatically derives a 6to4-based 48-bit prefix for the intranet, and configures the Remote Access server as an ISATAP router to provide IPv6 connectivity to ISATAP hosts across your intranet. (A 6to4-based prefix is used only if the server has public addresses, otherwise the prefix is automatically generated from a unique local address range.)<br/><br/>To use ISATAP do the following:<br/><br/>1.  Register the ISATAP name on a DNS server for each domain on which you want to enable ISATAP-based connectivity, so that the ISATAP name is resolvable by the internal DNS server to the internal IPv4 address of the Remote Access server.<br/>2.  By default, DNS servers running  Windows Server 2012 ,  Windows Server 2008 R2 ,  Windows Server 2008 , or Windows Server 2003 block resolution of the ISATAP name by using the global query block list. To enable ISATAP, you must remove the ISATAP name from the block list. For more information, see [Remove ISATAP from the DNS Global Query Block List](https://go.microsoft.com/fwlink/p/?LinkId=168593).<br/><br/>Windows-based ISATAP hosts that can resolve the ISATAP name automatically configure an address with the Remote Access server as following:<br/><br/>1.  An ISATAP-based IPv6 address on an ISATAP tunneling interface<br/>2.  A 64-bit route that provides connectivity to the other ISATAP hosts on the intranet<br/>3.  A default IPv6 route that points to the Remote Access server. The default route ensures that intranet ISATAP hosts can reach DirectAccess clients<br/><br/>When your Windows-based ISATAP hosts obtain an ISATAP-based IPv6 address, they begin to use ISATAP-encapsulated traffic to communicate if the destination is also an ISATAP host. Because ISATAP uses a single 64-bit subnet for the entire intranet, your communication goes from a segmented  IPv4 model of communication, to a single subnet communication model with IPv6. This can affect the behavior of some Active Directory Domain Services (AD DS) and applications that rely on your Active Directory Sites and Services configuration. For example, if you used the Active Directory Sites and Services snap-in to configure sites, IPv4-based subnets, and intersite transports for forwarding requests to servers within sites, this configuration is not used by ISATAP hosts.<br/><br/><ol><li>To configure Active Directory Sites and Services for forwarding within sites for ISATAP hosts, for each IPv4 subnet object, you must configure an equivalent IPv6 subnet object, in which the IPv6 address prefix for the subnet expresses the same range of ISATAP host addresses as the IPv4 subnet. For example, for the IPv4 subnet 192.168.99.0/24 and the 64-bit ISATAP address prefix 2002:836b:1:8000::/64, the equivalent IPv6 address prefix for the IPv6 subnet object is 2002:836b:1:8000:0:5efe:192.168.99.0/120. For an arbitrary IPv4 prefix length (set to 24 in the example), you can determine the corresponding IPv6 prefix length from the formula 96 + IPv4PrefixLength.</li><li>For the IPv6 addresses of DirectAccess clients, add the following:<br/><br/><ul><li>For Teredo-based DirectAccess clients: An IPv6 subnet for the range 2001:0:WWXX:YYZZ::/64, in which WWXX:YYZZ is the colon-hexadecimal version of the first Internet-facing IPv4 address of the Remote Access server. .</li><li>For IP-HTTPS-based DirectAccess clients: An IPv6 subnet for the range 2002:WWXX:YYZZ:8100::/56, in which WWXX:YYZZ is the colon-hexadecimal version of the first Internet-facing IPv4 address (w.x.y.z) of the Remote Access server. .</li><li>For 6to4-based DirectAccess clients: A series of 6to4-based IPv6 prefixes that begin with 2002: and represent the regional, public IPv4 address prefixes that are administered by Internet Assigned Numbers Authority (IANA) and regional registries. The 6to4-based prefix for a public IPv4 address prefix w.x.y.z/n is 2002:WWXX:YYZZ::/[16+n], in which WWXX:YYZZ is the colon-hexadecimal version of w.x.y.z.<br/><br/>        For example, the 7.0.0.0/8 range is administered by American Registry for Internet Numbers (ARIN) for North America. The corresponding 6to4-based prefix for this public IPv6 address range is 2002:700::/24. For information about the IPv4 public address space, see [IANA IPv4 Address Space Registry](https://www.iana.org/assignments/ipv4-address-space/ipv4-address-space.xml). .</li></ul></li></ol>|  
  
> [!IMPORTANT]  
> Ensure that you do not have public IP addresses on the internal interface of the DirectAccess server. If you have public IP address on the internal interface, connectivity through ISATAP may fail.  
  
### Plan firewall requirements  
If the Remote Access server is behind an edge firewall, the following exceptions will be required for Remote Access traffic when the Remote Access server is on the IPv4 Internet:  
  
-   For IP-HTTPS: Transmission Control Protocol (TCP) destination port 443, and TCP source port 443 outbound.  
  
-   For Teredo traffic: User Datagram Protocol (UDP) destination port 3544 inbound, and UDP source port 3544 outbound.  
  
-   For 6to4 traffic: IP Protocol 41 inbound and outbound.  
  
    > [!NOTE]  
    > For Teredo and 6to4 traffic, these exceptions should be applied for both of the Internet-facing consecutive public IPv4 addresses on the Remote Access server.  
    >   
    > For IP-HTTPS the exceptions need to be applied on the address that is registered on the public DNS server.  
  
-   If you are deploying Remote Access with a single network adapter and installing the network location server on the Remote Access server, TCP port 62000.  
  
    > [!NOTE]  
    > This exemption is on the Remote Access server, and the previous exemptions are on the edge firewall.  
  
The following exceptions are required for Remote Access traffic when the Remote Access server is on the IPv6 Internet:  
  
-   IP Protocol 50  
  
-   UDP destination port 500 inbound, and UDP source port 500 outbound.  
  
-   ICMPv6 traffic inbound and outbound (only when using Teredo).  
  
When you are using additional firewalls, apply the following internal network firewall exceptions for Remote Access traffic:  
  
-   For ISATAP: Protocol 41 inbound and outbound  
  
-   For all IPv4/IPv6 traffic: TCP/UD  
  
-   For Teredo: ICMP for all IPv4/IPv6 traffic  
  
### Plan certificate requirements  
There are three scenarios that require certificates when you deploy a single Remote Access server.  
  
-   **IPsec authentication**: Certificate requirements for IPsec include a computer certificate that is used by DirectAccess client computers when they establish the IPsec connection with the Remote Access server, and a computer certificate that is used by Remote Access servers to establish IPsec connections with DirectAccess clients.  
  
    For DirectAccess in  Windows Server 2012 , the use of these IPsec certificates is not mandatory. As an alternative, the Remote Access server can act as a proxy for Kerberos authentication without requiring certificates. If Kerberos authentication is used, it works over SSL, and the Kerberos protocol uses the certificate that was configured for IP-HTTPS. Some enterprise scenarios (including multisite deployment and one-time password client authentication) require the use of certificate authentication, and not Kerberos authentication.  
  
-   **IP-HTTPS server**: When you configure Remote Access, the Remote Access server is automatically configured to act as the IP-HTTPS web listener. The IP-HTTPS site requires a website certificate, and client computers must be able to contact the certificate revocation list (CRL) site for the certificate.  
  
-   **Network location server**: The network location server is a website that is used to detect whether client computers are located in the corporate network. The network location server requires a website certificate. DirectAccess clients must be able to contact the CRL site for the certificate.  
  
The certification authority (CA) requirements for each of these scenarios is summarized in the following table.  
  
|IPsec authentication|IP-HTTPS server|Network location server|  
|------------|----------|--------------|  
|An internal CA is required to issue computer certificates to the Remote Access server and clients for IPsec authentication when you don't use the Kerberos protocol for authentication.|Internal CA: You can use an internal CA to issue the IP-HTTPS certificate; however, you must make sure that the CRL distribution point is available externally.|Internal CA: You can use an internal CA to issue the network location server website certificate. Make sure that the CRL distribution point is highly available from the internal network.|  
||Self-signed certificate: You can use a self-signed certificate for the IP-HTTPS server. A self-signed certificate cannot be used in a multisite deployment.|Self-signed certificate: You can use a self-signed certificate for the network location server website; however, you cannot use a self-signed certificate in multisite deployments.|  
||Public CA: We recommend that you use a public CA to issue the IP-HTTPS certificate, this ensures that the CRL distribution point is available externally.||  
  
#### Plan computer certificates for IPsec authentication  
If you are using certificate-based IPsec authentication, the Remote Access server and clients are required to obtain a computer certificate. The simplest way to install the certificates is to use Group Policy to configure automatic enrollment for computer certificates. This ensures that all domain members obtain a certificate from an enterprise CA. If you do not have an enterprise CA set up in your organization, see [Active Directory Certificate Services](https://technet.microsoft.com/library/cc770357.aspx).  
  
This certificate has the following requirements:  
  
-   The certificate should have client authentication extended key usage (EKU).  
  
-   The client and the server certificates should relate to the same root certificate. This root certificate must be selected in the DirectAccess configuration settings.  
  
#### Plan certificates for IP-HTTPS  
The Remote Access server acts as an IP-HTTPS listener, and you must manually install an HTTPS website certificate on the server. Consider the following when you are planning:  
  
-   Using a public CA is recommended, so that CRLs are readily available.  
  
-   In the subject field, specify the IPv4 address of the Internet adapter of Remote Access server or the FQDN of the IP-HTTPS URL (the ConnectTo address). If the Remote Access server is located behind a NAT device, the public name or address of the NAT device should be specified.  
  
-   The common name of the certificate should match the name of the IP-HTTPS site.  
  
-   For the **Enhanced Key Usage** field, use the Server Authentication object identifier (OID).  
  
-   For the **CRL Distribution Points** field, specify a CRL distribution point that is accessible by DirectAccess clients that are connected to the Internet.  
  
    > [!NOTE]  
    > This is only required for clients running Windows 7.  
  
-   The IP-HTTPS certificate must have a private key.  
  
-   The IP-HTTPS certificate must be imported directly into the personal store.  
  
-   IP-HTTPS certificates can have wildcard characters in the name.  
  
#### Plan website certificates for the network location server  
Consider the following when you are planning the network location server website:  
  
-   In the **Subject** field, specify an IP address of the intranet interface of the network location server or the FQDN of the network location URL.  
  
-   For the **Enhanced Key Usage** field, use the Server Authentication OID.  
  
-   For the **CRL Distribution Points** field, use a CRL distribution point that is accessible by DirectAccess clients that are connected to the intranet. This CRL distribution point should not be accessible from outside the internal network.  
  
> [!NOTE]  
> Ensure that the certificates for IP-HTTPS and network location server have a subject name. If the certificate uses an alternative name, it will not be accepted by the Remote Access Wizard.  
  
#### Plan DNS requirements  
This section explains the DNS requirements for clients and servers in a Remote Access deployment.  
  
##### DirectAccess client requests  
DNS is used to resolve requests from DirectAccess client computers that are not located on the internal network. DirectAccess clients attempt to connect to the DirectAccess network location server to determine whether they are located on the Internet or on the corporate network.  
  
-   If the connection is successful, clients are determined to be on the intranet, DirectAccess is not used, and client requests are resolved by using the DNS server that is configured on the network adapter of the client computer.  
  
-   If the connection does not succeed, clients are assumed to be on the Internet. DirectAccess clients will use the name resolution policy table (NRPT) to determine which DNS server to use when resolving name requests. You can specify that clients should use DirectAccess DNS64 to resolve names, or an alternative internal DNS server.  
  
When performing name resolution, the NRPT is used by DirectAccess clients to identify how to handle a request. Clients request an FQDN or single-label name such as <https://internal>. If a single-label name is requested, a DNS suffix is appended to make an FQDN. If the DNS query matches an entry in the NRPT and DNS4 or an intranet DNS server is specified for the entry, the query is sent for name resolution by using the specified server. If a match exists but no DNS server is specified, an exemption rule and normal name resolution is applied.  
  
When a new suffix is added to the NRPT in the Remote Access Management console, the default DNS servers for the suffix can be automatically discovered by clicking the **Detect** button. Automatic detection works as follows:  
  
-   If the corporate network is IPv4-based, or it uses IPv4 and IPv6, the default address is the DNS64 address of the internal adapter on the Remote Access server.  
  
-   If the corporate network is IPv6-based, the default address is the IPv6 address of DNS servers in the corporate network.  
  
##### Infrastructure servers  
  
-   **Network location server**  
  
    DirectAccess clients attempt to reach the network location server to determine if they are on the internal network. Clients on the internal network must be able to resolve the name of the network location server, and they must be prevented from resolving the name when they are located on the Internet. To ensure that this occurs, by default, the FQDN of the network location server is added as an exemption rule to the NRPT. In addition, when you configure Remote Access, the following rules are created automatically:  
  
    -   A DNS suffix rule for root domain or the domain name of the Remote Access server, and the IPv6 addresses that correspond to the intranet DNS servers that are configured on the Remote Access server. For example, if the Remote Access server is a member of the corp.contoso.com domain, a rule is created for the corp.contoso.com DNS suffix.  
  
    -   An exemption rule for the FQDN of the network location server. For example, if the network location server URL is <https://nls.corp.contoso.com>, an exemption rule is created for the FQDN nls.corp.contoso.com.  
  
-   **IP-HTTPS server**  
  
    The Remote Access server acts as an IP-HTTPS listener and uses its server certificate to authenticate to IP-HTTPS clients. The IP-HTTPS name must be resolvable by DirectAccess clients that use public DNS servers.  
  
##### Connectivity verifiers  
Remote Access creates a default web probe that is used by DirectAccess client computers to verify connectivity to the internal network. To ensure that the probe works as expected, the following names must be registered manually in DNS:  
  
-   **directaccess-webprobehost** should resolve to the internal IPv4 address of the Remote Access server, or to the IPv6 address in an IPv6-only environment.  
  
-   **directaccess-corpconnectivityhost** should resolve to the local host (loopback) address. You should create A and AAAA records. The value of the A record is 127.0.0.1, and the value of the AAAA record is constructed from the NAT64 prefix with the last 32 bits as 127.0.0.1. The NAT64 prefix can be retrieved by running the **Get-netnatTransitionConfiguration** Windows PowerShell cmdlet.  
  
    > [!NOTE]  
    > This is valid only in IPv4-only environments. In an IPv4 plus IPv6 or an IPv6-only environment, create only a AAAA record with the loopback IP address ::1.  
  
You can create additional connectivity verifiers by using other web addresses over HTTP or PING. For each connectivity verifier, a DNS entry must exist.  
  
##### DNS server requirements  
  
-   For DirectAccess clients, you must use a DNS server running  Windows Server 2012 ,  Windows Server 2008 R2 ,  Windows Server 2008 , Windows Server 2003, or any DNS server that supports IPv6.  
  
-   You should use a DNS server that supports dynamic updates. You can use DNS servers that do not support dynamic updates, but then entries must be manually updated.  
  
-   The FQDN for your CRL distribution points must be resolvable by using Internet DNS servers. For example, if URL <https://crl.contoso.com/crld/corp-DC1-CA.crl> is in the **CRL Distribution Points** field of the IP-HTTPS certificate of the Remote Access server, you must ensure that the FQDN crld.contoso.com is resolvable by using Internet DNS servers.  
  
#### Plan for local name resolution  
Consider the following when you are planning for local name resolution:  
  
##### NRPT  
You may need to create additional name resolution policy table (NRPT) rules in the following situations:  
  
-   You need to add more DNS suffixes for your intranet namespace.  
  
-   If the FQDNs of your CRL distribution points are based on your intranet namespace, you must add exemption rules for the FQDNs of the CRL distribution points.  
  
-   If you have a split-brain DNS environment, you must add exemption rules for the names of resources for which you want DirectAccess clients that are located on the Internet to access the Internet version, rather than the intranet version.  
  
-   If you are redirecting traffic to an external website through your intranet web proxy servers, the external website is available only from the intranet. It uses the addresses of your web proxy servers to permit the inbound requests. In this situation, add an exemption rule for the FQDN of the external website, and specify that the rule uses your intranet web proxy server rather than the IPv6 addresses of intranet DNS servers.  
  
    For example, let's say that you are testing an external website named test.contoso.com. This name is not resolvable through Internet DNS servers, but the Contoso web proxy server knows how to resolve the name and how to direct requests for the website to the external web server. To prevent users who are not on the Contoso intranet from accessing the site, the external website allows requests only from the IPv4 Internet address of the Contoso web proxy. Thus, intranet users can access the website because they are using the Contoso web proxy, but DirectAccess users cannot because they are not using the Contoso web proxy. By configuring an NRPT exemption rule for test.contoso.com that uses the Contoso web proxy, webpage requests for test.contoso.com are routed to the intranet web proxy server over the IPv4 Internet.  
  
##### Single label names  
Single label names, such as <https://paycheck>, are sometimes used for intranet servers. If a single label name is requested and a DNS suffix search list is configured, the DNS suffixes in the list will be appended to the single label name. For example, when a user on a computer that is a member of the corp.contoso.com domain types <https://paycheck> in the web browser, the FQDN that is constructed as the name is paycheck.corp.contoso.com. By default, the appended suffix is based on the primary DNS suffix of the client computer.  
  
> [!NOTE]  
> In a disjointed name space scenario (where one or more domain computers has a DNS suffix that does not match the Active Directory domain to which the computers are members), you should ensure that the search list is customized to include all the required suffixes. By default, the Remote Access Wizard, configures the Active Directory DNS name as the primary DNS suffix on the client. Make sure to add the DNS suffix that is used by clients for name resolution.  
  
If multiple domains and Windows Internet Name Service (WINS) are deployed in your organization, and you are connecting remotely, single-names can be resolved as follows:  
  
-   By deploying a WINS forward lookup zone in the DNS. When trying to resolve computername.dns.zone1.corp.contoso.com, the request is directed to the WINS server that is only using the computer name. The client thinks it is issuing a regular DNS A records request, but it is actually a NetBIOS request.  
  
    For more information, see [Managing a Forward Lookup Zone](https://technet.microsoft.com/library/cc816891(WS.10).aspx).  
  
-   By adding a DNS suffix (for example, dns.zone1.corp.contoso.com) to the default domain GPO.  
  
##### Split-brain DNS  
Split-brain DNS refers to the use of the same DNS domain for Internet and intranet name resolution.  
  
For split-brain DNS deployments, you must list the FQDNs that are duplicated on the Internet and intranet, and decide which resources the DirectAccess client should reach-the intranet or the Internet version. When you want DirectAccess clients to reach the Internet version, you must add the corresponding FQDN as an exemption rule to the NRPT for each resource.  
  
In a split-brain DNS environment, if you want both versions of the resource to be available, configure your intranet resources with names that do not duplicate the names that are used on the Internet. Then instruct your users to use the alternate name when they access the resource on the intranet. For example, configure www\.internal.contoso.com for the internal name of www\.contoso.com.  
  
In a non-split-brain DNS environment, the Internet namespace is different from the intranet namespace. For example, the Contoso Corporation uses contoso.com on the Internet and corp.contoso.com on the intranet. Because all intranet resources use the corp.contoso.com DNS suffix, the NRPT rule for corp.contoso.com routes all DNS name queries for intranet resources to intranet DNS servers. DNS queries for names with the contoso.com suffix do not match the corp.contoso.com intranet namespace rule in the NRPT, and they are sent to Internet DNS servers. With a non-split-brain DNS deployment, because there is no duplication of FQDNs for intranet and Internet resources, there is no additional configuration needed for the NRPT. DirectAccess clients can access both Internet and intranet resources for their organization.  
  
##### Plan local name resolution behavior for DirectAccess clients  
If a name cannot be resolved with DNS, the DNS Client service in  Windows Server 2012 , Windows 8,  Windows Server 2008 R2 , and  Windows 7  can use local name resolution, with the Link-Local Multicast Name Resolution (LLMNR) and NetBIOS over TCP/IP protocols, to resolve the name on the local subnet. Local name resolution is typically needed for peer-to-peer connectivity when the computer is located on private networks, such as single subnet home networks.  
  
When the DNS Client service performs local name resolution for intranet server names, and the computer is connected to a shared subnet on the Internet, malicious users can capture LLMNR and NetBIOS over TCP/IP messages to determine intranet server names. On the DNS page of the Infrastructure Server Setup Wizard, you can configure the local name resolution behavior based on the types of responses received from intranet DNS servers. The following options are available:  
  
-   **Use local name resolution if the name does not exist in DNS**: This option is the most secure because the DirectAccess client performs local name resolution only for server names that cannot be resolved by intranet DNS servers. If the intranet DNS servers can be reached, the names of intranet servers are resolved. If the intranet DNS servers cannot be reached, or if there are other types of DNS errors, the intranet server names are not leaked to the subnet through local name resolution.  
  
-   **Use local name resolution if the name does not exist in DNS or DNS servers are unreachable when the client computer is on a private network (recommended)**: This option is recommended because it allows the use of local name resolution on a private network only when the intranet DNS servers are unreachable.  
  
-   **Use local name resolution for any kind of DNS resolution error (least secure)**: This is the least secure option because the names of intranet network servers can be leaked to the local subnet through local name resolution.  
  
#### Plan the network location server configuration  
The network location server is a website that is used to detect whether DirectAccess clients are located in the corporate network. Clients in the corporate network do not use DirectAccess to reach internal resources; but instead, they connect directly.  
  
The network location server website can be hosted on the Remote Access server or on another server in your organization. If you host the network location server on the Remote Access server, the website is created automatically when you deploy Remote Access. If you host the network location server on another server running a Windows operating system, you must make sure that Internet Information Services (IIS) is installed on that server, and that the website is created. Remote Access does not configure settings on the network location server.  
  
Make sure that the network location server website meets the following requirements:  
  
-   Has an HTTPS server certificate.  
  
-   Has high availability to computers on the internal network.  
  
-   Is not accessible to DirectAccess client computers on the Internet.  
  
-  
  
In addition, consider the following requirements for clients when you are setting up your network location server website:  
  
-   DirectAccess client computers must trust the CA that issued the server certificate to the network location server website.  
  
-   DirectAccess client computers on the internal network must be able to resolve the name of the network location server site.  
  
##### Plan certificates for the network location server  
When you obtain the website certificate to use for the network location server, consider the following:  
  
-   In the **Subject** field, specify the IP address of the intranet interface of the network location server or the FQDN of the network location URL.  
  
-   For the **Enhanced Key Usage** field, use the Server Authentication OID.  
  
-   The network location server certificate must be checked against a certificate revocation list (CRL). For the **CRL Distribution Points** field, use a CRL distribution point that is accessible by DirectAccess clients that are connected to the intranet. This CRL distribution point should not be accessible from outside the internal network.  
  
##### Plan DNS for the network location server  
DirectAccess clients attempt to reach the network location server to determine if they are on the internal network. Clients on the internal network must be able to resolve the name of the network location server, but must be prevented from resolving the name when they are located on the Internet. To ensure this occurs, by default, the FQDN of the network location server is added as an exemption rule to the NRPT.  
  
### Plan management servers' configuration  
DirectAccess clients initiate communication with management servers that provide services such as Windows Update and antivirus updates. DirectAccess clients also use the Kerberos protocol to authenticate to domain controllers before they access the internal network. During remote management of DirectAccess clients, management servers communicate with client computers to perform management functions such as software or hardware inventory assessments. Remote Access can automatically discover some management servers, including:  
  
-   Domain controllers: Automatic discovery of domain controllers is performed for the domains that contain client computers and for all domains in the same forest as the Remote Access server.  
  
-   Microsoft Endpoint Configuration Manager servers  
  
Domain controllers and Configuration Manager servers are automatically detected the first time DirectAccess is configured. The detected domain controllers are not displayed in the console, but settings can be retrieved using Windows PowerShell cmdlets. If domain controller or Configuration Manager servers are modified, clicking **Update Management Servers** in the console refreshes the management server list.  
  
**Management server requirements**  
  
-   Management servers must be accessible over the infrastructure tunnel. When you configure Remote Access, adding servers to the management servers list automatically makes them accessible over this tunnel.  
  
-   Management servers that initiate connections to DirectAccess clients must fully support IPv6, by means of a native IPv6 address or by using an address that is assigned by ISATAP.  
  
### Plan Active Directory requirements  
Remote Access uses Active Directory as follows:  
  
-   **Authentication**: The infrastructure tunnel uses NTLMv2 authentication for the computer account that is connecting to the Remote Access server, and the account must be in an Active Directory domain. The intranet tunnel uses Kerberos authentication for the user to create the intranet tunnel.  
  
-   **Group Policy Objects**: Remote Access gathers configuration settings into Group Policy Objects (GPOs), which are applied to Remote Access servers, clients, and internal application servers.  
  
-   **Security groups**: Remote Access uses security groups to gather and identify DirectAccess client computers. GPOs are applied to the required security groups.  
  
When you plan an Active Directory environment for a Remote Access deployment, consider the following requirements:  
  
-   At least one domain controller is installed on the  Windows Server 2012 ,  Windows Server 2008 R2  Windows Server 2008 , or Windows Server 2003 operating system.  
  
    If the domain controller is on a perimeter network (and therefore reachable from the Internet-facing network adapter of Remote Access server), prevent the Remote Access server from reaching it. You need to add packet filters on the domain controller to prevent connectivity to the IP address of the Internet adapter.  
  
-   The Remote Access server must be a domain member.  
  
-   DirectAccess clients must be domain members. Clients can belong to:  
  
    -   Any domain in the same forest as the Remote Access server.  
  
    -   Any domain that has a two-way trust with the Remote Access server domain.  
  
    -   Any domain in a forest that has a two-way trust with the forest of the Remote Access server domain.  
  
> [!NOTE]  
> -   The Remote Access server cannot be a domain controller.  
> -   The Active Directory domain controller that is used for Remote Access must not be reachable from the external Internet adapter of the Remote Access server (the adapter must not be in the domain profile of Windows Firewall).  
  
#### Plan client authentication  
In Remote Access in  Windows Server 2012 , you can choose between using built-in Kerberos authentication, which uses user names and passwords, or using certificates for IPsec computer authentication.  
  
**Kerberos authentication**: When you choose to use Active Directory credentials for authentication, DirectAccess first uses Kerberos authentication for the computer, and then it uses Kerberos authentication for the user. When using this mode of authentication, DirectAccess uses a single security tunnel that provides access to the DNS server, the domain controller, and any other server on the internal network  
  
**IPsec authentication**: When you choose to use two-factor authentication or Network Access Protection, DirectAccess uses two security tunnels. The Remote Access Setup Wizard configures connection security rules in Windows Firewall with Advanced Security. These rules specify the following credentials when negotiating IPsec security to the Remote Access server:  
  
-   The infrastructure tunnel uses computer certificate credentials for the first authentication and user (NTLMv2) credentials for the second authentication. User credentials force the use of Authenticated Internet Protocol (AuthIP), and they provide access to a DNS server and domain controller before the DirectAccess client can use Kerberos credentials for the intranet tunnel.  
  
-   The intranet tunnel uses computer certificate credentials for the first authentication and user (Kerberos V5) credentials for the second authentication.  
  
#### Plan multiple domains  
The management servers list should include domain controllers from all domains that contain security groups that include DirectAccess client computers. It should contain all domains that contain user accounts that might use computers configured as DirectAccess clients. This ensures that users who are not located in the same domain as the client computer they are using are authenticated with a domain controller in the user domain.  
  
This authentication is automatic if the domains are in the same forest. If there is a security group with client computers or application servers that are in different forests, the domain controllers of those forests are not detected automatically. Forests are also not detected automatically. You can run the task **Update Management Servers** in the **Remote Access Management** to detect these domain controllers.  
  
Where possible, common domain name suffixes should be added to the NRPT during Remote Access deployment. For example, if you have two domains, domain1.corp.contoso.com and domain2.corp.contoso.com, instead of adding two entries into the NRPT, you can add a common DNS suffix entry, where the domain name suffix is corp.contoso.com. This happens automatically for domains in the same root. Domains that are not in the same root must be added manually.  
  
### Plan Group Policy Object creation  
When you configure Remote Access, DirectAccess settings are collected into Group Policy Objects (GPOs). Two GPOs are populated with DirectAccess settings, and they are distributed as follows:  
  
-   **DirectAccess client GPO**: This GPO contains client settings, including IPv6 transition technology settings, NRPT entries, and connection security rules for Windows Firewall with Advanced Security. The GPO is applied to the security groups that are specified for the client computers.  
  
-   **DirectAccess server GPO**: This GPO contains the DirectAccess configuration settings that are applied to any server that you configured as a Remote Access server in your deployment. It also contains connection security rules for Windows Firewall with Advanced Security.  
  
> [!NOTE]  
> Configuration of application servers is not supported in remote management of DirectAccess clients because clients cannot access the internal network of the DirectAccess server where the application servers reside. Step 4 in the Remote Access Setup configuration screen is unavailable for this type of configuration.  
  
You can configure GPOs automatically or manually.  
  
**Automatically**: When you specify that GPOs are created automatically, a default name is specified for each GPO.  
  
**Manually**: You can use GPOs that have been predefined by the Active Directory administrator.  
  
When you configure your GPOs, consider the following warnings:  
  
-   After DirectAccess is configured to use specific GPOs, it cannot be configured to use different GPOs.  
  
-   Use the following procedure to back up all Remote Access Group Policy Objects before you run DirectAccess cmdlets:  
  
    [Back up and Restore Remote Access Configuration](https://go.microsoft.com/fwlink/?LinkID=257928).  
  
-   Whether you are using automatically or manually configured GPOs, you need to add a policy for slow link detection if your clients will use 3G. The path for **Policy: Configure Group Policy slow link detection** is:  
  
    **Computer configuration/Polices/Administrative Templates/System/Group Policy**.  
  
-   If the correct permissions for linking GPOs do not exist, a warning is issued. The Remote Access operation will continue, but linking will not occur. If this warning is issued, links will not be created automatically, even if the permissions are added later. Instead the administrator needs to create the links manually.  
  
#### Automatically created GPOs  
Consider the following when using automatically created GPOs:  
  
Automatically created GPOS are applied according to the location and link target, as follows:  
  
-   For the DirectAccess server GPO, the location and link target point to the domain that contains the Remote Access server.  
  
-   When client and application server GPOs are created, the location is set to a single domain. The GPO name is looked up in each domain, and the domain is filled with DirectAccess settings if it exists.  
  
-   The link target is set to the root of the domain in which the GPO was created. A GPO is created for each domain that contains client computers or application servers, and the GPO is linked to the root of its respective domain.  
  
When using automatically created GPOs to apply DirectAccess settings, the Remote Access server administrator requires the following permissions:  
  
-   Permissions to create GPOs for each domain.  
  
-   Permissions to link to all the selected client domain roots.  
  
-   Permissions to link to the server GPO domain roots.  
  
-   Security permissions to create, edit, delete, and modify the GPOs.  
  
-   GPO read permissions for each required domain. This permission is not required, but it is recommended because it enables Remote Access to verify that GPOs with duplicate names do not exist when GPOs are being created.  
  
#### Manually created GPOs  
Consider the following when using manually created GPOs:  
  
-   The GPOs should exist before running the Remote Access Setup Wizard.  
  
-   To apply DirectAccess settings, the Remote Access server administrator requires full security permissions to create, edit, delete, and modify the manually created GPOs.  
  
-   A search is made for a link to the GPO in the entire domain. If the GPO is not linked in the domain, a link is automatically created in the domain root. If the required permissions to create the link are not available, a warning is issued.  
  
#### Recovering from a deleted GPO  
If a GPO on a Remote Access server, client, or application server has been deleted by accident, the following error message will appear: **GPO (GPO name) cannot be found**.  
  
If a backup is available, you can restore the GPO from the backup. If there is no backup available, you must remove the configuration settings and configure them again.  
  
###### To remove configuration settings  
  
1.  Run the Windows PowerShell cmdlet **Uninstall-RemoteAccess**.  
  
2.  Open **Remote Access Management**.  
  
3.  You will see an error message that the GPO is not found. Click **Remove configuration settings**. After completion, the server will be restored to an unconfigured state, and you can reconfigure the settings.  
  


