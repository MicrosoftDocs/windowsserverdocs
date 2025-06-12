---
title: Partition and share GPUs with virtual machines on Hyper-V
description: Learn about how GPU partitioning works with multiple virtual machines on Windows Server.
author: meaghanlewis
ms.author: mosagie
ms.topic: concept-article
ms.subservice: core-os
ms.date: 06/12/2025
---

# GPU partitioning

GPU partitioning allows you to share a physical GPU device with multiple virtual machines (VMs). With GPU partitioning or GPU virtualization, each VM gets a dedicated fraction of the GPU instead of the entire GPU.

The GPU partitioning feature uses the [Single Root IO Virtualization (SR-IOV) interface](/windows-hardware/drivers/network/overview-of-single-root-i-o-virtualization--sr-iov-), which provides a hardware-backed security boundary with predictable performance for each VM. Each VM can access only the GPU resources dedicated to them and the secure hardware partitioning prevents unauthorized access by other VMs.

Windows Server introduces live migration with GPU partitioning. There are specific requirements to use GPU partitioning live migration. Aside from recommended live migration best practices, your cluster hosts need to have Input/Output Memory Management Unit (IOMMU) DMA bit tracking capable processors. For example, processors supporting Intel VT-D or AMD-Vi. If you use Windows Server and live migration without IOMMU enabled processors, the VMs are automatically restarted where GPU resources are available.

GPU partitioning is designed for standalone servers. You can live migrate VMs between standalone nodes for planned downtime; however, for customers that require clustering for unplanned downtime, you must use Windows Server 2025 Datacenter.

## When to use GPU partitioning

Some workloads, such as virtual desktop infrastructure (VDI), Artificial Intelligent (AI) and Machine Learning (ML) inferencing require GPU acceleration, GPU partitioning can help reduce your total cost of ownership for your overall infrastructure.

For example:

- VDI applications: Distributed edge customers run basic productivity apps, such as Microsoft Office and graphics-heavy visualization workloads in their VDI environments, which require GPU acceleration. For such workloads, you can achieve the required GPU acceleration via DDA or GPU partitioning. With GPU partitioning, you can create multiple partitions and assign each partition to VM hosting a VDI environment. GPU partitioning helps you achieve the desired density and scale the number of supported users by an order of magnitude.

- Inference with ML: Customers in retail stores and manufacturing plants can run inference at the edge, which requires GPU support for their servers. Using GPU on your servers, you can run ML models to get quick results that can be acted on before the data is sent to the cloud. The full data set can optionally be transferred to continue to retrain and improve your ML models. Along with DDA, where you dedicate an entire physical GPU to a VM, GPU partitioning enables you to run multiple inference applications simultaneously on the same GPU, but in separate hardware partitions, maximizing GPU utilization.

## Supported guest operating systems

GPU partitioning on Windows Server 2025 and later supports these guest operating systems:

- Windows 10 or later
- Windows 10 Enterprise multi-session​ or later
- Windows Server 2019 or later
- Linux Ubuntu 18.04 LTS, Linux Ubuntu 20.04 LTS​, Linux Ubuntu 22.04 LTS

## Supported GPUs

The following GPUs support GPU partitioning:

- NVIDIA A2
- NVIDIA A10
- NVIDIA A16
- NVIDIA A40
- NVIDIA L2
- NVIDIA L4
- NVIDIA L40
- NVIDIA L40S

> [!NOTE]
> You need to install v18.x or later of the NVIDIA driver to use live migration.

We recommend working with your Original Equipment Manufacturer (OEM) partners and GPU Independent Hardware Vendors (IHVs) when planning your systems. They can help you order and set up the right hardware and software for your workloads. However, we support more GPUs if you want to use GPU acceleration via Discrete Device Assignment (DDA). Reach out to your OEM partners and IHVs to get a list of GPUs that support DDA. For more information about using GPU acceleration via DDA, see [Discrete Device Assignment (DDA)](deploy/Deploying-graphics-devices-using-dda.md).

For best performance, we recommend that you create a homogeneous configuration for GPUs across all the servers in your cluster. A homogeneous configuration consists of installing the same make and model of the GPU, and configuring the same partition count in the GPUs across all the servers in the cluster. For example, in a cluster of two servers with one or more GPUs installed, all the GPUs must have the same make, model, and size. The partition count on each GPU must also match.

## Limitations

Consider the following limitations when using the GPU partitioning feature:

- GPU partitioning is unsupported if your configuration isn't homogeneous. Here are some examples of unsupported configurations:

  - Mixing GPUs from different vendors in the same cluster.

  - Using different GPU models from different product families from the same vendor in the same cluster.

- You can't assign a physical GPU as both [Discrete Device Assignment (DDA)](deploy/Deploying-graphics-devices-using-dda.md) or partitionable GPU. You can either assign it as DDA or as partitionable GPU, but not both.

- If you assign more than one GPU partition to a VM, each partition appears as another GPU.

- Partitions are autoassigned to the VMs. You can't choose a specific partition for a specific VM.

- You can partition your GPU using Windows Admin Center or using PowerShell. We recommend that you use Windows Admin Center to configure and assign GPU partitions. Windows Admin Center automatically validates for a homogeneous configuration of the GPUs across all the servers in your cluster. It provides appropriate warnings and errors to take any corrective action needed.

- If using PowerShell to enable GPU partitioning, you must perform the same configuration steps on each server in the cluster. You must manually ensure that the homogeneous configuration is maintained for GPUs across all the servers in your cluster.

- When live migrating a virtual machine with a GPU partition assigned, Hyper-V live migration automatically falls back to using TCP/IP with compression. Migrating a virtual machine has the potential effect of increasing the CPU utilization of a host. In addition, live migrations could take longer than with virtual machines without GPU partitions attached.

## Related content

For more information on using GPUs with your VMs and GPU partitioning, see:

- [Partition and assign GPUs to a virtual machine](partition-assign-vm-gpu.md)
- [Use GPUs with clustered VMs](deploy/use-gpu-with-clustered-vm.md)
