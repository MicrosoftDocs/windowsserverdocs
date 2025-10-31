---
title: Should I create a generation 1 or 2 virtual machine in Hyper-V?
description: Gives considerations such as supported boot methods and other feature differences to help you choose which generation meets your needs.
ms.topic: concept-article
ms.author: daknappe
author: dknappettmsft
ms.date: 06/18/2025
---
# Should I create a generation 1 or 2 virtual machine in Hyper-V?

Creating a generation 1 or generation 2 virtual machine depends on which guest operating system you want to install and the boot method you want to use to deploy the virtual machine. We recommend you create a generation 2 virtual machines to take advantage of features like Secure Boot unless one of the following statements is true:

- You're using an existing, prebuilt virtual hard drive (VHD or VHDX files), which isn't [compatible with UEFI](/windows-hardware/manufacture/desktop/boot-to-uefi-mode-or-legacy-bios-mode).
- Generation 2 doesn't support the operating system you want to run on the virtual machine.
- Generation 2 doesn't support the boot method you want to use.

For more information about what features are available with generation 2 virtual machines, see [Hyper-V feature compatibility by generation and guest](../Hyper-V-feature-compatibility-by-generation-and-guest.md).

You can't change a virtual machine's generation once it's created. We recommend that you review the considerations here, and choose the operating system, boot method, and features you want to use before you choose a generation.

## What are the advantages of using generation 2 virtual machines?

Here are some of the advantages you get when you use a generation 2 virtual machine:

- **Secure Boot**

  Use Secure Boot to help prevent unauthorized firmware, operating systems, or UEFI drivers from running at boot time. Secure Boot verifies the boot loader is signed by a trusted authority in the UEFI database. Secure Boot is enabled by default for generation 2 virtual machines. If you need to run a guest operating system that Secure Boot doesn't support, you can disable it after you create the virtual machine. For more information, see [Secure Boot](/windows-hardware/design/device-experiences/oem-secure-boot).

  To Secure Boot generation 2 Linux virtual machines, you need to choose the UEFI CA Secure Boot template when you create the virtual machine.

- **Larger boot volume**
  The maximum boot volume for generation 2 virtual machines is 64 TB. This maximum boot volume is the maximum disk size supported by a `.VHDX` For generation 1 virtual machines, the maximum boot volume is 2 TB for a `.VHDX`and 2040 GB for a `.VHD`.

  You might also see a slight improvement in virtual machine boot and installation times with generation 2 virtual machines.

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

| 64-bit versions of Windows | Generation 1 | Generation 2 |
|--|--|--|
| Windows Server 2025 |&#10004;|&#10004;|
| Windows Server 2022 |&#10004;|&#10004;|
| Windows Server 2019 |&#10004;|&#10004;|
| Windows Server 2016 |&#10004;|&#10004;|
| Windows Server 2012 R2 |&#10004;|&#10004;|
| Windows Server 2012 |&#10004;|&#10004;|
| Windows 11 |&#10006;|&#10004;|
| Windows 10 |&#10004;|&#10004;|

The following table shows which 32-bit versions of Windows you can use as a guest operating system for generation 1 and generation 2 virtual machines.

|32-bit versions of Windows|Generation 1|Generation 2|
|-------------------------------|----------------|----------------|
|Windows 10|&#10004;| &#10006;|

### CentOS and Red Hat Enterprise Linux guest operating system support

The following table shows which versions of Red Hat Enterprise Linux (RHEL) and CentOS you can use as a guest operating system for generation 1 and generation 2 virtual machines.

|Operating system versions|Generation 1|Generation 2|
|-----------------------------|----------------|----------------|
|RHEL/CentOS 10.x series|&#10004;|&#10004;|
|RHEL/CentOS 9.x series|&#10004;|&#10004;|
|RHEL/CentOS 8.x series|&#10004;|&#10004;|

For more information, see [CentOS and Red Hat Enterprise Linux virtual machines on Hyper-V](../Supported-CentOS-and-Red-Hat-Enterprise-Linux-virtual-machines-on-Hyper-V.md).

### Debian guest operating system support

The following table shows which versions of Debian you can use as a guest operating system for generation 1 and generation 2 virtual machines.

|Operating system versions|Generation 1|Generation 2|
|-----------------------------|----------------|----------------|
|Debian 12.x (Bookworm) series|&#10004;|&#10004;|
|Debian 11.x (Bullseye) series|&#10004;|&#10004;|
|Debian 10.x (Buster) series|&#10004;|&#10004;|

For more information, see [Debian virtual machines on Hyper-V](../Supported-Debian-virtual-machines-on-Hyper-V.md).

### FreeBSD guest operating system support

The following table shows which versions of FreeBSD you can use as a guest operating system for generation 1 and generation 2 virtual machines.

|Operating system versions|Generation 1|Generation 2|
|-----------------------------|----------------|----------------|
|FreeBSD 13.0 to 13.5|&#10004;| &#10004;|
|FreeBSD 12.0 to 12.4|&#10004;| &#10004;|
|FreeBSD 11.0 to 11.4|&#10004;| &#10004;|

For more information, see [FreeBSD virtual machines on Hyper-V](../Supported-FreeBSD-virtual-machines-on-Hyper-V.md).

### Oracle Linux guest operating system support

The following table shows which versions of Red Hat Compatible Kernel Series you can use as a guest operating system for generation 1 and generation 2 virtual machines.

|Red Hat Compatible Kernel Series versions|Generation 1|Generation 2|
|---------------------------------------------|----------------|----------------|
|Oracle Linux 9.x series|&#10004;|&#10004;|
|Oracle Linux 8.x series|&#10004;|&#10004;|

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
|SUSE Linux Enterprise Server 15 series|&#10004;|&#10004;|
|SUSE Linux Enterprise Server 12 series|&#10004;|&#10004;|
|SUSE Linux Enterprise Server 11 series|&#10004;| &#10006;|
|Open SUSE 12.3|&#10004;| &#10006;|

For more information, see [SUSE virtual machines on Hyper-V](../Supported-SUSE-virtual-machines-on-Hyper-V.md).

### Ubuntu guest operating system support

The following table shows which versions of Ubuntu you can use as a guest operating system for generation 1 and generation 2 virtual machines.

|Operating system versions|Generation 1|Generation 2|
|-----------------------------|----------------|----------------|
|Ubuntu 24.04|&#10004;|&#10004;|
|Ubuntu 22.04|&#10004;|&#10004;|
|Ubuntu 20.04|&#10004;|&#10004;|
|Ubuntu 18.04|&#10004;|&#10004;|
|Ubuntu 16.04|&#10004;|&#10004;|
|Ubuntu 14.04|&#10004;|&#10004;|

For more information, see [Ubuntu virtual machines on Hyper-V](../Supported-Ubuntu-virtual-machines-on-Hyper-V.md).

## How can I boot the virtual machine?

Generation 1 and generation 2 VMs support different boot methods, these methods are shown in the following table.

|Boot method|Generation 1|Generation 2|
|---------------|----------------|----------------|
|PXE boot by using a standard network adapter| &#10006;|&#10004;|
|PXE boot by using a legacy network adapter|&#10004;| &#10006;|
|Boot from a SCSI virtual hard disk (`.VHDX)` or virtual DVD (.ISO)| &#10006;|&#10004;|
|Boot from IDE Controller virtual hard disk (`.VHD)`, virtual DVD (`.ISO)` or a physical CD/DVD drive|&#10004;| &#10006;|
|Boot from virtual floppy (`.VFD)`|&#10004;| &#10006;|

## What's the difference in device support?

The following table compares the devices available between generation 1 and generation 2 virtual machines.

|Generation 1 Device|Generation 2 Replacement|Generation 2 Enhancements|
|-----------------------|----------------------------|-----------------------------|
|IDE controller|Virtual SCSI controller|Boot from `.VHDX`(64 TB maximum size, and online resize capability)|
|IDE CD-ROM|Virtual SCSI CD-ROM|Support for up to 64 SCSI DVD devices per SCSI controller.|
|Legacy BIOS|UEFI firmware|Secure Boot|
|Legacy network adapter|Synthetic network adapter|Network boot with IPv4 and IPv6|
|Floppy controller and DMA controller|No floppy controller support|N/A|
|Universal asynchronous receiver/transmitter (UART) for COM ports|Optional UART for debugging|Faster and more reliable|
|i8042 keyboard controller|Software-based input|Uses fewer resources because there's no emulation. Also reduces the attack surface from the guest operating system.|
|PS/2 keyboard|Software-based keyboard|Uses fewer resources because there's no emulation. Also reduces the attack surface from the guest operating system.|
|PS/2 mouse|Software-based mouse|Uses fewer resources because there's no emulation. Also reduces the attack surface from the guest operating system.|
|S3 video|Software-based video|Uses fewer resources because there's no emulation. Also reduces the attack surface from the guest operating system.|
|PCI bus|No longer required|N/A|
|Programmable interrupt controller (PIC)|No longer required|N/A|
|Programmable interval timer (PIT)|No longer required|N/A|
|Super I/O device|No longer required|N/A|

## Considerations for using generation 1 and generation 2 virtual machines

Here are some more tips about using the different generations of virtual machines.

### Create VMs with more than 64 logical CPUs

Hyper-V manager might fail to create a new generation 1 VM on a system with more than 64 logical CPUs. Hyper-V manager doesn’t let you specify the number of virtual processors at VM creation time. For hosts with more than 64 logical processors, specify the number of virtual processors at VM creation using Windows Admin Center, PowerShell, or another tool.

### Upload a virtual hard drive to Azure

Virtual hard drives created on generation 1 and generation 2 VMs can be uploaded to Azure as long as they use the VHD file format. The virtual hard drive must have a fixed (not dynamically expanding) sized disk. See [Generation 2 VMs on Azure](/azure/virtual-machines/windows/generation-2) to learn more about generation 2 capabilities supported on Azure. For more information on uploading a Windows VHD or VHDX, see [Prepare a Windows VHD or VHDX to upload to Azure](/azure/virtual-machines/windows/prepare-for-upload-vhd-image).

### Attach or add a DVD drive

- You can't attach a physical CD or DVD drive to a generation 2 virtual machine. The virtual DVD drive in generation 2 virtual machines only supports ISO image files. To create an ISO image file of a Windows environment, you can use the *OScdimg* command line tool. For more information, see [Oscdimg Command-Line Options](/windows-hardware/manufacture/desktop/oscdimg-command-line-options).
- When you create a new virtual machine with the `New-VM` Windows PowerShell cmdlet, the generation 2 virtual machine doesn't have a DVD drive. You can add a DVD drive while the virtual machine is running.

### Use UEFI firmware

- Secure Boot or UEFI firmware isn't required on the physical Hyper-V host. For generation 2 VMs, Hyper-V provides virtual firmware to virtual machines that is independent of what's on the Hyper-V host.
- UEFI firmware in a generation 2 virtual machine doesn't support setup mode for Secure Boot.
- We don't support running a UEFI shell or other UEFI applications in a generation 2 virtual machine. Using a non-Microsoft UEFI shell or UEFI applications is technically possible if they're compiled directly from the sources. If these applications aren't digitally signed correctly, you must disable Secure Boot for the virtual machine.

### Work with VHDX files

- You can resize a VHDX file that contains the boot volume for a generation 2 virtual machine while the virtual machine is running.
- We don't support or recommend that you create a single virtual disk (VHD or VHDX file) that is bootable to **both** generation 1 and generation 2 virtual machines. Instead, create bootable VHDX files that target only generation 1 **or** generation 2 virtual machines.
- The virtual machine generation is a property of the virtual machine, not a property of the virtual hard disk. You can't tell if a VHDX file was created as a generation 1 or a generation 2 virtual machine.
- A VHDX file created with a generation 2 virtual machine can be attached to the IDE controller or the SCSI controller of a generation 1 virtual machine. However, if the virtual hard drive is a bootable VHDX file, the generation 1 virtual machine fails to boot.

### Use IPv6 instead of IPv4

When you boot from network with PXE, generation 2 virtual machines use IPv4 by default. To use IPv6 instead, run the [Set-VMFirmware](/powershell/module/hyper-v/set-vmfirmware) Windows PowerShell cmdlet. For example, the following command sets the preferred protocol to IPv6 for a virtual machine named TestVM:

```powershell
Set-VMFirmware -VMName 'TestVM' -IPProtocolPreference IPv6
```

## Add a COM port for kernel debugging

COM ports aren't available in generation 2 virtual machines until you add them. You can add COM ports with Windows PowerShell or Windows Management Instrumentation (WMI). These steps show you how to do it with Windows PowerShell.

To add a COM port:

1. Disable Secure Boot. Kernel debugging isn't compatible with Secure Boot. Make sure the virtual machine is in an Off state, then use the [Set-VMFirmware](/powershell/module/hyper-v/set-vmfirmware) cmdlet. For example, the following command disables Secure Boot on virtual machine TestVM:

    ```powershell
    Set-VMFirmware -VMName 'TestVM' -EnableSecureBoot Off
    ```

2. Add a COM port. Use the [Set-VMComPort](/powershell/module/hyper-v/set-vmcomport) cmdlet to add a COM port. For example, the following command configures the first COM port on virtual machine, TestVM, to connect to the named pipe, TestPipe, on the local computer:

    ```powershell
    Set-VMComPort -VMName 'TestVM' -Number 1 -Path '\\.\pipe\TestPipe'
    ```

> [!NOTE]
> Configured COM ports aren't listed in the settings of a virtual machine in Hyper-V Manager.

## Related content

- [Linux and FreeBSD Virtual Machines on Hyper-V](../Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md)
- [Use local resources on Hyper-V virtual machine with VMConnect](../learn-more/Use-local-resources-on-Hyper-V-virtual-machine-with-VMConnect.md)
- [Plan for Hyper-V scalability in Windows Server 2016](../maximum-scale-limits.md)
