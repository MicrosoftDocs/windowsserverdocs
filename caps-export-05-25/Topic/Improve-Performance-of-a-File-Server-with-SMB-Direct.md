---
title: Improve Performance of a File Server with SMB Direct
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 82710653-854c-41e8-8b11-99139c607afb
author: JasonGerend
---
# Improve Performance of a File Server with SMB Direct
[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] include a feature called SMB Direct, which supports the use of network adapters that have Remote Direct Memory Access \(RDMA\) capability. Network adapters that have RDMA can function at full speed with very low latency, while using very little CPU. For workloads such as Hyper\-V or Microsoft SQL Server, this enables a remote file server to resemble local storage. SMB Direct includes:  
  
-   Increased throughput: Leverages the full throughput of high speed networks where the network adapters coordinate the transfer of large amounts of data at line speed.  
  
-   Low latency: Provides extremely fast responses to network requests, and, as a result, makes remote file storage feel as if it is directly attached block storage.  
  
-   Low CPU utilization: Uses fewer CPU cycles when transferring data over the network, which leaves more power available to server applications.  
  
SMB Direct is automatically configured by [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
**SMB Multichannel and SMB Direct**  
  
SMB Multichannel is the feature responsible for detecting the RDMA capabilities of network adapters to enable SMB Direct. Without SMB Multichannel, SMB uses regular TCP\/IP with the RDMA\-capable network adapters \(all network adapters provide a TCP\/IP stack along with the new RDMA stack\).  
  
With SMB Multichannel, SMB detects whether a network adapter has the RDMA capability, and then creates multiple RDMA connections for that single session \(two per interface\). This allows SMB to use the high throughput, low latency, and low CPU utilization offered by RDMA\-capable network adapters. It also offers fault tolerance if you are using multiple RDMA interfaces.  
  
> [!NOTE]  
> -   You should not team RDMA\-capable network adapters if you intend to use the RDMA capability of the network adapters. When teamed, the network adapters will not support RDMA.  
> -   After at least one RDMA network connection is created, the TCP\/IP connection used for the original protocol negotiation is no longer used. However, the TCP\/IP connection is retained in case the RDMA network connections fail.  
  
**In this guide**  
  
-   [Requirements](../Topic/Improve-Performance-of-a-File-Server-with-SMB-Direct.md#BKMK_prereq)  
  
    -   [Deploy SMB Direct with Ethernet &#40;iWARP&#41; Network Adapters](../Topic/Deploy-SMB-Direct-with-Ethernet--iWARP--Network-Adapters.md)  
  
    -   [Deploy SMB Direct with InfiniBand Network Adapters](../Topic/Deploy-SMB-Direct-with-InfiniBand-Network-Adapters.md)  
  
    -   [Deploy SMB Direct with RoCE Network Adapters](../Topic/Deploy-SMB-Direct-with-RoCE-Network-Adapters.md)  
  
-   [Enabling and disabling SMB Direct](../Topic/Improve-Performance-of-a-File-Server-with-SMB-Direct.md#BKMK_enable)  
  
-   [Test performance of SMB Direct](../Topic/Improve-Performance-of-a-File-Server-with-SMB-Direct.md#BKMK_test)  
  
## <a name="BKMK_prereq"></a>Requirements  
SMB Direct requires the following:  
  
-   At least two computers running [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]  
  
-   One or more network adapters with RDMA capability. Currently, these network adapters are available in three different types: iWARP, Infiniband, or RoCE \(RDMA over Converged Ethernet\). Use the links below for additional information on each of these types of RDMA\-capable network adapters:  
  
    -   [Deploy SMB Direct with Ethernet &#40;iWARP&#41; Network Adapters](../Topic/Deploy-SMB-Direct-with-Ethernet--iWARP--Network-Adapters.md)  
  
    -   [Deploy SMB Direct with InfiniBand Network Adapters](../Topic/Deploy-SMB-Direct-with-InfiniBand-Network-Adapters.md)  
  
    -   [Deploy SMB Direct with RoCE Network Adapters](../Topic/Deploy-SMB-Direct-with-RoCE-Network-Adapters.md)  
  
**Considerations when using SMB Direct**  
  
-   You can use SMB Direct in a failover cluster; however, you need to make sure that the cluster networks used for client access are adequate for SMB Direct. Failover clustering supports using multiple networks for client access, along with network adapters that are RSS \(Receive Side Scaling\)\-capable and RDMA\-capable.  
  
-   You can use SMB Direct on the Hyper\-V management operating system to support using Hyper\-V over SMB, and to provide storage to a virtual machine that uses the Hyper\-V storage stack. However, RDMA\-capable network adapters are not directly exposed to a Hyper\-V client. If you connect an RDMA\-capable network adapter to a virtual switch, the virtual network adapters from the switch will not be RDMA\-capable.  
  
-   If you disable SMB Multichannel, SMB Direct is also disabled. Since SMB Multichannel detects network adapter capabilities and determines whether a network adapter is RDMA\-capable, SMB Direct cannot be used by the client if SMB Multichannel is disabled.  
  
-   SMB Direct is not supported on [!INCLUDE[winrt_2](../Token/winrt_2_md.md)]. SMB Direct requires support for RDMA\-capable network adapters, which is available only on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
-   SMB Direct is not supported on down\-level versions of Windows Server. It is supported only on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
## <a name="BKMK_enable"></a>Enabling and disabling SMB Direct  
SMB Direct is enabled by default when [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] or [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] is installed. The SMB client automatically detects and uses multiple network connections if an appropriate configuration is identified.  
  
**Disabling SMB Direct**  
  
Typically, you will not need to disable SMB Direct, however, you can disable it by running one of the following Windows PowerShell scripts.  
  
To disable RDMA for a specific interface, type:  
  
```  
Disable-NetAdapterRdma <name>  
```  
  
To disable RDMA for all interfaces, type:  
  
```  
Set-NetOffloadGlobalSetting -NetworkDirect Disabled  
```  
  
When you disable RDMA on either the client or the server, the systems cannot use it. *Network Direct* is the internal name for [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] basic networking support for RDMA interfaces.  
  
**Re\-enabling SMB Direct**  
  
After disabling RDMA, you can re\-enable it by running one of the following Windows PowerShell scripts.  
  
To re\-enable RDMA for a specific interface, type:  
  
```  
Enable-NetAdapterRDMA <name>  
```  
  
To re\-enable RDMA for all interfaces, type:  
  
```  
Set-NetOffloadGlobalSetting -NetworkDirect Enabled  
```  
  
You need to enable RDMA on both the client and the server to start using it again.  
  
## <a name="BKMK_test"></a>Test performance of SMB Direct  
You can test how the performance is working by using one of the following procedures.  
  
**Compare a file copy with and without using SMB Direct**  
  
#### To measure the increased throughput of SMB Direct  
  
1.  Configure SMB Direct  
  
2.  Measure the amount of time to run a large file copy using SMB Direct.  
  
3.  Disable RDMA on the network adapter, see [Enabling and disabling SMB Direct](../Topic/Improve-Performance-of-a-File-Server-with-SMB-Direct.md#BKMK_enable).  
  
4.  Measure the amount of time to run a large file copy without using SMB Direct.  
  
5.  Re\-enable RDMA on the network adapter, and then compare the two results.  
  
6.  To avoid the impact of caching, you should do the following:  
  
    1.  Copy a large amount of data \(more data than memory is capable of handling\).  
  
    2.  Copy the data twice, with the first copy as practice and then timing the second copy.  
  
    3.  Restart both the server and the client before each test to make sure they operate under similar conditions.  
  
**Fail one of multiple network adapters during a file copy with SMB Direct**  
  
#### To confirm the failover capability of SMB Direct  
  
1.  Ensure that SMB Direct is functioning in a multiple network adapter configuration.  
  
2.  Run a large file copy. While the copying is run, simulate a failure of one of the network paths by disconnecting one of the cables \(or by disabling one of the network adapters\).  
  
3.  Confirm that the file copying continues using one of the remaining network adapters, and that there are no file copy errors.  
  
    > [!NOTE]  
    > To avoid failures of a workload that does not use SMB Direct, make sure there are no other workloads using the disconnected network path.  
  
## See also  
  
-   [Deploy SMB Direct with InfiniBand Network Adapters](../Topic/Deploy-SMB-Direct-with-InfiniBand-Network-Adapters.md)  
  
-   [Deploy SMB Direct with RoCE Network Adapters](../Topic/Deploy-SMB-Direct-with-RoCE-Network-Adapters.md)  
  
-   [Deploy SMB Direct with Ethernet &#40;iWARP&#41; Network Adapters](../Topic/Deploy-SMB-Direct-with-Ethernet--iWARP--Network-Adapters.md)  
  
-   [Server Message Block Overview](../Topic/Server-Message-Block-Overview.md)  
  
-   [Increasing Server, Storage, and Network Availability: scenario overview](assetId:///22c42d93-e045-4491-8906-4273569d160f)  
  
-   [Deploy Hyper\-V over SMB](assetId:///5a169fa2-f5c8-4c0d-a122-79ecdbdebc98)  
  
