---
ms.assetid: 5c8c6cc0-0d22-4f27-a111-0aa90db7d6c8
title: Plan Your AD FS Deployment Topology
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Plan Your AD FS Deployment Topology

The first step in planning a deployment of Active Directory Federation Services \(AD FS\) is to determine the right deployment topology to meet the needs of your organization.  
  
Before you read this topic, review how AD FS data is stored and replicated to other federation servers in a federation server farm and make sure you understand the purpose of and the replication methods that can be used for the underlying data that is stored in the AD FS configuration database.  
  
There are two database types that you can use to store AD FS configuration data: Windows Internal Database \(WID\) and Microsoft SQL Server. For more information, see [The Role of the AD FS Configuration Database](../../ad-fs/technical-reference/The-Role-of-the-AD-FS-Configuration-Database.md). Review the various benefits and limitations that are associated with using either WID or SQL Server as the AD FS configuration database, along with the various application scenarios that they support and then make your selection.  
  
> [!IMPORTANT]  
> To implement basic redundancy, load balancing, and the option to scale the Federation Service \(if required\), we recommend that you deploy at  least two federation servers per federation server farm for all production environments, regardless of the type of database that you will use.  
  
## Determining which type of AD FS configuration database to use  
AD FS uses a database to store configuration and—in some cases—transactional data related to the Federation Service. You can use the AD FS software to select either the built\-in Windows Internal Database \(WID\) or Microsoft SQL Server 2008 or newer to store the data in the Federation Service.  
  
For most purposes, the two database types are relatively equivalent. However, there are some differences to be aware of before you begin reading more about the various deployment topologies that you can use with AD FS. The following table describes the differences in supported features between a WID database and a SQL Server database.  
  
||Feature|Supported by WID?|Supported by SQL Server?
| --- | --- | --- |--- |
|AD FS features|Federation server farm deployment|Yes. A WID farm has a limit of 30 federation servers if you have 100 or fewer relying party trusts.</br></br>A WID farm does not support token replay detection or artifact resolution (part of the Security Assertion Markup Language (SAML) protocol). |Yes. There is no enforced limit for the number of federation servers that you can deploy in a single farm  
|AD FS features|SAML artifact resolution </br></br>**Note:** This feature is not required for Microsoft Online Services, Microsoft Office 365, Microsoft Exchange, or Microsoft Office SharePoint scenarios.|No|Yes  
|AD FS features|SAML\/WS\-Federation token replay detection|No|Yes  
|Database features|Basic database redundancy using pull replication, where one or more servers hosting a read\-only copy of the database request changes that are made on a source server that hosts a read\/write copy of the database|Yes|No 
|Database features|Database redundancy using high\-availability solutions, such as failover clustering or mirroring \(at the database layer only\) **Note:** All AD FS deployment topologies support clustering at the AD FS service layer.|No|Yes  

  
## SQL Server considerations  
You should consider the following deployment facts if you select SQL Server as the configuration database for your AD FS deployment.  
  
-   **SAML features and their effect on database size and growth**. When either the SAML artifact resolution or SAML token replay detection features are enabled, AD FS stores information in the SQL Server configuration database for each AD FS token that is issued. The growth of the SQL Server database as a result of this activity is not considered to be significant, and it depends on the configured token replay retention period. Each artifact record has a size of approximately 30 kilobytes \(KB\).  
  
-   **Number of servers required for your deployment**. You will need to add at least one additional server \(to the total number of servers required to deploy your AD FS infrastructure\) that will act as a dedicated host of the SQL Server instance. If you plan to use failover clustering or mirroring to provide fault tolerance and scalability for the SQL Server configuration database, a minimum of two SQL servers is required.  
  
## How the configuration database type you select may impact hardware resources  
The impact to hardware resources on a federation server that is deployed in a farm using WID as opposed to a federation server that is deployed in a farm using the SQL Server database is not significant. However, it is important to consider that when you use WID for the farm, each federation server in that farm must store, manage, and maintain replication changes for its local copy of the AD FS configuration database while also continuing to provide the normal operations that the Federation Service requires.  
  
In comparison, federation servers that are deployed in a farm that uses the SQL Server database do not necessarily contain a local instance of the AD FS configuration database. Therefore, they may make slightly fewer demands on hardware resources.  
  
## <a name="BKMK_1"></a>Where to place a federation server  
As a security best practice, place AD   FS federation servers in front of a firewall and connect them to your corporate network to prevent exposure from the Internet. This is important because federation servers have full authorization to grant security tokens. Therefore, they should have the same protection as a domain controller. If a federation server is compromised, a malicious user has the ability to issue full access tokens to all Web applications and to federation servers that are protected by AD FS.  
  
> [!NOTE]  
> As a security best practice, avoid having your federation servers directly accessible on the Internet. Consider giving your federation servers direct Internet access only when you are setting up a test lab environment or when your organization does not have a perimeter network.  
  
For typical corporate networks, an intranet\-facing firewall is established between the corporate network and the perimeter network, and an Internet\-facing firewall is often established between the perimeter network and the Internet. In this situation, the federation server sits inside the corporate network, and it is not directly accessible by Internet clients.  
  
> [!NOTE]  
> Client computers that are connected to the corporate network can communicate directly with the federation server through Windows Integrated Authentication.  
  
A federation server proxy should be placed in the perimeter network before you configure your firewall servers for use with AD FS.  
  
## Supported deployment topologies  
The following topics describe the various deployment topologies that you can use with AD FS. They also describe the benefits and limitations associated with each deployment topology so that you can select the most appropriate topology for your specific business needs.  
  
-   [Federation Server Farm Using WID](Federation-Server-Farm-Using-WID.md)  
  
-   [Federation Server Farm Using WID and Proxies](Federation-Server-Farm-Using-WID-and-Proxies.md)  
  
-   [Federation Server Farm Using SQL Server](Federation-Server-Farm-Using-SQL-Server.md)  
  
## See Also  
[AD FS Design Guide in Windows Server 2012 R2](AD-FS-Design-Guide-in-Windows-Server-2012-R2.md)  
  

