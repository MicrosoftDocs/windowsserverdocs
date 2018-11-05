---
title: Cmdlets for configuring persistent memory devices for Hyper-V VMs
description: "How to configure persistent memory devices for Hyper-V VMs"
ms.prod: windows-server-threshold
ms.service: na
manager: jasgroce
ms.technology: compute-hyper-v
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b5715c02-a90f-4de9-a71e-0fc08039ba1d
author: coreyp-at-msft
ms.author: coreyp
---

# Cmdlets for configuring persistent memory devices for Hyper-V VMs

>Applies To: Windows Server 2019

This article provides system administrators and IT Pros with information about configuring Hyper-V VMs with persistent memory (aka storage class memory or NVDIMM). JDEC-compliant NVDIMM-N persistent memory devices are supported in Windows Server 2016 and Windows 10 and provide byte-level access to very low latency non-volatile devices. VM persistent memory devices are supported in Windows Server 2019. 

## Create a persistent memory device for a VM

Use the **[New-VHD](https://docs.microsoft.com/powershell/module/hyper-v/new-vhd?view=win10-ps)** cmdlet to create a persistent memory device for a VM. The device must be created on an existing NTFS DAX volume.  The new filename extension (.vhdpmem) is used to specify that the device is a persistent memory device. Only the fixed VHD file format is supported.

**Example:** `New-VHD d:\VMPMEMDevice1.vhdpmem -Fixed -SizeBytes 4GB`

## Create a VM with a persistent memory controller



Use the **New-VM cmdlet** to create a Generation 2 VM with specified memory size and path to a VHDX image. Then, use **Add-VMPmemController** to add a persistent memory controller to a VM.

**Example:** 
    
    New-VM -Name "ProductionVM1" -MemoryStartupBytes 1GB -VHDPath c:\vhd\BaseImage.vhdx

    Add-VMPmemController ProductionVM1x

## Attach a persistent memory device to a VM

Use **[Add-VMHardDiskDrive](https://docs.microsoft.com/powershell/module/hyper-v/add-vmharddiskdrive?view=win10-ps)** to attach a persistent memory device to a VM

**Example:** `Add-VMHardDiskDrive ProductionVM1 PMEM -ControllerLocation 1 -Path D:\VPMEMDevice1.vhdpmem`

Persistent memory devices within a Hyper-V VM appear as a persistent memory device to be consumed and managed by the guest operating system. Guest operating systems can use the device as a block or DAX volume. When persistent memory devices within a VM are used as a DAX volume, they benefit from low latency byte-level address-ability of the host device (no I/O virtualization on the code path). 

>[!NOTE] 
>Persistent memory is only supported for Hyper-V Gen2 VMs. Live Migration and Storage Migration are not supported for VMs with persistent memory. Production checkpoints of VMs do not include persistent memory state. 