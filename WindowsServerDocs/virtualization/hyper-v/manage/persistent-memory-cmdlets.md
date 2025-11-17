---
title: Cmdlets for configuring persistent memory devices for Hyper-V VMs
description: How to configure persistent memory devices for Hyper-V VMs
ms.topic: how-to
ms.author: roharwoo
author: robinharwood
ms.date: 12/08/2020
---

# Cmdlets for configuring persistent memory devices for Hyper-V VMs

This article provides system administrators and IT Pros with information about configuring Hyper-V VMs with persistent memory (aka storage class memory or NVDIMM). JDEC-compliant NVDIMM-N persistent memory devices are supported in Windows Server 2016 and Windows 10 and provide byte-level access to very low latency non-volatile devices. VM persistent memory devices are supported in Windows Server 2019.

## Create a persistent memory device for a VM

Use the **[New-VHD](/powershell/module/hyper-v/new-vhd)** cmdlet to create a persistent memory device for a VM. The device must be created on an existing NTFS DAX volume.  The new filename extension (.vhdpmem) is used to specify that the device is a persistent memory device. Only the fixed VHD file format is supported.

**Example:** `New-VHD d:\VMPMEMDevice1.vhdpmem -Fixed -SizeBytes 4GB`

## Create a VM with a persistent memory controller

Use the **New-VM cmdlet** to create a Generation 2 VM with specified memory size and path to a VHDX image. Then, use **Add-VMPmemController** to add a persistent memory controller to a VM.

**Example:**

```powershell
New-VM -Name "ProductionVM1" -MemoryStartupBytes 1GB -VHDPath c:\vhd\BaseImage.vhdx

Add-VMPmemController ProductionVM1x
```

## Attach a persistent memory device to a VM

Use **[Add-VMHardDiskDrive](/powershell/module/hyper-v/add-vmharddiskdrive)** to attach a persistent memory device to a VM

**Example:** `Add-VMHardDiskDrive ProductionVM1 PMEM -ControllerLocation 1 -Path D:\VPMEMDevice1.vhdpmem`

Persistent memory devices within a Hyper-V VM appear as a persistent memory device to be consumed and managed by the guest operating system. Guest operating systems can use the device as a block or DAX volume. When persistent memory devices within a VM are used as a DAX volume, they benefit from low latency byte-level address-ability of the host device (no I/O virtualization on the code path).

>[!NOTE]
>Persistent memory is only supported for Hyper-V Gen2 VMs. Live Migration and Storage Migration are not supported for VMs with persistent memory. Production checkpoints of VMs do not include persistent memory state.


