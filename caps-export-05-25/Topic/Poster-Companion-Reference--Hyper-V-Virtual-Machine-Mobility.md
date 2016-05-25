---
title: Poster Companion Reference: Hyper-V Virtual Machine Mobility
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a0a62f6b-985c-4aea-8f67-07da03d40d4b
author: cwatsonmsft
---
# Poster Companion Reference: Hyper-V Virtual Machine Mobility
This document is part of a companion reference discussing the [Windows Server® 2012 Hyper\-V® Component Architecture Poster.](http://www.microsoft.com/download/details.aspx?id=29189)  
  
This document refers to the poster section titled “Hyper\-V Virtual Machine Mobility” and discusses new live migration features in Windows Server 2012, including live migration without shared storage \(also known as “shared nothing live migration”\), live migration with SMB shared storage, storage migration, and live migration with failover clusters.  
  
-   [Understanding Live Migration](#Sec1)  
  
-   [New Functionality in Windows Server 2012 Live Migration](#Sec2)  
  
-   [Windows Server 2012 Live Migration Requirements](#Sec3)  
  
-   [Live Migration Without Shared Storage \(“Shared Nothing Live Migration”\)](#Sec4)  
  
-   [Understanding Live Migration Without Shared Storage](#Sec5)  
  
-   [Storage Migration](#Sec6)  
  
-   [Understanding Storage Migration](#Sec7)  
  
-   [Live Migration with Failover Clusters](#Sec8)  
  
-   [Live Migration with SMB Shared Storage](#Sec9)  
  
-   [Windows Server Component Architecture Posters](#Sec10)  
  
You can obtain the Windows Server 2012 Hyper\-V Component Architecture Poster from the Microsoft Download Center. This is a free resource. You can download it here:  
  
[http:\/\/www.microsoft.com\/download\/en\/details.aspx?id\=29189](http://www.microsoft.com/download/en/details.aspx?id=29189)  
  
## <a name="Sec1"></a>1. Understanding Live Migration  
In Windows Server 2008 R2, live migration was introduced in Hyper\-V—live migration with failover clusters. It provides you with the capability to move a virtual machine from one node in a Windows Server 2008 R2 failover cluster to another node without a perceived interruption in service.  
  
Live migration quickly became one of the most popular features in Hyper\-V and one of the most useful tools for managing a virtualized environment. It is very helpful to be able to migrate a virtual machine off your server that needs maintenance, then later migrate it back when the maintenance is complete. You can also use live migration to manage high resource utilization periods in your environments by moving virtual machines to new servers that have greater performance or storage capacities.  
  
## <a name="Sec2"></a>2. New Functionality in Windows Server 2012 Live Migration  
In Windows Server 2012 Hyper\-V, new functionality extends live migration beyond just live migration with failover clusters. Now it works without any requirement for a failover cluster \(live migration without shared storage or “shared nothing” live migration\), allows you to migrate your virtual disk storage \(storage migration\), and works with your new SMB 3.0 file shares \(live migration with SMB shared storage\).  
  
## <a name="Sec3"></a>3. Windows Server 2012 Live Migration Requirements  
All types of Windows Server 2012 live migrations have the following requirements:  
  
-   Two or more servers running Windows Server 2012 with the Hyper\-V role installed that:  
  
    -   Support hardware virtualization.  
  
    -   Use processors from the same manufacturer \(for example, all AMD or all Intel\)  
  
    -   Are part of the same Active Directory® domain.  
  
-   Virtual machines that are configured to use virtual hard disks or virtual Fibre Channel disks \(no direct\-attached storage\).  
  
-   A private network for live migration network traffic.  
  
Live migration with failover clusters has the following additional requirements:  
  
-   The Failover Clustering feature is enabled and configured.  
  
-   Cluster Shared Volume \(CSV\) storage in the failover cluster is enabled.  
  
Live migration with SMB shared storage has the following additional requirements:  
  
-   All files on a virtual machine \(such as virtual hard disks, snapshots, and configuration\) are stored on a Server Message Block share.  
  
-   Permissions on the SMB share must be configured to grant access to the computer accounts of all servers running Hyper\-V.  
  
Live migration without shared storage \(“shared nothing” live migration\) has no additional requirements.  
  
## <a name="Sec4"></a>4. Live Migration Without Shared Storage \(“Shared Nothing Live Migration”\)  
Live migration without shared storage \(also known as “shared nothing” live migration\) is new in Windows Server 2012. It enables you to migrate your virtual machines and their associated storage between servers running Hyper\-V within the same domain. This kind of live migration requires only an Ethernet connection. Note that this type of live migration does not provide high availability—live migration with failover clusters offers this benefit with its shared storage.  
  
Live migration without shared storage offers the following benefits:  
  
-   It allows increased flexibility of your virtual machine placements.  
  
-   It increases administrator flexibility.  
  
-   It reduces downtime for migrations across cluster boundaries.  
  
Many administrators are using live migration without shared storage for more dynamically evolving and managing their infrastructure. For example, if you are experiencing hardware problems with your server running Hyper\-V, you can use this kind of live migration to quickly move the entire virtual machine to another server while you troubleshoot the original server. Then, you can simply move it back later. There is no failover cluster and no complex detailed configuration required.  
  
Using live migration without shared storage, you can also migrate your virtual machines between clusters, and from a non\-clustered computer into a failover cluster. Additionally, you can migrate virtual machines between different storage types. You can initiate live migration without shared storage using Windows PowerShell™.  
  
![](../Image/VMM_Fig1.jpg)  
  
It is easy to complete a live migration without shared storage operation. You use Hyper\-V Manager to select the virtual machine, and then choose the option to move the virtual machine. A wizard guides you through the process, but you need to make a few basic decisions as you migrate.  
  
For example, you must decide on how to store your virtual machine on the destination server running Hyper\-V. You can move the virtual machine data to a single location, or select individual locations for each component of your virtual machine \(for example virtual hard disks\). You can also choose to move only the virtual machine. If you choose this option, make sure your virtual hard disks are on shared storage.  
  
## <a name="Sec5"></a>5. Understanding Live Migration Without Shared Storage  
During the operation of live migration without shared storage, your virtual machine continues to run while all of its storage is mirrored across to the destination server running Hyper\-V. After the Hyper\-V storage is synchronized, the live migration completes its remaining tasks. Finally, the mirroring stops and the storage on the source server is deleted.  
  
When you perform a live migration of a virtual machine between two computers that do not share storage, Hyper\-V first performs a partial migration of the virtual machine’s storage. Hyper\-V performs the following steps:  
  
![](../Image/VMM_Fig2.jpg)  
  
1.  Throughout most of the move operation, disk reads and writes go to the source virtual hard disk \(VHD\).  
  
2.  While reads and writes occur on the source virtual hard disk, the disk contents are copied \(or mirrored\) over the network to the new destination virtual hard disk.  
  
3.  After the initial disk copy is complete, disk writes are mirrored to both the source and destination virtual hard disks, while outstanding disk changes are replicated.  
  
4.  After the source and destination virtual hard disks are synchronized, the virtual machine live migration is initiated, following the same process that was used for live migration with shared storage.  
  
5.  After the live migration is complete and the virtual machine is successfully running on the destination server, the files on the source server are deleted.  
  
After the virtual machine’s storage is migrated, the virtual machine migrates while it continues to run and provide network services.  
  
## <a name="Sec6"></a>6. Storage Migration  
In just about every organization, having the flexibility to manage storage without affecting the availability of your virtual machine workloads is a key capability. IT administrators require this flexibility to perform maintenance on storage subsystems, upgrade storage appliance firmware and software, respond to dynamic requests for organization resources, and balance loads as capacity is consumed—all without shutting down virtual machines.  
  
In Windows Server 2008 R2, you could move a running instance of a virtual machine by using live migration—but you were not able to move the virtual machine storage while the virtual machine was running. However, in Windows Server 2012 Hyper\-V, you are now able to move the virtual machine storage while it is running using the new functionality called storage migration.  
  
Hyper\-V storage migration enables you to move virtual machine storage \(virtual hard disks \(VHDs\)\) without downtime, and enables several new usage scenarios. For example, you can add more physical disk storage to a non\-clustered computer or a Hyper\-V failover cluster, and then move the virtual machines to the new storage while the virtual machines continue to run. You have two options to implement storage migration. You can perform a storage migration using the Hyper\-V Manager \(using the GUI\) or through Windows PowerShell and associated scripts.  
  
The requirements for storage migration are Windows Server 2012 with the Hyper\-V role installed and virtual machines configured to use virtual hard disks for storage.  
  
Storage migration allows you to migrate a complete virtual machine to another location—on either your current server or on shared storage \(for example, an SMB 3.0 file share\). It offers you a large variety of migration options. These include moving your virtual machine data to a single location, moving your virtual machine data to different locations, or just moving your virtual machine’s virtual hard disks. If you choose to move different components, you can specify virtual hard disks, current configuration, snapshots, and Smart Paging.  
  
## <a name="Sec7"></a>7. Understanding Storage Migration  
An important thing to understand about storage migration is that you can perform storage migration when your virtual machine is running or when it is turned off. Note that storage migration moves the storage, but not your virtual machine state.  
  
When you move a running virtual machine’s storage \(virtual hard disks\), Hyper\-V performs the following steps.  
  
![](../Image/VMM_Fig3.jpg)  
  
1.  Throughout most of the move operation, disk reads and writes go to the source virtual hard disk.  
  
2.  While reads and writes occur on the source virtual hard disk, the disk contents are copied to the new destination virtual hard disk.  
  
3.  After the initial disk copy is complete, disk writes are mirrored to both the source and destination virtual hard disks while outstanding disk changes are replicated.  
  
4.  After the source and destination virtual hard disks are synchronized, the virtual machine switches over to using the destination virtual hard disk.  
  
5.  The source virtual hard disk is deleted.  
  
## <a name="Sec8"></a>8. Live Migration with Failover Clusters  
Failover clustering provides your organization with protection against application and service failure, system and hardware failure \(such as CPUs, drives, memory, network adapters, and power supplies\), and site failure \(which could be caused by natural disaster, power outages, or connectivity outages\).  
  
The Windows Server Failover Clustering feature enables high\-availability solutions for many workloads, and has included Hyper\-V support since Hyper\-V was released. By clustering your virtualized workloads, you can increase reliability and availability, and can enable access to your server\-based applications in times of planned or unplanned downtime.  
  
Earlier in this guide, section 5 discussed live migration without shared storage. This is outside of a failover cluster and does not deliver high availability. However, Windows Server 2012 continues to offer a high availability solution that uses Failover Clustering with Hyper\-V.  
  
Hyper\-V live migration with failover clusters \(first introduced in Windows Server 2008 R2\) enables you to move running virtual machines from one clustered server \(node\) running Hyper\-V to another server \(node\) without any disruption or perceived loss of service. Note that live migration is initiated by the administrator and is a planned operation.  
  
In Windows Server 2012, you can improve on this migration process by selecting multiple virtual machines within the failover cluster and performing multiple simultaneous live migrations of those virtual machines.  
  
You can also select and queue live migrations of multiple virtual machines. It is important to remember that live migration queuing is only supported within a failover cluster.  
  
![](../Image/VMM_Fig4.jpg)  
  
As with all types of live migration, you can initiate live migration with failover clusters using Windows PowerShell.  
  
## <a name="Sec9"></a>9. Live Migration with SMB Shared Storage  
Some customers do not need to invest in clustering hardware to meet their business objectives. In fact, many organizations already have existing investments in simple SMB storage that they would like to leverage. In Windows Server 2012, you can now use live migration outside a failover cluster when your virtual machine is stored on a Server Message Block \(SMB\) share.  
  
Live migration with SMB shared storage enables you to move your virtual machines between servers running Hyper\-V within the same domain while your virtual machine storage remains on the SMB\-based file server. This allows you to benefit from virtual machine mobility without having to invest in a failover clustering infrastructure. Hosting providers and similar environments frequently need this capability. Windows Server 2012 also supports concurrent live migrations.  
  
Depending on your organizational infrastructure, live migration operations can be very fast—you are not migrating your virtual storage, so you are not moving larger virtual hard disks across your network.  
  
![](../Image/VMM_Fig5.jpg)  
  
For live migration with SMB shared storage, your virtual hard disk \(VHD\) is on an SMB 3–based file server.  
  
Once you begin this migration, the actual running state of your virtual machine is migrated from one server to another. It is important to note that the connection to the SMB storage is migrated, but your virtual hard disk never moves.  
  
As with live migration without shared storage \(“shared nothing” live migration\), Windows Server 2012 makes it easy to migrate your virtual machine on an SMB file server. You can start the live migration using Hyper\-V Manager \(which is GUI\-based\), or you can initiate it using Windows PowerShell \(see the “move\-vm cmdlet”\).  
  
There are a few things to keep in mind if you want to use live migration with SMB shared storage. Apart from having servers running Hyper\-V that are part of the same Active Directory domain, you should keep all the virtual machine files \(such as virtual hard disks, snapshots, and configuration files\) stored on a SMB 3\-based file server. In addition, you need to make sure you configure permissions on your SMB file server correctly. This means that you need to grant access to the computer accounts of all your servers running Hyper\-V. Also, you need to use Windows Server 2012 on servers that support hardware virtualization—and these servers need to use processors from the same manufacturer \(AMD\-V or Intel VT\)\(same as the requirement in Windows Server 2008 and Windows Server 2008 R2\).  
  
## <a name="Sec10"></a>10. Windows Server Component Architecture Posters  
To download the Windows Server 2012 poster, see [Windows Server 2012 Hyper\-V Component Architecture](http://www.microsoft.com/download/details.aspx?id=29189) in the Microsoft Download Center. If you want to reference the previous component architecture posters that relate to Hyper\-V in Windows Server 2008 R2, please see the following posters.  
  
### Windows Server 2008 R2: Hyper\-V Component Architecture  
The [Windows Server 2008 R2: Hyper\-V Component Architecture](http://www.microsoft.com/download/details.aspx?id=3501) poster provides a visual reference for understanding key Hyper\-V technologies in Windows Server 2008 R2. It focuses on architecture, snapshots, live migration, virtual networking, storage, and import\/export.  
  
You can use this poster in conjunction with the previously published [Windows Server 2008 R2 Feature Components Poster](http://www.microsoft.com/download/details.aspx?displaylang=en&id=7002).  
  
![](../Image/WSCAP_Fig1.jpg)  
  
### Windows Server 2008 R2 Hyper\-V Component Architecture \(with Service Pack 1\)  
This [Windows Server 2008 R2 Hyper\-V Component Architecture \(with Service Pack 1\)](http://www.microsoft.com/download/details.aspx?id=2688) poster provides a visual reference for understanding key Hyper\-V technologies in Windows Server 2008 R2 with Service Pack 1. It focuses on architecture, snapshots, live migration, virtual networking, storage, RemoteFX®, and Dynamic Memory.  
  
You can also use this poster in conjunction with the previously published [Windows Server 2008 R2 Feature Components Poster](http://www.microsoft.com/download/details.aspx?displaylang=en&id=7002).  
  
### Windows Server 2008 R2 Feature Components Poster  
The [Windows Server 2008 R2 Feature Components Poster](http://www.microsoft.com/download/details.aspx?id=7002) provides a visual reference for understanding key technologies in Windows Server 2008 R2. It focuses on Active Directory® Domain Services, Hyper\-V, Internet Information Services, Remote Desktop Services \(including Virtual Desktop Infrastructure \(VDI\)\), BranchCache®, and DirectAccess technologies. In addition, updates to core file services and server management are illustrated.  
  
You can use this poster in conjunction with the [Windows Server 2008](http://www.microsoft.com/download/details.aspx?id=17881) and Windows Server 2008 R2 component posters.  
  
![](../Image/WSCAP_Fig3.jpg)  
  
### Remote Desktop Services Component Architecture Poster  
The [Remote Desktop Services Component Poster](http://www.microsoft.com/download/details.aspx?id=3262) provides a visual reference for understanding key Remote Desktop Services technologies in Windows Server 2008 R2. It explains the functions and roles of Remote Desktop Session Host, Remote Desktop Virtualization Host, Remote Desktop Connection Broker, Remote Desktop Web Access, Remote Desktop Gateway, Remote Desktop Licensing, and RemoteFX.  
  
You can use this poster in conjunction with the Windows Server 2008 and Windows Server 2008 R2 component posters.  
  
![](../Image/WSCAP_Fig4.jpg)  
  
