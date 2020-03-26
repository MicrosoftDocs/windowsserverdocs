---
title: Virtual Receive Side Scaling (vRSS)
description: Learn about Virtual Receive Side Scaling (vRSS) in Windows Server and how to configure a virtual network adapter to load balance incoming network traffic across multiple logical processor cores in a VM. You can also configure mulitple physical cores for a host virtual Network Interface Card (vNIC).
ms.prod: windows-server
ms.technology: networking
ms.topic: article
ms.assetid: 9be477b3-f81d-4e84-a6b0-ac4c1ea97715
ms.date: 09/05/2018
ms.localizationpriority: medium
manager: dougkim
ms.author: lizross
author: eross-msft
---

# Virtual Receive Side Scaling \(vRSS\)

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2016

In this topic, you learn about Virtual Receive Side Scaling (vRSS) and how to configure a virtual network adapter to load balance incoming network traffic across multiple logical processor cores in a VM. You can also use vRSS to configure multiple physical cores for a host virtual Network Interface Card \(vNIC\).

This configuration allows the load from a virtual network adapter to be distributed across multiple virtual processors in a virtual machine \(VM\), allowing the VM to process more network traffic more rapidly than it can with a single logical processor.

>[!TIP]
>You can use vRSS in VMs on Hyper\-V hosts that have multiple processors, a single multiple core processor, or more than one multiple core processors installed and configured for VM use.

vRSS is compatible with all other Hyper\-V networking technologies. vRSS is dependent on Virtual Machine Queue \(VMQ\) in the Hyper\-V host and RSS in the VM or on the host vNIC.

By default, Windows Server enables vRSS, but you can disable it in a VM by using Windows PowerShell. For more information, see [Manage vRSS](vrss-manage.md) and [Windows PowerShell Commands for RSS and vRSS](vrss-wps.md).



## Operating System Compatibility

You can use RSS on any multiprocessor or multicore computer - or vRSS on any multiprocessor or multicore VM - that is running Windows Server 2016.

Multiprocessor or multicore VMs that are running the following Microsoft operating systems also support vRSS.

- Windows Server 2016
- Windows 10 Pro or Enterprise
- Windows Server 2012 R2
- Windows 8.1 Pro or Enterprise
- Windows Server 2012 with the Windows Server 2012 R2 integration components installed.
- Windows 8 with the Windows Server 2012 R2 integration components installed.

For information about vRSS support for VMs running FreeBSD or Linux as a guest operating system on Hyper-V, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](https://docs.microsoft.com/windows-server/virtualization/hyper-v/Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows).
  
## Hardware requirements

Following are the hardware requirements for vRSS.
 
- Physical network adapters must support Virtual Machine Queue \(VMQ\). If VMQ is disabled or not supported, then vRSS is disabled for the Hyper\-V host and any VMs configured on the host.
- Network adapters must have a link speed of 10 Gbps or more.
- Hyper\-V hosts must be configured with multiple processors or at least one multi\-core processor to use vRSS.
- Virtual machines \(VMs\) must be configured to use two or more logical processors.


## Use Case Scenarios

The following two use case scenarios depict common usage of vRSS for processor load balancing and software load balancing.

### Processor load balancing
  
Anthony, a network administrator, is setting up a new Hyper-V host with two network adapter that supports Single Root Input-Output Virtualization \(SR\-IOV\). He deploys Windows Server 2016 to host a VM file server.

After installing the hardware and software, Anthony configures a VM to use eight virtual processors and 4096 MB of memory. Unfortunately, Anthony does not have the option of turning on SR\-IOV because his VMs rely on policy enforcement through the virtual switch he created with Hyper\-V Virtual Switch manager. Because of this, Anthony decides to use vRSS instead of SR\-IOV.

Initially, Anthony assigns four virtual processors by using Windows PowerShell to be available for use with vRSS. The use of the file server after a week appeared to be quite popular, so Anthony checks the performance of the VM.  He discovers full utilization of the four virtual processors.

Because of this, Anthony decides to add processors to the VM for use by vRSS.  He assigns two more virtual processors to the VM, which are automatically available to vRSS to help handle the large network load. His efforts result in better performance for the VM file server, with the six processors efficiently handling the network traffic load.


### Software load balancing

Sandra, a network administrator, is setting up a single high-performance VM on one of her systems to act as a software load balancer. She has assigned all available logical processors to this single VM.

After installing Windows Server, she uses vRSS to get parallel network traffic processing on multiple logical processors in the VM. Because Windows Server enables vRSS, Sandra doesn't have to make any configuration changes.


## Related topics

- [Plan the Use of vRSS](vrss-plan.md)
- [Enable vRSS on a Virtual Network Adapter](vrss-enable.md)
- [Manage vRSS](vrss-manage.md)
- [vRSS Frequently Asked Questions](vrss-faq.md)
- [Windows PowerShell Commands for RSS and vRSS](vrss-wps.md)

---
