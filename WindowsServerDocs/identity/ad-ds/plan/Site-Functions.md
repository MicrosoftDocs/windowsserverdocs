---
ms.assetid: 22c514b2-401e-49e1-a87e-0cbaa2c1dac1
title: Site Functions
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adds
---

# Site Functions

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

 Windows Server 2008  uses site information for many purposes, including routing replication, client affinity, system volume (SYSVOL) replication, Distributed File System Namespaces (DFSN), and service location.  
  
## Routing replication  
Active Directory Domain Services (AD DS) uses a multimaster, store-and-forward method of replication. A domain controller communicates directory changes to a second domain controller, which then communicates to a third, and so on, until all domain controllers have received the change. To achieve the best balance between reducing replication latency and reducing traffic, site topology controls Active Directory replication by distinguishing between replication that occurs within a site and replication that occurs between sites.  
  
Within sites, replication is optimized for speed, data updates trigger replication, and the data is sent without the overhead required by data compression. Conversely, replication between sites is compressed to minimize the cost of transmission over wide area network (WAN) links. When replication occurs between sites, a single domain controller per domain at each site collects and stores the directory changes and communicates them at a scheduled time to a domain controller in another site.  
  
## Client affinity  
Domain controllers use site information to inform Active Directory clients about domain controllers present within the closest site as the client. For example, consider a client in the Seattle site that does not know its site affiliation and contacts a domain controller from the Atlanta site. Based on the IP address of the client, the domain controller in Atlanta determines which site the client is actually from and sends the site information back to the client. The domain controller also informs the client whether the chosen domain controller is the closest one to it. The client caches the site information provided by the domain controller in Atlanta, queries for the site-specific service (SRV) resource record (a Domain Name System (DNS) resource record used to locate domain controllers for AD DS) and thereby finds a domain controller within the same site.  
  
By finding a domain controller in the same site, the client avoids communications over WAN links. If no domain controllers are located at the client site, a domain controller that has the lowest cost connections relative to other connected sites advertises itself (registers a site-specific service (SRV) resource record in DNS) in the site that does not have a domain controller. The domain controllers that are published in DNS are those from the closest site as defined by the site topology. This process ensures that every site has a preferred domain controller for authentication.  
  
For more information about the process of locating a domain controller, see Active Directory Collection ([https://go.microsoft.com/fwlink/?LinkID=88626](https://go.microsoft.com/fwlink/?LinkID=88626)).  
  
## SYSVOL replication  
SYSVOL is a collection of folders in the file system that exists on each domain controller in a domain. The SYSVOL folders provide a default Active Directory location for files that must be replicated throughout a domain, including Group Policy objects (GPOs), startup and shutdown scripts, and logon and logoff scripts.  Windows Server 2008  can use the File Replication Service (FRS) or Distributed File System Replication (DFSR) to replicate changes made to the SYSVOL folders from one domain controller to other domain controllers. FRS and DFSR replicate these changes according to the schedule that you create during your site topology design.  
  
## DFSN  
DFSN uses site information to direct a client to the server that is hosting the requested data within the site. If DFSN does not find a copy of the data within the same site as the client, DFSN uses the site information in AD DS to determine which file server that has DFSN shared data is closest to the client.  
  
## Service location  
By publishing services such as file and print services in AD DS, you allow Active Directory clients to locate the requested service within the same or nearest site. Print services use the location attribute stored in AD DS to let users browse for printers by location without knowing their precise location. For more information about designing and deploying print servers, see Designing and Deploying Print Servers ([https://go.microsoft.com/fwlink/?LinkId=107041](https://go.microsoft.com/fwlink/?LinkId=107041)).  
  


