---
title: Plan Your AD FS Deployment Topology
ms.custom: 
  - AD
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-identity
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 48555e40-5506-44a5-9cf5-7d1825a91fb9
author: billmath
---
# Plan Your AD FS Deployment Topology
The first step in planning a deployment of [!INCLUDE[firstref_adfs2]()] is to determine the right deployment topology to meet the needs of your organization.  
  
Before you read this topic, review how [!INCLUDE[nextref_adfs2]()] data is stored and replicated to other federation servers in a federation server farm and make sure you understand the purpose of and the replication methods that can be used for the underlying data that is stored in the AD FS configuration database.  
  
There are two database types that you can use to store AD FS configuration data: Windows Internal Database \(WID\) and Microsoft SQL Server. For more information, see [The Role of the AD FS Configuration Database](). Review the various benefits and limitations that are associated with using either WID or SQL Server as the AD FS configuration database, along with the various application scenarios that they support and then make your selection.  
  
> [!IMPORTANT]  
> To implement basic redundancy, load balancing, and the option to scale the Federation Service \(if required\), we recommend that you deploy at  least two federation servers per federation server farm for all production environments, regardless of the type of database that you will use.  
  
## Determining which type of AD FS configuration database to use  
[!INCLUDE[nextref_adfs2]()] uses a database to store configuration and—in some cases—transactional data related to the Federation Service. You can use the [!INCLUDE[nextref_adfs2]()] software to select either the built\-in Windows Internal Database \(WID\) or Microsoft SQL Server 2008 or newer to store the data in the Federation Service.  
  
For most purposes, the two database types are relatively equivalent. However, there are some differences to be aware of before you begin reading more about the various deployment topologies that you can use with [!INCLUDE[nextref_adfs2]()]. The following table describes the differences in supported features between a WID database and a SQL Server database.  
  
|Feature|Supported by WID?|Supported by SQL Server?|  
|-----------|---------------------|----------------------------|  
||  
|[!INCLUDE[nextref_adfs2]()] features|Federation server farm deployment|Yes. If you have 5 or fewer relying party trusts, a maximum of ten AD FS servers in a single AD FS farm is supported for AD FS in Windows Server 2012 R2. If you have more than 5 relying party trusts, a maximum of five AD FS servers in a single farm is supported.|Yes. There is no enforced limit for the number of federation servers that you can deploy in a single farm|  
|[!INCLUDE[nextref_adfs2]()] features|SAML artifact resolution **Note:** This feature is not required for Microsoft Online Services, Microsoft Office 365, Microsoft Exchange, or Microsoft Office SharePoint scenarios.|No|Yes|  
|[!INCLUDE[nextref_adfs2]()] features|SAML\/WS\-Federation token replay detection|No|Yes|  
|Database features|Basic database redundancy using pull replication, where one or more servers hosting a read\-only copy of the database request changes that are made on a source server that hosts a read\/write copy of the database|Yes|No|  
|Database features|Database redundancy using high\-availability solutions, such as failover clustering or mirroring \(at the database layer only\) **Note:** All [!INCLUDE[nextref_adfs2]()] deployment topologies support clustering at the AD FS service layer.|No|Yes|  
  
## SQL Server considerations  
You should consider the following deployment facts if you select SQL Server as the configuration database for your AD FS deployment.  
  
-   **SAML features and their effect on database size and growth**. When either the SAML artifact resolution or SAML token replay detection features are enabled, AD FS stores information in the SQL Server configuration database for each AD FS token that is issued. The growth of the SQL Server database as a result of this activity is not considered to be significant, and it depends on the configured token replay retention period. Each artifact record has a size of approximately 30 kilobytes \(KB\).  
  
-   **Number of servers required for your deployment**. You will need to add at least one additional server \(to the total number of servers required to deploy your [!INCLUDE[nextref_adfs2]()] infrastructure\) that will act as a dedicated host of the SQL Server instance. If you plan to use failover clustering or mirroring to provide fault tolerance and scalability for the SQL Server configuration database, a minimum of two SQL servers is required.  
  
## How the configuration database type you select may impact hardware resources  
The impact to hardware resources on a federation server that is deployed in a farm using WID as opposed to a federation server that is deployed in a farm using the SQL Server database is not significant. However, it is important to consider that when you use WID for the farm, each federation server in that farm must store, manage, and maintain replication changes for its local copy of the AD FS configuration database while also continuing to provide the normal operations that the Federation Service requires.  
  
In comparison, federation servers that are deployed in a farm that uses the SQL Server database do not necessarily contain a local instance of the AD FS configuration database. Therefore, they may make slightly fewer demands on hardware resources.  
  
## <a name="BKMK_1"></a>Where to place a federation server  
As a security best practice, place AD   FS [!INCLUDE[adfs2_fs]()]s in front of a firewall and connect them to your corporate network to prevent exposure from the Internet. This is important because [!INCLUDE[adfs2_fs]()]s have full authorization to grant security tokens. Therefore, they should have the same protection as a domain controller. If a [!INCLUDE[adfs2_fs]()] is compromised, a malicious user has the ability to issue full access tokens to all Web applications and to [!INCLUDE[adfs2_fs]()]s that are protected by AD FS.  
  
> [!NOTE]  
> As a security best practice, avoid having your [!INCLUDE[adfs2_fs]()]s directly accessible on the Internet. Consider giving your [!INCLUDE[adfs2_fs]()]s direct Internet access only when you are setting up a test lab environment or when your organization does not have a perimeter network.  
  
For typical corporate networks, an intranet\-facing firewall is established between the corporate network and the perimeter network, and an Internet\-facing firewall is often established between the perimeter network and the Internet. In this situation, the [!INCLUDE[adfs2_fs]()] sits inside the corporate network, and it is not directly accessible by Internet clients.  
  
> [!NOTE]  
> Client computers that are connected to the corporate network can communicate directly with the [!INCLUDE[adfs2_fs]()] through Windows Integrated Authentication.  
  
A [!INCLUDE[adfs2_fsp]()] should be placed in the perimeter network before you configure your firewall servers for use with [!INCLUDE[nextref_adfs2]()].  
  
## Supported deployment topologies  
The following topics describe the various deployment topologies that you can use with [!INCLUDE[nextref_adfs2]()]. They also describe the benefits and limitations associated with each deployment topology so that you can select the most appropriate topology for your specific business needs.  
  
-   [Federation Server Farm Using WID]()  
  
-   [Federation Server Farm Using WID and Proxies]()  
  
-   [Federation Server Farm Using SQL Server]()  
  
## See Also  
[AD FS Design Guide in Windows Server 2012 R2]()  
  

