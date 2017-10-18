---
redirect_url: /windows-server/windows-server
title: Using soft reboot in Windows Server
description: Learn about the new soft reboot option in Windows Server
ms.prod: windows-server-threshold
ms.technology: server-general
ms.mktglfcycl: manage
ms.sitesec: library
author: lizap
ms.localizationpriority: low
ms.date: 10/16/2017
---

# Using soft reboot in Windows Server

> Applies To: Windows Server (Semi-Annual Channel)

Soft reboot is a way to fully reinitialize (or "reboot") the operating system without going through firmware platform initialization (POST). Bypassing POST can significantly reduce overall downtime for many server-class systems.

Here's how soft reboot works:

1. While user processes are still running, the OS prepares to restart. During this stage, in the context of the currently running kernel, the new kernel is loaded in memory.
2. The host OS shuts down, but instead of handing control to the firmware, the OS hands control to a new driver, winload.sys.
3. The current kernel hands over a few parameters to winload.sys.
4. Winload.sys jumps to the new kernel, which initializes drivers and sets up the OS, just like it would in a normal start-up cycle.

## Initiate soft reboot

You can use the ksrcmd.exe utility to put your system through a soft reboot. The basic flow of steps are as follows:

1. krscmd /surface (\<BcdEntryGuid\>)
2. ksrcmd /prepare (\<BcdEntryGuid\>) Initiateonly
3. ksrcmd /completeprepare
4. ksrcmd /reboot

\<BcdEntryGuid\> is one of the entry IDs for the BCD store on the target system. You can use friendly names (like {default} or {current}) similar to the **bcdedit** command. For example, to use the current OS image, you'd run **ksrcmd /suface {current}**.

You only need to do step 1 in the above example when the targed BCD entry is a VHD boot type. 

You can cancel the reboot between steps 2 and 3 by running the following command:

```
ksrcmd /cancel
```

To see the current status, run the following command:

```
ksrcmd /getstatus
```

The last step invokes the soft reboot. You don't need to run any other shutdown command. Until step 3, the OS is fully up and running - any user processes continue to run. User process downtime starts when you run **ksrcmd /reboot**.

## Enable soft reboot

Soft reboot is available as an optional feature in all editions of Windows Server, starting with Windows Server, version 1709. You can use the DISM command line utility to install or uninstall this feature.

To see if soft reboot is available on the server you're currently working on, run the following command:

```
dism /online /get-capabilities
```

If the feature is available, you'll see the following line in the output:

```
Capability identity: Kernel.Soft.Reboot~~~~0.0.1.0
```

To enable the feature, run the following:

```
dism /online /add-capability /capability-name:Kernel.Soft.Reboot~~~~0.0.1.0
```

To remove it:
```
dism /online /remove-capability /capability-name:Kernel.Soft.Reboot~~~~0.0.1.0
```

## Additional considerations for soft reboot

Be aware of the following considerations when you are using soft reboot:

- The only display driver that is compatible with soft reboot is the Microsoft Basic Display adapter.
- A side effect of avoiding POST is that a soft reboot doesn't benefit from UEFI Secure & Measured Boot. However, if you have enabled Windows Defender Device Guard, VTL1 will perform code integrity checks for the OS. Note that as of version 1709, DMA protection is not continuous but will be reestablished after reinitialization.