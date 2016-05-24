---
title: Building Your Cloud Infrastructure: Scenario Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 366a8096-18e8-44e8-9bb7-355d3781c4d5
---
# Building Your Cloud Infrastructure: Scenario Overview
An overview of the process for building your cloud infrastructure in [!INCLUDE[win8_server_1](../Token/win8_server_1_md.md)] for building an infrastructure for public and private clouds, including a scenario description, its practical applications, the roles and services that enable it, and links to topics that describe how to deploy it.  
  
**Did you mean…**  
  
1.  *[Private cloud](http://technet.microsoft.com/cloud/hh162047)*  
  
2.  *[Public cloud Software as a Service](http://www.microsoft.com/office365/online-software.aspx)*  
  
3.  *[Public Cloud Platform as a Service](http://www.windowsazure.com/)*  
  
## <a name="BKMK_OVER"></a>Scenario description  
The process for building your cloud infrastructure uses a combination of Hyper\-V, failover clustering, storage, and networking technologies to more easily create a Microsoft cloud infrastructure. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduces a significant number of new features that provide all of the required capabilities for building an effective cloud infrastructure in an open platform. By using automation, having an open platform, and being standards based, a [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]\-based cloud infrastructure decreases the total cost of ownership and reduces susceptibility to failures due to interoperability issues. The [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] open platform allows partners to extend the functionality beyond what is in the platform.  
  
## In this scenario  
The following topics for the process for building your cloud infrastructure allow you to design a Hyper\-V cluster for hosting the virtual machines of an IaaS cloud, configure the cloud, and then perform operations such as the on boarding of existing virtual machines and virtual machine maintenance:  
  
-   [Building Your Cloud Infrastructure: Non-Converged Data Center Configuration](../Topic/Building-Your-Cloud-Infrastructure--Non-Converged-Data-Center-Configuration.md)  
  
-   [Building Your Cloud Infrastructure: Converged Data Center with File Server Storage](assetId:///d266e62d-8a95-4c03-9276-9aa6ac0c0474)  
  
-   [Building Your Cloud Infrastructure: Converged Data Center without Dedicated Storage Nodes](assetId:///f38e1f6b-c18f-4135-9641-517754281570)  
  
## <a name="BKMK_APP"></a>Practical applications  
Building a cloud infrastructure with [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is much easier than previous versions of Windows Server because of built\-in support for the following:  
  
-   Multi\-tenancy  
  
    Designing a data center for dynamic and automatic placement of virtual machines is not enough, especially when you are serving more than one customer. Multi\-tenancy is the ability of a cloud infrastructure to support the virtual machine workloads of multiple tenants, but isolate them from each other, but all of the workloads run on the same infrastructure.  The multiple workloads of an individual tenant can interconnect and be managed remotely, but these systems do not interconnect with the workloads of other tenants, nor can other tenants remotely manage them.  
  
-   Highly Scalable, Low\-Cost Data Center  
  
    You can deploy different scales of clouds, such as:  
  
    -   A mid\-market business with a need for a small number of servers  
  
    -   An enterprise with hundreds or thousands of servers  
  
    -   An IaaS hosting provider with thousands of servers for multiple customers  
  
    In all of these cases, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] supports features that use low\-cost alternatives to traditional data center resources that allow small clouds to be easily built, but also supports features that enable high scale operations.  
  
-   Managing and Extending the Data Center  
  
    [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] simplifies data center initial configuration and ongoing management with the support of PowerShell 3.0 and PowerShell workflows. With the Hyper\-V virtual switch in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], vendors and partners can extend the capabilities of the virtual switch to develop additional functionality, such as network monitoring, security, or routing add\-ons.  
  
## <a name="BKMK_NEW"></a>Roles and features included in this scenario  
The following table lists the roles and features that are part of this scenario and describes how they support it.  
  
|Role\/feature|How it supports this scenario|  
|-----------------|---------------------------------|  
|[Hyper\-V](assetId:///5aad349f-ef06-464a-b36f-366fbb040143)|The Hyper\-V server role hosts the virtual machines that make up the IT workloads running in the cloud. The process for building your cloud infrastructure takes advantage of many new features of Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], including the Hyper\-V virtual switch, live migration and storage migration improvements, Hyper\-V Replica, and resource metering.|  
|[Failover Clustering](assetId:///6eeffe4f-3558-495b-bcea-c640fe4d6c49)|The Failover Clustering feature allows a set of computers to act as a single computer, providing scale\-out and failover to clustered services and resources, including storage and virtual machines. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is tightly integrated with Hyper\-V and enables much of the fabric management capabilities required for a cloud infrastructure.|  
|[File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md)|File and Storage Services allows a pool of storage to be made available to the cluster to assign to virtual machines and to store virtual hard disk files.|  
|[Network Adapter Teaming Technical Preview](assetId:///bad08782-bbd2-40c3-9cb1-ec54b9e87628)|The network adapter teaming feature allows you to group multiple network adapters into a team that appears as a single network adapter for bandwidth aggregation and fault tolerance.|  
|[Hyper\-V virtual switch](assetId:///e6ec46af-6ef4-49b3-b1f1-5268dc03f05b)|The Hyper\-V virtual switch platform allows network partners to easily hook into the Hyper\-V virtual switch network flows and build monitoring, security, and forwarding extensions.|  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
The exact hardware requirements depend on the types of workloads you are planning to run on the Hyper\-V servers in the cloud infrastructure. However, some features included in the cloud infrastructure scenarios require specialized BIOS capabilities, such as those needed to support Single Root I\/O Virtualization \(SR\-IOV\). Any technologies specific hardware requirements are discussed within the pertinent scenario..  
  
## <a name="BKMK_SOFT"></a>Software requirements  
Clouds based on this process for building your cloud infrastructure require [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and its platform capabilities.  
  
## <a name="BKMK_LINKS"></a>See also  
See the following table for links to additional resources about building your cloud infrastructure.  
  
|Content type|References|  
|----------------|--------------|  
|**Product evaluation**|[Building an Infrastructure as a Service \(IaaS\) Cloud Using Windows Server 2012](http://msdn.microsoft.com/library/windows/hardware/hh506335)|  
|**Deployment**|[Building Your Cloud Infrastructure: Non-Converged Data Center Configuration](../Topic/Building-Your-Cloud-Infrastructure--Non-Converged-Data-Center-Configuration.md) &#124; [Building Your Cloud Infrastructure: Converged Data Center with File Server Storage](assetId:///d266e62d-8a95-4c03-9276-9aa6ac0c0474) &#124; [Building Your Cloud Infrastructure: Converged Data Center without Dedicated Storage Nodes](assetId:///f38e1f6b-c18f-4135-9641-517754281570)|  
|**Community resources**|[Private Cloud Architecture Blog](http://blogs.technet.com/b/privatecloud/)|  
|**Related technologies**|[Hyper\-V](assetId:///5aad349f-ef06-464a-b36f-366fbb040143) &#124; [Failover Clustering](assetId:///6eeffe4f-3558-495b-bcea-c640fe4d6c49) &#124; [File and Storage Services Overview](../Topic/File-and-Storage-Services-Overview.md) &#124; [Windows Networking](assetId:///01868d35-e1a3-41ca-bc76-ef72884626d7)|  
  
