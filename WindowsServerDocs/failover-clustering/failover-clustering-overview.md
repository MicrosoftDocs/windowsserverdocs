---
title: Failover Clustering
description: Learn more about Failover Clustering in Windows Server and Azure Local.
ms.topic: overview
author: robinharwood
ms.author: roharwoo
ms.date: 06/25/2025
---

# Failover Clustering in Windows Server and Azure Local

Failover clustering is a powerful strategy to ensure high availability and uninterrupted operations in critical environments. It involves a configuration of independent computers, known as nodes, which work together to enhance the availability and scalability of applications and services, now referred to as clustered roles. These nodes are interconnected through both physical cabling and software.

If a failure occurs in one or more nodes, the remaining nodes automatically take over the workload, a process called failover, minimizing disruptions. Additionally, the health of clustered roles is continuously monitored. If any issues are detected, the roles are either restarted or migrated to another node to maintain seamless operation. This proactive approach ensures that services remain consistently available, even if hardware or software failures occur.

Networking is a crucial role in failover clusters by enabling reliable communication and efficient data exchange among cluster nodes and with external clients. Clusters often employ dedicated private networks for internal functions such as heartbeat signals and cluster management, while separate public networks handle client access and application data. This network separation enhances performance and security by isolating critical cluster traffic from external disruptions. It also increases fault tolerance, ensuring that internal cluster operations remain uninterrupted and that client connections maintain high availability during failover events.

The cluster's health is continuously monitored through heartbeat signals, which help detect any issues. If a problem arises, the system can automatically initiate a failover to maintain service continuity. To protect sensitive data and meet organizational standards, failover clusters incorporate robust security measures such as encryption to secure data both in transit and at rest. They also use granular access control to manage permissions and access rights effectively.

To learn more about failover clustering in Azure Local, see [Understanding cluster and pool quorum](/azure/azure-local/concepts/quorum?context=/windows-server/context/windows-server-failover-clustering).

## Active and passive failover configuration

Failover clusters can be set up in two primary configurations, active-active and active-passive. Each configuration has its own trade-offs, with active-active focusing on performance and resource efficiency, while active-passive emphasizes simplicity and reliability in failover scenarios. The choice depends on specific organizational needs and the criticality of applications being clustered.

| **Configuration** | **Operation** |
|--|--|
| Active | In an active-active failover cluster, all nodes are active and work together simultaneously to balance the workload across the cluster. This configuration distributes tasks, processing power, or services among all available nodes, making efficient use of resources. Here’s how it works: <br><br><li> **Load balancing:** Each node handles a portion of the total workload, enhancing performance and ensuring that no single node becomes a bottleneck. This equal distribution can improve responsiveness and throughput, as multiple nodes are servicing requests concurrently. <li> **Resource utilization:** An active-active setup maximizes resource utilization since all nodes are operational and contributing to the cluster’s performance. This setup is ideal for environments where maximizing available resources is critical. <li> **Fault tolerance:** If one node fails, the remaining nodes in the cluster can continue to handle the workload. The loss of a node might temporarily reduce overall capacity, but the system remains operational without service disruptions. </li> |
| Passive | In an active-passive failover cluster, some nodes are designated as active while others are on standby, ready to take over if an active node fails. Here’s how it works: <br><br><li> **Standby nodes:** The passive nodes are essentially in a "waiting" state, not handling any tasks or services during normal operations. These nodes are primed to take over responsibilities should an active node experience a failure. <li> **Failover process:** When a failure is detected, a standby node is activated to assume the responsibilities of the failed node. This involves quickly bringing the passive node online to ensure continuity of services. <li> **Resource allocation:** Active-passive configurations might not make full use of available hardware resources during normal operations since standby nodes remain idle. However, this setup can be simpler to manage and might ensure predictable performance under certain conditions. <li> **Simplicity and reliability:** An active-passive setup can be advantageous for applications where stability and predictability are more important than maximizing operational efficiency. It's often easier to implement and maintain compared to an active-active configuration. </li> |

## Failover Clustering functionalities

Failover clustering provides a comprehensive set of functionalities designed to maximize uptime, ensure data integrity, and streamline management of critical workloads. These features enable organizations to maintain service continuity, efficiently manage resources, and quickly recover from hardware or software failures. Some functionalities offered by failover clustering include:

- **Cluster nodes and quorum:**

  Cluster nodes collaborate to maintain what is known as a quorum, which is essentially the minimum number of votes from cluster members required for the cluster to function correctly. This mechanism prevents split-brain scenarios, where split portions of a cluster might try to operate independently, potentially causing inconsistencies. Quorum models, such as Node Majority, Node and Disk Majority, Node and File Share Majority, and No Majority (Disk Only), determine how votes are assigned and counted. For instance, Node Majority assigns each node a vote, while Node and Disk Majority incorporate additional votes from either a disk or a file share.

- **Storage configuration:**

  A notable feature of failover clusters is the Cluster Shared Volume (CSV), which allows multiple nodes to access the same storage concurrently, enabling smooth disk management and coordination without performance loss. CSVs are an integral part of storage configurations in failover clusters. CSVs facilitate efficient disk access, allowing nodes to handle storage tasks collaboratively.

- **Proactive monitoring and management:**

  Failover clusters employ heartbeat signals as a means of monitoring the health of nodes and their roles. These signals help detect issues such as node failures or service disruptions. When  such issues are detected, the system can automatically initiate failover procedures, ensuring continuity and minimizing downtime.

- **Security and compliance:**

  Security is a vital aspect of failover clusters, incorporating features like encryption and access control to protect data and cluster operations. Clusters help organizations meet compliance requirements for critical applications by ensuring secure data handling and reliable system performance. This makes them suitable for environments requiring stringent data protection and regulatory adherence.

- **Use cases:**

  Failover clustering has several practical applications, including disaster recovery, load balancing, and high-performance computing. It supports critical applications by providing high availability, enabling businesses to maintain operations even in adverse conditions. For instance, in disaster recovery scenarios, clusters can quickly restore services by transferring operations to unaffected nodes.

  - Failover clustering ensures high availability or continuous availability for critical applications and services (clustered roles) running on physical servers or virtual machines. If a failure occurs, these roles can be quickly moved or restarted on another node, minimizing downtime and maintaining consistent performance and redundancy.

  - Applications such as Microsoft SQL Server and Hyper-V virtual machines benefit from failover clustering by experiencing minimal service interruptions, even during hardware or software failures.

## Failover Clustering resources

This curated table of resources is designed to help you understand, plan, deploy, and manage failover clustering effectively.

| **Understand** | **Planning** | **Deployment** |
|--|--|--|
| [What's new in Failover Clustering](whats-new-in-failover-clustering.md) | [Planning Failover Clustering Hardware Requirements and Storage Options](clustering-requirements.md) | [Creating a Failover Cluster](create-failover-cluster.md) |
| [Scale-Out File Server for application data](sofs-overview.md) | [Use Cluster Shared Volumes (CSVs)](failover-cluster-csvs.md) | [Deploy a two-node file server](deploy-two-node-clustered-file-server.md) |
| [Cluster and pool quorum](/azure/azure-local/concepts/quorum?context=/windows-server/context/windows-server-failover-clustering) | [Using guest virtual machine clusters with Storage Spaces Direct](../storage/storage-spaces/storage-spaces-direct-in-vm.md) | [Prestage cluster computer objects in Active Directory Domain Services](prestage-cluster-adds.md) |
| [Fault domain awareness](fault-domains.md) | | [Configuring cluster accounts in Active Directory](configure-ad-accounts.md) |
| [Simplified SMB Multichannel and multi-NIC cluster networks](smb-multichannel.md) | | [Recover a failover cluster without quorum](recover-failover-cluster-without-quorum.md) |
| [VM load balancing](/azure/azure-local/manage/vm-load-balancing) | | [Deploy a quorum witness](deploy-quorum-witness.md) |
| [Cluster sets](/windows-server/failover-clustering/cluster-set) | | [Cluster operating system rolling upgrades](cluster-operating-system-rolling-upgrade.md) |
| [Cluster affinity](cluster-affinity.md) | | [Upgrading a failover cluster on the same hardware](upgrade-option-same-hardware.md) |
| | | [Deploy an Active Directory Detached Cluster](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn265970\(v%3dws.11\)) |

| **Manage** | **Tools and settings** | **Community resources** |
|--|--|--|
| [Cluster-Aware Updating](cluster-aware-updating.md) | [Failover Clustering PowerShell Cmdlets](/powershell/module/failoverclusters/) | [Failover Cluster Forum](https://www.microsoft.com/windows-server/blog/tag/failover-cluster) |
| [Health Service](health-service-overview.md) | [Cluster Aware Updating PowerShell Cmdlets](/powershell/module/clusterawareupdating/) | [Failover Clustering Blog](https://techcommunity.microsoft.com/category/windows-server/blog/failoverclustering) |
| [Cluster-domain migration](cluster-domain-migration.md) | | |
| [Troubleshooting using Windows Error Reporting](troubleshooting-using-wer-reports.md) | | |

