---
title: Virtual machine generations
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hprv
ms.tgt_pltfrm: na
ms.assetid: 540b8d0b-7774-4f40-abfd-31a584c3bda3
author: cwatsonmsft
robots: noindex,nofollow
---
# Virtual machine generations
This content is preliminary and subject to change.  
  
Most likely, your choice to create a generation 1 or generation 2 virtual machine will depend on which guest operating system you want to install and what type of environment you’re deploying the virtual machine to. Generally, we recommend that you create a generation 2 virtual machine to take advantage of features like Secure Boot.  But you may need to create a generation 1 virtual machine if one of the following statements is true:  
  
-   The VHD you want to boot from is not UEFI\-compatible.  
  
-   You plan to move your virtual machine to Microsoft Azure.  
  
-   Generation 2 doesn’t support the operating system you want to run on the virtual machine.  
  
-   Generation 2 doesn’t support the boot method you want to use.  
  
You can’t change a virtual machine’s generation after you’ve created it. So review the following sections in this article to make sure the generation you pick supports the operating system you want to install and the boot method you want to use. Also review the last section to learn what you get with a generation 2 virtual machines.  
  
## Which guest operating systems are supported?  
Generation 1 virtual machines support most guest operating systems. Generation 2 virtual machines support most 64\-bit versions of Windows and more current versions of Linux and FreeBSD operating systems. Use the following sections to see which generation of virtual machine will support the guest operating system you want to install.  
  
### Windows guest operating system support  
The following table shows what generation 1 and generation 2 virtual machines support for 64\-bit versions of Windows as guest operating systems.  
  
|64\-bit versions of Windows|Generation 1|Generation 2|  
|-------------------------------|----------------|----------------|  
|[!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)]|✔|✔|  
|[!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)]|✔|✔|  
|Windows Server 2008 R2|✔|✖|  
|Windows Server 2008|✔|✖|  
|[!INCLUDE[winthreshold_client_1](../Token/winthreshold_client_1_md.md)]|✔|✔|  
|[!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]|✔|✔|  
|[!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]|✔|✔|  
|Windows 7|✔|✖|  
  
The following table shows what generation 1 and generation 2 virtual machines support for 32\-bit versions of Windows as guest operating systems.  
  
|32\-bit versions of Windows|Generation 1|Generation 2|  
|-------------------------------|----------------|----------------|  
|[!INCLUDE[winthreshold_client_1](../Token/winthreshold_client_1_md.md)]|✔|✖|  
|[!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)]|✔|✖|  
|[!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)]|✔|✖|  
|Windows 7|✔|✖|  
  
For more information, see [Generation 2 Virtual Machine Overview](http://technet.microsoft.com/library/dn282285.aspx).  
  
### CentOS and Red Hat Enterprise Linux guest operating system support  
The following table shows what generation 1 and generation 2 virtual machines support for versions of Red Hat Enterprise Linux \(RHEL\) and CentOS as guest operating systems.  
  
|Operating system versions|Generation 1|Generation 2|  
|-----------------------------|----------------|----------------|  
|RHEL\/CentOS 7.x Series|✔|✔|  
|RHEL\/CentOS 6.x Series|✔|✖|  
|RHEL\/CentOS 5.x Series|✔|✖|  
  
For more information, see [CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](http://technet.microsoft.com/library/dn531026.aspx).  
  
### Debian guest operating system support  
The following table shows what generation 1 and generation 2 virtual machines support for versions of Debian as guest operating systems.  
  
|Operating system versions|Generation 1|Generation 2|  
|-----------------------------|----------------|----------------|  
|Debian 7.0\-7.8|✔|✖|  
  
For more information, see [Debian virtual machines on Hyper-V](http://technet.microsoft.com/library/dn614985.aspx).  
  
### FreeBSD guest operating system support  
The following table shows what generation 1 and generation 2 virtual machines support for versions of FreeBSD as guest operating systems.  
  
|Operating system versions|Generation 1|Generation 2|  
|-----------------------------|----------------|----------------|  
|FreeBSD 10. and 10.1|✔|✖|  
|FreeBSD 9.1 and 9.3|✔|✖|  
|FreeBSD 8.4|✔|✖|  
  
For more information, see [FreeBSD virtual machines on Hyper-V](http://technet.microsoft.com/library/dn848318.aspx).  
  
### Oracle Linux guest operating system support  
The following table shows what generation 1 and generation 2 virtual machines support for Red Hat Compatible Kernel Series versions as guest operating systems.  
  
|Red Hat Compatible Kernel Series versions|Generation 1|Generation 2|  
|---------------------------------------------|----------------|----------------|  
|Oracle Linux 7.x Series|✔|✔|  
|Oracle Linux 6.6, 6.5, and 6.4|✔|✖|  
  
The following table shows what generation 1 and generation 2 virtual machines support for Unbreakable Enterprise Kernel versions as guest operating systems.  
  
|Unbreakable Enterprise Kernel \(UEK\) versions|Generation 1|Generation 2|  
|--------------------------------------------------|----------------|----------------|  
|Oracle Linux UEK R3 QU3|✔|✖|  
|Oracle Linux UEK R3 QU2|✔|✖|  
|Oracle Linux UEK R3 QU1|✔|✖|  
  
For more information, see [Oracle Linux virtual machines on Hyper-V](http://technet.microsoft.com/library/dn609828.aspx).  
  
### SUSE guest operating system support  
The following table shows what generation 1 and generation 2 virtual machines support for versions of SUSE as guest operating systems  
  
|Operating system versions|Generation 1|Generation 2|  
|-----------------------------|----------------|----------------|  
|SUSE Linux Enterprise Server 12|✔|✔|  
|SUSE Linux Enterprise Server 11 SP3|✔|✖|  
|SUSE Linux Enterprise Server 11 SP2|✔|✖|  
|Open SUSE 12.3|✔|✖|  
  
For more information, see [SUSE virtual machines on Hyper-V](http://technet.microsoft.com/library/dn531027.aspx).  
  
### Ubuntu guest operating system support  
The following table shows what generation 1 and generation 2 virtual machines support for versions of Ubuntu as guest operating systems.  
  
|Operating system versions|Generation 1|Generation 2|  
|-----------------------------|----------------|----------------|  
|Ubuntu 14.04 and later versions|✔|✔|  
|Ubuntu 12.04|✔|✖|  
  
For more information, see [Ubuntu virtual machines on Hyper-V](http://technet.microsoft.com/library/dn531029.aspx).  
  
## How can I boot the virtual machine?  
The following table shows which boot methods are supported by generation 1 and generation 2 virtual machines.  
  
|Boot method|Generation 1|Generation 2|  
|---------------|----------------|----------------|  
|PXE boot by using a standard network adapter|✖|✔|  
|PXE boot by using a legacy network adapter|✔|✖|  
|Boot from a SCSI virtual hard disk \(.VHDX\) or virtual DVD \(.ISO\)|✖|✔|  
|Boot from IDE Controller virtual hard disk \(.VHD\) or virtual DVD \(.ISO\)|✔|✖|  
|Boot from floppy \(.VFD\)|✔|✖|  
  
## What do I get with a generation 2 virtual machine?  
You get the following benefits when you use a generation 2 virtual machine:  
  
-   **Secure Boot** \- This is a feature that verifies the boot loader is signed   
    by a trusted authority in the UEFI database to help prevent unauthorized firmware, operating systems, or UEFI drivers from   
    running at boot time. Secure Boot is enabled by default for generation 2 virtual machines. If you need to run a guest   
    operating system that’s not supported by Secure Boot, you can disable it after the virtual machine’s created.  For more   
    information, see [Secure Boot](http://technet.microsoft.com/library/hh824987.aspx).  
  
    To Secure Boot generation 2 Linux virtual machines, you need to choose the UEFI CA Secure Boot   
    template when you create the virtual machine.  
  
-   **Larger boot volume** \- The maximum boot volume for generation 2 virtual   
    machines is 64TB. This is the maximum disk size supported by a .VHDX. For generation 1 virtual machines, the maximum boot   
    volume is 2TB for a .VHDX and 2040GB for a .VHD.  
  
    For more information like a device support comparison and   
    frequently asked questions, see [Generation 2 Virtual Machine Overview](http://technet.microsoft.com/library/dn282285.aspx).  
  
## See Also  
[Generation 2 Virtual Machine Overview](http://technet.microsoft.com/library/dn282285.aspx)  
[Linux and FreeBSD Virtual Machines on Hyper-V](http://technet.microsoft.com/library/dn531030.aspx)  
  
