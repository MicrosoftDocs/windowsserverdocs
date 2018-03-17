---
title: Virtualization
description: Provides an overview of virtualization technologies, such as Containers, Hyper-V, and Hyper-V Virtual Switch; and links to additional content for Windows Server 2016 and later versions of the operating system.
ms.prod: windows-server-threshold
manager: brianlic
ms.technology: compute
ms.topic: article
author: jamesmci
ms.author: jamesmci
ms.localizationpriority: high
ms.date: 03/16/2018
---
# Virtualization

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016 

>[!TIP]
> Looking for information about older versions of Windows Server? Check out our other [Windows Server libraries](/previous-versions/windows/) on docs.microsoft.com. You can also [search this site](https://docs.microsoft.com/search/index?search=Windows+Server&dataSource=previousVersions) for specific information.

<img src="../media/landing-icons/virtualization.png" style='float:left; padding:.5em;' alt="Icon showing a box with spokes"> Virtualization in Windows Server 2016 is one of the foundational technologies required to create your software defined infrastructure. Along with networking and storage, virtualization features deliver the flexibility you need to power workloads for your customers.

Windows Server 2016 Virtualization technologies include updates to Hyper-V, Hyper-V Virtual Switch, and Guarded Fabric and Shielded Virtual Machines \(VMs\), that improve security, scalability, and reliability. Updates to failover clustering, networking, and storage make it even easier to deploy and manage these technologies when used with Hyper-V. 

Windows Containers is a new technology that offers you another way to deploy flexible, software-based computing power. 

>[!Note]
> To download Windows Server 2016, see [Windows Server Evaluations](https://www.microsoft.com/evalcenter/evaluate-windows-server).

The following sections contain brief technology overviews and links to Virtualization documentation.

## [Guarded Fabric and Shielded VMs](guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms-top-node.md)

As a cloud service provider or enterprise private cloud administrator, you can use a guarded fabric to provide a more secure environment for VMs. A guarded fabric consists of one Host Guardian Service \(HGS\) - typically, a cluster of three nodes - plus one or more guarded hosts, and a set of shielded VMs.

For more information, see [Guarded Fabric and Shielded VMs](guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms-top-node.md).

## [Hyper-V](./hyper-v/Hyper-V-on-Windows-Server.md)

The Hyper-V technology provides computing resources through hardware virtualization. Hyper-V creates a software version of computer, called a virtual machine, which you use to run an operating system and applications. You can run multiple virtual machines at the same time, and can create and delete them as needed. 

Hyper-V requires specific hardware to create the virtualization environment. For details, see [System requirements for Hyper-V on Windows Server 2016](./hyper-v/system-requirements-for-hyper-v-on-windows.md). 

### Hyper-V on Windows Server 2016

Hyper\-V is a server role in both Windows Server 2016 Datacenter and Standard editions. 

Learn more about Hyper-V, the hardware you need, the operating systems you can run in your virtual machines, and more. If you're new to Hyper-V, start with the [Hyper-V Technology Overview](./hyper-v/hyper-v-technology-overview.md).

For more information, see [Hyper-V on Windows Server 2016](hyper-v/Hyper-V-on-Windows-Server.md)

### Hyper-V on Windows 10

Hyper-V is available in some versions of Windows 10, Windows 8.1, and Windows 8. 

Hyper-V on Windows is geared toward development and test activities and gives you a quick and easy way to run different operating systems without deploying more hardware.

For more information, see [Hyper-V on Windows 10](https://msdn.microsoft.com/virtualization/hyperv_on_windows/windows_welcome).

### Microsoft Hyper-V Server 2016

The Hyper-V technology is also available separately from Windows and Windows Server, as a free, standalone product. Hyper-V Server is commonly used as the host in a virtualized desktop infrastructure (VDI) environment.

For more information, see [Microsoft Hyper-V Server 2016](https://docs.microsoft.com/en-us/windows-server/virtualization/hyper-v/hyper-v-server-2016).

## [Hyper-V Virtual Switch](hyper-v-virtual-switch/Hyper-V-Virtual-Switch.md)

The Hyper\-V Virtual Switch is a software\-based layer\-2 Ethernet network switch that is included in all versions of Hyper\-V.

Hyper\-V Virtual Switch is available in Hyper\-V Manager after you install the Hyper\-V server role. 

Included in Hyper\-V Virtual Switch are programmatically managed and extensible capabilities that allow you to connect virtual machines to both virtual networks and the physical network. 

In addition, Hyper-V Virtual Switch provides policy enforcement for security, isolation, and service levels.

## Additional Virtualization Technologies for Windows Server 2016 and Windows 10

Following are links to documentation for other Microsoft Windows virtualization technologies.

### [Windows Containers](https://msdn.microsoft.com/virtualization/windowscontainers)

You can use Windows Server and Hyper-V containers to provide standardized runtime environments for development, test, and production teams.

Windows Containers provide operating system\-level virtualization that allows multiple isolated applications to be run on a single system. Two different types of container runtimes are included with the feature, each with a different degree of application isolation.

Windows Server Containers achieve isolation through namespace and process isolation. 

Hyper-V Containers encapsulate each container in a light\-weight virtual machine.

For more information, see [Windows Containers Documentation](https://msdn.microsoft.com/virtualization/windowscontainers) on the Microsoft Developer Network \(MSDN\).
