---
title: Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V
description: " "
ms.prod: windows-server-threshold
ms.service: na
manager: timlt
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a9ee931d-91fc-40cf-9a15-ed6fa6965cb6
author: cwatsonmsft
---
# Feature Descriptions for Linux and FreeBSD virtual machines on Hyper-V

>Applies To: Hyper-V Server 2012, Hyper-V Server 2012 R2, Microsoft Hyper-V Server Technical Preview, Windows 10, Windows 8, Windows 8.1, Windows Server 2012, Windows Server 2012 R2, Windows Server Technical Preview

The following features are described in this section:  
  
-   [Core](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_core)  
  
-   [Networking](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Networking)  
  
-   [Storage](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Storage)  
  
-   [Memory](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Memory)  
  
-   [Video](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Video)  
  
-   [Miscellaneous](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_Misc)  
  
-   [Generation 2 virtual machines](Feature-Descriptions-for-Linux-and-FreeBSD-virtual-machines-on-Hyper-V.md#BKMK_gen2)  
  
## <a name="BKMK_core"></a>Core  
  
|**Feature**|**Description**|  
|-|-|  
|Integrated shutdown|With this feature, an administrator can shut down virtual machines from the Hyper-V Manager. For more information, see [Operating system shutdown](https://technet.microsoft.com/library/dn798297(WS.11).aspx#BKMK_Shutdown).|  
|Time synchronization|This feature ensures that the maintained time inside a virtual machine is kept synchronized with the maintained time on the host. For more information, see [Time synchronization](https://technet.microsoft.com/library/dn798297(WS.11).aspx#BKMK_time).|  
|Multiprocessing support|With this feature, a virtual machine can use multiple processors on the host by configuring multiple virtual CPUs.|  
|Heartbeat|With this feature, the host to can track the state of the virtual machine. For more information, see [Heartbeat](https://technet.microsoft.com/library/dn798297(WS.11).aspx#BKMK_heartbeat).|  
|Integrated mouse support|With this feature, you can use a mouse on a virtual machine's desktop and also use the mouse seamlessly between the Windows Server desktop and the Hyper-V console for the virtual machine.|  
|Hyper-V specific Storage device|This feature grants high-performance access to storage devices that are attached to a virtual machine.|  
|Hyper-V specific Network device|This feature grants high-performance access to network adapters that are attached to a virtual machine.|  
  
## <a name="BKMK_Networking"></a>Networking  
  
|**Feature**|**Description**|  
|-|-|  
|Jumbo frames|With this feature, an administrator can increase the size of network frames beyond 1500 bytes, which leads to a significant increase in network performance.|  
|VLAN tagging and trunking|This feature allows you to configure virtual LAN (VLAN) traffic for virtual machines.|  
|Live Migration|With this feature, you can migrate a virtual machine from one host to another host. For more   information, see [Virtual Machine Live Migration Overview](https://technet.microsoft.com/library/hh831435.aspx).|  
|Static IP Injection|With this feature, you can replicate the static IP address of a virtual machine after it has been failed over to its replica on a different host. Such IP replication ensures that network workloads continue to work seamlessly after a failover event.|  
|vRSS (Virtual Receive Side Scaling)|Spreads the load from a virtual network adapter across multiple virtual processors in a virtual machine.  For more information, see [Virtual Receive-side Scaling in Windows Server 2012 R2](https://technet.microsoft.com/library/dn383582.aspx).|  
|TCP Segmentation and Checksum Offloads|Transfers segmentation and checksum work from the guest CPU to the host virtual switch or network adapter during network data transfers.|  
|Large Receive Offload (LRO)|Increases inbound throughput of high-bandwidth connections by aggregating multiple packets into a larger buffer, decreasing CPU overhead.|
## <a name="BKMK_Storage"></a>Storage  
  
|**Feature**|**Description**|  
|-|-|  
|VHDX resize|With this feature, an administrator can resize a fixed-size .vhdx file that is attached to a virtual machine. For more information, see [Online Virtual Hard Disk Resizing Overview](https://technet.microsoft.com/library/dn282286.aspx).|  
|Virtual Fibre Channel|With this feature, virtual machines can recognize a fiber channel device and mount it natively. For more information, see [Hyper-V Virtual Fibre Channel Overview](https://technet.microsoft.com/library/hh831413.aspx).|  
|Live virtual machine backup|This feature facilitates zero down time backup of live virtual machines.<br /><br />Note that the backup operation does not succeed if the virtual machine has virtual hard disks (VHDs) that are hosted on remote storage such as a Server Message Block (SMB) share or an iSCSI volume. Additionally, ensure that the backup target does not reside on the same volume as the volume that you back up.|  
|TRIM support|TRIM hints notify the drive that certain sectors that were previously allocated are no longer required by the app and can be purged. This process is typically used when an app makes large space allocations via a file and then self-manages the allocations to the file, for example, to virtual hard disk files.|  
|SCSI WWN|The storvsc driver extracts World Wide Name (WWN) information from the port and node of devices attached to the virtual machine and creates the appropriate sysfs files. |  
  
## <a name="BKMK_Memory"></a>Memory  
  
|**Feature**|**Description**|  
|-|-|  
|Configuration of MMIO gap|With this feature, appliance manufacturers can configure the location of the Memory Mapped I/O (MMIO) gap. The MMIO gap is typically used to divide the available physical memory between an appliance's Just Enough Operating Systems (JeOS) and the actual software infrastructure that powers the appliance.|  
|Dynamic Memory - Hot Add|With this feature, you can dynamically increase the amount of memory that is available to a live virtual machine. To provision a virtual machine with dynamic memory, the administrator must specify three parameters:<br /><br />Startup memory, Minimum memory, and Maximum memory.<br /><br />When the virtual machine is first started, the available memory is equal to the Startup memory. As the memory requirements within the virtual machine increase due to application workloads, Hyper-V dynamically provides more memory via its Hot-Add mechanism.<br /><br />The maximum amount of memory that can be made available to the virtual machine is capped by the value of the **Maximum memory** parameter.<br /><br />For more information, see [Hyper-V Dynamic Memory Overview](https://technet.microsoft.com/library/hh831766.aspx)|  
|Dynamic Memory - Ballooning|This feature dynamically provisions and deprovisions the amount of memory that is allocated to a live virtual machine.<br /><br />If a virtual machine is configured with dynamic memory, Hyper-V continuously monitors memory requirements within the virtual machine. If the required amount of memory falls below the amount of memory that is allocated, then Hyper-V can automatically deprovision memory from the virtual machine. Similarly, if memory requirements increase, Hyper-V dynamically provisions more memory to the virtual machine.<br /><br />Note that if the amount of allocated memory falls to the **Minimum memory** parameter that is specified for the virtual machine, Hyper-V abstains from further deprovisioning.<br /><br />Also note that this feature is different from Hot Add. Hot Add increases the amount of memory **available** (or visible) to a virtual machine. Ballooning adjusts the actual amount of memory **allocated** to a virtual machine. The allocated memory can take up any value between the specified Minimum memory and the total available memory.|  
|Manual Memory Hot Add|You can increase (but not reduce) the amount of memory available to a virtual machine while the virtual machine is running. This works for both generation 1 and generation 2 virtual machines and is operates independently of the Dynamic Memory features above.|  
  
## <a name="BKMK_Video"></a>Video  
  
|**Feature**|**Description**|  
|-|-|  
|Hyper-V-specific video device|This feature provides high-performance graphics and superior resolution for virtual machines.|  
  
## <a name="BKMK_Misc"></a>Miscellaneous  
  
|**Feature**|**Description**|  
|-|-|  
|KVP (Key-Value pair) exchange|This feature provides a key/value pair (KVP) exchange service for virtual machines. Typically administrators use the KVP mechanism to perform read and write custom data operations on a virtual machine. For more information, see [Data Exchange: Using key-value pairs to share information between the host and guest on Hyper-V](https://technet.microsoft.com/library/dn798287.aspx).|  
|Non-Maskable Interrupt|With this feature, an administrator can issue Non-Maskable Interrupts (NMI) to a virtual machine. NMIs are useful in obtaining crash dumps of operating systems that have become unresponsive due to application bugs. These crash dumps can be diagnosed after you restart.|  
|PAE Kernel Support|Physical Address Extension (PAE) technology allows a 32-bit kernel to access a physical address space that is larger than 4GB.Older Linux distributions such as RHEL 5.x used to ship a separate kernel that was PAE enabled. Newer distributions such as RHEL 6.x have prebuilt PAE support.|  
|File copy from host to guest|This feature allows files to be copied from the host physical computer to the guest virtual machines without using the network adaptor. For more information, see [Guest services](https://technet.microsoft.com/library/dn798297(WS.11).aspx#BKMK_guest).|  
|lsvmbus command|You can use the python script lsvmbus in /usr/sbin to get information about devices on the Hyper-V virtual machine bus (VMBus) similiar to information commands like lspci.|  
|Hyper-V Sockets|This is an additional communication channel between the host and guest operating system. To load and use the Hyper-V Sockets kernel module, see [Make your own integration services](https://msdn.microsoft.com/virtualization/hyperv_on_windows/develop/make_mgmt_service).|  
  
## <a name="BKMK_gen2"></a>Generation 2 virtual machines  
  
|**Feature**|**Description**|  
|-|-|  
|Boot using UEFI|This feature allows virtual machines to boot using Unified Extensible Firmware Interface (UEFI).<br /><br />For more information, see [Generation 2 Virtual Machine Overview](https://technet.microsoft.com/library/dn282285.aspx).|  
|Secure boot|This feature allows virtual machines to use UEFI based secure boot mode. When a virtual machine is booted in secure mode, various operating system components are verified using signatures present in the UEFI data store.<br /><br />For more information, see [Secure Boot](https://technet.microsoft.com/library/dn486875.aspx).|  
  
**See Also**  
  
-   [Supported CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](Supported-CentOS-and-Red-Hat-Enterprise-Linux-virtual-machines-on-Hyper-V.md)  
  
-   [Supported Debian virtual machines on Hyper-V](Supported-Debian-virtual-machines-on-Hyper-V.md)  
  
-   [Supported Oracle Linux virtual machines on Hyper-V](Supported-Oracle-Linux-virtual-machines-on-Hyper-V.md)  
  
-   [Supported SUSE virtual machines on Hyper-V](Supported-SUSE-virtual-machines-on-Hyper-V.md)  
  
-   [Supported Ubuntu virtual machines on Hyper-V](Supported-Ubuntu-virtual-machines-on-Hyper-V.md)  
  
-   [Supported FreeBSD virtual machines on Hyper-V](Supported-FreeBSD-virtual-machines-on-Hyper-V.md)  
  
-   [Best Practices for running Linux on Hyper-V](Best-Practices-for-running-Linux-on-Hyper-V.md)  
  
-   [Best practices for running FreeBSD on Hyper-V](Best-practices-for-running-FreeBSD-on-Hyper-V.md)  


