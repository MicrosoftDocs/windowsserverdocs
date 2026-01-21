---
title: Failover Clustering topologies in Windows Server
description: Learn about the different failover cluster topologies available in Windows Server, including single rack, campus, stretch, and multi-cluster configurations.
author: robinharwood
ms.author: roharwoo
ms.service: windows-server
ms.topic: concept-article
ms.date: 01/21/2026
ai-usage: ai-assisted
#CustomerIntent: As a IT administrator, I want to understand the different failover cluster topologies so that I can choose the right configuration for my business requirements.
---

# Failover Clustering topologies

Windows Server Failover Clustering supports multiple deployment topologies to meet different business requirements for high availability and disaster recovery for your applications, services, and data. These topologies provide the reliability, resilience, and uptime critical across on-premises, hybrid, public cloud, private cloud, and sovereign cloud environments.

The topology you choose depends on factors such as your physical infrastructure, network latency requirements, budget constraints, and recovery objectives. Understanding these topologies helps you design the right solution for your workloads.

## Topologies

Windows Server Failover Clustering supports several topologies, each with its own advantages and trade-offs. The main topologies include:

- Simple cluster (single fault domain)
- Storage Spaces Direct campus cluster
- Storage Spaces Direct stretch cluster
- SAN stretch cluster
- Multi-cluster topology

The following sections provide an overview of each topology, including their use cases, benefits, and limitations.

## Failover clustering fault domains

Before exploring specific topologies, it's important to understand the concept of fault domains in a failover cluster. A fault domain is a logical grouping of hardware components that share a common point of failure. When one component in a fault domain fails, it can potentially affect all other components in that same domain.

Common examples of fault domains include:

- **Node level**: Individual server failures due to hardware issues, operating system problems, or maintenance
- **Rack level**: Shared infrastructure within a rack, such as power distribution units (PDUs), top-of-rack (TOR) network switches, or cooling systems
- **Room or data center level**: Building-wide systems like main power feeds, cooling systems, or physical security
- **Site level**: Geographic location-specific risks such as natural disasters, regional power outages, or network connectivity issues

When you design a failover cluster, understanding and planning for fault domains is crucial for achieving your desired level of availability and resilience. A well-designed cluster should be able to continue operating even when an entire fault domain fails. For example:

- A simple cluster with all nodes in one rack can survive individual node failures, but not a rack-level failure.
- A campus cluster with nodes distributed across two racks can survive the failure of an entire rack.
- A stretch cluster with nodes in separate geographic sites can survive a complete site failure.

The number and type of fault domains in your topology directly impact your cluster's ability to maintain service during various failure scenarios. More fault domains generally provide higher resilience but come with increased complexity and cost.

For more information about fault domains in Windows Server, see [Fault domain awareness](fault-domains.md).

## Topology comparison

The following table compares key characteristics of each failover clustering topology:

| Characteristic | Simple Cluster | Storage Spaces Direct Campus Cluster | Storage Spaces Direct Stretch Cluster | SAN Stretch Cluster | Multi-Cluster |
|---|---|---|---|---|---|
| **Geographic scope** | Single fault domain | Same physical location | Separate geographic sites | Separate geographic sites | Multiple separate sites |
| **Network type** | LAN | LAN | LAN or WAN | LAN or WAN | Determined by workload requirement |
| **Optimal latency** | ≤1 ms | ≤1 ms | [≤1-5 ms (sync)<br/>Variable (async)](../storage/storage-replica/storage-replica-overview.md#storage-replica-prerequisites) | Determined by SAN vendor | Variable (workload determined) |
| **Storage configuration** | Single pool (SAN/NAS/Storage Spaces Direct) | Single Storage Spaces Direct pool spanning racks | Separate Storage Spaces Direct pools per site | SAN LUNs replicated between sites | Independent storage per cluster |
| **Storage replication method** | None | Storage Spaces Direct Rack Level Nested Mirror | Storage Replica | SAN vendor replication | Application-level or Storage Replica |
| **Fault domains** | Nodes only | 2 fault domains | 2 fault domains | 2 fault domains | Independent clusters |
| **Protects against** | Node failure | Node + rack failure | Node + rack + site failure | Node + rack + site failure | Site + cluster failure |
| **Deployment complexity** | Low | Medium | High | High | High |
| **Primary use case** | Single datacenter HA | Campus/multi-building HA | Metro-area DR | Metro-area DR | Multi-region DR |

## Simple cluster (single fault domain)

A simple cluster places all cluster nodes within a single fault domain, typically in the same physical rack in a data center room. This topology is the most common and straightforward failover cluster topology. All nodes are in one rack, with shared storage that can be SAN, NAS, Storage Spaces Direct (S2D), or S2D with SAN coexistence. This configuration provides node-level redundancy and protection against individual server failures while maintaining the lowest network latency between nodes.

The following diagram illustrates a simple cluster topology with all nodes in the default subnet site fault domain.

:::image type="content" source="./media/topologies/simple-cluster.png" alt-text="Diagram that shows a simple cluster topology with all nodes in the default subnet site fault domain." lightbox="./media/topologies/simple-cluster.png":::

This topology is ideal for single datacenter deployments, workloads that require high performance with minimal latency, organizations with limited physical infrastructure, and development and test environments. It's the simplest configuration to deploy and manage, making it an excellent starting point for many organizations.

However, this topology has important limitations. It provides no protection against failure that could affect the whole fault domain. For example, if the fault domain is the rack-level, failures such as power distribution problems or top-of-rack switch failures could affect the availability of your cluster. It also offers no protection against wider data center or site-level disasters. The rack infrastructure itself represents a single point of failure that organizations must accept when choosing this topology.

## Storage Spaces Direct campus cluster

A Storage Spaces Direct campus cluster is a two-rack configuration within the same physical location, such as a factory, hospital, college campus, or datacenter connected by low-latency local area network (LAN) infrastructure. Campus clusters provide rack-level resiliency using Storage Spaces Direct (S2D) with either two-copy or four-copy volumes, known as Rack Level Nested Mirror (RLNM). This approach means data is intelligently distributed across racks. The topology is designed to protect against rack-level failures while maintaining low latency between nodes.

The following diagram illustrates a Storage Spaces Direct campus cluster topology with nodes distributed across two rack fault domains within the same physical location.

:::image type="content" source="./media/topologies/storage-spaces-direct-campus-cluster.png" alt-text="Diagram that shows a Storage Spaces Direct campus cluster topology with nodes distributed across two rack fault domains." lightbox="./media/topologies/storage-spaces-direct-campus-cluster.png":::

Campus clusters require Windows Server 2025 with the December cumulative update installed ([KB5072033](https://support.microsoft.com/en-gb/topic/december-9-2025-kb5072033-os-build-26100-7462-fca31d8d-5fe8-4b5e-9591-6641ef1d26a1)). Campus clusters only support two rack fault domains within the same physical location connected by LAN. This topology differs significantly from stretch clusters, which span geographically separated sites connected by WAN and use Storage Replica for replication between sites. This topology provides rack-level resiliency for Hyper-V VMs, SQL Server FCI, File Servers, SAP, and other applications.

The configuration requires exactly two rack fault domains with a single Storage Spaces Direct (S2D) storage pool spanning both racks. Rack Level Nested Mirror (RLNM) distributes data copies across racks: two-copy volumes place one copy in each rack, while four-copy volumes place two copies in each rack. All capacity drives must be the same type. Flash-based (SSD or NVMe) drives are recommended for optimal performance. Caching tiers and HDDs aren't recommended.

The campus cluster uses LAN connectivity and requires 1 ms latency or less between racks. RDMA NICs and switches are recommended to reduce CPU overhead. The configuration works best with redundant strands of dark fiber cable between racks, and highly available top-of-rack (TOR) switches to avoid single points of failure. Each rack should have a separate network path to the cluster quorum resource.

This topology is well-suited for campus environments including factories, business parks, hospitals, school and college campuses, vessels and cruise ships, and stadiums. It's also ideal for organizations meeting NIS2 requirements for separate data rooms, or any location with two buildings or rooms connected by fiber.

Campus clusters support symmetric node distributions (nodes per rack fault domain) with two and four-copy volumes recommended. For example, 1+1, 2+2, 3+3, and so on, up to a maximum of 10 nodes (5+5).

Common configurations include:

- **1+1**: One node per rack fault domain, the minimum configuration. This configuration uses a nested two-way mirror with four-copy volumes for maximum data resiliency. To learn more nest mirrors, see [Nested resiliency for Storage Spaces Direct](../storage/storage-spaces/nested-resiliency.md).
- **2+2**: Two nodes per rack fault domain, using any combination of two-copy or four-copy volumes.

> [!TIP]
> A 2+2 configuration with four-copy volumes provides the best balance between cost, performance, and resiliency, allowing the cluster to survive losing an entire rack (fault domain) and a node simultaneously.

To learn more about the different volume resiliency options, see [Fault tolerance and storage efficiency on Azure Local and Windows Server clusters](../storage/storage-spaces/fault-tolerance.md).

For the cluster quorum, place the witness resource (File Share Witness, Disk Witness, Cloud Witness, or USB Witness) in a third location, separate from the two racks.

Storage Spaces Direct campus clusters are also known as rack-aware clusters for Azure Local. Storage Spaces Direct campus clusters provide the same functionality and benefits as Azure Local rack aware cluster, but have specific deployment and configuration requirements. To learn more about Azure Local rack aware clustering, see [Overview of Azure Local rack aware clustering](/azure/azure-local/concepts/rack-aware-cluster-overview).

You can also learn more about Storage Spaces Direct campus clusters in our announcement blog, [Announcing Support for S2D Campus Cluster on Windows Server 2025](https://techcommunity.microsoft.com/blog/failoverclustering/announcing-support-for-s2d-campus-cluster-on-windows-server-2025/4477075).

## Stretch cluster

A stretch cluster, also known as a geo-cluster or multi-site cluster, extends a failover cluster across two geographically separated physical sites connected by high-speed wide area network (WAN) infrastructure. This topology provides site-level disaster recovery capability by maintaining complete, independent infrastructure at each location. The key distinction from a campus cluster is that stretch clusters span separate geographic locations connected via WAN, whereas campus clusters use LAN connectivity within a single location.

You can implement stretch clusters using two different storage architectures:

- **Storage Spaces Direct stretch cluster**: Each site maintains its own Storage Spaces Direct storage pool, with Storage Replica providing replication between sites
- **SAN stretch cluster**: Uses shared or replicated SAN storage with vendor-specific replication technology

Both stretch cluster variants are designed for disaster recovery across metropolitan areas, providing geographic redundancy for critical workloads. They're well-suited for organizations with multiple data center locations or those with compliance requirements mandating off-site data protection.

For the cluster quorum, use a File Share Witness or Cloud Witness. The witness must be accessible from both sites to enable automatic failover and determine site majority during network partitions.

Stretch cluster topologies are more complex to configure and manage than single-site clusters. Higher latency between sites can impact synchronous replication performance, regardless of the storage architecture chosen.

### Storage Spaces Direct stretch cluster

In a Storage Spaces Direct stretch cluster configuration, each site operates its own independent Storage Spaces Direct storage pool. Storage Replica handles replication between sites, and you can configure it as synchronous or asynchronous depending on the distance and latency between locations.

The following diagram illustrates a Storage Spaces Direct stretch cluster topology with nodes and storage pools at each geographic site, connected via WAN.

:::image type="content" source="./media/topologies/storage-spaces-direct-stretch-cluster.png" alt-text="Diagram that shows a Storage Spaces Direct stretch cluster topology with nodes and storage pools at each geographic site." lightbox="./media/topologies/storage-spaces-direct-stretch-cluster.png":::


TODO: the only requirement is latency and performance, rather than topology

Network requirements differ based on replication mode. Synchronous replication requires [less than 5 ms round-trip latency](../storage/storage-replica/stretch-cluster-replication-using-shared-storage.md#prerequisites) over the WAN connection. This ensures good performance. Asynchronous replication can work with higher latency. However, asynchronous replication means you might lose more data during a failure (larger RPO). Both modes require a dedicated high-bandwidth WAN connection between sites, and each site should have a network path to the witness to ensure proper quorum management.

This configuration requires Windows Server Datacenter edition for Storage Replica functionality. Network bandwidth and reliability are critical for maintaining successful replication and cluster health.

### SAN stretch cluster

A SAN stretch cluster relies on the storage area network vendor's replication capabilities to maintain data synchronization between sites. The SAN handles replication at the storage layer, presenting replicated LUNs to cluster nodes at both sites.

The following diagram illustrates a SAN stretch cluster topology with replicated SAN storage at each geographic site, connected via WAN.

:::image type="content" source="./media/topologies/storage-area-network-stretch-cluster.png" alt-text="Diagram that shows a SAN stretch cluster topology with replicated SAN storage at each geographic site." lightbox="./media/topologies/storage-area-network-stretch-cluster.png":::

When implementing a SAN stretch cluster, review the SAN vendor's interoperability requirements and supported configurations. Different SAN vendors have varying requirements for network latency, bandwidth, and configuration parameters. Ensure your SAN solution is validated for stretch cluster scenarios and meets your specific disaster recovery objectives.

SAN stretch clusters require careful coordination with storage administrators and adherence to vendor-specific best practices for replication configuration, failover procedures, and monitoring.

## Multi-cluster topology

Multi-cluster topology involves deploying multiple independent failover clusters that work together through application-level replication or coordination. This topology differs fundamentally from a single stretched cluster. In this approach, two or more independent failover clusters each operate autonomously, with application-level replication between clusters and no shared quorum or cluster resources.

The following diagram illustrates a multi-cluster topology with two independent SQL  clusters at separate geographic sites, connected via WAN and replicated at the application layer.

:::image type="content" source="./media/topologies/multi-cluster.png" alt-text="Diagram that shows a multi-cluster topology with two independent failover clusters at separate sites." lightbox="./media/topologies/multi-cluster.png":::

Clusters replicate data between each other using methods such as:

- SQL Server Always On Availability Groups for database workloads
- File-based copying for storage workloads
- Custom sync tools designed for specific applications

This topology works well for:

- Large-scale deployments that require isolation between clusters
- Environments with different administrative boundaries or security zones
- Active-active setups where you distribute load across sites
- Scenarios that demand maximum separation between sites

You can manage each cluster independently, and a failure in one cluster doesn't affect the quorum of other clusters. This architecture provides flexibility in cluster configurations and versions. It allows clusters to span greater distances using asynchronous replication without the constraints of a single cluster's quorum requirements.

However, multi-cluster deployments require careful planning. The approach depends on application support for cross-cluster replication. It involves more complex operational procedures than single-cluster topologies. It might require application-level orchestration for failover scenarios. Monitoring must comprehensively cover multiple cluster environments to ensure overall system health and performance.

## Choosing the right topology

You need to carefully consider multiple factors across business, infrastructure, workload, and operational dimensions when selecting the appropriate failover cluster topology.

From a business perspective, start by defining your Recovery Time Objective (RTO) - how quickly services must be restored after a failure - and your Recovery Point Objective (RPO) - how much data loss is acceptable to your organization. These metrics directly influence topology selection. Additionally, consider your budget for hardware, networking, and licensing, as more resilient topologies typically require greater investment. Compliance and regulatory requirements might mandate specific configurations, such as geographically separated data centers or specific data protection standards.

Infrastructure factors also shape your decision. Consider the number and location of data centers or rooms you have access to. Evaluate network links and latency between sites. Review existing storage systems that you can reuse. Assess power and cooling backup at each location. A campus with two nearby buildings connected by fiber supports different topologies than distant data centers.

A campus with two nearby buildings connected by fiber supports different topologies than geographically distant data centers.

Workload characteristics play a crucial role in topology selection. Evaluate your applications' I/O patterns and performance requirements, as latency-sensitive workloads might not tolerate the overhead of geographic replication.

Consider how much storage you need, how much network bandwidth you have, and whether your workload can handle delays. These factors help you decide between synchronous and asynchronous replication.

Finally, don't overlook operational considerations. Assess your IT team's expertise and available resources, as more complex topologies require deeper technical knowledge. 

Think about how to manage and monitor the cluster. Consider how often you need to test disaster recovery. Review your options for maintenance windows and upgrade schedules.

A topology that looks ideal on paper might prove difficult to operate if it exceeds your team's capabilities or available resources.

## Related content

- [Overview of Azure Local rack aware clustering (Preview)](/azure/azure-local/concepts/rack-aware-cluster-overview)
- [Storage Spaces Direct overview](../storage/storage-spaces/storage-spaces-direct-overview.md)
- [Failover Clustering](failover-clustering-overview.md)
