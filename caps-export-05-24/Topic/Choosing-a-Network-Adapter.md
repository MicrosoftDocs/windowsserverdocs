---
title: Choosing a Network Adapter
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a7e5c747-05fe-4241-8f86-12cd4fad22e5
---
# Choosing a Network Adapter
This topic contains the following sections.  
  
-   [Offload Capabilities](#bkmk_offload)  
  
-   [Receive Side Scaling \(RSS\)](#bkmk_rss)  
  
-   [Receive Segment Coalescing \(RSC\)](#bkmk_rsc)  
  
-   [Network Adapter Resources](#bkmk_resources)  
  
-   [Message\-Signaled Interrupts \(MSI\/MSI\-X\)](#bkmk_msi)  
  
-   [Interrupt Moderation](#bkmk_int)  
  
-   [Suggested Network Adapter Features for Server Workloads](#bkmk_features)  
  
Network\-intensive applications require high\-performance network adapters. This section explores some considerations for choosing network adapters, as well as how to configure different network adapter settings to achieve the best network performance.  
  
> [!TIP]  
> You can configure network adapter settings by using Windows PowerShell. For more information, see [Network Adapter Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/jj134956.aspx).  
  
## <a name="bkmk_offload"></a>Offload Capabilities  
Offloading tasks from the central processing unit \(CPU\) to the network adapter can reduce CPU usage on the server, which improves the overall system performance. The network stack in Microsoft products can offload one or more tasks to a network adapter if you select a network adapter that has the appropriate offload capabilities. The following table provides details about different offload capabilities that are available in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)].  
  
|Offload type|Description|  
|----------------|---------------|  
|Checksum calculation|The network stack can offload the calculation and validation of Transmission Control Protocol \(TCP\) and User Datagram Protocol \(UDP\) checksums on send and receive code paths. It can also offload the calculation and validation of IPv4 and IPv6 checksums on send and receive code paths.|  
|IP security authentication and encryption|The TCP\/IP transport layer can offload the calculation and validation of encrypted checksums for authentication headers and Encapsulating Security Payloads \(ESPs\). The TCP\/IP transport layer can also offload the encryption and decryption of ESPs.|  
|Segmentation of large TCP packets|The TCP\/IP transport layer supports Large Send Offload v2 \(LSOv2\). With LSOv2, the TCP\/IP transport layer can offload the segmentation of large TCP packets to the network adapter.|  
|Receive Side Scaling \(RSS\)|RSS is a network driver technology that enables the efficient distribution of network receive processing across multiple CPUs in multiprocessor systems.|  
|Receive Segment Coalescing \(RSC\)|RSC is the ability to group packets together to minimize the header processing that is necessary for the host to perform. A maximum of 64 KB of received payload can be coalesced into a single larger packet for processing.|  
  
## <a name="bkmk_rss"></a>Receive Side Scaling \(RSS\)  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)], and [!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] support Receive Side Scaling \(RSS\). Some servers are configured with multiple logical processors that share hardware resources \(such as a physical core\) and which are treated as Simultaneous Multi\-Threading \(SMT\) peers. Intel Hyper\-Threading Technology is an example. RSS directs network processing to up to one logical processor per core. For example, on a server with Intel Hyper\-Threading, 4 cores, and 8 logical processors, RSS uses no more than 4 logical processors for network processing.  
  
RSS distributes incoming network I\/O packets among logical processors so that packets which belong to the same TCP connection are processed on the same logical processor, which preserves ordering. RSS also load balances UDP unicast and multicast traffic, and it routes related flows \(which are determined by hashing the source and destination addresses\) to the same logical processor, preserving the order of related arrivals. This helps improve scalability and performance for receive\-intensive scenarios for servers that have fewer network adapters than they do eligible logical processors.  
  
**Configuring RSS**  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can configure RSS by using Windows PowerShell cmdlets and RSS profiles. You can define RSS profiles by using the **–Profile** parameter of the Set\-NetAdapterRss Windows PowerShell cmdlet.  
  
**Windows PowerShell commands for RSS configuration**  
  
The following cmdlets allow you to see and modify RSS parameters per network adapter.  
  
> [!NOTE]  
> For a detailed command reference for each cmdlet, including syntax and parameters, you can click the following links. In addition, you can pass the cmdlet name to Get\-Help at the Windows PowerShell prompt for details on each command.  
  
-   [Disable\-NetAdapterRss](http://technet.microsoft.com/library/jj130892). This command disables RSS on the network adapter that you specify.  
  
-   [Enable\-NetAdapterRss](http://technet.microsoft.com/library/jj130859). This command enables RSS on the network adapter that you specify.  
  
-   [Get\-NetAdapterRss](http://technet.microsoft.com/library/jj130912). This command retrieves RSS properties of the network adapter that you specify.  
  
-   [Set\-NetAdapterRss](http://technet.microsoft.com/library/jj130863). This command sets the RSS properties on the network adapter that you specify.  
  
**RSS profiles**  
  
You can use the **–Profile** parameter of the Set\-NetAdapterRss cmdlet to specify which logical processors are assigned to which network adapter. Available values for this parameter are:  
  
-   **Closest**. Logical processor numbers that are near the network adapter’s base RSS processor are preferred. With this profile, the operating system might rebalance logical processors dynamically based on load.  
  
-   **ClosestStatic**. Logical processor numbers near the network adapter’s base RSS processor are preferred. With this profile, the operating system does not rebalance logical processors dynamically based on load.  
  
-   **NUMA**. Logical processor numbers are generally selected on different NUMA nodes to distribute the load. With this profile, the operating system might rebalance logical processors dynamically based on load.  
  
-   **NUMAStatic**. This is the **default profile**. Logical processor numbers are generally selected on different NUMA nodes to distribute the load. With this profile, the operating system will not rebalance logical processors dynamically based on load.  
  
-   **Conservative**. RSS uses as few processors as possible to sustain the load. This option helps reduce the number of interrupts.  
  
Depending on the scenario and the workload characteristics, you can also use other parameters of the Set\-NetAdapterRss Windows PowerShell cmdlet to specify the following:  
  
-   On a per\-network adapter basis, how many logical processors can be used for RSS.  
  
-   The starting offset for the range of logical processors.  
  
-   The node from which the network adapter allocates memory.  
  
Following are the additional Set\-NetAdapterRss parameters that you can use to configure RSS:  
  
> [!NOTE]  
> In the example syntax for each parameter below, the network adapter name Ethernet is used as an example value for the **–Name** parameter of the Set\-NetAdapterRss command. When you run the cmdlet, ensure that the network adapter name that you use is appropriate for your environment.  
  
-   **\* MaxProcessors**:  Sets the maximum number of RSS processors to be used. This ensures that application traffic is bound to a maximum number of processors on a given interface. Example syntax:  
  
    `Set-NetAdapterRss –Name “Ethernet” –MaxProcessors <value>`  
  
-   **\* BaseProcessorGroup**:  Sets the base processor group of a NUMA node. This impacts the processor array that is used by RSS. Example syntax:  
  
    `Set-NetAdapterRss –Name “Ethernet” –BaseProcessorGroup <value>`  
  
-   **\* MaxProcessorGroup**:  Sets the Max processor group of a NUMA node. This impacts the processor array that is used by RSS. Setting this would restrict a maximum processor group so that load balancing is aligned within a k\-group. Example syntax:  
  
    `Set-NetAdapterRss –Name “Ethernet” –MaxProcessorGroup <value>`  
  
-   **\* BaseProcessorNumber**:  Sets the base processor number of a NUMA node. This impacts the processor array that is used by RSS. This allows partitioning processors across network adapters. This is the first logical processor in the range of RSS processors that is assigned to each adapter. Example syntax:  
  
    `Set-NetAdapterRss –Name “Ethernet” –BaseProcessorNumber <Byte Value>`  
  
-   **\* NumaNode**:  The NUMA node that each network adapter can allocate memory from. This can be within a k\-group or from different k\-groups. Example syntax:  
  
    `Set-NetAdapterRss –Name “Ethernet” –NumaNodeID <value>`  
  
-   **\* NumberofReceiveQueues**:  If your logical processors seem to be underutilized for receive traffic \(for example, as viewed in Task Manager\), you can try increasing the number of RSS queues from the default of 2 to the maximum that is supported by your network adapter. Your network adapter may have options to change the number of RSS queues as part of the driver. Example syntax:  
  
    `Set-NetAdapterRss –Name “Ethernet” –NumberOfReceiveQueues <value>`  
  
For more information, click the following link to download [Scalable Networking: Eliminating the Receive Processing Bottleneck—Introducing RSS](http://download.microsoft.com/download/5/D/6/5D6EAF2B-7DDF-476B-93DC-7CF0072878E6/NDIS_RSS.doc) in Word format.  
  
### Understanding RSS Performance  
Tuning RSS requires understanding the configuration and the load\-balancing logic. To verify that the RSS settings have taken effect, you can review the output when you run the **Get\-NetAdapterRss** Windows PowerShell cmdlet. Following is example output of this cmdlet.  
  
```  
PS C:\Users\Administrator> get-netadapterrss  
Name                                            : testnic 2  
InterfaceDescription                  : Broadcom BCM5708C NetXtreme II GigE (NDIS VBD Client) #66  
Enabled                                         : True  
NumberOfReceiveQueues         : 2  
Profile                                             : NUMAStatic  
BaseProcessor: [Group:Number]                   : 0:0  
MaxProcessor: [Group:Number]                    : 0:15  
MaxProcessors                               : 8  
  
IndirectionTable: [Group:Number]                :   
     0:0    0:4    0:0    0:4    0:0    0:4    0:0    0:4  
…   
(# indirection table entries are a power of 2 and based on # of processors)  
…   
                                                  0:0    0:4    0:0    0:4    0:0    0:4    0:0    0:4  
  
```  
  
In addition to echoing parameters that were set, the key aspect of the output is the indirection table output. The indirection table displays the hash table buckets that are used to distribute incoming traffic. In this example, the n:c notation designates the Numa K\-Group:CPU index pair that is used to direct incoming traffic. We see exactly 2 unique entries \(0:0 and 0:4\), which represent k\-group 0\/cpu0 and k\-group 0\/cpu 4, respectively.  
  
There is only one k\-group for this system \(k\-group 0\) and a n \(where n <\= 128\) indirection table entry. Because the number of receive queues is set to 2, only 2 processors \(0:0, 0:4\) are chosen \- even though maximum processors is set to 8. In effect, the indirection table is hashing incoming traffic to only use 2 CPUs out of the 8 that are available.  
  
To fully utilize the CPUs, the number of RSS Receive Queues must be equal to or greater than Max Processors. In the previous example, the Receive Queue should be set to 8 or greater.  
  
### RSS and Virtualization  
RSS provides hashing and scalability to host interface only. RSS does not provide any interaction with virtual machines, instead users can configure VMQ in those scenarios.  
  
RSS can be enabled for guest virtual machines in the case of SR\-IOV because the virtual function driver supports RSS capability. In this case, the guest and the host will have the benefit of RSS. Note that the host does not get RSS capability because the virtual switch is enabled with SR\-IOV.  
  
### NIC Teaming and RSS  
RSS can be enabled on a network adapter that is teamed with another network interface card using NIC Teaming. In this scenario, only the underlying physical network adapter can be configured to use RSS. A user cannot set RSS cmdlets on the teamed network adapter.  
  
## <a name="bkmk_rsc"></a>Receive Segment Coalescing \(RSC\)  
Receive Segment Coalescing \(RSC\) helps performance by reducing the number of IP headers that are processed for a given amount of received data. It should be used to help scale the performance of received data by grouping \(or coalescing\) the smaller packets into larger units.  
  
This approach can affect latency with benefits mostly seen in throughput gains. RSC is recommended to increase throughput for received heavy workloads. Consider deploying network adapters that support RSC. On these network adapters, ensure that RSC is on \(this is the default setting\), unless you have specific workloads \(for example, low latency, low throughput networking\) that show benefit from RSC being off.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], the following Windows PowerShell cmdlets allow you to configure RSC capable network adapters:  
  
### Understanding RSC Diagnostics  
You can diagnose RSC by using the Windows PowerShell cmdlets Get\-NetAdapterRsc and Get\-NetAdapterStatistics.  
  
Following is example output when you run the Get\-NetAdapterRsc cmdlet.  
  
```  
PS C:\Users\Administrator> Get-NetAdapterRsc  
  
Name                       IPv4Enabled  IPv6Enabled  IPv4Operational IPv6Operational               IPv4FailureReason              IPv6Failure  
                                            Reason  
----                           -----------  -----------  --------------- --------------- ----------------- ------------  
Ethernet                       True         False        True            False                  NoFailure       NicProperties  
  
```  
  
The **Get** cmdlet shows whether RSC is enabled in the interface and whether TCP enables RSC to be in an operational state. The failure reason provides details about the failure to enable RSC on that interface.  
  
In the previous scenario, IPv4 RSC is supported and operational in the interface. To understand diagnostic failures, one can see the coalesced bytes or exceptions caused. This provides an indication of the coalescing issues.  
  
Following is example output when you run the Get\-NetAdapterStatistics cmdlet.  
  
```  
PS C:\Users\Administrator> $x = Get-NetAdapterStatistics “myAdapter”   
PS C:\Users\Administrator> $x.rscstatistics  
  
CoalescedBytes       : 0  
CoalescedPackets     : 0  
CoalescingEvents     : 0  
CoalescingExceptions : 0  
  
```  
  
### RSC and Virtualization  
RSC is only supported in the physical host when the host network adapter is not bound to the Hyper\-V Virtual Switch. RSC is disabled by the operating system when the host is bound to the Hyper\-V Virtual Switch. In addition, virtual machines do not get the benefit of RSC because virtual network adapters do not support RSC.  
  
RSC can be enabled for a virtual machine when Single Root Input\/Output Virtualization \(SR\-IOV\) is enabled. In this case, virtual functions support RSC capability; hence, virtual machines also receive the benefit of RSC.  
  
## <a name="bkmk_resources"></a>Network Adapter Resources  
A few network adapters actively manage their resources to achieve optimum performance. Several network adapters let the administrator manually configure resources by using the **Advanced Networking** tab for the adapter. For such adapters, you can set the values of a number of parameters, including the number of receive buffers and send buffers.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], configuring network adapter resources is simplified by the use of the following Windows PowerShell cmdlets.  
  
-   Get\-NetAdapterAdvancedProperty  
  
-   Set\-NetAdapterAdvancedProperty  
  
-   Enable\-NetAdapter  
  
-   Enable\-NetAdapterBinding  
  
-   Enable\-NetAdapterChecksumOffload  
  
-   Enable\-NetAdapterLso  
  
-   Enable\-NetAdapterIPSecOffload  
  
-   Enable\-NetAdapterPowerManagement  
  
-   Enable\-NetAdapterQos  
  
-   Enable\-NetAdapterRDMA  
  
-   Enable\-NetAdapterSriov  
  
## <a name="bkmk_msi"></a>Message\-Signaled Interrupts \(MSI\/MSI\-X\)  
Network adapters that support MSI\/MSI\-X can target their interrupts to specific logical processors. If the adapters also support RSS, then a logical processor can be dedicated to servicing interrupts and deferred procedure calls \(DPCs\) for a given TCP connection. This preserves the cache locality of TCP structures and greatly improves performance.  
  
## <a name="bkmk_int"></a>Interrupt Moderation  
To control interrupt moderation, some network adapters expose either different interrupt moderation levels, or buffer coalescing parameters \(sometimes separately for send and receive buffers\), or both of these. You should consider buffer coalescing or batching when the network adapter does not perform interrupt moderation. Interrupt moderation helps reduce overall CPU utilization by minimizing the per\-buffer processing cost, but the moderation of interrupts and buffer batching can have a negative impact on latency\-sensitive scenarios.  
  
## <a name="bkmk_features"></a>Suggested Network Adapter Features for Server Workloads  
The following table lists high\-performance network adapter features – including Checksum Offload \(ChO\), Large Sum Offload \(LSO\), RSS, and RSC \- that can improve performance in terms of throughput, latency, or scalability for some server workloads.  
  
> [!NOTE]  
> When there is an **X** in a feature column, it means that for the server role, installing a network adapter with this feature enabled is recommended.  
  
|Server workload|ChO|LSO|RSS|RSC|  
|-------------------|-------|-------|-------|-------|  
|File server|**X**|**X**|**X**|**X**|  
|Web server|**X**|**X**|**X**||  
|Mail server \(short\-lived connections\)|**X**||**X**||  
|Database server|**X**|**X**|**X**||  
|FTP server|**X**|**X**||**X**|  
|Media server|**X**||**X**|**X**|  
  
