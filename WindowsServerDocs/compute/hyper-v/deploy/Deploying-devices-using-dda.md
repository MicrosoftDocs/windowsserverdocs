---
title: Deploy Devices using Discrete Device Assignment
description: " "
ms.prod: windows-server-threshold
ms.service: na
ms.technology: 
  - hyper-v
  - techgroup-compute
ms.tgt_pltfrm: na
ms.topic: article
author: chrishuybregts
---
# Deploy Devices using Discrete Device Assignment

>Applies To: Windows Server Technical Preview

**This is preliminary content and subject to change.**

Starting with Windows Server 2016, you can use Discrete Device Assignment, or DDA, to pass an entire PCIe Device into a VM.  This will allow high performance access to devices like NVMe storage or Graphics Cards from within a VM while being able to leverage the devices native drivers.  Please visit the <link to plan section> for more details on which devices work, what are the possible security implications, etc.
There are three steps to using a device with DDA:
-	Configure the VM for DDA
-	Dismount the Device from the Host Partition
-	Assigning the Device to the Guest VM

All command can be executed on the Host on a Windows PowerShell console as an Administrator.

## Configure the VM for DDA
Discrete Device Assignment imposes some restrictions to the VMs.

### Common to All Devices
1.	Configure the “Automatic Stop Action” of a VM to TurnOff by executing

```
Set-VM -Name VMName -AutomaticStopAction TurnOff
```


### For Some Devices including GPUs

Some hardware performs better if the VM in configured in a certain way.  For details on whether or not you need the following configurations for your hardware, please reach out to the hardware vendor. Additional details can be found on this [blog post.](https://blogs.technet.microsoft.com/virtualization/2015/11/23/discrete-device-assignment-gpus/)

1.	Enable Write-Combining on the CPU
```
Set-VM -GuestControlledCacheTypes $true -VMName VMName
```
2.	Configure the 32 bit MMIO space
```
Set-VM -LowMemoryMappedIoSpace 3Gb -VMName VMName
```
3.	Configure greater than 32 bit MMIO space
```
Set-VM -HighMemoryMappedIoSpace 33280Mb -VMName VMName
```

## Dismount the Device from the Host Partition
### Install the Partitioning Driver
Install the Vender provide Mitigation Driver
DDA provide hardware venders the ability to provide a security mitigation driver with their devices.  Note that this driver is not the same as the device driver that will be installed in the guest VM.  It’s up to the hardware vendor’s discretion to provide this driver, however, if they do provide it, please install it prior to dismounting the device from the host partition.  Please reach out to the hardware vendor for more information on if they have a mitigation driver
> If no Partitioning driver is provided, during dismount you must use the `-force` option to bypass the security warning.

### Locating the Device’s Location Path
The PCI Location path is required to dismount and mount the device from the Host.  An example location path looks like the following: `"PCIROOT(20)#PCI(0300)#PCI(0000)#PCI(0800)#PCI(0000)"`.   

#### Using Device Manager
![Device Manager](./media/dda-devicemanager.png)
- Open Device Manager and locate the device.  
- Right click and select “Properties.” 
- Navigate to the Details tab and select “Location Paths” in the Property drop down.  
- Right click the entry that begins with “PCIROOT” and select "Copy."  You now have the location path for that device.
Using PowerShell

#### Using PowerShell
Alternatively, you can use PowerShell to get to the location path.
```
#Enumerate all PNP Devices on the system
$pnpdevs = Get-PnpDevice -presentOnly
#Select only those devices that are Display devices manufactured by NVIDIA
$gpudevs = $pnpdevs |where-object {$_.Class -like "Display" -and $_.Manufacturer -like "NVIDIA"}
#Select the location path of the first device that's available to be dismounted by the host.
$locationPath = ($gpudevs | Get-PnpDeviceProperty DEVPKEY_Device_LocationPaths).data[0] 
```

### Disable the Device
Using Device Manager or PowerShell, ensure the device is “disabled.”  In device manager, right click the device and select “Disable.”  In PowerShell you can call `Disable-PnpDevice`.

### Dismount the Device
Depending on if the vendor provided a mitigation driver, you’ll either need to use the “-force” option or not.
- 	If a Mitigation Driver was installed
```
Dismount-VMHostAssignableDevice -LocationPath $locationPath
``` 
- 	If a Mitigation Driver was not installed
```
Dismount-VMHostAssignableDevice -force -LocationPath $locationPath
``` 

## Assigning the Device to the Guest VM
The final step is to tell Hyper-V that a VM should have access to the device.  In addition to the location path found above, you'll need to know the name of the vm.

```
Add-VMAssignableDevice -LocationPath $locationPath -VMName VMName
```

## What’s Next
After a device is successfully mounted in a VM, you’re now able to start that VM and interact with the device as you normally would if you were running on a bare metal system.  This means that you’re now able to install the Hardware Vendor’s drivers in the VM and applications will be able to see that hardware present.  You can verify this by opening device manager in the Guest VM and seeing that the hardware now shows up.

## Removing a Device and Returning it to the Host
If you want to return he device back to its original state, you will need to stop the VM and issue the following:
```
#Remove the device from the VM
Remove-VMAssignableDevice -LocationPath $locationPath -VMName VMName
#Mount the device back in the host
Mount-VMHostAssignableDevice -LocationPath $locationPath 
```
You can then re-enable the device in device manager and the host operating system will be able to interact with the device again.

## Examples

### Mounting a GPU to a VM
In this example we use PowerShell to configure a VM named “ddatest1” to take the first GPU available by the manufacturer NVIDIA and assign it into the VM.  
```
#Configure the VM for a DDA
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

