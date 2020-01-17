---
ms.assetid: 407d5e81-c04c-4275-9ae9-35f65b4a371a
title: Planning Global Catalog Server Placement
description:
author: MicrosoftGuyJFlo
ms.author: joflore
manager: mtillman
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adds
---

# Planning Global Catalog Server Placement

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Global catalog placement requires planning except if you have a single-domain forest. In a single-domain forest, configure all domain controllers as global catalog servers. Because every domain controller stores the only domain directory partition in the forest, configuring each domain controller as a global catalog server does not require any additional disk space usage, CPU usage, or replication traffic. In a single-domain forest, all domain controllers act as virtual global catalog servers; that is, they can all respond to any authentication or service request. This special condition for single-domain forests is by design. Authentication requests do not require contacting a global catalog server as they do when there are multiple domains, and a user can be a member of a universal group that exists in a different domain. However, only domain controllers that are designated as global catalog servers can respond to global catalog queries on the global catalog port 3268. To simplify administration in this scenario and to ensure consistent responses, designating all domain controllers as global catalog servers eliminates the concern about which domain controllers can respond to global catalog queries. Specifically, any time a user uses Start\Search\For People or Find Printers or expands Universal Groups, these requests go only to the global catalog.  
  
In multiple-domain forests, global catalog servers facilitate user logon requests and forest-wide searches. The following illustration shows how to determine which locations require global catalog servers.  
  
![planning gc placement](media/Planning-Global-Catalog-Server-Placement/8fc4777c-47b6-4ee7-b8ad-a04e7c5ee67f.gif)  
  
In most cases, it is recommended that you include the global catalog when you install new domain controllers. The following exceptions apply:  
  
- Limited bandwidth: In remote sites, if the wide area network (WAN) link between the remote site and the hub site is limited, you can use universal group membership caching in the remote site to accommodate the logon needs of users in the site.  
- Infrastructure operations master role incompatibility: Do not place the global catalog on a domain controller that hosts the infrastructure operations master role in the domain unless all domain controllers in the domain are global catalog servers or the forest has only one domain.  
  
## Adding global catalog servers based on application requirements

Certain applications, such as Microsoft Exchange, Message Queuing (also known as MSMQ), and applications using DCOM do not deliver adequate response over latent WAN links and therefore need a highly available global catalog infrastructure to provide low query latency. Determine whether any applications that perform poorly over a slow WAN link are running in locations or whether the locations require Microsoft Exchange Server. If your locations include applications that do not deliver adequate response over a WAN link, you must place a global catalog server at the location to reduce query latency.  
  
> [!NOTE]  
> Read-only domain controllers (RODCs) can be promoted successfully to global catalog server status. However, certain directory-enabled applications cannot support an RODC as a global catalog server. For example, no version of Microsoft Exchange Server uses RODCs. However, Microsoft Exchange Server works in environments that include RODCs, as long as there are writable domain controllers available. Exchange Server 2007 effectively ignores RODCs. Exchange Server 2003 also ignores RODCs in default conditions where Exchange components automatically detect available domain controllers. No changes were made to Exchange Server 2003 to make it aware of read-only directory servers. Therefore, trying to force Exchange Server 2003 services and management tools to use RODCs may result in unpredictable behavior.  
  
## Adding global catalog servers for a large number of users

Place global catalog servers at all locations that contain more than 100 users to reduce congestion of network WAN links and to prevent productivity loss in case of WAN link failure.  
  
## Using highly available bandwidth

You do not need to place a global catalog at a location that does not include applications that require a global catalog server, includes less than 100 users, and is also connected to another location that includes a global catalog server by a WAN link that is 100 percent available for Active Directory Domain Services (AD DS). In this case, the users can access the global catalog server over the WAN link.  
  
Roaming users need to contact the global catalog servers whenever they log on for the first time at any location. If the logon time over the WAN link is unacceptable, place a global catalog at a location that is visited by a large number of roaming users.  
  
## Enabling universal group membership caching

For locations that include less than 100 users and that do not include a large number of roaming users or applications that require a global catalog server, you can deploy domain controllers that are running  Windows Server 2008  and enable universal group membership caching. Ensure that the global catalog servers are not more than one replication hop from the domain controller on which universal group membership caching is enabled so that universal group information in the cache can be refreshed. For information about how universal group caching works, see the article [How the Global Catalog Works](https://go.microsoft.com/fwlink/?LinkId=107063).  
  
For a worksheet to assist you in documenting where you plan to place global catalog servers and domain controllers with universal group caching enabled, see [Job Aids for Windows Server 2003 Deployment Kit](https://go.microsoft.com/fwlink/?LinkID=102558), download Job_Aids_Designing_and_Deploying_Directory_and_Security_Services.zip, and open Domain Controller Placement (DSSTOPO_4.doc). See the information about locations in which you need to place global catalog servers when you deploy the forest root domain and regional domains.  
