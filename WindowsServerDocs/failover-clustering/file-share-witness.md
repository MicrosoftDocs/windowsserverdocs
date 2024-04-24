---
title: Deploy a File Share Witness in Windows Server 2019
description: Use a file share witnesses to use a file share to vote in cluster quorum, listing requirements and deployment.
manager: eldenc
ms.topic: article
author: johnmarlin-msft
ms.author: johnmar
ms.date: 04/24/2024

---
# Deploy a file share witness

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Azure Stack HCI, versions 21H2 and 20H2

A file share witness is an SMB share that Failover Cluster uses as a vote in the cluster quorum. This topic provides an overview of the technology and the new functionality in Windows Server 2019, including using a USB drive connected to a router as a file share witness.

File share witnesses are handy in the following circumstances:

- A cloud witness can't be used because not all servers in the cluster have a reliable Internet connection
- A disk witness can't be used because there aren't any shared drives to use for a disk witness. This could be a Storage Spaces Direct cluster, SQL Server Always On Availability Groups (AG), Exchange Database Availability Group (DAG), etc.  None of these types of clusters use shared disks.

## File share witness requirements

You can host a file share witness on a domain-joined Windows server, or if your cluster is running Windows Server 2019, any device that can host an SMB 2 or later file share.

|File server type                 | Supported clusters |
|---------------------------------|--------------------|
|Any device w/an SMB 2 file share | Windows Server 2019|
|Domain-joined Windows Server     | Windows Server 2008 and later|

If the cluster is running Windows Server 2019, here are the requirements:

- An SMB file share *on any device that uses the SMB 2 or later protocol*, including:
  - Network-attached storage (NAS) devices
  - Windows computers joined to a workgroup
  - Routers with locally-connected USB storage
- A local account on the device for authenticating the cluster
- If you're instead using Active Directory for authenticating the cluster with the file share, the Cluster Name Object (CNO) must have write permissions on the share, and the server must be in the same Active Directory forest as the cluster
- The file share has a minimum of 5 MB of free space

If the cluster is running  Windows Server 2016 or earlier, here are the requirements:

- SMB file share *on a Windows server joined to the same Active Directory forest as the cluster*
- The Cluster Name Object (CNO) must have write permissions on the share
- The file share has a minimum of 5 MB of free space

Other notes:

- To use a file share witness hosted by devices other than a domain-joined Windows server, you currently must use the **Set-ClusterQuorum -Credential** PowerShell cmdlet to set the witness, as described later in this topic.
- For high availability, you can use a file share witness on a separate Failover Cluster
- The file share can be used by multiple clusters
- The use of a Distributed File System (DFS) share or replicated storage is not supported with any version of failover clustering.  These can cause a split brain situation where clustered servers are running independently of each other and could cause data loss.
