---
title: Physical storage architectures for Hyper-V in Windows Server
description: An overview of the types of physical storage architectures you can configure for your Hyper-V deployment.
ms.topic: conceptual
ms.author: helohr
author: Heidilohr
ms.date: 06/24/2024
---
# Physical storage architectures for Hyper-V

Windows Server Hyper-V is a mature hypervisor platform that supports a wide range of physical storage architectures, from standalone systems with no resiliency to clustered systems with complex resiliency requirements. This article is an overview of some of the most widely used configuration options.

>[!NOTE]
>This article doesn't describe every possible storage architecture configuration. It also doesn't describe less common types of configuration or edge cases.

## Standalone Hyper-V with local disks

Hyper-V supports several nonclustered, or standalone, configurations where you install Hyper-V on a standalone server and use local storage.

When using this configuration:

- Standalone Hyper-V with local disks doesn't support automatic failover of virtual machine (VM) workloads due to the lack of shared storage and the compute (VM processing and memory) systems being nonclustered. For example, if the physical host loses power, the VMs running on it restart when you power the physical host back on. You can also live migrate VMs to other nodes or clusters using [shared-nothing](../hyper-v/deploy/Set-up-hosts-for-live-migration-without-Failover-Clustering.md) migration.

- You can optionally configure local disk resiliency for local drives using hardware or software RAID solutions. If you need more information, we recommend you contact your storage vendor.

:::image type="content" source="media/hyper-v-storage-architecture/standalone-hyper-v-local.png" alt-text="A diagram showing an example of a basic deployment of a standalone Hyper-V with local disks.":::

## Disaggregated Hyper-V with SAN or NAS Storage

In this configuration, you install Hyper-V in its own cluster. The VMs on the Hyper-V hosts access their storage over the network using SAN or NAS storage from a storage vendor instead.

When using this configuration:

- VMs are highly available to any node in the same compute cluster.

- SAN and NAS systems provide their own availability guarantees.

In this model, the compute and storage scales independently from one another. For example, if you need more processing or memory resources to host your VMs (CPU or RAM), you can add more compute nodes to the cluster or create new clusters without adding more storage. Each compute cluster can contain between 1 and 64 nodes.

You can scale storage independently from the compute cluster. Storage cluster scaling is vendor-specific. Contact your vendors to understand how the storage solution they offer can scale.

## Hyperconverged Hyper-V and Storage Spaces Direct

In this configuration, you install Hyper-V and Storage Spaces Direct on each node in a cluster. Each node contains local disks with data replicated to other nodes in the same cluster.

When using this configuration:

- You can move VMs to any node in the cluster using Live Migrate or automatically restart after a failure (failover).

- Data gets replicated to other nodes in the cluster to increase storage resilience. Storage Spaces Direct supports several storage resiliency models. For more information, see [Fault tolerance and storage efficiency on Azure Stack HCI and Windows Server clusters](/azure-stack/hci/concepts/fault-tolerance).

- In this model, each physical host contains storage and compute resources. As a result, those physical resources scale symmetrically. Every new host automatically adds both compute and storage resources. Each cluster can contain between 1 and 16 nodes.

:::image type="content" source="media/hyper-v-storage-architecture/hyperconverged-hyper-v-storage.png" alt-text="A diagram showing a basic example of a deployment of a hyperconverged Hyper-V and Storage Spaces Direct." lightbox="media/hyper-v-storage-architecture/hyperconverged-hyper-v-storage.png":::

## Disaggregated Hyper-V with hyperconverged storage

In this configuration, you install Hyper-V and Storage Spaces Direct in separate clusters and access the VMs' configuration and storage over the network.

When using this configuration:

- VMs are highly available to any node in the same compute cluster.

- Data gets replicated to other nodes in the storage cluster to increase storage resilience. Storage Spaces Direct supports several storage resiliency models. For more information, see [Fault tolerance and storage efficiency on Azure Stack HCI and Windows Server clusters](/azure-stack/hci/concepts/fault-tolerance).

In this model, compute and storage scale independently from each other. This architecture is ideal for scenarios where your storage and compute requirements grow at different rates. For example, if you need more CPU or memory resources to host VMs, you can add extra cluster nodes without also adding more storage. If you have VMs that consume a lot of storage but don't consume many CPU resources, you can add another storage node or cluster without adding more compute resources.

- Each compute cluster can contain between 1 and 64 nodes.

- Each storage cluster can contain between 1 and 16 nodes.

The following diagram shows a simple example deployment with one compute cluster and one storage cluster.

:::image type="content" source="media/hyper-v-storage-architecture/hyperconverged-basic-example.png" alt-text="A diagram showing a basic deployment of disaggregated Hyper-V with hyperconverged storage." lightbox="media/hyper-v-storage-architecture/hyperconverged-basic-example.png":::

When you add more compute resources to run your VMs, you can either add a new node to the existing compute cluster or add a new cluster. The following diagram shows what happens to the simple deployment if you add a new cluster to it without adding more storage.

:::image type="content" source="media/hyper-v-storage-architecture/hyperconverged-basic-compute.png" alt-text="A diagram that shows the basic deployment with a new cluster added to its compute tier." lightbox="media/hyper-v-storage-architecture/hyperconverged-basic-compute.png":::

When you add more storage resources for hosting data without adding more compute resources, you can either add a new node to the existing storage cluster or add a new cluster. The following diagram shows what the simple deployment looks like when you add a new cluster without adding compute resources like CPU or RAM.

:::image type="content" source="media/hyper-v-storage-architecture/hyperconverged-basic-storage.png" alt-text="A diagram that shows the basic deployment with a new storage cluster added to its storage tier." lightbox="media/hyper-v-storage-architecture/hyperconverged-basic-storage.png":::

## Mixed architecture support

Hyper-V can support the combining the following types of architectures in the same compute cluster:

- Disaggregated Hyper-V with hyperconverged storage

- Disaggregated Hyper-V with SAN

- Disaggregated Hyper-V with NAS

The following diagram shows an example of a deployment with a compute cluster containing a mix of disaggregated SAN and NAS storage.

:::image type="content" source="media/hyper-v-storage-architecture/hyperconverged-mixed-example.png" alt-text="A diagram that shows a deployment with a compute cluster containing a mix of disaggregated SAN and NAS storage." lightbox="media/hyper-v-storage-architecture/hyperconverged-mixed-example.png":::

### Network Storage Protocols

Windows Server supports the following network file storage protocols:

- [SMB over TCP](/troubleshoot/windows-server/networking/direct-hosting-of-smb-over-tcpip)

- [SMB over QUIC](../../storage/file-server/smb-over-quic.md)

- [SMB over RDMA (SMB Direct)](../../storage/file-server/smb-direct.md)

Windows Server also supports the following network block storage protocols:

- iSCSI

- Fibre Channel

- InfiniBand

>[!NOTE]
>Configuration specifics ultimately determine whether your deployment can support these protocols. For example, deployments that use the Hyper-V virtual switch don't support InfiniBand. However, they can support InfiniBand devices when they aren't bound to the virtual switch.

Microsoft also provides an in-box software-based iSCSI initiator for network block storage.

You can also use a storage vendor client for any device available in the Windows Server catalog.
