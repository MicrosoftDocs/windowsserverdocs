---
title: Hyper-V Technology Overview
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ac069fed-7bf5-4cc3-aff5-25a2766040b8
author: KBDAzure
---
# Hyper-V Technology Overview
**This is preliminary content and subject to change.**  
Hyper\-V is Microsoft's hardware virtualization product. It lets you create and run a software version of a computer, called a *virtual machine*. Each virtual machine acts like a complete computer, running an operating system and programs. When you need computing resources, virtual machines give you more flexibility, help save time and money, and are a more efficient way to use hardware than just running one operating system on physical hardware.  
  
Hyper\-V runs each virtual machine in its own isolated space, which means you can run more than one virtual machine on the same hardware at the same time. You might want to do this to avoid problems such as a crash affecting the other workloads, or to give different people, groups or services access to different systems.  
  
>[!NOTE]  
>Hyper-V in Windows and Windows Server replaces older hardware virtualization products, such as Microsoft Virtual PC, Microsoft Virtual Server, and Windows Virtual PC.  
  
## Some ways Hyper\-V can help you   
  
Hyper\-V can help you:  
  
-   **Establish or expand a private cloud environment.** Provide more flexible, on\-demand IT services by moving to or expanding your use of shared resources and adjust utilization as demand changes.  
  
-   **Use your hardware more effectively.** Consolidate servers and workloads onto fewer, more powerful physical computers to use less power and physical space.  
  
-   **Improve business continuity.** Minimize the impact of both scheduled and unscheduled downtime of your workloads.  
  
-   **Establish or expand a virtual desktop infrastructure \(VDI\).** Use a centralized desktop strategy with VDI can help you increase business agility and data security, as well as simplify regulatory compliance and manage desktop operating systems and applications. Deploy Hyper\-V and Remote Desktop Virtualization Host \(RD Virtualization Host\) on the same  server to make personal virtual desktops or virtual desktop pools available to your users.  
  
-   **Make development and test more efficient.** Reproduce different computing environments without having to buy or maintain all the hardware you'd need if you only used physical systems.  
  
## What features does Hyper-V have?  
  
Hyper\-V offers many features. This is an overview, grouped by what the features provide or help you do.   
  
**Computing environment** — A Hyper\-V virtual machine includes the same basic parts as a physical computer, such as memory, processor, storage, and networking. All these parts have features and options that you can configure different ways to meet different needs. Storage and networking can each be considered categories of their own, because of the many ways you can configure them.   
  
**Disaster recovery and backup** — For disaster recovery, Hyper\-V Replica creates copies of virtual machines, intended to be stored in another physical location, so you can restore the virtual machine from the copy. For backup, Hyper\-V offers two types. One uses saved states and the other uses Volume Shadow Copy Service (VSS) so you can make application-consistent backups for programs that support VSS.  
  
**Optimization** — Each supported guest operating system has a customized set of services and drivers, called *integration services*, that make it easier to use the operating system in a Hyper\-V virtual machine.  
  
**Portability** — Features such as live migration, storage migration, and import/export make it easier to move or distribute a virtual machine.  
  
**Remote connectivity** — Hyper\-V includes Virtual Machine Connection, a remote connection tool for use with both Windows and Linux. Unlike Remote Desktop, this tool gives you console access, so you can see what's happening in the guest even when the operating system isn't booted yet.   
   
**Security** — Secure boot and shielded virtual machines help protect against malware and other unauthorized access to a virtual machine and its data.  
  
For a summary of the features introduced in this version, see [What's new in Hyper-V on Windows Server 2016 Technical Preview](What-s-new-in-Hyper-V-on-Windows-Server-2016-Technical-Preview.md). Some features or parts have a limit to how many can be configured. For details, see [Plan for Hyper-V scalability in Windows Server 2016](plan/Plan-for-Hyper-V-scalability-in-Windows-Server-2016.md).  
  
## How to get Hyper\-V  
Hyper\-V is available in Windows Server and Windows, as a server role available for x64 versions of Windows Server. For server instructions, see [Install the Hyper-V role on Windows Server Technical Preview](get-started/Install-the-Hyper-V-role-on-Windows-Server-Technical-Preview.md). On Windows, it's available as [feature](https://msdn.microsoft.com/virtualization/hyperv_on_windows/windows_welcome) in some 64\-bit versions of Windows. It's also available as a downloadable, standalone server product, [Microsoft Hyper-V Server](https://technet.microsoft.com/library/hh923062.aspx).  
  
## Supported operating systems  
  
Many operating systems will run on virtual machines. In general, an operating system that uses an x86 architecture will run on a Hyper\-V virtual machine. Not all operating systems that can be run are tested and supported by Microsoft, however. For lists of what's supported, see:  
  
-   [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)  
  
-   [Supported Windows guest operating systems for Hyper-V on Windows Server Technical Preview](Supported-Windows-guest-operating-systems-for-Hyper-V-on-Windows-Server-Technical-Preview.md)  
  
## How Hyper\-V works  
Hyper\-V is a hypervisor\-based virtualization technology. Hyper\-V uses the Windows hypervisor, which requires a physical processor with specific features. For hardware details, see [System requirements for Hyper-V on Windows Server 2016 Technical Preview](System-requirements-for-Hyper-V-on-Windows-Server-2016-Technical-Preview.md).  
  
In most cases, the hypervisor manages the interactions between the hardware and the virtual machines. This hypervisor\-controlled access to the hardware gives virtual machines the isolated environment in which they run. In some configurations, a virtual machine or the operating system running in the virtual machine has direct access to graphics, networking, or storage hardware.  
  
## What does Hyper\-V consist of?  
Hyper\-V has required parts that work together so you can create and run virtual machines. Together, these parts are called the virtualization platform. They're installed as a set when you install the Hyper-V role. The required parts include Windows hypervisor, Hyper\-V Virtual Machine Management Service, the virtualization WMI provider, the virtual machine bus \(VMbus\), virtualization service provider \(VSP\) and virtual infrastructure driver \(VID\).  
  
Hyper\-V also has tools for management and connectivity. You can install these on the same computer that Hyper-V role is installed on, and on computers without the Hyper-V role installed. These tools are:  
- Hyper\-V Manager  
-	[Hyper\-V module for Windows PowerShell](https://technet.microsoft.com/library/hh848559.aspx)  
- Virtual Machine Connection (VMConnect)  
- [Windows PowerShell Direct](manage/Manage-Windows-virtual-machines-with-PowerShell-Direct.md)  
  
## Related technologies  
These are some technologies from Microsoft that are often used with Hyper\-V:  
  
* [Failover Clustering overview](failover-clustering/Failover-Clustering-Overview.md)  
* [Remote Desktop Services](../remote-desktop-services/Host-desktops-and-apps-in-Remote-Desktop-Services.md)  
* [Virtual Machine Manager](https://technet.microsoft.com/library/mt203994(v=sc.16).aspx)  
  
Various storage technologies: cluster shared volumes, SMB 3.0, storage spaces direct  
  
Windows containers offer another approach to virtualization. See the [Windows Containers](https://msdn.microsoft.com/virtualization/windowscontainers/containers_welcome) library on MSDN.  
  

