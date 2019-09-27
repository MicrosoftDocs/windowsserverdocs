---
ms.assetid: f67b0bc9-e5af-4891-9da0-d9be539af42d
title: Determine Your AD FS Deployment Topology
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server

ms.technology: identity-adfs
---

# Determine Your AD FS Deployment Topology

The first step in planning a deployment of Active Directory Federation Services \(AD FS\) is to determine the right deployment topology to meet the single sign\-on \(SSO\) needs of your organization. The topics in this section describe the various deployment topologies that you can use with AD FS. They also describe the benefits and limitations associated with each deployment topology so that you can select the most appropriate topology for your specific business needs.  
  
Before you read this deployment topology topic, we recommend that you first complete the tasks in the order shown in the following table.  
  
|Recommended task|Description|Reference|  
|--------------------|---------------|-------------|  
|Review how AD FS data is stored and replicated to other federation servers in a federation server farm.|Understand the purpose of and the replication methods that can be used for the underlying data that is stored in the AD FS configuration database. This topic introduces the concepts of the configuration database and describes the two database types: Windows Internal Database \(WID\) and Microsoft SQL Server.|[The Role of the AD FS Configuration Database](../../ad-fs/technical-reference/The-Role-of-the-AD-FS-Configuration-Database.md)|  
|Select the type of AD FS configuration database that you will deploy in your organization.|Review the various benefits and limitations that are associated with using either WID or SQL Server as the AD FS configuration database, along with the various application scenarios that they support.|[AD FS Deployment Topology Considerations](AD-FS-Deployment-Topology-Considerations.md)|  
  
> [!NOTE]  
> To implement basic redundancy, load balancing, and the option to scale the Federation Service \(if required\), we recommend that you deploy at  least two federation servers per federation server farm for all production environments, regardless of the type of database that you will use.  
  
When you have reviewed the content in the previous table, proceed to the following topics in this section:  
  
-   [Stand-Alone Federation Server Using WID](Stand-Alone-Federation-Server-Using-WID.md)  
  
-   [Federation Server Farm Using WID](Federation-Server-Farm-Using-WID-2012.md)  
  
-   [Federation Server Farm Using WID and Proxies](Federation-Server-Farm-Using-WID-and-Proxies-2012.md)  
  
-   [Federation Server Farm Using SQL Server](Federation-Server-Farm-Using-SQL-Server-2012.md)  
  
After you finish selecting your AD FS deployment topology, we recommend that you review the topic [Planning for AD FS Server Capacity](Planning-for-AD-FS-Server-Capacity.md) to determine the recommended number of servers that you will need to deploy to support this topology.  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)

