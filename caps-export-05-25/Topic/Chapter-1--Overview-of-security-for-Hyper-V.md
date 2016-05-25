---
title: Chapter 1: Overview of security for Hyper-V
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0b09fc33-9f0e-4575-9a5a-42ecf6bdcd34
author: cwatsonmsft
---
# Chapter 1: Overview of security for Hyper-V
This chapter provides necessary prerequisite information on Hyper\-V to set the groundwork for subsequent material. This guide is targeted for Windows Server 2012 with the Hyper\-V role enabled.  
  
## Hardware Requirements  
To install the Hyper\-V role and take advantage of the virtualization capabilities requires the following:  
  
-   A server computer running the 64\-bit edition of Windows Server 2012.  
  
-   Hardware\-Assisted Virtualization must be enabled on the hardware.  
  
-   Data Execution Prevention \(DEP\) must be enabled in the BIOS. DEP is a security feature that is available on all processors that support virtualization assistance. It prevents a process from executing code from a non\-executable memory region. DEP is supported by processors that can mark memory pages as non\-executable, such as Intel processors that support the XD \(Execute Disable\) bit and AMD processors that support the NX \(No\-Execute\) bit.  
  
After installation of the Hyper\-V role, all of the operating system instances on the physical computer run as virtual machines. Even the instance of Windows Server 2012 that is used to create and manage the virtual machines is a virtual machine. This instance is called the *management operating system*.  
  
## Hyper\-V Architecture  
Hyper\-V is a hypervisor\-based virtualization solution. The hypervisor is the processor\-specific virtualization platform that allows multiple isolated operating systems to share a single hardware platform. Hyper\-V supports isolation in terms of a partition.  
  
A partition is a logical unit of isolation, created by the hypervisor, in which operating systems execute. The Microsoft hypervisor has a parent\/ root partition called the Management Operating System which runs 64\-bit Windows. The virtualization stack runs in the Management Operating System and has direct access to hardware devices. The Management Operating System then creates the child partitions which host the guest operating systems.  
  
Partitions do not have unrestricted access to the physical processors, nor do they handle the processor interrupts. Instead, they have a virtual view of the processors and run in a virtual memory address region that is private to each guest partition. The hypervisor handles the interrupts to the processor, and redirects them to the respective partition.  
  
The following diagram provides a high\-level overview of the architecture of a Hyper\-V environment.  
  
![](../Image/HyperVSecGuide.jpg)  
  
Acronyms and terms used in the diagram above are described below:  
  
-   **APIC** – Advanced Programmable Interrupt Controller – A device which allows priority levels to be assigned to its interrupt outputs.  
  
-   **Child Partition** – Partition that hosts a guest operating system \- All access to physical memory and devices by a child partition is provided via the virtual machine bus \(VMBus\) or the hypervisor.  
  
-   **Enlightenments** are enhancements made to the operating system to assist with efficient functioning of the operating system in a virtualized environment.  
  
-   **Hypercall** – Interface for communication with the hypervisor – In addition to basic operations \(e.g. creating a partition, etc.\) the hypercall interface accommodates access to the optimizations provided by the hypervisor.  
  
-   **Hypervisor** – A layer of software that sits between the hardware and one or more operating systems. Its primary job is to provide isolated execution environments called partitions. The hypervisor controls and arbitrates access to the underlying hardware.  
  
-   **IC** – Integration component – Component that allows child partitions to communication with other partitions and the hypervisor.  
  
-   **I\/O stack** – Input\/output stack  
  
-   **MSR** – Model Specific Register  
  
-   **Root Partition** – This is the Management Operating System that manages machine\-level functions such as device drivers, power management, and device hot addition\/removal. This partition is the only partition that has direct access to all physical memory as well as devices.  
  
-   **VID** – Virtualization Infrastructure Driver – Provides partition management services, virtual processor management services, and memory management services for partitions  
  
-   **VMBus** – Channel\-based communication mechanism used for inter\-partition communication and device enumeration. The VMBus is installed with Hyper\-V integration services.  
  
-   **VMMS** – Virtual Machine Management Service – Responsible for managing the state of all virtual machines in child partitions.  
  
-   **VMWP** – Virtual Machine Worker Process – A user mode component of the virtualization stack. The worker process provides virtual machine management services from the Windows Server 2012 instance in the Management Operating System to the guest operating systems in the child partitions. The Virtual Machine Management Service spawns a separate worker process for each running virtual machine.  
  
-   **VSC** – Virtualization Service Client – A synthetic device instance that resides in a child partition. VSCs utilize hardware resources that are provided by Virtualization Service Providers \(VSPs\) in the Management Operating System. They communicate with the corresponding VSPs in the Management Operating System over the VMBus to satisfy a child partition’s device I\/O requests.  
  
-   **VSP** – Virtualization Service Provider – Resides in the Management Operating System and provide synthetic device support to child partitions over the Virtual Machine Bus \(VMBus\).  
  
-   **WinHv** – Windows Hypervisor Interface Library \- WinHv is essentially a bridge between a partitioned operating system’s drivers and the hypervisor which allows drivers to call the hypervisor using standard Windows calling conventions  
  
-   **WMI** – The Virtual Machine Management Service exposes a set of Windows Management Instrumentation \(WMI\)\-based APIs for managing and controlling virtual machines.  
  
## Hyper\-V Administration  
  
### AZMan deprecation  
Windows Authorization Manager \(AzMan\) has been deprecated for Hyper\-V authorization. For more information, refer to the section on “Removed or deprecated functionality” in “[What’s New in Hyper\-V](http://technet.microsoft.com/library/hh831410.aspx)”. In lieu of Azman, Windows Server 2012 Hyper\-V introduces a simplified authorization scheme.  
  
### Taxonomy of administrative roles  
A new local security group “**Hyper\-V Administrators**” has been introduced in Windows Server 2012.  Members of the Hyper\-V Administrators group have complete access to all features and configuration of Hyper\-V. Hyper\-V Administrators are different from system administrators in that they only have privileges to perform Hyper\-V specific administration operations. This ensures that the user role responsible for performing Hyper\-V related administrative tasks does not need to be a system administrator. It is recommended to add users with administrative responsibilities to this group instead of the local Administrators group to provide them with access to Hyper\-V.  
  
Creating and managing virtual machines often requires creating or accessing files such as virtual hard disks or virtual machine configuration files.  Users performing tasks that require access to files even while members of the Hyper\-V Administrators group must also have permissions to the files, folders and\/or shares. Specifically, it should be noted that mounting a virtual hard disk file requires the *SeManageVolume* privilege. Members of the Hyper\-V Administrators group do not have this privilege by default. Additionally, members of this group do not have the privileges to attach a disk as direct\-attached storage \(passthru disk\) to a guest virtual machine.  
  
Virtual machines running on a Hyper\-V server are isolated from the management operating system.  Each virtual machine including the management operating system have their own unique operating environment requiring individual security configuration.  Members of the virtual machine’s security groups have no additional or special access to the management operating system nor do members of the management operating system security groups have special access to the virtual machines operating system.  
  
**Virtual machine administrators** are administrative accounts that only have administrative access to the virtual machine on which the account has been established.  
  
Microsoft recommends that you limit administrative privileges to user roles that need the requisite permissions.  
  
## See also:  
[Chapter 2: Hardening the Hyper\-V host](../Topic/Chapter-2--Hardening-the-Hyper-V-host.md)  
  
[Chapter 3: Roles & Delegation](../Topic/Chapter-3--Roles---Delegation.md)  
  
[Chapter 4: Protecting Virtual Machines](../Topic/Chapter-4--Protecting-Virtual-Machines.md)  
  
[Chapter 5: Best Practices Checklist](../Topic/Chapter-5--Best-Practices-Checklist.md)  
  
