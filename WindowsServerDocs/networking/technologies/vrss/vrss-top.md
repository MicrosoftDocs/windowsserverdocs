---
title: Virtual Receive Side Scaling (vRSS)
description: You can use this topic to learn about vRSS in Windows Server 2016.
ms.prod: windows-server-threshold
ms.technology: networking
ms.topic: article
ms.assetid: 9be477b3-f81d-4e84-a6b0-ac4c1ea97715
manager: brianlic
ms.author: jamesmci
author: jamesmci
---

# Virtual Receive Side Scaling \(vRSS\)

>Applies To: Windows Server 2016

You can use Virtual Receive Side Scaling \(vRSS) to configure a virtual network adapter to load balance incoming network traffic across multiple logical processor cores in a VM or multiple physical cores for a host virtual Network Interface Card \(vNIC\).

This configuration allows the load from a virtual network adapter to be distributed across multiple virtual processors in a virtual machine \(VM\), allowing the VM to process more network traffic more rapidly that it could with a single logical processor.

>[!NOTE]
>In addition to this topic, the following vRSS documentation is available.
>
> - [Plan the Use of vRSS](vrss-plan.md)
> - [Enable vRSS on a Virtual Network Adapter](vrss-enable.md)
> - [Manage vRSS](vrss-manage.md)
> - [vRSS Frequently Asked Questions](vrss-faq.md)
> - [Windows PowerShell Commands for RSS and vRSS](vrss-wps.md)


You can use vRSS in VMs on Hyper\-V hosts that have multiple processors, a single multiple core processor, or more than one multiple core processors installed and configured for VM use.

vRSS is compatible with all other Hyper\-V networking technologies. vRSS is dependent on Virtual Machine Queue \(VMQ\) in the Hyper\-V host and RSS in the VM or on the host vNIC.

vRSS is enabled by default, however you can disable vRSS in a VM by using Windows PowerShell commands. For more information, see [Windows PowerShell Commands for RSS and vRSS](vrss-wps.md).

## Operating System Compatibility

You can use RSS on any multiprocessor or multicore computer - or vRSS on any multiprocessor or multicore VM - that is running Windows Server 2016.

Multiprocessor or multicore VMs that are running the following Microsoft operating systems also support vRSS.

1. Windows Server 2016
2. Windows 10 Pro or Enterprise
3. Windows Server 2012 R2
4. Windows 8.1 Pro or Enterprise
5. Windows Server 2012 with the Windows Server 2012 R2 integration components installed.
6. Windows 8 with the Windows Server 2012 R2 integration components installed.

For information about vRSS support for VMs running FreeBSD or Linux as a guest operating system on Hyper-V, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](https://docs.microsoft.com/windows-server/virtualization/hyper-v/Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows).
  
## Hardware requirements
 
vRSS requires Virtual Machine Queue \(VMQ\) support from the physical adapter. If VMQ is disabled or is not supported, then vRSS is disabled for the host and any VMs that are configured on the host.

## Use Case Scenarios

The following two use case scenarios depict common usage of vRSS for processor load balancing and software load balancing.

### Processor load balancing
  
Anthony is a network administrator that is setting up a new Hyper-V host with two network adapters that support Single Root Input-Output Virtualization \(SR\-IOV\). He deploys Windows Server 2016 to host a VM file server.

After the hardware and software are installed, Anthony configures a VM to use 8 virtual processors and 4096 MB of memory. 

Unfortunately, Anthony does not have the option of turning on SR\-IOV because his VMs rely on policy enforcement through the virtual switch he created with Hyper\-V Virtual Switch manager in Windows Server 2016. Because of this, Anthony decides to use vRSS instead of SR\-IOV.

Initially, Anthony assigns 4 virtual processors by using Windows PowerShell to be available for use with vRSS. 

After a week, the use of the file server is extremely popular, and Anthony checks the VM performance. He discovers that all four virtual processors are fully utilized. 

Because of this, Anthony decides to add processors to the VM for use by vRSS. Anthony changes the VM's processor count, and assigns two more virtual processors to the VM, knowing they will automatically be available to vRSS to help handle the large network load. His efforts result in better performance for the VM file server, with the six processors easily handling the network traffic load.

### Software load balancing

Sandra, a network administrator, is setting up a single high performance VM on one of her systems for the sole purpose of acting as a software load balancer. She has assigned all available logical processors to this single VM.

Sandra has just installed Windows Server 2016 so that she can use vRSS to get parallel network traffic processing on multiple logical processors in the VM.

Because vRSS is enabled by default in Windows Server 2016, Sandra doesn’t have to make any configuration changes to get great performance.

## Other topics in this guide

The following topics are also available.

 - [Plan the Use of vRSS](vrss-plan.md)
 - [Enable vRSS on a Virtual Network Adapter](vrss-enable.md)
 - [Manage vRSS](vrss-manage.md)
 - [vRSS Frequently Asked Questions](vrss-faq.md)
 - [Windows PowerShell Commands for RSS and vRSS](vrss-wps.md)
