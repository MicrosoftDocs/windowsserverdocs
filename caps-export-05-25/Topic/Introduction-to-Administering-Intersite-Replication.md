---
title: Introduction to Administering Intersite Replication
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 965da631-45c4-49a5-bff3-4dc9766ad189
author: Femila
---
# Introduction to Administering Intersite Replication
  This guide explains how to administer intersite replication. These administration activities are part of the operations phase of the information technology \(IT\) life cycle. If you are not familiar with this guide, review the following sections of this introduction.  
  
 A site object in Active Directory Domain Services \(AD DS\) represents a collection of IP subnets, usually constituting a physical local area network \(LAN\). Multiple sites are connected for replication by site link objects.  
  
 Sites are used in AD DS to:  
  
-   Make it possible for clients to discover network resources \(published shares, domain controllers, global catalog servers\) that are close to the physical location of the client, reducing network traffic over wide area network \(WAN\) links.  
  
-   Optimize replication between domain controllers.  
  
 Managing sites in AD DS involves adding new subnet, site, and site link objects when the network grows, as well as configuring a schedule and cost for site links. You can modify the site link schedule, cost, or both to optimize intersite replication. When conditions no longer require replication to a site or clients no longer require the sites to discover network resources, you can remove the site and associated objects from AD DS.  
  
 Managing large hub\-and\-spoke topology is beyond the scope of this documentation. For information about managing branch sites, see the Planning and Deploying Read\-Only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120840](http://go.microsoft.com/fwlink/?LinkId=120840)\).  
  
## Optimizing replication between sites  
 The efficiency of replication between sites is optimized by cost settings on site links that favor replication routes between specific sites. The Knowledge Consistency Checker \(KCC\) uses site link configuration information to enable and optimize replication traffic by generating a least\-cost replication topology. Within a site, for each directory partition, the KCC builds a ring topology that tries to set a maximum number of hops \(three\) between any two domain controllers. Between sites, the KCC on the domain controller that has the intersite topology generator \(ISTG\) role creates the topology based on site link cost.  
  
 Designing a simple replication topology is the best way to optimize replication. Adding sites and domains increases the processing that is required by the KCC. Before adding to the site topology, be sure to review the guidelines in [Adding a New Site](../Topic/Adding-a-New-Site.md). For information about topology design, see Designing the Site Topology for Windows Server 2008 AD DS \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=89026](http://go.microsoft.com/fwlink/?LinkId=89026)\).  
  
### Effects of site link bridging  
 By default, all site links are bridged. When site links are bridged, replication is transitive between sites and the costs that are assigned to site links are cumulative; the lowest\-cost route between sites that have more than one site link is the route that replication takes. By default, site link costs are equal, with a cost of 100 on each new site link. For this reason, with no changes to the default site link cost, a hub\-and\-spoke topology favors the replication route between the hub site and each branch site, rather than between branch sites. The cost to replicate to and from two branch sites is always higher than the cost to replicate to and from the hub site. Therefore, replication between branch sites occurs only if no domain controller for the domain is available in the hub site.  
  
### Effects of disabling site link bridging  
 If you disable the **Bridge all site links** setting in the properties of the IP container in Active Directory Sites and Services, the ability of the ISTG to create the topology on the basis of cost is disabled. In addition, Distributed File System \(DFS\) cannot compute the cost matrix for its site\-costing functionality. Therefore, if you disable site link bridging and you are using File Replication Service \(FRS\) to replicate DFS replicas, which include the SYSVOL share, the DFS site\-costing ability is also disabled.  
  
> [!NOTE]  
>  DFS Replication, which is available in domains that are at the [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] domain functional level, uses the replication topology that is defined by the administrator, which is independent of Active Directory site costing.  
  
 If you turn off site link bridging, you must create site link bridges manually. For information about using manual site link bridges, see Creating a Site Link Bridge Design \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122678](http://go.microsoft.com/fwlink/?LinkId=122678)\).  
  
> [!NOTE]  
>  When you use FRS to replicate DFS replicas, you can maintain DFS site\-costing functionality with **Bridge all site links** turned off. When the forest functional level is at least Windows Server 2003 or Windows Server 2003 interim and the ISTG in a site is running Windows Server 2003 with Service Pack 1 \(SP1\), Windows Server 2003 with Service Pack 2 \(SP2\), Windows Server 2003 R2, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], you can use a site option to turn off automatic site link bridging for KCC operation without hampering the ability of DFS to use Intersite Messaging to calculate the cost matrix. This site option is set when you run the command **repadmin \/siteoptions W2K3\_BRIDGES\_REQUIRED**. For more information about the effects of disabling site link bridging, see How Active Directory Replication Topology Works \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=93526](http://go.microsoft.com/fwlink/?LinkId=93526)\).  
  
 Do not disable **Bridge all site links** unless you are deploying a branch office environment. For information about branch office deployments, see “RODC Placement Considerations” in Planning and Deploying Read\-Only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120840](http://go.microsoft.com/fwlink/?LinkId=120840)\).  
  
## Optimizing domain controller location  
 Two new Group Policy settings are available on domain controllers that are running Windows Server 2008: **Try Next Closest Site** and **Force Rediscovery Interval**. These settings help Windows Vista and Windows Server 2008 clients in the domain to locate domain controllers in the next closest site if no domain controller in their own site is available. These settings improve domain controller discovery by controlling how the domain controller locator \(DC Locator\) process operates.  
  
### Finding the next closest site  
 By default, when a client requests a domain controller, the DC Locator process locates a domain controller in the site of the client. If no domain controller is available in the site, DC Locator returns any domain controller in the domain. If the domain controller is located in another branch site instead of the hub site, communication with the domain controller might be significantly slow. The **Try Next Closest Site** Group Policy setting in the Default Domain Policy can improve the location of domain controllers by clients that are running Windows Server 2008 or Windows Vista.  
  
 The **Try Next Closest Site** Group Policy setting uses site link cost values to determine the next closest site to the site of the client. **Try Next Closest Site** can affect how you configure site link costs because it affects the order in which domain controllers are located. For enterprises that have many hub sites and branch offices, you can significantly reduce Active Directory traffic on the network by ensuring that clients fail over to the next closest hub site when they cannot find a domain controller in the closest hub site. For more information, see Enabling Clients to Locate the Next Closest Domain Controller \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120711](http://go.microsoft.com/fwlink/?LinkId=120711)\).  
  
### Forcing domain controller rediscovery  
 In addition to finding a domain controller in the next closest site, a new Group Policy setting in [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] ensures that a client that is running Windows Vista or Windows Server 2008 finds a new domain controller that might be introduced since the last domain controller location. On domain controllers that are running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the **Force Rediscovery Interval** Group Policy setting forces a new domain controller location every 12 hours \(43200 seconds\) by default. You can change the time limit for rediscovery by enabling the setting and specifying a new time in seconds.  
  
 By default, clients cache the last domain controller that was returned by DC Locator. On clients that are running Windows XP or Windows Server 2003, even if the domain controller that was last located is in a distant site, DC Locator continues to return the cached domain controller on each subsequent request. The cache is updated only if the cached domain controller is unavailable or the client restarts.  
  
 For domain clients that are running Windows XP and Windows Server 2003, a hotfix is available that makes the registry setting available for this Group Policy setting. For information about downloading and using this hotfix, see article ID 939252 in the Microsoft Knowledge Base \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=122681](http://go.microsoft.com/fwlink/?LinkId=122681)\).  
  
## Improving the logon experience in branch sites  
 Branch sites often contain only a single domain controller that might not be a global catalog server. Perhaps replication of global catalog updates is considered to be prohibitive as a result of poor or unreliable bandwidth between the branch site and the nearest hub site. When the global catalog is required for domain logon and there is no global catalog server in the site, the domain controller must contact a global catalog server in another site.  
  
 The global catalog is required when a domain user logs on interactively to a domain under the following conditions:  
  
-   The user's domain has a domain functional level of Windows 2000 native, Windows Server 2003, or [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)]. In these cases, the user might belong to a universal group whose object is stored in a different domain. Only the global catalog stores universal group memberships for all domains in the forest.  
  
-   The user’s logon name is a user principal name \(UPN\), which has the format sAMAccountName@DNSDomainName. In this case, the Domain Name System \(DNS\) domain suffix is not necessarily the user’s domain and the identity of the user’s domain must be retrieved from a global catalog server.  
  
 In [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], the best solution to this branch site scenario is to deploy a read\-only domain controller \(RODC\) that is a global catalog server. In this case, although the global catalog must be replicated to the site, access to universal group memberships is always local and logon experience is consistent. In addition, RODCs provide more security against compromise than regular domain controllers because they are not writable. For information about deploying RODCs that are global catalog servers, see Planning and Deploying Read\-only Domain Controllers \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=120840](http://go.microsoft.com/fwlink/?LinkId=120840)\).  
  
 As an alternative to deploying the global catalog in the branch site, you can enable Universal Group Membership Caching, which means that the domain controller contacts the global catalog server only once for each user and that it caches all universal group memberships, rather than having to retrieve them at each logon. For more information about Universal Group Membership Caching, see How the Global Catalog Works \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=107063](http://go.microsoft.com/fwlink/?LinkId=107063)\). For information about using Universal Group Membership Caching, see [Enabling Universal Group Membership Caching in a Site](../Topic/Enabling-Universal-Group-Membership-Caching-in-a-Site.md).  
  
## See Also  
 [Managing Intersite Replication](../Topic/Managing-Intersite-Replication.md)  
  
  