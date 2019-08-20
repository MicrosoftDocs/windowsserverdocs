---
ms.assetid: 4ef052f0-61a9-4912-b780-5c96187c850f
title: AD FS Deployment Topology Considerations
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# AD FS Deployment Topology Considerations

This topic describes important considerations to help you plan and design which Active Directory Federation Services \(AD FS\) deployment topology to use in your production environment. This topic is a starting point for reviewing and assessing considerations that affect what features or capabilities will be available to you after you deploy AD FS. For example, depending on which database type you choose to store the AD FS configuration database will ultimately determine whether you can implement certain Security Assertion Markup Language \(SAML\) features that require SQL Server.  

## Determining which type of AD FS configuration database to use  
AD FS uses a database to store configuration and—in some cases—transactional data related to the Federation Service. You can use the AD FS software to select either the built\-in Windows Internal Database \(WID\) or Microsoft SQL Server 2005 or newer to store the data in the Federation Service.  

For most purposes, the two database types are relatively equivalent. However, there are some differences to be aware of before you begin reading more about the various deployment topologies that you can use with AD FS. The following table describes the differences in supported features between a WID database and a SQL Server database.  

AD FS features  

|Feature|Supported by WID?|Supported by SQL Server?|More information about this feature|  
|-----------|---------------------|----------------------------|---------------------------------------|  
|Federation server farm deployment|Yes, with a limit of 30 federation servers for each farm|Yes. There is no enforced limit for the number of federation servers that you can deploy in a single farm|[Determine Your AD FS Deployment Topology](Determine-Your-AD-FS-Deployment-Topology.md)|  
|SAML artifact resolution **Note:** This feature is not required for Microsoft Online Services, Microsoft Office 365, Microsoft Exchange, or Microsoft Office SharePoint scenarios.|No|Yes|[The Role of the AD FS Configuration Database](../../ad-fs/technical-reference/The-Role-of-the-AD-FS-Configuration-Database.md)<br /><br />[Best Practices for Secure Planning and Deployment of AD FS](Best-Practices-for-Secure-Planning-and-Deployment-of-AD-FS.md)|  
|SAML\/WS\-Federation token replay detection|No|Yes|[The Role of the AD FS Configuration Database](../../ad-fs/technical-reference/The-Role-of-the-AD-FS-Configuration-Database.md)<br /><br />[Best Practices for Secure Planning and Deployment of AD FS](Best-Practices-for-Secure-Planning-and-Deployment-of-AD-FS.md)|  

Database features  

|Feature|Supported by WID?|Supported by SQL Server?|More information about this feature|  
|-----------|---------------------|----------------------------|---------------------------------------|  
|Basic database redundancy using pull replication, where one or more servers hosting a read\-only copy of the database request changes that are made on a source server that hosts a read\/write copy of the database|Yes|No|[The Role of the AD FS Configuration Database](../../ad-fs/technical-reference/The-Role-of-the-AD-FS-Configuration-Database.md)|  
|Database redundancy using high\-availability solutions, such as failover clustering or mirroring \(at the database layer only\) **Note:** All AD FS deployment topologies support clustering at the AD FS service layer.|No|Yes|[The Role of the AD FS Configuration Database](../../ad-fs/technical-reference/The-Role-of-the-AD-FS-Configuration-Database.md)<br /><br />[High Availability Solutions Overview](https://go.microsoft.com/fwlink/?LinkId=179853)|  

### SQL Server considerations  
You should consider the following deployment facts if you select SQL Server as the configuration database for your AD FS deployment.  

-   **SAML features and their effect on database size and growth**. When either the SAML artifact resolution or SAML token replay detection features are enabled, AD FS stores information in the SQL Server configuration database for each AD FS token that is issued. The growth of the SQL Server database as a result of this activity is not considered to be significant, and it depends on the configured token replay retention period. Each artifact record has a size of approximately 30 kilobytes \(KB\).  

-   **Number of servers required for your deployment**. You will need to add at least one additional server \(to the total number of servers required to deploy your AD FS infrastructure\) that will act as a dedicated host of the SQL Server instance. If you plan to use failover clustering or mirroring to provide fault tolerance and scalability for the SQL Server configuration database, a minimum of two SQL servers is required.  

### How the configuration database type you select may impact hardware resources  
The impact to hardware resources on a federation server that is deployed in a farm using WID as opposed to a federation server that is deployed in a farm using the SQL Server database is not significant. However, it is important to consider that when you use WID for the farm, each federation server in that farm must store, manage, and maintain replication changes for its local copy of the AD FS configuration database while also continuing to provide the normal operations that the Federation Service requires.  

In comparison, federation servers that are deployed in a farm that uses the SQL Server database do not necessarily contain a local instance of the AD FS configuration database. Therefore, they may make slightly fewer demands on hardware resources.  

## Verifying that your production environment can support an AD FS deployment  
In addition to the federation servers that you will deploy, and depending on how your existing production environment is set up, the following additional servers may be required to provide the necessary infrastructure to support your new AD FS deployment:  

-   Active Directory domain controller  

-   Certification authority \(CA\)  

-   Web server to host federation metadata  

-   Network load balancing \(NLB\)  

## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
