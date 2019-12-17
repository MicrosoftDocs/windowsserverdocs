---
ms.assetid: 4cc9c16c-1928-4dce-a3a8-6229be28eb65
title: Active Directory Replication Concepts
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Active Directory Replication Concepts

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Before designing site topology, become familiar with some Active Directory replication concepts.  
  
-   [Connection object](#BKMK_1)  
  
-   [KCC](#BKMK_2)  
  
-   [Failover functionality](#BKMK_3)  
  
-   [Subnet](#BKMK_4)  
  
-   [Site](#BKMK_5)  
  
-   [Site link](#BKMK_6)  
  
-   [Site link bridge](#BKMK_7)  
  
-   [Site link transitivity](#BKMK_8)  
  
-   [Global catalog server](#BKMK_9)  
  
-   [Universal group membership caching](#BKMK_10)  
  
## <a name="BKMK_1"></a>Connection object  
A connection object is an Active Directory object that represents a replication connection from a source domain controller to a destination domain controller. A domain controller is a member of a single site and is represented in the site by a server object in Active Directory Domain Services (AD DS). Each server object has a child NTDS Settings object that represents the replicating domain controller in the site.  
  
The connection object is a child of the NTDS Settings object on the destination server. For replication to occur between two domain controllers, the server object of one must have a connection object that represents inbound replication from the other. All replication connections for a domain controller are stored as connection objects under the NTDS Settings object. The connection object identifies the replication source server, contains a replication schedule, and specifies a replication transport.  
  
The Knowledge Consistency Checker (KCC) creates connection objects automatically, but they can also be created manually. Connection objects created by the KCC appear in the Active Directory Sites and Services snap-in as **<automatically generated>** and are considered adequate under normal operating conditions. Connection objects created by an administrator are manually created connection objects. A manually created connection object is identified by the name assigned by the administrator when it was created. When you modify a **<automatically generated>** connection object, you convert it into an administratively modified connection object and the object appears in the form of a GUID. The KCC does not make changes to manual or modified connection objects.  
  
## <a name="BKMK_2"></a>KCC  
The KCC is a built-in process that runs on all domain controllers and generates replication topology for the Active Directory forest. The KCC creates separate replication topologies depending on whether replication is occurring within a site (intrasite) or between sites (intersite). The KCC also dynamically adjusts the topology to accommodate the addition of new domain controllers, the removal of existing domain controllers, the movement of domain controllers to and from sites, changing costs and schedules, and domain controllers that are temporarily unavailable or in an error state.  
  
Within a site, the connections between writable domain controllers are always arranged in a bidirectional ring, with additional shortcut connections to reduce latency in large sites. On the other hand, the intersite topology is a layering of spanning trees, which means one intersite connection exists between any two sites for each directory partition and generally does not contain shortcut connections. For more information about spanning trees and Active Directory replication topology, see Active Directory Replication Topology Technical Reference ([https://go.microsoft.com/fwlink/?LinkID=93578](https://go.microsoft.com/fwlink/?LinkID=93578)).  
  
On each domain controller, the KCC creates replication routes by creating one-way inbound connection objects that define connections from other domain controllers. For domain controllers in the same site, the KCC creates connection objects automatically without administrative intervention. When you have more than one site, you configure site links between sites, and a single KCC in each site automatically creates connections between sites as well.  
  
### KCC improvements for Windows Server 2008 RODCs  

There are a number of KCC improvements to accommodate the newly available read-only domain controller (RODC) in  Windows Server 2008 . A typical deployment scenario for RODC is the branch office. The Active Directory replication topology most commonly deployed in this scenario is based on a hub-and-spoke design, where branch domain controllers in multiple sites replicate with a small number of bridgehead servers in a hub site.  
  
One of the benefits of deploying RODC in this scenario is unidirectional replication. Bridgehead servers are not required to replicate from the RODC, which reduces administration and network usage.  
  
However, one administrative challenge highlighted by the hub-spoke topology on previous versions of the Windows Server operating system is that after adding a new bridgehead domain controller in the hub, there is no automatic mechanism to redistribute the replication connections between the branch domain controllers and the hub domain controllers to take advantage of the new hub domain controller.  
  
For Windows Server 2003 domain controllers, you can rebalance the workload by using a tool such as Adlb.exe from the Windows Server 2003 Branch Office Deployment Guide ([https://go.microsoft.com/fwlink/?LinkID=28523](https://go.microsoft.com/fwlink/?LinkID=28523)).  
  
For  Windows Server 2008  RODCs, the normal functioning of the KCC provides some rebalancing, which eliminates the need to use an additional tool such as Adlb.exe. The new functionality is enabled by default. You can disable it by adding the following registry key set on the RODC:  
  
**HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Services\NTDS\Parameters**  
  
**"Random BH Loadbalancing Allowed"**  
**1 = Enabled (default), 0 = Disabled**  
  
For more information about how these KCC improvements work, see Planning and Deploying Active Directory Domain Services for Branch Offices ([https://go.microsoft.com/fwlink/?LinkId=107114](https://go.microsoft.com/fwlink/?LinkId=107114)).  
  
## <a name="BKMK_3"></a>Failover functionality  
Sites ensure that replication is routed around network failures and offline domain controllers. The KCC runs at specified intervals to adjust the replication topology for changes that occur in AD DS, such as when new domain controllers are added and new sites are created. The KCC reviews the replication status of existing connections to determine if any connections are not working. If a connection is not working due to a failed domain controller, the KCC automatically builds temporary connections to other replication partners (if available) to ensure that replication occurs. If all the domain controllers in a site are unavailable, the KCC automatically creates replication connections between domain controllers from another site.  
  
## <a name="BKMK_4"></a>Subnet  
A subnet is a segment of a TCP/IP network to which a set of logical IP addresses are assigned. Subnets group computers in a way that identifies their physical proximity on the network. Subnet objects in AD DS identify the network addresses that are used to map computers to sites.  
  
## <a name="BKMK_5"></a>Site  
Sites are Active Directory objects that represent one or more TCP/IP subnets with highly reliable and fast network connections. Site information allows administrators to configure Active Directory access and replication to optimize usage of the physical network. Site objects are associated with a set of subnets, and each domain controller in a forest is associated with an Active Directory site according to its IP address. Sites can host domain controllers from more than one domain, and a domain can be represented in more than one site.  
  
## <a name="BKMK_6"></a>Site link  
Site links are Active Directory objects that represent logical paths that the KCC uses to establish a connection for Active Directory replication. A site link object represents a set of sites that can communicate at uniform cost through a specified intersite transport.  
  
All sites contained within the site link are considered to be connected by means of the same network type. Sites must be manually linked to other sites by using site links so that domain controllers in one site can replicate directory changes from domain controllers in another site. Because site links do not correspond to the actual path taken by network packets on the physical network during replication, you do not need to create redundant site links to improve Active Directory replication efficiency.  
  
When two sites are connected by a site link, the replication system automatically creates connections between specific domain controllers in each site that are called bridgehead servers. In  Windows Server 2008 , all domain controllers in a site that host the same directory partition are candidates for being selected as bridgehead servers. The replication connections created by the KCC are randomly distributed among all candidate bridgehead servers in a site to share the replication workload. By default, the randomized selection process takes place only once, when connection objects are first added to the site.  
  
## <a name="BKMK_7"></a>Site link bridge  
A site link bridge is an Active Directory object that represents a set of site links, all of whose sites can communicate by using a common transport. Site link bridges enable domain controllers that are not directly connected by means of a communication link to replicate with each other. Typically, a site link bridge corresponds to a router (or a set of routers) on an IP network.  
  
By default, the KCC can form a transitive route through any and all site links that have some sites in common. If this behavior is disabled, each site link represents its own distinct and isolated network. Sets of site links that can be treated as a single route are expressed through a site link bridge. Each bridge represents an isolated communication environment for network traffic.  
  
Site link bridges are a mechanism to logically represent transitive physical connectivity between sites. A site link bridge allows the KCC to use any combination of the included site links to determine the least expensive route to interconnect directory partitions held in those sites. The site link bridge does not provide actual connectivity to the domain controllers. If the site link bridge is removed, replication over the combined site links will continue until the KCC removes the links.  
  
Site link bridges are only necessary if a site contains a domain controller hosting a directory partition that is not also hosted on a domain controller in an adjacent site, but a domain controller hosting that directory partition is located in one or more other sites in the forest. Adjacent sites are defined as any two or more sites included in a single site link.  
  
A site link bridge creates a logical connection between two site links, providing a transitive path between two disconnected sites by using an interim site. For the purposes of the intersite topology generator (ISTG), the bridge implies physical connectivity by using the interim site. The bridge does not imply that a domain controller in the interim site will provide the replication path. However, this would be the case if the interim site contained a domain controller that hosted the directory partition to be replicated, in which case a site link bridge is not required.  
  
The cost of each site link is added, creating a summed cost for the resulting path. The site link bridge would be used if the interim site does not contain a domain controller hosting the directory partition and a lower cost link does not exist. If the interim site contained a domain controller that hosts the directory partition, two disconnected sites would set up replication connections to the interim domain controller and not use the bridge.  
  
## <a name="BKMK_8"></a>Site link transitivity  
By default, all site links are transitive, or "bridged." When site links are bridged and the schedules overlap, the KCC creates replication connections that determine domain controller replication partners between sites, where the sites are not directly connected by site links but are connected transitively through a set of common sites. This means that you can connect any site to any other site through a combination of site links.  
  
In general, for a fully routed network, you do not need to create any site link bridges unless you want to control the flow of replication changes. If your network is not fully routed, site link bridges should be created to avoid impossible replication attempts. All site links for a specific transport implicitly belong to a single site link bridge for that transport. The default bridging for site links occurs automatically, and no Active Directory object represents that bridge. The **Bridge all site links** setting, found in the properties of both the IP and Simple Mail Transfer Protocol (SMTP) intersite transport containers, implements automatic site link bridging.  
  
> [!NOTE]  
> SMTP replication will not be supported in future versions of AD DS; therefore, creating site links objects in the SMTP container is not recommended.  
  
## <a name="BKMK_9"></a>Global catalog server  
A global catalog server is a domain controller that stores information about all objects in the forest, so that applications can search AD DS without referring to specific domain controllers that store the requested data. Like all domain controllers, a global catalog server stores full, writable replicas of the schema and configuration directory partitions and a full, writable replica of the domain directory partition for the domain that it is hosting. In addition, a global catalog server stores a partial, read-only replica of every other domain in the forest. Partial, read-only domain replicas contain every object in the domain but only a subset of the attributes (those attributes that are most commonly used for searching the object).  
  
## <a name="BKMK_10"></a>Universal group membership caching  
Universal group membership caching allows the domain controller to cache universal group membership information for users. You can enable domain controllers that are running  Windows Server 2008  to cache universal group memberships by using the Active Directory Sites and Services snap-in.  
  
Enabling universal group membership caching eliminates the need for a global catalog server at every site in a domain, which minimizes network bandwidth usage because a domain controller does not need to replicate all of the objects located in the forest. It also reduces logon times because the authenticating domain controllers do not always need to access a global catalog to obtain universal group membership information. For more information about when to use universal group membership caching, see [Planning Global Catalog Server Placement](../../../ad-ds/plan/Planning-Global-Catalog-Server-Placement.md).  
  


