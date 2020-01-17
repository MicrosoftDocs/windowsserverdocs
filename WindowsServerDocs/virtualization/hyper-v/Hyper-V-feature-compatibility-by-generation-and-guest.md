---
title: Hyper-V feature compatibility by generation and guest
description: "Lists the generations and operating systems that are compatible with key Hyper-V features"
ms.prod: windows-server
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 81c1f32d-7814-4992-8a66-dd4b77c939b4
author: KBDAzure
ms.author: kathydav
ms.date: 12/05/2016
---
# Hyper-V feature compatibility by generation and guest

>Applies To: Windows Server 2016
  
The tables in this article show you the generations and operating systems that are compatible with some of the Hyper-V features, grouped by categories. In general, you'll get the best availability of features with a generation 2 virtual machine that runs the newest operating system.  
  
Keep in mind that some features rely on hardware or other infrastructure. For hardware details, see [System requirements for Hyper-V on Windows Server 2016](System-requirements-for-Hyper-V-on-Windows.md). In some cases, a feature can be used with any supported guest operating system. For details on which operating systems are supported, see:  
  
* [Supported Linux and FreeBSD virtual machines](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)  
* [Supported Windows guest operating systems](Supported-Windows-guest-operating-systems-for-Hyper-V-on-Windows.md)  
  
## Availability and backup  
  
Feature  | Generation | Guest operating system  
------------- | ------------- | -----------  
Checkpoints | 1 and 2 | Any supported guest  
Guest clustering | 1 and 2 | Guests that run cluster-aware applications and have iSCSI target software installed  
Replication | 1 and 2 | Any supported guest  
Domain Controller | 1 and 2 | Any supported Windows Server guest using only production checkpoints. See [Supported Windows Server guest operating systems](https://docs.microsoft.com/windows-server/virtualization/hyper-v/supported-windows-guest-operating-systems-for-hyper-v-on-windows#supported-windows-server-guest-operating-systems)   
  
## Compute  
  
Feature  | Generation | Guest operating system  
------------- | ------------- | -----------  
Dynamic memory | 1 and 2 | Specific versions of supported guests. See [Hyper-V Dynamic Memory Overview](https://technet.microsoft.com/library/hh831766.aspx) for versions older than Windows Server 2016 and Windows 10.  
Hot add/removal of memory | 1 and 2 | Windows Server 2016, Windows 10  
Virtual NUMA | 1 and 2 | Any supported guest  
  
## Development and test  
Feature  | Generation | Guest operating system  
------------- | ------------- | -----------  
COM/Serial ports | 1 and 2 <br>**Note:** For generation 2, use Windows PowerShell to configure. For details, see [Add a COM port for kernel debugging](./plan/should-i-create-a-generation-1-or-2-virtual-machine-in-hyper-v.md#add-a-com-port-for-kernel-debugging). | Any supported guest  
  
## Mobility  
  
Feature  | Generation | Guest operating system  
------------- | ------------- | -----------  
Live migration  | 1 and 2 |  Any supported guest  
Import/export | 1 and 2 |  Any supported guest  
  
## Networking  
  
Feature  | Generation | Guest operating system  
------------- | ------------- | -----------  
Hot add/removal of virtual network adapter | 2 | Any supported guest  
Legacy virtual network adapter | 1 | Any supported guest  
Single root input/output virtualization (SR-IOV) | 1 and 2 | 64-bit Windows guests, starting with  Windows Server 2012  and Windows 8.  
Virtual machine multi queue (VMMQ) | 1 and 2  | Any supported guest  
  
## Remote connection experience  
  
Feature  | Generation | Guest operating system  
------------- | ------------- | -----------  
Discrete device assignment (DDA) | 1 and 2 | Windows Server 2016, Windows Server 2012 R2 only with Update 3133690 installed, Windows 10 <br> **Note:** For details on Update 3133690, see [this](https://support.microsoft.com/kb/3133690) support article.  
Enhanced session mode | 1 and 2 | Windows Server 2016, Windows Server 2012 R2, Windows 10, and Windows 8.1, with Remote Desktop Services enabled <br>**Note**: You might need to also configure the host. For details, see [Use local resources on Hyper-V virtual machine with VMConnect](./learn-more/Use-local-resources-on-Hyper-V-virtual-machine-with-VMConnect.md).  
RemoteFx | 1 and 2 | Generation 1 on 32-bit and 64-bit Windows versions starting with Windows 8. <br> Generation 2 on 64-bit Windows 10 versions  
  
## Security  
  
Feature  | Generation | Guest operating system  
------------- | ------------- | -----------  
Secure boot | 2 | **Linux**: Ubuntu 14.04 and later, SUSE Linux Enterprise Server 12 and later, Red Hat Enterprise Linux 7.0 and later, and CentOS 7.0 and later<br>**Windows**: All supported versions that can run on a generation 2 virtual machine  
Shielded virtual machines | 2 | **Windows**: All supported versions that can run on a generation 2 virtual machine  
  
## Storage  
  
Feature  | Generation | Guest operating system  
------------- | ------------- | -----------  
Shared virtual hard disks (VHDX only) | 1 and 2  | Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
SMB3 | 1 and 2 | All that support SMB3  
Storage spaces direct | 2 | Windows Server 2016  
Virtual Fibre Channel | 1 and 2 | Windows Server 2016, Windows Server 2012 R2, Windows Server 2012  
VHDX format | 1 and 2 | Any supported guest   
  
  
  
  
    


