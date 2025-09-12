---
title: Recover a failover cluster without quorum in Windows Server
description: How to recover a failover cluster without quorum in a disaster recovery scenario in Windows Server.
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 03/27/2025
---

# Recover a failover cluster without quorum

Recovering a failover cluster without quorum is a critical skill as it enables you to swiftly restore services and minimize downtime if quorum is lost. Quorum is essential for the proper functioning of a failover cluster, as it prevents split-brain scenarios and ensures consistent data integrity. Without quorum, the cluster can't make authoritative decisions, leading to service interruptions. By following these guidelines, administrators can enhance their system's resilience and maintain continuous, reliable operations, even in the face of unexpected challenges.

A cluster that doesn't have enough quorum votes doesn't start. As a first step, you should always confirm the cluster quorum configuration and investigate why the cluster no longer has quorum. This might happen if you have nodes that stopped responding, or if the primary site isn't reachable in a multisite cluster. After you identify the root cause for the cluster failure, you can use the recovery steps described in this section.

> [!NOTE]
>
> - If the Cluster service stops because quorum is lost, [Event ID 1177](/previous-versions/troubleshoot/windows-server/failover-clustering-system-log-events#event-1177-mm_event_arbitration_failed) appears in the system log.
> - It's always necessary to investigate why the cluster quorum was lost.
> - It's always preferable to bring a node or quorum witness to a healthy state (join the cluster) rather than starting the cluster without quorum.

## Prerequisites

- Your device must be running Windows Server 2012 or later on all cluster nodes.
- The Failover Clustering feature must be installed on each node. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

  *Alternatively*, you can run the following command to install Failover Clustering:

  ```powershell
  Install-WindowsFeature -Name Failover-Clustering -IncludeManagementTools
  ```

- You must be a member of the Administrators or Domain Admins group.

- Shared storage that is accessible by all nodes in the cluster, such as Network Attached Storage (NAS) or Storage Area Network (SAN).

## Force start cluster nodes

After you determine that you can't recover your cluster by bringing the nodes or quorum witness to a healthy state, forcing your cluster to start becomes necessary. Forcing the cluster to start overrides your cluster quorum configuration settings and starts the cluster in **ForceQuorum** mode.

To force the cluster node to start without quorum, run the following command in an elevated PowerShell window:

```powershell
Start-ClusterNode -ForceQuorum
```

Forcing a cluster to start when it doesn't have quorum might be especially useful in a multisite cluster. Consider a disaster recovery scenario with a cluster that contains separately located primary and backup sites such as *SiteA* and *SiteB*. If there's a genuine disaster at *SiteA*, it could take a significant amount of time for the site to come back online. You would likely want to force *SiteB* to come online, even though it doesn't have quorum.

When a cluster is started in **ForceQuorum** mode, and after it regains sufficient quorum votes, the cluster automatically leaves the forced state, and it behaves normally. Hence, it isn't necessary to start the cluster again normally. If the cluster loses a node and it loses quorum, it goes offline again because it's no longer in the forced state. To restore a cluster where quorum is lost, you must force it to start without quorum.

> [!NOTE]
>
> - Once a cluster is force started, the administrator takes complete control over its operations.
> - When the cluster is force started on a specific node, it uses the configuration from that node and replicates it to all other reachable nodes.
> - If you force the cluster to start without quorum, all quorum configuration settings are ignored while the cluster remains in **ForceQuorum** mode. Node vote assignments and dynamic quorum management settings are essential considerations for configuring failover clusters effectively.

## Prevent quorum on cluster nodes

After you have force started the cluster on a node, it's necessary to start any remaining nodes in your cluster with a setting to prevent quorum. A node started with a setting that prevents quorum indicates to the Cluster service to join an existing running cluster instead of forming a new cluster instance. This prevents the remaining nodes from forming a split cluster that contains two competing instances.

This becomes necessary when you need to recover your cluster in multisite disaster recovery scenarios after you have force started the cluster on your backup site, *SiteB*. To join the force started cluster in *SiteB*, the nodes in your primary site, *SiteA*, need to be started with the quorum prevented.

Recovering the cluster can be performed using the Failover Cluster Manager or PowerShell in an elevated window.

> [!IMPORTANT]
> After a cluster is force started on a node, we recommend that you always start the remaining nodes with quorum prevented.

# [Failover Cluster Manager](#tab/failover)

1. In **Server Manager**, select tools, then select **Failover Cluster Manager**.

   *Alternatively*, select **Start**, type **Failover Cluster Manager** and select it.

1. In the left pane, select the cluster you want to recover.

   To specify a cluster, in the right pane under **Actions**, select **Connect to Cluster**. Type the cluster name and then select **OK**.

1. In the right pane under **Actions**, select **Force Cluster Start**, then select **Yes**.

If you select **Start Cluster Service** instead of **Force Cluster Start**, the node is automatically started with the setting that prevents quorum.

# [PowerShell](#tab/powershell)

To force start the cluster on node ContosoNode1 without quorum, run the following command:

```PowerShell
Start-ClusterNode –Node "ContosoNode1" –ForceQuorum
```

To force start the cluster on node ContosoNode1 and prevent quorum, run the following command:

```PowerShell
Start-ClusterNode –Node "ContosoNode1" –PreventQuorum
```

To retrieve information about the quorum configuration, run the following command:

```PowerShell
Get-ClusterQuorum
```

To retrieve detailed information about a specific node, such as ContosoNode1, run the following command:

```PowerShell
Get-ClusterNode -Name "ContosoNode1" | Format-List *
```

---

## Quorum considerations for disaster recovery configurations

This section summarizes characteristics and quorum configurations for two multisite cluster configurations in disaster recovery deployments. The quorum configuration guidelines differ depending on if you need automatic failover or manual failover for workloads between the sites. Your configuration typically aligns with the service level agreements (SLAs) established in your organization. These SLAs define the expectations for providing and supporting clustered workloads during site failures or disasters.

# [Automatic failover](#tab/autofailover)

In this configuration, the cluster consists of two or more sites that can host clustered roles. If a failure occurs at any site, the clustered roles are expected to automatically fail over to the remaining sites. Therefore, the cluster quorum must be configured so that any site can sustain a complete site failure.

The following table summarizes considerations and recommendations for this configuration.

| Item | Description |
|--|--|
| Dynamic quorum management | Should be enabled |
| Number of node votes per site | Should be equal |
| Node vote assignment | Node votes shouldn't be removed because all nodes are equally important |
| Witness configuration | File share witness is recommended, configured in a site that is separate from the cluster sites |
| Workloads | Workloads can be configured on any of the sites |

Configuring the file share witness in a separate site is necessary to give each site an equal opportunity to survive.

# [Manual failover](#tab/manualfailover)

In this configuration, the cluster consists of a primary site, *SiteA*, and a backup (recovery) site, *SiteB*. Clustered roles are hosted on *SiteA*. Because of the cluster quorum configuration, if a failure occurs at all nodes in *SiteA*, the cluster stops functioning. In this scenario, the administrator must manually fail over the cluster services to *SiteB* and perform additional steps to recover the cluster.

The following table summarizes considerations and recommendations for this configuration.

| Item | Description |
|--|--|
| Dynamic quorum management | Should be enabled |
| Number of node votes per site | <ul><li>Node votes shouldn't be removed from nodes at the primary site, **SiteA**</li><li>Node votes should be removed from nodes at the backup site, **SiteB**</li><li>If a long-term outage occurs at **SiteA**, votes must be assigned to nodes at **SiteB** to enable a quorum majority at that site as part of recovery</li></ul> |
| Witness configuration | <ul><li>Configure a witness if there's an even number of nodes at **SiteA**</li><li>If a witness is needed, configure either a file share witness or a disk witness that is accessible only to nodes in **SiteA** (sometimes called an asymmetric disk witness)</li></ul> |
| Workloads | Use preferred owners to keep workloads running on nodes at **SiteA** |

Only the nodes at *SiteA* are initially configured with quorum votes, which is necessary to ensure that the state of nodes at *SiteB* doesn't affect the cluster quorum. Recovery steps can vary depending on if *SiteA* sustains a temporary failure or a long-term failure.

---

## See also

- [Failover Clustering](failover-clustering-overview.md)

- [Failover Clusters Windows PowerShell cmdlets](/powershell/module/failoverclusters/)

