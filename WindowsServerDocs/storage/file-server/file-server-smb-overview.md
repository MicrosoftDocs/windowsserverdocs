---
title: Overview of file sharing using the SMB 3 protocol in Windows Server
description: An overview of using the SMB 3 protocol for file shares and file serving with Windows Server.
ms.topic: concept-article
author: robinharwood
ms.author: roharwoo
ms.date: 01/15/2025
---

# Overview of file sharing using the SMB 3 protocol in Windows Server

This article provides an overview of the Server Message Block (SMB) 3 protocol in Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, and Windows Server 2012. It covers practical applications, new and updated features compared to previous versions, and hardware requirements. Additionally, SMB serves as a fabric protocol for [software-defined data center (SDDC)](../../sddc.md) solutions like Storage Spaces Direct and Storage Replica. SMB 3.0 enhancements continue in subsequent releases.

## Feature description

The SMB protocol is a network file sharing protocol that allows applications on a computer to read and write to files. SMB also requests services from server programs in a computer network. The SMB protocol can be used on top of its TCP/IP protocol or other network protocols. Using the SMB protocol, an application (or the user of an application) can access files or other resources at a remote server. This protocol allows applications to read, create, and update files on the remote server. SMB can also communicate with any server program that is set up to receive an SMB client request. SMB is a fabric protocol that is used by Software-defined Data Center (SDDC) computing technologies, such as Storage Spaces Direct, Storage Replica. For more information, see [Windows Server software-defined datacenter](../../sddc.md).

## Practical applications

This section discusses some new practical ways to use the new SMB 3.0 protocol.

* **File storage for virtualization (Hyper-V™ over SMB)**. Hyper-V can store virtual machine files, such as configuration, Virtual hard disk (VHD) files, and snapshots, in file shares over the SMB 3.0 protocol. This can be used for both stand-alone file servers and clustered file servers that use Hyper-V together with shared file storage for the cluster.
* **Microsoft SQL Server over SMB**. SQL Server can store user database files on SMB file shares. Currently, SQL Server over SMB is supported with SQL Server 2008 R2 for stand-alone SQL servers. Upcoming versions of SQL Server add support for clustered SQL servers and system databases.
* **Traditional storage for end-user data**. The SMB 3.0 protocol provides enhancements to the Information Worker (or client) workloads. These enhancements include reducing the application latencies experienced by branch office users when accessing data over wide area networks (WAN) and protecting data from eavesdropping attacks.

> [!NOTE]
> If you need to conserve storage space on an SMB file share, consider using Azure File Sync with cloud tiering enabled. Azure File Sync allows you to cache your most frequently accessed files locally and tier your least frequently accessed files to the cloud, saving local storage space while maintaining performance. For details, see [Planning for an Azure File Sync deployment](/azure/storage/files/storage-sync-files-planning).

## New and changed functionality

The following sections describe functionality that was added in SMB 3 and subsequent updates.

## Features added in Windows Server 2019 and Windows 10, version 1809

| Feature/functionality  | New or updated  | Summary  |
| --------- | --------- | --------- |
| Ability to require write-through to disk on file shares that aren't continuously available | New | To provide some added assurance that writes to a file share make it all the way through the software and hardware stack to the physical disk before the write operation returning as completed, you can enable write-through on the file share using either the `NET USE /WRITETHROUGH` command or the `New-SMBMapping -UseWriteThrough` PowerShell cmdlet. There's some amount of performance hit to using write-through; see the blog post [Controlling write-through behaviors in SMB](https://techcommunity.microsoft.com/t5/storage-at-microsoft/controlling-write-through-behaviors-in-smb/bc-p/1083417#M677) for further discussion. |

## Features added in Windows Server, version 1709, and Windows 10, version 1709

| Feature/functionality  | New or updated  | Summary  |
| --------- | --------- | --------- |
| Guest access to file shares is disabled | New | The SMB client no longer allows the following actions: Guest account access to a remote server; Fallback to the Guest account after invalid credentials are provided. For details, see [Guest access in SMB2 disabled by default in Windows](https://support.microsoft.com/help/4046019/guest-access-in-smb2-disabled-by-default-in-windows-10-and-windows-ser). |
| SMB global mapping | New | Maps a remote SMB share to a drive letter that is accessible to all users on the local host, including containers. SMB global mapping is required to enable container I/O on the data volume to traverse the remote mount point. When using SMB global mapping for containers, all users on the container host can access the remote share. Any application running on the container host also have access to the mapped remote share. For details, see [Container Storage Support with Cluster Shared Volumes (CSV), Storage Spaces Direct, SMB Global Mapping](https://techcommunity.microsoft.com/t5/failover-clustering/container-storage-support-with-cluster-shared-volumes-csv/ba-p/372140). |
| SMB dialect control | New | You can now set registry values to control the minimum SMB version (dialect) and maximum SMB version used. For details, see [Controlling SMB Dialects](https://techcommunity.microsoft.com/t5/storage-at-microsoft/controlling-smb-dialects/ba-p/860024). |

## Features added in SMB 3.1.1 with Windows Server 2016 and Windows 10, version 1607

| Feature/functionality  | New or updated  | Summary  |
| --------- | --------- | --------- |
| SMB Encryption     |   Updated      | SMB 3.1.1 encryption with Advanced Encryption Standard-Galois/Counter Mode (AES-GCM) is faster than SMB Signing or previous SMB encryption using AES-CCM.   |
| Directory Caching | New | SMB 3.1.1 includes enhancements to directory caching. Windows clients can now cache larger directories, approximately 500,000 entries. Windows clients attempt directory queries with 1 MB buffers to reduce round trips and improve performance. |
| Pre-Authentication Integrity | New |  In SMB 3.1.1, preauthentication integrity provides improved protection from a man-in-the-middle attacker tampering with SMB’s connection establishment and authentication messages. For details, see [SMB 3.1.1 Pre-authentication integrity in Windows 10](/archive/blogs/openspecification/smb-3-1-1-pre-authentication-integrity-in-windows-10). |
| SMB Encryption Improvements | New | SMB 3.1.1 offers a mechanism to negotiate the crypto algorithm per connection, with options for AES-128-CCM and AES-128-GCM. AES-128-GCM is the default for new Windows versions, while older versions continue to use AES-128-CCM. |
| Rolling cluster upgrade support | New | Enables [rolling cluster upgrades](../../failover-clustering/cluster-operating-system-rolling-upgrade.md) by letting SMB appear to support different max versions of SMB for clusters in the process of being upgraded. For more information on letting SMB communicate using different versions (dialects) of the protocol, see the blog post [Controlling SMB Dialects](https://techcommunity.microsoft.com/t5/storage-at-microsoft/controlling-smb-dialects/ba-p/860024). |
| SMB Direct client support in Windows 10 | New | Windows 10 Enterprise, Windows 10 Education, and Windows 10 Pro for Workstations now include SMB Direct client support. |
| Native support for FileNormalizedNameInformation API calls | New | Adds native support for querying the normalized name of a file. For details, see [FileNormalizedNameInformation](/openspecs/windows_protocols/ms-fscc/20bcadba-808c-4880-b757-4af93e41edf6). |

For more information, see the blog post [What’s new in SMB 3.1.1 in the Windows Server 2016 Technical Preview 2](/archive/blogs/josebda/whats-new-in-smb-3-1-1-in-the-windows-server-2016-technical-preview-2).

## Features added in SMB 3.02 with Windows Server 2012 R2 and Windows 8.1

| Feature/functionality  | New or updated  | Summary  |
| --------- | --------- | --------- |
| Automatic rebalancing of Scale-Out File Server clients     |   New      | Improves scalability and manageability for Scale-Out File Servers. SMB client connections are tracked per file share (instead of per server), and clients are then redirected to the cluster node with the best access to the volume used by the file share. This improves efficiency by reducing redirection traffic between file server nodes. Clients are redirected following an initial connection and when cluster storage is reconfigured.    |
| Performance over WAN   | Updated  | Windows 8.1 and Windows 10 provide improved CopyFile SRV_COPYCHUNK over SMB support when you use File Explorer for remote copies from one location on a remote machine to another copy on the same server. You'll copy only a small amount of metadata over the network (1/2KiB per 16MiB of file data is transmitted). This results in a significant performance improvement. This is an OS-level and File Explorer-level distinction for SMB. |
| SMB Direct     |   Updated      | Improves performance for small I/O workloads by increasing efficiency when hosting workloads with small I/Os (such as an online transaction processing (OLTP) database in a virtual machine). These improvements are evident when using higher speed network interfaces, such as 40 Gbps Ethernet and 56 Gbps InfiniBand.  |
| SMB bandwidth limits | New | You can now use [Set-SmbBandwidthLimit](/powershell/module/smbshare/set-smbbandwidthlimit) to set bandwidth limits in three categories: VirtualMachine (Hyper-V over SMB traffic), LiveMigration (Hyper-V Live Migration traffic over SMB), or Default (all other types of SMB traffic).

For more information on new and changed SMB functionality in Windows Server 2012 R2, see [What's New in SMB in Windows Server](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831474(v%3dws.11)>).

## Features added in SMB 3.0 with Windows Server 2012 and Windows 8

| Feature/functionality  | New or updated  | Summary  |
| --------- | --------- | --------- |
| SMB Transparent Failover     |   New    | Enables administrators to perform hardware or software maintenance of nodes in a clustered file server without interrupting server applications storing data on these file shares. Also, if a hardware or software failure occurs on a cluster node, SMB clients transparently reconnect to another cluster node without interrupting server applications that are storing data on these file shares.        |
| SMB Scale Out     |   New      | Support for multiple SMB instances on a Scale-Out File Server. Using Cluster Shared Volumes (CSV) version 2, administrators can create file shares that provide simultaneous access to data files, with direct I/O, through all nodes in a file server cluster. SMB Scale Out provides better utilization of network bandwidth and load balancing of the file server clients, and optimizes performance for server applications.  |
| SMB Multichannel     |   New      |  Enables aggregation of network bandwidth and network fault tolerance if multiple paths are available between the SMB client and server. This enables server applications to take full advantage of all available network bandwidth and be resilient to a network failure.<br><br>SMB Multichannel in SMB 3 contributes to a substantial increase in performance compared to previous versions of SMB. |
| SMB Direct     |   New      | Supports the use of network adapters that have RDMA capability and can function at full speed with low latency, while using little CPU. For workloads such as Hyper-V or Microsoft SQL Server, SMB Direct enables a remote file server to resemble local storage.<br><br>SMB Direct in SMB 3 contributes to a substantial increase in performance compared to previous versions of SMB.  |
| Performance Counters for server applications     |   New      |  The new SMB performance counters provide detailed, per-share information about throughput, latency, and I/O per second (IOPS), allowing administrators to analyze the performance of SMB file shares where their data is stored. These counters are designed for server applications, such as Hyper-V and SQL Server, which store files on remote file shares.      |
| Performance optimizations    |  Updated   | Both the SMB client and server are optimized for small random read/write I/O, which is common in server applications such as SQL Server OLTP. In addition, large Maximum Transmission Unit (MTU) is turned on by default, which significantly enhances performance in large sequential transfers, such as SQL Server data warehouse, database backup or restore, deploying or copying virtual hard disks. |
| SMB-specific Windows PowerShell cmdlets     |   New      |  With Windows PowerShell cmdlets for SMB, an administrator can manage file shares on the file server, end to end, from the command line.   |
| SMB Encryption     |   New      | Provides end-to-end encryption of SMB data and protects data from eavesdropping occurrences on untrusted networks. Requires no new deployment costs, and no need for Internet Protocol security (IPsec), specialized hardware, or WAN accelerators. It may be configured on a per share basis, or for the entire file server, and may be enabled for various scenarios where data traverses untrusted networks. |
| SMB Directory Leasing     |  New | Improves application response times in branch offices. With the use of directory leases, roundtrips from client to server are reduced since metadata is retrieved from a longer living directory cache. Cache coherency is maintained because clients are notified when directory information on the server changes. Directory leases work with scenarios for HomeFolder (read/write with no sharing) and Publication (read-only with sharing).    |
| Performance over WAN   | New   | Directory opportunistic locks (oplocks) and oplock leases were introduced in SMB 3.0. For typical office/client workloads, oplocks/leases are shown to reduce network round trips by approximately 15%.<br><br>In SMB 3, the Windows implementation of SMB was refined to improve the caching behavior on the client and the ability to push higher throughputs.<br><br>SMB 3 features improvements to the CopyFile() API, and to associated tools such as Robocopy, to push more data over the network. |
| Secure dialect negotiation | New | Helps protect against man-in-the-middle attempt to downgrade dialect negotiation. The idea is to prevent an eavesdropper from downgrading the initially negotiated dialect and capabilities between the client and the server. For details, see [SMB3 Secure Dialect Negotiation](/archive/blogs/openspecification/smb3-secure-dialect-negotiation). [SMB 3.1.1 Pre-authentication Integrity in Windows 10](/archive/blogs/openspecification/smb-3-1-1-pre-authentication-integrity-in-windows-10) replaced this feature in SMB 3.1.1.|

## Hardware requirements

SMB Transparent Failover has the following requirements:

* A failover cluster running Windows Server 2012 or Windows Server 2016 with at least two configured nodes. The cluster must pass the cluster validation tests included in the validation wizard.
* File shares must be created with the Continuous Availability (CA) property, which is the default.
* File shares must be created on CSV volume paths to attain SMB Scale-Out.
* Client computers must be running Windows® 8 or Windows Server 2012, both of which include the updated SMB client that supports continuous availability.

> [!NOTE]
> Down-level clients can connect to file shares that have the CA property, but transparent failover isn't supported for these clients.

SMB Multichannel has the following requirements:

* At least two computers running Windows Server 2012 are required. No extra features need to be installed—the technology is on by default.
* For information on recommended network configurations, see the See Also section at the end of this overview article.

SMB Direct has the following requirements:

* At least two computers running Windows Server 2012 are required. No extra features need to be installed—the technology is on by default.
* Network adapters with RDMA capability are required. Currently, these adapters are available in three different types: iWARP, Infiniband, or RoCE (RDMA over Converged Ethernet).

## More information

The following list provides additional resources on the web about SMB and related technologies in Windows Server 2012 R2, Windows Server 2012, and Windows Server 2016.

* [Storage in Windows Server](../storage.yml)
* [Scale-Out File Server for Application Data](../../failover-clustering/sofs-overview.md)
* [Improve Performance of a File Server with SMB Direct](smb-direct.md)
* [Deploy Hyper-V over SMB](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134187(v%3dws.11)>)
* [Deploy SMB Multichannel](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn610980(v%3dws.11)>)
* [Deploying Fast and Efficient File Servers for Server Applications](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831723(v%3dws.11)>)
* [SMB: Troubleshooting Guide](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn659439(v%3dws.11)>)

