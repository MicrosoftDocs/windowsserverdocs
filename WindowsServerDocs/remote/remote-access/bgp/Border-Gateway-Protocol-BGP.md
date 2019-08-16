---
title: Border Gateway Protocol (BGP)
description: You can use this topic to gain an understanding of Border Gateway Protocol (BGP) in Windows Server 2016, including BGP supported deployment topologies and BGP features and capabilities. 
manager: brianlic
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: networking-ras
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 78cc2ce3-a48e-45db-b402-e480b493fab1
ms.author: pashort
author: shortpatti
---
# Border Gateway Protocol (BGP)

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

You can use this topic to gain an understanding of Border Gateway Protocol (BGP), including BGP supported deployment topologies and BGP features and capabilities.  
  
> [!NOTE]  
> In addition to this topic, the following BGP documentation is available.  
>   
> -   [BGP Windows PowerShell Command Reference](../../remote-access/bgp/BGP-Windows-PowerShell-Command-Reference.md)  
  
This topic contains the following sections.  
  
-   [BGP Supported Deployment Topologies](#bkmk_top)  
  
-   [BGP Features](#bkmk_features)  
  
When configured on a  Windows Server 2016 Remote Access Service \(RAS\) Gateway in multitenant mode, Border Gateway Protocol (BGP) provides you with the ability to manage the routing of network traffic between your tenants' VM networks and their remote sites. You can also use BGP for single tenant RAS Gateway deployments, and when you deploy Remote Access as a Local Area Network \(LAN\) router.  
  
BGP reduces the need for manual route configuration on routers because it is a dynamic routing protocol, and automatically learns routes between sites that are connected by using site-to-site VPN connections.  
  
To use BGP routing, you must install the **Remote Access Service \(RAS\)** and/or the **Routing** role service of the Remote Access server role on a computer or virtual machine \(VM\) - the type of system you use depends on whether or not you have a multitenant deployment:  
  
-   For a multitenant deployment, it is recommended that you install the RAS Gateway on one or more VMs. Use of multiple VMs provides high availability. The RAS Gateway is capable of handling multiple connections from multiple tenants, and consists of a Hyper-V host and a VM that is actually configured as the gateway. This gateway is configured with site-to-site VPN connections as a multitenant BGP router to exchange tenant and Cloud Service Provider \(CSP\) subnet routes.  
  
-   For a single tenant edge gateway deployment or a LAN router deployment, you can install the RAS Gateway on either a physical computer or a VM.  
  
> [!IMPORTANT]  
> When you install a RAS Gateway, you must specify whether BGP is enabled for each tenant by using the **Enable-RemoteAccessRoutingDomain** Windows PowerShell command with the **Type** parameter value of **All**. To install Remote Access as a BGP-enabled LAN router without multitenant capabilities, you can use the command **Install-RemoteAccess -VpnType RoutingOnly**.  
>   
> The following example code illustrates how to install RAS in Multitenancy mode with all RAS features (point-to-site VPN, site-to-site VPN, and BGP routing) enabled for two tenants, Contoso and Fabrikam.  
  
```  
$Contoso_RoutingDomain = "ContosoTenant"  
$Fabrikam_RoutingDomain = "FabrikamTenant"  
  
Install-RemoteAccess -MultiTenancy  
  
Enable-RemoteAccessRoutingDomain -Name $Contoso_RoutingDomain -Type All -PassThru  
Enable-RemoteAccessRoutingDomain -Name $Fabrikam_RoutingDomain -Type All -PassThru  
```  
  
## <a name="bkmk_top"></a>BGP Supported Deployment Topologies  
Listed below are the supported deployment topologies where Enterprise sites are connected to a Cloud Service Provider (CSP) datacenter.  
  
In all scenarios, the CSP gateway is a  Windows Server 2016 RAS Gateway at the edge. The RAS Gateway, which is capable of handling multiple connections from multiple tenants, consists of a Hyper-V host and a VM that is actually configured as the gateway. This edge gateway is configured with site-to-site VPN connections as a multitenant BGP router to exchange Enterprise and CSP subnet routes.  
  
Tenants connect to their resources at the CSP datacenter by using a site-to-site (S2S) VPN connection. In addition, the BGP routing protocol is deployed for dynamic routing information exchange between the Enterprise and CSP gateways.  
  
The following deployment topologies are supported.  
  
-   [RAS VPN Site-to-Site Gateway with BGP at Enterprise site edge](#bkmk_top1)  
  
-   [Third party Gateway with BGP at Enterprise site edge](#bkmk_top2)  
  
-   [Multiple Enterprise sites with third party gateways](#bkmk_top3)  
  
-   [Separate termination points for BGP and VPN](#bkmk_top4)  
  
The following sections contain additional information on each supported BGP topology.  
  
### <a name="bkmk_top1"></a>RAS VPN Site-to-Site Gateway with BGP at Enterprise site edge  
This topology depicts an Enterprise site connected to a CSP. The Enterprise routing topology includes an internal router, a  Windows Server 2016 RAS Gateway configured for VPN site-to-site connections with the CSP, and an edge firewall device. The RAS Gateway terminates the S2S VPN and BGP connections.  
  
![RAS VPN Site-to-Site Gateway](../../media/Border-Gateway-Protocol-BGP/bgp_01.jpg)  
  
Both sites are connected using External Border Gateway Protocol (eBGP), which can transmit information between BGP-enabled routers in separate autonomous systems (AS). This requires that both the Enterprise and the CSP have distinct Autonomous System Numbers (ASN), which is a parameter that is integral to the BGP protocol.  
  
In this scenario, BGP works in the following way.  
  
-   The Enterprise site edge device learns the virtualized subnet routes (10.2.1.0/24) hosted in the cloud by using BGP. This device also advertises the on-premises subnet routes (10.1.1.0/24) to the CSP RAS Multitenant Gateway.  
  
-   The customer edge router learns on-premises internal routes through one of the following mechanisms:  
  
    -   The edge device runs BGP with an internal router and learns internal routes (in this example, 10.1.1.0/24). Meanwhile, the internal router learns external routes (such as 10.2.1.0/24) from the edge device, and the internal router must distribute these routes to other on-premises routers using an Interior Gateway Protocol (IGP) such as Open Shortest Path First (OSPF) or Routing Information Protocol (RIP).  
  
    -   The edge device can be configured with static routes or interfaces to select routes for advertisement by using BGP. The edge device also distributes the external routes to other on-premises routers using an IGP.  
  
### <a name="bkmk_top2"></a>Third party Gateway with BGP at Enterprise site edge  
This topology depicts an Enterprise site using a third party edge router to connect to a CSP. The edge router also serves as a site-to-site VPN gateway.  
  
![Third party Gateway with BGP at Enterprise site edge](../../media/Border-Gateway-Protocol-BGP/bgp_02.jpg)  
  
The Enterprise edge router learns on-premises internal routes through one of the following mechanisms:  
  
-   The edge device runs BGP with an internal router and learns internal routes (in this case, 10.1.1.0/24)  
  
-   The edge device implements an Interior Gateway Protocol (IGP) and participates directly in internal routing.  
  
### <a name="bkmk_top3"></a>Multiple Enterprise sites connecting to CSP cloud datacenter  
This topology depicts multiple Enterprise sites that use third party gateways to connect to a CSP. The third party edge devices serve as site-to-site VPN gateways and as BGP routers.  
  
![Multiple Enterprise sites connecting to CSP cloud datacenter](../../media/Border-Gateway-Protocol-BGP/bgp_03.jpg)  
  
The customer edge routers learn on-premises internal routes through one of the following mechanisms:  
  
-   The edge device runs BGP with an internal router and learns internal routes (in this case, 10.1.1.0/24)  
  
-   The edge device implements an Interior Gateway Protocol (IGP) and participates directly in internal routing.  
  
Each Enterprise site learns the routes from the other site over the direct eBGP connectivity.  
  
Each Enterprise site learns the hosted network routes directly and by using the other Enterprise site, but selects the best route based on the cost of the route.  
  
If the BGP router at Enterprise Site 1 cannot connect with the Enterprise Site 2 BGP router because connectivity has failed, the Site 1 BGP router dynamically begins to learn the routes to Enterprise Site 2 network from the CSP BGP Router, and the traffic is seamlessly rerouted from Site 1 to Site 2 via the Windows Server BGP Router at the CSP.  
  
### <a name="bkmk_top4"></a>Separate termination points for BGP and VPN  
This topology depicts an Enterprise that uses two different routers as the BGP and site-to-site VPN endpoints. Site-to-site VPN is terminated on the  Windows Server 2016 RAS Gateway, while BGP is terminated on an internal router. At the CSP side of the connections, the CSP terminates both the VPN and BGP connections with the RAS Gateway. With this configuration, the internal third party router hardware must support redistribution of IGP routes to BGP, as well as redistributing BGP routes to IGP.  
  
![Separate termination points for BGP and VPN](../../media/Border-Gateway-Protocol-BGP/bgp_04.jpg)  
  
The internal router learns Enterprise routes through one of the following mechanisms:  
  
-   BGP  
  
-   An Interior Gateway Protocol (IGP) such as OSPF or RIP.  
  
-   Static route configuration  
  
When any IGP is used at the Enterprise site, the internal router must redistribute IGP routes into BGP - as well as redistribute BGP routes into IGP routes - for maintaining the subnet connectivity between CSP virtual networks and local Enterprise subnets.  
  
With this deployment, the Enterprise RAS Gateway has a site-to-site VPN connection with the CSP RAS Gateway, which provides the Enterprise RAS Gateway with the routes to the CSP gateway. The Enterprise internal router then learns this route to the CSP gateway by using iBGP with the Enterprise RAS Gateway. Because of this, the Enterprise internal router is then able to establish a peering session with the CSP RAS Gateway BGP Router.  
  
From this point forward, the Enterprise internal router and the CSP RAS Gateway exchange routing information. And the Enterprise RAS BGP router learns the CSP routes and Enterprise routes to physically route packets between the networks.  
  
## <a name="bkmk_features"></a>BGP Features  
Following are the features of the RAS Gateway BGP Router.  
  
**BGP Routing as a role service of Remote Access**. You can now install the **Routing** role service of the Remote Access server role without installing the **Remote Access Service (RAS)** role service when you want to use Remote Access as a BGP LAN router.  This reduces the BGP router memory footprint and only installs the components required for dynamic BGP routing. The Routing role service is useful when only a BGP Router VM is required, and you don't require use of DirectAccess or VPN. In addition, using Remote Access as a LAN router with BGP provides you with the dynamic routing advantages of BGP on your internal network.  
  
**BGP Statistics (Message counters, Route counters)**. The BGP Router supports displaying the message and route statistics, if required, by using the **Get-BgpStatistics** Windows PowerShell command.  
  
**Equal Cost Multi Path Routing (ECMP) support**. The BGP Router supports ECMP and can have more than one equal cost routes plumbed into the BGP routing table and stack. The BGP router selection of the route for transmitting data packets is random with ECMP enabled.  
  
**HoldTime configuration**. The BGP Router supports configuration of the HoldTimer value according to your network requirements. This timer can be dynamically changed to accommodate interoperability with third party devices or to maintain a specific maximum time for BGP peering session timeout.  
  
**Internal BGP and External BGP support**. The BGP router supports both iBGP and eBGP peering. To configure either, you must ensure that the appropriate ASNs are assigned to the local and remote BGP Routers. All four BGP deployment topologies employ the use of eBGP peering, and the fourth topology uses iBGP peering as well.  
  
**Interoperability with 3rd party solutions**. The BGP Router is based on the latest BGP version 4 specification, and has been tested for interoperability with most of the major third party BGP routing devices. For more information, see Request for Comments (RFC) 4271, [A Border Gateway Protocol 4 (BGP-4)](https://tools.ietf.org/html/rfc4271).  
  
**IPv4 and IPv6 transport peering support**. The BGP Router supports both IPv4 and IPv6 peering. However, you must configure the BGP Identifier as the IPv4 address of the BGP Router. For all of the BGP router deployment topologies, either of the two peering types (IPV4 / IPv6) can be used.  
  
**IPv4 and IPv6 unicast route learning and advertisement capability (Multiprotocol Network Layer Reachability Information [NLRI])**. No matter what transport you use, the BGP Router can exchange IPv4 and IPv6 routes if the appropriate capability is announced by other BGP routers while establishing the session. To configure IPv6 routing, parameter IPv6Routing must be enabled, and a Local Global IPv6 address must be configured at the router level.  
  
**Mixed mode and Passive mode peering**. You can configure BGP peering sessions in either mixed mode - where the BGP router acts as both initiator and responder - or passive mode, where the BGP router does not initiate peering, but does respond to incoming requests. Mixed mode is the default, and is recommended for BGP peering. This is true unless you want to use passive mode for debugging or diagnostic purposes. For all of the BGP router deployment topologies, mixed mode peering is required to enable automatic restarts in case of failure events.  
  
**Route Attribute rewrite capability**. You can add, modify, or remove the following attributes from the BGP router ingress and egress route advertisements by using the BGP Routing policies Next-Hop, MED, Local-Pref, and Community.  
  
**Route filtering**. The BGP router supports filtering ingress or egress route advertisements based on multiple route attributes such as Prefix, ASN-Range, Community, and Next-Hop.  
  
**Route-Reflector (RR) and RR client**. The BGP Router can act as a Route-Reflector and an RR client. This is useful in complex topologies where RR can simplify the network by forming RR Clusters.  
  
**Route-Refresh support**. The BGP Router supports Route-Refresh and advertises this capability on peering by default. It is capable of sending a fresh set of route updates when requested by a peer via route-refresh message, as well as sending a Route-Refresh to update its Routing table in the events like Routing policy changes for a peer. This enables the scenario of changing or updating the BGP Routing policies in  Windows Server 2016 without needing to restart the peering.  
  
**Static route configuration support**. You can configure static routes or interfaces on the BGP Router by using the **Add-BgpCustomRoute** Windows PowerShell command. The static routes that you configure can be the prefixes or the name of the interfaces from which the routes must be chosen. However, only the routes with resolvable next-hops are plumbed into the BGP routing tables and advertised to peers.  
  
**Transit routing support**. The BGP Router supports transit routing for iBGP to iBGP connections, iBGP to eBGP connections as well as eBGP to eBGP connections.  
  
**Route Flap Dampening**. Route Flap Dampening to BGP Routing in  Windows Server 2016 provides support for Route flap dampening. For example, when a route is constantly being advertised and withdrawn, making the routing table unstable, you can configure the BGP Router to assign a dampening weight to the route and monitor it for flaps - and accordingly suppress or un-suppress it as required. This helps with maintaining a stable routing table and less processing by the BGP Router.  
  
**Route Aggregation**. Route Aggregation to the   BGP Router provides you with the ability to configure Aggregate Routes and to replace the more granular route advertisements with summary or aggregate routes to peers. This results in a fewer number of route advertisement messages transmitted on the network.  
  
> [!NOTE]  
> In System Center, the RAS Gateway is named Windows Server Gateway.  
  

  

