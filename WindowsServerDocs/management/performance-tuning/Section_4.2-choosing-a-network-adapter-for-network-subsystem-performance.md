---
title: Choosing a Network Adapter for Network Subsystem Performance
description: Choosing a Network Adapter for Network Subsystem Performance
---

# Choosing a Network Adapter for Network Subsystem Performance

Network-intensive applications require high-performance network adapters. This topic explores some considerations for choosing network adapters.

**In this topic:**

-   [Offload capabilities](#offload-capabilities)

-   [Receive-Side Scaling (RSS)](#rss)

-   [Receive Segment Coalescing (RSC)](#rsc)

-   [Network adapter resources](#resources)

-   [Message-Signaled Interrupts (MSI/MSI-X)](#msi)

-   [Interrupt moderation](#irq)

-   [Suggested network adapter features for server roles](#features)

## Offload capabilities


Offloading tasks can reduce CPU usage on the server, which improves the overall system performance. The network stack in Microsoft products can offload one or more tasks to a network adapter if you choose one that has the appropriate offload capabilities. The following table provides details about each offload capability.

| Offload type | Description |
| - | - |
| Checksum calculation | The network stack can offload the calculation and validation of Transmission Control Protocol (TCP) and User Datagram Protocol (UDP) checksums on send and receive code paths. It can also offload the calculation and validation of IPv4 and IPv6 checksums on send and receive code paths. |
| IP security authentication and encryption | The TCP/IP transport layer can offload the calculation and validation of encrypted checksums for authentication headers and Encapsulating Security Payloads (ESPs). The TCP/IP transport layer can also offload the encryption and decryption of ESPs. |
| Segmentation of large TCP packets | The TCP/IP transport layer supports Large Send Offload v2 (LSOv2). With LSOv2, the TCP/IP transport layer can offload the segmentation of large TCP packets to the hardware. |
| Receive Segment Coalescing (RSC) | RSC is the ability to group packets together to minimize the header processing that is necessary for the host to perform. A maximum of 64 KB of received payload can be coalesced into a single larger packet for processing. |
| Receive-Side Scaling (RSS) | Receive-side scaling (RSS) is a network driver technology that enables the efficient distribution of network receive processing across multiple CPUs in multiprocessor systems. |
| SR-IOV | Single root I/O virtualization (SR-IOV) allows direct assignment of network resources (virtual functions) to individual virtual machines when the network adapter supports this feature. |

## <a href="" id="rss"></a>Receive-Side Scaling (RSS)

Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008 support Receive Side Scaling (RSS). A server may have multiple logical processors that share hardware resources (such as a physical core) and are treated as Simultaneous Multi-Threading (SMT) peers. Intel hyper-threading technology is an example. RSS directs network processing to up to one logical processor per core. For example, given a server with Intel hyper-threading and 4 cores (8 logical processors), RSS will use no more than 4 logical processors for network processing.

RSS distributes incoming network I/O packets among logical processors so that packets that belong to the same TCP connection are processed on the same logical processor, which preserves ordering. RSS also load balances UDP unicast and multicast traffic from Windows Server 2012 R2, and it routes related flows (as determined by hashing the source and destination addresses) to the same logical processor, thereby preserving the order of related arrivals. This helps improve scalability and performance for receive-intensive scenarios that have fewer network adapters than eligible logical processors.

Windows Server 2012 R2 provides the following ways to tune RSS behavior:

-   Windows PowerShell cmdlets: Get-NetAdapterRSS, Set-NetAdapterRSS, Enable-NetAdapterRss, and Disable-NetAdapterRss. For more info, see [Network Adapter Cmdlets in Windows PowerShell](http://technet.microsoft.com/library/jj134956).

    These cmdlets allow you to see and modify RSS parameters per network adapter. Pass the cmdlet name to **Get-Help** for more info.

-   RSS Profiles: One of the parameters that is available is the RSS Profile, which is used to determine which logical processors are assigned to which network adapter. Possible profiles include:

    -   **Closest** Logical processor numbers near the network adapter’s base RSS processor are preferred. Windows may rebalance logical processors dynamically based on load.

    -   **ClosestStatic** Logical processor numbers near the network adapter’s base RSS processor are preferred. Windows will not rebalance logical processors dynamically based on load.

    -   **NUMA** Logical processor numbers will tend to be selected on different NUMA nodes to distribute the load. Windows may rebalance logical processors dynamically based on load.

    -   **NUMAStatic** This is the default profile. Logical processor numbers will tend to be selected on different NUMA nodes to distribute the load. Windows will not rebalance logical processors dynamically based on load.

    -   **Conservative** RSS uses as few processors as possible to sustain the load. This option helps reduce the number of interrupts.

Depending on the scenario and the workload characteristics, you can use the following Windows PowerShell cmdlet to choose things like how many logical processors can be used for RSS on a per-network adapter basis, the starting offset for the range of logical processors, and which node the network adapter allocates memory from:

-   **MaxProcessors** Sets the maximum number of RSS processors to be used. This ensures that application traffic is bound to a maximum number of processors on a given interface.

    ``` syntax
    set-netadapterRSS –Name “Ethernet” –MaxProcessors <value>
    ```

-   **BaseProcessorGroup** Sets the base processor group of a NUMA node. This impacts the processor array that is used by RSS.

    ``` syntax
    set-netadapterRSS –Name “Ethernet” –BaseProcessorGroup <value>
    ```

-   **MaxProcessorGroup** Sets the Max processor group of a NUMA node. This impacts the processor array that is used by RSS. Setting this would restrict a maximum processor group so that load balancing is aligned within a k-group.

    ``` syntax
    set-netadapterRSS –Name “Ethernet” –MaxProcessorGroup <value>
    ```

-   **BaseProcessorNumber** Sets the base processor number of a NUMA node. This impacts the processor array that is used by RSS. This allows partitioning processors across network adapters. This is the first logical processor in the range of RSS processors that is assigned to each adapter.

    ``` syntax
    set-netadapterRSS –Name “Ethernet” –BaseProcessorNumber <Byte Value>
    ```

-   **NumaNode** The NUMA node that each network adapter can allocate memory from. This can be within a k-group or from different k-groups.

    ``` syntax
    set-netadapterRSS –Name “Ethernet” –NumaNodeID <value>
    ```

-   **NumberofReceiveQueues** If your logical processors seem to be underutilized for receive traffic (for example, as viewed in Task Manager), you can try increasing the number of RSS queues to the maximum that is supported by your network adapter. Your network adapter may have options to change the number of RSS queues as part of the driver.

    ``` syntax
    set-netadapterRSS –Name “Ethernet” –NumberOfReceiveQueues <value>
    ```

For more information, see [Scalable Networking: Eliminating the Receive Processing Bottleneck—Introducing RSS](http://download.microsoft.com/download/5/D/6/5D6EAF2B-7DDF-476B-93DC-7CF0072878E6/NDIS_RSS.doc).

### Understanding RSS performance

Tuning RSS requires understanding the configuration and the load-balancing logic. Use the **Get-NetAdapterRss** Windows PowerShell cmdlet to verify that the RSS settings have taken effect.

``` syntax
PS C:\Users\Administrator> get-netadapterrss
Name                            : testnic 2
InterfaceDescription            : Broadcom BCM5708C NetXtreme II GigE (NDIS VBD Client) #66
Enabled                         : True
NumberOfReceiveQueues           : 2
Profile                         : NUMAStatic
BaseProcessor: [Group:Number]   : 0:0
MaxProcessor: [Group:Number]    : 0:15
MaxProcessors                   : 8

IndirectionTable: [Group:Number] :
0:0    0:4    0:0    0:4    0:0    0:4    0:0    0:4
…
(# indirection table entries are a power of 2 and based on # of processors)
…
0:0    0:4    0:0    0:4    0:0    0:4    0:0    0:4
```

In addition to echoing parameters that were set, the key aspect of the output is to understand the indirection table. The indirection table displays the hash table buckets that are used to distribute incoming traffic. In this example, the n:c notation designates the Numa K-Group:CPU index pair that is used to direct incoming traffic. We see exactly 2 unique entries (0:0 and 0:4), which represent k-group 0/cpu0 and k-group 0/cpu 4, respectively.

We further see only one k-group for this system (k-group 0) and a n (where n &lt;= 128) indirection table entry. Because the number of receive queues is set to 2, only 2 processors (0:0, 0:4) are chosen even though maximum processors is set to 8. In effect, the indirection table is hashing incoming traffic to only use 2 CPUs out of the 8 that are available.

To fully utilize the CPUs, the number of RSS Receive Queues should be equal to or greater than Max Processors. For the previous example, the Receive Queue should be set to 8 or greater.

### RSS and virtualization

RSS provides hashing and scalability to host interface only. RSS does not provide any interaction with virtual machines, instead users can configure VMQ in those scenarios.

RSS can be enabled for guest virtual machines in the case of SR-IOV if the SR-IOV NIC and virtual function driver supports VF RSS capability. In this case, the guest will have the benefit of RSS. Note that the host does not get RSS capability because the host is bypassed by SR-IOV.

### NIC teaming and RSS

RSS can be enabled on a network adapter that is teamed. In this scenario, only the underlying physical network adapter can be configured to use RSS. A user cannot use RSS cmdlets on the teamed network adapter.

## <a href="" id="rsc"></a>Receive Segment Coalescing (RSC)


Receive Segment Coalescing (RSC) helps performance in Windows Server 2012 R2 by reducing the number of IP headers that are processed for a given amount of received data. It should be used to help scale the performance of received data by grouping (or coalescing) the smaller packets into larger units. This approach can affect latency with benefits mostly seen in throughput gains. RSC is recommended to increase throughput for received heavy workloads. Consider deploying network adapters that support RSC. On these network adapters, ensure that RSC is on (this is the default setting), unless you have specific workloads (for example, low latency, low throughput networking) that show benefit from RSC being off.

In Windows Server 2012 R2, the following Windows PowerShell cmdlets allow you to configure RSC capable network adapters: Enable-NetAdapterRsc, Disable-NetRsc, Get-NetAdapterAdvancedProperty, and Set-NetAdapterAdvancedProperty.

### Understanding RSC diagnostics

You can diagnose RSC by using the Get-NetAdapterRsc Windows PowerShell cmdlet. The following tables show some sample data from the output:

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<thead>
<tr class="header">
<th>Name</th>
<th>IPv4Enabled</th>
<th>IPv4Operational</th>
<th>IPv4FailureReason</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Ethernet</p></td>
<td><p>True</p></td>
<td><p>True</p></td>
<td><p>NoFailure</p></td>
</tr>
</tbody>
</table>

 

<table>
<colgroup>
<col width="25%" />
<col width="25%" />
<col width="25%" />
<col width="25%" />
</colgroup>
<thead>
<tr class="header">
<th>Name</th>
<th>IPv6Enabled</th>
<th>IPv6Operational</th>
<th>IPv6FailureReason</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Ethernet</p></td>
<td><p>False</p></td>
<td><p>False</p></td>
<td><p>NicProperties</p></td>
</tr>
</tbody>
</table>

 

The Get cmdlet shows whether RSC is enabled in the interface and if TCP enables RSC to be in operational state. The failure reason provides details about the failure to enable RSC on that interface.

In the previous scenario, IPv4 RSC is supported and operational in the interface. To understand diagnostic failures, one can see the coalesced bytes or exceptions caused. This gives an indication of the coalescing issues.

``` syntax
PS C:\Users\Administrator> $x = Get-NetAdapterStatistics “myAdapter”
PS C:\Users\Administrator> $x.rscstatistics

CoalescedBytes       : 0
CoalescedPackets     : 0
CoalescingEvents     : 0
CoalescingExceptions : 0
```

### RSC and virtualization

RSC is only supported in the physical host when the host network adapter is not bound to the virtual switch. RSC is disabled by the operating system when the host is bound to the virtual switch. Also, virtual machines do not get the benefit of RSC because virtual network adapters do not support RSC.

RSC can be enabled for a virtual machine when SR-IOV is enabled. In this case, virtual functions will support RSC capability and virtual machines will also get the benefit of RSC.

## <a href="" id="resources"></a>Network adapter resources


A few network adapters actively manage their resources to achieve optimum performance. Several network adapters let the administrator manually configure resources by using the Advanced Networking tab for the adapter. For such adapters, you can set the values of a number of parameters including the number of receive buffers and send buffers.

In Windows Server 2012 and Windows Server 2012 R2, configuration has been simplified by the use of the following Windows PowerShell cmdlets:

-   Get-NetAdapterAdvancedProperty

-   Set-NetAdapterAdvancedProperty

-   Enable-NetAdapter

-   Enable-NetAdapterBinding

-   Enable-NetAdapterChecksumOffload

-   Enable-NetAdapterLso

-   Enable-NetAdapterIPSecOffload

-   Enable-NetAdapterPowerManagement

-   Enable-NetAdapterQos

-   Enable-NetAdapterRDMA

-   Enable-NetAdapterSriov

## <a href="" id="msi"></a>Message-Signaled Interrupts (MSI/MSI-X)


Network adapters that support MSI/MSI-X can target their interrupts to specific logical processors. If the adapters also support RSS, a logical processor can be dedicated to servicing interrupts and deferred procedure calls (DPCs) for a given TCP connection. This preserves the cache locality of TCP structures and greatly improves performance.

## <a href="" id="irq"></a>Interrupt moderation


To control interrupt moderation, some network adapters expose different interrupt moderation levels, or buffer coalescing parameters (sometimes separately for send and receive buffers), or both. You should consider buffer coalescing or batching when the network adapter does not perform interrupt moderation. Interrupt moderation helps reduce overall CPU utilization by minimizing the per-buffer processing cost, but the moderation of interrupts and buffer batching can have a negative impact on latency-sensitive scenarios.

## <a href="" id="features"></a>Suggested network adapter features for server roles


The following table lists the high-performance network adapter features that can improve performance in terms of throughput, latency, or scalability for some server roles.

<table>
<colgroup>
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
<col width="20%" />
</colgroup>
<thead>
<tr class="header">
<th>Server role</th>
<th>Checksum offload</th>
<th>Large Send Offload (LSO)</th>
<th>Receive-side Scaling (RSS)</th>
<th>Receive Segment Coalescing (RSC)</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>File server</p></td>
<td><p>X</p></td>
<td><p>X</p></td>
<td><p>X</p></td>
<td><p>X</p></td>
</tr>
<tr class="even">
<td><p>Web server</p></td>
<td><p>X</p></td>
<td><p>X</p></td>
<td><p>X</p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>Mail server (short-lived connections)</p></td>
<td><p>X</p></td>
<td><p></p></td>
<td><p>X</p></td>
<td><p></p></td>
</tr>
<tr class="even">
<td><p>Database server</p></td>
<td><p>X</p></td>
<td><p>X</p></td>
<td><p>X</p></td>
<td><p></p></td>
</tr>
<tr class="odd">
<td><p>FTP server</p></td>
<td><p>X</p></td>
<td><p>X</p></td>
<td><p></p></td>
<td><p>X</p></td>
</tr>
<tr class="even">
<td><p>Media server</p></td>
<td><p>X</p></td>
<td><p></p></td>
<td><p>X</p></td>
<td><p>X</p></td>
</tr>
</tbody>
</table>

 

**Caution**  
The recommendations in the table above are intended to serve as guidance only for choosing the most suitable technology for specific server roles under a predetermined traffic pattern. The user’s experience can be different, depending on workload characteristics and the hardware that is used.
