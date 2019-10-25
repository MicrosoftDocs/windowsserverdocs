---
title: Deploy graphics devices using Discrete Device Assignment
description: Learn how to use DDA to deploy graphics devices in Windows Server
ms.prod: windows-server
ms.service: na
ms.technology: hyper-v
ms.tgt_pltfrm: na
ms.topic: article
author: chrishuybregts
ms.author: chrihu
ms.assetid: 67a01889-fa36-4bc6-841d-363d76df6a66
ms.date: 08/21/2019
---
# Deploy graphics devices using Discrete Device Assignment

> Applies to: Microsoft Hyper-V Server 2016, Windows Server 2016, Windows Server 2019, Microsoft Hyper-V Server 2019  

Starting with Windows Server 2016, you can use Discrete Device Assignment, or DDA, to pass an entire PCIe Device into a VM.  This will allow high performance access to devices like [NVMe storage](./Deploying-storage-devices-using-dda.md) or Graphics Cards from within a VM while being able to leverage the devices native drivers.  Please visit the [Plan for Deploying Devices using Discrete Device Assignment](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md) for more details on which devices work, what are the possible security implications, etc.

There are three steps to using a device with Discrete Device Assignment:
-	Configure the VM for Discrete Device Assignment
-	Dismount the Device from the Host Partition
-	Assigning the Device to the Guest VM

All command can be executed on the Host on a Windows PowerShell console as an Administrator.

## Configure the VM for DDA
Discrete Device Assignment imposes some restrictions to the VMs and the following step needs to be taken.

1.	Configure the “Automatic Stop Action” of a VM to TurnOff by executing

```
Set-VM -Name VMName -AutomaticStopAction TurnOff
```

### Some Additional VM preparation is required for Graphics Devices

Some hardware performs better if the VM in configured in a certain way.  For details on whether or not you need the following configurations for your hardware, please reach out to the hardware vendor. Additional details can be found on [Plan for Deploying Devices using Discrete Device Assignment](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md) and on this [blog post.](https://techcommunity.microsoft.com/t5/Virtualization/Discrete-Device-Assignment-GPUs/ba-p/382266)

1. Enable Write-Combining on the CPU
   ```
   Set-VM -GuestControlledCacheTypes $true -VMName VMName
   ```
2. Configure the 32 bit MMIO space
   ```
   Set-VM -LowMemoryMappedIoSpace 3Gb -VMName VMName
   ```
3. Configure greater than 32 bit MMIO space
   ```
   Set-VM -HighMemoryMappedIoSpace 33280Mb -VMName VMName
   ```
   > [!TIP] 
   > The MMIO space values above are reasonable values to set for experimenting with a single GPU.  If after starting the VM, the device is reporting an error relating to not enough resources, you'll likely need to modify these values. Consult [Plan for Deploying Devices using Discrete Device Assignment](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md) to learn how to precisely calculate MMIO requirements.

## Dismount the Device from the Host Partition
### Optional - Install the Partitioning Driver
Discrete Device Assignment provide hardware venders the ability to provide a security mitigation driver with their devices.  Note that this driver is not the same as the device driver that will be installed in the guest VM.  It's up to the hardware vendor's discretion to provide this driver, however, if they do provide it, please install it prior to dismounting the device from the host partition.  Please reach out to the hardware vendor for more information on if they have a mitigation driver
> If no Partitioning driver is provided, during dismount you must use the `-force` option to bypass the security warning. Please read more about the security implications of doing this on [Plan for Deploying Devices using Discrete Device Assignment](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md).

### Locating the Device's Location Path
The PCI Location path is required to dismount and mount the device from the Host.  An example location path looks like the following: `"PCIROOT(20)#PCI(0300)#PCI(0000)#PCI(0800)#PCI(0000)"`.  More details on located the Location Path can be found here: [Plan for Deploying Devices using Discrete Device Assignment](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md).

### Disable the Device
Using Device Manager or PowerShell, ensure the device is “disabled.”  

### Dismount the Device
Depending on if the vendor provided a mitigation driver, you'll either need to use the “-force” option or not.
- If a Mitigation Driver was installed
  ```
  Dismount-VMHostAssignableDevice -LocationPath $locationPath
  ```
- If a Mitigation Driver was not installed
  ```
  Dismount-VMHostAssignableDevice -force -LocationPath $locationPath
  ```

## Assigning the Device to the Guest VM
The final step is to tell Hyper-V that a VM should have access to the device.  In addition to the location path found above, you'll need to know the name of the vm.

```
Add-VMAssignableDevice -LocationPath $locationPath -VMName VMName
```

## What's Next
After a device is successfully mounted in a VM, you're now able to start that VM and interact with the device as you normally would if you were running on a bare metal system.  This means that you're now able to install the Hardware Vendor's drivers in the VM and applications will be able to see that hardware present.  You can verify this by opening device manager in the Guest VM and seeing that the hardware now shows up.

## Removing a Device and Returning it to the Host
If you want to return he device back to its original state, you will need to stop the VM and issue the following:
```
#Remove the device from the VM
Remove-VMAssignableDevice -LocationPath $locationPath -VMName VMName
#Mount the device back in the host
Mount-VMHostAssignableDevice -LocationPath $locationPath
```
You can then re-enable the device in device manager and the host operating system will be able to interact with the device again.

## Example

### Mounting a GPU to a VM
In this example we use PowerShell to configure a VM named “ddatest1” to take the first GPU available by the manufacturer NVIDIA and assign it into the VM.  
```
#Configure the VM for a Discrete Device Assignment
$vm = 	"ddatest1"
#Set automatic stop action to TurnOff
Set-VM -Name $vm -AutomaticStopAction TurnOff
#Enable Write-Combining on the CPU
Set-VM -GuestControlledCacheTypes $true -VMName $vm
#Configure 32 bit MMIO space
Set-VM -LowMemoryMappedIoSpace 3Gb -VMName $vm
#Configure Greater than 32 bit MMIO space
Set-VM -HighMemoryMappedIoSpace 33280Mb -VMName $vm

#Find the Location Path and disable the Device
#Enumerate all PNP Devices on the system
$pnpdevs = Get-PnpDevice -presentOnly
#Select only those devices that are Display devices manufactured by NVIDIA
$gpudevs = $pnpdevs |where-object {$_.Class -like "Display" -and $_.Manufacturer -like "NVIDIA"}
#Select the location path of the first device that's available to be dismounted by the host.
$locationPath = ($gpudevs | Get-PnpDeviceProperty DEVPKEY_Device_LocationPaths).data[0]
#Disable the PNP Device
Disable-PnpDevice  -InstanceId $gpudevs[0].InstanceId

#Dismount the Device from the Host
Dismount-VMHostAssignableDevice -force -LocationPath $locationPath

#Assign the device to the guest VM.
Add-VMAssignableDevice -LocationPath $locationPath -VMName $vm
```

## Troubleshooting

If you've passed a GPU into a VM but Remote Desktop or an application isn't recognizing the GPU, check for the following common issues:

- Make sure you've installed the most recent version of the GPU vendor's supported driver and that the driver isn't reporting errors by checking the device state in Device Manager.
- Make sure your device has enough MMIO space allocated within the VM. To learn more, see [MMIO Space](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md#mmio-space).
- Make sure you're using a GPU that the vendor supports being used in this configuration. For example, some vendors prevent their consumer cards from working when passed through to a VM.
- Make sure the application being run supports running inside a VM, and that both the GPU and its associated drivers are supported by the application. Some applications have allow-lists of GPUs and environments.
- If you're using the Remote Desktop Session Host role or Windows Multipoint Services on the guest, you will need to make sure that a specific Group Policy entry is set to allow use of the default GPU. Using a Group Policy Object applied to the guest (or the Local Group Policy Editor on the guest), navigate to the following Group Policy item: **Computer Configuration** > **Administrator Templates** > **Windows Components** > **Remote Desktop Services** > **Remote Desktop Session Host** > **Remote Session Environment** > **Use the hardware default graphics adapter for all Remote Desktop Services sessions**. Set this value to Enabled, then reboot the VM once the policy has been applied.
