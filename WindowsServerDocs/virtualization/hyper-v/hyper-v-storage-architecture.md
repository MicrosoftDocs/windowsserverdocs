---
title: Physical storage architectures for Hyper-V in Windows Server
description: An overview of the types of physical storage architectures you can configure for your Hyper-V deployment.
ms.topic: conceptual
ms.author: helohr
author: Heidilohr
ms.date: 05/31/2024
---
# Physical storage architectures for Hyper-V in Windows Server

Windows Server Hyper-V is a mature hypervisor platform that supports a wide range of physical storage architectures, from standalone systems with no resiliency to clustered systems with complex resiliency requirements. This article is an overview of some of the most widely used configuration options.

>[!NOTE]
>This article doesn't describe every possible storage architecture configuration. It also doesn't describe less common types of configuration or edge cases.

## Standalone Hyper-V with local disks

Hyper-V supports several non-clustered, or standalone, configurations where you install Hyper-V on a standalone server and use local storage, network-attached storage (NAS), or storage area network (SAN) storage.

If you plan to use this configuration, it's important to keep the following details that can affect high availability in your deployment in mind:

- This configuration doesn't support automatic failover of virtual machine (VM) workloads due to its compute systems being non-clustered. For example, if the physical host loses power, the VMs running on it will restart when you power the physical host back on. However, you can manually live migrate VMs to other nodes or clusters using [shared-nothing](../hyper-v/deploy/Set-up-hosts-for-live-migration-without-Failover-Clustering.md) migration.

- You can optionally configure local disk resiliency for local drives. SAN and NAS systems provide their own availability guarantees. If you need more information, we recommend you contact your storage vendor.

:::image type="content" source="./plan/images/hyper-v-storage-architecture/standalone-hyper-v-local-transparent.png" alt-text="A diagram showing an example of a basic deployment of a standalone Hyper-V with local disks.":::

## Hyperconverged Hyper-V and Storage Spaces Direct

In this configuration, you install Hyper-V and Storage Spaces Direct on each node in a cluster. Each node contains local disks with data replicated to other nodes in the same cluster.

If you plan to use this configuration, remember that the following details can affect the performance of your deployment:

- VMs automatically failover to any node in the cluster in the event of a disaster scenario.

- Data gets replicated to other nodes in the cluster to increase storage resilience. Storage Spaces Direct supports several storage resiliency models. For more information, see [Fault tolerance and storage efficiency on Azure Stack HCI and Windows Server clusters](/azure-stack/hci/concepts/fault-tolerance).

- In this model, each physical host contains storage and compute resources. As a result, those resources scale symmetrically: every new host automatically adds both compute and storage resources. Each cluster can contain between one and sixteen nodes.

:::image type="content" source="./plan/images/hyper-v-storage-architecture/hyperconverged-hyper-v-storage-transparent.png" alt-text="A diagram showing a basic example of a deployment of a hyperconverged Hyper-V and Storage Spaces Direct":::

## Disaggregated Hyper-V with hyperconverged storage

In this configuration, you install Hyper-V and Storage Spaces Direct in separate clusters and have the VMs access their storage over the network.

If you plan to use this configuration, keep the following details in mind:

- VMs are highly available to any node in the same compute cluster.

- Data gets replicated to other nodes in the cluster to increase storage resilience. Storage Spaces Direct supports several storage resiliency models. For more information, see [Fault tolerance and storage efficiency on Azure Stack HCI and Windows Server clusters](/azure-stack/hci/concepts/fault-tolerance).

In this model, compute and storage scale independently from each other. This feature makes hyperconverged storage ideal for scenarios where your storage and compute requirements grow at different rates. For example, if you need more RAM or CPU resources to host VMs, you can add extra clusters without also adding more storage. If you have VMs that consume a lot of storage but don't consume many CPU resources, you can add another storage cluster without adding more compute resources.

- Each Compute cluster can contain between one and 64 nodes.

- Each storage cluster can contain between one and 16 nodes.

For example, the following diagram shows a simple deployment with one compute cluster and one storage cluster.

:::image type="content" source="./plan/images/hyper-v-storage-architecture/hyperconverged-basic-example-transparent.png" alt-text="A diagram showing a basic deployment of disaggregated Hyper-V with hyperconverged storage.":::

When you add more computing resources to run your VMs, you can either add a new node to the existing compute cluster or add a new cluster. The following diagram shows what happens to the simple deployment if you add a new cluster to it without adding more storage.

:::image type="content" source="./plan/images/hyper-v-storage-architecture/hyperconverged-basic-compute.png" alt-text="A diagram that shows the basic deployment with a new cluster added to its compute tier.":::

When you add more storage reources for hosting data without adding more computing resources, youc an either add a new node to the existing storage cluster or add a new cluster. The following diagram shows what the simple deployment looks like when you add a new cluster without adding computing resources like RAM or CPU.

:::image type="content" source="./plan/images/hyper-v-storage-architecture/hyperconverged-basic-storage.png" alt-text="A diagram that shows the basic deployment with a new storage cluster added to its storage tier.":::

## Disaggregated Hyper-V with NAS or SAN Storage

In this configuration, you install Hyper-V is a cluster with VMs that access their storage over the network like [hyperconverged storage](#disaggregated-hyper-v-with-hyperconverged-storage), but Hyper-V uses NAS or SAN storage from a storage vendor instead.

If you plan to use this configuration, keep the following details in mind:

- VMs are highly available to any node in the same compute cluster.

- SAN and NAS systems provide their own availability guarantees.

In this model, the compute and storage scales independently from one another. For example, if you need more RAM or CPU resources to host your VMs, you can add additional compute nodes or clusters without adding more storage. Each compute cluster can contain between one and 64 nodes.

Storage cluster scaling is vendor-specific, which means you need to contact your vendors to understand how the storage solution they offer can scale.

## Mixed architecture support

Hyper-V can support the combining the following types of architectures in the same compute cluster:

- Disaggregated Hyper-V with hyperconverged storage

- Disaggregated Hyper-V with SAN storage

- Disaggregated Hyper-V with NAS

### Network Storage Protocols

Windows Server supports the following file protocols:

- SMB over TCP

- SMB over QUIC

- SMB over RDMA (SMB Direct)

Windows Server also supports the following block protocols:

- iSCSI

- NVMe-oF

- Fibre Channel

- Infiniband

>[!NOTE]
>Configuration specifics ultimately determine whether your deployment can support these protocols. For example, deployments that use the Hyper-V virtual switch don't support Infiniband. However, they can support Infiniband devices when they aren't bound to the virtual switch.

Microsoft also provides the following in-box software-based block initiators for network storage:

- SCSI

- NVMe-oF (coming soon) <!--Is this in preview? If not, maybe we should add it in later.-->

You can also use a storage vendor client for any device available in the Windows Server catalog.
