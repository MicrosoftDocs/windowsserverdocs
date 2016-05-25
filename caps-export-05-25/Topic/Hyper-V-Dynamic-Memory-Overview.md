---
title: Hyper-V Dynamic Memory Overview
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: de6ce015-ff1f-4f77-81f1-a9b1a9f0b08b
author: cwatsonmsft
---
# Hyper-V Dynamic Memory Overview
If you have idle or low\-load virtual machines, as in pooled Virtual Desktop Infrastructure \(VDI\) environments, Dynamic Memory enables you to increase consolidation and improve reliability for restart operations. You also gain agility in responding to requirement changes with these new capabilities.  
  
## Key benefits  
With the Dynamic Memory improvements for Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], you can attain higher consolidation numbers with improved reliability for restart operations. This can lead to lower costs, especially in environments that have many idle or low\-load virtual machines, such as pooled VDI environments. Dynamic Memory run\-time configuration changes  can reduce downtime and provide increased agility to respond to requirement changes.  
  
## Technical overview  
Dynamic Memory, introduced in Windows Server 2008 R2 Service Pack 1 \(SP1\), defined startup memory as the minimum amount of memory that a virtual machine can have. However, Windows requires more memory during startup than the steady state. As a result, administrators sometimes assign extra memory to a virtual machine because Hyper\-V cannot reclaim memory from these virtual machines after startup. In [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], Dynamic Memory introduces a minimum memory setting, which allows Hyper\-V to reclaim the unused memory from the virtual machines. This is reflected as increased virtual machine consolidation numbers, especially in Virtual Desktop Infrastructure \(VDI\) environments.  
  
[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] also introduces Smart Paging for reliable virtual machine restart operations. Although minimum memory increases virtual machine consolidation numbers, it also brings a challenge. If a virtual machine has a smaller amount of memory than its startup memory and if it is restarted, Hyper\-V needs additional memory to restart the virtual machine. Due to host memory pressure or virtual machine states, Hyper\-V may not always have additional memory available. This can cause sporadic virtual machine restart failures. Smart Paging is used to bridge the memory gap between minimum memory and startup memory, and allow virtual machines to restart reliably.  
  
### Minimum memory configuration with reliable restart operation  
As in the previous version of Dynamic Memory, you can configure a minimum memory amount for virtual machines, and Hyper\-V continues to ensure that this amount is always assigned to running virtual machines.  
  
To provide a reliable restart experience for the virtual machines configured with less minimum memory than startup memory, Hyper\-V uses Smart Paging. This memory management method uses disk resources as additional, temporary memory when more memory is required to restart a virtual machine. This approach has advantages and drawbacks. It provides a reliable way to keep the virtual machines running when there is no available physical memory. However, it can degrade virtual machine performance because disk access speeds are much slower than memory access speeds.  
  
> [!IMPORTANT]  
> When installing or upgrading the operating system of a virtual machine, the amount of memory that is available to the virtual machine during the installation and upgrade process is the value specified as **Startup RAM**. Even if Dynamic Memory has been configured for the virtual machine, the virtual machine only uses the amount of memory as configured in the **Startup RAM** setting. Ensure the **Startup\-RAM** value meets the minimum memory requirements of the operating system during the install or upgrade procedure.  
  
To minimize the performance impact of Smart Paging, Hyper\-V uses it only when all of the following occurs:  
  
-   The virtual machine is being restarted.  
  
-   There is no available physical memory.  
  
-   No memory can be reclaimed from other virtual machines running on the host.  
  
Smart Paging is not used when:  
  
-   A virtual machine is being started from an “off state” \(instead of a restart\).  
  
-   Oversubscribing memory for a running virtual machine is required.  
  
-   A virtual machine is failing over in Hyper\-V clusters.  
  
When host memory is oversubscribed, Hyper\-V continues to rely on the paging operation in the guest operating system because it is more effective than Smart Paging. The paging operation in the guest operating system is performed by Windows Memory Manager. Windows Memory Manager has more information than the Hyper\-V host about memory usage within the virtual machine, which means it can provide Hyper\-V with better information to use when choosing the memory to be paged. Because of this, less overhead to the system is incurred compared to Smart Paging.  
  
To further reduce the impact of Smart Paging, Hyper\-V removes memory from the virtual machine after it completes the start process. It accomplishes this by coordinating with Dynamic Memory components inside the guest operating system \(a process sometimes referred to as “ballooning”\), so the virtual machine stops using Smart Paging. With this technique, the use of Smart Paging is temporary and is not expected to be longer than 10 minutes.  
  
Also note the following about how Smart Paging is used:  
  
-   Smart Paging files are created only when needed for a virtual machine.  
  
-   After the additional amount of memory is removed, Smart Paging files are deleted.  
  
-   Smart Paging is not used for this virtual machine again until another restart occurs and there is not enough physical memory.  
  
### Run\-time Dynamic Memory configuration changes  
Hyper\-V enables users to make the following configuration changes to Dynamic Memory when the virtual machine is running:  
  
-   Increase the maximum memory.  
  
-   Decrease the minimum memory.  
  
## About the Dynamic Memory Settings  
The following virtual machine settings in Hyper\-V Manager allow you to configure Dynamic Memory. Review the following descriptions to understand how the features work and how they are related.  
  
|Setting|Description|  
|-----------|---------------|  
|Startup RAM|Specifies the amount of memory required to start the virtual machine. The value needs to be high enough to allow the guest operating system to start, but should be as low as possible to allow for optimal memory utilization and potentially higher consolidation ratios.|  
|Minimum RAM|Specifies the minimum amount of memory that should be allocated to the virtual machine after the virtual machine has started. The value can be set as low as 32 MB to a maximum value equal to the **Startup RAM** value.|  
|Maximum RAM|Specifies the maximum amount of memory that this virtual machine is allowed to use. The value can be set from as low as the value for Startup RAM to as high as 1 TB. However, a virtual machine can use only as much memory as the maximum amount supported by the guest operating system. For example, if you specify 64 GB for a virtual machine running a guest operating system that supports a maximum of 32 GB, the virtual machine cannot use more than 32 GB.|  
|Memory buffer|Specifies how much memory Hyper\-V will attempt to assign to the virtual machine compared to the amount of memory actually needed by the applications and services running inside the virtual machine. Memory buffer is specified as a percentage because the actual amount of memory that represents the buffer changes in response to changes in memory usage while the virtual machine is running. Hyper\-V uses performance counters in the virtual machine that identify committed memory to determine the current memory requirements of the virtual machine and then calculates the amount of memory to add as a buffer. The buffer is determined using the following formula:<br /><br />Amount of memory buffer \= how much memory the virtual machine actually needs \/ \(memory buffer value \/ 100\).<br /><br />For example, if the memory committed to the guest operating system is 1000 MB and the memory buffer is 20%, Hyper\-V will attempt to allocate an additional 20% \(200 MB\) for a total of 1200 MB of physical memory allocated to the virtual machine. **Note:** The buffer is not maintained when there is not enough physical memory available in the computer to give every virtual machine its requested memory buffer.|  
|Memory weight|Provides Hyper\-V with a way to determine how to distribute memory among virtual machines if there is not enough physical memory available in the computer to give every virtual machine its requested amount of memory.|  
  
### <a name="BKMK_ossupport"></a>Guest operating systems that support Dynamic Memory  
The following table lists the guest operating systems that support Dynamic Memory on Hyper\-V in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
For a list of the operating systems supported for use as guest operating systems in Hyper\-V virtual machines see [Software requirements \(for supported guest operating systems\)](assetId:///5aad349f-ef06-464a-b36f-366fbb040143#BKMK_SOFT).  
  
|Guest operating system|Notes|  
|--------------------------|---------|  
|Linux distributions|For details on Linux distributions and versions that support dynamic memory, and the requirements for Linux Integration Services, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](../Topic/Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md).|  
|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|Datacenter, Standard, and Essentials editions.<br /><br />Integration services are built\-in and do not require a separate download and installation.|  
|[!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] and [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]|[!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] Pro, and [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)] Enterprise editions.<br /><br />[!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] Pro, and [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)] Enterprise editions.<br /><br />Integration services are built\-in and do not require a separate download and installation.|  
|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] with Service Pack 1 \(SP1\)|Datacenter, Enterprise, Standard, and Web editions.|  
|[!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)]|Datacenter and Enterprise editions.|  
|[!INCLUDE[nextref_client_7](../Token/nextref_client_7_md.md)]|Enterprise and Ultimate editions \(32\-bit and 64\-bit\).|  
|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] with Service Pack 2 \(SP2\)|Standard and Web editions \(32\-bit and 64\-bit\).<br /><br />Apply the following  hotfix as described in [article 2230887](http://go.microsoft.com/fwlink/?LinkId=206472)\(http:\/\/go.microsoft.com\/fwlink\/?LinkId\=206472\)|  
|[!INCLUDE[nextref_longhorn](../Token/nextref_longhorn_md.md)] with Service Pack 2 \(SP2\)|Datacenter and Enterprise editions \(32\-bit and 64\-bit\).|  
|[!INCLUDE[nextref_vista](../Token/nextref_vista_md.md)] with Service Pack 1 \(SP1\)|Ultimate and Enterprise editions \(32\-bit and 64\-bit\).|  
|Windows Server 2003 R2 with Service Pack 2 \(SP2\)|Datacenter, Enterprise, Standard, and Web editions \(32\-bit and 64\-bit\).|  
|Windows Server 2003 with Service Pack 2 \(SP2\)|Datacenter, Enterprise, Standard, and Web editions \(32\-bit and 64\-bit\).|  
  
> [!NOTE]  
> Install the latest integration services after you set up the operating system in the virtual machine.  
  
> [!NOTE]  
> Hyper\-V running on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] automatically calculates an amount of memory to reserve for exclusive use by the management host operating system. This memory is used to run virtualization services. If the computer is part of a failover cluster, Hyper\-V also reserves enough memory to run failover cluster services. In previous versions of Hyper\-V you might have needed to modify the **MemoryReserve** registry setting to ensure adequate memory for these functions. This is no longer necessary for Hyper\-V running on [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)].  
  
## <a name="BKMK_faq"></a>Dynamic Memory \/ Hyper\-V Memory Management FAQs  
The following are some frequently asked questions regarding Dynamic Memory.  
  
### Do I need to manually configure the size of the page file after installing the Hyper\-V role?  
No, it is recommended to allow the system to manage the page file size when running Hyper\-V.  
  
### How is the memory divided up between the host operating system and running virtual machines on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]?  
Hyper\-V running on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] monitors the runtime health of the host operating system to determine how much memory can be safely allocated to virtual machines.  
  
In previous versions, Hyper\-V performed calculations at boot\-time to estimate how much memory could be consumed by virtual machines and how much should be reserved for the host operating system.  
  
The move to runtime monitoring in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] improves overall system reliability and performance.  
  
### My virtual machine failed to start with the following error message “Not enough memory in the system to start the virtual machine” or “Could not initialize memory: Ran out of memory \(0x8007000E\)”. How can I tell how much memory is available for virtual machines?  
As described above, Hyper\-V running on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] monitors the runtime health of the host operating system to determine how much memory can be safely allocated to virtual machines.  
  
The current amount of memory available to virtual machines can be viewed in the following Performance Monitor counter, **Hyper\-V Dynamic Memory Balancer – Available Memory**.  
  
### Should I configure the MemoryReserve registry setting?  
When running Hyper\-V on [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] it is recommend that the **MemoryReserve** registry setting no longer be created.  
  
With Hyper\-V running on [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] or [!INCLUDE[nextref_server_7](../Token/nextref_server_7_md.md)] Service Pack 1, certain cases necessitated modifying  the **MemoryReserve** registry setting to ensure adequate memory for virtualization and failover clustering services in the host operating system. Improved memory reserve calculations in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)] and the addition of runtime monitoring of the host operating system health in [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] makes use of the **MemoryReserve** registry setting unnecessary.  
  
