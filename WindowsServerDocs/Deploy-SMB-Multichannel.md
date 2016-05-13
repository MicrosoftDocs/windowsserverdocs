---
title: Deploy SMB Multichannel
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4dccad4b-e84c-4621-80e8-f455233e4503
---
# Deploy SMB Multichannel
SMB Multichannel, a feature included with [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and part of the Server Message Block \(SMB\) 3.0 protocol, increases the network performance and availability of file servers.

SMB Multichannel enables file servers to use multiple network connections simultaneously. It facilitates aggregation of network bandwidth and network fault tolerance when multiple paths are available between the SMB 3.0 client and the SMB 3.0 server. This capability allows server applications to take full advantage of all available network bandwidth and makes them resilient to network failures.

SMB Multichannel provides the following capabilities:

-   **Increased throughput**. The file server can simultaneously transmit additional data by using multiple connections for high\-speed network adapters or multiple network adapters.

-   **Network fault tolerance**. When clients simultaneously use multiple network connections, the clients can continue without interruption despite the loss of a network connection.

-   **Automatic configuration**. SMB Multichannel automatically discovers multiple available network paths and dynamically adds connections as necessary.

## Requirements for using SMB Multichannel
SMB Multichannel has the following requirements:

-   At least two computers that run on [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)], or [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] operating systems are required. No additional features have to be installed—SMB Multichannel is enabled by default.

-   At least one of the following configurations:

    -   Multiple network adapters

    -   One or more network adapters that support Receive Side Scaling \(RSS\)

    -   One of more network adapters that are configured by using NIC Teaming

    -   One or more network adapters that support remote direct memory access \(RDMA\)

For detailed information, see [Example configurations](Deploy-SMB-Multichannel.md#BKMK_exam_config).

## Configure SMB Multichannel
Because SMB Multichannel is enabled by default, you do not have to install additional roles, role services, or features. The SMB client automatically detects and uses multiple network connections when the configuration is identified.

### <a name="BKMK_disableSMBMultichannel"></a>Disable SMB Multichannel
Typically, you do not have to disable SMB Multichannel. However, if you want to disable SMB Multichannel, for example, in a test environment, you can use the following SMB cmdlets in Windows PowerShell:

To disable SMB Multichannel on the server side, type the following in Windows PowerShell:

```
Set-SmbServerConfiguration -EnableMultiChannel $false
```

To disable SMB Multichannel on the client side, type the following in Windows PowerShell:

```
Set-SmbClientConfiguration -EnableMultiChannel $false
```

> [!NOTE]
> Disabling SMB Multichannel on either the client or the server blocks both systems from using it.

To re\-enable SMB Multichannel, use the following procedures:

To re\-enable SMB Multichannel on the server side, type the following in Windows PowerShell:

```
Set-SmbServerConfiguration -EnableMultiChannel $true
```

To re\-enable SMB Multichannel on the client side, type the following in Windows PowerShell:

```
Set-SmbClientConfiguration -EnableMultiChannel $true
```

> [!NOTE]
> You have to re\-enable SMB Multichannel on both the client and the server to start using it again.

### <a name="BKMK_exam_config"></a>Example configurations
This section describes some configuration options for deploying SMB Multichannel by using an array of network adapters. These configurations are only example configurations. There are many other possible configurations that are not included in this topic.

**Single RSS\-capable network adapter**

In this typical configuration, an SMB client and an SMB server are configured by using a single 10\-gigabit Ethernet \(10 GbE\) network adapter. When SMB is deployed without SMB Multichannel, and if there is only one SMB session established, SMB creates a single TCP\/IP connection. With only a single CPU core, this configuration inherently leads to congestion, especially when many small I\/O operations are performed. Therefore, the potential for a performance bottleneck is significant.

Most current network adapters offer a capability called Receive Side Scaling \(RSS\), which enables multiple connections to automatically spread across multiple CPU cores. However, if you use a single connection, RSS cannot help. When you use SMB Multichannel with a RSS\-capable network adapter, SMB creates multiple TCP\/IP connections for that particular session. This configuration avoids a potential bottleneck on a single CPU core if many small I\/O operations  are required.

**Multiple network adapters**

In this configuration, an SMB client and SMB server are configured by using multiple 10 GbE network adapters. When SMB is deployed without SMB Multichannel, and if there is only one SMB session established, SMB uses one of the available network adapters to create a single TCP\/IP connection. In this scenario, it is not possible to aggregate the bandwidth of the multiple network adapters; for example, you cannot achieve 2 gigabits per second \(Gbps\) when you use two 1\-GbE network adapters. There is also a potential for failure if the selected network adapter is disconnected or disabled.

When SMB is deployed with SMB Multichannel, SMB creates multiple TCP\/IP connections for a single session with at least one or more connections per interface if the network adapters are RSS\-capable. This configuration enables SMB to use the combined network adapter bandwidth that is available and makes it possible for the SMB client to continue without interruption if a network adapter fails.

**NIC Teaming**

[!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] support the ability to combine multiple network adapters into one network adapter by using a feature called NIC Teaming. Although a team always provides fault tolerance, when SMB is deployed without SMB Multichannel, SMB creates only one TCP\/IP connection per team. This configuration leads to limitations in both the number of CPU cores that are engaged and the maximum use of the team bandwidth.

When SMB is deployed with SMB Multichannel, SMB creates multiple TCP\/IP connections for a single session to achieve a better balance across CPU cores and better use of the available bandwidth. NIC Teaming continues to offer the failover capability, which works faster than using SMB Multichannel by itself. We also recommend NIC Teaming because it offers failover capabilities to other workloads that do not rely on SMB, because those workloads cannot benefit from the failover capabilities of SMB Multichannel.

> [!IMPORTANT]
> A team of RDMA\-capable network adapters is always reported as non\-RDMA capable. If you intend to use the RDMA capabilities of the network adapters, do not team them.

**Single or multiple RDMA\-capable network adapters**

SMB Multichannel detects the RDMA capabilities of network adapters, which enables the SMB Direct feature, SMB Direct over RDMA. Without SMB Multichannel, SMB uses regular TCP\/IP connections with the RDMA\-capable network adapters where all network adapters provide a TCP\/IP stack that exists side\-by\-side with the new RDMA stack.

When SMB is deployed with SMB Multichannel, SMB detects the RDMA capability of a network adapter and creates multiple RDMA connections for that single session, with two RDMA connections per interface. This configuration enables SMB to take advantage of the high throughput, low latency, and low CPU utilization that is offered by the RDMA\-capable network adapters. It also offers fault tolerance when you use multiple RDMA interfaces.

> [!IMPORTANT]
> A team of RDMA\-capable network adapters is always reported as non\-RDMA capable. If you intend to use the RDMA capabilities of the network adapters, do not team them.
> 
> After a RDMA connection is created, the TCP\/IP connection that is used for the original protocol negotiation is no longer used. However, that connection is maintained in case the RDMA connections fail.

**SMB Multichannel, RDMA\-capable network adapters, and NIC Teaming compatibility**

The following table summarizes the different capabilities that are available when you combine SMB Multichannel, RDMA \(SMB Direct\), and NIC Teaming.

||Throughput|Fault tolerance for SMB|Fault tolerance for non\-SMB|Lower CPU utilization|
|-|--------------|---------------------------|--------------------------------|-------------------------|
|Single network adapter \(no RSS\)|√||||
|Multiple network adapters \(no RSS\)|√√|√|||
|Multiple network adapters \(no RSS\) with NIC Teaming|√√|√√|√||
|Single network adapter with RSS|√||||
|Multiple network adapters with RSS|√√|√|||
|Multiple network adapters with RSS and NIC Teaming|√√|√√|√||
|Single RDMA\-capable network adapter|**√**|||√|
|Multiple RDMA\-capable network adapters|**√√√**|√||√|

For non\-RDMA network adapters, the ideal solution is to combine NIC Teaming with SMB Multichannel. This combination provides the best throughput and also provides fault tolerance for applications that use SMB and other protocols.

When you use RDMA\-capable network adapters, NIC Teaming is not a good option, because it disables the RDMA capability of the network adapter.

**Example configurations without SMB Multichannel**

If you plan to use a single network adapter without RSS, you do not benefit from multiple network connections, and therefore, SMB Multichannel is not used. Also, if you plan to use network adapters of different speeds, SMB Multichannel automatically selects the fastest network adapter because network adapters that are the same type, such as RDMA, RSS, or none, and have the same speed are simultaneously used by SMB Multichannel. The slower network adapters are idle.

## Test SMB Multichannel
This section describes some scenarios for testing SMB Multichannel, which includes comparing a file copy with and then without SMB Multichannel and intentionally causing a network adapter to fail during a file copy operation.

### Compare a file copy with and without SMB Multichannel

##### To measure the increased throughput that is provided by SMB Multichannel

1.  Configure SMB Multichannel by using one the previously described configurations.

2.  Measure the amount of time that it takes to perform a long\-running file copy operation by using SMB Multichannel.

3.  Disable SMB Multichannel. For instructions, see Disable SMB Multichannel.

4.  Measure the amount of time that it takes to perform the same file copy without SMB Multichannel.

5.  Re\-enable SMB Multichannel.

6.  Compare the two results.

To avoid the performance impact of caching, do the following:

-   Copy a large amount of data that exceeds the size of available memory.

-   Perform the copy operation twice, where the first copy serves as a warm\-up. Time only the second copy operation.

-   Restart both the server and the client before each test to make sure that they operate under similar conditions.

### Cause one of the several network adapters to fail during a file copy with SMB Multichannel

##### To confirm the failover capability of SMB Multichannel

1.  Make sure SMB Multichannel operates in a multiple network adapter configuration.

2.  Perform a long\-running file copy operation.

3.  While the file copy operation is running, simulate a failure of one of the network paths by disconnecting one of the cables or by disabling one of the network adapters.

4.  Confirm that the file copy continues to use the remaining network adapter and operates without any file copy errors.

Make sure there are no other workloads that use the disconnected network connection path. This precaution avoids a possible failure in workloads that do not leverage SMB Multichannel.

### Verify that SMB Multichannel works
Use the following procedure to verify that SMB Multichannel works.

##### To verify that SMB Multichannel works

1.  To verify network adapter configuration is correct, type the following in Windows PowerShell on both the SMB server and the SMB client.

    ```
    Get-NetAdapter
    Get-NetAdapterRSS
    Get-NetAdapterRDMA
    Get-NetAdapterHardwareInfo
    ```

2.  To verify that SMB Multichannel is enabled, confirm that SMB correctly identifies the network adapters, and that the network adapter’s RSS and RDMA capabilities are correctly identified, do the following:

    On the SMB client, type the following in Windows PowerShell:

    ```
    Get-SmbClientConfiguration | Select EnableMultichannel
    Get-SmbClientNetworkInterface
    ```

    On the SMB server, type the following in Windows PowerShell:

    ```
    Get-SmbServerConfiguration | Select EnableMultichannel
    Get-SmbServerNetworkInterface
    ```

3.  On the SMB client, perform a long\-running file copy operation that creates an ongoing session with the SMB server. While the copy operation is running, type the following in Windows PowerShell to verify that the connection uses the right version of SMB and that SMB Multichannel works.

    ```

    Get-SmbConnection
    Get-SmbMultichannelConnection
    Get-SmbMultichannelConnection -IncludeNotSelected
    ```

## See also

-   [Server Message Block Overview](Server-Message-Block-Overview.md)

-   [Improve Performance of a File Server with SMB Direct](Improve-Performance-of-a-File-Server-with-SMB-Direct.md)

-   [Increasing Server, Storage, and Network Availability: scenario overview](assetId:///22c42d93-e045-4491-8906-4273569d160f)

-   [Deploy Hyper\-V over SMB](assetId:///5a169fa2-f5c8-4c0d-a122-79ecdbdebc98)


