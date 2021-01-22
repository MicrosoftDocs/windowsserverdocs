---
title: Virtual machine sizing
description: Size recommendations for each workload type.
ms.author: helohr
ms.date: 01/22/2021
ms.topic: article
author: Heidilohr
manager: lizross
---
# Virtual machine sizing guidelines

Whether you're running your virtual machine on Remote Desktop Services or Windows Virtual Desktop, different types of workloads require different session host virtual machine (VM) configurations. For the best possible experience, scale your deployment depending on your users' needs.

## Multi-session recommendations

The following tables list the maximum suggested number of users per virtual central processing unit (vCPU) and the minimum VM configuration for each workload. These recommendations are based on [Remote Desktop workloads](remote-desktop-workloads.md).

This table shows examples of a smaller user workload with less than 30 users:

| Workload type | Maximum users per vCPU | vCPU/RAM/OS storage minimum | Example Azure instances | Profile container storage minimum |
| --- | --- | --- | --- | --- |
| Light | 4 | 4 vCPUs, 16 GB RAM, 32 GB storage | D4s_v3, F4s_v2, D4a_v4 | 30 GB |
| Medium | 4 | 4 vCPUs, 16 GB RAM, 32 GB storage | D4s_v3, F4s_v2, D4a_v4 | 30 GB |
| Heavy | 2 | 4 vCPUs, 16 GB RAM, 32 GB storage | D4s_v3, F4s_v2, D4a_v4 | 30 GB |
| Power | 1 | 6 vCPUs, 56 GB RAM, 340 GB storage | D4s_v3, F4s_v2, D4a_v4, NV6 | 30 GB |

This table shows examples of a standard user workload with 30 or more users:

| Workload type | Maximum users per vCPU | vCPU/RAM/OS storage minimum | Example Azure instances | Profile container storage minimum |
| --- | --- | --- | --- | --- |
| Light | 6 | 2 vCPUs, 8 GB RAM, 16 GB storage | D8s_v3, F8s_v2, D8as_v4
D16s_v3, F16s_v2, D16as_v4 | 30 GB |
| Medium | 4 | 4 vCPUs, 16 GB RAM, 32 GB storage | D8s_v3, F8s_v2, D8as_v4
D16s_v3, F16s_v2, D16as_v4 | 30 GB |
| Heavy | 2 | 4 vCPUs, 16 GB RAM, 32 GB storage | D8s_v3, F8s_v2, D8as_v4
D16s_v3, F16s_v2, D16as_v4 | 30 GB |
| Power | 1 | 6 vCPUs, 56 GB RAM, 340 GB storage | D8s_v3, F8s_v2, D8as_v4
D16s_v3, F16s_v2, D16as_v4
NV6 | 30 GB |

## Recommended VM sizes for standard or larger environments

We recommend limiting VM size to between 4 vCPUs and 24 vCPUs. We don't recommend using 2 cores or 32 or more cores for standard and larger environments. Why is that?

Windows 10 and its UI components rely on using at least two parallel threads for some of the heavier rendering operations. Having multiple users on a two-core VM will lead to the UI and apps becoming unstable, which lowers the quality of user experience. Four cores is the lowest possible number of cores that a stable multi-user VM can have.

As the number of cores increase, the system's synchronization overhead also increases. For most workloads, at around 16 cores the return on investment gets lower, with most of the extra capacity being offset by synchronization overhead. It is likely to get more capacity from two 16 core VMs as opposed to one 32 core one.

The recommended range between 4 and 24 cores will generally provide better capacity returns for your users as you increase the number of cores. For example, if your scenario needs one-third of a core for each user, then 12 users on a four-core system would have less available burst capacity than 14 users with eight cores.

For scenarios with 20 or more connections on a single VM, several smaller VMs would perform better than one or two large VMs. For example, if you're expecting 30 or more user to simultaneously sign in on the same session host within 10 minutes, two eight-core VMs will handle the workload better than one 16-core VM. You can also use breadth-first load balancing to evenly distribute users across different VMs.

## Single-session recommendations

For VM sizing recommendations for single-session scenarios, we recommend at least two physical CPU cores per VM (typically four vCPUs with hyperthreading). If you need more specific VM sizing recommendations for single-session scenarios, ask the software vendors specific to your workload. VM sizing for single-session VMs will likely align with physical device guidelines.

## General virtual machine recommendations

For VM requirements to run the operating system, see [Windows 10 computer specifications and system requirements](https://www.microsoft.com/windows/windows-10-specifications).

We recommend you use Premium SSD storage in your OS disk for production workloads that require a service level agreement (SLA). For more details, see the [SLA for virtual machines](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_8/).

Graphics processing units (GPUs) are a good choice for users who regularly use graphics-intensive programs for video rendering, 3D design, and simulations. To learn more about graphics acceleration, see [Choose your graphics rendering technology](rds-graphics-virtualization.md). Azure has several graphics acceleration deployment options and multiple available GPU VM sizes. Learn more at [GPU optimized virtual machine sizes](/azure/virtual-machines/windows/sizes-gpu).

[B-series burstable VMs](/azure/virtual-machines/windows/b-series-burstable) are a good choice for users who don't always need maximum CPU performance. For more information about VM types and sizes, see [Sizes for Windows virtual machines in Azure](/azure/virtual-machines/windows/sizes) and the pricing information on [our Virtual Machine series page](https://azure.microsoft.com/pricing/details/virtual-machines/series/).

## Test your workload

Finally, we recommend you use simulation tools to test your deployment with both stress tests and real-life usage simulations. Make sure your system is responsive and resilient enough to meet user needs, and remember to vary the load size to avoid surprises.
