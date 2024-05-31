---
title: Physical storage architectures for Hyper-V in Windows Server
description: An overview of the types of physical storage architectures you can configure for your Hyper-V deployment.
ms.topic: conceptual
ms.author: helohr
author: Heidilohr
ms.date: 05/31/2024
---
# Physical storage architectures for Hyper-V in Windows Server

Windows Server Hyper-V is a mature hypervisor platform that supports a wide range of physical storage architectures from standalone systems with no resiliency through clustered systems with complex resiliency requirements. Here are a few example configuration options. 

Note: This list is not exhaustive of all possible storage architectures.

## Standalone Hyper-V with local disks

Hyper-V supports several standalone (non-clustered) configurations where Hyper-V is installed on a standalone server and uses either local, NAS, or SAN storage. 

High availability: 

- Virtual Machine high availability: Automatic failover of VM workloads is not possible with this configuration as the compute systems are not clustered. For example, if the physical host loses power, the virtual machines running will be restarted when the physical host is powered back on. Virtual machines can be manually live migrated to other nodes or clusters using [shared-nothing](https://learn.microsoft.com/en-us/windows-server/virtualization/hyper-v/deploy/set-up-hosts-for-live-migration-without-failover-clustering) migration. 

- Storage high availability: Local disk resiliency can be optionally configured for local drives. SAN and NAS systems provide their own availability guarantees. Consult your storage vendor for more information.

<!--Image goes here-->

## Hyperconverged Hyper-V and storage

In this configuration, Hyper-V and Storage Spaces Direct are installed on each node in a cluster. Each node contains local disks with data that is replicated to other nodes in the same cluster. 

High availability: 

- Virtual Machine high availability: Virtual machines automatically failover to any node in the cluster. 

- Storage high availability: Data is replicated to other nodes in the cluster. Storage Spaces Direct supports several storage resiliency models. For more information, see link. 

Scalability: In this model, each physical host contains storage and compute resources. As a result, those resources scale symmetrically; a new host adds both compute and storage resources. Each cluster can be between 1 – 16 nodes.

<!--Image goes here-->

## Disaggregated Hyper-V with hyperconverged storage

In this configuration, Hyper-V and Storage Spaces Direct are installed in separate clusters with virtual machines accessing their storage over the network. 

High availability: 

- Virtual Machine high availability: Virtual machines are made highly available to any node in the same compute cluster. 

- Storage high availability: Data is replicated to other nodes in the same cluster. Storage Spaces Direct supports several storage resiliency models. For more information, see link. 

Scalability: In this model, compute and storage scale independently from one another. This is beneficial if your storage or compute requirements grow at different rates. For example, if you need more RAM or CPU resources to host virtual machines, you can add additional compute nodes (or clusters) without adding more storage. Or if you have virtual machines that consume a lot of storage and need more, you can add another storage cluster without adding more compute. 

- Each Compute cluster can range between 1 – 64 nodes. 

- Each storage cluster can range between 1 – 16 nodes.  

For example, this is the simplest model with one compute cluster and one storage cluster.

<!--Image goes here-->

To add additional RAM and CPU resources for running virtual machines, you have the option to: 

- add an additional node to the existing compute cluster 

- add a new cluster as shown below. 

Note: No additional storage was added in this example. 

<!--Image goes here-->

To add additional storage resources to host more data, you have the option to: 

- add an additional node to the existing storage cluster 

- add a new cluster as shown below 

Note: No CPU or RAM resources for running virtual machines were added to the compute cluster in this example. 

<!--Image goes here-->

## Disaggregated Hyper-V with SAN or NAS Storage 

In this configuration, Hyper-V uses SAN or NAS storage from a storage vendor. Hyper-V is installed in a cluster with virtual machines accessing their storage over the network. 

High availability: 

- Compute high availability: Virtual machines are made highly available to any node in the same compute cluster. 

- Storage high availability: SAN and NAS systems provide their own availability guarantees. 

Scalability: In this model, the compute and storage scales independently from one another. For example, if you need more RAM or CPU resources to host virtual machines, you can add additional compute nodes (or clusters) without adding more storage. 

- Each Compute cluster can range between 1 – 64 nodes. 

- Storage Cluster Scaling: Vendor Specific 

## Supportability of mixed architectures 

The following architectures can be combined with the same compute cluster: 

- Disaggregated Hyper-V with Hyperconverged Storage 

- Disaggregated Hyper-V with SAN Storage 

- Disaggregated Hyper-V with NAS Storage 

### Network Storage Protocols 

Windows Server supports several network storage protocols. 

File Protocols 

- SMB over TCP 

- SMB over QUIC 

- SMB over RDMA (SMB Direct) 

Block Protocols 

- iSCSI 

- NVMe-oF 

- Fibre Channel 

- Infiniband 

Note: The specifics of the configuration may ultimately determine supportability. For example, Infiniband is not supported with the Hyper-V virtual switch. As long as your infiniband devices are not bound to the virtual switch this is supported. 

Microsoft provides inbox software-based block initiators for network storage including: 

- SCSI 

- NVMe-oF (coming soon) 

You can also use a storage vendor client for any device available in the Windows Server catalog. 