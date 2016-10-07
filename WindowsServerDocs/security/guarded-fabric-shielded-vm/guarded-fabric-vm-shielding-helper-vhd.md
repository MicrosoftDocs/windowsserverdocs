---
title: Shielded VMs - hosting service provider prepares a VM Shielding Helper VHD
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 0e3414cf-98ca-4e91-9e8d-0d7bce56033b
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
---

# Shielded VMs - hosting service provider prepares a VM Shielding Helper VHD

>Applies To: Windows Server 2016

>**Important**&nbsp;&nbsp;You cannot convert existing non-shielded VMs to Shielded VMs. There is no workaround at this time. If you need to deploy Shielded VMs, create new ones directly from shielded templates. For more information, see [Deploy shielded VMs](https://technet.microsoft.com/system-center-docs/vmm/scenario/guarded-overview). 

This section outlines steps performed by a hosting service provider to enable support for converting existing VMs to shielded VMs.

For information about other configuration options for shielded VMs, see [Configuration scenarios for shielded VMs in a guarded fabric](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md).

## Prepare Helper VHD

<!--In the Important below, change "the template disks you signed and protected with the template disk wizard" to something like "the template disks you created in <LINK-GOES-HERE-TO-SUBSECTION-IN-VMM-SECTION>." -->

1.  On a machine with Hyper-V and the Remote Server Administration Tools feature “Shielded VM Tools” installed, create a new generation 2 VM with a blank VHDX and install Windows Server 2016 on it using the Windows Server ISO installation media. This VM should not be shielded and cannot use the Nano server installation option (it must be Server Core or Server with Desktop Experience).

    >**Important**&nbsp;&nbsp;The VM Shielding Helper VHD **must not** be related to the template disks you signed and protected with the template disk wizard. If you re-use a template disk, there will be a disk signature collision during the shielding process because both disks will have the same GPT disk identifier. You can avoid this by creating a new (blank) VHD and installing Windows Server 2016 onto it using your ISO installation media.

2.  Start the VM, complete any setup steps, and log into the desktop. Once you have verified the VM is in a working state, shut down the VM.

3.  In an elevated Windows PowerShell window, run the following command to prepare the VHDX created earlier to become a VM shielding helper disk. Update the path with the correct path for your environment.

        Initialize-VMShieldingHelperVHD -Path 'C:\VHD\shieldingHelper.vhdx'

4.  Once the command has completed successfully, copy the VHDX to your VMM library share. **Do not** start up the VM from step 1 again. Doing so will corrupt the helper disk.

5.  You can now delete the VM from step 1 in Hyper-V.

## Configure VMM Host Guardian Server Settings

In the VMM Console, open the settings pane and then **Host Guardian Service Settings** under **General**. At the bottom of this window, there is a field to configure the location of your helper VHD. Use the browse button to select the VHD from your library share. If you do not see your disk in the share, you may need to manually refresh the library in VMM for it to show up.

![VMM - Host Guardian Service Settings](media/Guarded-Fabric-Shielded-VM/guarded-host-vmm-hgs-settings-01.png)

## See also

[Configuration scenarios for shielded VMs in a guarded fabric](guarded-fabric-configuration-scenarios-for-shielded-vms-overview.md)
