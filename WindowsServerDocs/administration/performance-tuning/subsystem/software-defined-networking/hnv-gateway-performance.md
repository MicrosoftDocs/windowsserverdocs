---
title: HNV Gateway Performance Tuning in Software Defined Networks  
description: HNV gateway performance tuning guidelines on Software Defined Networks
ms.prod: windows-server
ms.technology: performance-tuning-guide
ms.topic: article
ms.author: grcusanz; AnPaul
author: phstee
ms.date: 10/16/2017
---

# HNV Gateway Performance Tuning in Software Defined Networks

This topic provides hardware specifications and configuration recommendations for servers that are running Hyper-V and hosting Windows Server Gateway virtual machines, in addition to configuration parameters for Windows Server Gateway virtual machines (VMs). To extract best performance from Windows Server gateway VMs, it is expected that these guidelines will be followed.
The following sections contain hardware and configuration requirements when you deploy Windows Server Gateway.
1. Hyper-V hardware recommendations
2. Hyper-V host configuration
3. Windows Server gateway VM configuration

## Hyper-V hardware recommendations

Following is the recommended minimum hardware configuration for each server that is running Windows Server 2016 and Hyper-V.

| Server Component               | Specification                                                                                                                                                                                                                                                                   |
|--------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Central Processing Unit (CPU)  | Non-Uniform Memory Architecture (NUMA) nodes: 2 <br> If there are multiple Windows Server gateway VMs on the host, for best performance, each gateway VM should have full access to one NUMA node. And it should be different from the NUMA node used by the host physical adapter. |
| Cores per NUMA node            | 2                                                                                                                                                                                                                                                                               |
| Hyper-Threading                | Disabled. Hyper-Threading does not improve the performance of Windows Server Gateway.                                                                                                                                                                                           |
| Random Access Memory (RAM)     | 48 GB                                                                                                                                                                                                                                                                           |
| Network Interface Cards (NICs) | Two 10 GB NICs,The gateway performance will depend on the line rate. If the line rate is less than 10Gbps, the gateway tunnel throughput numbers will also go down by the same factor.                                                                                          |

Ensure that the number of virtual processors that are assigned to a Windows Server Gateway VM does not exceed the number of processors on the NUMA node. For example, if a NUMA node has 8 cores, the number of virtual processors should be less than or equal to 8. For best performance, it should be 8. To find out the number of NUMA nodes and the number of cores per NUMA node, run the following Windows PowerShell script on each Hyper-V host:

```PowerShell
$nodes = [object[]] $(gwmi –Namespace root\virtualization\v2 -Class MSVM_NumaNode)
$cores = ($nodes | Measure-Object NumberOfProcessorCores -sum).Sum
$lps = ($nodes | Measure-Object NumberOfLogicalProcessors -sum).Sum


Write-Host "Number of NUMA Nodes: ", $nodes.count
Write-Host ("Total Number of Cores: ", $cores)
Write-Host ("Total Number of Logical Processors: ", $lps)
```

>[!Important]
> Allocating virtual processors across NUMA nodes might have a negative performance impact on Windows Server Gateway. Running multiple VMs, each of which has virtual processors from one NUMA node, likely provides better aggregate performance than a single VM to which all virtual processors are assigned.

One gateway VM with eight virtual processors and at least 8GB RAM is recommended when selecting the number of gateway VMs to install on each Hyper-V host when each NUMA node has eight cores. In this case, one NUMA node is dedicated to the host machine.

## Hyper-V Host configuration

Following is the recommended configuration for each server that is running Windows Server 2016 and Hyper-V and whose workload is to run Windows Server Gateway VMs. These configuration instructions include the use of Windows PowerShell command examples. These examples contain placeholders for actual values that you need to provide when you run the commands in your environment. For example, network adapter name placeholders are "NIC1" and "NIC2." When you run commands that use these placeholders, utilize the actual names of the network adapters on your servers rather than using the placeholders, or the commands will fail.

>[!Note]
> To run the following Windows PowerShell commands, you must be a member of the Administrators group.

| Configuration Item                          | Windows Powershell Configuration                                                                                                                                                                                                                                                                                                                                                                                                                                                                          |
|---------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Switch Embedded Teaming                     | When you create a vswitch with multiple network adapters, it automatically enabled switch embedded teaming for those adapters. <br> ```New-VMSwitch -Name TeamedvSwitch -NetAdapterName "NIC 1","NIC 2"``` <br> Traditional teaming through LBFO is not supported with SDN in Windows Server 2016. Switch Embedded Teaming allows you to use the same set of NICs for your virtual traffic and RDMA traffic. This was not supported with NIC teaming based on LBFO.                                                        |
| Interrupt Moderation on physical NICs       | Use default settings. To check the configuration, you can use the following Windows PowerShell command: ```Get-NetAdapterAdvancedProperty```                                                                                                                                                                                                                                                                                                                                                                    |
| Receive Buffers size on physical NICs       | You can verify whether the physical NICs support the configuration of this parameter by running the command  ```Get-NetAdapterAdvancedProperty```. If they do not support this parameter, the output from the command does not include the property "Receive Buffers." If NICs do support this parameter, you can use the following Windows PowerShell command to set the Receive Buffers size: <br>```Set-NetAdapterAdvancedProperty "NIC1" –DisplayName "Receive Buffers" –DisplayValue 3000``` <br>                          |
| Send Buffers size on physical NICs          | You can verify whether the physical NICs support the configuration of this parameter by running the command ```Get-NetAdapterAdvancedProperty```. If the NICs do not support this parameter, the output from the command does not include the property "Send Buffers." If NICs do support this parameter, you can use the following Windows PowerShell command to set the Send Buffers size: <br> ```Set-NetAdapterAdvancedProperty "NIC1" –DisplayName "Transmit Buffers" –DisplayValue 3000``` <br>                           |
| Receive Side Scaling (RSS) on physical NICs | You can verify whether your physical NICs have RSS enabled by running the Windows PowerShell command Get-NetAdapterRss. You can use the following Windows PowerShell commands to enable and configure RSS on your network adapters: <br> ```Enable-NetAdapterRss "NIC1","NIC2"```<br> ```Set-NetAdapterRss "NIC1","NIC2" –NumberOfReceiveQueues 16 -MaxProcessors``` <br> NOTE: If VMMQ or VMQ is enabled, RSS does not have to be enabled on the physical network adapters. You can enable it on the host virtual network adapters |
| VMMQ                                        | To enable VMMQ for a VM, run the following command: <br> ```Set-VmNetworkAdapter -VMName <gateway vm name>,-VrssEnabled $true -VmmqEnabled $true``` <br> NOTE: Not all network adapters support VMMQ. Currently, it is supported on Chelsio T5 and T6, Mellanox CX-3 and CX-4, and QLogic 45xxx series                                                                                                                                                                                                                                      |
| Virtual Machine Queue (VMQ) on the NIC Team | You can enable VMQ on your SET team by using the following Windows PowerShell command: <br>```Enable-NetAdapterVmq``` <br> NOTE: This should be enabled only if the HW does not support VMMQ. If supported, VMMQ should be enabled for better performance.                                                                                                                                                                                                                                                               |
>[!Note]
> VMQ and vRSS come into picture only when the load on the VM is high and the CPU is being utilized to the maximum. Only then will at least one processor core max out. VMQ and vRSS will then be beneficial to help spread the processing load across multiple cores. This is not applicable for IPsec traffic as IPsec traffic is confined to a single core.

## Windows Server Gateway VM configuration

On both Hyper-V hosts, you can configure multiple VMs that are configured as gateways with Windows Server Gateway. You can use Virtual Switch Manager to create a Hyper-V Virtual Switch that is bound to the NIC team on the Hyper-V host. Note that for best performance, you should deploy a single gateway VM on a Hyper-V host.
Following is the recommended configuration for each Windows Server Gateway VM.

| Configuration Item                 | Windows Powershell Configuration                                                                                                                                                                                                                                                                                                                                                               |
|------------------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Memory                             | 8 GB                                                                                                                                                                                                                                                                                                                                                                                           |
| Number of virtual network adapters | 3 NICs with the following specific uses: 1 for Management that is used by the management operating system, 1 External that provides access to external networks, 1 that is Internal that provides access to internal networks only.                                                                                                                                                            |
| Receive Side Scaling (RSS)         | You can keep the default RSS settings for the Management NIC. The following example configuration is for a VM that has 8 virtual processors. For the External and Internal NICs, you can enable RSS with BaseProcNumber set to 0 and MaxRssProcessors set to 8 using the following Windows PowerShell command: <br> ```Set-NetAdapterRss "Internal","External" –BaseProcNumber 0 –MaxProcessorNumber 8``` <br> |
| Send side buffer                   | You can keep the default Send Side Buffer settings for the Management NIC. For both the Internal and External NICs you can configure the Send Side Buffer with 32 MB of RAM by using the following Windows PowerShell command: <br> ```Set-NetAdapterAdvancedProperty "Internal","External" –DisplayName "Send Buffer Size" –DisplayValue "32MB"``` <br>                                                       |
| Receive Side buffer                | You can keep the default Receive Side Buffer settings for the Management NIC. For both the Internal and External NICs, you can configure the Receive Side Buffer with 16 MB of RAM by using the following Windows PowerShell command: <br> ```Set-NetAdapterAdvancedProperty "Internal","External" –DisplayName "Receive Buffer Size" –DisplayValue "16MB"``` <br>                                            |
| Forward Optimization               | You can keep the default Forward Optimization settings for the Management NIC. For both the Internal and External NICs, you can enable Forward Optimization by using the following Windows PowerShell command: <br> ```Set-NetAdapterAdvancedProperty "Internal","External" –DisplayName "Forward Optimization" –DisplayValue "1"``` <br>                                                                      |
