---
title: Failover Clustering topology overview
description: Learn about the different failover cluster topologies available in Windows Server, including single rack, campus, stretch, and multi-cluster configurations.
author: robinharwood
ms.author: roharwoo
ms.service: windows-server
ms.topic: concept-article
ms.date: 12/19/2025
ai-usage: ai-assisted
#CustomerIntent: As a IT administrator, I want to understand the different failover cluster topologies so that I can choose the right configuration for my business requirements.
---

# Failover Clustering topology overview

Windows Server Failover Clustering supports multiple deployment topologies to meet different business requirements for high availability and disaster recovery. The topology you choose depends on factors such as your physical infrastructure, network latency requirements, budget constraints, and recovery objectives. Understanding these topologies helps you design the right solution for your workloads.

## Topologies

Windows Server Failover Clustering supports several topologies, each with its own advantages and trade-offs. The main topologies include:

- Single rack failover cluster
<!-- I wonder if this should be single location (then it can be same rack, or row, or room, but predicated on same L2 LAN -->
- Campus cluster
- Stretch cluster
- Multi-cluster topology

The following sections provide an overview of each topology, including their use cases, benefits, and limitations.

## Topology comparison

The following table compares key characteristics of each failover clustering topology:

| Characteristic | Single Rack | Campus Cluster | Stretch Cluster | Multi-Cluster |
|---|---|---|---|---|
| **Geographic scope** | Single rack | Same physical location | Separate geographic sites | Multiple separate sites |
| **Network type** | LAN | LAN | WAN | Determined by workload requirement |
| **Typical latency** | <1 ms | ≤1 ms | <5 ms (sync)<br/>Variable (async) | Variable (workload determined) |
| **Storage configuration** | Single pool (SAN/NAS/S2D) | Single S2D pool spanning racks | Separate S2D pools per site | Independent storage per cluster |
| **Storage replication method** | None | S2D Rack Level Nested Mirror | Storage Replica | Application-level |
| **Fault domains** | Nodes only | 2 racks | 2 sites | Independent clusters |
| **Protects against** | Node failure | Node + rack failure | Node + rack + site failure | Site + cluster failure |
| **Deployment complexity** | Low | Medium | High | Very High |
| **Primary use case** | Single datacenter HA | Campus/multi-building HA | Metro-area DR | Multi-region DR |

## Single rack failover cluster

A single rack failover cluster places all cluster nodes within a single physical rack, typically in the same data center room. This topology is the most common and straightforward failover cluster topology. All nodes are located in one rack, with shared storage that can be SAN, NAS, Storage Spaces Direct (S2D), or S2D with SAN coexistence. This configuration provides node-level redundancy and protection against individual server failures while maintaining the lowest network latency between nodes.

This topology is ideal for single data center deployments, workloads that require high performance with minimal latency, organizations with limited physical infrastructure, and development and test environments. It's the simplest configuration to deploy and manage, making it an excellent starting point for many organizations.

However, the single rack approach has important limitations. It provides no protection against rack-level failures such as power distribution issues or top-of-rack switch failures. It also offers no protection against data center or site-level disasters. The rack infrastructure itself represents a single point of failure that organizations must accept when choosing this topology.

## Campus cluster

A campus cluster is a two-rack configuration within the same physical location—such as a factory, hospital, college campus, or datacenter—connected by low-latency local area network (LAN) infrastructure. Campus clusters provide rack-level resiliency using Storage Spaces Direct (S2D) with either two-copy or four-copy volumes, known as Rack Level Nested Mirror (RLNM). This approach means data is intelligently distributed across racks. The topology is designed to protect against rack-level failures while maintaining low latency between nodes.

Campus clusters requires Windows Server 2025 with the December cumulative update installed ([KB5072033](https://support.microsoft.com/en-gb/topic/december-9-2025-kb5072033-os-build-26100-7462-fca31d8d-5fe8-4b5e-9591-6641ef1d26a1)). Campus clusters only supports two rack fault domains within the same physical location connected by LAN. This differs significantly from stretch clusters, which span geographically separated sites connected by WAN and use Storage Replica for replication between sites. This topology provides rack-level resiliency for Hyper-V VMs, SQL Server FCI, File Servers, SAP, and other applications.

This configuration requires exactly two rack fault domains defined in the cluster, with a single Storage Spaces Direct (S2D) storage pool spanning both racks. All flash storage (SSD or NVMe) is required—HDDs aren't supported. The Rack Level Nested Mirror (RLNM) feature ensures data copies are intelligently distributed across racks: two-copy volumes place one copy in each rack, while four-copy volumes place two copies in each rack. The recommended 2+2 configuration (two nodes per rack) with four-copy volumes provides rack and node resiliency, meaning the cluster can survive losing an entire rack and a node simultaneously.

From a networking perspective, the campus cluster uses LAN connectivity and works best with 1 ms latency or less between racks. RDMA NICs and switches are recommended as they can achieve 30% CPU savings. The configuration requires two strands of dark fiber cable between racks, with redundant top-of-rack (TOR) switches recommended to avoid single points of failure. Each rack should ideally have a separate network path to the cluster quorum resource.

This topology is well-suited for campus environments including factories, business parks, hospitals, school and college campuses, vessels and cruise ships, and stadiums. It's also ideal for organizations meeting NIS2 requirements for separate data rooms, or any location with two buildings or rooms connected by fiber. The configuration supports 1+1, 2+2, 3+3, 4+4, and 5+5 node distributions (nodes per rack), with the 2+2 configuration recommended for balanced cost and resiliency.

For quorum, place the witness resource (File Share Witness, Disk Witness, Cloud Witness, or USB Witness) in a third location, separate from the two racks.

## Stretch Cluster

A stretch cluster, also known as a geo-cluster or multi-site cluster, extends a failover cluster across two geographically separated physical sites connected by high-speed wide area network (WAN) infrastructure. This topology provides site-level disaster recovery capability by maintaining complete, independent infrastructure at each location. The key distinction from a campus cluster is that stretch clusters span separate geographic locations connected via WAN, whereas campus clusters use LAN connectivity within a single location. Each site maintains its own Storage Spaces Direct storage pool, with Storage Replica providing replication between sites. You can configure the replication as synchronous or asynchronous depending on the distance and latency between locations.

Network requirements differ based on replication mode. Synchronous replication typically requires [less than 5 ms round-trip latency](../storage/storage-replica/stretch-cluster-replication-using-shared-storage.md#prerequisites) over the WAN connection to maintain performance, while asynchronous replication can tolerate higher latency at the cost of a larger recovery point objective. Both modes require a dedicated high-bandwidth WAN connection between sites, and each site should have a network path to the witness to ensure proper quorum management.

This topology is designed for disaster recovery across metropolitan areas, providing geographic redundancy for critical workloads. It's well-suited for organizations with multiple data center locations or those with compliance requirements mandating off-site data protection. For quorum, a File Share Witness or Cloud Witness is recommended, as the witness must be accessible from both sites to enable automatic failover and determine site majority during network partitions.

The stretch cluster topology is more complex to configure and manage than single-site clusters. Higher latency between sites can impact synchronous replication performance, and the configuration requires Windows Server Datacenter edition for Storage Replica functionality. Network bandwidth and reliability are critical for maintaining successful replication and cluster health.

## Multi-cluster topology

Multi-cluster topology involves deploying multiple independent failover clusters that work together through application-level replication or coordination. This topology differs fundamentally from a single stretched cluster. In this approach, two or more independent failover clusters each operate autonomously, with application-level replication between clusters and no shared quorum or cluster resources.

Clusters replicate data between each other using methods such as:

- SQL Server Always On Availability Groups for database workloads
- File-based copying for storage workloads
- Custom sync tools designed for specific applications

This topology works well for:

- Large-scale deployments that require isolation between clusters
- Environments with different administrative boundaries or security zones
- Active-active setups where you distribute load across sites
- Scenarios that demand maximum separation between sites

Each cluster can be managed independently, and a failure in one cluster doesn't affect the quorum of other clusters. This architecture provides flexibility in cluster configurations and versions, and allows clusters to span greater distances using asynchronous replication without the constraints of a single cluster's quorum requirements.

However, multi-cluster deployments require careful planning. The approach depends on application support for cross-cluster replication, involves more complex operational procedures than single-cluster topologies, and might require application-level orchestration for failover scenarios. Monitoring must comprehensively cover multiple cluster environments to ensure overall system health and performance.

## Choosing the right topology

You need to carefully consider multiple factors across business, infrastructure, workload, and operational dimensions when selecting the appropriate failover cluster topology.

From a business perspective, start by defining your Recovery Time Objective (RTO) - how quickly services must be restored after a failure - and your Recovery Point Objective (RPO) - how much data loss is acceptable to your organization. These metrics directly influence topology selection. Additionally, consider your budget for hardware, networking, and licensing, as more resilient topologies typically require greater investment. Compliance and regulatory requirements might mandate specific configurations, such as geographically separated data centers or specific data protection standards.

Infrastructure factors also shape your decision. Consider the number and location of data centers or rooms you have access to. Evaluate network links and latency between sites. Review existing storage systems that you can reuse. Assess power and cooling backup at each location. A campus with two nearby buildings connected by fiber supports different topologies than distant data centers.

A campus with two nearby buildings connected by fiber supports different topologies than geographically distant data centers.

Workload characteristics play a crucial role in topology selection. Evaluate your applications' I/O patterns and performance requirements, as latency-sensitive workloads might not tolerate the overhead of geographic replication.

Consider how much storage you need, how much network bandwidth you have, and whether your workload can handle delays. These factors help you decide between synchronous and asynchronous replication.

Finally, don't overlook operational considerations. Assess your IT team's expertise and available resources, as more complex topologies require deeper technical knowledge. 

Think about how you'll manage and monitor the cluster. Consider how often you need to test disaster recovery. Review your options for maintenance windows and upgrade schedules.

A topology that looks ideal on paper might prove difficult to operate if it exceeds your team's capabilities or available resources.

## Related content

- [Overview of Azure Local rack aware clustering (Preview)](/azure/azure-local/concepts/rack-aware-cluster-overview?view=azloc-2511)
- [Storage Spaces Direct overview](../storage/storage-spaces/storage-spaces-direct-overview.md)
- [Failover Clustering](failover-clustering-overview.md)
