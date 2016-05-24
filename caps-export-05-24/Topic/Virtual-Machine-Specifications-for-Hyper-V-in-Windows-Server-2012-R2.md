---
title: Virtual Machine Specifications for Hyper-V in Windows Server 2012 R2
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 442d79d1-6085-49b2-93db-541379545e56
author: cwatsonmsft
---
# Virtual Machine Specifications for Hyper-V in Windows Server 2012 R2
Hyper\-V in Windows Server 2012 R2 and Client Hyper\-V in Windows 8.1 introduce generation 2 virtual machines that have a revised set of virtual hardware. The virtual hardware that was exposed in Windows Server 2012 and Windows 8 is preserved as generation 1 virtual machines.  
  
## Generation 1 virtual machine components  
The following table lists basic virtual machine components and their corresponding emulated hardware. Collapse this tableExpand this table  
  
|||  
|-|-|  
|**Component**|**Purpose**|  
|Basic input\/output system \(BIOS\)|Implements American Megatrends \(AMI\) BIOS on an emulated Intel 440BX chipset with PIIX4 on\-board components:<br /><br />-   Battery\-backed CMOS<br />-   Real\-Time clock<br />-   Two 8327 DMA controllers<br />-   I\/O APIC<br />-   PCI\-to\-ISA bridge \(also known as PIIX or PCI\-to\-ISA \/ IDE Xcelerator\)<br />-   PCI bus as found in the Intel 440BX chipset<br />-   Host\-to\-PCI bridge as found in the Intel 440BX chipset<br />-   Two cascaded 8259 programmable interrupt controllers \(PICs\)<br />-   Programmable Interval Timer \(PIT\)<br />-   Power management hardware as provided in the Intel 440BX chipset<br />-   SMBus<br />-   Two 16550 UART controllers that support up to two serial ports<br />-   Winbond 83977 Super I\/O chipset<br />-   Keyboard Controller Device \(i8042\)<br />-   Standard Microsoft® 101\-Key PS\-2 Keyboard or PS\/2 Mouse<br />-   ISA Bus<br />-   PIC Device: Generic VESA 2.0 Video Device<br />-   DEC 21140 Ethernet Adapter<br />-   Floppy disk controller<br /><br />We recommend that the guest operating system implements the Advanced Configuration and Power Interface \(ACPI\) specification for best performance.|  
|Floppy disk drive|Supports a single 1.44 MB floppy disk drive and mapping floppy drive images.|  
|Serial \(COM\) port|Emulates up to two serial ports that can be mapped to local named pipes and files.|  
|Mouse|Emulates a standard PS\/2 Microsoft IntelliMouse pointing device.|  
|Keyboard|Emulates a standard PS\/2 101\-key Microsoft keyboard.|  
|Network adapter \(multifunction\)|Emulates the multiport DEC 21140 10\/100TX 100 MB Ethernet network adapter with one to four network connections. In some cases, the DEC 21140 network adapter might be displayed on the virtual machine as an Intel 21140 network adapter. They are equivalent network adapters. The virtual network adapters and the network driver that controls them do not support the virtual local area network \(VLAN\) identifier \(ID\) in a tag header. Up to four such adapters can be added to a virtual machine.|  
|Memory|Supports 1 terabyte \(TB\) of RAM per virtual machine.|  
|Video card|Emulates a generic graphics adapter with 4 MB of Video RAM \(VRAM\), VGA, and SVGA support that is compliant with VESA 2.0, a hardware cursor, and support for Microsoft DirectX.|  
|IDE\/ATAPI storage|Emulates up to four IDE devices, hard drives, or CD\-ROM or DVD\-ROM drives \(or ISO images\), and virtual hard disks up to 2040 MB in size per IDE channel.|  
  
The following table lists software components that are designed for optimal performance in virtualized environments.  
  
|||  
|-|-|  
|**Component**|**Purpose**|  
|Microsoft Virtual Machine Bus|Provides a high\-speed Hyper\-V\-specific communication channel between a virtual machine and a host that is installed as a part of integration services.|  
|Microsoft Virtual Machine Bus Network Adapter|Provides a network adapter that can be added to the virtual machine when the integration services are installed in the operating system on the virtual machine.|  
|Hyper\-V\-specific SCSI Controller|Provides a SCSI adapter that can be added to the virtual machine when the integration services are installed in the operating system on the virtual machine. It supports up to 64 devices per controller with a maximum of four SCSI controllers per virtual machine.|  
|Physical disk attached to the virtual machine \(also known as pass\-through storage\)|Provides mechanisms to enable virtual machines to read and write directly to a storage device accessible to the virtual machine. The virtual machine treats it as a disk.|  
|Hyper\-V\-specific Video Card|Provides a Hyper\-V\-specific video card that is added when the integration services are installed in the operating system on the virtual machine.|  
|Hyper\-V\-specific Mouse|Provides a Hyper\-V\-specific mouse that is added when the integration services are installed in the operating system on the virtual machine.|  
|Virtual Fibre Channel Adapter|Provides a Hyper\-V\-specific virtual Fibre Channel adapter that is added to the guest operating system when the integration services are installed in the operating system on the virtual machine and a virtual Host Bus Adapter \(HBA\) is added to the virtual machine.|  
|Virtual PCI Bus|Provides a Hyper\-V\-specific virtual PCI bus that is added when the integration services are installed in the operating system on the virtual machine and Single Root I\/O Virtualization \(SR\-IOV\) networking is being used.|  
|Hyper\-V\-specific Generation Counter device|Provides a Hyper\-V\-specific virtual machine Generation Counter device that is added when the integration services are installed in the operating system on the virtual machine. The device provides a 128\-bit virtual machine Generation Identifier for a virtual machine that stays the same unless the virtual machine is reverted to a snapshot.|  
|Automatic Virtual Machine Activation|Enables the Windows Server 2012 R2 guest operating systems to automatically activate themselves when running on a Windows Server 2012 R2 Datacenter host, which makes it easier and faster to deploy Microsoft cloud solutions that are based on Windows Server 2012 R2 Datacenter.|  
|Enhanced Session Mode|Enables Hyper\-V to redirect local resources to a virtual machine session through the Virtual Machine Connection tool. The enhanced session mode connection uses a Remote Desktop Connection session via the virtual machine bus \(VMBus\), so that no network connection to the virtual machine is required.|  
  
## Generation 2 virtual machine components  
The following table lists basic virtual machine components in a generation 2 virtual machine.  
  
|||  
|-|-|  
|**Component**|**Purpose**|  
|UEFI firmware|Provides system firmware.|  
|Serial \(COM\) ports|Provides optional emulated serial ports that can be mapped to local named pipes and files.|  
|Real\-Time clock|Provides emulated time support.|  
|I\/O APIC|Provides an emulated Advanced Programmable Interrupt Controller \(I\/O APIC\).|  
|Memory|Supports 1 TB of RAM per virtual machine.|  
  
The following table lists software components that are designed for optimal performance in virtualized environments.  
  
|||  
|-|-|  
|**Component**|**Purpose**|  
|Microsoft Hyper\-V Virtual Machine Bus|Provides a communication channel between a virtual machine and the host.|  
|Microsoft Hyper\-V Network Adapter|Supports network input and output.|  
|Microsoft Hyper\-V SCSI Controller|Supports storage input and output.|  
|Physical disk attached to the virtual machine \(also known as pass\-through storage\)|Provides mechanisms to enable virtual machines to read and write directly to a storage device that is accessible to the virtual machine. The virtual machine treats it as a disk.|  
|Microsoft Hyper\-V Video|Supports video output.|  
|Microsoft Hyper\-V Input|Supports human interface device \(HID\)\-compliant mouse input.|  
|Microsoft Hyper\-V Virtual Keyboard|Supports keyboard input.|  
|Microsoft Hyper\-V Virtual Fibre Channel Adapter|Supports fibre\-channel\-based input and output.|  
|Microsoft Hyper\-V Virtual PCI Bus|Supports SR\-IOV network input and output.|  
|Microsoft Hyper\-V Generation Counter device|Provides a 128\-bit Generation Identifier that stays the same unless the virtual machine is reverted to a checkpoint.|  
|Microsoft Virtual DVD\-ROM|Supports CD\/DVD\-ROM input.|  
|Automatic Virtual Machine Activation|Enables Windows Server 2012 R2 guest operating systems to automatically activate themselves when running on a Windows Server 2012 R2 Datacenter host, which makes it easier and faster to deploy Microsoft cloud solutions that are based on Windows Server 2012 R2 Datacenter.|  
|Enhanced Session Mode|Enables Hyper\-V to redirect local resources to a virtual machine session through the Virtual Machine Connection tool. The enhanced session mode connection uses a Remote Desktop Connection session via the virtual machine bus \(VMBus\), so that no network connection to the virtual machine is required.|  
  
## Hypervisor top\-level functional specification \(TLFS\)  
The [Hypervisor top\-level functional specification \(TLFS\)](http://www.microsoft.com/download/details.aspx?id=39289) for the third\-generation hypervisor by Microsoft specifies the externally visible behavior of the hypervisor, which is a component of the Hyper\-V role in Windows Server 2012 R2.  
  
The specification provides details on the functionalities of the hypervisor. It covers topics such as Feature and Interface Discovery, Hypercall Interfaces, Partition Management, Physical Hardware Management, Resource Management, Guest Physical Address Spaces, Intercepts, Virtual Processor Management, Virtual Processor Execution, Virtual MMU and Caching, Virtual Interrupt Control, Inter\-Partition Communication, Timers, Message Formats, Partition Save and Restore, Scheduler, Event Logging, Guest Debugging Support, Statistics, Booting, and System Properties.  
  
