---
title: Deploy NVMe Storage Devices using Discrete Device Assignment
description: Learn how to use DDA to deploy storage devices
ms.prod: windows-server
ms.service: na
ms.technology: hyper-v
ms.tgt_pltfrm: na
ms.topic: article
author: chrishuybregts
ms.author: chrihu
ms.assetid: 1c36107e-78c9-4ec0-a313-6ed557ac0ffc
---
# Deploy NVMe Storage Devices using Discrete Device Assignment

>Applies To: Microsoft Hyper-V Server 2016, Windows Server 2016

Starting with Windows Server 2016, you can use Discrete Device Assignment, or DDA, to pass an entire PCIe Device into a VM.  This will allow high performance access to devices like NVMe storage or Graphics Cards from within a VM while being able to leverage the devices native drivers.  Please visit the [Plan for Deploying Devices using Discrete Device Assignment](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md) for more details on which devices work, what are the possible security implications, etc.
There are three steps to using a device with DDA:
-	Configure the VM for DDA
-	Dismount the Device from the Host Partition
-	Assigning the Device to the Guest VM

All command can be executed on the Host on a Windows PowerShell console as an Administrator.

## Configure the VM for DDA
Discrete Device Assignment imposes some restrictions to the VMs and the following step needs to be taken.

1.	Configure the “Automatic Stop Action” of a VM to TurnOff by executing

```
Set-VM -Name VMName -AutomaticStopAction TurnOff
```

## Dismount the Device from the Host Partition

### Locating the Device's Location Path
The PCI Location path is required to dismount and mount the device from the Host.  An example location path looks like the following: `"PCIROOT(20)#PCI(0300)#PCI(0000)#PCI(0800)#PCI(0000)"`.   More details on located the Location Path can be found here: [Plan for Deploying Devices using Discrete Device Assignment](../plan/Plan-for-Deploying-Devices-using-Discrete-Device-Assignment.md).

### Disable the Device
Using Device Manager or PowerShell, ensure the device is “disabled.”  

### Dismount the Device
```
Dismount-VMHostAssignableDevice -LocationPath $locationPath
```

## Assigning the Device to the Guest VM
The final step is to tell Hyper-V that a VM should have access to the device.  In addition to the location path found above, you'll need to know the name of the vm.

```
Add-VMAssignableDevice -LocationPath $locationPath -VMName VMName
```

## What's Next
After a device is successfully mounted in a VM, you're now able to start that VM and interact with the device as you normally would if you were running on a bare metal system.  You can verify this by opening device manager in the Guest VM and seeing that the hardware now shows up.

## Removing a Device and Returning it to the Host
If you want to return he device back to its original state, you will need to stop the VM and issue the following:
```
#Remove the device from the VM
Remove-VMAssignableDevice -LocationPath $locationPath -VMName VMName
#Mount the device back in the host
Mount-VMHostAssignableDevice -LocationPath $locationPath
```
You can then re-enable the device in device manager and the host operating system will be able to interact with the device again.
