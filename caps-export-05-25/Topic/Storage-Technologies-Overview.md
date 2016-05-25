---
title: Storage Technologies Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 161343e6-310a-452c-83a5-3304d6e34970
author: cwatsonmsft
---
# Storage Technologies Overview
In Windows Server 2012 R2 and Windows Server 2012, you’ll find rich data storage capabilities built directly into the product. You can design and build flexible, secure, and resilient data storage infrastructures for your organization. Storage technologies and capabilities include Direct\-attached storage, JBOD, network\-attached storage, storage area networks, SCSI, iSCSI, and Fibre Channel.  
  
Windows Server 2012 R2 further extends storage capacity in a virtualized environment with shared virtual hard disks, online virtual hard disk resizing, virtual Fibre Channel, support for Hyper\-V over SMB, support for storage migration, storage Quality of Service \(QoS\), Hyper\-V failover clustering, and support for large sector disks.  
  
In this topic:  
  
-   [Basic storage concepts and technologies](../Topic/Storage-Technologies-Overview.md#BKMK_Concepts)  
  
-   [Storage technologies in Windows Server](../Topic/Storage-Technologies-Overview.md#BKMK_WinSrvStorage)  
  
-   [Storage technologies in Windows Server Hyper\-V](../Topic/Storage-Technologies-Overview.md#BKMK_HV)  
  
## <a name="BKMK_Concepts"></a>Basic storage concepts and technologies  
This section covers basic storage concepts and technologies that are useful to understand when designing and deploying Windows Server technologies.  
  
### Direct\-attached storage  
Direct\-attached storage refers to a computer storage system that is directly attached to your server or PC instead of being attached directly to a network. Direct\-attached storage is not limited only to internal storage. It can also utilize an external disk enclosure that contains hard disk drives, including just\-a\-bunch\-of\-disks \(JBOD\) enclosures and enclosures that are part of a redundant array of independent disks \(RAID\).  
  
The important point about direct\-attached storage is that it does not use a storage network. Although a common example of direct\-attached storage is the internal hard drive in your computer, more commonly it refers to a dedicated storage array that is attached directly to your servers. Multiple computers can use the same direct\-attached storage \(for example, if you’re using Failover Clustering\), if each computer has a separate connection to the storage and the array supports the usage you have in mind \(for example, it’s certified for use with Failover Clustering\).  
  
The main interfaces and protocols that are used for direct\-attached storage connections are Serial ATA \(SATA\), external Serial Advanced Technology Attachment \(eSATA\), serial attached SCSI \(SAS\), and Fibre Channel.  
  
![](../Image/StorageOverview_01.JPG)  
  
### JBOD  
JBOD is an abbreviation for “just\-a\-bunch\-of\-disks." In other words, the disks are presented to a computer as if they were directly attached internal disks, and they are used to increase the direct\-attached storage capacity of file servers. JBODs are usually relatively simple external enclosures, connected to one or more servers through SAS or eSATA connections.  
  
You can use JBODs with the Storage Spaces technology to combine all of your physical disks into a storage pool, and then create one or more virtual disks \(called storage spaces\) out of the free space in the pool. JBODs are typically less expensive and often more flexible and easier to manage than RAID enclosures because they use the Windows or Windows Server operating systems to manage the storage instead of using dedicated RAID adapters.  
  
For a list of JBODs that are certified for use with Storage Spaces, see the [Windows Server Catalog](http://windowsservercatalog.com/results.aspx?&chtext=&cstext=&csttext=&chbtext=&bCatID=1645&cpID=0&avc=10&ava=0&avq=0&OR=1&PGS=25&ready=0). For more information about Storage Spaces, see [the Storage Spaces Overview](http://technet.microsoft.com/en-us/library/hh831739.aspx).  
  
![](../Image/StorageOverview_02.JPG)  
  
### Network\-attached storage  
Network\-attached storage devices connect storage to a network where they are accessed through file shares. Unlike direct\-attached storage, they are not directly attached to the computer.  
  
Network\-attached storage devices support Ethernet connection, and they typically allow an administrator to manage disk space, set disk quotas, provide security, and utilize snapshot technologies. Network\-attached storage devices support multiple protocols. These include network attached file systems, Common Internet File Systems \(CIFS\), and Server Message Block \(SMB\).  
  
![](../Image/StorageOverview_03.JPG)  
  
### Storage area network  
A storage area network \(SAN\) is a dedicated network that allows you to share storage. A SAN consists of a storage device, the interconnecting network infrastructure \(switches and so on\), and servers that are connected to this network. SAN devices provide continuous and fast access to large amounts of data. The communication and data transfer mechanism for a given deployment is commonly known as a storage fabric.  
  
A SAN uses a separate network, and it is generally not accessible by other devices through the local area network. A SAN can be managed by using Simple Network Management Protocol \(SNMP\) or a proprietary management protocol. SNMP is based on TCP\/IP, and it offers basic alert management. This allows a node in your SAN to alert the management system of failures. A typical failure might include a fan or hard disk failure.  
  
A SAN does not provide file abstraction, only block\-level operations. The most common SAN protocols used are iSCSI, Fiber Channel, and Fiber Channel over Ethernet \(FCOE\). A proprietary management protocol can deliver additional capabilities such as disk zoning, disk mapping, LUN masking, and fault management.  
  
![](../Image/StorageOverview_04.JPG)  
  
#### SAN and network\-attached storage differences  
SANs and network\-attached storage appear similar because they both bring together storage and networking technologies to ensure that your data storage is easily accessible, secure, and manageable. However, they are different storage technologies. A network\-attached storage device is directly attached to your internal network, and it is usually optimized for file serving purposes only. It is typically a standalone device. A SAN is a separate network that is dedicated to storage devices and traffic. It is a block\-level device, and it provides greater flexibility and additional functionality than a network\-attached storage. It is designed for communication over greater distances. A SAN uses serial attached SCSI, Fibre Channel, or iSCSI protocol over a Fibre Channel or Ethernet network. A network\-attached storage device uses a network attached file system or CIFS \(SMB\) protocol over an Ethernet network. Despite the differences between a SAN and network\-attached storage, the two technologies blend together so that many network\-attached storage devices provide support for iSCSI \(which makes them SAN devices\), and many SANs provide support for SMB and network attached file systems \(which makes them network\-attached storage devices\).  
  
#### SCSI  
SCSI stands for small computer system interface \(pronounced "scuzzy"\). SCSI is fast data transfer technology that allows you to connect various internal and external devices \(most typically hard drives\) to your PC or server. This connection is made by using a SCSI card that fits inside the computer. For example, a typical RAID controller is a SCSI device that allows a connection to an external storage enclosure with multiple drives. Serial ATA \(SATA\) has largely replaced traditional SCSI in new systems, and it tends to be faster and less expensive than traditional SCSI drives.  
  
### iSCSI  
The Internet SCSI \(iSCSI\) protocol encapsulates SCSI commands into TCP packets, then transmits them over the Ethernet network to storage devices. The iSCSI protocol uses an existing TCP\/IP infrastructure and resolves traditional SCSI distance limitations. The iSCSI protocol enables the disk drives in your SAN to be presented over an Ethernet network to server\-based applications as though the disks were local to your physical server hardware.  
  
When using iSCSI, you need an iSCSI initiator, which is the iSCSI software that is used by a client computer to connect to storage by using the iSCSI protocol. You also need an iSCSI Target Server, which provides the storage that you want to connect to by using the iSCSI protocol. The iSCSI Target Server provides storage for data from an iSCSI SAN device or Windows Server by using the iSCSI Target Server service. For more information, see [iSCSI Target Block Storage Overview](http://technet.microsoft.com/en-us/library/hh848272.aspx).  
  
![](../Image/StorageOverview_05.JPG)  
  
### Fibre Channel  
Enterprises need high\-performance communications for their server\-to\-storage infrastructures, which has driven the adoption and use of Fibre Channel technology. Fibre Channel is a high\-speed network technology that is used to connect computer data storage. It is the most common connection technology for SANs \(although iSCSI is increasingly popular\). Typically, a SAN utilizes Fibre Channel, which is a transport protocol that transports SCSI commands over Fibre Channel networks. Fiber Channel’s long distance capability allows SAN devices to be placed in the most appropriate physical location.  
  
There are three topologies based on Fibre Channel. These are known as point\-to\-point, arbitrated loop, and switch fabric. Most SAN implementations use an arbitrated loop or switch fabric topology as the underlying infrastructure. Switch fabric is a very flexible topology because it enables all servers and storage devices to communicate with each other. Using a switch fabric topology also allows you to provide failover architecture in the event of a server or a server disk array failure.  
  
## <a name="BKMK_WinSrvStorage"></a>Storage technologies in Windows Server  
This section describes storage technologies in Windows Server 2012 R2 and Windows Server 2012. These include Storage Spaces, Server Message Block 3.0, Data Deduplication, Cluster Shared Volumes, and Scale\-Out File Server.  
  
|Technology|Description|  
|--------------|---------------|  
|Storage Spaces|Storage virtualization technology in Windows Server 2012 R2 and Windows Server 2012 that enables you to group industry\-standard disks into storage pools and then create virtual disks called storage spaces from free space in the pools.<br /><br />In Windows Server 2012 R2, you can create tiered storage spaces with a mixture of solid state drives \(SSD\) \(fast tier\) and hard disk drives \(standard tier\). Frequently accessed \(hot\) data in a tiered storage space gets moved to the SSDs in the fast tier, while infrequently accessed \(cold\) data is moved to the high\-capacity hard disks in the standard tier. This enables you to balance capacity and performance.<br /><br />For more information, see [Storage Spaces Overview](http://technet.microsoft.com/en-us/library/hh831739.aspx)|  
|Server Message Block 3.0|Network file sharing protocol that allows applications on a computer to read and write to files and to request services from server programs in a computer network. SMB Direct is a feature in SMB 3.0 that delivers scalable, fast, and efficient storage access. You can also benefit from fast data transfers and network fault tolerance by using the SMB Multichannel feature.<br /><br />SMB Multichannel and SMB Direct improve network communications between your Hyper\-V server cluster and your file server cluster. It also improves internode communications within your file server cluster. Windows Server 2012 R2 uses the SMB 3.0 protocol. SMB Direct improves your cloud deployment storage by using a network adapter that has Remote Direct Memory Access \(RDMA\) capability. It can function at full speed with very low latency, while using very little CPU. SMB Multichannel delivers network bandwidth aggregation and network fault tolerance if multiple paths are available between the SMB client and the SMB server. Server applications can then take advantage of all available network bandwidth to be more resilient in the event of a network failure. SMB Transparent Failover supports server application workloads that require a continuous availability connection to the storage infrastructure. The SMB file server and client work together to make the failover of file server cluster nodes transparent to applications for all file operations, and for planned cluster resource moves and unplanned node failures.<br /><br />For more information, see [What's New in SMB in Windows Server 2012 R2.](http://technet.microsoft.com/en-us/library/hh831474.aspx)|  
|Data Deduplication|Find and remove duplication within data without compromising its fidelity or integrity. The goal is to store more data in less space by segmenting files into small variable\-sized chunks \(32–128 KB\), identifying duplicate chunks, and maintaining a single copy of each chunk. Redundant copies of the chunk are replaced by a reference to the single copy. The chunks are compressed and then organized into special container files in the System Volume Information folder.<br /><br />Data Deduplication is ideal for numerous workloads including:<br /><br />-   General file shares: Group content publication and sharing, user home folders, and Folder Redirection and offline files<br />-   Software deployment shares: Software binaries, images, and updates<br />-   Virtual hard disk \(VHD\) libraries: VHD file storage for provisioning to hypervisors<br />-   Virtual Desktop Infrastructure \(VDI\) deployments that use Hyper\-V \(Windows Server 2012 R2 only\)<br /><br />You can significantly reduce your storage capacity requirements by using the data deduplication technology on your Clustered Shared Volume. In Windows Server 2012 R2, Data Deduplication adds support for a Scale\-Out File Server deployment for VDI workloads with separate storage and compute nodes. The desktop VHDs are stored on a Scale\-out File Server and accessed by using SMB 3.0.<br /><br />For more information, see [Data Duplication Overview](http://technet.microsoft.com/en-us/library/hh831602.aspx)|  
|Cluster Shared Volumes \(CSV\)|Multiple nodes in a failover cluster can simultaneously have Read and Write access to the same volume. CSV simplify the configuration and management of virtual machines that are running on a cluster. With CSV, multiple virtual machines that run on a cluster can use the same physical disk, while still being able to fail over independently of one another. Cluster Shared Volumes provide multiple benefits, including easier storage management and greater resiliency to failures.<br /><br />With CSV you can:<br /><br />-   Easily integrate with Storage Spaces.<br />-   Scale out access to your data by creating virtualized cluster storage that uses groups of inexpensive disks in JBODs. CSV also supports tiered storage spaces and write\-back caching.<br />-   Use with SMB Multichannel and SMB Direct. This allows CSV traffic to stream across multiple networks in the cluster and leverage network adapters that support RDMA.|  
|Scale\-Out File Server|Store server application data \(such as Hyper\-V virtual machine files\) on file shares and get a similar level of reliability, availability, manageability, and high performance as you would expect from a storage area network without the complexity. All file shares are online on all nodes simultaneously. File shares associated with this type of clustered file server are called scale\-out file shares.<br /><br />For more information, see [Scale\-Out File Server for Application Data Overview](http://technet.microsoft.com/en-us/library/hh831349.aspx).|  
  
## <a name="BKMK_HV"></a>Storage technologies in Windows Server Hyper\-V  
This section describes the new Hyper\-V storage virtualization capabilities that are incorporated in Windows Server 2012 R2 and Windows Server 2012. These include, shared virtual hard disks, online VHDX resizing, storage migration, storage Quality of Service \(QoS\), virtual Fibre Channel, SMB, support for virtual hard disks, and the VHDX format.  
  
|Technology|Description|  
|--------------|---------------|  
|Virtual hard disk sharing|Share a virtual hard disk file \(VHDX format\) to provide shared storage for a virtual machine failover cluster \(also known as a guest cluster\). By making shared storage available to virtual machines, you can easily use a virtual machine failover cluster to protect the application services \(for example, SQL Server or file server services\) that are running inside your virtual machines.There are two deployment options available. You can use virtual hard disk sharing with Cluster Shared Volumes or use a Scale\-Out File Server.<br /><br />For more information, see [Virtual Hard Disk Sharing Overview](http://technet.microsoft.com/en-us/library/dn281956.aspx).|  
|Online VHDX resizing|Expand or shrink the size of a virtual hard disk while the virtual machine is still running. You can avoid costly downtime by performing maintenance operations on running virtual hard disks. You couldn’t do this prior to Windows Server 2012 R2. If a virtual machine was online or a virtual hard disk was in use, it wasn’t possible to perform maintenance on the virtual hard disk without temporarily shutting down the virtual machine. Because shutting down virtual machines is no longer required, interruption to users accessing those virtual machines is eliminated and maintenance costs are reduced.<br /><br />For more information, see [Online VHDX Resizing Overview](http://technet.microsoft.com/en-us/library/dn282286.aspx).|  
|Storage migration|Move virtual machine storage \(virtual hard disks\) without downtime. This feature enables new servicing scenarios. For example, you can add more physical disk storage to a non\-clustered computer or a Hyper\-V cluster, and then move the virtual machines to the new storage while the virtual machines continue to run.You can perform storage migration when the virtual machine is running or when it is turned off. Storage migration moves the storage, not the virtual machine state.<br /><br />For more information, see [Virtual Machine Storage Migration Overview](http://technet.microsoft.com/en-us/library/hh831656.aspx).|  
|Storage Quality of Service|Set certain Quality of Service \(QoS\) parameters for storage on a virtual machine. Storage QoS provides storage performance isolation in a multitenant environment and mechanisms to notify you when the storage I\/O performance does not meet the defined threshold to efficiently run your virtual machine workloads.<br /><br />For more information, see [Storage Quality of Service Overview](http://technet.microsoft.com/en-us/library/dn282281.aspx).|  
|Virtual Fibre Channel for Hyper\-V|Traditional datacenters have invested a great deal of resources in their infrastructures to provision storage. In Windows Server 2012 R2 and Windows Server 2012, it is easier to ensure that your virtualized workloads can connect into your existing storage infrastructure. Virtual Fibre Channel for Hyper\-V provides Fibre Channel ports within the guest operating system, which provides a direct connection to Fibre Channel from within your virtual machines. This feature allows you to virtualize your workloads that require Fibre Channel storage. It also allows you to cluster guest operating systems in virtual machines that are using Fibre Channel.<br /><br />For more information, see [Virtual Fibre Channel Overview](http://technet.microsoft.com/en-us/library/hh831413.aspx).|  
|SMB with Hyper\-V|Store virtual machine files \(configuration files, virtual hard disk files, and snapshots\) on file servers by using SMB 3.0. This is supported for non\-clustered and clustered servers running Hyper\-V where file storage is used as shared storage for the failover cluster.If you configure virtual machine storage on a central SMB share, you can also perform a live migration of this virtual machine even when you have not configured a cluster. During the live migration, the virtual machine is moved from one physical server to another while the storage remains on the central SMB share. Storage migration is also possible. If you want to update the physical storage that is available to your server running Hyper\-V, you can move virtual hard disks on shared storage subsystems or on non\-shared storage if an SMB 3.0 network shared folder is visible to both Hyper\-V hosts. SMB 3.0 allows you to use your file storage resources across virtualization environments. Storing Hyper\-V data on inexpensive, easy\-to\-manage file servers provides the benefits that you would expect from a storage area network \(SAN\)—it is continuous availability, high performance, and manageability.<br /><br />For more information, see [Server Message Block Overview](http://technet.microsoft.com/en-us/library/hh831795.aspx).|  
|Support for virtual hard disks|For many years, the format for disk storage architecture has been to have 512 bytes per sector. A sector format where storage exceeds 512 to 520 bytes per sector is referred to as an advanced format. In Windows Server 2012, Hyper\-V introduces support for 4,096\-byte sectors \(4 KB disk sectors\) in virtual disks. The 4 KB disk sector format is a standard to which the industry is moving over the next few years to support increasing storage requirements. Changing the sector format to the 4,096\-byte structure \(or 4 KB disks\) uses the storage surface area more efficiently for larger files. It is less efficient for smaller files; however, you gain powerful error correction technology \(or algorithms\) to maintain the integrity of your data at much higher storage densities.<br /><br />For more information, see [Hyper\-V Support for Large Sector Disks Overview](http://technet.microsoft.com/en-us/library/hh831459.aspx).|  
|VHDX format|Customer environments are dynamic in nature and storage systems are always evolving. This is especially true for customers who require increased reliance on virtualized enterprise workloads. To address this, Hyper\-V in Windows Server 2012 introduced an update to the virtual hard disk format, called VHDX. This format is designed to provide enterprise environments with the capacity necessary for current and future workloads.<br /><br />For more information, see [Hyper\-V Virtual Hard Disk Format Overview](http://technet.microsoft.com/en-us/library/hh831446.aspx).|  
  
## See also  
As an additional resource, you can download the [Windows Server 2012 R2: Private Cloud Storage and Virtualization](http://www.microsoft.com/en-us/download/details.aspx?id=41665) poster from the Microsoft Download Center. This is a free resource, and it provides a visual reference for understanding key private cloud storage and virtualization technologies in Windows Server 2012 R2. Specific focus is given to understanding storage architecture, virtual hard disks, Cluster Shared Volumes, Scale\-Out File Server, Storage Spaces, Data Deduplication, Hyper\-V, Failover Clustering, and virtual hard disk sharing.  
  
A series of mini\-posters are also available. These include:  
  
-   Virtual Hard Disk and Cluster Shared Volumes Mini Poster  
  
-   Virtual Hard Disk Sharing Mini Poster  
  
-   Understanding Storage Architecture Mini Poster  
  
-   Storage Spaces and Deduplication Mini Poster  
  
-   Virtual Hard Disk and Cluster Shared Volumes Mini Poster  
  
-   Scale\-Out and SMB Mini Poster  
  
-   Hyper\-V and Failover Clustering Mini Poster  
  
Additional information about Hyper\-V storage technologies can also be found in the Windows Server 2012 poster. To download the poster, see the [Windows Server 2012 Hyper\-V Component Architecture Poster](http://www.microsoft.com/en-us/download/details.aspx?id=29189) in the Microsoft Download Center.  
  
