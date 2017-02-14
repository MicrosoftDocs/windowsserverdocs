---
title: RDS - RemoteFX vGPU setup and configuration
description: Planning information to configure RemoteFX vGPU graphics virtualization.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 02/13/2017  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0263fa6b-2185-4cc3-99ef-3588e2f4ada5
author: lizap
manager: scottman
---
# Set up and configure RemoteFX vGPU for Remote Desktop Services

RemoteFX in Windows Server 2012 is a suite of improvements to the Microsoft Remote Display Protocol (RDP). It optimizes the display experience for remote users, even on constraint networks. Additionally, RemoteFX improves access to peripheral devices attached to the client, e.g. via USB. 

The vGPU feature of RemoteFX makes it possible for multiple virtual machines to share a physical graphics adapter. The virtual machines are able to offload rendering of graphic information from the processor to the dedicated graphics adapter. This will decrease the CPU load and improve the scalability for graphic intense workloads that run in the VDI virtual machines. 

## RemoteFX vGPU requirements

- Windows Server 2016 
- DX 11.0 compatible GPU with WDDM 1.2 compatible driver 
- Windows Server RD Virtualization Host role enabled (enables Hyper-V Role) 
- Server with a CPU that supports SLAT (Second Level Address Translation) 
- Guest VM running a Windows Enterprise client (Windows 7 with Service Pack 1, Windows 8.1, Windows 10, or Windows Server 2016)  
   - OpenGL and OpenCL functionality is only available in Windows 10 or Windows Server 2016 Technical Preview o DirectX 11.0 is only available with Windows 8 or newer Guest VM’s 
   - Windows 7 SP1 Guest VM requires latest updates and also does not support OpenGL/OpenCL. 
   - Remote Desktop Session Host is not supported with RemoteFX vGPU

## Install RemoteFX vGPU

Use the following steps to install RemoteFX vGPU support:

1. Install Windows Server 2016. 
2. Install the latest Windows 10/Windows Server 2016 GPU drivers available from the vendor's site 
3. Enable Hyper-V role 
4. Enable Remote Desktop Virtualization Host (RDVH) role 
5. Note: If you have multiple GPU’s configured in your system use “Hyper Setting 
6. Create VM with Windows 10 (Enterprise SKU) or Windows Server 2016 Technical Preview 5. 
7. Add the RemoteFX 3D Graphics Adapter 

## Configure the RemoteFX vGPU 3D adapter
You can use either the Hyper-V Manager UI or PowerShell cmdlets to configure the RemoteFX vGPU 3D graphics adapter. 

### Through Hyper-V Manager:

1. Ensure the system has been set up with Hyper-V and has a VM configured.  
2. Stop the VM, if it is running. 
3. In Hyper-V Manager navigate to the **VM Settings**, and then click **RemoteFX 3D Graphics Adapter**. 
4. Set the maximum number of monitors, maximum monitor resolution, and dedicated video memory. 
   > [!NOTE]
   > Setting higher values for any of these options will have impact to scale, so you should only set what is absolutely necessary. 


### With PowerShell cmdlets:

Run the following cmdlets to review and configure the adapter: 

```powershell
Get-VMRemoteFx3dVideoAdapter [-VM] <VirtualMachine[]>  [<CommonParameters>]  

Set-VMRemoteFx3dVideoAdapter [-VMName] <string[]> [[-MonitorCount] <byte>] [[MaximumResolution] <string> {1024x768 | 1280x1024 | 1600x1200 | 1920x1200 | 2560x1600}] [[VRAMSizeBytes] <uint64> {67108864 | 134217728 | 268435456 | 536870912 | 1073741824}] [Passthru] [-ComputerName <string[]>] [-WhatIf] [-Confirm] [<CommonParameters>]  
```

For example: ```Set-VMRemoteFX3dVideoAdapter mytestvm 2 1920x1200 1024MB ```

Run the following cmdlets to review and configure the physical GPUs: 

```powershell
Get-VMRemoteFXPhysicalVideoAdapter [[-Name] <string[]>] [-ComputerName <string[]>] [Credential <pscredential[]>] [<CommonParameters>]  
 
Set-VMRemoteFx3dVideoAdapter [-VM] <VirtualMachine[]> [[-MonitorCount] <byte>] [[MaximumResolution] <string>][[-VRAMSizeBytes] <uint64>] [-Passthru] [-WhatIf] [Confirm][<CommonParameters>] 
```

## Configure which GPU to use when there are multiple GPUs to choose from

When there are multiple GPUs on the host, RemoteFX vGPU will use all GPUs. However, in certain cases this may not be the best option. For example, if you have a built-in GPU that came with the system and a separate more powerful GPU, you will want to use which to use. You do this by specifying which GPU should NOT be used with RemoteFX.

Use the following steps to choose which GPU to use: 

1. Navigate to the Hyper-V settings in Hyper-V Manager.
2. Click **Physical GPUs** in Hyper-V Settings.
3. Select the GPU that you don’t want to use, and then clear **Use this GPU with RemoteFX**.
