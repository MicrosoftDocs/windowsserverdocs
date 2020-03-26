---
title: Deploy graphics devices using RemoteFX vGPU
description: Learn how to deploy and configure RemoteFX vGPU in Windows Server
ms.prod: windows-server
ms.reviewer: rickman
author: rick-man
ms.author: rickman
manager: stevelee
ms.topic: article
ms.date: 08/21/2019
---

# Deploy graphics devices using RemoteFX vGPU

> Applies to: Windows Server 2016, Microsoft Hyper-V Server 2016

The vGPU feature for RemoteFX makes it possible for multiple virtual machines to share a physical GPU. Rendering and compute resources are shared dynamically among virtual machines, making RemoteFX vGPU appropriate for high-burst workloads where dedicated GPU resources are not required. For example, in a VDI service, RemoteFX vGPU can be used to offload app rendering costs to the GPU, with the effect of decreasing CPU load and improving service scalability.

## RemoteFX vGPU requirements

Host system requirements:

- Windows Server 2016
- A DirectX 11.0-compatible GPU with a WDDM 1.2-compatible driver
- A CPU with Second Level Address Translation (SLAT) support

Guest VM requirements:

- Supported guest OS. For more information, see [RemoteFX 3D Video Adapter (vGPU) support](../../../remote/remote-desktop-services/rds-supported-config.md#remotefx-3d-video-adapter-vgpu-support).

Additional considerations for guest VMs:

- OpenGL and OpenCL functionality is only available in guests running Windows 10 or Windows Server 2016.  
- DirectX 11.0 is only available for guests running Windows 8 or later.

## Enable RemoteFX vGPU

To configure RemoteFX vGPU on your Windows Server 2016 host:

1. Install the graphics drivers recommended by your GPU vendor for Windows Server 2016.
2. Create a VM running a guest OS supported by RemoteFX vGPU. To learn more, see [RemoteFX 3D Video Adapter (vGPU) support](../../../remote/remote-desktop-services/rds-supported-config.md#remotefx-3d-video-adapter-vgpu-support).
3. Add the RemoteFX 3D graphics adapter to the VM. To learn more, see [Configure the RemoteFX vGPU 3D adapter](#configure-the-remotefx-vgpu-3d-adapter).

By default, RemoteFX vGPU will use all available and supported GPUs. To limit which GPUs the RemoteFX vGPU uses, follow these steps:

1. Navigate to the Hyper-V settings in Hyper-V Manager.
2. Select **Physical GPUs** in Hyper-V Settings.
3. Select the GPU that you don't want to use, and then clear **Use this GPU with RemoteFX**.

### Configure the RemoteFX vGPU 3D adapter

You can use either the Hyper-V Manager UI or PowerShell cmdlets to configure the RemoteFX vGPU 3D graphics adapter.

#### Configure RemoteFX vGPU with Hyper-V Manager

1. Stop the VM if it's currently running.
2. Open Hyper-V Manager, navigate to **VM Settings**, then select **Add Hardware**.
3. Select **RemoteFX 3D Graphics Adapter**, then select **Add**.
4. Set the maximum number of monitors, maximum monitor resolution, and dedicated video memory, or leave the default values.

   > [!NOTE]
   > - Setting higher values for any of these options will impact your service scale, so you should only set what is necessary.
   > - When you need to use 1 GB of dedicated VRAM, use a 64-bit guest VM instead of 32-bit (x86) for best results.

5. Select **OK** to finish the configuration.

#### Configure RemoteFX vGPU with PowerShell cmdlets

Use the following PowerShell cmdlets to add, review, and configure the adapter:

- [Add-VMRemoteFx3dVideoAdapter](https://docs.microsoft.com/powershell/module/hyper-v/add-vmremotefx3dvideoadapter?view=win10-ps)
- [Get-VMRemoteFx3dVideoAdapter](https://docs.microsoft.com/powershell/module/hyper-v/get-vmremotefx3dvideoadapter?view=win10-ps)
- [Set-VMRemoteFx3dVideoAdapter](https://docs.microsoft.com/powershell/module/hyper-v/set-vmremotefx3dvideoadapter?view=win10-ps)
- [Get-VMRemoteFXPhysicalVideoAdapter](https://docs.microsoft.com/powershell/module/hyper-v/get-vmremotefxphysicalvideoadapter?view=win10-ps)

## Monitor performance

The performance and scale of a RemoteFX vGPU-enabled service are determined by a variety of factors such as number of GPUs on your system, total GPU memory, amount of system memory and memory speed, number of CPU cores and CPU clock frequency, storage speed, and NUMA implementation.

### Host system memory

For every VM enabled with a vGPU, RemoteFX uses system memory both in the guest operating system and in the host server. The hypervisor guarantees the availability of system memory for a guest operating system. On the host, each vGPU-enabled virtual desktop needs to advertise its system memory requirement to the hypervisor. When the vGPU-enabled virtual desktop starts, the hypervisor reserves additional system memory in the host.

The memory requirement for the RemoteFX-enabled server is dynamic because the amount of memory consumed on the RemoteFX-enabled server is dependent on the number of monitors that are associated with the vGPU-enabled virtual desktops and the maximum resolution for those monitors.

### Host GPU video memory

Every vGPU-enabled virtual desktop uses the GPU hardware video memory on the host server to render the desktop. In addition, a codec uses the video memory to compress the rendered screen. The amount of memory needed for rendering and compression is directly based on the number of monitors provisioned to the virtual machine. The amount of reserved video memory varies based on the system screen resolution and how many monitors there are. Some users require a higher screen resolution for specific tasks, but there's greater scalability with lower resolution settings if all other settings remain constant.

### Host CPU

The hypervisor schedules the host and VMs on the CPU. The overhead is increased on a RemoteFX-enabled host because the system runs an additional process (rdvgm.exe) per vGPU-enabled virtual desktop. This process uses the graphics device driver to run commands on the GPU. The codec also uses the CPU to compress screen data that needs to be sent back to the client.

More virtual processors mean a better user experience. We recommend allocating at least two virtual CPUs per vGPU-enabled virtual desktop. We also recommend using the x64 architecture for vGPU-enabled virtual desktops because the performance on x64 virtual machines is better compared to x86 virtual machines.

### GPU processing power

Every vGPU-enabled virtual desktop has a corresponding DirectX process that runs on the host server. This process replays all graphics commands it receives from the RemoteFX virtual desktop onto the physical GPU. This is like running multiple DirectX applications at the same time on the same physical GPU.

Usually, graphics devices and drivers are tuned to run only a few applications on the desktop at a time, but RemoteFX stretches the GPUs to go even further. vGPUs come with performance counters that measure the GPU response to RemoteFX requests and help you make sure the GPUs aren't stretched too far.

When a GPU is low on resources, read and write operations take a long time to complete. Administrators can use performance counters to know when to adjust resources and prevent downtime for users.

Learn more about performance counters for monitoring RemoteFX vGPU behavior at [Diagnose graphics performance issues in Remote Desktop](https://docs.microsoft.com/azure/virtual-desktop/remotefx-graphics-performance-counters).
