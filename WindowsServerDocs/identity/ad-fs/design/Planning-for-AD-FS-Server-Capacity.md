---
ms.assetid: ef91f1d8-2991-4d90-b687-5fa189737c88
title: Planning for AD FS Server Capacity
description:
author: billmath
ms.author: billmath
manager: femila
ms.date: 05/31/2017
ms.topic: article
ms.prod: windows-server-threshold

ms.technology: identity-adfs
---

# Planning for AD FS Server Capacity


  
> [!NOTE]  
> The content provided in this topic does not reflect actual testing that was performed on servers running  Windows Server 2012 . This topic will be updated once the required testing has been performed.  
  
Capacity planning for Active Directory Federation Services \(AD FS\) is the process of forecasting peak usage periods for your Federation Service and planning or scaling\-up your AD FS server deployment to meet those load requirements.  
  
This section describes deployment guidelines for both the federation server and federation server proxy roles and is based on lab testing that was performed by the AD FS product team at Microsoft. The purpose of this content is to help you:  
  
-   Closely estimate the hardware needs for your organization’s specific AD FS deployment, such as the number of AD FS servers.  
  
-   Accurately project the expected peak usage for sign\-in requests, plan for growth, and ensure that your AD FS deployment is capable of handling that expected peak usage.  
  
Before you proceed with reading this capacity planning content, we recommend that you first complete the tasks in the order shown in the following two tables. In the first table, we provide links to recommended tasks that will help provide relevant context for this capacity planning discussion.  
  
|Recommended task|Description|Reference|  
|--------------------|---------------|-------------|  
|Understand the requirements for deploying AD FS federation servers and federation server proxies|Review important hardware and software requirements necessary for deploying federation server and federation server proxies.|[Appendix A: Reviewing AD FS Requirements](Appendix-A--Reviewing-AD-FS-Requirements.md)|  
|Select the type of AD FS configuration database that you will deploy in your organization|Before you can begin using capacity planning data in this section, you first have to determine which AD FS configuration database type you will deploy, either Windows Internal Database \(WID\) or a Structured Query Language \(SQL\) database.|[The Role of the AD FS Configuration Database](../../ad-fs/technical-reference/The-Role-of-the-AD-FS-Configuration-Database.md);<br /><br />[AD FS Deployment Topology Considerations](AD-FS-Deployment-Topology-Considerations.md)|  
|Determine the type of topology layout to use with your new AD FS configuration database selection|Once you have decided on the type of AD FS configuration database to use in your deployment, you will need to consider which deployment topology most closely matches where you will need to place federation servers and federation server proxies within your production environment.|[Determine Your AD FS Deployment Topology](Determine-Your-AD-FS-Deployment-Topology.md)|  
|Understand key AD FS–related capacity planning terms|Review the definitions of common capacity planning terms that are used throughout the AD FS capacity planning discussion.|See the section titled [AD FS capacity planning terms](Planning-for-AD-FS-Server-Capacity.md#bk_terms) in this topic|  
  
Once you have reviewed the content in the previous table, you can now complete the prerequisite tasks in the next table.  
  
|Prerequisite task|Description|Reference|  
|---------------------|---------------|-------------|  
|Download the AD FS Capacity Planning Sizing Spreadsheet|The AD FS Capacity Planning Sizing spreadsheet can help you to determine the number of federation servers required for an AD FS federation server farm deployment. Instructions for how to use this spreadsheet are available in the link provided below for the next task.|[AD FS Capacity Planning Spreadsheet](http://adfsdocs.blob.core.windows.net/adfs/ADFSCapacityPlanning.xlsx)|  
|Gather data about the number of users who will require single sign\-on \(SSO\) access to the target claims\-aware application and the expected peak usage periods associated with this access|This user data you collect will be used for the input values required within the context of the AD FS Capacity Planning Sizing Spreadsheet.|[Estimate the number of federation servers for your organization](Planning-for-Federation-Server-Capacity.md#bk_estimatefs)|  
|AD FS Capacity Planning Spreadsheet for Windows Server 2016|Updated Planning worksheet for Windows Server 2016|[AD FS Windows Server 2016 Capacity Planning](http://adfsdocs.blob.core.windows.net/adfs/ADFSCapacity2016.xlsx)  
  
## <a name="bk_terms"></a>AD FS capacity planning terms  
The following table describes important terms that are used often in this capacity planning section of the AD FS Design Guide. For a more complete list of AD FS terms, see [Understanding Key AD FS Concepts](../../ad-fs/technical-reference/Understanding-Key-AD-FS-Concepts.md).  
  
|Term|Definition|  
|--------|--------------|  
|Concurrent users|The estimated number of users that are expected to submit requests to the service within a given period of time, usually a peak activity period.|  
|Active users|The approximate average number of users that are active on a system, but not necessarily submitting requests, during a given period of time.|  
|Defined users|A theoretical maximum user count, usually based on the number of users who have defined accounts in the system.|  
|Requests per second|The number of requests either submitted by clients \(when talking about the load on a system\) or processed by servers \(when talking about server throughput\) in a second. This metric is used in planning server processor and memory capacity.|  
|Target server responsiveness and utilization|Success metrics that bound the acceptable server performance range. Generally, if responsiveness goes below or utilization goes above the target, the system is considered to be overloaded and more capacity is required.|  
|Windows Internal Database \(WID\)|The default AD FS configuration database that can be used as an alternative to SQL Server in certain AD FS deployments.|  
  
## Configuration environment used during AD FS testing  
This section describes the configuration environment that the AD FS product team used to perform its tests. The team used the following computer hardware, software, and network configuration to gather performance and scalability data in tests of the federation server:  
  
-   Dual Quad Core 2.27 gigahertz \(GHz\) \(8 cores\)  
  
-   16\-GB RAM  
  
-   Windows Server 2008 R2, Enterprise Edition  
  
-   Gigabit Network  
  
> [!NOTE]  
> Although 16 GB’s of RAM was used on the federation server during testing, a more moderate memory size, such as 4 GB’s of RAM per federation server can be used for most AD FS deployments. The recommendations that are provided in this AD FS Capacity Planning content along with the results provided by the AD FS Capacity Planning Spreadsheet are based on assumptions that each federation server will use approximately 4GB’s of RAM for most AD FS production environments.  
  
The product team used the following configuration to gather performance and scalability data for the federation server proxy testing:  
  
-   Dual Quad Core 2.24 GHz \(4 cores\)  
  
-   4\-GB RAM  
  
-   Windows Server 2008 R2, Enterprise Edition  
  
-   Gigabit Network  
  
> [!NOTE]  
> Capacity recommendations for AD FS servers can vary considerably, depending on the specifications you choose for the hardware and network configuration to be used in a given environment. As a point of reference, the sizing guidance provided in this content is based on a utilization target of 80 percent on the computers mentioned earlier.  
  
## Measure AD FS server capacity  
Typically, the hardware components that affect server performance and scalability are the CPU, memory, the disk, and network adapters. Fortunately, each of the AD FS components requires very little demand on memory and disk space. Network connectivity is an obvious requirement. Therefore, load tests that are performed on federation servers and federation server proxies concentrate on two primary areas for measuring server capacity:  
  
-   **Peak AD FS requests per second:** The number of sign\-in requests that are processed per second on federation servers. This measurement can help you determine how many simultaneous users can sign in to a given server. You can use this measurement in conjunction with the CPU consumption measurement to understand this measurement's effect on performance.  
  
-   **CPU consumption:** The percentage by which CPU capacity is measured. This measurement can help you determine the overall CPU load that occurred based on the number of incoming sign\-in requests per second.  
  
## Continue reading more about AD FS capacity planning  
After you have completed the prerequisite tasks and have become familiar with related terms and hardware requirements, you can use the following additional capacity planning content to help you determine the recommended number of AD FS servers required for your deployment:  
  
-   [Planning for Federation Server Capacity](Planning-for-Federation-Server-Capacity.md)  
  
-   [Planning for Federation Server Proxy Capacity](Planning-for-Federation-Server-Proxy-Capacity.md)  
  
## See Also
[AD FS Design Guide in Windows Server 2012](AD-FS-Design-Guide-in-Windows-Server-2012.md)
