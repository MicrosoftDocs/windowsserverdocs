---
title: Virtual machine sizing
description: Size recommendations for each workload type.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.author: helohr
ms.date: 12/02/2019
ms.tgt_pltfrm: na
ms.topic: article
author: Heidilohr
manager: lizross
---
# Virtual machine sizing guidance

Whether you're running your virtual machine on Remote Desktop Services or Windows Virtual Desktop, different types of workloads require different session host virtual machine (VM) configurations. For the best possible experience, scale your deployment depending on your users' needs.

## Multi-session recommendations

The following table lists the maximum suggested number of users per virtual central processing unit (vCPU) and the minimum VM configuration for each workload. These recommendations are based on [Remote Desktop workloads](remote-desktop-workloads.md).

| Workload type | Maximum users per vCPU | vCPU/RAM/OS storage minimum | Example Azure instances | Profile container storage minimum |
| --- | --- | --- | --- | --- |
| Light | 6 | 2 vCPUs, 8 GB RAM, 16 GB storage | D2s_v3, F2s_v2 | 30 GB |
| Medium | 4 | 4 vCPUs, 16 GB RAM, 32 GB storage | D4s_v3, F4s_v2 | 30 GB |
| Heavy | 2 | 4 vCPUs, 16 GB RAM, 32 GB storage | D4s_v3, F4s_v2 | 30 GB |
| Power | 1 | 6 vCPUs, 56 GB RAM, 340 GB storage | D4s_v3, F4s_v2, NV6 | 30 GB |

## Single-session recommendations

For VM sizing recommendations for single-session scenarios, we recommend at least two physical CPU cores per VM (typically four vCPUs with hyperthreading). If you need more specific VM sizing recommendations for single-session scenarios, ask the software vendors specific to your workload. VM sizing for single-session VMs will likely align with physical device guidelines.

## General virtual machine recommendations

For VM requirements to run the operating system, see [Windows 10 computer specifications and system requirements](https://www.microsoft.com/windows/windows-10-specifications).

We recommend you use Premium SSD storage in your OS disk for production workloads that require a service level agreement (SLA). For more details, see the [SLA for virtual machines](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_8/).

Graphics processing units (GPUs) are a good choice for users who regularly use graphics-intensive programs for video rendering, 3D design, and simulations. To learn more about graphics acceleration, see [Choose your graphics rendering technology](rds-graphics-virtualization.md). Azure has several graphics acceleration deployment options and multiple available GPU VM sizes. Learn more at [GPU optimized virtual machine sizes](https://docs.microsoft.com/azure/virtual-machines/windows/sizes-gpu).

[B-series burstable VMs](https://docs.microsoft.com/azure/virtual-machines/windows/b-series-burstable) are a good choice for users who don't always need maximum CPU performance. For more information about VM types and sizes, see [Sizes for Windows virtual machines in Azure](https://docs.microsoft.com/azure/virtual-machines/windows/sizes) and the pricing information on [our Virtual Machine series page](https://azure.microsoft.com/pricing/details/virtual-machines/series/).

## Test your workload

Finally, we recommend you use simulation tools to test your deployment with both stress tests and real-life usage simulations. Make sure your system is responsive and resilient enough to meet user needs, and remember to vary the load size to avoid surprises.
