---
title: Deploy graphics devices using RemoteFX vGPU
description: Learn how to deploy and configure RemoteFX vGPU in Windows Server
ms.prod: windows-server-threshold
ms.reviewer: rickman
author: rick-man
ms.author: rickman
manager: stevelee
ms.topic: article
ms.date: 08/21/2019
---

# Deploy graphics devices using RemoteFX vGPU

>Applies To: Windows Server 2016, Microsoft Hyper-V Server 2016

The vGPU feature of RemoteFX makes it possible for multiple virtual machines to share a physical GPU. Rendering and compute resources are shared dynamically among virtual machines, making RemoteFX vGPU appropriate for high-burst workloads where dedicated GPU resources are not required. For example, in a VDI service, RemoteFX vGPU can be used to offload app rendering costs to the GPU, with the effect of decreasing CPU load and improving service scalability.

## RemoteFX vGPU requirements

Host system requirements:

- Windows Server 2016
- DirectX 11.0 compatible GPU with WDDM 1.2 compatible driver
- CPU with SLAT (Second Level Address Translation) support

Guest VM requirements:

- Supported guest OS. See [Support for GPU Acceleration with Hyper-V](../../../remote/remote-desktop-services/rds-supported-config.md#support-for-gpu-acceleration-with-hyper-v).

Additional considerations for guest VMs:

- OpenGL and OpenCL functionality is only available in guests running Windows 10 or Windows Server 2016.  
- DirectX 11.0 is only available in guests running Windows 8 or newer.

## Enable RemoteFX vGPU

Use the following steps to configure RemoteFX vGPU on your Windows Server 2016 host:

1. Install the graphics drivers recommended by your GPU vendor for Windows Server 2016.
2. Create a VM running a guest OS supported by RemoteFX vGPU. See [Support for GPU Acceleration with Hyper-V](../../../remote/remote-desktop-services/rds-supported-config.md#support-for-gpu-acceleration-with-hyper-v).
3. Add the RemoteFX 3D graphics adapter to the VM. See [Configure the RemoteFX vGPU 3D adapter](#configure-the-remotefx-vgpu-3d-adapter) below.

By default, RemoteFX vGPU will use all available and supported GPUs. Use the following steps to limit which GPUs are used by RemoteFX vGPU:

1. Navigate to the Hyper-V settings in Hyper-V Manager.
2. Click **Physical GPUs** in Hyper-V Settings.
3. Select the GPU that you don't want to use, and then clear **Use this GPU with RemoteFX**.

### Configure the RemoteFX vGPU 3D adapter

You can use either the Hyper-V Manager UI or PowerShell cmdlets to configure the RemoteFX vGPU 3D graphics adapter.

#### Configure RemoteFX vGPU with Hyper-V Manager

1. Stop the VM, if it is running.
2. In Hyper-V Manager, navigate to **VM Settings**, and then click **Add Hardware**.
3. Select **RemoteFX 3D Graphics Adapter**, and click **Add**.
4. Set the maximum number of monitors, maximum monitor resolution, and dedicated video memory, or leave the default values.

   > [!NOTE]
   > - Setting higher values for any of these options will impact your service scale, so you should only set what is necessary.
   >
   > - When you need to use 1GB of dedicated VRAM, use a 64-bit guest VM instead of 32-bit (x86) for best results.

5. Click **OK** to finish the configuration.

#### Configure RemoteFX vGPU with PowerShell cmdlets

Run the following cmdlets to add, review, and configure the adapter:

```powershell
Add-VMRemoteFx3dVideoAdapter [-CimSession <CimSession[]>] [-ComputerName <String[]>] [-Credential <PSCredential[]>] [-VMName] <String[]> [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

For details see [Add-VMRemoteFx3dVideoAdapter](https://technet.microsoft.com/itpro/powershell/windows/hyper-v/add-vmremotefx3dvideoadapter).

```powershell
Get-VMRemoteFx3dVideoAdapter [-CimSession <CimSession[]>] [-ComputerName <String[]>]  [-Credential <PSCredential[]>] [-VMName] <String[]> [<CommonParameters>]
```

For details see [Get-VMRemoteFx3dVideoAdapter](https://technet.microsoft.com/itpro/powershell/windows/hyper-v/get-vmremotefx3dvideoadapter)

```powershell
Set-VMRemoteFx3dVideoAdapter [-CimSession <CimSession[]>] [-ComputerName <String[]>] [-Credential <PSCredential[]>] [-VMName] <String[]> [[-MonitorCount] <Byte>] [[-MaximumResolution] <String>] [[-VRAMSizeBytes] <UInt64>] [-Passthru] [-WhatIf] [-Confirm] [<CommonParameters>]
```

For details see [Set-VMRemoteFx3dVideoAdapter](https://technet.microsoft.com/itpro/powershell/windows/hyper-v/set-vmremotefx3dvideoadapter).

Run the following cmdlet to review the physical GPUs:

```powershell
Get-VMRemoteFXPhysicalVideoAdapter [-ComputerName <String[]>] [-Credential <PSCredential[]>] [[-Name] <String[]>] [<CommonParameters>]  
```

For details see [Get-VMRemoteFXPhysicalVideoAdapter](https://technet.microsoft.com/itpro/powershell/windows/hyper-v/get-vmremotefxphysicalvideoadapter).

## Monitor performance

The performance and scale of a RemoteFX vGPU-enabled service are determined by a variety of factors such as total GPU memory, amount of system memory and memory speed, number of CPU cores and CPU clock frequency, storage speed, and NUMA implementation. For detailed information about performance counters you can use to monitor RemoteFX vGPU behavior, refer to the following articles:

- [Performance Tuning Remote Desktop Virtualization Hosts](../../../administration/performance-tuning/role/remote-desktop/virtualization-hosts.md)
- [Diagnose graphics performance issues in Remote Desktop](https://docs.microsoft.com/en-us/azure/virtual-desktop/remotefx-graphics-performance-counters)
