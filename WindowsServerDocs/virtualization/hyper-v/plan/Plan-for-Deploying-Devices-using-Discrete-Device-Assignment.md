---
title: Plan for deploying devices using Discrete Device Assignment
description: Learn about how DDA works in Windows Server
ms.prod: windows-server-threshold
ms.service: na
ms.technology: hyper-v
ms.tgt_pltfrm: na
ms.topic: article
author: chrishuybregts
ms.author: chrihu
ms.date: 02/06/2018
---
# Plan for Deploying Devices using Discrete Device Assignment
>Applies To: Microsoft Hyper-V Server 2016, Windows Server 2016, Microsoft Hyper-V Server 2019, Windows Server 2019

Discrete Device Assignment allows physical PCIe hardware to be directly accessible from within a virtual machine.  This guide will discuss the type of devices that can use Discrete Device Assignment, host system requirements, limitations imposed on the virtual machines as well as security implications of Discrete Device Assignment.

For Discrete Device Assignment's initial release, we have focused on two device classes to be formally supported by Microsoft: Graphics Adapters and NVMe Storage devices.  Other devices are likely to work and hardware vendors are able to offer statements of support for those devices.  For these other devices, please reach out to those hardware vendors for support.

If you are ready to try out Discrete Device Assignment, you can jump over to [Deploying Graphics Devices Using Discrete Device Assignment](../deploy/Deploying-graphics-devices-using-dda.md) or [Deploying Storage Devices using Discrete Device Assignment](../deploy/Deploying-storage-devices-using-dda.md) to get started!

## Supported Virtual Machines and Guest Operating Systems
Discrete Device Assignment is supported for Generation 1 or 2 VMs.  Additionally, the guests supported include Windows 10, Windows Server 2019, Windows Server 2016, Windows Server 2012r2 with [KB 3133690](https://support.microsoft.com/kb/3133690) applied, and various distributions of the [Linux OS.](../supported-linux-and-freebsd-virtual-machines-for-hyper-v-on-windows.md)

## System Requirements
In addition to the [System Requirements for Windows Server](../../../get-started/System-Requirements--and-Installation.md) and the [System Requirements for Hyper-V](../System-requirements-for-Hyper-V-on-Windows.md), Discrete Device Assignment requires server class hardware that is capable of granting the operating system control over configuring the PCIe fabric (Native PCI Express Control). In addition, the PCIe Root Complex has to support "Access Control Services" (ACS), which enables Hyper-V to force all PCIe traffic through the I/O MMU.

These capabilities usually aren't exposed directly in the BIOS of the server and are often hidden behind other settings.  For example, the same capabilities are required for SR-IOV support and in the BIOS you may need to set "Enable SR-IOV."  Please reach out to your system vendor if you are unable to identify the correct setting in your BIOS.

To help ensure hardware the hardware is capable of Discrete Device Assignment, our engineers have put together a [Machine Profile Script](#machine-profile-script) that you can run on an Hyper-V enabled host to test if your server is correctly setup and what devices are capable of Discrete Device Assignment.

## Device Requirements
Not every PCIe device can be used with Discrete Device Assignment.  For example, older devices that leverage legacy (INTx) PCI Interrupts are not supported. Jake Oshin's [blog posts](https://blogs.technet.microsoft.com/virtualization/2015/11/20/discrete-device-assignment-machines-and-devices/) go into more detail - however, for the consumer, running the [Machine Profile Script](#machine-profile-script) will display which devices are capable of being used for Discrete Device Assignment.

Device manufactures can reach out to their Microsoft representative for more details.

## Device Driver
As Discrete Device Assignment passes the entire PCIe device into the Guest VM, a host driver is not required to be installed prior to the device being mounted within the VM.  The only requirement on the host is that the device's [PCIe Location Path](#pcie-location-path) can be determined.  The device's driver can optionally be installed if this helps in identifying the device.  For example, a GPU without its device driver installed on the host may appear as a Microsoft Basic Render Device.  If the device driver is installed, its manufacturer and model will likely be displayed.

Once the device is mounted inside the guest, the Manufacturer's device driver can now be installed like normal inside the guest virtual machine.  

## Virtual Machine Limitations
Due to the nature of how Discrete Device Assignment is implemented, some features of a virtual machine are restricted while a device is attached.  The following features are not available:
- VM Save/Restore
- Live migration of a VM
- The use of dynamic memory
- Adding the VM to a high availability (HA) cluster

## Security
Discrete Device Assignment passes the entire device into the VM.  This means all capabilities of that device are accessible from the guest operating system. Some capabilities, like firmware updating, may adversely impact the stability of the system. As such, numerous warnings are presented to the admin when dismounting the device from the host. We highly recommend that Discrete Device Assignment is only used where the tenants of the VMs are trusted.  

If the admin desires to use a device with an untrusted tenant, we have provided device manufactures with the ability to create a Device Mitigation driver that can be installed on the host.  Please contact the device manufacturer for details on whether they provide a Device Mitigation Driver.

If you would like to bypass the security checks for a device that does not have a Device Mitigation Driver, you will have to pass the `-Force` parameter to the `Dismount-VMHostAssignableDevice` cmdlet.  Understand that by doing so, you have changed the security profile of that system and this is only recommended during prototyping or trusted environments.

## PCIe Location Path
The PCIe Location path is required to dismount and mount the device from the Host.  An example location path looks like the following: `"PCIROOT(20)#PCI(0300)#PCI(0000)#PCI(0800)#PCI(0000)"`.   The [Machine Profile Script](#machine-profile-script) will also return the Location Path of the PCIe device.

### Getting the Location Path by Using Device Manager
![Device Manager](../deploy/media/dda-devicemanager.png)
- Open Device Manager and locate the device.  
- Right click the device and select “Properties.”
- Navigate to the Details tab and select “Location Paths” in the Property drop down.  
- Right click the entry that begins with “PCIROOT” and select "Copy."  You now have the location path for that device.

## MMIO Space
Some devices, especially GPUs, require additional MMIO space to be allocated to the VM for the memory of that device to be accessible. By default, each VM starts off with 128MB of low MMIO space and 512MB of high MMIO space allocated to it. However, a device might require more MMIO space, or multiple devices may be passed through such that the combined requirements exceed these values.  Changing MMIO Space is straight forward and can be performed in PowerShell using the following commands:

```PowerShell
Set-VM -LowMemoryMappedIoSpace 3Gb -VMName $vm
Set-VM -HighMemoryMappedIoSpace 33280Mb -VMName $vm
```

The easiest way to determine how much MMIO space to allocate is to use the [Machine Profile Script](#machine-profile-script). To download and run the machine profile script, run the following commands in a PowerShell console:

```PowerShell
curl -o SurveyDDA.ps1 https://raw.githubusercontent.com/MicrosoftDocs/Virtualization-Documentation/live/hyperv-tools/DiscreteDeviceAssignment/SurveyDDA.ps1
.\SurveyDDA.ps1
```

For devices that are able to be assigned, the script will display the MMIO requirements of a given device like the example below:

```PowerShell
NVIDIA GRID K520
Express Endpoint -- more secure.
    ...
    And it requires at least: 176 MB of MMIO gap space
...
```

The low MMIO space is used only by 32-bit operating systems and devices that use 32-bit addresses. In most circumstances, setting the high MMIO space of a VM will be enough since 32-bit configurations aren't very common.

> [!IMPORTANT]
> When assigning MMIO space to a VM, the user needs to be sure set the MMIO space to the sum of the requested MMIO space for all desired assigned devices plus an additional buffer if there are other virtual devices that require a few MB of MMIO space. Use the default MMIO values described above as the buffer for low and high MMIO (128 MB and 512 MB, respectively).

If a user were to assign a single K520 GPU as in the example above, they must set the MMIO space of the VM to the value outputted by the machine profile script plus a buffer--176 MB + 512 MB. If a user were to assign three K520 GPUs, they must set the MMIO space to three times 176 MB plus a buffer, or 528 MB + 512 MB.

For a more in-depth look at MMIO space, see [Discrete Device Assignment - GPUs](https://techcommunity.microsoft.com/t5/Virtualization/Discrete-Device-Assignment-GPUs/ba-p/382266) on the TechCommunity blog.

## Machine Profile Script
In order to simplify identifying if the server is configured correctly and what devices are available to be passed through using Discrete Device Assignment, one of our engineers put together the following PowerShell script: [SurveyDDA.ps1.](https://github.com/Microsoft/Virtualization-Documentation/blob/live/hyperv-tools/DiscreteDeviceAssignment/SurveyDDA.ps1)

Before using the script, please ensure you have the Hyper-V role installed and you run the script from a PowerShell command window that has Administrator privileges.

If the system is incorrectly configured to support Discrete Device Assignment, the tool will display an error message as to what is wrong. If the tool finds the system configured correctly, it will enumerate all the devices it can find on the PCIe Bus.

For each device it finds, the tool will display whether it is able to be used with Discrete Device Assignment. If a device is identified as being compatible with Discrete Device Assignment, the script will provide a reason.  When a device is successfully identified as being compatible, the device's Location Path will be displayed.  Additionally, if that device requires [MMIO space](#mmio-space), it will be displayed as well.

![SurveyDDA.ps1](./images/hyper-v-surveydda-ps1.png)

## Frequently Asked Questions

### How does Remote Desktop's RemoteFX vGPU technology relate to Discrete Device Assignment?
They are completely separate technologies. RemoteFX vGPU does not need to be installed for Discrete Device Assignment to work. Additionally, no additional roles are required to be installed. RemoteFX vGPU requires the RDVH role to be installed in order for the RemoteFX vGPU driver to be present in the VM. For Discrete Device Assignment, since you will be installing the Hardware Vendor's driver into the virtual machine, no additional roles need to be present.  

### I've passed a GPU into a VM but Remote Desktop or an application isn't recognizing the GPU
There are a number of reasons this could happen, but several common issues are listed below.
- Ensure the latest GPU vendor's driver is installed and is not reporting an error by checking the device state in the Device Manager.
- Ensure that device has enough [MMIO space](#mmio-space) allocated for it within the VM.
- Ensure you're using a GPU that the vendor supports being used in this configuration. For example, some vendors prevent their consumer cards from working when passed through to a VM.
- Ensure the application being run supports running inside a VM, and that both the GPU and its associated drivers are supported by the application. Some applications have whitelists of GPUs and environments.
- If you're using the Remote Desktop Session Host role or Windows Multipoint Services on the guest, you will need to ensure that a specific Group Policy entry is set to allow use of the default GPU. Using a Group Policy Object applied to the guest (or the Local Group Policy Editor on the guest), navigate to the following Group Policy item:
   - Computer Configuration
   - Administrator Templates
   - Windows Components
   - Remote Desktop Services
   - Remote Desktop Session Host
   - Remote Session Environment
   - Use the hardware default graphics adapter for all Remote Desktop Services sessions

    Set this value to Enabled, then reboot the VM once the policy has been applied.

### Can Discrete Device Assignment take advantage of Remote Desktop's AVC444 codec?
Yes, visit this blog post for more information: [Remote Desktop Protocol (RDP) 10 AVC/H.264 improvements in Windows 10 and Windows Server 2016 Technical Preview.](https://blogs.technet.microsoft.com/enterprisemobility/2016/01/11/remote-desktop-protocol-rdp-10-avch-264-improvements-in-windows-10-and-windows-server-2016-technical-preview/)

### Can I use PowerShell to get the Location Path?
Yes, there are various ways to do this. Here is one example:
```
#Enumerate all PNP Devices on the system
$pnpdevs = Get-PnpDevice -presentOnly
#Select only those devices that are Display devices manufactured by NVIDIA
$gpudevs = $pnpdevs |where-object {$_.Class -like "Display" -and $_.Manufacturer -like "NVIDIA"}
#Select the location path of the first device that's available to be dismounted by the host.
$locationPath = ($gpudevs | Get-PnpDeviceProperty DEVPKEY_Device_LocationPaths).data[0]
```

### Can Discrete Device Assignment be used to pass a USB device into a VM?
Although not officially supported, our customers have used Discrete Device Assignment to do this by passing the entire USB3 controller into a VM.  As the whole controller is being passed in, each USB device plugged into that controller will also be accessible in the VM.  Note that only some USB3 controllers may work, and USB2 controllers cannot be used with Discrete Device Assignment.
