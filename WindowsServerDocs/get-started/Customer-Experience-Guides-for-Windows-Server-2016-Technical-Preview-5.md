---
title: Customer Experience Guides for Windows Server 2016 Technical Preview 5
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - server-general
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bd2a2a8f-5640-416d-ac8d-a9a1987b892e
author: jaimeo
robots: noindex,nofollow
---
# Customer Experience Guides for Windows Server 2016 Technical Preview 5
Customer Experience Guides are available for a number of new features present in Windows Server 2016. These guides introduce the new feature and offer walkthroughs and other information can use to try out the feature in your deployment.  
  
> [!NOTE]  
> \[This information is preliminary and subject to change.\]  
  
## Customer Experience Guides for Windows Server 2016 Technical Preview  
The following experience guides have been created by the Windows Server 2016 Engineering and Content Development Teams to help get you started with technologies and features being released in Windows Server 2016.  
  
-   [Storage Spaces Direct in Windows Server Technical Preview](../storage/storage-spaces/Storage-Spaces-Direct-in-Windows-Server-2016-Technical-Preview.md)  
Windows Server Technical Preview introduces Storage Spaces Direct, which enables building highly available \(HA\) storage systems with local storage. This is a significant step forward in Microsoft Windows Server software\-defined storage \(SDS\) as it simplifies the deployment and management of SDS systems and also unlocks use of new classes of disk devices, such as SATA and NVMe disk devices, that were previously not possible with clustered Storage Spaces with shared disks.  
  
-   [Storage Replica in Windows Server Technical Preview](../storage/storage-replica/Storage-Replica-in-Windows-Server-2016-Technical-Preview.md)  
Storage Replica is a new feature in Windows Server 2016 Technical Preview that enables storage\-agnostic, block\-level, synchronous replication between clusters or servers for disaster preparedness and recovery, as well as stretching of a failover cluster across sites for high availability. Synchronous replication enables mirroring of data in physical sites with crash\-consistent volumes ensuring zero data loss at the file system level. Asynchronous replication allows site extension beyond metropolitan ranges with the possibility of data loss.  
  
-   [Increasing Resiliency of Virtual Machines in Windows Server 2016](http://blogs.msdn.com/b/clustering/archive/2015/06/03/10619308.aspx)  
In today’s cloud scale environments, commonly comprising of commodity hardware, transient failures have become more common than hard failures. In these circumstances, reacting aggressively to handle these transient failures can cause more downtime than it prevents. Windows Server 2016, therefore introduces increased virtual machine resiliency to intra\-cluster communication failures in your compute cluster.  
  
-   [Windows Server 2016 Failover Cluster Troubleshooting Enhancements - Cluster Log](http://blogs.msdn.com/b/clustering/archive/2015/05/15/10614930.aspx)  
A number of  improvements have been made in the tools and methods for troubleshooting Failover Clusters with Windows Server 2016. Failover Clustering has diagnostic logs running on each server that allow in\-depth troubleshooting of problems without having to reproduce the issue. This log is valuable for Microsoft’s support as well as those out there who have expertise at troubleshooting failover clusters.  
  
-   [Site-aware Failover Clusters in Windows Server 2016](http://blogs.msdn.com/b/clustering/archive/2015/08/19/10636304.aspx)   
Nodes in stretched clusters can now be grouped based on their physical location \(site\). Cluster site\-awareness enhances key operations during the cluster lifecycle such as failover behavior, placement policies, heartbeating between the nodes and quorum behavior.  
  
-   [Workgroup and Multi-domain clusters in Windows Server 2016](http://blogs.msdn.com/b/clustering/archive/2015/08/17/10635825.aspx)  
In Windows Server 2012 R2 and previous versions, a cluster could only be created between member nodes joined to the same domain. Windows Server 2016 breaks down these barriers and introduces the ability to create a Failover Cluster without Active Directory dependencies. Failover Clusters can now therefore be created as single\-domain clusters, multi\-domain clusters, or as workgroup clusters.  
  
-  [Cluster Operating System Rolling Upgrade](../compute/failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md)  
Cluster Operating System \(OS\) Rolling Upgrade is a new feature in Windows Server Technical Preview that enables an administrator to upgrade the operating system of the cluster nodes from Windows Server 2012 R2 to Windows Server Technical Preview without stopping the Hyper\-V or the Scale\-Out File Server workloads. Using this feature, the downtime penalties against Service Level Agreements \(SLA\) can be avoided.  
  
-   [Validate features of PowerShell DSC](http://blogs.msdn.com/b/powershell/archive/2015/07/06/validate-features-of-powershell-dsc.aspx)  
This topic introduces Windows Management Framework 5 Preview and provides links to blog postings about some of the new features included. It also includes information about how to provide feedback.  
  
-   [Introducing Package Management in Windows 10](http://blogs.technet.com/b/packagemanagement/archive/2015/04/29/introducing-packagemanagement-in-windows-10.aspx)  
Windows Server 2016 includes a new PackageManagement feature \(formerly called OneGet\) that enables ITPros or DevOps to automate software discovery, installation, and inventory \(SDII\), locally or remotely, no matter what the installer technology is and where the software is located. You can explore the feature at [https://github.com/OneGet/oneget/wiki](https://github.com/OneGet/oneget/wiki).  
  
-   [PowerShell ♥ the Blue Team](http://blogs.msdn.com/b/powershell/archive/2015/06/09/powershell-the-blue-team.aspx)  
This post discusses some important advances we’ve made in scripting security and protection in the preview versions of Windows PowerShell 5.0 and Windows 10.  
  
-   [Manage Windows virtual machines with PowerShell Direct](Manage-Windows-virtual-machines-with-PowerShell-Direct.md)  
PowerShell Direct allows Windows PowerShell management inside a virtual machine regardless of the network configuration or remote management settings on either the Hyper\-V host or the virtual machine. This makes it easier for Hyper\-V Administrators to automate and script virtual machine management and configuration.  
  
-   [Experience guide for Enabling OpenGL Support for vGPU in Server 2016](http://social.technet.microsoft.com/wiki/contents/articles/31771.experience-guide-for-enabling-opengl-support-for-vgpu-in-server-2016.aspx)  
RemoteFX vGPU is constantly evolving and Windows Server 2016 is no exception.  Since Windows Server 2012 R2 the team has been working hard addressing some of the key features that have been requested.  For this technical preview we invite you to experience some of these improvements.  
  
- [Use Azure SQL DB for your Remote Desktop Connection Broker high availability environment](../compute/remote-desktop-services/Use-an-Azure-SQL-database-to-enable-high-availability-for-your-Connection-Broker.md)  
With the release of Technical Preview 5, deploying a highly available RDS deployment lets you leverage Azure SQL Database for your RD Connection Brokers in high availability mode.  
  
-   [Deploy Software Defined Networks using scripts](../networking/sdn/deploy/Deploy-a-Software-Defined-Network-infrastrcture-using-scripts.md)  
Software Defined Networking \(SDN\) provides a method to centrally configure and manage physical and virtual network devices such as routers, switches, and gateways in your datacenter. This topic covers how to deploy a Microsoft Software Defined Network infrastructure using scripts. The infrastructure includes a network controller, an SLB\/MUX, virtual networks, and associated ACLs. Additionally, another script deploys a tenant workload for you to experiment with.  
  
-   [Deploy Software Defined Networks using Virtual Machine Manager](../netrowking/sdn/deploy/Deploy-Software-Defined-Networks-using-Virtual-Machine-Manager.md)  
This topic helps you evaluate the Software Defined Networking \(SDN\) features in Windows Server 2016 and Virtual Machine Manager 2016 Technology Preview 3. In particular, this topic is focused on scenarios that incorporate VMM with the Microsoft Network Controller, a new feature in Windows Server 2016.  
  
-   [Remote Direct Memory Access and Switch Embedded Teaming](../networking/technologies/hyper-v-virtual-switch/Remote-Direct-Memory-Access--and-Switch-Embedded-Teaming--SET-.md)  
This topic provides information on configuring Remote Direct Memory Access \(RDMA\) interfaces with Hyper\-V in Windows Server® 2016 Technical Preview, in addition to information about Switch Embedded Teaming \(SET\).  
  
-   [Getting Started with Nano Server](../compute/Getting-Started-with-Nano-Server.md)  
Windows Server® 2016 Technical Preview offers a new installation option: Nano Server. Nano Server is a remotely administered server operating system optimized for hosting in private clouds and datacenters. It is similar to Windows Server in Server Core mode, but markedly smaller. Also, there is no local logon capability, nor does it support Terminal Services. It takes up far less disk space, sets up significantly faster, and requires far fewer updates and restarts than Windows Server.  
  
-   [Introducing Cloud Witness in Windows Server 2016](http://blogs.msdn.com/b/clustering/archive/2014/11/14/10572766.aspx)  
Cloud Witness is a new type of Failover Cluster quorum witness being introduced in Windows Server 2016. This blog posting gives a quick overview of Cloud Witness and the steps required to configure it.  
  

