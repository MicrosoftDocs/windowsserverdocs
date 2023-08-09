---
title: Session host virtual machine sizing guidelines for Azure Virtual Desktop and Remote Desktop Services
description: Learn about sizing for session host virtual machines based on different workload types when used with Azure Virtual Desktop or Remote Desktop Services.
ms.author: helohr
ms.date: 08/10/2023
ms.topic: article
author: Heidilohr
manager: femila
---
# Session host virtual machine sizing guidelines

Whether you're running your session host virtual machines (VM) on Remote Desktop Services or Azure Virtual Desktop, different types of workloads require different VM configurations. The examples in this article are generic guidelines, and you should only use them for initial performance estimates. For the best possible experience, scale your deployment depending on your users' needs.

## Workloads

Users can run different types of workloads on the session host virtual machines. The following table shows examples of a range of workload types to help you estimate what size your virtual machines need to be. After you set up your virtual machines, you should continually monitor their actual usage and adjust their size accordingly. If you end up needing a bigger or smaller virtual machine, you can easily scale your existing deployment up or down in Azure.

The following table describes each workload. *Example users* are the types of users that might find each workload most helpful. *Example apps* are the kinds of apps that work best for each workload.

| Workload type | Example users | Example apps |
| --- | --- | --- |
| Light | Users doing basic data entry tasks | Database entry applications, command-line interfaces |
| Medium | Consultants and market researchers | Database entry applications, command-line interfaces, Microsoft Word, static web pages |
| Heavy | Software engineers, content creators | Database entry applications, command-line interfaces, Microsoft Word, static web pages, Microsoft Outlook, Microsoft PowerPoint, dynamic web pages, software development |
| Power | Graphic designers, 3D model makers, machine learning researchers | Database entry applications, command-line interfaces, Microsoft Word, static web pages, Microsoft Outlook, Microsoft PowerPoint, dynamic web pages, photo and video editing, computer-aided design (CAD), computer-aided manufacturing (CAM) |

## Single-session recommendations

*Single-session* scenarios are when there's only one user signed in to a session host VM at any one time. For example, if you use personal host pools in Azure Virtual Desktop, you're using a single-session scenario. For VM sizing recommendations for single-session scenarios, we recommend you use at least two physical CPU cores per VM, typically four vCPUs with hyper-threading. If you need more specific VM sizing recommendations for single-session scenarios, ask the software vendors specific to your workload. VM sizing for single-session VMs usually align with physical device guidelines.

The following table shows examples of typical workloads:

| Workload type | vCPU/RAM/OS storage minimum | Example Azure instances | Profile container storage minimum |
|--|--|--|--|
| Light | 2 vCPUs, 8-GB RAM, 32-GB storage | D2s_v5, D2s_v4 | 30 GB |
| Medium | 4 vCPUs, 16-GB RAM, 32-GB storage | D4s_v5, D4s_v4 | 30 GB |
| Heavy | 8 vCPUs, 32-GB RAM, 32-GB storage | D8s_v5, D8s_v4 | 30 GB |

## Multi-session recommendations

*Multi-session* scenarios are when there's more than one user signed in to a session host virtual machine at any one time. For example, when you use pooled host pools in Azure Virtual Desktop with the Windows 11 Enterprise multi-session operating system (OS), that's a multi-session deployment.

The following table lists the maximum suggested number of users per virtual central processing unit (vCPU) and the minimum VM configuration for standard or larger user workload. If you need more specific VM sizing recommendations for single-session scenarios, ask the software vendors specific to your workload.

| Workload type | Maximum users per vCPU | Minimum vCPU/RAM/OS storage | Example Azure instances | Minimum profile storage |
| --- | --- | --- | --- | --- |
| Light | 6 | 8 vCPUs, 16-GB RAM, 32-GB storage | D8s_v5, D8s_v4, F8s_v2, D8as_v4, D16s_v5, D16s_v4, F16s_v2, D16as_v4 | 30 GB |
| Medium | 4 | 8 vCPUs, 16-GB RAM, 32-GB storage | D8s_v5, D8s_v4, F8s_v2, D8as_v4, D16s_v5, D16s_v4, F16s_v2, D16as_v4 | 30 GB |
| Heavy | 2 | 8 vCPUs, 16-GB RAM, 32-GB storage | D8s_v5, D8s_v4, F8s_v2, D8as_v4, D16s_v5, D16s_v4, F16s_v2, D16as_v4 | 30 GB |
| Power | 1 | 6 vCPUs, 56-GB RAM, 340-GB storage | D16ds_v5, D16s_v4, D16as_v4, NV6, NV16as_v4 | 30 GB |

For multi-session workloads, you should limit VM size to between 4 vCPUs and 24 vCPUs for the following reasons:

- All VMs should have more than two cores. The UI components in Windows rely on the use of at least two parallel threads for some of the heavier rendering operations. For multi-session scenarios, having multiple users on a two-core VM leads to the UI and apps becoming unstable, which lowers the quality of user experience. Four cores are the lowest recommended number of cores that a stable multi-session VM should have.

- VMs shouldn't have more than 32 cores. As the number of cores increase, the system's synchronization overhead also increases. For most workloads, at around 16 cores, the return on investment gets lower, with most of the extra capacity offset by synchronization overhead. User experience is better with two 16-core VMs instead of one 32-core one.

The recommended range between 4 and 24 cores generally provides better capacity returns for your users as you increase the number of cores. For example, if you have 12 users sign in at the same time to a VM with four cores, the ratio is three users per core. Meanwhile, on a VM with 8 cores and 14 users, the ratio is 1.75 users per core. In this scenario, the latter configuration with a ratio of 1.75 offers greater burst capacity for your applications that have short-term CPU demand.

This recommendation is true at a larger scale. For scenarios with 20 or more users connected to a single VM, several smaller VMs would perform better than one or two large VMs. For example, if you're expecting 30 or more users to sign in within 10 minutes of each other on the same session host with 16 cores, two 8-core VMs would handle the workload better. You can also use breadth-first load balancing to evenly distribute users across different VMs instead of depth-first load balancing, where you can only use a new session host after the existing one is full of users.

It's also better to use a large number of smaller VMs instead of a few large VMs. It's easier to shut down VMs that need to be updated or aren't currently in use. With larger VMs, you're more likely to have at least one user signed in at any time, which prevents you from shutting down the VM. When you have many smaller VMs, it's more likely you have some VMs without active users. You can safely shut down these unused VMs to conserve resources, either manually or automatically by using autoscale in Azure Virtual Desktop. Conserving resources makes your deployment more resilient, easier to maintain, and less expensive.

## General virtual machine recommendations

In order to run your chosen OS in Azure, you must use a Premium SSD storage for production workloads that require a service level agreement (SLA). For more information, see the [Service Level Agreements (SLA) for Online Services](https://azure.microsoft.com/support/legal/sla/virtual-machines/v1_8/).

Graphics processing units (GPUs) are a good choice for users who regularly use graphics-intensive programs for video rendering, 3D design, and simulations. Azure has several graphics acceleration deployment options and multiple available GPU VM sizes. Learn more at [GPU optimized virtual machine sizes](/azure/virtual-machines/windows/sizes-gpu). For more general information about graphics acceleration in Remote Desktop Services, see [Remote Desktop Services - GPU acceleration](rds-graphics-virtualization.md)

[B-series burstable VMs](/azure/virtual-machines/windows/b-series-burstable) in Azure are a good choice for users who don't always need maximum CPU performance. For more information, see [Sizes for Windows virtual machines in Azure](/azure/virtual-machines/windows/sizes) and the pricing information on the [Virtual Machine series](https://azure.microsoft.com/pricing/details/virtual-machines/series/).

## Test your workload

Finally, you should use simulation tools to test your deployment with both stress tests and real-life usage simulations. Make sure your system is responsive and resilient enough to meet user needs, and remember to vary the load size to avoid surprises.
