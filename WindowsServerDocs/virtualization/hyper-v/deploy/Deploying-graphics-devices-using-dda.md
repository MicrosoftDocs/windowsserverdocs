---
title: Deploy graphics devices by using Discrete Device Assignment
description: Learn how to use DDA to deploy graphics devices in Windows Server and how to mount a GPU to a virtual machine.
ms.topic: article
ms.author: wscontent
author: BenjaminArmstrong
ms.assetid: 67a01889-fa36-4bc6-841d-363d76df6a66
ms.date: 06/08/2023
---
# Deploy graphics devices by using Discrete Device Assignment

> Applies to: Windows Server 2022, Windows Server 2019, Microsoft Hyper-V Server 2019, Windows Server 2016, Microsoft Hyper-V Server 2016

Starting with Windows Server 2016, you can use Discrete Device Assignment (DDA) to pass an entire PCIe device into a virtual machine (VM). Doing so allows high performance access to devices like [NVMe storage](./Deploying-storage-devices-using-dda.md) or graphics cards from within a VM while being able to apply the device's native drivers. For more information on devices that work and possible security implications, see [Plan for Deploying Devices using Discrete Device Assignment](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md).

> [!IMPORTANT]
> Though not required, if [Single Root I/O Virtualization (SR-IOV)](/windows-hardware/drivers/network/overview-of-single-root-i-o-virtualization--sr-iov-) isn't enabled or supported, you might encounter issues when you use DDA to deploy graphics devices.

There are three steps to using a device with DDA:

1. [Configure the VM for DDA](#configure-the-vm-for-dda)
1. [Dismount the device from the host partition](#dismount-the-device-from-the-host-partition)
1. [Assign the device to the guest VM](#assign-the-device-to-the-guest-vm)

You can execute all commands on the host on a Windows PowerShell console as an administrator.

## Configure the VM for DDA

The first step in the solution is to address DDA restrictions to the VMs. Configure the `Automatic Stop Action` of a VM to enable **TurnOff** with the following PowerShell cmdlet:

```powershell
Set-VM -Name VMName -AutomaticStopAction TurnOff
```

### VM preparation for graphics devices

Some hardware performs better if the VM in configured in a certain way. For details on whether you need the following configurations for your hardware, reach out to the hardware vendor. For more information, see [Plan for Deploying Devices using Discrete Device Assignment](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md) and on this [blog post](https://techcommunity.microsoft.com/t5/Virtualization/Discrete-Device-Assignment-GPUs/ba-p/382266).

1. Enable Write-Combining on the CPU by using the following cmdlet:

   ```powershell
   Set-VM -GuestControlledCacheTypes $true -VMName VMName
   ```

1. Configure the 32-bit MMIO space by using the following cmdlet:

   ```powershell
   Set-VM -LowMemoryMappedIoSpace 3Gb -VMName VMName
   ```

1. Configure greater than 32-bit MMIO space by using the following cmdlet:

   ```powershell
   Set-VM -HighMemoryMappedIoSpace 33280Mb -VMName VMName
   ```

   > [!TIP]
   > The MMIO space values shown are reasonable values to set for experimenting with a single GPU. If after starting the VM the device is reporting an error relating to not enough resources, you'll likely need to modify these values. For more information about how to precisely calculate MMIO requirements, see [Plan for Deploying Devices using Discrete Device Assignment](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md).

## Dismount the device from the host partition

Follow the instructions in this section to dismount the device from the host partition.

### Install the partitioning driver (optional)

DDA gives hardware vendors the ability to provide a security mitigation driver with their devices. This driver isn't the same as the device driver installed in the guest VM. It's up to the hardware vendor's discretion to provide this driver. But if they do provide a driver, install it prior to dismounting the device from the host partition. Reach out to the hardware vendor to see if they have a mitigation driver.

If no partitioning driver is provided, during dismount you must use the `-Force` option to bypass the security warning. For more information about the security implications, see [Plan for Deploying Devices using Discrete Device Assignment](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md).

### Locate the device's location path

The PCI location path is required to dismount and mount the device from the host. An example location path looks like this: `PCIROOT(20)#PCI(0300)#PCI(0000)#PCI(0800)#PCI(0000)`. For more information about locating the location path, see [Plan for Deploying Devices using Discrete Device Assignment](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md).

### Disable the device

Use Device Manager or PowerShell to ensure the device is **Disabled**.

### Dismount the device

Depending on whether the vendor provided a mitigation driver, you must either use the `-Force` option or not, as shown here:

- If a mitigation driver was installed, use the following cmdlet:

  ```powershell
  Dismount-VMHostAssignableDevice -LocationPath $locationPath
  ```

- If a mitigation driver wasn't installed, use the following cmdlet:

  ```powershell
  Dismount-VMHostAssignableDevice -Force -LocationPath $locationPath
  ```

## Assign the device to the guest VM

The final step is to tell Hyper-V that a VM should have access to the device. Specify the location path and the name of the VM.

```powershell
Add-VMAssignableDevice -LocationPath $locationPath -VMName VMName
```

## Complete tasks on the VM

After a device is successfully mounted in a VM, you're now able to start that VM and interact with the device as though you were running on a bare metal system. You're now able to install the hardware vendor's drivers in the VM, and applications are able to see the hardware. You can verify it by opening Device Manager in the guest VM and seeing that the hardware is available.

## Remove a device and return it to the host

If you want to return the device back to its original state, you must stop the VM and issue this command:

```powershell
# Remove the device from the VM
Remove-VMAssignableDevice -LocationPath $locationPath -VMName VMName
# Mount the device back in the host
Mount-VMHostAssignableDevice -LocationPath $locationPath
```

You can then re-enable the device in Device Manager, and the host operating system is able to interact with the device again.

## Mount a GPU to a VM

This example uses PowerShell to configure a VM named **ddatest1** to take the first GPU available by the manufacturer NVIDIA and assign it into the VM.

```powershell
# Configure the VM for a Discrete Device Assignment
$vm = "ddatest1"
# Set automatic stop action to TurnOff
Set-VM -Name $vm -AutomaticStopAction TurnOff
# Enable Write-Combining on the CPU
Set-VM -GuestControlledCacheTypes $true -VMName $vm
# Configure 32 bit MMIO space
Set-VM -LowMemoryMappedIoSpace 3Gb -VMName $vm
# Configure Greater than 32 bit MMIO space
Set-VM -HighMemoryMappedIoSpace 33280Mb -VMName $vm

# Find the Location Path and disable the Device
# Enumerate all PNP Devices on the system
$pnpdevs = Get-PnpDevice -presentOnly
# Select only those devices that are Display devices manufactured by NVIDIA
$gpudevs = $pnpdevs | Where-Object {$_.Class -like "Display" -and $_.Manufacturer -like "NVIDIA"}
# Select the location path of the first device that's available to be dismounted by the host.
$locationPath = ($gpudevs | Get-PnpDeviceProperty DEVPKEY_Device_LocationPaths).data[0]
# Disable the PNP Device
Disable-PnpDevice -InstanceId $gpudevs[0].InstanceId

# Dismount the Device from the Host
Dismount-VMHostAssignableDevice -Force -LocationPath $locationPath

# Assign the device to the guest VM.
Add-VMAssignableDevice -LocationPath $locationPath -VMName $vm
```

### Troubleshoot issues with mounting a GPU

If you've passed a GPU into a VM but Remote Desktop Services or an application isn't recognizing the GPU, check for the following common issues:

- Make sure you've installed the most recent version of the GPU vendor's supported driver, and that the driver isn't reporting errors. You can do so by checking the device state in Device Manager.
- Make sure your device has enough MMIO space allocated within the VM. For more information, see [MMIO Space](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md#mmio-space).
- Make sure you use a GPU that the vendor supports being used in this configuration. For example, some vendors prevent their consumer cards from working when passed through to a VM.
- Make sure the application supports running inside a VM, and that the application supports both the GPU and its associated drivers. Some applications have allowlists of GPUs and environments.
- If you use the Remote Desktop Session Host role or Windows Multipoint Services on the guest, you must make sure that a specific Group Policy entry is set to allow use of the default GPU. Use a Group Policy Object applied to the guest (or the Local Group Policy Editor on the guest) to navigate to the following Group Policy item:

  **Computer Configuration\Administrator Templates\Windows Components\Remote Desktop Services\Remote Desktop Session Host\Remote Session Environment\Use hardware graphics adapters for all Remote Desktop Services sessions**.

  Set the Group Policy value to **Enabled**, then reboot the VM once the policy has been applied.
