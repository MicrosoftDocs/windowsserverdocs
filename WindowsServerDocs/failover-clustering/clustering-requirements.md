---
title: Failover clustering hardware requirements and storage options
description: Hardware requirements and storage options for creating a failover cluster.
ms.prod: windows-server-threshold 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage-failover-clustering 
ms.date: 04/26/2018
ms.localizationpriority: medium
---
# Failover clustering hardware requirements and storage options

Applies to: Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

You need the following hardware to create a failover cluster. To be supported by Microsoft, all hardware must be certified for the version of Windows Server that you are running, and the complete failover cluster solution must pass all tests in the Validate a Configuration Wizard. For more information about validating a failover cluster, see [Validate Hardware for a Failover Cluster](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134244(v%3dws.11)>).

- **Servers**: We recommend that you use a set of matching computers that contain the same or similar components.
- **Network adapters and cable (for network communication)**: If you use iSCSI, each network adapter should be dedicated to either network communication or iSCSI, not both.

    In the network infrastructure that connects your cluster nodes, avoid having single points of failure. For example, you can connect your cluster nodes by multiple, distinct networks. Alternatively, you can connect your cluster nodes with one network that's constructed with teamed network adapters, redundant switches, redundant routers, or similar hardware that removes single points of failure.

    >[!NOTE]
    >If you connect cluster nodes with a single network, the network will pass the redundancy requirement in the Validate a Configuration Wizard. However, the report from the wizard will include a warning that the network should not have single points of failure.

- **Device controllers or appropriate adapters for the storage**:

  - **Serial Attached SCSI or Fibre Channel**: If you are using Serial Attached SCSI or Fibre Channel, in all clustered servers, all elements of the storage stack should be identical. It's required that the multipath I/O (MPIO) software be identical and that the Device Specific Module (DSM) software be identical. It's recommended that the mass-storage device controllers— the host bus adapter (HBA), HBA drivers, and HBA firmware—that are attached to cluster storage be identical. If you use dissimilar HBAs, you should verify with the storage vendor that you are following their supported or recommended configurations.
  - **iSCSI**: If you are using iSCSI, each clustered server should have one or more network adapters or HBAs that are dedicated to the cluster storage. The network you use for iSCSI should not be used for network communication. In all clustered servers, the network adapters you use to connect to the iSCSI storage target should be identical, and we recommend that you use Gigabit Ethernet or higher.
- **Storage**: You must use [Storage Spaces Direct](../storage/storage-spaces/storage-spaces-direct-overview.md) or shared storage that's compatible with Windows Server 2012 R2 or Windows Server 2012. You can use shared storage that's attached, and you can also use SMB 3.0 file shares as shared storage for servers that are running Hyper-V that are configured in a failover cluster. For more information, see [Deploy Hyper-V over SMB](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134187(v%3dws.11)>).

    In most cases, attached storage should contain multiple, separate disks (logical unit numbers, or LUNs) that are configured at the hardware level. For some clusters, one disk functions as the disk witness (described at the end of this subsection). Other disks contain the files required for the clustered roles (formerly called clustered services or applications). Storage requirements include the following:

  - To use the native disk support included in Failover Clustering, use basic disks, not dynamic disks.
  - We recommend that you format the partitions with NTFS. If you use Cluster Shared Volumes (CSV), the partition for each of those must be NTFS.

    >[!NOTE]
    >If you have a disk witness for your quorum configuration, you can format the disk with either NTFS or Resilient File System (ReFS).

  - For the partition style of the disk, you can use either master boot record (MBR) or GUID partition table (GPT).

    A disk witness is a disk in the cluster storage that's designated to hold a copy of the cluster configuration database. A failover cluster has a disk witness only if this is specified as part of the quorum configuration. For more information, see [Understanding Quorum in Storage Spaces Direct](../storage/storage-spaces/understand-quorum.md).

## Hardware requirements for Hyper-V

If you are creating a failover cluster that includes clustered virtual machines, the cluster servers must support the hardware requirements for the Hyper-V role. Hyper-V requires a 64-bit processor that includes the following:

- Hardware-assisted virtualization. This is available in processors that include a virtualization option—specifically processors with Intel Virtualization Technology (Intel VT) or AMD Virtualization (AMD-V) technology.
- Hardware-enforced Data Execution Prevention (DEP) must be available and enabled. Specifically, you must enable Intel XD bit (execute disable bit) or AMD NX bit (no execute bit).

For more information about the Hyper-V role, see [Hyper-V Overview](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831531(v%3dws.11)>).

## Deploying storage area networks with failover clusters

When deploying a storage area network (SAN) with a failover cluster, follow these guidelines:

- **Confirm compatibility of the storage**: Confirm with manufacturers and vendors that the storage, including drivers, firmware, and software used for the storage, are compatible with failover clusters in the version of Windows Server that you are running.
- **Isolate storage devices, one cluster per device**: Servers from different clusters must not be able to access the same storage devices. In most cases, a LUN used for one set of cluster servers should be isolated from all other servers through LUN masking or zoning.
- **Consider using multipath I/O software or teamed network adapters**: In a highly available storage fabric, you can deploy failover clusters with multiple host bus adapters by using multipath I/O software or network adapter teaming (also called load balancing and failover, or LBFO). This provides the highest level of redundancy and availability. For Windows Server 2012 R2 or Windows Server 2012, your multipath solution must be based on Microsoft Multipath I/O (MPIO). Your hardware vendor will typically supply an MPIO device-specific module (DSM) for your hardware, although Windows Server includes one or more DSMs as part of the operating system.

    For more information about LBFO, see [NIC Teaming Overview](https://docs.microsoft.com/windows-server/networking/technologies/nic-teaming/nic-teaming) in the Windows Server Technical Library.

    >[!IMPORTANT]
    >Host bus adapters and multipath I/O software can be very version sensitive. If you are implementing a multipath solution for your cluster, work closely with your hardware vendor to choose the correct adapters, firmware, and software for the version of Windows Server that you are running.

- **Consider using Storage Spaces**: If you plan to deploy serial attached SCSI (SAS) clustered storage that's configured using Storage Spaces, see [Deploy Clustered Storage Spaces](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj822937(v%3dws.11)>) for the requirements.

## More information

- [Failover Clustering](failover-clustering.md)
- [Storage Spaces](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831739(v%3dws.11)>)
- [Using Guest Clustering for High Availability](<https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn440540(v%3dws.11)>)