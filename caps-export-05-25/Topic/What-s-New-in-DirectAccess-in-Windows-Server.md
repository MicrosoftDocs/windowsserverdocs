---
title: What&#39;s New in DirectAccess in Windows Server
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bf96671b-cca4-4dfa-8c94-15532f03b4c4
author: vhorne
---
# What&#39;s New in DirectAccess in Windows Server
This topic contains information about new features for DirectAccess in Windows Server.  
  
## What's new in DirectAccess in Windows Server 2012 R2 and Windows Server 2012  
This section contains information about new features for DirectAccess in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], and contains the following sections:  
  
-   [DirectAccess and RRAS coexistence](#bkmk_coexist)  
  
-   [Simplified DirectAccess deployment](#bkmk_simplified)  
  
-   [Removal of PKI deployment as a DirectAccess prerequisite](#bkmk_pki)  
  
-   [NAT64 and DNS64 support for accessing IPv4\-only resources](#bkmk_nat64)  
  
-   [Support for DirectAccess Server behind a NAT device](#bkmk_nat)  
  
-   [Simplified network security policy](#bkmk_netsec)  
  
-   [Load balancing support](#bkmk_load)  
  
-   [Support for multiple domains](../Topic/What-s-New-in-DirectAccess-in-Windows-Server.md#bkmk_domains)  
  
-   [Support for token based authentication with One Time Password \(OTP\)](#bkmk_otp)  
  
-   [Automated support for force tunneling](#bkmk_force)  
  
-   [IP\-HTTPS interoperability and performance improvements](#bkmk_interop)  
  
-   [DirectAccess manage\-out to clients support](#bkmk_manage)  
  
-   [Multisite support](#bkmk_multisite)  
  
### <a name="bkmk_coexist"></a>DirectAccess and RRAS coexistence  
Both DirectAccess and RRAS implement security features to protect the server from hostile inbound traffic. Previously these security feature settings conflicted with each other if both services attempt to run on the same server, preventing either DirectAccess or RRAS from functioning as expected.  
  
DirectAccess relies on Internet Protocol version six \(IPv6\) transition technologies to establish client connections. RRAS implements Internet Key Exchange version 2 \(IKEv2\) Internet Protocol security \(IPsec\), and configures incoming and outgoing packet filters to drop all packets using transition technologies. This results in DirectAccess traffic being blocked if RRAS is installed and VPN access is deployed with IKEv2.  
  
DirectAccess implements IPsec Denial of Service Protection \(DoSP\) to protect resources on the corporate network. DoSP drops all IPv4 traffic, and all IPv6 traffic that is not protected by IPsec, except ICMPv6 packets. This results in all IPv4 packets and non\-IPsec\-protected IPv6 packets forwarded by RRAS being blocked if DirectAccess is installed.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]DirectAccess and RRAS unified server role solves these problems by modifying IKEv2 policies to allow IPv6 transition technology traffic, and by modifying IPsec DoSP to allow VPN traffic. These changes allow both DirectAccess and RRAS to coexist on the same server.  
  
### <a name="bkmk_simplified"></a>Simplified DirectAccess deployment  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] include features to facilitate deployment, particularly for small and medium size organizations. These new features include a simplified prerequisite list, removal of the need for a full PKI deployment, integrated certificate provisioning, and removal of the requirement for two consecutive public IPv4 addresses. Each of these features is discussed in more detail in the following sections.  
  
Administrators can now deploy DirectAccess using a new Getting Started Wizard, which presents a greatly simplified configuration experience. The Getting Started Wizard masks the complexity of DirectAccess, and allows for an automated setup in a few simple steps. The administrator no longer requires an understanding of the technical details of IPv6 transition technologies and Network Location Server \(NLS\) deployment.  
  
### <a name="bkmk_pki"></a>Removal of PKI deployment as a DirectAccess prerequisite  
One major deployment blocker for Windows 7 DirectAccess is the requirement of a PKI for server and client certificate\-based authentication. DirectAccess relies on IPsec AuthIP policies for authenticating and securing traffic from Internet\-connected clients. In order to authenticate to domain resources using Kerberos, the client must first establish connectivity to DNS servers and Domain Controllers \(DCs\).  
  
Windows 7 DirectAccess enables this connectivity by implementing two authentication methods in the AuthIP policies. The infrastructure IPsec tunnel is established using computer certificate as the first authentication method and user NTLM as the second method. Once this tunnel is established and a DC is available, the client can obtain a Kerberos token and establish the intranet IPsec tunnel using computer certificate and user Kerberos as the first and second authentication methods.  
  
This implementation requires that the DirectAccess server and all clients be provisioned with computer certificates for mutual authentication. Managing an internal PKI is considered difficult by many small and medium organizations. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] DirectAccess makes PKI deployment optional to simplify configuration and management.  
  
This functionality is achieved by implementing an HTTPS based Kerberos proxy. Client authentication requests are sent to a Kerberos proxy service running on the DirectAccess server. The Kerberos proxy then sends Kerberos requests to Domain Controllers on behalf of the client.  
  
The new Getting Started wizard provides a seamless experience for the administrator by configuring this solution automatically. In this simplified DirectAccess deployment, user level configuration options such as force tunneling, Network Access Protection \(NAP\) integration, and two\-factor authentication are not available. This deployment requires only one IPsec tunnel to be established, and has the following requirements:  
  
-   The DirectAccess server must have TCP port 443 open on its firewall.  
  
-   The DirectAccess server should have a server authentication certificate for TLS issued by a Certification Authority \(CA\) that is trusted by the DirectAccess clients. This can be a public CA and does not require an internal PKI deployment. If no certificate is available, the DirectAccess server setup process will configure the necessary IP\-HTTPS and KDC proxy certificate automatically as a self\-signed certificate.  
  
### <a name="bkmk_mat64"></a>NAT64 and DNS64 support for accessing IPv4\-only resources  
To allow access to internal IPv4\-only resources, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] DirectAccess includes native support for a protocol translation \(NAT64\) and name resolution \(DNS64\) gateway to convert the IPv6 communication from a DirectAccess client to IPv4 for the internal servers. IPv4\-only intranet computers cannot initiate connections to DirectAccess clients for remote management because the translation done with NAT64 is unidirectional \(for traffic initiated by the DirectAccess client\).  
  
There are three primary instances where IPv6\-only DirectAccess does not allow full access to corporate intranet resources.  
  
-   Intranet servers that are not fully IPv6 capable and support only IPv4, such as Windows Server 2003 file servers  
  
-   Environments where IPv6 has been administratively disabled on the network  
  
-   Applications running on IPv6 capable servers, such as [!INCLUDE[firstref_longhorn](../Token/firstref_longhorn_md.md)], which are not IPv6 capable themselves \(such as applications that are not able to listen and respond to traffic on the IPv6 interface\)  
  
To access these resources over DirectAccess, protocol translation must be done between the DirectAccess server and the internal IPv4\-only resources, with subsequent translation back to IPv6 for responses sent to DirectAccess clients. NAT64 receives IPv6 traffic from the client and converts it into IPv4 traffic to the intranet. NAT64 is used in combination with DNS64. DNS64 intercepts DNS queries from clients, and sends responses after converting IPv4 answers into associated IPv6 mappings on the NAT64.  
  
> [!NOTE]  
> Prior to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] DirectAccess, the only method available to provide protocol translation for DirectAccess is through deployment of Microsoft Forefront Unified Access Gateway DirectAccess.  
  
The DirectAccess setup wizard will seamlessly configure protocol translation components as a background operation, without any need for administrative interaction. There are no configuration options exposed to the administrator. The setup wizard will automatically enable NAT64 and DNS64 if the internal interface of the DirectAccess server has an IPv4 address assigned. To support this functionality, the setup wizard will configure an IPv6 network prefix for NAT64. The wizard assigns the NAT64 prefix automatically, and applies it to all IPv4 ranges in the enterprise.  
  
### <a name="bkmk_nat"></a>Support for DirectAccess Server behind a NAT device  
A [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DirectAccess server requires two network interfaces with two consecutive public IPv4 addresses assigned to the external interface. This is required so that it can act as a Teredo server. In order for clients behind a NAT to determine the Teredo server and the type of NAT device, the Teredo server requires two consecutive IPv4 addresses.  
  
This requirement presents difficulty for small and medium organizations that do not have access to consecutive, public IPv4 addresses. In the future this has the potential to become a deployment blocker as the available IPv4 address space is exhausted. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] DirectAccess provides the ability to deploy the DirectAccess server behind a NAT device, with support for a single network interface or multiple interfaces, and removes the public IPv4 address prerequisite.  
  
When the Remote Access Services setup Getting Started Wizard or Remote Access Setup Wizard is run, it will check the status of network interfaces on the server to determine if the DirectAccess server is located behind a NAT device. In this configuration, only IP over HTTPS \(IP\-HTTPS\) will be deployed. The IP\-HTTPS protocol is an IPv6 transition technology that allows for a secure IP tunnel to be established using a secure HTTP connection.  
  
### <a name="bkmk_netsec"></a>Simplified network security policy  
[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DirectAccess uses two IPsec tunnels to establish connectivity to the corporate network. The DirectAccess client requires the infrastructure tunnel to access infrastructure resources such as DNS, DC, and Management servers. These infrastructure servers are all listed as endpoints in the infrastructure tunnel IPsec policy. Then the intranet tunnel provides access to all other corporate intranet resources.  
  
The endpoints listed in the infrastructure tunnel policy require periodic updates as the infrastructure changes, such as when DNS servers or Domain Controllers are added to or removed from the production network. Clients can lose connectivity to the domain when their IPsec policies are not updated to reflect the current infrastructure server endpoints, and this loss of connectivity will prevent them from receiving group policy updates to correct the failure.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)], the Simplified DirectAccess model provides a way to deploy DirectAccess over a single IPsec tunnel, which eliminates this problem. However, Simplified DirectAccess does not support certain capabilities, which rely on certificate\-based authentication. Examples are two\-factor authentication with smart cards, multi\-site, and NAP integration. Enterprises requiring a full featured DirectAccess experience will still need to deploy the two\-tunnel model.  
  
If the two\-tunnel model is required for full functionality, there is additional functionality available to enable administrators to refresh the list of servers that are made accessible via the infrastructure tunnel. New domain controllers and System Center Configuration Manager servers are discovered and added to the list. Servers that no longer exist are removed from the list, and entries for servers whose IP addresses have changed are updated.  
  
### <a name="bkmk_load"></a>Load balancing support  
[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DirectAccess does not provide a full high availability solution, and is limited to single\-server deployments. To provide limited hardware redundancy, DirectAccess can be configured inside a Hyper\-V Failover cluster configured for Hyper\-V Live Migration. However, only one server node may be online at any time.  
  
DirectAccess deployments have quickly grown beyond the point where a single server can provide adequate processing power. Enterprises need the flexibility to deploy additional servers quickly and transparently to meet changing load requirements. Additionally, the Network Location Server used for inside\/outside detection must be highly available to prevent major outages for DirectAccess clients connected to the intranet.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] DirectAccess addresses these issues through built\-in support for Windows Network Load Balancing \(NLB\) to achieve high availability and scalability for both DirectAccess and RRAS VPN. The NLB configuration is simple to setup and automate through the new deployment wizard interface. The setup process also provides integrated support for third party external hardware\-based load balancer solutions.  
  
> [!IMPORTANT]  
> [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] DirectAccess provides a basic failover solution using Network Load Balancing for up to eight nodes. Although server load will be shared across all NLB nodes, existing connections will not automatically be transferred to other servers when one server becomes unavailable.  
  
### <a name="bkmk_domains"></a>Support for multiple domains  
The DirectAccess setup wizard in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] can be used to configure DirectAccess for a single domain only. This means that remote clients from a different domain from the DirectAccess server will not be able to use DirectAccess. In addition, if application servers are in a different domain, remote clients will not be able to access them remotely via DirectAccess.  
  
Although administrators can manually configure multiple domain support in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], the deployment requires manual edit of the DirectAccess policies after setup is completed. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] DirectAccess provides integrated multiple domain support to allow remote client access to enterprise resources located in different domains.  
  
### <a name="bkmk_otp"></a>Support for token\-based authentication with One Time Password \(OTP\)  
To increase login security, many organizations have deployed One\-Time Password \(OTP\) two\-factor authentication, and mandate its use for remote access connections. [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DirectAccess provided support for two\-factor authentication with Smart Cards, but was not capable of integrating with OTP vendor solutions, such as RSA SecurID. This prevented DirectAccess deployment in organizations that require this level of security.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] DirectAccess supports two\-factor authentication with Smart Cards or OTP token based solutions. This feature requires a PKI deployment, so if the option is selected in the DirectAccess Setup Wizard, the **Use computer certificates** option is automatically selected and enforced.  
  
In addition to support for standard smart card authentication, DirectAccess can use the Trusted Platform Module \(TPM\)\-based virtual smart card capabilities available in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]. The TPM of client computers can act as a virtual smart card for two\-factor authentication, thus removing the overhead and costs incurred in smart card deployment.  
  
### <a name="bkmk_force"></a>Automated support for force tunneling  
By default, DirectAccess clients are able to access the Internet, the corporate intranet, and local LAN resources simultaneously. Since only connections made to the corporate intranet are sent over the DirectAccess IPsec tunnels, this is known as a split\-tunnel configuration. Split tunneling provides an optimal user experience when accessing resources on the Internet, while still providing strong security for traffic intended for the intranet.  
  
Although split tunneling is not a security risk, some organizations have a requirement to force all traffic through a corporate proxy so that it can be inspected by their IDS. With legacy VPN connections, the potential exists for users to bridge traffic between networks, such as a home network and the corporate network, effectively making the client operate as a router. For this reason, it is common practice for administrators to disable split tunneling for VPN connections, forcing all network traffic to be routed through the VPN connection. This results in decreased performance when accessing Internet resources, since all traffic must traverse the VPN tunnel and then be proxied out to the Internet. It also consumes significant additional bandwidth on the corporate network.  
  
The perceived security risk of split tunneling is not valid in a DirectAccess scenario, since the IPsec rules that enable DirectAccess require authentication by the client endpoint. If another endpoint attempts to route through the DirectAccess client, it will not be an authenticated source, and IPsec will prevent the connection. However, since some organizations have a requirement to force all traffic through the corporate proxy server so that it can be inspected, the DirectAccess Force Tunneling option provides this ability.  
  
The Force Tunneling option was provided in [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DirectAccess, but required manual steps to enable it via group policy setting. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] DirectAccess integrate the Force Tunneling option with the Setup Wizard and management UI to automate the required settings. Enabling the Force Tunneling option limits the DirectAccess client to using only the IP\-HTTPS protocol for connectivity, and by default uses the DirectAccess server as the NAT64\/DNS64 server to translate IPv6 resources to send to the IPv4 proxy server.  
  
### <a name="bkmk_interop"></a>IP\-HTTPS interoperability and performance improvements  
On certain networks, Internet firewall settings may prevent successful client connections using the 6to4 or Teredo IPv6 transition technologies. IP\-HTTPS is an IPv6 transition technology introduced in Windows 7 to ensure that DirectAccess clients can connect to the corporate network even when all other IPv6 transition technologies fail. IP\-HTTPS assigns a unique, globally routable IPv6 address to an IPv4 host, encapsulates the IPv6 packets within IPv4 for transmission over an HTTPS tunnel, and routes IPv6 traffic between the host and other globally routable IPv6 nodes.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] provide several improvements to the implementation of IP\-HTTPS. Changes to the technology allow IP\-HTTPS clients to obtain proxy configuration information, and authenticate to an HTTP proxy if authentication is required. The Windows 7 requirement to deploy client certificates to each IP\-HTTPS client has been removed.  
  
IP\-HTTPS works by creating an SSL\/TLS connection between the client and server, then passing IP traffic across the connection. This data is encrypted by IPsec, which means that the data is encrypted twice, first by IPsec, and again by SSL. The result is poor performance and a negative user experience compared to the other IPv6 transition technologies 6to4 and Teredo, and limits the scalability of the DirectAccess server.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] DirectAccess includes several performance improvements for IP\-HTTPS to increase scalability and reduce the overhead associated with this connectivity method. These optimizations include changes to batched send behavior and receive buffers, reduced lock contention, and the option to implement SSL with NULL encryption.  
  
IP\-HTTPS runs in a system context rather than a user context. This context can cause connection issues.  For example, if a DirectAccess client computer is located in the network of a partner company that uses a proxy for Internet access, and WPAD auto detection is not used, the user must manually configure proxy settings in order to access the Internet. These settings are configured in Internet Explorer on a per user basis, and cannot be retrieved in an intuitive way on behalf of IP\-HTTPS.  In addition, if the proxy requires authentication, the client provides credentials for Internet access, but IP\-HTTPS will not provide the credentials required to authenticate to DirectAccess. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], a new feature solves these issues. Specifically, the user can configure IP\-HTTPS to work when behind a proxy that is not configured using WPAD and IP\-HTTPS will request and provide the proxy credentials needed to IP\-HTTPS request authenticated, and relay it to the DirectAccess server.  
  
When configuring IP\-HTTPS in DirectAccess on the server, you can use a certificate issued by a certification authority \(CA\), or you can specify that DirectAccess should automatically generate a self\-signed certificate.  
  
### <a name="bkmk_manage"></a>DirectAccess manage\-out to clients support  
DirectAccess clients establish connectivity to the corporate intranet whenever an Internet connection is available, even if there is no user logged in. This allows IT administrators to manage remote machines for patching and compliance enforcement even when they are not in the office. Some customers see this as the primary benefit to DirectAccess, and choose to keep their existing remote access solution in place for user connectivity, while using DirectAccess just for remote management.  
  
[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] DirectAccess does not provide an automated method to limit the deployment to manage\-out only, and administrators must manually edit the policies created by the setup wizard. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] DirectAccess provide support for a manage\-out only configuration through a deployment wizard option that limits the creation of policies to only those needed for remote management of client computers. In this deployment, user level configuration options such as force tunneling, NAP integration, and two\-factor authentication are not available.  
  
> [!NOTE]  
> Manage\-out support requires ISATAP deployment or management servers with v6 addresses.  
  
### <a name="bkmk_multisite"></a>Multisite support  
DirectAccess servers can be deployed in multiple sites to increase capacity and provide more efficient access to the nearest entry point for intranet resources. This works well if clients remain in their respective sites and do not need to travel to different sites within the enterprise. However, setting up multisite DirectAccess requires careful planning and design if clients will roam between sites, to ensure that they connect through DirectAccess servers via the most efficient route.  
  
There are many challenges to consider in a multisite environment, such as making sure the client locates the closest IP\-HTTPS server, Teredo server, DNS server, and Domain Controller. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] DirectAccess provide a solution that allows for deployment of multiple DirectAccess entry points across geographic locations, and allows clients regardless of their physical location to access resources within corpnet in an efficient manner.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] DirectAccess servers can be configured in a multisite deployment that allows remote users in dispersed geographical locations to connect to the multisite entry point closest to them. For client computers running [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], entry points can be assigned automatically, or selected manually by the client. For Windows 7 client computers, entry points can be allocated statically. Traffic across the multisite deployment can be distributed and balanced with external traffic across the multisite deployment, all of which can be distributed and balanced with an external global load balancer.  
  
## See also  
  
-   [DirectAccess in Windows Server](../Topic/DirectAccess-in-Windows-Server.md)  
  
-   [What's New in DirectAccess for Windows Server 2008 R2 SP1](http://technet.microsoft.com/library/hh226652(v=ws.10).aspx)  
  
