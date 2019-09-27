---
ms.assetid: 83f746e5-81db-4610-9977-1d5c57699f50
title: Creating a Site Design
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Creating a Site Design

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Creating a site design involves deciding which locations will become sites, creating site objects, creating subnet objects, and associating the subnets with sites.  
  
## Deciding which locations will become sites

Decide which locations to create sites for as follows:  
  
- Create sites for all locations in which you plan to place domain controllers. Refer to the information documented in the "Domain Controller Placement" (DSSTOPO_4.doc) worksheet to identify locations that include domain controllers.  
- Create sites for those locations that include servers that are running applications that require a site to be created. Certain applications, such as Distributed File System Namespaces (DFSN), use site objects to locate the closest servers to clients.  

   > [!NOTE]  
   > If your organization has multiple networks in close proximity with fast, reliable connections, you can include all of the subnets for those networks in a single Active Directory site. For example, if the round-trip return network latency between two servers in different subnets is 10 ms or less, you can include both subnets in the same Active Directory site. If the network latency between the two locations is greater than 10 ms, you should not include the subnets in a single Active Directory site. Even when latency is 10 ms or less, you may elect to deploy separate sites if you want to segment the traffic between sites for Active Directory-based applications.  

- If a site is not required for a location, add the subnet of the location to a site for which the location has the maximum wide area network (WAN) speed and available bandwidth.  
  
Document locations that will become sites and the network addresses and subnet masks within each location. For a worksheet to assist you in documenting sites, see [Job Aids for Windows Server 2003 Deployment Kit](https://go.microsoft.com/fwlink/?LinkID=102558), download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip, and open "Associating Subnets with Sites" (DSSTOPO_6.doc).  
  
## Creating a site object design

For every location where you have decided to create sites, plan to create site objects in Active Directory Domain Services (AD DS). Document locations that will become sites in the "Associating Subnets with Sites" worksheet.  
  
For more information about how to create site objects, see the article [Create a Site](https://go.microsoft.com/fwlink/?LinkId=107067).  
  
## Creating a subnet object design

For every IP subnet and subnet mask associated with each location, plan to create subnet objects in AD DS representing all the IP addresses within the site.  
  
When creating an Active Directory subnet object, the information about network IP subnet and subnet mask is automatically translated into the network prefix length notation format <IP address>/<prefix length>. For example, the network IP version 4 (IPv4) address 172.16.4.0 with a subnet mask 255.255.252.0 appears as 172.16.4.0/22. In addition to IPv4 addresses,  Windows Server 2008  also supports IP version 6 (IPv6) subnet prefixes, for example, 3FFE:FFFF:0:C000::/64. For more information about IP subnets in each location, see the "Locations and Subnets" (DSSTOPO_2.doc) worksheet in [Collecting Network Information](../../ad-ds/plan/Collecting-Network-Information.md) and [Appendix A: Locations and Subnet Prefixes](Appendix-A--Locations-and-Subnet-Prefixes.md).  
  
Associate each subnet object with a site object by referring to the "Associating Subnets with Sites" (DSSTOPO_6.doc) worksheet in "Deciding Which Locations Will Become Sites" section to determine which subnet is to be associated with which site. Document the Active Directory subnet object associated with each location in the "Associating Subnets with Sites" (DSSTOPO_6.doc) worksheet.  
  
For more information about how to create subnet objects, see the article [Create a Subnet](https://go.microsoft.com/fwlink/?LinkId=107068).
