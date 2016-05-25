---
title: Windows Server Gateway Hardware and Configuration Requirements
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-networking
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f8ba42a9-8afa-440e-9244-3f12406309a1
author: vhorne
---
# Windows Server Gateway Hardware and Configuration Requirements
You can use the information in this topic to choose the correct server hardware configuration when you are deploying Windows Server Gateway in a hybrid cloud or private cloud deployment. This topic provides hardware specifications and configuration recommendations for servers that are running Hyper\-V, in addition to configuration parameters for Windows Server Gateway virtual machines \(VMs\).  
  
On each server running Hyper\-V, you can configure either two or four Windows Server Gateway VMs, depending on the requirements for your deployment. For example, if your organization is an Enterprise with a private cloud deployment, you might need only two Windows Server Gateway VMs.  
  
In another example, if your organization is a Cloud Service Provider \(CSP\) with two hundred tenants in your datacenter, you can use four Windows Server Gateway VMs, with each Windows Server Gateway VM providing routing services for fifty tenants.  
  
The following sections contain hardware and configuration requirements when you deploy Windows Server Gateway.  
  
-   [Hyper-V hardware recommendations](#bkmk_hardware)  
  
-   [Failover Clustering and Load Balancing](#bkmk_failover)  
  
-   [Hyper-V host configuration](#bkmk_host)  
  
-   [Windows Server Gateway VM configuration](#bkmk_gateway)  
  
## <a name="bkmk_hardware"></a>Hyper\-V hardware recommendations  
Following is the recommended minimum hardware configuration for each server that is running [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] and Hyper\-V.  
  
|Server component|Specification|  
|--------------------|-----------------|  
|Central Processing Unit \(CPU\)|Non\-Uniform Memory Architecture  \(NUMA\) nodes: 2|  
|Cores per NUMA node|8|  
|Hyper\-threading|Disabled. Hyper\-Threading does not improve the performance of Windows Server Gateway.|  
|Random Access Memory \(RAM\)|48 GB|  
|Network Interface Cards \(NICs\)|Two 10 GB NICs|  
  
Ensure that the number of virtual processors that are assigned to a Windows Server Gateway VM does not exceed the number of processors on the NUMA node. For example, if a NUMA node has 8 cores, the number of virtual processors should be less than or equal to 8. To find out the number of NUMA nodes and the number of cores per NUMA node, run the following Windows PowerShell script on each Hyper\-V host:  
  
```  
$nodes = [object[]] $(gwmi –Namespace root\virtualization\v2 -Class MSVM_NumaNode)  
$cores = ($nodes | Measure-Object NumberOfProcessorCores -sum).Sum  
$lps = ($nodes | Measure-Object NumberOfLogicalProcessors -sum).Sum  
  
Write-Host "Number of NUMA Nodes: ", $nodes.count  
Write-Host ("Total Number of Cores: ", $cores)  
Write-Host ("Total Number of Logical Processors: ", $lps)  
```  
  
> [!IMPORTANT]  
> Allocating virtual processors across NUMA nodes might have a negative performance impact on Windows Server Gateway. Running multiple VMs, each of which has virtual processors from one NUMA node, likely provides better aggregate performance than a single VM to which all virtual processors are assigned.  
  
Following are the recommendations when you select the number of VMs to install on each Hyper\-V host when each NUMA node has eight cores:  
  
-   Two gateway VMs with eight virtual processors each and at least 8GB RAM  
  
-   Four gateway VMs with four virtual processors each and at least 8GB RAM  
  
## <a name="bkmk_failover"></a>Failover Clustering and Load Balancing  
For load balancing and failover, it is recommended that you deploy two servers running Hyper\-V and that you configure the computers in a failover cluster, which is depicted in the following illustration.  
  
![](../Image/wsg_cl_2.jpg)  
  
In addition, you must configure the Windows Server Gateway VMs on each Hyper\-V host in individual guest clusters, so that there are either two Windows Server Gateway VM guest clusters or four Windows Server Gateway VM guest clusters. The illustration below depicts eight VMs, four on each Hyper\-V host, that are configured in four guest clusters.  
  
![](../Image/wsg_cl_3.jpg)  
  
When more than one gateway VM cluster is hosted on a two node Hyper\-V host cluster, you can distribute active gateways across the two Hyper\-V hosts to load balance the workloads.  
  
## <a name="bkmk_host"></a>Hyper\-V host configuration  
Following is the recommended configuration for each server that is running [!INCLUDE[winblue_server_1](../Token/winblue_server_1_md.md)] and Hyper\-V and whose workload is to run Windows Server Gateway VMs. These configuration instructions include the use of Windows PowerShell command examples. These examples contain placeholders for actual values that you need to provide when you run the commands in your environment. For example, network adapter name placeholders are “NIC1” and “NIC2.” When you run commands that use these placeholders, utilize the actual names of the network adapters on your servers rather than using the placeholders, or the commands will fail.  
  
> [!NOTE]  
> To run the following Windows PowerShell commands, you must be a member of the Administrators group.  
  
|Configuration item|Windows PowerShell Configuration|  
|----------------------|------------------------------------|  
|NIC Teaming|In our test environment, both NICs are connected to the same physical switch. You can use the following command to create a NIC team; ensure that you run the command with parameter values that are appropriate for your deployment.<br /><br />Code \-<br /><br />New\-NetLbfoTeam “Team” –TeamMember “NIC1”,”NIC2” –TeamingMode SwitchIndependent –LoadBalancingAlgorithm Dynamic|  
|Interrupt Moderation on physical NICs|Use default settings. To check the configuration you can use the following Windows PowerShell command:<br /><br />Code \- Get\-NetAdapterAdvancedProperty|  
|Receive Buffers size on physical NICs|You can verify whether the physical NICs support the configuration of this parameter by running the command **Get\-NetAdapterAdvancedProperty**. If they do not support this parameter, the output from the command does not include the property “Receive Buffers.” If NICs do support this parameter, you can use the following Windows PowerShell command to set the Receive Buffers size:<br /><br />Code \- Set\-NetAdapterAdvancedProperty “NIC1” –DisplayName “Receive Buffers” –DisplayValue 3000|  
|Send Buffers size on physical NICs|You can verify whether the physical NICs support the configuration of this parameter by running the command **Get\-NetAdapterAdvancedProperty**. If the NICs do not support this parameter, the output from the command does not include the property “Send Buffers.” If NICs do support this parameter, you can use the following Windows PowerShell command to set the Send Buffers size:<br /><br />Code \- Set\-NetAdapterAdvancedProperty “NIC1” –DisplayName “Transmit Buffers” –DisplayValue 3000|  
|Receive Side Scaling \(RSS\) on physical NICs|You can verify whether your physical NICs have RSS enabled by running the Windows PowerShell command **Get\-NetAdapterRss**. You can use the following Windows PowerShell commands to enable and configure RSS on your network adapters.<br /><br />Code \- Enable\-NetAdapterRss “NIC1”,”NIC2”<br />Set\-NetAdapterRss “NIC1”,”NIC2” –NumberOfReceiveQueues 16 \-MaxProcessors|  
|Virtual Machine Queue \(VMQ\) on the NIC Team|You can enable VMQ on your NIC team by using the following Windows PowerShell command.<br /><br />Code \- Enable\-NetAdapterVmq “Team”|  
  
## <a name="bkmk_gateway"></a>Windows Server Gateway VM configuration  
On both Hyper\-V hosts, you can configure two or four VMs that are configured as gateways with Windows Server Gateway. You can use Virtual Switch Manager to create a Hyper\-V Virtual Switch that is bound to the NIC team on the Hyper\-V host.  
  
After you have created Windows Server Gateway VMs, configure each Windows Server Gateway VM with four virtual network adapters that are connected to the Hyper\-V Virtual Switch that is bound to the NIC Team.  
  
Following is the recommended configuration for each Windows Server Gateway VM.  
  
|Configuration item|Windows PowerShell configuration|  
|----------------------|------------------------------------|  
|Memory|8 GB|  
|Number of virtual network adapters|4 NICs with the following specific uses: <br />1 for Management that is used by the management operating system<br />1 for Clustering<br />1 External that provides access to external networks<br />1 that is Internal that provides access to internal networks only.|  
|Receive Side Scaling \(RSS\)|You can keep the default RSS settings for the Management NIC and the Cluster NIC. The following example configuration is for a VM that has 8 virtual processors. For the External and Internal NICs, you can enable RSS with BaseProcNumber set to 0 and MaxRssProcessors set to 8 using the following Windows PowerShell command.<br /><br />Code \- Set\-NetAdapterRss “Internal”,”External” –BaseProcNumber 0 –MaxProcessorNumber 8|  
|Send Side Buffer|You can keep the default Send Side Buffer settings for the Management NIC and the Cluster NIC. For both the Internal and External NICs you can configure the Send Side Buffer with 32 MB of RAM by using the following Windows PowerShell command.<br /><br />Code \- Set\-NetAdapterAdvancedProperty “Internal”,”External” –DisplayName “Send Buffer Size” –DisplayValue “32MB”|  
|Receive Side Buffer|You can keep the default Receive Side Buffer settings for the Management NIC and the Cluster NIC. For both the Internal and External NICs you can configure the Receive Side Buffer with 16 MB of RAM by using the following Windows PowerShell command.<br /><br />Code \- Set\-NetAdapterAdvancedProperty “Internal”,”External” –DisplayName “Receive Buffer Size” –DisplayValue “16MB”|  
|Forward Optimization|You can keep the default Forward Optimization settings for the Management NIC and the Cluster NIC. For both the Internal and External NICs you can enable Forward Optimization by using the following Windows PowerShell command.<br /><br />Code \- Set\-NetAdapterAdvancedProperty “Internal”,”External” –DisplayName “Forward Optimization” –DisplayValue “1”|  
  
## See Also  
[Windows Server Gateway](assetId:///e39e8b8c-a23c-4dbd-b895-d1e3f2885e9e)  
  
