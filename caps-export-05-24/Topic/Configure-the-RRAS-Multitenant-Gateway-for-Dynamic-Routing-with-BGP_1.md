---
title: Configure the RRAS Multitenant Gateway for Dynamic Routing with BGP_1
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5757b83c-d7b4-4e92-8fc7-18c62e5b8ce9
---
# Configure the RRAS Multitenant Gateway for Dynamic Routing with BGP_1
You can use this topic to enable Border Gateway Protocol \(BGP\) for each of your tenants on the Routing and Remote Access Service \(RRAS\) Multitenant Gateway \(MTGW\). When you enable BGP on the MTGW and on tenant routers, routes are dynamically exchanged between peers, eliminating the need for constant manual route updates and providing automatic rerouting of network traffic if a peer becomes unavailable due to hardware or other failure.  
  
This topic contains the following sections.  
  
-   [Prerequisites](#bkmk_pre)  
  
-   [To enable BGP on the RRAS MTGW](#bkmk_procedure)  
  
-   [Windows PowerShell command reference links](#bkmk_links)  
  
## <a name="bkmk_pre"></a>Prerequisites  
Following are the prerequisites for adding BGP routers for tenants.  
  
-   You must replace the Autonomous Systems Number \(ASN\) in the Windows PowerShell commands below with values that are suitable for your deployment. The values that are provided in this topic are examples only.  
  
## <a name="bkmk_procedure"></a>To enable BGP on the RRAS MTGW  
  
> [!NOTE]  
> If your tenants' remote routers are also running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] Routing and Remote Access \(RRAS\) configured as a BGP router, your tenants can configure their routers by using the commands in this section. If tenants are using third party BGP routers instead, refer to the router documentation for configuration instructions.  
  
1.  On the RRAS MTGW Hyper\-V host, open Windows PowerShell with Administrator privileges. For each tenant that has site\-to\-site VPN connections established to remote tenant resources, add a BGP router using the following command.  
  
    ```  
    Add-BgpRouter -RoutingDomain $Contoso_RoutingDomain -BgpIdentifier $Contoso_BGPAddress -LocalASN $Contoso_BGP_LocalASN   
    Add-BgpRouter -RoutingDomain $Fabrikam_RoutingDomain -BgpIdentifier $Fabrikam_BGPAddress -LocalASN $Fabrikam_BGP_LocalASN  
  
    ```  
  
2.  Add BGP peers to the BGP router for each of the tenant’s remote sites. The **–PeeringMode** value of **Automatic** in the command below allows BGP to automatically initiate connections to peers and receive connections from peers.  
  
    ```  
    Add-BgpPeer -RoutingDomain $Contoso_RoutingDomain -Name "ContosoTenantSite1" -LocalIPAddress $Contoso_BGPAddress -PeerIPAddress $Contoso_BGPPeerAddress -PeerASN $Contoso_BGP_PeerASN  
    Add-BgpPeer -RoutingDomain $Fabrikam_RoutingDomain -Name "FabrikamTenantSite1" -LocalIPAddress $Fabrikam_BGPAddress -PeerIPAddress $Fabrikam_BGPPeerAddress -PeerASN $Fabrikam_BGP_PeerASN  
  
    ```  
  
3.  Configure the remote tenant routers with BGP and matching BGP peers and routes.  
  
4.  To allow the triggering of site\-to\-site VPN connections from the BGP router to the remote tenant sites, add the host\-specific route of the remote BGP peer to the site\-to\-site VPN interface in the tenant compartment on the MTGW.  
  
    ```  
    Set-VpnS2SInterface -Name <TenantS2SInterfaceName> -IPv4Subnet <IPv4Address/PrefixLength:Metric>  
    ```  
  
5.  Add custom networks for advertisements to peers.  
  
    ```  
    Add-BgpCustomRoute -RoutingDomain $Contoso_RoutingDomain -Interface $Contoso_MTInterface   
    Add-BgpCustomRoute -RoutingDomain $Fabrikam_RoutingDomain -Interface $Fabrikam_MTInterface  
  
    ```  
  
> [!NOTE]  
> After you add routes, the BGP router automatically begins to advertise them to peers.  
  
## <a name="bkmk_links"></a>Windows PowerShell command reference links  
The script in this topic uses the following Windows PowerShell commands. Click a link to open the help topic for the command.  
  
-   [Add\-BgpRouter](http://technet.microsoft.com/library/dn262665.aspx). Adds a BGP router.  
  
-   [Add\-BgpPeer](http://technet.microsoft.com/library/dn262687.aspx). Adds a BGP peer to the current router.  
  
-   [Set\-VpnS2SInterface](http://technet.microsoft.com/library/hh918392.aspx). Modifies parameters for a site\-to\-site \(S2S\) interface.  
  
-   [Add\-BgpCustomRoute](http://technet.microsoft.com/library/dn262684.aspx). Adds custom routes to the BGP routing table.  
  
## See Also  
[Microsoft BGP Router configuration automation](http://gallery.technet.microsoft.com/BGP-Router-configuration-e2bae411)  
[Multi\-tenant Site\-to\-Site \(S2S\) VPN Gateway with Windows Server 2012 R2](http://blogs.technet.com/b/networking/archive/2013/09/29/multi-tenant-site-to-site-s2s-vpn-gateway-with-windows-server-2012-r2.aspx)  
[Additional Resources_1](../Topic/Additional-Resources_1.md)  
  
