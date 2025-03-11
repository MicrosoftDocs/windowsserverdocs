---
title: DHCP failover in Windows Server
description: Learn how DHCP Failover replicates IP address leases and settings in DHCP scopes from a primary DHCP server to a failover partner server.
ms.topic: concept-article
author: meaghanlewis
ms.author: mosagie
ms.date: 03/11/2025
---

# DHCP failover overview

DHCP failover is a feature that enables two Microsoft DHCP servers to share service availability information with each other, providing DHCP high availability. DHCP failover works by replicating IP address leases and settings in one or more DHCP scopes from a primary DHCP server to a failover partner server.

All scope information is shared between the two DHCP servers, including active leases. This enables either DHCP server to assume responsibility for DHCP clients if the other server becomes unavailable.

This article provides an overview of DHCP failover.

## Introduction to DHCP failover

With DHCP failover, DHCPv4 scopes are replicated from a primary DHCP server to a partner DHCP server, enabling redundancy and load balancing of DHCP services. DHCP servers that share a failover-enabled DHCP scope are called **failover partners**. Microsoft’s implementation of DHCP failover is based on the [Internet Engineering Task Force (IETF) DHCP Failover Protocol draft](https://datatracker.ietf.org/doc/html/draft-ietf-dhc-failover-12).

When two DHCP servers are configured for failover, they share scope information, including all active leases. This enables both DHCP servers to provide leases to the same subnet for load balancing or redundancy purposes. Scope settings are replicated when you first configure DHCP failover, and can be replicated again later if configuration changes are made.

The following figure illustrates how components and settings for a failover-enabled DHCP scope are shared between two DHCP servers.

![Diagram of DHCP failover.](media/dhcp-failover-diagram.png)

The scopes and settings used with DHCP servers that are configured for DHCP failover are shared using a new object called the **DHCP failover relationship**. For more information, see [DHCP Failover Relationships](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/dn338986(v=ws.11)).

Several configuration options are available with DHCP failover. You can configure failover on all scopes that exist on a DHCP server, or only on some scopes. You can also easily use the same DHCP failover settings for many scopes by adding them to the same failover relationship. A failover relationship is always between only two DHCP servers. However, a server can have many failover relationships, and each failover relationship can be with a different DHCP server.

> [!IMPORTANT]
> If changes are made to a failover-enabled scope, you must manually replicate these changes to the partner server in order to synchronize scopes on both DHCP servers. Replication copies scope settings from the DHCP server where replication is initiated to the partner server, overwriting settings on the partner server. Therefore, it's important to always initiate replication from the server that has DHCP scope settings you wish to use.

## DHCP failover specifications

The following specifications apply to DHCP failover:

- You can't configure DHCP failover on a DHCP scope to include more than two DHCP servers.

- DHCP failover supports DHCPv4 scopes only. DHCPv6 scopes can't be failover-enabled.

- DHCP failover partners must both be running at least Windows Server 2016.

- DHCP failover can be configured, and settings can be modified without the need to pause, stop, or restart the DHCP Server service.

- If parameters of a failover-enabled scope are modified, these settings must be manually replicated to the partner DHCP server.

- Replication of scope settings can be initiated from either DHCP server to it's failover partner server.

- Clustered DHCP is supported in conjunction with DHCP failover. For purposes of failover, a DHCP cluster is considered a single DHCP server.

- DHCP clients must be able to communicate with both DHCP failover partner servers, either directly or using a DHCP relay.

- DHCP servers configured as failover partners can be located on different subnets, but this isn't required.

- When DHCP failover is enabled on a DHCP scope, the DHCP server that renews a DHCP client lease can be different from the DHCP server that initially granted the lease.

- Two DHCP servers configured as failover partners attempt to maintain a persistent TCP/IP connection.

- Two separate, synchronized client lease databases are maintained independently by each DHCP failover partner server.

- DHCP servers configured as failover partners are both aware of the status of the DHCP service on the other server, and are informed of any change in that status with minimal delay.

- If two DHCP servers configured as failover partners are unable to communicate, precautions are taken to avoid the same IP address lease being issued to two different DHCP clients.

- If a DHCP server becomes unavailable before it's able to successfully synchronize all DHCP client information with its failover partner, precautions are taken to ensure DHCP lease continuity for DHCP clients.

> [!IMPORTANT]
> When replicating settings between DHCP failover partner servers that have different operating system versions, always modify settings and initiate replication from the DHCP server with the more recent operating system version. This ensures that settings are recognized by both failover partners and replicated consistently.

You can configure DHCP failover can be configured using Server Manager or Windows PowerShell. For information about using Windows PowerShell, see [DHCP Server Cmdlets in Windows PowerShell](/powershell/module/dhcpserver/). For instructions to configure DHCP in Server Manager, see this [step-by-step guide](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/hh831385(v=ws.11)).

## DHCP failover and IPv6

DHCP failover isn't supported for Internet Protocol version 6 (IPv6) scopes. Network adapters using IPv6 typically determine their own IPv6 address using stateless IP auto-configuration. In this mode, the DHCP server delivers only the DHCP option configuration, and the server does not maintain any lease state information. A high availability deployment for stateless DHCPv6 is possible by simply setting up two servers with identical option configuration. Even in a stateful DHCPv6 deployment, the scopes do not run under high address utilization, which makes split scope a viable solution for high availability.

## DHCP failover and Windows Failover Clustering

DHCP failover is supported with clustered DHCP in the following configurations:

- A single DHCP server can have a failover relationship with a DHCP failover cluster.

- A DHCP failover cluster can have a failover relationship with another DHCP failover cluster.

In both cases, you must configure DHCP failover to use the name or IP address of the cluster, not the name or IP address of an cluster node. If an individual cluster node is configured as the failover partner, the primary server will enter a communications interrupted state if the DHCP Server service moves to a different node in the cluster.

> [!IMPORTANT]
> If you use a shared secret, you must manually replicate the shared secret to all cluster nodes. See the following procedure for more information.

## Replicate a shared secret on DHCP failover cluster nodes

1. On the Server Manager menu, select Tools and then select Failover Cluster Manager.

1. In Failover Cluster Manager, determine the currently active node. To determine the active node, you can click on each node under Nodes until you see the DHCP Server role with a status of Running. You can also type the following command at a Windows PowerShell prompt:

    ```powershell
    Get-ClusterResource –Name dhcp1.contoso.com | select OwnerNode
    ```

    In this example, the cluster name is **dhcp1.contoso.com**. Output from this command will be the name of the currently active node.

1. On the currently active cluster node, type the following command at an elevated Windows PowerShell prompt, and then press ENTER.

    ```powershell
    Set-DhcpServerv4Failover –Name "dhcp1.contoso.com"  -SharedSecret "123"
    ```

    In this example, the cluster name is dhcp1.contoso.com and the shared secret is 123.

1. Next, move the DHCP Server role to another node. To move a role, select Action on the Failover Cluster Manager menu, point to Move, and then click Select Node.

1. In the Move Clustered Role dialog box, select a node under Cluster nodes and then select OK.

1. Repeat steps 3-5 until you have set the shared secret on all nodes in the cluster.

The reason you must replicate the shared secret is because it's encrypted in the Windows Registry.

Windows Failover Clustering will automatically replicate registry parameters related to the DHCP Server service when it moves to a new node, but encryption of a shared secret is specific to each node. Therefore, each node can only decrypt a shared secret if it was configured on the same node.

## DHCP failover and DNS dynamic updates

If DHCP servers are configured to perform DNS dynamic updates on behalf of the client computer, both DHCP servers in a DHCP failover relationship must use the same DNS credentials to update DNS records. If the failover partner attempts to use different credentials to update DNS resource records, this update will fail.

The following steps describe how DNS dynamic updates might fail when a client computer uses a different DHCP server:

1. A Windows DHCP server performs a dynamic update on behalf of a DHCP client.

1. The DHCP server creates the client’s DNS name and becomes the owner of that name.

1. Now only the DHCP server itself can update the DNS records for the client’s name.

1. The original server fails and a second backup DHCP server comes online; now the second server can't update the client name because it isn't the name’s owner.

Also see [DNS Record Ownership and the DnsUpdateProxy Group](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd334715(v=ws.10)) for a discussion of this scenario.
