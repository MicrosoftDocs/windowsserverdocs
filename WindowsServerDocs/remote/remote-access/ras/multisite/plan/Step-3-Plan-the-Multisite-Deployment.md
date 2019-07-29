---
title: Step 3 Plan the Multisite Deployment
description: This topic is part of the guide Deploy Multiple Remote Access Servers in a Multisite Deployment in Windows Server 2016.
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e5ea9d22-a503-4ed4-96b3-0ee2ccf4fd17
ms.author: pashort
author: shortpatti
---
# Step 3 Plan the Multisite Deployment

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

After planning the multisite infrastructure, plan any additional certificate requirements, how client computers select entry points, and IPv6 addresses assigned in your deployment.  

The following sections provide detailed planning information.
  
## <a name="bkmk_3_1_IPHTTPS"></a>3.1 Plan IP-HTTPS certificates  
When you configure the entry points, you configure each entry point with a specific ConnectTo address. The IP-HTTPS certificate for each entry point must match the ConnectTo address. Note the following when obtaining the certificate:  
  
-   You cannot use self-signed certificates in a multisite deployment.  
  
-   Using a public CA is recommended, so that CRLs are readily available.  
  
-   In the subject field, specify either the IPv4 address of the external adapter of Remote Access server (if the ConnectTo address has been specified as an IP address and not a DNS name), or the FQDN of the IP-HTTPS URL.  
  
-   The common name of the certificate should match the name of the IP-HTTPS website. Use of a wildcard URL that matches the ConnectTo DNS name is also supported.  
  
-   IP-HTTPS certificates can use wildcards in the subject name. The same wildcard certificate can be used for all entry points.  
  
-   For the Enhanced Key Usage field, use the Server Authentication object identifier (OID).  
  
-   If you are supporting client computers running Windows 7 in the multisite deployment, in the CRL Distribution Points field, specify a CRL distribution point that is accessible by DirectAccess clients that are connected to the Internet. This is not required for clients running Windows 8 (by default the CRL revocation check is disabled for IP-HTTPS on these clients).  
  
-   The IP-HTTPS certificate must have a private key.  
  
-   The IP-HTTPS certificate must be imported directly into the personal store of the computer, and not of the user.  
  
## <a name="bkmk_3_2_NLS"></a>3.2 Plan the network location server  
The network location server website can be hosted on the Remote Access server or on another server in your organization. If you host the network location server on the Remote Access server, the website is created automatically when you deploy Remote Access. If you host the network location server on another server running a Windows operating system in your organization, you must make sure that Internet Information Services (IIS) is installed to create the website.  
  
### 3.2.1 Certificate requirements for the network location server  
Make sure that the network location server website meets the following requirements for certificate deployment:  
  
-   It requires an HTTPS server certificate.  
  
-   If the network location server is located on the Remote Access server, and you selected to use a self-signed certificate when you deployed the single Remote Access server, you must reconfigure the single server deployment to use a certificate issued by an internal CA.  
  
-   DirectAccess client computers must trust the CA that issued the server certificate to the network location server website.  
  
-   DirectAccess client computers on the internal network must be able to resolve the name of the network location server website.  
  
-   The network location server website must be highly available to computers on the internal network.  
  
-   The network location server must not be accessible to DirectAccess client computers on the Internet.  
  
-   The server certificate must be checked against a Certificate Revocation List (CRL).  
  
-   Wildcard certificates are not supported when the network location server is hosted on the Remote Access server.  
  
When obtaining the website certificate to use for the network location server, note the following:  
  
1.  In the Subject field, specify either an IP address of the intranet interface of the network location server or the FQDN of the network location URL. Note that you should not specify an IP address if the network location server is hosted on the Remote Access server. This is because the network location server must use the same subject name for all entry points, and not all entry points have the same IP address.  
  
2.  For the Enhanced Key Usage field, use the Server Authentication OID.  
  
3.  For the CRL Distribution Points field, use a CRL distribution point that is accessible by DirectAccess clients that are connected to the intranet.  
  
### 3.2.2DNS for the network location server  
If you host the network location server on the Remote Access server, you must add a DNS entry for the network location server website for every entry point in your deployment. Note the following:  
  
-   The subject name of the first network location server certificate in the multisite deployment is used as the network location server URL for all entry points, therefore the subject name and the network location server URL cannot be the same as the computer name of the first Remote Access server in the deployment. It must be an FQDN dedicated for the network location server.  
  
-   The service provided by the network location server traffic is balanced across entry points using DNS, and therefore there should be a DNS entry with the same URL for each entry point, configured with the internal IP address of the entry point.  
  
-   All entry points must be configured with a network location server certificate with the same subject name (that matches the network location server URL).  
  
-   The network location server infrastructure (DNS and certificate settings) for an entry point must be created before adding the entry point.  
  
## <a name="bkmk_3_3_IPsec"></a>3.3 Plan the IPsec root certificate for all Remote Access servers  
Note the following when planning for IPsec client authentication in a multisite deployment:  
  
1.  If you opted to use the built-in Kerberos proxy for computer authentication when you set up the single Remote Access server, you must change the setting to use computer certificates issued by an internal CA, since Kerberos proxy is not supported for a multisite deployment.  
  
2.  If you used a self-signed certificate, you must reconfigure the single server deployment to use a certificate issued by an internal CA.  
  
3.  For IPsec authentication to succeed during client authentication, all Remote Access servers must have a certificate issued by the IPsec root or intermediate CA, and with the Client Authentication OID for Enhanced Key Usage.  
  
4.  The same IPsec root or intermediate certificate must be installed on all of the Remote Access servers in the multisite deployment.  
  
## <a name="bkmk_3_4_GSLB"></a>3.4 Plan global server load balancing  
In a multisite deployment, you can additionally configure a global server load balancer. A global server load balancer can be useful to your organization if your deployment covers a large geographical distribution because it can distribute traffic load between the entry points.  The global server load balancer can be configured to provide DirectAccess clients with the entry point information of the closest entry point. The process works as follows:  
  
1.  Client computers running Windows 10 or Windows 8 have a list of global server load balancer IP addresses, each associated with an entry point.  
  
2.  The Windows 10 or Windows 8 client computer attempts to resolve the FQDN of the global server load balancer in the public DNS to an IP address. If the resolved IP address is listed as the global server load balancer IP address of an entry point, the client computer automatically selects that entry point and connects to its IP-HTTPS URL (ConnectTo address), or to its Teredo server IP address. Note that the IP address of the global server load balancer does not need to be identical to the ConnectTo address or to the Teredo server address of the entry point, since the client computers never try to connect to the global server load balancer IP address.  
  
3.  If the client computer is behind a web proxy (and cannot use DNS resolution), or if the global server load balancer FQDN does not resolve to any configured global server load balancer IP address, then an entry point will be selected automatically using an HTTPS probe to the IP-HTTPS URLs of all entry points. The client will connect to server that responds first.  
  
For a list of global server load balancing devices that support Remote Access, go to the Find a Partner page at [Microsoft Server and Cloud Platform](https://www.microsoft.com/server-cloud/).  
  
## <a name="bkmk_3_5_EP_Selection"></a>3.5 Plan DirectAccess client entry point selection  
When you configure a multisite deployment, by default, Windows 10 and Windows 8 client computers are configured with the information required to connect to all entry points in the deployment and to automatically connect to a single entry point based on a selection algorithm. You can also configure your deployment to allow Windows 10 and Windows 8 client computers to manually select the entry point to which they will connect. If a Windows 10 or Windows 8 client computer is currently connected to the United States entry point and automatic entry point selection is enabled, if the United States entry point becomes unreachable, after a few minutes the client computer will attempt to connect through the Europe entry point. Using automatic entry point selection is recommended; however, allowing manual entry point selection enables end users to connect to a different entry point based on current network conditions. For example, if a computer is connected to the United States entry point and the connection to the internal network becomes much slower than expected. In this situation, the end user can manually select to connect to the Europe entry point to improve the connection to the internal network.  
  
> [!NOTE]  
> After an end user selects an entry point manually, the client computer will not revert to automatic entry point selection. That is, if the manually selected entry point becomes unreachable, the end user must either revert to automatic entry point selection, or manually select another entry point.  
  
 Windows 7  client computers are configured with the information required to connect to a single entry point in the multisite deployment. They cannot store the information for multiple entry points simultaneously. For example, a  Windows 7  client computer can be configured to connect to the United States entry point, but not the Europe entry point. If the United States entry point is unreachable, the  Windows 7  client computer will lose connectivity to the internal network until the entry point is reachable. The end user cannot make any changes to attempt to connect to the Europe entry point.  
  
## <a name="bkmk_3_6_IPv6"></a>3.6 Plan prefixes and routing  
  
### Internal IPv6 prefix  
During deployment of the single Remote Access server you planned the internal network IPv6 prefixes Note the following in a multisite deployment:  
  
1.  If you included all of your Active Directory sites when you configured your single server Remote Access deployment, the internal network IPv6 prefixes will already be defined in the Remote Access Management console.  
  
2.  If you create additional Active Directory sites for multisite deployment, you must plan new IPv6 prefixes for the additional sites and define them in Remote Access. Note that IPv6 prefixes can only be configured using the Remote Access Management console or PowerShell cmdlets if IPv6 is deployed in the internal corporate network.  
  
### IPv6 prefix for DirectAccess client computers (IP-HTTPS prefix)  
  
1.  If IPv6 is deployed in the internal corporate network, you must plan an IPv6 prefix to assign to DirectAccess client computers in any additional entry points in your deployment.  
  
2.  Ensure that the IPv6 prefixes to assign to DirectAccess client computers in each entry point are distinct and that there is no overlap in the IPv6 prefixes.  
  
3.  If IPv6 is not deployed in the corporate network, an IP-HTTPS prefix for each entry point will be automatically selected when adding the entry point.  
  
### IPv6 prefix for VPN clients  
If you deployed VPN on the single Remote Access server, note the following:  
  
1.  Adding an IPv6 VPN prefix to an entry point is only required if you want to allow VPN client IPv6 connectivity to the corporate network.  
  
2.  The VPN prefix can only be configured on an entry point using the Remote Access Management console or PowerShell cmdlet if IPv6 is deployed in the internal corporate network, and if VPN is enabled on the entry point.  
  
3.  The VPN prefix should be unique in each entry point and should not overlap with other VPN or IP-HTTPS prefixes.  
  
4.  If IPv6 is not deployed in the corporate network, VPN clients connecting to the entry point will not be assigned an IPv6 address.  
  
### Routing  
In a multisite deployment symmetric routing is enforced using Teredo and IP-HTTPS. When IPv6 is deployed in the corporate network note the following:  
  
1. The Teredo and IP-HTTPS prefixes of each entry point must be routable across the corporate network to their associated Remote Access server.  
  
2. The routes must be configured in the corporate network routing infrastructure.  
  
3. For each entry point there should be one to three routes in the internal network:  
  
   1. IP-HTTPS prefix-This prefix is chosen by the administrator in the Add an Entry Point wizard.  
  
   2. VPN IPv6 prefix (optional). This prefix can be chosen after enabling VPN for an entry point  
  
   3. Teredo prefix (optional). This prefix is relevant only if the Remote Access server is configured with two consecutive public IPv4 addresses on the external adapter. The prefix is based on the first public IPv4 address of the address pair. For example if the external addresses are:  
  
      1. www\.xxx.yyy.zzz  
  
      2. www\.xxx.yyy.zzz+1  
  
      Then the Teredo prefix to configure is 2001:0:WWXX:YYZZ::/64, where WWXX:YYZZ is the hexadecimal representation of the IPv4 address www\.xxx.yyy.zzz.  
  
      Note that you can use the following script to calculate the Teredo prefix:  
  
      ```  
      $TeredoIPv4 = (Get-NetTeredoConfiguration).ServerName # Use for a Remote Access server that is already configured  
      $TeredoIPv4 = "20.0.0.1" # Use for an IPv4 address  
  
          [Byte[]] $TeredoServerAddressBytes = `  
          [System.Net.IPAddress]::Parse("2001::").GetAddressBytes()[0..3] + `  
          [System.Net.IPAddress]::Parse($TeredoIPv4).GetAddressBytes() + `  
          [System.Net.IPAddress]::Parse("::").GetAddressBytes()[0..7]  
  
      Write-Host "The server's Teredo prefix is $([System.Net.IPAddress]$TeredoServerAddressBytes)/64"  
      ```  
  
   4. All of the above routes must be routed to the IPv6 address on the internal adapter of the Remote Access server (or to the internal virtual IP (VIP) address for a load balanced entry point).  
  
> [!NOTE]  
> When IPv6 is deployed in the corporate network and Remote Access server administration is performed remotely over DirectAccess, routes for the Teredo and IP-HTTPS prefixes of all other entry points must be added to each Remote Access server so that the traffic will be forwarded to the internal network.  
  
### Active Directory site-specific IPv6 prefixes  
When a client computer running Windows 10 or Windows 8 is connected to an entry point, the client computer is immediately associated with the Active Directory site of the entry point, and is configured with IPv6 prefixes associated with the entry point. The preference is for client computers to connect to resources using these IPv6 prefixes, since they are configured dynamically in the IPv6 prefix policy table with higher precedence when connecting to an entry point.  
  
If your organization uses an Active Directory topology with site-specific IPv6 prefixes (for example an internal resource FQDN app.corp.com is hosted in both North America and Europe with a site-specific IP address in each location) this is not configured by default using the Remote Access console, and site-specific IPv6 prefixes are not configured for each entry point. If you do want to enable this optional scenario, you need to configure each entry point with the specific IPv6 prefixes that should be preferred by client computers connecting to a specific entry point. Do this as follows:  
  
1.  For each GPO used for Windows 10 or Windows 8 client computers, run the Set-DAEntryPointTableItem PowerShell cmdlet  
  
2.  Set the EntryPointRange parameter for the cmdlet with the site-specific IPv6 prefixes. For example, to add the site-specific prefixes 2001:db8:1:1::/64 and 2001:db:1:2::/64 to an entry point called Europe, run the following  
  
    ```  
    $entryPointName = "Europe"  
    $prefixesToAdd = @("2001:db8:1:1::/64", "2001:db8:1:2::/64")  
    $clientGpos = (Get-DAClient).GpoName  
    $clientGpos | % { Get-DAEntryPointTableItem -EntryPointName $entryPointName -PolicyStore $_ | %{ Set-DAEntryPointTableItem -PolicyStore $_.PolicyStore -EntryPointName $_.EntryPointName -EntryPointRange ($_.EntryPointRange) + $prefixesToAdd}}  
    ```  
  
3.  When modifying the EntryPointRange parameter, ensure that you do not remove the existing 128-bit prefixes which belong to the IPsec tunnel endpoints and the DNS64 address.  
  
## <a name="bkmk_3_7_TransitionIPv6"></a>3.7 Plan the transition to IPv6 when multisite Remote Access is deployed  
Many organizations use the IPv4 protocol on the corporate network. With the exhaustion of available IPv4 prefixes, many organizations are making the transition from IPv4-only to IPv6-only networks.  
  
This transition is most likely to take place in two stages:  
  
1.  From an IPv4-only to an IPv6+IPv4 corporate network.  
  
2.  From an IPv6+IPv4 to an IPv6-only corporate network.  
  
In each part, the transition may be performed in stages. In each stage only one subnet of the network may be changed to the new network configuration. Therefore, a DirectAccess multisite deployment is required to support a hybrid deployment where, for example, some of the entry points belong to an IPv4-only subnet and others belong to an IPv6+IPv4 subnet. In addition, configuration changes during the transition processes must not break client connectivity via DirectAccess.  
  
### <a name="TransitionIPv4toMixed"></a>Transition from an IPv4-only to an IPv6+IPv4 corporate network  
When adding IPv6 addresses to an IPv4-only corporate network, you may want to add an IPv6 address to an already deployed DirectAccess server. In addition, you may want to add an entry point or a node to a load balanced cluster with both IPv4 and IPv6 addresses to the DirectAccess deployment.  
  
Remote Access allows you to add servers with both IPv4 and IPv6 addresses to a deployment that was originally configured with only IPv4 addresses. These servers are added as IPv4-only servers and their IPv6 addresses are ignored by DirectAccess; consequently, your organization cannot take advantage of the benefits of native IPv6 connectivity on these new servers.  
  
To transform the deployment to an IPv6+IPv4 deployment and take advantage of the native IPv6 capabilities, you must reinstall DirectAccess. To maintain client connectivity throughout the reinstallation see Transition from an IPv4-only to an IPv6-only deployment using dual DirectAccess deployments.  
  
> [!NOTE]  
> As with an IPv4-only network, in a mixed IPv4+IPv6 network, the address of the DNS server that is used to resolve client DNS requests must be configured with the DNS64 that is deployed on Remote Access servers themselves, and not with a corporate DNS.  
  
### <a name="TransitionMixedtoIPv6"></a>Transition from an IPv6+IPv4 to an IPv6-only corporate network  
DirectAccess enables you to add IPv6-only entry points only if the first Remote Access server in the deployment originally had either both IPv4 and IPv6 addresses or only an IPv6 address. That is, you cannot transition from an IPv4-only network to an IPv6-only network in a single step without reinstalling DirectAccess. To transition directly from an IPv4-only network to an IPv6-only network, see Transition from an IPv4-only to an IPv6-only deployment using dual DirectAccess deployments.  
  
After you have completed the transition from an IPv4-only deployment to an IPv6+IPv4 deployment, you can transition to an IPv6-only network. During, and after the transition, note the following:  
  
-   If any IPv4-only backend servers remain in the corporate network, they will not be reachable to clients that connect through the IPv6-only entry points.  
  
-   When adding IPv6-only entry points to an IPv4+IPv6 deployment, DNS64 and NAT64 will not be enabled on the new servers. Clients that connect to these entry points will be automatically configured to use the corporate DNS servers.  
  
-   If you need to delete IPv4 addresses from a deployed server, you must remove the server from the DirectAccess deployment, remove its IPv4 corporate network address, and add it again to the deployment.  
  
To support client connectivity to the corporate network, you must ensure that the network location server can be resolved by the corporate DNS to its IPv6 address. An additional IPv4 address can be set as well, but isn't required.  
  
### <a name="DualDeployment"></a>Transition from an IPv4-only to an IPv6-only deployment using dual DirectAccess deployments  
The transition from an IPv4-only to an IPv6-only corporate network cannot be done without reinstalling the DirectAccess deployment. To maintain client connectivity during the transition, you can use another DirectAccess deployment. Dual deployment is required when the first transition stage finishes (IPv4-only network upgraded to IPv4+IPv6) and you intend to prepare for a future transition to an IPv6-only corporate network orto take advantage of the native IPv6 connectivity benefits. The dual deployment is described in the following general steps:  
  
1.  Install a second DirectAccess deployment. You can install DirectAccess on new servers, or remove servers from the first deployment and use them for the second deployment.  
  
    > [!NOTE]  
    > When installing an additional DirectAccess deployment alongside a current one, make sure that no two entry points share the same client prefix.  
    >   
    > If you install DirectAccess using the Getting Started Wizard or with the cmdlet `Install-RemoteAccess`, Remote Access automatically sets the client prefix of the first entry point in the deployment to a default value of <IPv6 subnet\_prefix>:1000::/64. If needed, you must change the prefix.  
  
2.  Remove the chosen client security groups from the first deployment.  
  
3.  Add the client security groups to the second deployment.  
  
    > [!IMPORTANT]  
    > To maintain client connectivity throughout the process, you must add the security groups to the second deployment immediately after removing them from the first. This ensures that clients will not be updated with either two or zero DirectAccess GPOs. Clients will start using the second deployment once they retrieve and update their client GPO.  
  
4.  Optional: Remove the DirectAccess entry points from the first deployment and add those servers as new entry points in the second.  
  
When you have completed the transition, you can uninstall the first DirectAccess deployment. When uninstalling, the following issues may occur:  
  
-   If the deployment was configured to support only clients on mobile computers, the WMI filter will be deleted. If the client security groups of the second deployment include desktop computers, the DirectAccess client GPO will not filter desktop computers and may cause issues on them. If a mobile computers filter is needed, recreate it by following the instructions on [Create WMI Filters for the GPO](https://technet.microsoft.com/library/cc947846.aspx).  
  
-   If both deployments were originally created on the same Active Directory domain, the DNS probe entry which points to localhost will be deleted and may cause client connectivity issues. For example, clients may connect using IP-HTTPS rather than Teredo, or switch between DirectAccess multisite entry points. In this case, you must add the following DNS entry to the corporate DNS:  
  
    -   Zone: domain name  
  
    -   Name: directaccess-corpConnectivityHost  
  
    -   IP address: ::1  
  
    -   Type: AAAA  
  
  
  


