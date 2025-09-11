---
title: Plan for GPU acceleration in Windows Server
description: Learn about the different Hyper-V technologies for GPU acceleration, including DDA and GPU partitioning.
author: robinharwood
ms.author: roharwoo
ms.topic: concept-article
ms.date: 10/25/2024
---

# Plan for GPU acceleration in Windows Server

This article introduces the graphics virtualization capabilities available in Windows Server.

## When to use GPU acceleration

Depending on your workload, you might want to consider GPU acceleration. Here's what you should consider before choosing GPU acceleration:

- **App and desktop remoting (VDI/DaaS) workloads**: If you're building an app or desktop remoting service with Windows Server, consider the catalog of apps you expect your users to run. Some types of apps, such as CAD/CAM apps, simulation apps, games, and rendering/visualization apps, rely heavily on 3D rendering to deliver smooth and responsive interactivity. Most customers consider GPUs a necessity for a reasonable user experience with these kinds of apps.
- **Remote rendering, encoding, and visualization workloads**: These graphics-oriented workloads tend to rely heavily on a GPU's specialized capabilities, such as efficient 3D rendering and frame encoding/decoding, in order to achieve cost-effectiveness and throughput goals. For this kind of workload, a single GPU-enabled virtual machine (VM) might be able to match the throughput of many CPU-only VMs.
- **HPC and ML workloads**: For highly data-parallel computational workloads, such as high-performance compute and machine learning model training or inference, GPUs can dramatically shorten time to result, time to inference, and training time. Alternatively, they might offer better cost-effectiveness than a CPU-only architecture at a comparable performance level. Many High Performance Compute (HPC) and machine learning frameworks can use GPU acceleration; consider whether GPU acceleration might benefit your specific workload.

## GPU virtualization in Windows Server

GPU virtualization technologies enable GPU acceleration in a virtualized environment, typically within virtual machines. If your workload is virtualized with Hyper-V, then you need to employ graphics virtualization in order to provide GPU acceleration from the physical GPU to your virtualized apps or services. However, if your workload runs directly on physical Windows Server hosts, then you have no need for graphics virtualization; your apps and services already have access to the GPU capabilities and APIs natively supported in Windows Server.

The following graphics virtualization technologies are available to Hyper-V VMs in Windows Server:

- [Discrete Device Assignment (DDA)](#discrete-device-assignment-dda)
- [GPU Partitioning (GPU-P)](#gpu-partitioning-gpu-p)

In addition to VM workloads, Windows Server also supports GPU acceleration of containerized workloads within Windows Containers. For more information, see [GPU Acceleration in Windows containers](/virtualization/windowscontainers/deploy-containers/gpu-acceleration).

## Discrete Device Assignment (DDA)

Discrete Device Assignment (DDA) allows you to dedicate one or more physical GPUs to a virtual machine. In a DDA deployment, virtualized workloads run on the native driver and typically have full access to the GPU's functionality. DDA offers the highest level of app compatibility and potential performance. DDA can also provide GPU acceleration to Linux VMs, subject to support.

A DDA deployment can accelerate only a limited number of virtual machines, since each physical GPU can provide acceleration to at most one VM. If you're developing a service whose architecture supports shared virtual machines, consider hosting multiple accelerated workloads per VM. For example, if you're building a Remote Desktop Services solution, you can improve user scale by using the multi-session capabilities of Windows Server to host multiple user desktops on each VM. These users share the benefits of GPU acceleration.

For more information, see these articles:

- [Plan for deploying Discrete Device Assignment](plan-for-deploying-devices-using-discrete-device-assignment.md)
- [Deploy graphics devices using Discrete Device Assignment](../deploy/Deploying-graphics-devices-using-dda.md)

## GPU Partitioning (GPU-P)

Beginning with Windows Server 2025, GPU partitioning allows you to share a physical GPU device with multiple virtual machines (VMs). With GPU partitioning or GPU virtualization, each VM gets a dedicated fraction of the GPU instead of the entire GPU.

The GPU partitioning uses the [Single Root IO Virtualization (SR-IOV) interface](/windows-hardware/drivers/network/overview-of-single-root-i-o-virtualization--sr-iov-), which provides a hardware-backed security boundary with predictable performance for each VM. Each VM can access only the GPU resources dedicated to them and the secure hardware partitioning prevents unauthorized access by other VMs.

To learn more about GPU partitioning, see these articles:

- [GPU partitioning](../gpu-partitioning.md)
- [Partition and assign GPUs to a virtual machine](../partition-assign-vm-gpu.md)

## Comparing DDA and GPU partitioning

Consider the following functionality and support differences between graphics virtualization technologies when planning your deployment:

| Description | Discrete Device Assignment | GPU Partitioning |
|--|--|--|
| GPU resource model | Dedicated only | Partitioned |
| VM density | Low (one or more GPUs to one VM) | High (one or more GPUs to many VMs) |
| App compatibility | All GPU capabilities provided by vendor (DX 12, OpenGL, CUDA) | All GPU capabilities provided by vendor (DX 12, OpenGL, CUDA) |
| AVC444 | Available through Group Policy | Available through Group Policy |
| GPU VRAM | Up to VRAM supported by the GPU | Up to VRAM supported by the GPU per partition |
| GPU driver in guest | GPU vendor driver (NVIDIA, AMD, Intel) | GPU vendor driver (NVIDIA, AMD, Intel) |

