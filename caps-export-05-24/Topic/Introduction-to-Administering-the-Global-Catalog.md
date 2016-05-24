---
title: Introduction to Administering the Global Catalog
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: 5540451f-d0b2-4cc6-b5de-c10cb2bf99de
author: Femila
---
# Introduction to Administering the Global Catalog
  Designate global catalog servers in sites to accommodate forest\-wide directory searching and to facilitate domain client logons when universal groups are available \(that is, when a domain has a domain functional level of [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)], Windows Server 2003, or Windows 2000 native\). When universal groups are available in a domain, a domain controller must be able to locate a global catalog server to process a logon request.  
  
## Global catalog hardware requirements  
 Minimum hardware requirements for global catalog servers depend on the number of users in the site. For disk space requirements and directory database storage guidelines, see Planning Domain Controller Capacity \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=80404](http://go.microsoft.com/fwlink/?LinkId=80404)\).  
  
## Global catalog placement  
 In most cases, we recommend that you include the global catalog when you install new domain controllers. The following exceptions apply:  
  
 Limited bandwidth: In remote sites, if the wide area network \(WAN\) link between the remote site and the hub site is limited, you can use universal group membership caching in the remote site to accommodate the logon needs of users in the site. For information about universal group membership caching, see [Enabling Universal Group Membership Caching in a Site](../Topic/Enabling-Universal-Group-Membership-Caching-in-a-Site.md).  
  
 Infrastructure operations master role incompatibility: Do not place the global catalog on a domain controller that hosts the infrastructure operations master role in the domain unless all domain controllers in the domain are global catalog servers or the forest has only one domain.  
  
## Initial global catalog replication  
 When you add a global catalog server to a site, the Knowledge Consistency Checker \(KCC\) updates the replication topology, after which replication of partial domain directory partitions that are available within the site begins. Replication of partial domain directory partitions that are available only from other sites begins at the next scheduled interval.  
  
 Adding subsequent global catalog servers within the same site requires only intrasite replication and does not affect network performance. Replication of the global catalog potentially affects network performance only when you add the first global catalog server in the site. The impact of this replication varies, depending on the following conditions:  
  
-   The speed and reliability of the WAN link or links to the site  
  
-   The size of the forest  
  
 For example, in a forest that has a large hub site, five domains, and thirty small branch sites \(some of which are connected by only dial\-up connections\), global catalog replication to the small sites takes considerably longer than replication of one or two domains to a few well\-connected sites.  
  
## Global catalog readiness  
 A global catalog server is available to directory clients when Domain Name System \(DNS\) servers can locate it as a global catalog server. Several conditions must be met before the global catalog server is locatable by clients. These conditions are divided into seven levels \(numbered 0 to 6\) of readiness, called occupancy levels. At each level, a specific degree of synchronization must be achieved before occupancy moves to the next level. By default, domain controllers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] require all levels to be reached before the global catalog is ready for use. At level 6, all partial, read\-only directory partitions have been successfully replicated to the global catalog server. When the requirements of all occupancy levels have been satisfied, the Net Logon service on the global catalog server registers DNS service \(SRV\) resource records that identify the domain controller as a global catalog server in the site and in the forest. For more information about global catalog readiness and occupancy levels, see How the Global Catalog Works \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=107063](http://go.microsoft.com/fwlink/?LinkID=107063)\).  
  
 In summary, a global catalog server is ready to serve clients when the following events occur, in this order:  
  
-   The global catalog receives replication of read\-only replicas to the required occupancy level.  
  
-   The **isGlobalCatalogReady** rootDSE attribute is set to **TRUE**.  
  
-   The Net Logon service on the domain controller has updated DNS with global\-catalog\-specific service \(SRV\) resource records.  
  
 At this point, the global catalog server begins accepting queries on ports 3268 and 3269.  
  
## Global catalog removal  
 When you remove the global catalog from a domain controller, that domain controller immediately stops advertising in DNS as a global catalog server. The Knowledge Consistency Checker \(KCC\) gradually removes the read\-only replicas from the domain controller. On domain controllers running [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] or Windows Server 2003, the global catalog, partial, read\-only directory partitions are removed in the background, and they receive a low priority so that high\-priority services are not interrupted.  
  
 You might decide to remove the global catalog from a domain controller if universal group membership caching is adequate to satisfy logon requirements in a particular site where WAN link speeds are not adequate for the global catalog. For more information, see [Enabling Universal Group Membership Caching in a Site](../Topic/Enabling-Universal-Group-Membership-Caching-in-a-Site.md).  
  
 For more information about global catalog removal, see How the Global Catalog Works \([http:\/\/go.microsoft.com\/fwlink\/?LinkID\=107063](http://go.microsoft.com/fwlink/?LinkID=107063)\).  
  
  