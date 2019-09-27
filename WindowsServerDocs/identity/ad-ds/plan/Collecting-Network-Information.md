---
ms.assetid: 8be8c48d-790c-4199-b9d3-9f4a07d5ced2
title: Collecting Network Information
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/08/2018
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Collecting Network Information

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

The first step in designing an effective site topology in Active Directory Domain Services (AD DS) is to consult your organization's networking group to collect information and communicate with them regularly about your physical network topology.  
  
## Creating a location map

Create a location map that represents the physical network infrastructure of your organization. On the location map, identify the geographic locations that contain groups of computers with internal connectivity of 10 megabits per second (Mbps) or higher (local area network (LAN) speed or better).  
  
## Listing communication links and available bandwidth

After creating a location map, document the type of communication link, its link speed, and the available bandwidth between each location. Obtain a wide area network (WAN) topology from your networking group. For a list of common WAN circuit types and their bandwidths, see "Determining the cost" section in [Creating a Site Link Design](../../ad-ds/plan/Creating-a-Site-Link-Design.md). You will need this information to create site links later in the site topology design process.  
  
Bandwidth refers to the amount of data that you can transmit across a communication channel in a given amount of time. Available bandwidth refers to the amount of bandwidth actually available for use by AD DS. You can obtain available bandwidth information from your networking group, or you can analyze traffic on each link by using a protocol analyzer such as Network Monitor. For information about installing Network Monitor, see the article [Monitoring network traffic](https://go.microsoft.com/fwlink/?LinkId=107058).  
  
Document each location and the other locations that are linked to it. In addition, record the type of communication link and its available bandwidth. For a worksheet to assist you in listing communication links and available bandwidth, see [Job Aids for Windows Server 2003 Deployment Kit](https://go.microsoft.com/fwlink/?LinkID=102558), download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip, and open "Geographic Locations and Communication Links" (DSSTOPO_1.doc).  
  
## Listing IP subnets within each location

After you document the communication links and the available bandwidth between each location, record the IP subnets within each location. If you do not already know the subnet mask and IP address within each location, consult your networking group.  
  
AD DS associates a workstation with a site by comparing the workstation's IP address with the subnets that are associated with each site. As you add domain controllers to a domain, AD DS also examines their IP addresses and places them in the most appropriate site.  
  
For a worksheet to assist you in listing the IP subnets within each location, see [Job Aids for Windows Server 2003 Deployment Kit](https://go.microsoft.com/fwlink/?LinkID=102558), download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip, and open "Locations and Subnets" (DSSTOPO_2.doc).  
  
> [!NOTE]  
> In addition to IP version 4 (IPv4) addresses, Windows Server also supports IP version 6 (IPv6) subnet prefixes. For a worksheet to assist you in listing the IPv6 subnet prefixes, see [Appendix A: Locations and subnet prefixes](../../ad-ds/plan/Appendix-A--Locations-and-Subnet-Prefixes.md).  

## Listing domains and number of users for each location

The number of users for each regional domain that is represented in a location is one of the factors that determine the placement of regional domain controllers and global catalog servers, which is the next step in the site topology design process. For example, plan to place a regional domain controller in a location that contains more than 100 regional domain users so they can still log on to the domain if the WAN link fails.  
  
Record the locations, the domains that are represented in each location, and the number of users for each domain that is represented in each location. For a worksheet to assist you in listing the domains and the number of users that are represented in each location, see [Job Aids for Windows Server 2003 Deployment Kit](https://go.microsoft.com/fwlink/?LinkID=102558), download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip, and open "Domains and Users in Each Location" (DSSTOPO_3.doc).  
