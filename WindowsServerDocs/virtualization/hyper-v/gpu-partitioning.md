---
title: Partition and share GPUs with virtual machines on Hyper-V
description: Learn how to partition and share a GPU with multiple virtual machines on Windows Server and Azure Stack HCI.
author: robinharwood
ms.author: roharwoo
ms.topic: how-to
ms.date: 04/05/2023
zone_pivot_groups: windows-os
---

# GPU partitioning

:::zone pivot="windows-server"
>Applies to: Windows Server 2025

> [!IMPORTANT]
> GPU partitioning is in PREVIEW on Windows Server. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.
::: zone-end

:::zone pivot="azure-stack-hci"

[!INCLUDE [applies-to](~/../_azurestack/azure-stack/includes/hci-applies-to-23h2-22h2.md)]

[!INCLUDE [hci-arc-vm](~/../_azurestack/azure-stack/includes/hci-arc-vm.md)]

::: zone-end

GPU partitioning allows you to share a physical GPU device with multiple virtual machines (VMs). With GPU partitioning or GPU virtualization, each VM gets a dedicated fraction of the GPU instead of the entire GPU.

The GPU partitioning feature uses the [Single Root IO Virtualization (SR-IOV) interface](/windows-hardware/drivers/network/overview-of-single-root-i-o-virtualization--sr-iov-), which provides a hardware-backed security boundary with predictable performance for each VM. Each VM can access only the GPU resources dedicated to them and the secure hardware partitioning prevents unauthorized access by other VMs.

> [!NOTE]
> Currently, we support only Nvidia A2, A10, A16, A40 GPUs for GPU partitioning on Azure Stack HCI. We recommend that you work with your Original Equipment Manufacturer (OEM) partners and GPU Independent Hardware Vendors (IHVs) to plan, order, and set up the systems for your desired workloads with the appropriate configurations and necessary software. However, we support additional GPUs if you want to use GPU acceleration via Discrete Device Assignment (DDA) or GPU passthrough. Reach out to your OEM partners and IHVs to get a list of GPUs that support DDA. For more information about using GPU acceleration via DDA, see [Use GPUs with clustered VMs](../manage/use-gpu-with-clustered-vm.md).

## When to use GPU partitioning

You may prefer to keep certain workloads on premises because they require low latency or need to be compliant with the data sovereignty laws of your country/region. Certain workloads, such as virtual desktop infrastructure (VDI) and Machine Learning (ML) inferencing require GPU acceleration, and GPU partitioning can help reduce your total cost of ownership for your overall infrastructure.

- VDI applications: Distributed edge customers run basic productivity apps, such as Microsoft Office and graphics-heavy visualization workloads in their VDI environments, which require GPU acceleration. For such workloads, you can achieve the required GPU acceleration via DDA or GPU partitioning. With GPU partitioning, you can create multiple partitions and assign each partition to VM hosting a VDI environment. GPU partitioning helps you achieve the desired density and scale the number of supported users by an order of magnitude.

- Inference with ML: Customers in retail stores and manufacturing plants can run inference at the edge, which requires GPU support for their servers. Using GPU on your servers, you can run ML models to get quick results that can be acted on before the data is sent to the cloud. The full data set can optionally be transferred to continue to retrain and improve your ML models. Along with DDA where you assign an entire physical GPU to a VM, GPU partitioning allows you to run multiple inferencing applications in parallel on the same GPU, but in separate physical partitions, thereby utilizing the GPU to the maximum.

## Supported guest operating systems

GPU partitioning on Azure Stack HCI supports these guest operating systems:

- Windows 10, Windows 11, Windows 10 Enterprise multi-session​, Windows 11 Enterprise multi-session
- Windows Server 2019, Windows Server 2022
- Linux Ubuntu 18.04 LTS, Linux Ubuntu 20.04 LTS​

## GPU partitioning caveats

Consider the following caveats when using the GPU partitioning feature:

- For best performance, we recommend that you create a homogeneous configuration for GPUs across all the servers in your cluster. A homogeneous configuration consists of installing the same make and model of the GPU, and configuring the same partition count in the GPUs across all the servers in the cluster. For example, in a cluster of two servers with one or more GPUs installed, all the GPUs must have the same make, model, and size. The partition count on each GPU must also match. Azure Stack HCI doesn't support GPU partitioning if your configuration isn't homogeneous. Here are some examples of unsupported configurations:

    - Mixing GPUs from different vendors in the same cluster.
    
    - Using different GPU models from different product families from the same vendor in the same cluster.

- You can't assign a physical GPU as both [Discrete Device Assignment (DDA)](../manage/use-gpu-with-clustered-vm.md) or partitionable GPU. You can either assign it as DDA or as partitionable GPU, but not both.

- You can assign only a single GPU partition to a VM.

- Azure Stack HCI auto-assigns the partition to the VMs. You can't choose a specific partition for a specific VM.

- Currently, GPU partitioning on Azure Stack HCI doesn't support live migration of VMs. But VMs can be automatically restarted and placed where GPU resources are available if there's a failure.

- You can partition your GPU using Windows Admin Center or using PowerShell. We recommend that you use Windows Admin Center to configure and assign GPU partitions. Windows Admin Center automatically validates for a homogeneous configuration of the GPUs across all the servers in your cluster. It provides appropriate warnings and errors to take any corrective action needed.

- If using PowerShell to provision GPU partitioning, you must perform the provisioning steps on each server in the cluster. You must manually ensure that the homogeneous configuration is maintained for GPUs across all the servers in your cluster.

## Next steps

For more information on using GPUs with your VMs and GPU partitioning, see:

- [Partition and assign GPUs to a virtual machine](partition-assign-vm-gpu.md)
- [Use GPUs with clustered VMs](../manage/use-gpu-with-clustered-vm.md)
- [Accelerate your edge workloads with affordable NVIDIA GPU-powered Azure Stack HCI solutions](https://techcommunity.microsoft.com/t5/azure-stack-blog/accelerate-your-edge-workloads-with-affordable-nvidia-gpu/ba-p/3692795) blog