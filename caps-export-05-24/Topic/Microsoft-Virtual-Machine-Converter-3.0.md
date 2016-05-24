---
title: Microsoft Virtual Machine Converter 3.0
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0aedbd2e-651c-4616-83b1-d82bc2c863c6
author: cwatsonmsft
---
# Microsoft Virtual Machine Converter 3.0
  
> [!NOTE]  
> For documents that contain information about Windows PowerShell cmdlets for Microsoft Virtual Machine Converter and the setup files, see [Microsoft Virtual Machine Converter](http://www.microsoft.com/en-gb/download/details.aspx?id=42497) on the Microsoft Download Center.  
>   
> For late\-breaking information that is not available in the product documentation, see [Release Notes for Microsoft Virtual Machine Converter 2.0.](http://go.microsoft.com/fwlink/p/?LinkId=394277).  
  
Microsoft Virtual Machine Converter \(MVMC\) is a Microsoft\-supported, stand\-alone solution for the information technology \(IT\) pro or solution provider who wants to:  
  
-   Convert virtual machines and disks from VMware hosts to Hyper\-V hosts and Microsoft Azure.  
  
-   Convert physical machines and disks to Hyper\-V hosts.  
  
This guide is intended for the enterprise customer in an IT role, such as the IT decision maker, IT pro, or IT implementer. It provides an overview of MVMC features and functionality, in addition to information about how to install and use MVMC as a conversion solution.  
  
## Benefits  
MVMC can be deployed with minimal dependencies. Because MVMC provides native support for Windows PowerShell, it enables scripting and integration with datacenter automation workflows such as those authored and run within Microsoft System Center Orchestrator 2012 R2. It can also be invoked through the Windows PowerShell command\-line interface. The solution is simple to download, install, and use. In addition to the Windows PowerShell capability, MVMC provides a wizard\-driven GUI to facilitate virtual machine conversion.  
  
## New features in MVMC 3.0  
MVMC 3.0 release of MVMC includes the following new feature:  
  
-   Online conversion of physical machines to virtual hard disks \(VHDs\) that can be uploaded to Hyper\-V hosts.  
  
## Key MVMC features  
In addition to the new feature listed previously, MVMC provides the following functionality:  
  
-   Converts and deploys virtual machines from VMware hosts to Hyper\-V hosts on any of the following operating systems:  
  
    -   Windows Server 2012 R2  
  
    -   Windows Server 2012  
  
    -   Windows Server 2008 R2 with SP1  
  
-   Converts VMware virtual machines, virtual disks, and configurations for memory, virtual processor, and other virtual computing resources from the source to Hyper\-V.  
  
-   Adds virtual network adapters to the converted virtual machine on Hyper\-V  
  
-   Supports conversion of virtual machines from VMware vSphere 5.5, VMware vSphere 5.1, and VMware vSphere 4.1 hosts to Hyper\-V  
  
-   Has a wizard\-driven GUI, which simplifies performing virtual machine conversions  
  
-   Uninstalls VMware Tools before online conversion \(online only\) to provide a clean way to migrate VMware\-based virtual machines to Hyper\-V  
  
    > [!IMPORTANT]  
    > MVMC takes a snapshot of the virtual machine that you are converting before you uninstall VMware Tools, and then shuts down the source machine to preserve state during conversion. The virtual machine is restored to its previous state after the source disks that are attached to the virtual machine are successfully copied. At that point, the source machine in VMware can be turned on, if required.  
  
    > [!IMPORTANT]  
    > MVMC does not uninstall VMware Tools in an offline conversion. Instead, it disables VMware services, drivers, and programs only for Windows Server guest operating systems. For file conversions with Linux guest operating systems, VMware Tools are not disabled or uninstalled. We highly recommend that you manually uninstall VMware Tools when you convert an offline virtual machine.  
  
    > [!IMPORTANT]  
    > Disconnect extra hardware and pass\-through or USB devices, and uninstall any hardware\-specific services or monitoring software that will not be needed from the virtual machine configuration.  
  
-   Supports conversion and provisioning of Linux\-based guest operating systems from VMware hosts to Hyper\-V hosts. For more information, see “Supported Configurations for Virtual Machine Conversion” later in this topic. \(Does not apply to physical machine conversions.\)  
  
-   Provides native Windows PowerShell capability that enables scripting and integration into IT automation workflows  
  
    > [!NOTE]  
    > The command\-line interface \(CLI\) in MVMC 1.0 has been replaced by Windows PowerShell in MVMC 2.0.  
  
-   Supports conversion of offline virtual machines. \(Does not apply to physical machine conversions.\)  
  
-   Supports the new virtual hard disk format \(VHDX\) when converting and provisioning in Hyper\-V in Windows Server 2012 R2 and Windows Server 2012. \(Does not apply to physical machine conversions.\)  
  
-   Supports Windows Server 2008 through Windows Server 2012 R2, and Windows Vista through Windows 8.1 as guest operating systems that you can select for conversion, along with a number of Linux distributions. For more information, see “Supported Configurations for Virtual Machine Conversion” later in this topic.  
  
-   Includes Windows PowerShell capability for offline conversions of VMware\-based virtual hard disks \(VMDK\) to a Hyper\-V–based virtual hard disk file format \(.vhd file\).  
  
    > [!NOTE]  
    > The offline disk conversion does not include driver fixes.  
  
-   Includes Windows PowerShell capability for online conversions of physical machines to VHD and provisioning in Hyper\-V hosts  
  
## Supported configurations for converting virtual machines  
The following outlines all supported configurations for virtual machine conversion.  
  
**VMware sources**  
  
||  
|-|  
|VMware vSphere 5.5 \(VMware ESXi 5.5\)|  
|VMware vSphere 5.1 \(VMware ESXi 5.1\)|  
|VMware vSphere 4.1 \(VMware ESXi\/ESX 4.1\)|  
|VMware vCenter Server 5.5|  
|VMware vCenter Server 5.1|  
|VMware vCenter Server 4.1|  
  
**Destination host servers**  
  
> [!NOTE]  
> Hyper\-V must be enabled.  
  
||  
|-|  
|Windows Server 2012 R2 Standard|  
|Windows Server 2012 R2 Datacenter|  
|Windows Server 2012 Standard|  
|Windows Server 2012 Datacenter|  
|Windows Server 2008 R2 Standard with Service Pack 1 \(SP1\)|  
|Windows Server 2008 R2 Enterprise with Service Pack 1 \(SP1\)|  
|Windows Server 2008 R2 Datacenter with Service Pack 1 \(SP1\)|  
  
**Operating systems on which MVMC can be installed**  
  
||  
|-|  
|Windows Server 2012 R2 Standard|  
|Windows Server 2012 R2 Datacenter|  
|Windows Server 2012 Standard|  
|Windows Server 2012 Datacenter|  
|Windows Server 2008 R2 Standard with Service Pack 1 \(SP1\)|  
|Windows Server 2008 R2 Enterprise with Service Pack 1 \(SP1\)|  
|Windows Server 2008 R2 Datacenter with Service Pack 1 \(SP1\)|  
  
**Microsoft guest operating systems for conversion to Hyper\-V from VMware virtual machines**  
  
||  
|-|  
|Windows Server 2012 R2 Standard|  
|Windows Server 2012 R2 Datacenter|  
|Windows Server 2012 Standard|  
|Windows Server 2012 Datacenter|  
|Windows Server 2008 R2 Standard|  
|Windows Server 2008 R2 Enterprise|  
|Windows Server 2008 R2 Datacenter|  
|Windows Server 2008 R2 with SP1|  
|Windows Server 2008 Standard \(x86\/x64\)|  
|Windows Server 2008 Enterprise \(x86\/x64\)|  
|Windows Server 2008 Datacenter \(x86\/x64\)|  
|Windows 8.1 Enterprise \(x86\/x64\)|  
|Windows 8.1 Pro \(x86\/x64\)|  
|Windows 8 Enterprise \(x86\/x64\)|  
|Windows 8 Pro \(x86\/x64\)|  
|Windows 7 Enterprise \(x86\/x64\)|  
|Windows 7 Professional \(x86\/x64\)|  
|Windows 7 Ultimate \(x86\/x64\)|  
|Windows Vista Enterprise x86\/x64|  
  
**Linux operating systems for conversion from VMware virtual machines**  
  
||  
|-|  
|Red Hat Enterprise Linux 6 \(x86\/x64\)|  
|Red Hat Enterprise Linux 5 \(x86\/x64\)|  
|Ubuntu 12.04 \(x86\/x64\)|  
|Ubuntu 10.04 \(x86\/x64\)|  
|SUSE Linux Enterprise Server 11 \(x86\/x64\)|  
|CentOS 6 \(x86\/x64\)|  
|CentOS 5 \(x86\/x64\)|  
|Debian GNU\/Linux 7 \(x86\/x64\)|  
|Oracle Linux 6 \(x86\/x64\)|  
|Oracle Linux 5 \(x86\/x64\)|  
  
**Guest operating systems supported for converting to Microsoft Azure**  
  
> [!NOTE]  
> The list of supported VMware hosts is identical to the list of VMware hosts for which conversion to Hyper\-V is supported.  
  
||  
|-|  
|Windows Server 2012 R2 Standard|  
|Windows Server 2012 R2 Datacenter|  
|Windows Server 2012 Standard|  
|Windows Server 2012 Datacenter|  
|Windows Server 2008 R2 Standard|  
|Windows Server 2008 R2 Enterprise|  
|Windows Server 2008 R2 Datacenter|  
|Windows Server 2008 R2 with SP1|  
|Windows Server 2008 Standard \(x86\/x64\)|  
|Windows Server 2008 Enterprise \(x86\/x64\)|  
|Windows Server 2008 R2 Web x64|  
|Ubuntu 12.04 \(x86\/x64\)|  
|SUSE Linux Enterprise Server 11 \(x86\/x64\)|  
|CentOS 6 \(x86\/x64\)|  
|CentOS 5 \(x86\/x64\)|  
|Debian GNU\/Linux 7 \(x86\/x64\)|  
|Oracle Linux 6 \(x86\/x64\)|  
|Oracle Linux 5 \(x86\/x64\)|  
  
> [!IMPORTANT]  
> With Windows Server 2012 R2, the virtual machine must reside on a VMware vCenter Server 5.5\/ESXi 5.5. It cannot be on any older versions of VMware vCenter Server ESXi.  
  
> [!IMPORTANT]  
> MVMC doesn’t support EFI\-based virtual machines.  
  
> [!IMPORTANT]  
> MVMC doesn’t support a dynamic disk configuration in the source virtual machine.  
  
> [!IMPORTANT]  
> SUSE Linux Enterprise Server 11 \(SP2 and SP3\) require additional steps to enable Linux Integration Services when migrating from VMware to Hyper\-V.  
>   
> Perform these steps on the SUSE Linux Enterprise Server 11 SP2 or SUSE Linux Enterprise Server 11 SP3 virtual machine before conversion:  
>   
> -   Edit \/etc\/sysconfig\/kernel to include the Hyper\-V LIS modules. Add the hv\_ modules to the INITRD\_MODULES line. It should look similar to this:  
>   
>     INITRD\_MODULES\="mptspi ata\_piix ata\_generic vmxnet3 vmw\_pvscsi vmxnet **hv\_vmbus hv\_netvsc hv\_storvsc hv\_blkvsc**”  
> -   Re\-create the initrd with the following command. The kernel specified in the command must match the current kernel that the virtual machine boots with.  
>   
>     mkinitrd \-k \/boot\/vmlinux\-3.0.13\-0.27\-pae.gz \-i \/boot\/initrd\-3.0.13\-0.27\-pae  
  
> [!IMPORTANT]  
> For the following Linux versions, Linux Integration Services is available from Microsoft as a Red Hat Package Manager \(RPM\) package.  
>   
> -   Red Hat Enterprise Linux 5.8 and previous versions  
> -   CentOS Linux 5.8 and previous versions  
> -   Oracle Linux 5.8 and previous versions  
>   
> Perform these steps on the Linux virtual machine before conversion:  
>   
> -   Install the latest Linux Integration Services package.  
> -   Edit the \/etc\/grub.conf file:  
>   
>     -   Find the section that contains: **hda\=noprobe hdb\=noprobe**  
>     -   Change this section to: **hda\=probe hdb\=probe**  
>     -   Save the **\/etc\/grub.conf** file  
>     -   Reboot the Linux virtual machine before converting to the Microsoft virtual machine  
  
## Supported configurations for disk conversion  
The following VMware virtual disk types are supported for conversion:  
  
-   monolithicFlat  
  
-   monolithicSparse  
  
-   twoGbMaxExtentFlat  
  
-   twoGbMaxExtentSparse  
  
-   streamOptimized  
  
-   vmfs  
  
-   vmfsSparse  
  
-   delta disk conversion  
  
## Supported configurations for converting a physical machine to Hyper\-V  
The following outlines all supported configurations for physical machine to Hyper\-V.  
  
**Destination host servers**  
  
> [!NOTE]  
> Hyper\-V and the BITS Compact Server must be enabled.  
  
||  
|-|  
|Windows Server 2012 R2 Standard|  
|Windows Server 2012 R2 Datacenter|  
|Windows Server 2012 Standard|  
|Windows Server 2012 Datacenter|  
|Windows Server 2008 R2 Standard with SP1|  
|Windows Server 2008 R2 Enterprise with SP1|  
|Windows Server 2008 R2 Datacenter with SP1|  
  
**Operating systems that are supported for which MVMC can be installed**  
  
||  
|-|  
|Windows Server 2012 R2 Standard|  
|Windows Server 2012 R2 Datacenter|  
|Windows Server 2012 Standard|  
|Windows Server 2012 Datacenter|  
|Windows Server 2008 R2 Standard|  
|Windows Server 2008 R2 Enterprise|  
|Windows Server 2008 R2 Datacenter|  
|Windows Server 2008 R2 with SP1|  
|Windows 8.1|  
|Windows 8.1 Enterprise|  
|Windows 8|  
|Windows 8 Enterprise|  
|Windows 7 Standard|  
|Windows 7 Enterprise|  
|Windows 7 Datacenter|  
  
**Guest operating systems that are supported for conversion from physical machines to Hyper\-V**  
  
||  
|-|  
|Windows Server 2012 R2 Standard|  
|Windows Server 2012 R2 Datacenter|  
|Windows Server 2012 Standard|  
|Windows Server 2012 Datacenter|  
|Windows Server 2008 R2 Standard|  
|Windows Server 2008 R2 Enterprise|  
|Windows Server 2008 R2 Datacenter|  
|Windows Server 2008 R2 with SP1|  
|Windows Server 2008 Standard \(x86\/x64\)|  
|Windows Server 2008 Enterprise \(x86\/x64\)|  
|Windows Server 2008 Datacenter \(x86\/x64\)|  
|Windows 8.1|  
|Windows 8.1 Enterprise|  
|Windows 8|  
|Windows 8 Enterprise|  
|Windows 7 Enterprise \(x86\/x64\)|  
|Windows 7 Professional \(x86\/x64\)|  
|Windows 7 Ultimate \(x86\/x64\)|  
|Windows Vista Enterprise \(x86\/x64\)|  
  
