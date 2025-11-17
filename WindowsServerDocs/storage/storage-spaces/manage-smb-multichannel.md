---
title: Manage SMB Multichannel
description: Use this topic to use SMB Multichannel for increased throughput and network fault tolerance.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 04/17/2023
appliesto: [
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2025</a>",
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2022</a>",
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2019</a>",
            "✅ <a href=\"https://learn.microsoft.com/windows-server/get-started/windows-server-release-info\" target=\"_blank\">Windows Server 2016</a>",
            "✅ <a href=\"https://learn.microsoft.com/azure/azure-local/release-information-23h2\" target=\"_blank\">Azure Local 2311.2 and later</a>"
           ]
---

# Manage SMB Multichannel

SMB Multichannel is part of the Server Message Block (SMB) 3.0 protocol, which increases network performance and the availability of file servers.

SMB Multichannel enables file servers to use multiple network connections simultaneously. It facilitates aggregation of network bandwidth and network fault tolerance when multiple paths are available between the SMB 3.0 client and the SMB 3.0 server. This allows server applications to take full advantage of all available network bandwidth and makes them more resilient to network failures.

SMB Multichannel provides the following capabilities:

- **Increased throughput.** The file server can simultaneously transmit additional data by using multiple connections for high-speed network adapters or multiple network adapters.

- **Network fault tolerance.** When clients simultaneously use multiple network connections, the clients can continue without interruption despite the loss of a network connection.

- **Automatic configuration.** SMB Multichannel automatically discovers multiple available network paths and dynamically adds connections as necessary.

## Requirements for SMB Multichannel

Because SMB Multichannel is enabled by default, you do not have to install additional roles, role services, or features. The SMB client automatically detects and uses multiple network connections when the configuration is identified. However, SMB Multichannel has the following requirements:

- At least two computers that run Azure Local, Windows Server, or Windows 10 operating system.

- At least one of the following configurations:

    - Multiple network adapters

    - One or more network adapters that support Receive Side Scaling (RSS)

    - Multiple network adapters that are teamed (see [NIC teaming](#nic-teaming))

    - One or more network adapters that support remote direct memory access (RDMA)

## Configure SMB Multichannel

This section describes some configuration options for deploying SMB Multichannel using an array of network adapters. These configurations are only example configurations. There are many other possible configurations that are not included in this topic.

### Single RSS-capable network adapter

In this typical configuration, an SMB client and an SMB server are configured by using a single 10-gigabit Ethernet (10 GbE) network adapter. When SMB is deployed without SMB Multichannel, and if there is only one SMB session established, SMB creates a single TCP/IP connection. With only a single CPU core, this configuration inherently leads to congestion, especially when many small I/O operations are performed. Therefore, the potential for a performance bottleneck is significant.

Most current network adapters offer a capability called Receive Side Scaling (RSS), which enables multiple connections to automatically spread across multiple CPU cores. However, if you use a single connection, RSS cannot help. When you use SMB Multichannel with a RSS-capable network adapter, SMB creates multiple TCP/IP connections for that particular session. This configuration avoids a potential bottleneck on a single CPU core if many small I/O operations are required.

### Multiple network adapters

In this configuration, an SMB client and SMB server are configured by using multiple 10 GbE network adapters. When SMB is deployed without SMB Multichannel, and if there is only one SMB session established, SMB uses one of the available network adapters to create a single TCP/IP connection. In this scenario, it is not possible to aggregate the bandwidth of the multiple network adapters; for example, you cannot achieve 2 gigabits per second (Gbps) when you use two 1-GbE network adapters. There is also a potential for failure if the selected network adapter is disconnected or disabled.

When SMB is deployed with SMB Multichannel, SMB creates multiple TCP/IP connections for a single session with at least one or more connections per interface if the network adapters are RSS-capable. This configuration enables SMB to use the combined network adapter bandwidth that is available and makes it possible for the SMB client to continue without interruption if a network adapter fails.

### NIC teaming

Azure Local and Windows Server support the ability to combine multiple network adapters into one network adapter by using a feature called NIC teaming. Although a team always provides fault tolerance, when SMB is deployed without SMB Multichannel, SMB creates only one TCP/IP connection per team. This configuration leads to limitations in both the number of CPU cores that are engaged and the maximum use of the team bandwidth.

When SMB is deployed with SMB Multichannel, SMB creates multiple TCP/IP connections for a single session to achieve a better balance across CPU cores and better use of the available bandwidth. NIC teaming continues to offer the failover capability, which works faster than using SMB Multichannel by itself. We also recommend NIC teaming because it offers failover capabilities to other workloads that do not rely on SMB, because those workloads cannot benefit from the failover capabilities of SMB Multichannel.

If you’re using a dedicated set of network adapters for Storage Spaces Direct traffic, as is sometimes done with Azure Local, teaming these storage network adapters is strictly optional—it doesn’t provide any significant benefits or drawbacks.

>[!IMPORTANT]
>On Windows Server 2012 R2 and earlier, do not use NIC teaming if you intend to use the RDMA capabilities of the network adapters. On these operating systems, a team of RDMA-capable network adapters is always reported as non-RDMA capable because teaming disables the RDMA capability of the network adapter.

### Single or multiple RDMA-capable network adapters

SMB Multichannel detects the RDMA capabilities of network adapters, which enables the SMB Direct feature called SMB Direct over RDMA. Without SMB Multichannel, SMB uses regular TCP/IP connections with the RDMA-capable network adapters where all network adapters provide a TCP/IP stack that exists side-by-side with the new RDMA stack.

When SMB is deployed with SMB Multichannel, SMB detects the RDMA capability of a network adapter and creates multiple RDMA connections for that single session, with two RDMA connections per interface. This configuration enables SMB to take advantage of the high throughput, low latency, and low CPU utilization that is offered by the RDMA-capable network adapters. It also offers fault tolerance when you use multiple RDMA interfaces.

>[!IMPORTANT]
>After an RDMA connection is created, the TCP/IP connection for the original protocol negotiation is no longer used. However, that connection is maintained in case a different RDMA connection fails.

### SMB Multichannel, RDMA-capable network adapters, and NIC teaming compatibility

The following table summarizes the different capabilities that are available when you combine SMB Multichannel, RDMA (SMB Direct), and NIC teaming.

| Configuration                                           | Throughput | Fault tolerance for SMB | Fault tolerance for non-SMB | Lower CPU utilization |
|:-------------------------------------------------------:|:----------:|:-----------------------:|:---------------------------:|:---------------------:|
| Single network adapter (no RSS)                         | *          |                         |                             |                       |
| Multiple network adapters (no RSS)                      | **         | *                       |                             |                       |
| Multiple network adapters (no RSS) with NIC teaming     | **         | **                      | *                           |                       |
| Single network adapter with RSS                         | *          |                         |                             |                       |
| Multiple network adapters with RSS                      | **         | *                       |                             |                       |
| Multiple network adapters with RSS and NIC teaming      | **         | **                      | *                           |                       |
| Single RDMA-capable network adapter                     | *          |                         |                             | *                     |
| Multiple RDMA-capable network adapters                  | ***        | *                       |                             | *                     |
| Multiple RDMA-capable network adapters with NIC teaming | ***        | **                      | *                           | *                     |

If you're running Windows Server 2016 or later, the ideal solution is to use multiple RDMA-capable network adapters and combine NIC teaming with SMB Multichannel. This combination provides the best throughput, provides fault tolerance for applications that use SMB and other protocols, and has the lowest CPU impact.

As mentioned above, when using RDMA-capable network adapters on Windows Server 2012 R2 or earlier, NIC teaming is not a good option, because it disables the RDMA capability of the network adapter.

### Example configurations without SMB Multichannel

If you plan to use a single network adapter without RSS, you do not benefit from multiple network connections, and therefore, SMB Multichannel is not used. Also, if you plan to use network adapters of different speeds, SMB Multichannel automatically selects the fastest network adapter. This is because network adapters that are the same type (such as RDMA, RSS, or neither) and have the same speed are simultaneously used by SMB Multichannel. The slower network adapters are idle.

## Disable SMB Multichannel
Typically, you don't need to disable SMB Multichannel. However, if you want to disable SMB Multichannel, for example in a test environment, use the following Windows PowerShell procedures.

First, connect to one of the servers by opening a PowerShell session:

```PowerShell
Enter-PSSession <server-name>
```

To disable SMB Multichannel on the server side, use the following cmdlet:

```PowerShell
Set-SmbServerConfiguration -EnableMultiChannel $false
```

To disable SMB Multichannel on the client side, use the following cmdlet:

```PowerShell
Set-SmbClientConfiguration -EnableMultiChannel $false
```

>[!NOTE]
>Disabling SMB Multichannel on either the client or the server blocks both systems from using it.

## Re-enable SMB Multichannel

If you have disabled SMB Multichannel and want to re-enable it, use the following procedures.

To re-enable SMB Multichannel on the server side, use the following cmdlet:

```PowerShell
Set-SmbServerConfiguration -EnableMultiChannel $true
```

To re-enable SMB Multichannel on the client side, use the following cmdlet:

```PowerShell
Set-SmbClientConfiguration -EnableMultiChannel $true
```

>[!NOTE]
>You must re-enable SMB Multichannel on both the client and the server to start using it again.

## Test SMB Multichannel

This section describes some scenarios for testing SMB Multichannel, which includes comparing a file copy with and then without SMB Multichannel and intentionally causing a network adapter to fail during a file copy operation.

### Compare a file copy with and without SMB Multichannel

To measure the increased throughput that is provided by SMB Multichannel, perform the following tests. Restart both the server and the client before each test to make sure that they operate under similar conditions.

1. Configure SMB Multichannel using one the previously described configurations.

1. Measure the amount of time that it takes to perform a long-running file copy operation by using SMB Multichannel.

1. Disable SMB Multichannel. For instructions, see [Disable SMB Multichannel](#disable-smb-multichannel).

1. Measure the amount of time that it takes to perform the same file copy without SMB Multichannel.

1. Re-enable SMB Multichannel. For instructions, see [Re-enable SMB Multichannel](#re-enable-smb-multichannel).

1. Compare the two results.

>[!IMPORTANT]
>To avoid the performance impact of caching, first copy a large amount of data that exceeds the size of available memory. Then perform the copy operation again, with the first copy operation serving as a warm-up. Time only the second copy operation.

### Cause one of the network adapters to fail during a file copy with SMB Multichannel

To confirm the failover capability of SMB Multichannel:

1. Make sure SMB Multichannel operates in a multiple network adapter configuration.

1. Perform a long-running file copy operation.

1. While the file copy operation is running, simulate a failure of one of the network paths by disconnecting one of the cables or by disabling one of the network adapters.

1. Confirm that the file copy continues to use the remaining network adapter and operates without any file copy errors.

Make sure there are no other workloads that use the disconnected network connection path. This precaution avoids a possible failure in workloads that do not leverage SMB Multichannel.

## Verify that SMB Multichannel works

Use the following procedure to verify that SMB Multichannel works.

1. To verify network adapter configuration is correct, type the following in Windows PowerShell on both the SMB server and the SMB client.

   ```PowerShell
   Get-NetAdapter
   Get-NetAdapterRSS
   Get-NetAdapterRDMA
   Get-NetAdapterHardwareInfo
   ```

2. To verify that SMB Multichannel is enabled, confirm that SMB correctly identifies the network adapters, and that the network adapter’s RSS and RDMA capabilities are correctly identified, do the following:

   On the SMB client, type the following in Windows PowerShell:

   ```PowerShell
   Get-SmbClientConfiguration | Select EnableMultichannel
   Get-SmbClientNetworkInterface
   ```

   On the SMB server, type the following in Windows PowerShell:

   ```PowerShell
   Get-SmbServerConfiguration | Select EnableMultichannel
   Get-SmbServerNetworkInterface
   ```

3. On the SMB client, perform a long-running file copy operation that creates an ongoing session with the SMB server. While the copy operation is running, type the following in Windows PowerShell to verify that the connection uses the right version of SMB and that SMB Multichannel works.

   ```PowerShell
   Get-SmbConnection
   Get-SmbMultichannelConnection
   Get-SmbMultichannelConnection -IncludeNotSelected
   ```

## Next steps

For related information, see also:

- [Overview of file sharing using the SMB 3 protocol in Windows Server](/windows-server/storage/file-server/file-server-smb-overview)
- [Simplified SMB Multichannel and Multi-NIC Cluster Networks](/windows-server/failover-clustering/smb-multichannel)
- [SMB Direct](/windows-server/storage/file-server/smb-direct)
