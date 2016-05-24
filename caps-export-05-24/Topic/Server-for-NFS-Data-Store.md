---
title: Server for NFS Data Store
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 92c23725-ab49-4fa8-99a2-c474df1e7c53
---
# Server for NFS Data Store
In the past several years, organizations have been increasingly pressured to reduce their IT spending. Reduced IT budgets drive a business need for IT to find new ways to decrease costs. Because the cost of storage constitutes a sizeable portion of IT budgets, this trend has resulted in the shift towards converged storage fabric. Virtualization is a large driver of the increase in demand for storage capacity. File\-based storage has gained credence as a viable alternative to more expensive storage area network \(SAN\) block\-based storage because it is simple to provision and manage. An example of this trend is the recent popularity of deploying and running VMware ESX and VMware ESXi on virtual machines from file\-based storage accessed over the Network File System \(NFS\) protocol.  
  
The need to store and run critical virtualized enterprise workloads from file\-based storage demands a guarantee for increased availability and reliability. [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes several key improvements to the file system, storage, and networking stack. Server for NFS is the NFS server implementation that is included with Windows Server operating systems. For [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Server for NFS has been updated to support continuous availability. These improvements make it possible to reliably store and run VMware ESX on a virtual machine that is running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] by using the NFS protocol to share files. Additional improvements in failover clustering make it possible to deploy Server for NFS in a clustered configuration and take advantage of better resilience to hardware and software outages that may afflict individual cluster nodes. At the same time, failover clustering isolates VMware ESX hypervisor hosts from intermittent glitches during failovers.  
  
![](../Image/1_NFS_Rev_Guide.jpg)  
  
**Figure 1** NFS sharing files  
  
## Requirements  
The following items are required to deploy and run VMware ESX on virtual machines that are using Server for NFS as a data store:  
  
-   A computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] with the Failover Clustering feature installed and shared storage  
  
-   A server running VMware ESX 4.1  
  
-   A computer that is used for management \(such as a computer running [!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]\) with VMware vSphere Client version 4.1 installed on it  
  
-   Installable media, such as a CD or ISO image of the guest operating system that you want to run on the VMware ESX hypervisor host  
  
On the computer running [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you need to use Server Manager to install the following features:  
  
-   The File Services role  
  
-   The Server for NFS role service  
  
-   The Failover Clustering feature  
  
This feature set includes Windows PowerShell cmdlets that you can use to set NFS to share files. You can also use these tools to quickly provision the shared files as a data store for servers running VMware ESX and to run virtual machines on the shared files by using the NFS protocol.  
  
## Technical overview  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes a new open network computing remote procedure call \(ONCRPC\), which consists of an External Data Representation \(XDR\) runtime built on the Winsock Kernel \(WSK\) interface. This configuration replaces the previous runtime that was built on the legacy Transport Driver Interface \(TDI\). The new XDR runtime is equipped with a dynamic autotuned thread pool that does not require performance tuning using registry keys, and it features a more efficient XDR encoding and decoding implementation. In addition, it implements dynamic endpoints and consumes Plug and Play \(PnP\) notifications to support the addition and removal of network interfaces at runtime. With this new design, the XDR runtime infrastructure is capable of performing faster and more targeted failovers to achieve continuous availability. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Server for NFS and Client for NFS have been ported to run on this new scalable, high\-performance XDR runtime infrastructure.  
  
The failover cluster resource DLL is completely rewritten in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], which enables Server for NFS to fail over much faster than on previous versions of Windows Server. The previous per\-share cluster resource for NFS has been replaced by a consolidated per\-virtual disk cluster resource, which results in fewer cluster resources on the failover cluster and faster end\-to\-end failovers. The failover logic within the NFS cluster resource has also been reworked for performance. The failover clustering infrastructure has undergone several key performance enhancements, which has resulted in faster failovers of the disk and network resources. This helps reduce the total amount of time for a failover to occur, and It makes it easy to deploy shared files as a reliable file\-based storage backend for VMware ESX hypervisor hosts.  
  
In addition, [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] includes a comprehensive set of task\-oriented Windows PowerShell cmdlets that make it easy to provision and manage the NFS shares.  
  
