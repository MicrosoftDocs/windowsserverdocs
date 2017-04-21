---
title: Customer experience guides for Windows Server 2016
description: "Guides that introduce new features in Windows Server 2016 and provide walkthroughs to try out the new features."
ms.prod: windows-server-threshold
ms.technology: server-general
ms.topic: article
ms.date: 10/11/2016
ms.assetid: bd2a2a8f-5640-416d-ac8d-a9a1987b892e
author: jasongerend
ms.author: jgerend
manager: dongill
---
# Customer Experience Guides for Windows Server 2016

>Applies To: Windows Server 2016

Customer Experience Guides are a series of blog posts that highlight some of the new features in Windows Server 2016 that we haven't yet discussed in our formal TechNet content.

If there's a new feature that's not discussed here, it's probably discussed in our formal documentation - see [Windows Server 2016](../Windows-Server-2016.md) and [What's new in Windows Server 2016](What-s-New-in-windows-server-2016.md) for more info.

The following experience guides have been created by the Windows Server 2016 Engineering and Content Development Teams to help get you started with technologies and features being released in Windows Server 2016:

## Failover Clustering technologies

### Increased resiliency of virtual machines to transient failures
In today's cloud-scale environments, transient failures have become more common than equipment failures. In these circumstances, reacting aggressively to handle these transient failures can cause more downtime than it prevents. Windows Server 2016 therefore introduces increased virtual machine resiliency to transient intra-cluster communication failures in your compute cluster.

For more info, see [Increasing Resiliency of Virtual Machines in Windows Server 2016](http://blogs.msdn.com/b/clustering/archive/2015/06/03/10619308.aspx).  

### Failover Clustering troubleshooting enhancements
A number of  improvements have been made in the tools and methods for troubleshooting Failover Clusters with Windows Server 2016. Failover Clustering has diagnostic logs running on each server that allow in-depth troubleshooting of problems without having to reproduce the issue. This log is valuable for Microsoft's support as well as those out there who have expertise at troubleshooting failover clusters.

For more info, see [Windows Server 2016 Failover Cluster Troubleshooting Enhancements - Cluster Log](http://blogs.msdn.com/b/clustering/archive/2015/05/15/10614930.aspx).  

### Site-aware Failover Clusters
Nodes in stretched clusters can now be grouped based on their physical location (site). Cluster site-awareness enhances key operations during the cluster lifecycle such as failover behavior, placement policies, cluster heartbeats between the nodes, and quorum behavior.

For more info, see [Site-aware Failover Clusters in Windows Server 2016](http://blogs.msdn.com/b/clustering/archive/2015/08/19/10636304.aspx).

### Workgroup and Multi-domain clusters
In Windows Server 2012 R2 and previous versions, a cluster could only be created between member nodes joined to the same domain. Windows Server 2016 breaks down these barriers and introduces the ability to create a Failover Cluster without Active Directory Domain Services dependencies. Failover Clusters can now therefore be created as single-domain clusters, multi-domain clusters, or as workgroup clusters.

For more info, see [Workgroup and Multi-domain clusters in Windows Server 2016](http://blogs.msdn.com/b/clustering/archive/2015/08/17/10635825.aspx).

## Management technologies

### PowerShell Desired State Configuration (DSC) in Windows Management Framework (WMF) 5
Windows Management Framework 5 includes updates to Windows PowerShell Desired State Configuration (DSC), Windows Remote Management (WinRM), and Windows Management Instrumentation (WMI).

For more info about testing the DSC features of Windows Management Framework 5, see the series of blog posts discussed in [Validate features of PowerShell Desired State Configuration (DSC)](http://blogs.msdn.com/b/powershell/archive/2015/07/06/validate-features-of-powershell-dsc.aspx). To download, see [Windows Management Framework 5.0 ](https://www.microsoft.com/download/details.aspx?id=50395).

### PackageManagement unified package management for software discovery, installation, and inventory
Windows Server 2016 and Windows 10 includes a new PackageManagement feature (formerly called OneGet) that enables IT Professionals or DevOps to automate software discovery, installation, and inventory (SDII), locally or remotely, no matter what the installer technology is and where the software is located. 

For more info, see [https://github.com/OneGet/oneget/wiki](https://github.com/OneGet/oneget/wiki).

### PowerShell enhancements to assist digital forensics and help reduce security breaches
To help the team responsible for investigating comprimised systems - sometimes known as the "blue team" - we've added additional PowerShell logging and other digital forensics functionality, and we've added functionality to help reduce vulnerabilities in scripts, such as constrained PowerShell, and secure CodeGeneration APIs.

For more info, see [PowerShell hearts the Blue Team](http://blogs.msdn.com/b/powershell/archive/2015/06/09/powershell-the-blue-team.aspx).

## Remote Desktop Services technologies

### OpenGL support for higher video-memory virtual GPUs
Windows Server 2016 includes capabilities that improve the experience for end users in a Windows virtualized desktop infrastructure (VDI) environment for ‘Engineering/Designer’ application workloads that require OpenGL API support and all graphics applications (DX and OpenGL) that require more video memory.

For more info, see [RemoteFX vGPU Updates in Windows Server Next](https://blogs.technet.microsoft.com/enterprisemobility/2014/11/05/remotefx-vgpu-updates-in-windows-server-next/) and [Experience guide for Enabling OpenGL Support for vGPU in Server 2016](http://social.technet.microsoft.com/wiki/contents/articles/31771.experience-guide-for-enabling-opengl-support-for-vgpu-in-server-2016.aspx).

### Using Azure SQL DB for your Remote Desktop Connection Broker high availability environment
With the release of Windows Server 2016, deploying a highly available Remote Desktop Services deployment enables you to leverage an Azure SQL database for your Remote Desktop Connection Brokers in high availability mode.

For more info, see [Use Azure SQL DB for your Remote Desktop Connection Broker high availability environment](../remote/remote-desktop-services/Use-an-Azure-SQL-database-to-enable-high-availability-for-your-Connection-Broker.md).