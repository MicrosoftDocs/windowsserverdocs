---
title: RDS - Which graphics virtualization technology is right for you?
description: Planning information to help you choose the right graphics virtualization option for your RDS deployment.
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: elizapo
ms.date: 02/13/2017  
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d6ff5b22-7695-4fee-b1bd-6c9dce5bd0e8
author: lizap
manager: scottman
---
# Which graphics virtualization technology is right for you?

You have a range of options when it comes to enabling graphics rendering in Remote Desktop Services. When you are planning your virtualization environment, the following considerations drive which graphics rendering technology you choose:

![Graphics rendering considerations](media/rds-gpu.png)

Windows Server 2012 R2 introduced Windows Advanced Rasterization Platform (WARP), which impoved graphics experience when minimal GPU virtualization was required (for example, with data entry/line of business apps). Now, in Windows Server 2016, you have two graphics virtualization technologies available with Hyper-V that let you leverage the GPU hardware:

- Remote FX vGPU - For knowledge worker and high-burst GPU scenarios where multiple VMs leverage one or more GPUs through para-virtualization. This solution provides higher user density per server.
- Discrete Device Assignment (DDA) - For the highest performance using one or more GPUs dedicated to a VM providing native GPU driver support inside the VM. The density is low because it is limited by the number of physical GPUs available in the server. 

The following illustration shows the graphics virtualization options in Windows Server 2016.

![Graphics virtualization options in Windows Server 2016 with RDS](media/rds-graphics-virtualization.png)

## RemoteFX vGPU
RemoteFX vGPU was introduced in Windows Server 2008 R2 and initially focused on delivering typical knowledge worker scenarios (see the first graphic above). Windows Server 2016 provides further enhancements for GPU burst scenarios, for example for designer applications and data visualization. We've also enhanced application compatibility with OpenGL/CL support. Windows Server 2016 added the following new features to RemoteFX vGPU:

- OpenGL 4.4 and OpenCL 1.1 support, to improve application compatibility
- Dedicated VRAM up to 2GB
- Performance improvements in transport and API implementations
- VM support for both Gen 1 and Gen 2 VMs
- Up to 4K (3840X2160) resolution support
- Support for Windows Server 2016 personal VM
- AVC 444 codec for faster frame rate in the Remote Desktop Protocol

For installation and configuration steps, see [Set up and configure RemoteFX vGPU for Remote Desktop Services](rds-remotefx-vgpu.md).

## Discrete Device Assignment
Discrete Device Assignment (DDA) is a new hardware pass-through solution that provides the best performance, given that the VM has full access to the GPU using the native driver. Your VM user can access the full capabilities of their device as well the device’s native driver. This means the features and capabilities of running the device in a VM mirror running the same device on bare metal.

For more information about DDA, check out Plan for deploying Discrete Device Assignment.

## Which should you use?

Unfortunately, there's no simple, clearcut answer to when to use RemoteFX vGPU vs when to use DDA. The general guidance is, if you need native driver support (for example, Cuda, or anything greater than OpenCL 1.1), use DDA. If your application uses a whitelist approach to enabling graphics acceleration, you may have to use DDA. If you want the highest performance possible for a VM for either visualization (VDI, Remote Desktop) or GP-GPU workloads (like machine learning workloads), you’ll likely want to use DDA. 