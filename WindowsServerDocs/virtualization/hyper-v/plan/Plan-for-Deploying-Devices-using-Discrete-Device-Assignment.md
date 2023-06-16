---
title: Plan for deploying devices by using Discrete Device Assignment
description: Learn how Discrete Device Assignment allows physical PCIe hardware to be directly accessible from within a virtual machine.
ms.topic: article
ms.author: wscontent
author: robinharwood
ms.date: 06/08/2023
---

# Plan for deploying devices by using Discrete Device Assignment

> Applies to: Windows Server 2022, Microsoft Hyper-V Server 2019, Windows Server 2019, Microsoft Hyper-V Server 2016, Windows Server 2016

Discrete Device Assignment allows physical Peripheral Component Interconnect Express (PCIe) hardware to be directly accessible from within a virtual machine (VM). This article discusses the type of devices that can be used, host system requirements, limitations imposed on the VMs, and security implications.

For Discrete Device Assignment, Microsoft supports two device classes: Graphics Adapters and NVMe Storage devices. Other devices are likely to work, and hardware vendors are able to offer statements of support for those devices. For other devices, contact specific hardware vendors for support.

To learn about other methods of GPU virtualization, see [Plan for GPU acceleration in Windows Server](plan-for-gpu-acceleration-in-windows-server.md). If you're ready to try Discrete Device Assignment, you can go to [Deploy graphics devices using Discrete Device Assignment](../deploy/Deploying-graphics-devices-using-dda.md) or [Deploy NVMe Storage Devices using Discrete Device Assignment](../deploy/Deploying-storage-devices-using-dda.md).

## Supported VMs and guest operating systems

Discrete Device Assignment is supported for Generation 1 or 2 VMs. The guests supported include:

- Windows 10 or later
- Windows Server 2016 or later
- Windows Server 2012 R2 with the [Update to add Discrete Device Assignment support for Azure](https://support.microsoft.com/kb/3133690).

For more information, see [Supported Linux and FreeBSD virtual machines for Hyper-V on Windows Server and Windows](../supported-linux-and-freebsd-virtual-machines-for-hyper-v-on-windows.md).

## System requirements

Your system must meet the [Hardware Requirements for Windows Server](../../../get-started/hardware-requirements.md) and [System Requirements for Hyper-V on Windows Server](../System-requirements-for-Hyper-V-on-Windows.md). Discrete Device Assignment also requires server class hardware that's capable of granting the operating system control over configuring the PCIe fabric (Native PCI Express Control). In addition, the PCIe Root Complex has to support Access Control Services (ACS), which enables Hyper-V to force all PCIe traffic through the Input-Output Memory Management Unit.

These capabilities usually aren't exposed directly in the BIOS of the server and are often hidden behind other settings. If the same capabilities are required for SR-IOV support and in the BIOS, you might need to set "Enable SR-IOV." Reach out to your system vendor if you're unable to identify the correct setting in your BIOS.

To help ensure the hardware is capable of Discrete Device Assignment, you can run the [machine profile script](#machine-profile-script) on a Hyper-V enabled host. The script tests if your server is correctly set up and what devices are capable of Discrete Device Assignment.

## Device requirements

Not every PCIe device can be used with Discrete Device Assignment. Older devices that use legacy (INTx) PCI Interrupts aren't supported. For more information, see [Discrete Device Assignment - Machines and devices](https://techcommunity.microsoft.com/t5/virtualization/discrete-device-assignment-machines-and-devices/ba-p/382260). You can also run the [Machine Profile Script](#machine-profile-script) to display which devices are capable of being used for Discrete Device Assignment.

Device manufacturers can reach out to their Microsoft representative for more details.

## Device driver

Discrete Device Assignment passes the entire PCIe device into the Guest VM. A host driver isn't required to be installed prior to the device being mounted within the VM. The only requirement on the host is that the device's [PCIe Location Path](#pcie-location-path) can be determined. The device's driver can be installed to help in identifying the device. A GPU without its device driver installed on the host might appear as a Microsoft Basic Render Device. If the device driver is installed, its manufacturer and model is likely to be displayed.

When the device is mounted inside the guest, the Manufacturer's device driver can be installed like normal inside the guest VM.

## VM limitations

Due to the nature of how Discrete Device Assignment is implemented, some features of a VM are restricted while a device is attached. The following features aren't available:

- VM Save/Restore
- Live migration of a VM
- The use of dynamic memory
- Adding the VM to a high availability (HA) cluster

## Security

Discrete Device Assignment passes the entire device into the VM. This pass means all capabilities of that device are accessible from the guest operating system. Some capabilities, like firmware updating, might adversely affect the stability of the system. Numerous warnings are presented to the admin when dismounting the device from the host. You should only use Discrete Device Assignment where the tenants of the VMs are trusted.

If the admin desires to use a device with an untrusted tenant, device manufactures can create a Device Mitigation driver that can be installed on the host. Contact the device manufacturer for details on whether they provide a Device Mitigation Driver.

If you would like to bypass the security checks for a device that doesn't have a Device Mitigation Driver, you have to pass the `-Force` parameter to the `Dismount-VMHostAssignableDevice` cmdlet. When you make this pass, you have changed the security profile of that system. You should only make this change during prototyping or trusted environments.

## PCIe location path

The PCIe location path is required to dismount and mount the device from the Host. An example location path is `PCIROOT(20)#PCI(0300)#PCI(0000)#PCI(0800)#PCI(0000)`. The [Machine Profile Script](#machine-profile-script) also returns the location path of the PCIe device.

### Get the location path by using Device Manager

:::image type="content" source="../deploy/media/dda-devicemanager.png" alt-text="Screenshot of the device manager, showing the selections for finding a device path." border="false":::

1. Open Device Manager and locate the device.
1. Right-click the device and select **Properties**.
1. On the **Details** tab, expand the **Property** drop-down menu and select **Location Paths**.
1. Right-click the entry that begins with **PCIROOT** and select **Copy** to get the location path for the device.

## MMIO space

Some devices, especially GPUs, require more MMIO space to be allocated to the VM for the memory of that device to be accessible. By default, each VM starts off with 128 MB of low MMIO space and 512 MB of high MMIO space allocated to it. However, a device might require more MMIO space, or multiple devices might be passed through such that the combined requirements exceed these values. Changing MMIO Space is straightforward and can be performed in PowerShell by using the following commands:

```powershell
Set-VM -LowMemoryMappedIoSpace 3Gb -VMName $vm
Set-VM -HighMemoryMappedIoSpace 33280Mb -VMName $vm
```

The easiest way to determine how much MMIO space to allocate is to use the [Machine Profile Script](#machine-profile-script). To download and run the Machine Profile Script, run the following commands in a PowerShell console:

```powershell
curl -o SurveyDDA.ps1 https://raw.githubusercontent.com/MicrosoftDocs/Virtualization-Documentation/live/hyperv-tools/DiscreteDeviceAssignment/SurveyDDA.ps1
.\SurveyDDA.ps1
```

For devices that can be assigned, the script displays the MMIO requirements of a given device. The following script output is an example:

```powershell
NVIDIA GRID K520
Express Endpoint -- more secure.
    ...
    And it requires at least: 176 MB of MMIO gap space
...
```

The low MMIO space is used only by 32-bit operating systems and devices that use 32-bit addresses. In most circumstances, setting the high MMIO space of a VM is enough since 32-bit configurations aren't common.

> [!IMPORTANT]
> When you assign MMIO space to a VM, be sure to specify sufficient MMIO space. The MMIO space should be the sum of the requested MMIO space for all desired assigned devices plus a buffer for other virtual devices that require a few MB of MMIO space. Use the default MMIO values previously described as the buffer for low and high MMIO (128 MB and 512 MB, respectively).

Consider the previous example. If you assign a single K520 GPU, set the MMIO space of the VM to the value outputted by the machine profile script plus a buffer: 176 MB + 512 MB. If you assign three K520 GPUs, set the MMIO space to three times the base amount of 176 MB plus a buffer, or 528 MB + 512 MB.

For a more in-depth look at MMIO space, see [Discrete Device Assignment - GPUs](https://techcommunity.microsoft.com/t5/Virtualization/Discrete-Device-Assignment-GPUs/ba-p/382266) on the Tech Community blog.

## Machine profile script

To identify if the server is configured correctly, and what devices can be passed through by using Discrete Device Assignment, run the [SurveyDDA.ps1.](https://github.com/Microsoft/Virtualization-Documentation/blob/live/hyperv-tools/DiscreteDeviceAssignment/SurveyDDA.ps1) PowerShell script.

Before you use the script, ensure you have the Hyper-V role installed and you run the script from a PowerShell command window that has Administrator privileges.

If the system is incorrectly configured to support Discrete Device Assignment, the tool displays an error message with details about the issue. If the system is correctly configured, the tool enumerates all devices located on the PCIe Bus.

For each device it finds, the tool displays whether it's able to be used with Discrete Device Assignment. If a device is identified as being compatible with Discrete Device Assignment, the script provides a reason. When a device is successfully identified as being compatible, the device's Location Path is displayed. Additionally, if that device requires [MMIO space](#mmio-space), it's displayed as well.

:::image type="content" source="./images/hyper-v-surveydda-ps1.png" alt-text="Screenshot of the requirements displayed in SurveyDDA.ps1.":::
