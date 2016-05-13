---
title: Generation 2 Virtual Machine Overview
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b1ddf7cd-dab8-4cc0-bd32-528f8df97540
---
# Generation 2 Virtual Machine Overview
The generation of a virtual machine determines the virtual hardware and functionality that is presented to the virtual machine. In Hyper\-V there are two supported virtual machine generations, generation 1 and generation 2. Generation 2 virtual machines have a simplified virtual hardware model, and supports Unified Extensible Firmware Interface \(UEFI\) firmware instead of BIOS\-based firmware. The majority of legacy devices have also been removed from generation 2 virtual machines.

This topic describes the various benefits and the requirements for generation 2 virtual machines.

## <a name="BKMK_OVER"></a>
In previous versions of Hyper\-V, there was only one generation of virtual machine. In [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] there are two generations of virtual machines to choose from when you create a new virtual machine:

-   **Generation 1** Provides the same virtual hardware to the virtual machine as in previous versions of Hyper\-V.

-   **Generation 2** Provides the following new functionality on a virtual machine:

    -   PXE boot by using a standard network adapter

    -   Boot from a SCSI virtual hard disk

    -   Boot from a SCSI virtual DVD

    -   Secure Boot \(enabled by default\)

    -   UEFI firmware support

> [!NOTE]
> IDE drives and legacy network adapter support has been removed.

## Requirements
The following Windows guest operating systems are supported as generation 2 virtual machines:

-   [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)]

-   [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)]

-   64\-bit versions of [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)]

-   64\-bit versions of [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)]

-   For information about Linux distributions that support Generation 2 virtual machines, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md).

    > [!WARNING]
    > Generation 2 Linux virtual machines will not boot unless the secure boot option is disabled.

> [!CAUTION]
> After a virtual machine is created, you cannot change its generation.

## <a name="BKMK_APP"></a>Generation 2 virtual machine features

### PXE boot by using a standard network adapter
In previous versions of Hyper\-V, if you wanted to perform a remote installation of the guest operating system by using PXE boot, you were required to install a legacy network adapter. Legacy network adapters are not available in generation 2 virtual machines. Generation 2 virtual machines support PXE boot by using a standard network adapter.

### Boot from SCSI controller
In previous versions of Hyper\-V, you could not boot a virtual machine from a SCSI\-attached virtual hard disk or from a DVD.

Generation 2 virtual machines can boot from a virtual hard disk or DVD that is attached to the SCSI controller. The virtual Integrated Device Electronics \(IDE\) controller is not available in generation 2 virtual machines.

### Secure Boot
Secure Boot is a feature that helps prevent unauthorized firmware, operating systems, or UEFI drivers \(also known as option ROMs\) from running at boot time.

> [!NOTE]
> Secure Boot is enabled by default for generation 2 virtual machines. This can be modified after you create the virtual machine. For more information, see [Secure Boot](assetId:///fa233171-694e-484f-95fe-1dea0ab2a310).

## Device support comparison
Following is a device comparison between generation 1 and generation 2 virtual machines.

|Generation 1 Device|Generation 2 Replacement|Generation 2 Enhancements|
|-----------------------|----------------------------|-----------------------------|
|IDE controller|Virtual SCSI controller|Boot from .vhdx \(64 TB maximum size, and online resize capability\)|
|IDE CD\-ROM|Virtual SCSI CD\-ROM|Support for up to 64 SCSI DVD devices per SCSI controller.|
|Legacy BIOS|UEFI firmware|Secure Boot|
|Legacy network adapter|Synthetic network adapter|Network boot with IPv4 and IPv6|
|Floppy controller and DMA controller|No floppy controller support||
|Universal asynchronous receiver\/transmitter \(UART\) for COM ports|Optional UART for debugging|Faster and more reliable|
|i8042 keyboard controller|Software\-based input|Uses fewer resources because there is no emulation. Also reduces the attack surface from the guest operating system.|
|PS\/2 keyboard|Software\-based keyboard|Uses fewer resources because there is no emulation. Also reduces the attack surface from the guest operating system.|
|PS\/2 mouse|Software\-based mouse|Uses fewer resources because there is no emulation. Also reduces the attack surface from the guest operating system.|
|S3 video|Software\-based video|Uses fewer resources because there is no emulation. Also reduces the attack surface from the guest operating system.|
|PCI bus|No longer required||
|Programmable interrupt controller \(PIC\)|No longer required||
|Programmable interval timer \(PIT\)|No longer required||
|Super I\/O device|No longer required||

## Generation 2 FAQ
The following are some frequently asked questions regarding generation 2 virtual machines.

### Can I run generation 1 and generation 2 virtual machines together?
Yes. This is expected because generation 2 does not support all of the Hyper\-V\-supported guest operating systems. Guest operating systems that are not supported by generation 2 virtual machines need to be installed in a generation 1 virtual machine.

### Is there a performance gain to generation 2 virtual machines?
In the daily running of a virtual machine, there is no performance difference between generation 1 and generation 2 virtual machines. You might see a slight improvement in virtual machine boot and installation times with generation 2 virtual machines.

### What are the benefits of using a generation 2 virtual machine?
Following are the benefits of using a generation 2 virtual machine:

-   Can boot the virtual machine from a SCSI device or a standard network adapter.

-   Helps prevent unauthorized firmware, operating systems, or UEFI drivers from running at boot time when Secure Boot is enabled.

### How can I enable kernel debugging by using a COM port on a generation 2 virtual machine?
By default, COM ports are not visible in generation 2 virtual machines. You can configure COM ports by using Windows PowerShell or Windows Management Instrumentation \(WMI\).

To enable kernel debugging by using a COM port, follow these steps:

1.  Disable Secure Boot. Kernel debugging is not compatible with Secure Boot, so Secure Boot must be disabled in the virtual machine. Use the **Set\-VMFirmware** Windows PowerShell cmdlet  to disable Secure Boot when the virtual machine is in an Off state. For example, the following command will disable Secure Boot on virtual machine TestVM:

    ```
    Set-VMFirmware –Vmname TestVM –EnableSecureBoot Off
    ```

2.  Configure a COM port. Use the **Set\-VMComPort** Windows PowerShell cmdlet to add a COM port to the virtual machine. For example, the following command will configure the first COM port on virtual machine, TestVM, to connect to the named pipe, TestPipe, on the local computer:

    ```
    Set-VMComPort –VMName TestVM 1 \\.\pipe\TestPipe
    ```

> [!NOTE]
> Configured COM ports are not visible when looking at the settings of a virtual machine in the Hyper\-V Manager console.

### Is RemoteFX supported by generation 2 virtual machines?
No. RemoteFX is not supported by generation 2 virtual machines.

### Can I attach a physical CD or DVD drive to a generation 2 virtual machine?
No. The virtual DVD drive in generation 2 virtual machines only supports ISO image files.   To create an ISO image file of a Windows environment, you can use the Oscdimg  command line tool. For more information, see [Oscdimg Command\-Line Options](http://msdn.microsoft.com/library/hh824847.aspx).

### Can I attach a virtual hard disk in VHD format to a generation 2 virtual machine?
No. Generation 2 virtual machines only support VHDX format virtual hard drives. You can convert VHD files to VHDX format using the **Edit Virtual Hard Disk Wizard** in the Hyper\-V Manager console or use the **Convert\-VHD** Windows PowerShell cmdlet.

### Can a VHDX file that was converted from a VHD file be used to boot a generation 2 virtual machine?
No. A clean installation of the operating system is required.

### Can I resize a VHDX file that contains the boot volume for a generation 2 virtual machine while the virtual machine is running?
Yes.

### What is the maximum size of a VHDX file that is supported by a generation 2 virtual machine?
64 TB

### Can I create a VHDX file that can be used to boot both generation 1 and generation 2 virtual machines?
Although this is technically possible, it is possible that unexpected errors can occur. Therefore, a VHDX file that is bootable to both generation 1 and generation 2 virtual machines is not supported or recommended.

### Can I mount a VHDX file that is used by a generation 2 virtual machine?
Yes. A VHDX file is a container for a disk, and as such, it can be mounted regardless of the virtual machine generation.

### Can I tell whether a VHDX file was created by a generation 1 or a generation 2 virtual machine?
No. The virtual machine generation is a property of the virtual machine, not a property of the virtual hard disk.

### Can a generation 2 VHDX file be attached to a generation 1 virtual machine?
Yes. The VHDX file can be attached to the IDE controller or the SCSI controller of a generation 1 virtual machine. However, if this is a bootable VHDX file, the generation 1 virtual machine will not boot.

### Can I import a generation 2 virtual machine to Hyper\-V in Windows Server 2012?
No. Generation 2 virtual machine is a new feature in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)].

### Is Secure Boot or UEFI firmware required on the physical host?
No. The virtual firmware and its configuration are independent of the physical platform.

### Does the UEFI firmware in a generation 2 virtual machine support setup mode for Secure Boot?
No.

### Can I run a UEFI shell or other UEFI application in a generation 2 virtual machine?
Microsoft does not provide or support a UEFI shell or other UEFI applications. Using a non\-Microsoft UEFI shell or UEFI applications is technically possible if they are compiled directly from the sources. If these applications are not appropriately digitally signed, you will be required to disable Secure Boot for the virtual machine.

### Where are the boot entries for generation 2 virtual machines stored?
The boot entries for a generation 2 virtual machine are stored in the configuration file for the virtual machine.

### What is the default generation of a new virtual machine?
By default, generation 1 virtual machines are created by using the **New Virtual Machine Wizard** or the **New\-VM** Windows PowerShell cmdlet . In the **New Virtual Machine Wizard**, you can select **Generation 2** on the **Specify Generation** page. In Windows PowerShell, you can use the **–Generation** parameter to specify the generation of a virtual machine.

### Can I change the generation of a virtual machine after it has been created?
No.

### Why are 64\-bit versions of Windows Server 2008 R2 and Windows 7 not supported as generation 2 guest operating systems?
Although [!INCLUDE[nextref_server_7](includes/nextref_server_7_md.md)] and [!INCLUDE[nextref_client_7](includes/nextref_client_7_md.md)] support UEFI, they depend on a programmable interrupt controller \(PIC\), which is not present in generation 2 virtual machine hardware.

### Why are 32\-bit versions of [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)] and [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] not supported as guest operation systems for generation 2 virtual machines?
Generation 2 virtual machines are not supported on 32\-bit guest operating systems because the 64\-bit\-only UEFI firmware does not have a compatibility support module.

### Can I use Generation 2 for Linux virtual machines?
For information about Linux distributions that support Generation 2 virtual machines, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows](Supported-Linux-and-FreeBSD-virtual-machines-for-Hyper-V-on-Windows.md).

> [!WARNING]
> Secure boot is enabled by default in Generation 2 virtual machines and Linux virtual machines will not boot unless the secure boot option is disabled.

You can disable secure boot in the **Firmware** section of the settings for the virtual machine in Hyper\-V Manager or you can disable it using Powershell:

```
Set-VMFirmware -VMName "VMname" -EnableSecureBoot Off

```

### What is the maximum number of network adapters that can be supported by a generation 2 virtual machine?
Eight. In addition, generation 2 virtual machines do not support legacy network adapters.

### What is the maximum number of storage devices, VHDX files or DVD drives, that can be supported by generation 2 virtual machines?
256. Generation 2 virtual machines support up to four SCSI controllers, with each controller supporting 64 devices. Generation 2 virtual machines can have more than four DVD drives.

### When I create a new virtual machine with the New\-VM Windows PowerShell cmdlet, why does the generation 2 virtual machine not have a DVD drive?
On a generation 2 virtual machine, you can add a DVD drive while the virtual machine is running.

### Does a generation 2 virtual machine support iSCSI or Fibre Channel boot?
No.

### Can I perform a network installation that uses IPv6?
Yes. By default, generation 2 virtual machines use IPv4. You can set a virtual machine to use IPv6 instead of IPv4 by using the **Set\-VMFirmware** Windows PowerShell cmdlet. For example, the following command will set the preferred protocol to IPv6 for a virtual machine named TestVM:

```
Set-VMFirmware –VMName TestVM –IPProtocolPreference IPv6
```

### Can I use a virtual floppy disk \(.vfd\) as an answer file for an unattended installation of a generation 2 virtual machine?
No. Generation 2 virtual machines do not support virtual floppy drives. As an alternate, use an ISO image file in a DVD drive.


