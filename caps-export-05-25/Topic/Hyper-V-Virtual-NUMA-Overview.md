---
title: Hyper-V Virtual NUMA Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 73e62bad-5356-4c2b-b837-0dd9ca542135
author: cwatsonmsft
---
# Hyper-V Virtual NUMA Overview
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] introduced support for projecting a virtual NUMA topology into Hyper\-V virtual machines. This capability can help improve the performance of workloads running on virtual machines that are configured with large amounts of memory. This document briefly defines what NUMA is, explains how applications can take advantage of NUMA to optimize their performance, describes how virtual NUMA can be configured, and provides guidance about understanding virtual NUMA and its impact on virtual machine workloads.  
  
This document is intended for Hyper\-V administrators who are running high\-performance NUMA\-aware applications \(such as database servers and web servers\), and for system or software architects looking for information about virtual NUMA.  
  
This topic includes the following sections:  
  
-   [Introduction to NUMA](../Topic/Hyper-V-Virtual-NUMA-Overview.md#bkmk_Intro)  
  
-   [NUMA topology in Hyper\-V virtual machines](../Topic/Hyper-V-Virtual-NUMA-Overview.md#bkmk_NUMA_VM)  
  
-   [Configuring virtual NUMA](../Topic/Hyper-V-Virtual-NUMA-Overview.md#bkmk_Config)  
  
-   [Virtual NUMA and Dynamic Memory](../Topic/Hyper-V-Virtual-NUMA-Overview.md#BKMK_NUMA_DM)  
  
-   [Virtual NUMA FAQs](../Topic/Hyper-V-Virtual-NUMA-Overview.md#bkmk_FAQ)  
  
## <a name="bkmk_Intro"></a>Introduction to NUMA  
Non\-Uniform Memory Access \(NUMA\) is a computer system architecture that is used with multiprocessor designs in which some regions of memory have greater access latencies. This is due to how the system memory and processors are interconnected. Some memory regions are connected directly to one or more processors, with all processors connected to each other through various types of interconnection fabric. For large multiprocessor systems, this arrangement results in less contention for memory and increased system performance.  
  
A NUMA architecture divides memory and processors into groups, called *NUMA nodes*. From the perspective of any single processor in the system, memory that is in the same NUMA node as that processor is referred to as *local*, and memory that is contained in another NUMA node is referred to as *remote*. Processors can access local memory faster.  
  
Most modern operating systems and many high\-performance applications that typically scale to utilize many processors and large amounts of memory, such as Microsoft SQL Server, include optimizations that recognize and adapt to a computer’s NUMA topology. To avoid remote access penalties, a NUMA\-aware application attempts to allocate storage for data and schedule processor threads to access that data in the same NUMA node. These optimizations minimize memory access latencies and reduce memory interconnect traffic.  
  
## <a name="bkmk_NUMA_VM"></a>NUMA topology in Hyper\-V virtual machines  
When a virtual machine is started, Hyper\-V attempts to allocate all the memory for that virtual machine from a single physical NUMA node, if sufficient memory is available. If the memory requirements for the virtual machine cannot be satisfied from a single node, Hyper\-V allocates memory from another physical NUMA node. This is known as NUMA spanning. For more information about NUMA Spanning, see the [Server setting – NUMA Spanning](../Topic/Hyper-V-Virtual-NUMA-Overview.md#bkmk_NUMA_Spanning) section later in this document.  
  
### Virtual NUMA  
To enable virtualizing large scale\-up workloads, Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] offers expanded virtual machine scale limits. A single virtual machine can be assigned up to 64 virtual processors and 1 TB of memory. When creating much larger virtual machines, memory from multiple NUMA nodes on the host system will likely be utilized. In such a virtual machine configuration, if the virtual processors and memory continue to be allocated from a single NUMA node, workloads would not be taking advantage of NUMA optimizations, and performance will suffer.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Hyper\-V presents a virtual NUMA topology to virtual machines. By default, this virtual NUMA topology is optimized to match the NUMA topology of the underlying host computer. Exposing a virtual NUMA topology into a virtual machine allows the guest operating system and any NUMA\-aware applications running within it to take advantage of the NUMA performance optimizations, just as they would when running on a physical computer.  
  
There is no distinction between a virtual and a physical NUMA from the workload’s perspective. Inside a virtual machine, when a workload allocates local memory for data, and accesses that data in the same NUMA node, fast local memory access results on the underlying physical system. Performance penalties due to remote memory access are successfully avoided.  
  
## <a name="bkmk_Config"></a>Configuring Virtual NUMA  
Virtual NUMA is configured in the following locations:  
  
-   [Host settings – NUMA Spanning](../Topic/Hyper-V-Virtual-NUMA-Overview.md#bkmk_NUMA_Spanning)  
  
-   [Virtual machine settings \- NUMA](../Topic/Hyper-V-Virtual-NUMA-Overview.md#BKMK_VM_Settings)  
  
### <a name="bkmk_NUMA_Spanning"></a>Host settings – NUMA Spanning  
This setting affects all virtual machines on the server running Hyper\-V. The NUMA spanning setting determines virtual machine behavior when there is not enough memory on the host to perform an optimal mapping between the virtual NUMA nodes and the host’s physical NUMA nodes. This setting affects the following virtual machine operations:  
  
-   Startup  
  
-   Restore  
  
-   Migration  
  
When NUMA spanning is enabled and one or more virtual NUMA nodes must be split between two or more physical NUMA nodes due to memory constraints, the virtual machines are still allowed to start, or be restored or migrated to another host. This splitting, however, results in a suboptimal mapping between virtual and physical NUMA nodes. Even NUMA\-aware workloads may perform sub optimally; for example, memory access within the virtual machine that appears to be local can actually become remote on the host’s physical NUMA topology. Additionally, because mapping virtual NUMA nodes to physical NUMA nodes can vary based on memory availability at the time the virtual machine is started, performance may be inconsistent across virtual machine restarts.  
  
This virtual NUMA to physical NUMA split can occur in the following scenarios:  
  
-   A virtual machine has been configured with virtual NUMA nodes larger than the host’s physical NUMA nodes. This might be caused by manual configuration of the virtual machine’s NUMA settings, or because the virtual machine was initially created on a server running Hyper\-V and then moved to a server that has a different physical NUMA topology.  
  
-   The current distribution of available memory across the physical NUMA nodes requires that at least one virtual NUMA node be backed by memory on multiple physical NUMA nodes. Uneven distribution of available memory could be caused by the memory usage of other virtual machines or by the host computer system.  
  
> [!IMPORTANT]  
> NUMA spanning is enabled by default.  
  
When NUMA Spanning is disabled, Hyper\-V will not start, restore, or accept a live migration of a virtual machine if it would be forced to split a virtual NUMA node between two or more physical NUMA nodes. This ensures that virtual machines always run with optimal performance. Each virtual NUMA node is backed by one physical NUMA node, and the virtual NUMA topology aligns exactly with the physical server’s NUMA topology. This setting is recommended for NUMA\-aware workloads that require optimal performance at all times, but it might cause a virtual machine to not start, restore, or migrate.  
  
> [!NOTE]  
> The NUMA spanning setting applies to all the virtual machines on the server running Hyper\-V.  
  
The following table lists the benefits and disadvantages of enabling or disabling NUMA spanning.  
  
|NUMA Spanning|Benefits|Disadvantages|  
|-----------------|------------|-----------------|  
|Enabled \(default setting\)|-   Virtual machines can utilize whatever memory is available on the host, regardless of the distribution across physical NUMA nodes.<br />-   Virtual machines will start regardless of their virtual NUMA topology, even if it does not align well with the host’s physical NUMA topology.<br />-   Virtual machines with Dynamic Memory enabled can use all available system resources, even if those resources come from multiple physical NUMA nodes.|-   Virtual machine performance may vary between virtual machine restarts.<br />-   Virtual NUMA alignment may vary between boots.<br />-   NUMA\-aware workloads may not perform optimally because virtual NUMA topologies may not align well with physical NUMA topologies.|  
|Disabled|-   NUMA\-aware workloads perform optimally because virtual NUMA topologies will align with physical NUMA topologies.<br />-   Virtual machine performance is consistent between reboots.|-   Virtual machines will fail to start if any virtual NUMA node cannot be placed entirely within a single physical NUMA node.<br />-   Virtual machines may fail to migrate to a given host if their virtual NUMA topologies aren’t configured to align with the target host’s physical NUMA topology.<br />-   Virtual machines with Dynamic Memory enabled cannot use more processors or memory than available in a single physical NUMA node.|  
  
### <a name="BKMK_VM_Settings"></a>Virtual machine settings \- NUMA  
The virtual NUMA topology can be configured for each individual virtual machine. The maximum amount of memory and the maximum number of virtual processors in each virtual NUMA node can be configured, in addition to the maximum number of virtual NUMA nodes presented in each virtualized socket. By default, these values are set to align with the host’s physical NUMA topology.  
  
Maximum values are set to the highest that allow a single virtual NUMA node to be contained entirely within a physical NUMA node on the host. These default values account for virtualization overheads, such as memory that is required by virtual devices. If changes have been made to these settings or the virtual machine has been moved to host with a different physical NUMA topology, you can restore the default virtual NUMA topology by clicking **Use Hardware Topology** on the **NUMA Configuration** page in the settings of a virtual machine.  
  
If a virtual machine will be moved or migrated between multiple hosts with different physical NUMA topologies, and NUMA spanning has been disabled, configure the virtual NUMA setting for each virtual machine to the lowest default value that is available across the potential hosts. This ensures the virtual NUMA topology for the virtual machine will fit within the physical NUMA topology on each host that it could be migrated to—which is required when NUMA spanning is disabled.  
  
## <a name="BKMK_NUMA_DM"></a>Virtual NUMA and Dynamic Memory  
Virtual NUMA and Dynamic Memory features cannot be used at the same time. A virtual machine that has Dynamic Memory enabled effectively has only one virtual NUMA node, and no NUMA topology is presented to the virtual machine regardless of the virtual NUMA settings. As a result, the NUMA spanning setting must be enabled when you have virtual machines that are large enough to be split between two or more physical NUMA nodes. If the NUMA spanning setting is disabled, the virtual machine must fit entirely within a single physical NUMA node, or the virtual machine will not start, or be restored or migrated.  
  
Workloads that are not NUMA\-aware will not take advantage of virtual NUMA. However, the guest operating system may perform some NUMA optimization. Enabling Dynamic Memory \(therefore presenting only a single virtual NUMA\) should not cause performance degradation.  
  
Similarly, virtual machines that are not large enough to consume resources from multiple physical NUMA nodes receive no benefit from enabling virtual NUMA. Enabling Dynamic Memory, and so presenting only a single virtual NUMA node, will not cause any performance\-related degradation.  
  
When trying to decide which feature to use, you should take the following questions into consideration. If the answer to both is yes, enable virtual NUMA and do not enable Dynamic Memory.  
  
1.  Is the workload running in the virtual machine NUMA\-aware?  
  
2.  Will the virtual machine consume more resources, processors, or memory than are available on a single physical NUMA node?  
  
> [!IMPORTANT]  
> -   If a virtual machine is configured through Hyper\-V Manager, Windows PowerShell, or the virtualization v1 namespace for WMI \(root\\virtualization\\v1\), enabling Dynamic Memory automatically disables virtual NUMA. Similarly, disabling Dynamic Memory automatically enables virtual NUMA when the virtual machine has enough virtual processors to warrant it.  
> -   If a virtual machine is configured through the virtualization v2 namespace for WMI \(root\\virtualization\\v2\), the two features are configured independently, and an error will result if both features are enabled simultaneously.  
  
For more information about Dynamic Memory, see [Hyper-V Dynamic Memory Overview](../Topic/Hyper-V-Dynamic-Memory-Overview.md) topic.  
  
## <a name="bkmk_FAQ"></a>Virtual NUMA FAQs  
This section explains some questions that are commonly asked about virtual NUMA.  
  
### Why is NUMA virtualized in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]?  
Prior to [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], all virtual processors and memory were presented to a virtual machine as if they belonged to the same NUMA node, irrespective of the host’s physical hardware topology. At the time, this was reasonable given that virtual machines could be configured with a maximum of four virtual processors.  
  
In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], virtual machines can have up to 64 virtual processors and 1 TB of memory. At this scale, virtual machines must utilize memory and processors from multiple physical NUMA nodes simultaneously. If the virtual processors and memory continued to be presented to the virtual machine as belonging to the same NUMA node, performance \(especially for NUMA\-aware scale up workloads\) would suffer.  
  
### Do all virtual machines take advantage of virtual NUMA?  
No, only virtual machines running NUMA\-aware workloads that are large enough to require resources from more than one physical NUMA node, and are not configured to use Dynamic Memory, will benefit from virtual NUMA.  
  
### How much of a benefit does virtual NUMA provide?  
A number of factors contribute, such as the architecture of the host’s memory bus and processors, the topology to which the memory and processors are connected, how the memory is physically installed on the motherboards, the memory allocation techniques in use, and the workload’s memory access patterns. The simplest way to find out is to benchmark your workload with virtual NUMA disabled, and then again with virtual NUMA enabled.  
  
### Can virtual NUMA and Dynamic Memory be used together?  
No. Virtual NUMA and Dynamic Memory cannot be used together by a virtual machine. When Dynamic Memory is enabled, a single virtual NUMA node will be presented to the virtual machine regardless of the virtual NUMA settings, and virtual NUMA is disabled. When trying to decide which feature to use, you should consider the following questions. If the answer to both is yes, enable virtual NUMA.  
  
1.  Is the workload running in the virtual machine NUMA\-aware?  
  
2.  Will the virtual machine consume more resources, processors, or memory than are available on a single physical NUMA node?  
  
### How can I tell if my system in NUMA\-based?  
The Get\-VMHostNumaNode Windows PowerShell cmdlet gets the NUMA topology of a Hyper\-V host and returns an object for each of the host’s NUMA nodes. If the results return more than one NUMA node, your host is NUMA based. However, if the results return one node, your host is not NUMA based.  
  
**Example of a NUMA based host**  
  
```  
PS C:\> Get-VMHostNumaNode  
  
NodeId                 : 0  
ProcessorsAvailability : {94, 99, 100, 100}  
MemoryAvailable        : 3196  
MemoryTotal            : 4093  
ComputerName           : ServerName_01  
  
NodeId                 : 1  
ProcessorsAvailability : {66, 73, 98, 99}  
MemoryAvailable        : 2533  
MemoryTotal            : 4096  
ComputerName           : ServerName_01  
  
```  
  
### How can I determine if a virtual machine’s performance is being impacted by NUMA spanning?  
Hyper\-V provides performance counters that enable you to judge how well a virtual machine’s virtual NUMA nodes align with the host’s physical NUMA nodes. You can look at the following counters:  
  
-   **Hyper\-V VM Vid Partition : Remote Physical Pages** Indicates how many of a virtual machine’s memory pages were allocated on a non\-aligned physical NUMA node.  
  
-   **Hyper\-V VM Vid Partition : Physical Pages Allocated** Indicates how many memory pages a virtual machine has in total.  
  
If the **Remote Physical Pages** counter is zero, the virtual machine is perfectly aligned. If the **Remote Physical Pages** counter is not zero, comparing it with the total number of memory pages. The **Physical Pages Allocated** counter enables you to determine the percentage of the virtual machine’s memory that is split between more than one physical NUMA node.  
  
Performance counters information can be retrieved through Performance monitor or the Get\-Counter cmdlet.  
  
**Example**  
  
In this example, the Get\-Counter cmdlet reveals that a virtual machine’s virtual NUMA topology exactly matches the host’s physical NUMA topology.  
  
```  
PS C:\> Get-Counter "\Hyper-V VM VID Partition(*)\*"  
  
Timestamp                 CounterSamples  
---------                 --------------  
5/30/2013 2:42:04 PM      \\ServerName_01\hyper-v vm vid partition(_total)\remote physical pages :  
                          0  
  
                          \\ServerName_01\hyper-v vm vid partition(_total)\preferred numa node index :  
                          1  
  
                          \\ServerName_01\hyper-v vm vid partition(_total)\physical pages allocated :  
                          526344  
  
                          \\ServerName_01\hyper-v vm vid partition(Windows® server 2012 - server 1)\remote physical pages :  
                          0  
  
                          \\ServerName_01\hyper-v vm vid partition(Windows® server 2012 - server 1)\preferred numa node index :  
                          1  
  
                          \\ServerName_01\hyper-v vm vid partition(Windows® server 2012 - server 1)\physical pages allocated :  
                          526344  
  
```  
  
### What can I do if a performance counters indicate that a virtual machine’s virtual NUMA nodes do not align well with the Hyper\-V host’s physical NUMA topology?  
First, determine if the virtual machine’s workload is performing well. If it’s already performing well, the workload may not depend heavily on memory access latency, or your host may provide remote memory access latencies that are low enough that the misalignment does not cause any impact.  
  
If the workload is not performing optimally, and performance counters indicate a large proportion of the virtual machine’s memory is allocated on misaligned physical NUMA nodes, consider the following actions:  
  
-   Ensure that the configured NUMA topology of the virtual machine aligns well with the Hyper\-V host. Try resetting the virtual machine’s NUMA settings to their default values. For more information about resetting a virtual machine’s NUMA settings, see the [Virtual machine settings \- NUMA](../Topic/Hyper-V-Virtual-NUMA-Overview.md#BKMK_VM_Settings) section.  
  
-   If you have multiple Hyper\-V hosts, consider moving the virtual machine to another host. The distribution of available memory across NUMA nodes on the current host may not be ideal with the memory that was allocated for the virtual machine.  
  
-   Consider disabling the Hyper\-V NUMA spanning setting. For more information about the Hyper\-V NUMA spanning setting, see the [Host  settings – NUMA Spanning](../Topic/Hyper-V-Virtual-NUMA-Overview.md#bkmk_NUMA_Spanning) section.  
  
### How can I see which physical NUMA nodes a virtual machine is using?  
To see which physical NUMA nodes a virtual machine is using, copy and save the following script and run it on your server running Hyper\-V. See the example for the required script syntax.  
  
**Example**  
  
In this example, the virtual NUMA topology matches the physical NUMA topology. Each virtual NUMA node fits in a physical NUMA node without the need to split the virtual NUMA nodes between more than one physical NUMA node. Virtual NUMA node number 0 resides in physical NUMA node 3.  
  
```  
PS C:\> .\Users\vmuser\Desktop\GetBackingPhyNumaNode.ps1 -VmName NumaTest  
  
VMName                                   : NumaTest  
vNUMANode                                : 0,          1,            2  
VMMem                                    : 6828,       6826,        6826  
PhyNUMANode                              : 3,          1,            2  
PhyNUMANodeMemRemaining                  : 1836,       1840,        1840  
  
```  
  
**Sample code**  
  
```  
param ($VmName=$(throw "Please provide the name of the virtual machine whose virtual to physical NUMA mapping is to be found"))  
  
$Namespace = 'root\virtualization\v2'  
  
$RUNNING=2  
$STOPPED=3  
  
$VNUMA = New-Object System.Object  
[Array]$vNodes = @()  
  
function EditMember  
{  
    param ($Object=$(throw "Please provide the name of the class to be modified"), `  
            $MemberName=$(throw "Please provide the name of the member to be modified"), `  
            $MemberValue=$(throw "Please provide the value with which the member is to be modified"))  
  
    if ($MemberValue -isnot [String])  
    {  
        $MemberValue = [System.Convert]::ToString($MemberValue)  
    }  
  
    $Error.Clear()  
    $currValue = Get-Member -InputObject $Object -Name $MemberName  
    if ($currValue -eq $null)  
    {  
        $Object | Add-Member -MemberType NoteProperty -Name $MemberName -Value $MemberValue  
    }  
    else  
    {  
        $Object.$MemberName += ", " + $MemberValue  
    }  
}  
  
$vms = $null  
  
if ($VmName -eq "*")  
{  
    $vms = GWMI -n $Namespace Msvm_ComputerSystem | ? { $_.ElementName -ne $_.__SERVER }  
}  
else  
{  
    $vms = GWMI -n $Namespace Msvm_ComputerSystem | ? { $_.ElementName -eq $VmName }  
}  
  
if ($vms -eq $null)  
{  
    Throw "$VmName does not seem to exist on $($ENV:COMPUTERNAME)"  
}  
  
$vmIndex = 0  
$vms | % {  
    $VNUMA = New-Object System.Object  
  
    $vm = $_  
    $VNUMA | Add-Member -MemberType NoteProperty -Name VMName -Value $($vm.ElementName)  
    $vmMem = GWMI -N $Namespace Msvm_Memory | ? { $_.Name.Contains($vm.Name) }  
    $vmMemStg = GWMI -n $Namespace Msvm_MemorySettingData | ? { $_.__PATH.Contains($vm.Name) }  
  
    if ($($vm.EnabledState) -ne $RUNNING)  
    {  
        if ($vmMemStg -is [Array])  
        {  
            $vmMemStg = $vmMemStg[0]  
        }  
        EditMember -Object $VNUMA -MemberName vNUMANode -MemberValue "NA (Off)"  
        EditMember -Object $VNUMA -MemberName VMMem -MemberValue $($vmMemStg.VirtualQuantity)  
        EditMember -Object $VNUMA -MemberName PhyNUMANode -MemberValue "NA"  
        EditMember -Object $VNUMA -MemberName PhyNUMANodeMemRemaining -MemberValue "NA"  
    }  
    else  
    {  
        if ($vmMem -is [Array])  
        {  
            $vmMem | % {  
                if (-not $_.DeviceID.EndsWith("Aggregate"))  
                {  
                    $memSrcNode = $_.GetRelated("Msvm_NumaNode")  
                    EditMember -Object $VNUMA -MemberName vNUMANode -MemberValue $($_.DeviceID.Split("\")[1])  
                    EditMember -Object $VNUMA -MemberName VMMem -MemberValue $($_.NumberOfBlocks)  
                    if ($memSrcNode -ne $null)  
                    {  
                        EditMember -Object $VNUMA -MemberName PhyNUMANode -MemberValue $($($($_.GetRelated("Msvm_NumaNode")).NodeId).Split("\")[1])  
                        EditMember -Object $VNUMA -MemberName PhyNUMANodeMemRemaining -MemberValue $($($_.GetRelated("Msvm_NumaNode")).CurrentlyConsumableMemoryBlocks)  
                    }  
                    else  
                    {  
                        EditMember -Object $VNUMA -MemberName PhyNUMANode -MemberValue "Multi"  
                        EditMember -Object $VNUMA -MemberName PhyNUMANodeMemRemaining -MemberValue "NA"  
                    }  
                }  
            }  
        }  
        else  
        {  
            $memSrcNode = $vmMem.GetRelated("Msvm_NumaNode")  
            if ($memSrcNode -ne $null)  
            {  
                EditMember -Object $VNUMA -MemberName vNUMANode -MemberValue $($vmMem.DeviceID.Split("\")[1])  
                EditMember -Object $VNUMA -MemberName VMMem -MemberValue $($vmMem.NumberOfBlocks)  
                EditMember -Object $VNUMA -MemberName PhyNUMANode -MemberValue $($($($vmMem.GetRelated("Msvm_NumaNode")).NodeId).Split("\")[1])  
                EditMember -Object $VNUMA -MemberName PhyNUMANodeMemRemaining -MemberValue $($($vmMem.GetRelated("Msvm_NumaNode")).CurrentlyConsumableMemoryBlocks)  
            }  
            else  
            {  
                EditMember -Object $VNUMA -MemberName vNUMANode -MemberValue "NA"  
                if ($vmMemStg.DynamicMemoryEnabled -eq $true)  
                {  
                    EditMember -Object $VNUMA -MemberName VMMem -MemberValue "Dynamic"  
                }  
                else  
                {  
                    EditMember -Object $VNUMA -MemberName VMMem -MemberValue "Multi"  
                }  
                EditMember -Object $VNUMA -MemberName PhyNUMANode -MemberValue "NA"  
                EditMember -Object $VNUMA -MemberName PhyNUMANodeMemRemaining -MemberValue "NA"  
            }  
        }  
    }  
  
    $vNodes += $VNUMA  
}  
  
$vNodes  
```  
  
### Why do I see that a virtual machine is assigned memory from different physical NUMA nodes than expected?  
Other virtual machines running on the host will dictate which physical NUMA nodes can best be used to provide memory. When the NUMA spanning setting is enabled, Hyper\-V may choose NUMA distributions that don’t seem to match the physical host well, but this configuration makes sense in the context of the other running virtual machines. Disabling the NUMA spanning setting can make the NUMA distribution of memory more predictable, but virtual machines may fail to start if this predictable  distribution cannot be supported with the currently available resources. For more information about NUMA spanning, see the [Host setting – NUMA Spanning](../Topic/Hyper-V-Virtual-NUMA-Overview.md#bkmk_NUMA_Spanning) section.  
  
