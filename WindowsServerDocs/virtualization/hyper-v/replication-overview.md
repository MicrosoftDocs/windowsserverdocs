---
title: Hyper-V Replica overview
description: Replicate virtual machines between Hyper-V hosts using Hyper-V Replica as part of a business continuity and disaster recovery (BCDR) strategy.
ms.topic: concept-article
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 11/10/2025
---

# Hyper-V Replica overview

Hyper-V Replica is a built-in feature of Hyper-V in Windows Server that enables the replication of virtual machines (VMs) between Hyper-V hosts for business continuity and disaster recovery (BCDR) purposes. It enables you to create and maintain offline copies of VMs on a secondary host, and even extend to a third host, which you can use for failover if a primary host fails. Hyper-V Replica isn't available in Hyper-V in Windows client operating systems.

Hyper-V failover clustering and Hyper-V Replica solve related but distinct availability scenarios. A Hyper-V failover cluster provides local high availability for running VMs by using multiple hosts (nodes) that typically access the same clustered storage. If a node fails, the cluster service restarts the affected VM on another node, with no (or minimal) data loss because the VM's virtual hard disks remain on shared storage. Hyper-V Replica, by contrast, is a disaster recovery technology that maintains an asynchronous copy of a VM's storage on another host or cluster - often at a different site - so you can manually initiate failover if the primary host, cluster, or site becomes unavailable. Replica doesn't require shared storage, introduces a recovery point objective (potential data loss up to the replication interval), and complements rather than replaces failover clustering. Many organizations use both: clustering for intra-site high availability and Hyper-V Replica for inter-site resilience and recovery.

This article provides an overview of Hyper-V Replica, its key features, how it works, and how you can use it to enhance your BCDR strategy.

## Key features of Hyper-V Replica

Hyper-V Replica offers several key features that make it a powerful and affordable tool for VM replication and disaster recovery:

- **Workload and application agnostic**: Hyper-V Replica works at the hypervisor level, making it suitable for replicating a wide range of workloads and applications without requiring application-specific agents or configurations.

- **Asynchronous replication**: changes made to the primary VM are collated by using resilient change tracking (RCT) at the block level and can be sent to the replica VM at regular intervals of 30 seconds, 5 minutes, or 15 minutes, depending on your recovery point objective (RPO) requirements. RCT decreases the need for time-consuming consistency checks and provides great resiliency.

- **Planned and unplanned failover**: In a planned failover, the primary VM shuts down gracefully and replicates remaining changes before switching to the replica. In an unplanned failover, the replica VM starts without shutting down the primary VM, which might result in some data loss. Once you recover the primary host, you can perform a reverse replication to synchronize changes back to the original primary VM. For more information, see [Failover and recovery](#failover-and-recovery).

- **Flexible topologies**: replicate between single hosts, clustered hosts, or a combination of both, allowing you to design a replication strategy that fits your infrastructure. Hosts can be located in the same site or across different geographic locations.

- **Encryption and authentication**: support for both Kerberos (for domain-joined hosts) and certificate-based authentication (for non-domain-joined hosts), providing flexibility in securing replication traffic. Encrypt replication traffic with a certificate to protect data in transit. You can restrict replication between specific Hyper-V hosts to enhance security.

- **Flexible storage options**: file-based replication that is storage and workload agnostic, allowing flexibility in your infrastructure design to use different types of storage solutions for the primary and replica hosts. You can choose to replicate all virtual hard disks for a VM or only a subset of them, enabling you to optimize storage usage and replication performance.

- **Network and compression**: replication is TCP-based by using HTTP or HTTPS. You can enable compression to reduce bandwidth usage during replication.

- **Recovery history**: up to 24 hourly recovery points enable you to revert to a previous state of the VM if needed. Volume Shadow Copy Service (VSS) integration can provide application-consistent recovery points for VMs running VSS-aware applications, such as Microsoft SQL Server.

- **Test failover**: perform test failovers to validate your disaster recovery plan without impacting the production environment. For more information, see [Failover and recovery](#failover-and-recovery).

- **Extended replication**: You can extend replication from the secondary host to a third Hyper-V host, creating a three-tier replication topology. This approach provides an extra layer of redundancy and caters for more complex BCDR strategies. You can use a different replication interval for the extended replication to balance recovery point objectives (RPO) and bandwidth usage across different sites. Replication doesn't happen from the primary server to two other replica servers. Instead, the primary server replicates to the replica server, which in turn replicates to the extended replica server.

- **No additional licensing costs**: Hyper-V Replica is included with Windows Server at no extra cost, making it a cost-effective solution for VM replication and disaster recovery.

## Hyper-V Replica components

Hyper-V Replica includes the components described in the following table:

| Component | Description |
|--|--|
| Replication engine | Manages initial replication, replication configuration details, replication of delta changes, and failover and test failover operations. Tracks VM and storage mobility events and takes appropriate actions when necessary. |
| Change tracking module | Tracks changes that occur to the VM on a source Hyper-V host by monitoring write operations to the virtual hard disks (VHDs), regardless of storage location (local, SAN, NAS, SMB 3 or newer share, or Cluster Shared Volume). |
| Network module | Provides a secure and efficient way to transfer VM data between Hyper-V hosts. Minimizes traffic by compressing data by default and can encrypt data when HTTPS and certificate-based authentication are used. |
| Hyper-V Replica Broker | Used only when a Hyper-V host is a node in a failover cluster. Enables use of Hyper-V Replica with highly available VMs that can move between cluster nodes by querying the cluster database and redirecting requests to the node where the VM is running. |
| Management tools | Configure and manage Hyper-V Replica with Hyper-V Manager and Windows PowerShell. Use Failover Cluster Manager for all VM management and Hyper-V Replica configurations when source or replica hosts are part of a failover cluster. |

## How Hyper-V Replica works

Hyper-V Replica works by replicating the changes you make to a primary VM to a replica VM on a secondary Hyper-V host. The approach you take depends on whether you're replicating to a Hyper-V cluster or a single host. You configure the receiving cluster or host, not the primary cluster or host. Configure both the primary and secondary hosts for replication to ensure that you can fail back to the original primary host after a failover.

Hyper-V Replica can have the following two instances of a single VM residing on different Hyper-V hosts:

- The main, actively running VM, which is called a *primary VM*.
- An offline copy of the primary VM, which is called a *replica VM*.

The replication process involves several key components and steps, which are outlined in the following diagram:

:::image type="content" source="media/replication-overview/hyper-v-replica-overview.svg" alt-text="A diagram of the Hyper-V Replica data flow showing the primary VM with change tracking, asynchronous replication to a secondary host, and optional extended replication to a third host.":::

1. When you enable Hyper-V Replica for a VM, you create an initial copy of the VM on the secondary host. You can send this copy over the network or by using external media.

1. Hyper-V uses a change tracking mechanism to monitor changes you make to the primary VM's virtual hard disks (VHDs). It stores changes in `.hrl` files in the same location. This approach enables Hyper-V to identify which blocks of data changed since the last replication cycle.

1. At the configured replication interval (30 seconds, 5 minutes, or 15 minutes), Hyper-V sends the changes to the secondary host. The replication process is asynchronous, so the primary VM continues to operate while Hyper-V replicates changes.

1. The secondary host receives the changes and applies them to the replica VM's VHDs, ensuring the replica VM stays up-to-date with the primary VM.

1. If a primary host fails, you initiate a failover to the replica VM. Depending on whether it's a planned or unplanned failover, the process differs slightly, but the end result is that the replica VM becomes the new primary VM. You can initiate failover manually or through automation scripts.

1. Once you restore the primary host, you can perform a reverse replication to synchronize any changes made to the replica VM back to the original primary VM, allowing it to resume its role as the primary host.

## Plan for Hyper-V Replica

When planning to implement Hyper-V Replica as part of your BCDR strategy, consider and make decisions on the following design points:

| Decision point | Supporting details |
|--|--|
| **Which workloads do you want to replicate?** | List target VMs and their workloads. Default replication protects OS state, not in‑flight application state. If you need to recover application state, enable (and schedule) application‑consistent recovery points. |
| **Which VHDs need to be replicated?** | Exclude disks whose changing data isn't required after failover (for example, page file or temp data disks) to conserve bandwidth and storage. Document exclusions. |
| **How often do you need to synchronize data?** | Choose 30 seconds, 5 minutes, or 15 minutes based on RPO, criticality, and bandwidth. Higher criticality and lower RPO needs favor shorter intervals; validate available network capacity. |
| **What's the rate of change of the data on each VM?** | High churn increases bandwidth and replica storage consumption. Consider compression or a longer interval if saturation occurs. Include every VM in sizing calculations. |
| **What authentication method will you use and do you require encryption?** | Use Kerberos when both hosts are domain‑joined and you don't require encryption. Use certificate‑based authentication for encrypting replica traffic and/or if either host is non‑domain‑joined; provision and trust the required certificates beforehand. |
| **Do you need to fail over to an earlier point in time?** | Default is a single (latest) recovery point. Configure up to 24 hourly points for point‑in‑time recovery; more points increase storage and I/O overhead. |
| **How will you seed the initial replication of VM data?** | Options:<br />- Send over the network immediately.<br />- Schedule network transfer for a later time window.<br />- Use an existing restored VM on the replica host.<br />- Export to external media, ship, and import at the replica site. |

## Failover and recovery

It's important to regularly test your BCDR plan to ensure that Hyper-V Replica functions as expected and that you can successfully fail over and recover VMs. You should perform test failovers, validate recovery points, and ensure that all components of your replication strategy are working correctly. Regular testing helps identify potential issues and ensures that your team is familiar with the failover and recovery processes.

There are three types of failover scenarios in Hyper-V Replica:

- You can run a test failover at any point without impacting the production environment. A test failover creates a temporary copy of the replica VM on the secondary host, allowing you to validate the failover process and ensure that the VM starts correctly. The test VM is isolated from the production network to prevent any conflicts. The primary VM continues to run during a test failover, so there's no downtime, and the replication process isn't affected. After completing the test, including other components of your BCDR plan, you can delete the test VM without impacting the replica VM or the primary VM.

- In a planned failover, the primary VM shuts down gracefully, and any remaining changes are replicated to the replica VM before switching roles. This approach ensures that there's no data loss during the failover process. No duplicate VM is created during a planned failover. The failover action is initiated from the primary host. You can reverse the replication after the primary host is available again to synchronize any changes made to the replica VM back to the original primary VM, then perform another planned failover to switch back.

- In an unplanned failover, the replica VM starts without shutting down the primary VM, which can result in data loss. The replica VM becomes the new primary VM, and you can later perform a reverse replication to synchronize changes back to the original primary VM once it's restored. No duplicate VM is created during an unplanned failover. The failover action is initiated from the secondary host.

For more information about performing failover and recovery operations with Hyper-V Replica, see [Fail over a replicated virtual machine with Hyper-V Replica](replication-failover.md).

## Next step

To configure Hyper-V Replica, select one of the following articles based on your environment:

> [!div class="nextstepaction"]
> [Enable Hyper-V Replica on a failover cluster](configure-replication-failover-cluster.md)

> [!div class="nextstepaction"]
> [Enable Hyper-V Replica on a single host](configure-replication-single-host.md)
