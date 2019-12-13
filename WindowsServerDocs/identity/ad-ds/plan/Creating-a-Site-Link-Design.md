---
ms.assetid: 206b8072-1d0c-4a0b-ba8a-35a868d67b4c
title: Creating a Site Link Design
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/08/2018
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---
# Creating a Site Link Design

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Create a site link design to connect your sites with site links. Site links reflect the intersite connectivity and method used to transfer replication traffic. You must connect sites with site links so that domain controllers at each site can replicate Active Directory changes.  
  
## Connecting sites with site links

To connect sites with site links, identify the member sites that you want to connect with the site link, create a site link object in the respective Inter-Site Transports container, and then name the site link. After you create the site link, you can proceed to set the site link properties.  
  
When creating site links, ensure that every site is included in a site link. In addition, ensure that all sites are connected to each other through other site links so that the changes can be replicated from domain controllers in any site to all other sites. If you fail to do this, an error message is generated in the Directory Service log in Event Viewer stating that the site topology is not connected.  
  
Whenever you add sites to a newly created site link, determine if the site being added is a member of other site links, and change the site link membership of the site if needed. For example, if you make a site a member of the Default-First-Site-Link when you initially create the site, be sure to remove the site from the Default-First-Site-Link after you add the site to a new site link. If you do not remove the site from the Default-First-Site-Link, the Knowledge Consistency Checker (KCC) will make routing decisions based on the membership of both site links, which may result in incorrect routing.  
  
To identify the member sites that you want to connect with a site link, use the list of locations and linked locations that you recorded in the "Geographic Locations and Communication Links" (DSSTOPO_1.doc) worksheet. If multiple sites have the same connectivity and availability to each other, you can connect them with the same site link.  
  
The Inter-Site Transports container provides the means for mapping site links to the transport that the link uses. When you create a site link object, you create it in either the IP container, which associates the site link with the remote procedure call (RPC) over IP transport, or the Simple Mail Transfer Protocol (SMTP) container, which associates the site link with the SMTP transport.  
  
> [!NOTE]  
> SMTP replication will not be supported in future versions of Active Directory Domain Services (AD DS); therefore, creating site links objects in the SMTP container is not recommended.  
  
When you create a site link object in the respective Inter-Site Transports container, AD DS uses RPC over IP to transfer both intersite and intrasite replication between domain controllers. To keep data secure while in transit, RPC over IP replication uses both the Kerberos authentication protocol and data encryption.  
  
When a direct IP connection is not available, you can configure replication between sites to use SMTP. However, SMTP replication functionality is limited and requires an enterprise certification authority (CA). SMTP can only replicate the configuration, schema, and application directory partitions and does not support the replication of domain directory partitions.  
  
To name site links, use a consistent naming scheme, such as name_of_site1-name_of_site2. Record the list of sites, linked sites, and the names of the site links connecting these sites in a worksheet. For a worksheet to assist you in recording site names and associated site link names, see [Job Aids for Windows Server 2003 Deployment Kit](https://go.microsoft.com/fwlink/?LinkID=102558), download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip, and open"Sites and Associated Site Links" (DSSTOPO_5.doc).  
  
## In this guide

[Setting Site Link Properties](Setting-Site-Link-Properties.md)  
