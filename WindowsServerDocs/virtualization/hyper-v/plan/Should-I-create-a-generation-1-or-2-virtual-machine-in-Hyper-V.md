---
title: Should I create a generation 1 or 2 virtual machine in Hyper-V?
description: "Gives considerations such as supported boot methods and other feature differences to help you choose which generation meets your needs."
ms.prod: windows-server-threshold
ms.service: na
manager: dongill
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 02e31413-6140-4723-a8d6-46c7f667792d
author: KBDAzure
ms.author: kathydav
ms.date: 12/05/2016
---
# Should I create a generation 1 or 2 virtual machine in Hyper-V?

>Applies To: Windows 10, Windows Server 2016, Microsoft Hyper-V Server 2016, Windows Server 2019, Microsoft Hyper-V Server 2019

> [!NOTE]
> If you plan to ever upload a Windows virtual machines (VM) from on-premises to Microsoft Azure, generation 1 and generation 2 VMs in the VHD file format and have a fixed sized disk are supported. See [Generation 2 VMs on Azure](https://docs.microsoft.com/azure/virtual-machines/windows/generation-2) to learn more about generation 2 capabilities supported on Azure. For more information on uploading a Windows VHD or VHDX, see [Prepare a Windows VHD or VHDX to upload to Azure](https://docs.microsoft.com/azure/virtual-machines/windows/prepare-for-upload-vhd-image).

Your choice to create a generation 1 or generation 2 virtual machine depends on which guest operating system you want to install and the boot method you want to use to deploy the virtual machine. We recommend that you create a generation 2 virtual machine to take advantage of features like Secure Boot unless one of the following statements is true:  

- The VHD you want to boot from is not [UEFI-compatible](https://technet.microsoft.com/library/hh824898.aspx).  
- Generation 2 doesn't support the operating system you want to run on the virtual machine.  
- Generation 2 doesn't support the boot method you want to use.  

For more information about what features are available with generation 2 virtual machines, see [Hyper-V feature compatibility by generation and guest](../Hyper-V-feature-compatibility-by-generation-and-guest.md).

You can't change a virtual machine's generation after you've created it. So, we recommend that you review the considerations here, as well as choose the operating system, boot method, and features you want to use before you choose a generation.  

## Which guest operating systems are supported?

Generation 1 virtual machines support most guest operating systems. Generation 2 virtual machines support most 64-bit versions of Windows and more current versions of Linux and FreeBSD operating systems. Use the following sections to see which generation of virtual machine supports the guest operating system you want to install.  

- [Windows guest operating system support](#windows-guest-operating-system-support)  

- [CentOS and Red Hat Enterprise Linux guest operating system support](#centos-and-red-hat-enterprise-linux-guest-operating-system-support)  

- [Debian guest operating system support](#debian-guest-operating-system-support)  

- [FreeBSD guest operating system support](#freebsd-guest-operating-system-support)  

- [Oracle Linux guest operating system support](#oracle-linux-guest-operating-system-support)  

- [SUSE guest operating system support](#suse-guest-operating-system-support)  

- [Ubuntu guest operating system support](#ubuntu-guest-operating-system-support)  

### Windows guest operating system support

The following table shows which 64-bit versions of Windows you can use as a guest operating system for generation 1 and generation 2 virtual machines.  

|64-bit versions of Windows|Generation 1|Generation 2|  
|-------------------------------|----------------|----------------|  
| Windows Server 2019 |&#10004;|&#10004;|  
| Windows Server 2016 |&#10004;|&#10004;|  
| Windows Server 2012 R2 |&#10004;|&#10004;|  
| Windows Server 2012 |&#10004;|&#10004;|  
|Windows Server 2008 R2|&#10004;| &#10006;|  
|Windows Server 2008|&#10004;| &#10006;|  
|Windows 10|&#10004;|&#10004;|  
|Windows 8.1|&#10004;|&#10004;|  
|Windows 8|&#10004;|&#10004;|  
|Windows 7|&#10004;| &#10006;|

The following table shows which 32-bit versions of Windows you can use as a guest operating system for generation 1 and generation 2 virtual machines.

|32-bit versions of Windows|Generation 1|Generation 2|  
|-------------------------------|----------------|----------------|  
|Windows 10|&#10004;| &#10006;|  
|Windows 8.1|&#10004;| &#10006;|  
|Windows 8|&#10004;| &#10006;|  
|Windows 7|&#10004;| &#10006;|  

### CentOS and Red Hat Enterprise Linux guest operating system support

The following table shows which versions of Red Hat Enterprise Linux \(RHEL\) and CentOS you can use as a guest operating system for generation 1 and generation 2 virtual machines.

|Operating system versions|Generation 1|Generation 2|  
|-----------------------------|----------------|----------------|  
|RHEL/CentOS 7.x series|&#10004;|&#10004;|  
|RHEL/CentOS 6.x series|&#10004;|&#10004;<br />**Note:** Only supported on Windows Server 2016 and above.|  
|RHEL/CentOS 5.x series|&#10004;| &#10006;|  

For more information, see [CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](../Supported-CentOS-and-Red-Hat-Enterprise-Linux-virtual-machines-on-Hyper-V.md).  

### Debian guest operating system support  

The following table shows which versions of Debian you can use as a guest operating system for generation 1 and generation 2 virtual machines.

|Operating system versions|Generation 1|Generation 2|  
|-----------------------------|----------------|----------------|  
|Debian 7.x series|&#10004;| &#10006;|  
|Debian 8.x series|&#10004;|&#10004;|  

For more information, see [Debian virtual machines on Hyper-V](../Supported-Debian-virtual-machines-on-Hyper-V.md).  

### FreeBSD guest operating system support

The following table shows which versions of FreeBSD you can use as a guest operating system for generation 1 and generation 2 virtual machines.  

|Operating system versions|Generation 1|Generation 2|  
|-----------------------------|----------------|----------------|  
|FreeBSD 10 and 10.1|&#10004;| &#10006;|  
|FreeBSD 9.1 and 9.3|&#10004;| &#10006;|  
|FreeBSD 8.4|&#10004;| &#10006;|  

For more information, see [FreeBSD virtual machines on Hyper-V](../Supported-FreeBSD-virtual-machines-on-Hyper-V.md).  

### Oracle Linux guest operating system support  

The following table shows which versions of Red Hat Compatible Kernel Series you can use as a guest operating system for generation 1 and generation 2 virtual machines.  

|Red Hat Compatible Kernel Series versions|Generation 1|Generation 2|  
|---------------------------------------------|----------------|----------------|  
|Oracle Linux 7.x series|&#10004;|&#10004;|
|Oracle Linux 6.x series|&#10004;| &#10006;|  

The following table shows which versions of Unbreakable Enterprise Kernel you can use as a guest operating system for generation 1 and generation 2 virtual machines.

|Unbreakable Enterprise Kernel (UEK) versions|Generation 1|Generation 2|  
|--------------------------------------------------|----------------|----------------|  
|Oracle Linux UEK R3 QU3|&#10004;| &#10006;|  
|Oracle Linux UEK R3 QU2|&#10004;| &#10006;|  
|Oracle Linux UEK R3 QU1|&#10004;| &#10006;|  

For more information, see [Oracle Linux virtual machines on Hyper-V](../Supported-Oracle-Linux-virtual-machines-on-Hyper-V.md).  

### SUSE guest operating system support

The following table shows which versions of SUSE you can use as a guest operating system for generation 1 and generation 2 virtual machines.

|Operating system versions|Generation 1|Generation 2|  
|-----------------------------|----------------|----------------|  
|SUSE Linux Enterprise Server 12 series|&#10004;|&#10004;|  
|SUSE Linux Enterprise Server 11 series|&#10004;| &#10006;|  
|Open SUSE 12.3|&#10004;| &#10006;|  

For more information, see [SUSE virtual machines on Hyper-V](../Supported-SUSE-virtual-machines-on-Hyper-V.md).  

### Ubuntu guest operating system support

The following table shows which versions of Ubuntu you can use as a guest operating system for generation 1 and generation 2 virtual machines.

|Operating system versions|Generation 1|Generation 2|  
|-----------------------------|----------------|----------------|  
|Ubuntu 14.04 and later versions|&#10004;|&#10004;|  
|Ubuntu 12.04|&#10004;| &#10006;|  

For more information, see [Ubuntu virtual machines on Hyper-V](../Supported-Ubuntu-virtual-machines-on-Hyper-V.md).  

## How can I boot the virtual machine?

The following table shows which boot methods are supported by generation 1 and generation 2 virtual machines.  

|Boot method|Generation 1|Generation 2|  
|---------------|----------------|----------------|  
|PXE boot by using a standard network adapter| &#10006;|&#10004;|  
|PXE boot by using a legacy network adapter|&#10004;| &#10006;|  
|Boot from a SCSI virtual hard disk (.VHDX) or virtual DVD (.ISO)| &#10006;|&#10004;|  
|Boot from IDE Controller virtual hard disk (.VHD) or virtual DVD (.ISO)|&#10004;| &#10006;|  
|Boot from floppy (.VFD)|&#10004;| &#10006;|  

## What are the advantages of using generation 2 virtual machines?

Here are some of the advantages you get when you use a generation 2 virtual machine:  
- **Secure Boot**
    This is a feature that verifies the boot loader is signed by a trusted authority in the UEFI database to help prevent unauthorized firmware, operating systems, or UEFI drivers from running at boot time. Secure Boot is enabled by default for generation 2 virtual machines. If you need to run a guest operating system that's not supported by Secure Boot, you can disable it after the virtual machine's created.  For more information, see [Secure Boot](https://technet.microsoft.com/library/dn486875.aspx).  

    To Secure Boot generation 2 Linux virtual machines, you need to choose the UEFI CA Secure Boot template when you create the virtual machine.  

- **Larger boot volume**
    The maximum boot volume for generation 2 virtual machines is 64 TB. This is the maximum disk size supported by a .VHDX. For generation 1 virtual machines, the maximum boot volume is 2TB for a .VHDX and 2040GB for a .VHD. For more information, see [Hyper-V Virtual Hard Disk Format Overview](https://technet.microsoft.com/library/hh831446.aspx).  

  You may also see a slight improvement in virtual machine boot and installation times with generation 2 virtual machines.

## What's the difference in device support?

The following table compares the devices available between generation 1 and generation 2 virtual machines.  

|Generation 1 Device|Generation 2 Replacement|Generation 2 Enhancements|  
|-----------------------|----------------------------|-----------------------------|  
|IDE controller|Virtual SCSI controller|Boot from .vhdx (64 TB maximum size, and online resize capability)|  
|IDE CD-ROM|Virtual SCSI CD-ROM|Support for up to 64 SCSI DVD devices per SCSI controller.|  
|Legacy BIOS|UEFI firmware|Secure Boot|  
|Legacy network adapter|Synthetic network adapter|Network boot with IPv4 and IPv6|  
|Floppy controller and DMA controller|No floppy controller support|N/A|  
|Universal asynchronous receiver/transmitter (UART) for COM ports|Optional UART for debugging|Faster and more reliable|  
|i8042 keyboard controller|Software-based input|Uses fewer resources because there is no emulation. Also reduces the attack surface from the guest operating system.|  
|PS/2 keyboard|Software-based keyboard|Uses fewer resources because there is no emulation. Also reduces the attack surface from the guest operating system.|  
|PS/2 mouse|Software-based mouse|Uses fewer resources because there is no emulation. Also reduces the attack surface from the guest operating system.|  
|S3 video|Software-based video|Uses fewer resources because there is no emulation. Also reduces the attack surface from the guest operating system.|  
|PCI bus|No longer required|N/A|  
|Programmable interrupt controller (PIC)|No longer required|N/A|  
|Programmable interval timer (PIT)|No longer required|N/A|  
|Super I/O device|No longer required|N/A|  

## More about generation 2 virtual machines

Here are some additional tips about using generation 2 virtual machines.

### Attach or add a DVD drive

- You can't attach a physical CD or DVD drive to a generation 2 virtual machine. The virtual DVD drive in generation 2 virtual machines only supports ISO image files. To create an ISO image file of a Windows environment, you can use the Oscdimg  command line tool. For more information, see [Oscdimg Command-Line Options](https://msdn.microsoft.com/library/hh824847.aspx).
- When you create a new virtual machine with the New-VM Windows PowerShell cmdlet, the generation 2 virtual machine doesn't have a DVD drive. You can add a DVD drive while the virtual machine is running.

### Use UEFI firmware

- Secure Boot or UEFI firmware isn't required on the physical Hyper-V host. Hyper-V provides virtual firmware to virtual machines that is independent of what's on the Hyper-V host.
- UEFI firmware in a generation 2 virtual machine doesn't support setup mode for Secure Boot.
- We don't support running a UEFI shell or other UEFI applications in a generation 2 virtual machine. Using a non-Microsoft UEFI shell or UEFI applications is technically possible if they are compiled directly from the sources. If these applications are not appropriately digitally signed, you must disable Secure Boot for the virtual machine.

### Work with VHDX files

- You can resize a VHDX file that contains the boot volume for a generation 2 virtual machine while the virtual machine is running.
- We don't support or recommend that you create a VHDX file that is bootable to both generation 1 and generation 2 virtual machines.  
- The virtual machine generation is a property of the virtual machine, not a property of the virtual hard disk. So you can't tell if a VHDX file was created by a generation 1 or a generation 2 virtual machine.  
- A VHDX file created with a generation 2 virtual machine can be attached to the IDE controller or the SCSI controller of a generation 1 virtual machine. However, if this is a bootable VHDX file, the generation 1 virtual machine won't boot.

### Use IPv6 instead of IPv4

By default, generation 2 virtual machines use IPv4. To use IPv6 instead, run the [Set-VMFirmware](https://technet.microsoft.com/library/dn464287.aspx) Windows PowerShell cmdlet. For example, the following command sets the preferred protocol to IPv6 for a virtual machine named TestVM:  

```powershell
Set-VMFirmware -VMName TestVM -IPProtocolPreference IPv6  
```  

## Add a COM port for kernel debugging

COM ports aren't available in generation 2 virtual machines until you add them. You can do this with Windows PowerShell or Windows Management Instrumentation (WMI). These steps show you how to do it with Windows PowerShell.

To add a COM port:  

1. Disable Secure Boot. Kernel debugging isn't compatible with Secure Boot. Make sure the virtual machine is in an Off state, then use the [Set-VMFirmware](https://technet.microsoft.com/library/dn464287.aspx) cmdlet. For example, the following command disables Secure Boot on virtual machine TestVM:  

    ```powershell  
    Set-VMFirmware -Vmname TestVM -EnableSecureBoot Off  
    ```  

2. Add a COM port. Use the [Set-VMComPort](https://technet.microsoft.com/library/hh848616.aspx) cmdlet to do this. For example, the following command configures the first COM port on virtual machine, TestVM, to connect to the named pipe, TestPipe, on the local computer:  

    ```powershell
    Set-VMComPort -VMName TestVM 1 \\.\pipe\TestPipe  
    ```  

> [!NOTE]  
> Configured COM ports aren't listed in the settings of a virtual machine in Hyper-V Manager.

## See Also  

- [Linux and FreeBSD Virtual Machines on Hyper-V](../Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)
- [Use local resources on Hyper-V virtual machine with VMConnect](../learn-more/Use-local-resources-on-Hyper-V-virtual-machine-with-VMConnect.md)
- [Plan for Hyper-V scalability in Windows Server 2016](Plan-for-Hyper-V-scalability-in-Windows-Server-2016.md)
