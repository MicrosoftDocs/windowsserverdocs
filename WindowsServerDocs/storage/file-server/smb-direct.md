---
title: Improve performance of a file server with SMB Direct
description: SMB Direct allows for faster file transfer and more efficient network usage by utilizing remote direct memory access (RDMA) technology.
ms.topic: how-to
author: xelu86
ms.author: wscontent
ms.date: 08/02/2023
---

# SMB Direct

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Azure Stack HCI version 21H2

Windows Server includes a feature called SMB Direct, which supports the use of network adapters that have Remote Direct Memory Access (RDMA) capability. Network adapters that have RDMA can function at full speed with lower latency without compromising CPU utilization. For workloads such as Hyper-V or Microsoft SQL Server, this enables a remote file server to resemble local storage. SMB Direct is automatically configured and enabled by default in Windows Server 2012 and future iterations.

Using SMB Direct provides:

- **Increased throughput**: Leverages the full throughput of high speed networks where the network adapters coordinate the transfer of large amounts of data at line speed.
- **Low latency**: Provides fast responses to network requests, which makes remote file storage feel as if it's directly attached block storage.
- **Low CPU utilization**: Uses fewer CPU cycles when transferring data over the network, which leaves more power available to server applications.

You can use SMB Direct in a failover cluster; however, you need to make sure that the cluster networks used for client access are adequate for SMB Direct. Failover clustering supports using multiple networks for client access, along with network adapters that are RSS (Receive Side Scaling)-capable and RDMA-capable.

> [!NOTE]
> You can use SMB Direct on the Hyper-V management operating system to support using Hyper-V over SMB, and to provide storage to a virtual machine that uses the Hyper-V storage stack. However, RDMA-capable network adapters aren't directly exposed to a Hyper-V client. If you connect an RDMA-capable network adapter to a virtual switch, the virtual network adapters from the switch won't be RDMA-capable.

## Requirements

SMB Direct requires the following:

- One or more network adapters with RDMA capability.
- At least two computers running one or more of the following operating systems:
  - Windows Server 2012 and later.
  - Windows 10 Enterprise and later.
  - Windows 10 Education and later.
  - Windows 10 Pro and later.

> [!NOTE]
> Windows 10 and Windows 11 family are restricted to client-only and can't act as an SMB Direct server.

### SMB Multichannel

SMB Multichannel is the feature responsible for detecting the RDMA capabilities of network adapters to enable SMB Direct. Without SMB Multichannel, SMB uses regular TCP/IP with the RDMA-capable network adapters (all network adapters provide a TCP/IP stack along with the new RDMA stack).

With SMB Multichannel, SMB detects whether a network adapter has RDMA capability, and creates multiple RDMA connections for that single session (two per interface). This allows SMB to use the high throughput, low latency, and low CPU utilization offered by RDMA-capable network adapters. It also offers fault tolerance if you're using multiple RDMA interfaces.

You can team RDMA-capable network adapters using Switch Embedded Teaming (SET) starting with Windows Server 2016. After at least one RDMA network connection is created, the TCP/IP connection used for the original protocol negotiation is no longer used. However, the TCP/IP connection is retained in case the RDMA network connections fail.

Disabling SMB Multichannel also disables SMB Direct. Since SMB Multichannel detects network adapter capabilities and determines whether a network adapter is RDMA-capable, SMB Direct can't be used by the client if SMB Multichannel is disabled.

### SMB Encryption

Beginning in Windows Server 2022 and Windows 11, SMB Direct now supports encryption. Previously, enabling SMB encryption disabled direct data placement, making RDMA performance as slow as TCP. Now data is encrypted before placement, leading to relatively minor performance degradation while adding AES-128 and AES-256 protected packet privacy. For more information on configuring SMB encryption, see [SMB security enhancements](smb-security.md).

Furthermore, Windows Server failover clusters now support granular control of encrypting intra-node storage communications for Cluster Shared Volumes (CSV) and the storage bus layer (SBL). This means that when using Storage Spaces Direct and SMB Direct, you can decide to encrypt east-west communications within the cluster itself for higher security.

## Disabling and enabling SMB Direct features

The SMB client automatically detects and uses multiple network connections if an appropriate configuration is identified. As SMB Direct is enabled by default, once disabled, it needs to be manually re-enabled whenever needed.

# [Disable](#tab/disable)

Typically, you won't need to disable SMB Direct, however, you can disable it along with its features, by running the following Windows PowerShell commands.

To disable SMB Direct, type:

```powershell
Disable-WindowsOptionalFeature -Online -FeatureName SMBDirect
```

To disable SMB Multichannel on the server-side, type:

```powershell
Set-SmbServerConfiguration -EnableMultiChannel $false
```

To disable SMB Multichannel on the client-side, type:

```powershell
Set-SmbClientConfiguration -EnableMultiChannel $false
```

To disable RDMA for a specific interface, type:

```powershell
Disable-NetAdapterRdma <name>
```

To disable RDMA for all interfaces, type:

```powershell
Set-NetOffloadGlobalSetting -NetworkDirect Disabled
```

When you disable RDMA on either the client or the server, the systems can't use it. _Network Direct_ is the internal name for Windows Server basic networking support for RDMA interfaces.

# [Enable](#tab/enable)

After disabling SMB Direct and its features, you can re-enable them by running the following Windows PowerShell commands.

To enable SMB Direct, type:

```powershell
Enable-WindowsOptionalFeature -Online -FeatureName SMBDirect
```

To enable SMB Multichannel on the server-side, type:

```powershell
Set-SmbServerConfiguration -EnableMultiChannel $true
```

To enable SMB Multichannel on the client-side, type:

```powershell
Set-SmbClientConfiguration -EnableMultiChannel $true
```

To enable RDMA for a specific interface, type:

```powershell
Enable-NetAdapterRDMA <name>
```

To enable RDMA for all interfaces, type:

```powershell
Set-NetOffloadGlobalSetting -NetworkDirect Enabled
```

RDMA must be enabled on both the client and the server to start using it again.

---

To verify which state of operability SMB Direct is currently configured to, run the following cmdlet:

```powershell
Get-WindowsOptionalFeature -Online -FeatureName SMBDirect
```

## Testing SMB Direct

You can test the performance of SMB Direct by measuring the throughput when running a large file copy. Prior to testing, verify that the network adapter supports RDMA using PowerShell.

On the server-side, type:

```powershell
Get-SmbServerNetworkInterface
```

On the client-side, type:

```powershell
Get-SmbClientNetworkInterface
```

Once the network adapter is verified RDMA-capable, perform the following test:

1. Disable RDMA on the network adapter, see [Disabling and Enabling SMB Direct features](#disabling-and-enabling-smb-direct-features).
1. Measure the amount of time taken to run a large file copy without using SMB Direct.
1. Re-enable RDMA on the network adapter, perform the same file copy, and then compare the two results.
1. To avoid the impact of caching, perform the following:
   1. Copy a large amount of data (more data than memory is capable of handling).
   1. Copy the data twice, with the first copy as practice and then timing the second copy.
   1. Restart both the server and the client before each test to ensure they operate under similar conditions.

Additionally, you can observe the performance counters during testing using the same scenario utilizing the Performance Monitor tool by performing the following:

1. Select **Start**, type **perfmon**, hit <kbd>Enter</kbd>.
1. In the left pane, under **Monitoring Tools** > select **Performance Monitor**.
1. In the right pane, select the green "**+**" icon to add a new counter.
1. In the **Add Counters** dialog box, expand **SMB Direct Connection**.
1. Select both **Bytes RDMA Read/sec** and **Bytes RDMA Written/sec**, select **Add**, then select **OK**.

## SMB Direct failover capability

Here's how to confirm the failover capability of SMB Direct:

1. Ensure that SMB Direct is functioning in a multiple network adapter configuration.
1. Run a large file copy. During the copy process, simulate a failure of one of the network paths by disconnecting one of the cables or by disabling one of the network adapters.
1. Confirm that the file copying continues using one of the remaining network adapters, and that there are no file copy errors.

> [!TIP]
> To avoid failures of a workload that does not use SMB Direct, make sure there are no other workloads using the disconnected network path.

## Additional references

- [Server Message Block overview](file-server-smb-overview.md)
- [Increasing Server, Storage, and Network Availability: Scenario Overview](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/hh831437(v%3dws.11)>)
- [Deploy Hyper-V over SMB](</previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/jj134187(v%3dws.11)>)
