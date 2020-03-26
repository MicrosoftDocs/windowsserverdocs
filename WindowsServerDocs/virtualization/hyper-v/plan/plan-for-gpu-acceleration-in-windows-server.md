---
title: Plan for GPU acceleration in Windows Server
description: Learn about the different Hyper-V technologies for GPU acceleration, including DDA and RemoteFX vGPU
ms.prod: windows-server
ms.reviewer: rickman
author: rick-man
ms.author: rickman
manager: stevelee
ms.topic: article
ms.date: 08/21/2019
---

# Plan for GPU acceleration in Windows Server

> Applies to: Windows Server 2016, Microsoft Hyper-V Server 2016, Windows Server 2019, Microsoft Hyper-V Server 2019

This article introduces the graphics virtualization capabilities available in Windows Server.

## When to use GPU acceleration

Depending on your workload, you may want to consider GPU acceleration. Here's what you should consider before choosing GPU acceleration:

- **App and desktop remoting (VDI/DaaS) workloads**: If you're building an app or desktop remoting service with Windows Server, consider the catalogue of apps you expect your users to run. Some types of apps, such as CAD/CAM apps, simulation apps, games, and rendering/visualization apps, rely heavily on 3D rendering to deliver smooth and responsive interactivity. Most customers consider GPUs a necessity for a reasonable user experience with these kinds of apps.
- **Remote rendering, encoding, and visualization workloads**: These graphics-oriented workloads tend to rely heavily on a GPU's specialized capabilities, such as efficient 3D rendering and frame encoding/decoding, in order to achieve cost-effectiveness and throughput goals. For this kind of workload, a single GPU-enabled VM may be able to match the throughput of many CPU-only VMs.
- **HPC and ML workloads**: For highly data-parallel computational workloads, such as high-performance compute and machine learning model training or inference, GPUs can dramatically shorten time to result, time to inference, and training time. Alternatively, they may offer better cost-effectiveness than a CPU-only architecture at a comparable performance level. Many HPC and machine learning frameworks have an option to enable GPU acceleration; consider whether this might benefit your specific workload.

## GPU virtualization in Windows Server

GPU virtualization technologies enable GPU acceleration in a virtualized environment, typically within virtual machines. If your workload is virtualized with Hyper-V, then you'll need to employ graphics virtualization in order to provide GPU acceleration from the physical GPU to your virtualized apps or services. However, if your workload runs directly on physical Windows Server hosts, then you have no need for graphics virtualization; your apps and services already have access to the GPU capabilities and APIs natively supported in Windows Server.

The following graphics virtualization technologies are available to Hyper-V VMs in Windows Server:

- [Discrete Device Assignment (DDA)](#discrete-device-assignment-dda)
- [RemoteFX vGPU](#remotefx-vgpu)

In addition to VM workloads, Windows Server also supports GPU acceleration of containerized workloads within Windows Containers. For more information, see [GPU Acceleration in Windows containers](https://docs.microsoft.com/virtualization/windowscontainers/deploy-containers/gpu-acceleration).

## Discrete Device Assignment (DDA)

Discrete Device Assignment (DDA), also known as GPU pass-through, allows you to dedicate one or more physical GPUs to a virtual machine. In a DDA deployment, virtualized workloads run on the native driver and typically have full access to the GPU's functionality. DDA offers the highest level of app compatibility and potential performance. DDA can also provide GPU acceleration to Linux VMs, subject to support.

A DDA deployment can accelerate only a limited number of virtual machines, since each physical GPU can provide acceleration to at most one VM. If you're developing a service whose architecture supports shared virtual machines, consider hosting multiple accelerated workloads per VM. For example, if you're building a desktop remoting service with RDS, you can improve user scale by leveraging the multi-session capabilities of Windows Server to host multiple user desktops on each VM. These users will share the benefits of GPU acceleration.

For more information, see these topics:

- [Plan for deploying Discrete Device Assignment](plan-for-deploying-devices-using-discrete-device-assignment.md)
- [Deploy graphics devices using Discrete Device Assignment](../deploy/Deploying-graphics-devices-using-dda.md)

## RemoteFX vGPU

> [!NOTE]
> RemoteFX vGPU is fully supported in Windows Server 2016 but isn't supported in Windows Server 2019.

RemoteFX vGPU is a graphics virtualization technology that allows a single physical GPU to be shared among multiple virtual machines. In a RemoteFX vGPU deployment, virtualized workloads run on Microsoft's RemoteFX 3D adapter, which coordinates GPU processing requests between the host and guests. RemoteFX vGPU is most suitable for knowledge worker and high-burst workloads where dedicated GPU resources are not required. RemoteFX vGPU can only provide GPU acceleration to Windows VMs.

For more information, see these topics:

- [Deploy graphics devices using RemoteFX vGPU](../deploy/deploy-graphics-devices-using-remotefx-vgpu.md)
- [RemoteFX 3D Video Adapter (vGPU) support](../../../remote/remote-desktop-services/rds-supported-config.md#remotefx-3d-video-adapter-vgpu-support)

## Comparing DDA and RemoteFX vGPU

Consider the following functionality and support differences between graphics virtualization technologies when planning your deployment:

|                       | RemoteFX vGPU                                                                       | Discrete Device Assignment                                                          |
|-----------------------|-------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------|
| GPU resource model    | Dedicated or shared                                                                 | Dedicated only                                                                      |
| VM density            | High (one or more GPUs to many VMs)                                                 | Low (one or more GPUs to one VM)                                                    |
| App compatibility     | DX 11.1, OpenGL 4.4, OpenCL 1.1                                                     | All GPU capabilities provided by vendor (DX 12, OpenGL, CUDA)                       |
| AVC444                | Enabled by default                                                                  | Available through Group Policy                                                      |
| GPU VRAM              | Up to 1 GB dedicated VRAM                                                           | Up to VRAM supported by the GPU                                                     |
| Frame rate            | Up to 30fps                                                                         | Up to 60fps                                                                         |
| GPU driver in guest   | RemoteFX 3D adapter display driver (Microsoft)                                      | GPU vendor driver (NVIDIA, AMD, Intel)                                              |
| Host OS support       | Windows Server 2016                                                                 | Windows Server 2016; Windows Server 2019                                            |
| Guest OS support      | Windows Server 2012 R2; Windows Server 2016; Windows 7 SP1; Windows 8.1; Windows 10 | Windows Server 2012 R2; Windows Server 2016; Windows Server 2019; Windows 10; Linux |
| Hypervisor            | Microsoft Hyper-V                                                                   | Microsoft Hyper-V                                                                   |
| GPU hardware          | Enterprise GPUs (such as Nvidia Quadro/GRID or AMD FirePro)                         | Enterprise GPUs (such as Nvidia Quadro/GRID or AMD FirePro)                         |
| Server hardware       | No special requirements                                                             | Modern server, exposes IOMMU to OS (usually SR-IOV compliant hardware)              |
