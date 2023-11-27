---
title: Failover clustering hardware requirements and storage options
description: Hardware requirements and storage options for creating a failover cluster.
ms.topic: article
author: JasonGerend
ms.author: wscontent
manager: lizross
ms.date: 10/10/2023
---
# Failover clustering hardware requirements and storage options

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Azure Stack HCI, versions 21H2 and 20H2

In order to create a failover cluster, your system must meet the following requirements:

- Have all hardware listed in [Hardware requirements](#hardware-requirements)
- Certify all hardware for the version of Windows Server you're currently running
- All parts of the failover cluster must pass the validation tests in [Validate a Configuration](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134244(v=ws.11)#step-2-validate-a-new-or-existing-failover-cluster).

This article describes each of these hardware requirements in more detail.

## Hardware requirements

The following sections describe hardware requirements and recommendations for failover clusters.

### Servers

We recommend that you use a set of matching computers that contain the same or similar components.

> [!NOTE]
> If you've purchased Azure Stack HCI Integrated System solution hardware from the [Azure Stack HCI Catalog](https://hcicatalog.azurewebsites.net) through your preferred Microsoft hardware partner, the Azure Stack HCI operating system should be pre-installed.

### Network adapters and cables

If you use Internet Small Computer Systems Interface (iSCSI), you should only dedicate each network adapter to either network communication or iSCSI.

In the network infrastructure that connects your cluster nodes, avoid having single points of failure. For example, you can connect your cluster nodes by multiple, distinct networks. You can also connect your cluster nodes using a network with teamed network adapters, redundant switches, redundant routers, or similar hardware that removes single points of failure.

>[!NOTE]
>If you connect cluster nodes with a single network, the network should pass the redundancy requirement in [Validate a Configuration](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134244(v=ws.11)#step-2-validate-a-new-or-existing-failover-cluster). However, you should also see a message in the report that says that the network shouldn't have single points of failure.

### Device controllers and other adapters for storage

Which device controllers or other compatible adapters you should use for storage depends on what type of storage you plan to use.

- If you're using Serial Attached SCSI or Fibre Channel, all elements of the storage stack across all clustered servers should be identical. More specifically, the following components attached to cluster storage should be identical across all clustered servers:

  - Multipath input and output (MPIO) software
  - Device-Specific Module (DSM) software
  - Host bus adapter (HBA)
  - HBA drivers
  - HBA firmware
  
  IF you use different HBAs, you must verify with your storage vendor that you're following their configuration guidelines.

- If you're using iSCSI, each of your clustered servers should have one or more network adapters or HBAs dedicated to cluster storage. You should only use the network you connect to the iSCSI with for network communication. Your network adapters for connecting to the iSCSI storage target should be identical across all servers. We recommend you use Gigabit Ethernet or higher.

### Storage

You must use [Storage Spaces Direct](/azure-stack/hci/concepts/storage-spaces-direct-overview) or shared storage that's compatible with Windows Server 2012 R2, Windows Server 2012, and later. You can use attached shared storage or use SMB 3.0 file shares as shared storage for servers running Hyper-V that you've configured in a failover cluster. For more information, see [Deploy Hyper-V over SMB](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134187(v%3dws.11)).

In most cases, attached storage should contain multiple, separate disks configured at the hardware level. These disks are also known as logical unit numbers (LUNs). 

Some clusters have a disk that functions as the *disk witness*, which is a disk in cluster storage that holds the cluster configuration database. Failover clusters only have disk witnesses if the disk witness is supposed to be part of the specified quorum configuration. For more information, see [Understanding Quorum in Storage Spaces Direct](/azure-stack/hci/concepts/quorum). The other disks contain required files for clustered roles.

You should also consider these additional storage requirements:

- When you use native disk support included in failover clustering, you should only use basic disks, not dynamic disks.
- We recommend you format disk partitions with New Technology File System (NTFS). If you use Cluster Shared Volumes (CSV), you must format the partitions for each CSV with NTFS.
  
  >[!NOTE]
  >If you have a disk witness for your quorum configuration, you can format the disk with either NTFS or Resilient File System (ReFS).

- For the partition style of the disk, you can use either a Master Boot Record (MBR) or a GUID Partition Table (GPT).

## Hardware requirements for Hyper-V

If you're creating a failover cluster that includes clustered virtual machines, your cluster servers must also meet the hardware requirements to support the Hyper-V role.

The Hyper-V role has the following requirements:

- A 64-bit processor
- The processor must have hardware-assisted virtualization, which is available in processors that come with a virtualization option, especially Intel Virtualization Technology (Intel VT) or Advanced Micro Devices Virtualization (AMD-V) technology.
- The processor must also have hardware-enforced Data Execution Prevention (DEP) available and enabled. Specifically, you must enable the Intel execute disable (XD) bit or the AMD no execute (NX) bit.

For more information about the Hyper-V role, see [Hyper-V Overview](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831531(v%3dws.11)>).

## Guidelines for deploying storage area networks with failover clusters

If you're deploying a storage area network (SAN) with a failover cluster, follow these guidelines:

- Confirm storage compatibility. You should confirm with manufacturers and vendors that your storage, including its drivers, firmware, and software, are compatible with failover clusters in the version of Windows Server you're running.
- Isolate your storage devices, one cluster per device. Servers from different clusters shouldn't access the same storage devices. In most cases, you should isolate the LUN you use for one set of cluster servers from all other servers through LUN masking or zoning.
- Use multipath I/O software or teamed network adapters. When you use highly available storage fabric, you can deploy failover clusters with multiple HBAs using multipath I/O software or network adapter teaming. With these two methods, you can perform load balancing and failover (LBFO), which provides your system with the highest possible level of redundancy and availability. If you're using Windows Server 2012 R2 or Windows Server 2012, you must base your multipath solution on Microsoft Multipath I/O (MPIO). Your hardware vendor should typically give you an MPIO device-specific module (DSM) for your hardware, although Windows Server also includes one or more DSMs as part of its operating system.

  >[!IMPORTANT]
  >HBAs and multipath I/O software can be version-sensitive. Work closely with your hardware vendor to choose the correct adapters, firmware, and software that are compatible with your system's version of Windows Server. Network Interface Card (NIC) adapters, drivers, and firmware must exactly match for Switch Embedded Teaming (SET) to function properly in all cluster nodes.

- Use Storage Spaces. If you're planning to deploy serial-attached SCSI (SAS) clustered storage you've configured using Storage Spaces, make sure you read the requirements in [Deploy Clustered Storage Spaces](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj822937(v%3dws.11)).

## Related content

- [Failover Clustering](./failover-clustering-overview.md)
- [Storage Spaces](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831739(v%3dws.11))
- [Using Guest Clustering for High Availability](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn440540(v%3dws.11))
