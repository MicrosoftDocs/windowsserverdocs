---
title: Failover Clustering Overview for Windows Server Threshold
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 984b6f74-e35d-484f-9df9-7264ed6d84bc
author: kumudd
---
# Failover Clustering Overview for Windows Server Threshold
This topic provides an overview of the Failover Clustering feature in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]. Failover clusters provide high availability and scalability to many server workloads. These include server applications such as Microsoft Exchange Server, Hyper\-V, Microsoft SQL Server, and file servers. The server applications can run on physical servers or virtual machines. This topic describes the Failover Clustering feature and provides links to additional guidance about creating, configuring, and managing failover clusters that can scale to 64 physical nodes and to 8,000 virtual machines.  
  
|||  
|-|-|  
|![](b93f8edc-baa1-46ad-aed5-99c8690273c0)|Did you know that Microsoft Azure provides similar functionality in the cloud? Learn more about [Microsoft Azure virtualization solutions](http://aka.ms/f9bh7g).<br /><br />Create a hybrid virtualization solution in Microsoft Azure:<br />\- [Learn about high availability and site recovery options using Microsoft Azure](http://aka.ms/agl678)|  
  
**Did you mean…**  
  
-   [Building Your Cloud Infrastructure: Scenario Overview](assetId:///366a8096-18e8-44e8-9bb7-355d3781c4d5)  
  
-   [Scale-out File Servers](assetId:///0a6029b2-9390-414f-b486-98d31d033ff0)  
  
-   [Maintaining Business Continuity of Virtualized Environments with Hyper-V Replica: scenario overview [Pillar Overview]](assetId:///e9b0e9f5-db53-4c04-8923-4888a0427689)  
  
-   [Network Load Balancing [Role/Tech Overview]](assetId:///bad6f3ac-ab94-425c-8a51-883765dc7f97)  
  
## <a name="BKMK_OVER"></a>Feature description  
A failover cluster is a group of independent computers that work together to increase the availability and scalability of clustered roles \(formerly called clustered applications and services\). The clustered servers \(called nodes\) are connected by physical cables and by software. If one or more of the cluster nodes fail, other nodes begin to provide service \(a process known as failover\). In addition, the clustered roles are proactively monitored to verify that they are working properly. If they are not working, they are restarted or moved to another node. Failover clusters also provide Cluster Shared Volume \(CSV\) functionality that provides a consistent, distributed namespace that clustered roles can use to access shared storage from all nodes. With the Failover Clustering feature, users experience a minimum of disruptions in service.  
  
You can manage failover clusters by using the Failover Cluster Manager snap\-in and the Failover Clustering [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets. You can also use the tools in File and Storage Services to manage file shares on file server clusters.  
  
## <a name="BKMK_APP"></a>Practical applications  
  
-   Highly available or continuously available file share storage for applications such as Microsoft SQL Server and Hyper\-V virtual machines  
  
-   Highly available clustered roles that run on physical servers or on virtual machines that are installed on servers running Hyper\-V  
  
## <a name="BKMK_NEW"></a>New and changed functionality  
New and changed functionality in Failover Clustering supports increased scalability, easier management, faster failover, and more flexible architectures for failover clusters.  
  
For information about Failover Clustering functionality that is new or changed in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], see [What's New in Failover Clustering in Windows Server](assetId:///444c4ac3-9866-41ba-8888-8724777b8f0a).  
  
For information about Failover Clustering functionality that is new or changed in [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], see [What's New in Failover Clustering in Windows Server](assetId:///444c4ac3-9866-41ba-8888-8724777b8f0a).  
  
## <a name="BKMK_HARD"></a>Hardware requirements  
A failover cluster solution must meet the following hardware requirements:  
  
-   Hardware components in the failover cluster solution must meet the qualifications for the Certified for [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] logo.  
  
-   Storage must be attached to the nodes in the cluster, if the solution is using shared storage.  
  
-   Device controllers or appropriate adapters for the storage can be Serial Attached SCSI \(SAS\), Fibre Channel, Fibre Channel over Ethernet \(FcoE\), or iSCSI.  
  
-   The complete cluster configuration \(servers, network, and storage\) must pass all tests in the Validate a Configuration Wizard.  
  
> [!NOTE]  
> In the network infrastructure that connects your cluster nodes, avoid having single points of failure.  
  
For more information about hardware compatibility, see the [Windows Server Catalog](http://go.microsoft.com/fwlink/p/?linkid=139145).  
  
For more information about the correct configuration of the servers, network, and storage for a failover cluster, see the following topics:  
  
-   [Failover Clustering Hardware Requirements and Storage Options](assetId:///c72342a0-7bf8-4e42-b8d2-b4a48659ba7c)  
  
-   [Validating Hardware for a Windows Server 2012 Failover Cluster](assetId:///c05d69b4-1c61-4422-8409-4343a839478c)  
  
## <a name="BKMK_SOFT"></a>Software requirements  
  
-   You can use the Failover Clustering feature on the Standard and Datacenter editions of [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]. This includes Server Core installations.  
  
-   You must follow the hardware manufacturers' recommendations for firmware updates and software updates. Usually, this means that the latest firmware and software updates have been applied. Occasionally, a manufacturer might recommend specific updates other than the latest updates.  
  
## <a name="BKMK_INSTALL"></a>Server Manager information  
In Server Manager, use the Add Roles and Features Wizard to add the Failover Clustering feature. The Failover Clustering Tools include the Failover Cluster Manager snap\-in, the Failover Clustering [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets, the Cluster\-Aware Updating \(CAU\) user interface and [!INCLUDE[wps_2](includes/wps_2_md.md)] cmdlets, and related tools. For general information about installing features, see [Install or Uninstall Roles, Role Services, or Features](http://go.microsoft.com/fwlink/p/?LinkID=239563).  
  
To open Failover Cluster Manager in Server Manager, click **Tools**, and then click **Failover Cluster Manager**.  
  
## <a name="BKMK_LINKS"></a>See also  
The following table provides additional resources about the Failover Clustering feature in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]. Additionally, see the content on [failover clusters](http://technet.microsoft.com/library/ff182338(WS.10).aspx) in the [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] Technical Library.  
  
|Content type|References|  
|----------------|--------------|  
|**Product evaluation**|[What's New in Failover Clustering in Windows Server 2012 R2](assetId:///444c4ac3-9866-41ba-8888-8724777b8f0a) &#124; [What's New in Failover Clustering in Windows Server 2012 [redirected]](assetId:///187d6191-4f92-4f98-9cae-c5e6d5b74e76) &#124; [Microsoft Server and Cloud Platform](http://www.microsoft.com/server-cloud/) &#124; [Cloud and Datacenter Solutions Hub](http://technet.microsoft.com/cloud/hh162047)|  
|**Planning**|[Failover Clustering Hardware Requirements and Storage Options](assetId:///c72342a0-7bf8-4e42-b8d2-b4a48659ba7c) &#124; [Validating Hardware for a Windows Server 2012 Failover Cluster](assetId:///c05d69b4-1c61-4422-8409-4343a839478c) &#124; [Network Recommendations for a Hyper-V Cluster in Windows Server 2012](assetId:///4fb79ef2-829d-4313-a82a-f35d2e9b45e7)|  
|**Deployment**|[Installing the Failover Clustering Feature and Tools](http://go.microsoft.com/fwlink/p/?LinkId=253342) &#124; [Validating Hardware for a Windows Server 2012 Failover Cluster](assetId:///c05d69b4-1c61-4422-8409-4343a839478c) &#124; [Prestage Cluster Computer Objects in Active Directory Domain Services](assetId:///42eca3f8-299a-4e04-b8fc-9b3dde070f87) &#124; [Creating a Windows Server 2012 Failover Cluster](http://blogs.msdn.com/b/clustering/archive/2012/05/01/10299698.aspx) &#124; [Deploy Hyper-V over SMB](http://technet.microsoft.com/library/jj134187) &#124; [Deploy Scale-Out File Server](http://technet.microsoft.com/library/hh831359) &#124; [iSCSI Target Block Storage, How To](http://technet.microsoft.com/library/hh848268) &#124; [Install and Configure High Availability Printing](http://technet.microsoft.com/library/jj556313.aspx) &#124; [Deploy an Active Directory-Detached Cluster](assetId:///21bc89d4-e744-4a94-8ee2-a9d93c68a804) &#124; [Deploy a Hyper-V Cluster](assetId:///636c67f7-de15-4e23-ad6a-119a8d43d819) &#124; [Using Guest Clustering for High Availability](assetId:///839c30af-d036-42d1-a0f6-dcc82d61717a) &#124; [Deploy a Guest Cluster Using a Shared Virtual Hard Disk](assetId:///d25a2cb3-0932-47c9-b2e4-0e0c7ae9dd6a) &#124; [Building Your Cloud Infrastructure: Scenario Overview](assetId:///366a8096-18e8-44e8-9bb7-355d3781c4d5)|  
|**Operations**|[Configure and Manage the Quorum in a Failover Cluster](assetId:///e5cef0e4-cf8e-48be-a5bc-2182d416fab1) &#124; <br />[Use Cluster Shared Volumes in a Failover Cluster](assetId:///c4ca6129-017c-484f-8bb5-7a4c54a38726) &#124; [Cluster-Aware Updating overview](assetId:///a8e6dfbb-9d98-4130-86ac-9f6f00241e02)|  
|**Tools and settings**|[Failover Clustering Windows PowerShell Cmdlets](http://go.microsoft.com/fwlink/p/?LinkId=233200)|  
|**Community resources**|[High Availability (Clustering) Forum](http://go.microsoft.com/fwlink/p/?LinkId=230641) &#124; [Failover Clustering and Network Load Balancing Team Blog](http://blogs.msdn.com/b/clustering/)|  
|**Related technologies**|[Hyper-V](assetId:///5aad349f-ef06-464a-b36f-366fbb040143) &#124; [File and Storage Services](assetId:///4cb00829-8d05-4499-8adc-7506e159f857) &#124; <br />[Storage Spaces overview](assetId:///bbfe20d3-59c4-4826-82b4-90154b0b3457) &#124; [Scale-out File Servers](assetId:///0a6029b2-9390-414f-b486-98d31d033ff0) &#124; [Network Load Balancing](assetId:///bad6f3ac-ab94-425c-8a51-883765dc7f97) &#124; [Microsoft SQL Server](http://www.microsoft.com/sqlserver/default.aspx) &#124; [Microsoft Server and Cloud Platform](http://www.microsoft.com/server-cloud/) &#124; [System Center Virtual Machine Manager](http://technet.microsoft.com/systemcenter/vmm/default.aspx)|  
  

