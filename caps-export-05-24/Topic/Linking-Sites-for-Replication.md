---
title: Linking Sites for Replication
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.assetid: d4a76ef3-1184-4773-8b88-a5f1731313a6
author: Femila
---
# Linking Sites for Replication
  Linking sites is required for Active Directory replication to occur between sites. Plan your site topology and then implement the plan by creating sites and site links. For information about planning your site topology, see Designing the Site Topology for Windows Server 2008 AD DS \([http:\/\/go.microsoft.com\/fwlink\/?LinkId\=89026](http://go.microsoft.com/fwlink/?LinkId=89026)\).  
  
## Creating site links  
 To link sites for Active Directory replication, create a site link object in the IP transport container in Active Directory Domain Services \(AD DS\) and add two or more sites to the link. Use a naming convention that includes the sites that you are linking. For example, if you want to link the site named Seattle to the site named Boston, you might name the site link SEA\-BOS.  
  
 After you add two or more site names to a site link object, the bridgehead servers in the respective sites replicate between the sites according to the replication schedule, cost, and interval settings on the site link object. For information about modifying the default settings, see [Changing Site Link Properties](../Topic/Changing-Site-Link-Properties.md).  
  
 At least two sites must exist when you create a site link. If you are adding a site link to connect a new site to an existing site, create the new site first and then create the site link. For information about creating a site, see [Adding a New Site](../Topic/Adding-a-New-Site.md).  
  
## Selecting bridgehead servers  
 By default, the intersite topology generator \(ISTG\) selects bridgehead servers in a site automatically. We recommend that you allow the ISTG to perform bridgehead server selection. However, if you want to ensure that only certain domain controllers in the sites you are linking perform replication between sites, you can designate preferred bridgehead servers in the site.  
  
> [!NOTE]  
>  If you have selected one or more bridgehead servers, removing them all from the bridgehead servers list restores the automatic selection functionality to the ISTG.  
  
 Use the following guidelines when you select bridgehead servers:  
  
-   Selecting preferred bridgehead servers limits the bridgehead servers that the Knowledge Consistency Checker \(KCC\) can use to those bridgehead servers that you have selected. If you use Active Directory Sites and Services to select any preferred bridgehead servers at all in a site, you must select as many bridgehead servers as possible and you must select them for all domains that must be replicated to a different site.  
  
-   If a site contains a global catalog server, select the global catalog server as a preferred bridgehead server.  
  
 When you use preferred bridgehead servers, the following problems can occur:  
  
-   If you select preferred bridgehead servers for a domain and all preferred bridgehead servers for that domain become unavailable, replication of that domain to and from that site does not occur.  
  
-   If you select a non\-global\-catalog server but a global catalog server currently exists in the site, or the global catalog is subsequently added to another domain controller in the site, the global catalog server cannot receive updates of read\-only domain directory partitions for any domain that does not have a selected bridgehead server in the site.  
  
 **Task requirements**  
  
 The following is required to perform the procedures for this task:  
  
-   Active Directory Sites and Services  
  
 To complete this task, perform the following procedures:  
  
1.  [Create a Site Link Object and Add the Appropriate Sites](../Topic/Create-a-Site-Link-Object-and-Add-the-Appropriate-Sites.md)  
  
2.  By default, the KCC runs every 15 minutes to generate the replication topology. To generate the intersite topology immediately, perform the following two procedures:  
  
    -   [Determine the ISTG Role Owner for a Site](../Topic/Determine-the-ISTG-Role-Owner-for-a-Site.md)  
  
    -   [Generate the Replication Topology on the ISTG](../Topic/Generate-the-Replication-Topology-on-the-ISTG.md)  
  
3.  If you are designating servers that will perform intersite replication, you can [Designate a Server as a Preferred Bridgehead Server](../Topic/Designate-a-Server-as-a-Preferred-Bridgehead-Server.md).  
  
  