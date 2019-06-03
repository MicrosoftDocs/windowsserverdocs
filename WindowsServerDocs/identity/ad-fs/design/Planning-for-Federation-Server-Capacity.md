---
ms.assetid: 7013fc21-9ced-4f9d-9588-cb04d6d60924
title: Planning for Federation Server Capacity
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Planning for Federation Server Capacity

Capacity planning for federation servers helps you estimate:  
  
-   Which factors grow the size of the AD FS configuration database.  
  
-   The appropriate hardware requirements for each federation server.  
  
-   The number of federation servers to place in each organization.  
  
Federation servers issue security tokens to users. These tokens are presented to a relying party for consumption. Federation servers issue security tokens after authenticating a user or after receiving a security token that was previously issued by a partner Federation Service. A security token is requested from a Federation Service when users initially sign in to federated applications or when their security tokens expire while they are accessing federated applications.  
  
Federation servers are designed to accommodate high\-availability server farm configurations that use Microsoft Network Load Balancing \(NLB\) technology. Federation servers in a farm configuration can service requests independently, without accessing any common farm components for each request. Therefore, there is little overhead involved in scaling out a federation server deployment.  
  
**Recommendations:**  
  
-   For mission\-critical or high\-availability deployments, we recommend that you create a small federation server farm in each partner organization, with at least two federation servers per farm, to provide fault tolerance.  
  
-   With the need for high availability and the ease of scaling out federation servers, scaling out is the recommended method for handling high numbers of requests per second for a particular Federation Service. Scaling up beyond the base configuration in this guide is unlikely to produce significant capacity handling gains.  
  
## AD FS configuration database size and growth  
The size of the AD FS configuration database is generally considered to be small, and database size does not tend to be a major consideration in AD FS deployments.  The precise size of the AD FS configuration database can depend largely on the number of trust relationships and the associated trust\-related metadata—such as claims, claim rules, and monitoring settings configured for each trust. As the number of trust entries in the configuration database grows, so does the need for more disk space.  
  
For additional deployment information about the AD FS configuration database, see [AD FS Deployment Topology Considerations](AD-FS-Deployment-Topology-Considerations.md).  
  
## Memory, CPU and disk space requirements  
Fortunately, memory, CPU and disk space requirements for federation servers are modest, and they are not likely to be a driving factor in hardware decisions. For more information about hardware requirements, see [Appendix A: Reviewing AD FS Requirements](Appendix-A--Reviewing-AD-FS-Requirements.md).  
  
> [!NOTE]  
> In tests that were performed by the AD FS product team using a federation server farm configured with a dedicated SQL Server to store the AD FS configuration database, the overall load on the SQL Server tended to be low. In one test using a four\-federation\-server farm that was configured to use a single SQL Server, CPU utilization did not exceed 10% despite testing that brought the federation servers to target utilization.  
  
## <a name="bk_estimatefs"></a>Estimate the number of federation servers for your organization  
In an effort to streamline the hardware planning process for federation servers, the AD FS product team developed the AD FS Capacity Planning Sizing Spreadsheet. This Excel spreadsheet includes calculator\-like functionality that will take expected usage data that you provide about users in your organization and return a recommended optimal number of federation servers for your AD FS production environment.  
  
> [!NOTE]  
> The number of federation servers that this spreadsheet will recommend is based on the hardware and network specifications that the AD FS product team used during testing. Therefore, the number of federation servers that the spreadsheet will recommend must be understood within this context.  For more information about the specifications used during testing, see the topic titled [Planning for AD FS Server Capacity](Planning-for-AD-FS-Server-Capacity.md).  
  
### Using the AD FS Capacity Planning Sizing Spreadsheet  
When you use this spreadsheet, you will need to select a value \(either **40%**, **60%**, or **80%**\) that best represents the percentage of total users you expect will send authentication requests to your federation servers during peak usage periods.  
  
Then, you will need to select a value \(either **1 minute**, **15 minutes**, or **1 hour**\) that best represents the length of time you expect the peak usage period to last. For example, you might estimate 40% as the value for the total number of users who will login within a period of 15 minutes, or that 60% of users will login within a period of 1 hour. Together, these values define the peak load profile by which your sizing recommendation will be calculated.  
  
Next, you will need to specify the total number of users that will require single sign\-on access to the target claims\-aware application, based on whether the users are:  
  
-   Logging into Active Directory from a local computer that is physically connected to your corporate network \(through Windows integrated authentication\)  
  
-   Logging into Active Directory remotely from a computer that is not physically connected to your corporate network \(through Windows integrated authentication or Username and password\)  
  
-   From another organization and are attempting to access the target claims\-aware application from a trusted partner  
  
-   From a SAML 2.0 identity provider and are attempting to access the target claims\-aware application  
  
#### How to use this spreadsheet  
You can use the following steps for each federation server farm instance you plan to deploy to determine the recommended number of federation servers.  
  
1.  Download and then open the [AD FS Capacity Planning Sizing Spreadsheet For Windows Server 2012 R2](https://adfsdocs.blob.core.windows.net/adfs/ADFSCapacityPlanning.xlsx) or the [AD FS Capacity Planning Sizing Spreadsheet For Windows Server 2016](https://adfsdocs.blob.core.windows.net/adfs/ADFSCapacity2016.xlsx).
  
2.  In the cell to the right of the **During the peak system usage period, I expect this percentage of my users to authenticate** cell, click the cell and then use the drop\-down arrows to select your estimated system utilization level, either **40%**, **60%** or **80%** for the deployment.  
  
3.  In the cell to the right of the **within the following period of time** cell, click the cell and then use the drop\-down arrows to select either **1 minute**, **15 minutes**, or **1 hour** to select the duration of peak load.  
  
4.  In the cell to the right of the **Enter estimated number of internal applications \(such as SharePoint \(2007 or 2010\) or claims aware web applications\)** cell, type the number of internal applications you will use in your organization.  
  
5.  In the cell to the right of the **Enter estimated number of online applications \(such as Office 365 Exchange Online, SharePoint Online or Lync Online\)** cell, type the number of online applications or services you will used in your organization.  
  
6.  Under the cell titled **Number of Users**, type a number on each row that applies to an example application scenario your users will need single sign\-on access to. This column should contain the number of defined users, not the peak users per second. If access attempts made to the application must first go through the home realm discovery page, type **Y**. If you are unsure of this selection, type **Y**.  
  
7.  Review the following recommended values that are provided:  
  
    1.  For the total number of recommended federation servers, see the lower right cell that is highlighted in gray.  
  
    2.  For the number of servers recommended for each example application scenario, see the cell on the row that is highlighted in gray.  
  
> [!NOTE]  
> The value that will be automatically calculated in the cell to the right of the cell titled **Total number of federation servers recommended** at the bottom of the spreadsheet contains a formula which will add an additional 20% buffer to the sum total of all the values in each of the individual rows preceding it. The formula added to the **Total number of federation servers recommended** cell builds in this buffer to your total recommended number of deployed federation servers to make it very unlikely that the overall load on the farm will ever hit its saturation point.  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
