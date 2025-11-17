---
title: Session Host Virtual Machine Sizing Guidelines for Remote Desktop
description: Learn about sizing for session host virtual machines based on different workload types when used with Azure Virtual Desktop or Remote Desktop Services.
ms.topic: best-practice
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 07/23/2025
---

# Session host virtual machine sizing guidelines for Azure Virtual Desktop and Remote Desktop Services

Session host sizing for Azure Virtual Desktop and Remote Desktop Services requires careful consideration of workload types and hardware configurations. Different types of workloads require different hardware configurations to ensure optimal performance.

There are two types of session hosts to consider when sizing them appropriately for users:

- **Single-session**: dedicated to a single user at a time.

- **Multi-session**: shared between multiple users concurrently.

In an environment where desktops and apps are accessed remotely, execution and data processing occurs on the session host, unless apps support local offload. Correctly sizing both each session host and the number of session hosts is important so you don't run out of resources during peak loads, which would otherwise lead to disruption to users.

Session hosts can run on virtual machines or on physical hardware for Remote Desktop Services. Virtual machines do have some overhead, so you should account for that when sizing your session hosts, which is covered in this article.

The examples in this article are generic guidelines, and you should only use them for initial performance estimates. For the best possible experience, scale your deployment depending on your users' needs.

## Capacity planning

The capacity and resources you need to provide is different for everyone as it depends on many contributing factors. Capacity planning is the process of determining the session hosts and their resources required to meet the expected workload demands. It involves analyzing current and future resource needs, estimating the number of users per session host, and determining the appropriate sizes to ensure optimal performance.

When planning capacity for session hosts, consider the following areas:

| Area | Description |
|--------|-------------|
| **User workload** | Understand the types of apps and tasks users perform. Different workloads have varying resource requirements, such as CPU, memory, and storage. |
| **User count** | Estimate the number of concurrent users who access the session hosts. This helps determine the required resources to support the expected user load. |
| **Resource requirements** | Analyze the resource requirements of the apps and tasks users perform. This includes CPU, memory, storage, and network bandwidth. |
| **Performance expectations** | Define the performance expectations for the session hosts, such as response time, logon time, application launch time, and overall user experience. Consider logon performance for key times, such as the start of a work day or shift as these can impact performance compared to a steady state. |
| **Scalability** | Consider the ability to scale the session hosts as user demands increase. This might involve adding more session hosts or resizing existing ones to accommodate extra users or workloads. |
| **Resilience and redundancy** | Consider implementing redundancy and failover mechanisms to ensure high availability and minimize downtime if there are hardware or software failures. |
| **Monitoring and optimization** | Implement monitoring tools to track resource utilization and performance metrics. Use this data to optimize the session hosts and make ongoing adjustments as needed. |

The following two approaches are commonly used to help you determine the capacity of session hosts:

- **Pilot approach**: deploy a single test server and gradually increase the load while monitoring user feedback and system performance indicators such as CPU, paging, disk, and network. This approach is reliable for smaller deployments but might require initial hardware investments that might not meet final deployment goals.

- **Simulation approach**: use automation tools to generate simulated user workloads that mimic real user behavior. Typically simulation involves gradually increasing the number of simulated users over time and performance metrics are collected throughout the test. Analysis helps identify the point where performance degrades beyond acceptable thresholds. This approach is more suitable for larger deployments where accurate capacity determination significantly influences purchasing decisions.

Piloting tends to be more time and cost effective for smaller deployments, while the simulation approach might be more suitable for larger deployments where accurately determining session host capacity can significantly influence purchasing decisions.

Whichever approach you use, you also need to consider key times for user logon, such as the start of a work day or shift, which can impact performance compared to a steady state and cause long logon times. A session host might be able to support enough users for a certain scenario, but it might not have the capacity to service those users all logging on concurrently. Also plan for some headroom to accommodate unexpected spikes in user activity or resource demands.

We recommend you document the capacity planning process, including assumptions, calculations, and decisions made. Communicate the plan to stakeholders to ensure alignment and understanding.

### Key factors affecting capacity and performance

There are several key factors that affect the capacity of session hosts. Understanding these factors can help you make informed decisions about sizing and scaling your session hosts.

- **CPU scaling**:
  - The number of CPU cores directly impacts the number of users that can be supported on a session host VM.
  - Doubling the number of CPU cores doesn't necessarily double the user capacity due to diminishing returns and synchronization overhead. The scaling factor is higher when the initial number of CPUs is small, and it decreases as the number of cores get higher. For example, the scaling factor going from 4 cores to 8 cores is larger than the one going from 8 cores to 16 cores.
  - The scaling factor typically ranges between 1.5 and 1.9, meaning that for every extra core, you can expect a proportional increase in user capacity, but not a linear one.

- **Memory impact**:
  - The amount of memory allocated to a session host VM directly affects the number of users it can support.
  - When memory is the limiting factor, adding more memory at lower capacities can significantly improve performance. For example, increasing memory from 8 GB to 16 GB can more than double the number of users you can support.

- **User logon impact**:
  - User logon is a CPU-intensive operation, and high concurrent logon rates can significantly impact system performance.
  - Plan for expected logon patterns, such as the start of a work day at 9 AM, where many users log on simultaneously. Otherwise users might experience extended logon times.

- **Virtualization overhead**
  - Running on virtual machines can incur a 15-20% capacity cost compared to bare metal, based on internal testing.
  - A hypervisor introduces more latency and CPU overhead that can result in user response times being 10% to 20% higher than on bare metal.

- **Hyperthreading benefits**
  - Hyperthreading can improve user capacity by allowing more threads to run concurrently on each core, making more efficient use of the processor's resources.
  - The benefits of hyperthreading vary depending on the workload and the number of cores. Workloads that are less CPU-intensive can benefit from extra parallel processing capabilities and achieve better performance through hyperthreading.

- **Network performance**
  - Network latency, packet loss and jitter can impact user experience, especially for applications that require frequent communication with remote servers or databases. Any combination of high latency, packet loss, and jitter can lead to slower response times and degraded performance.
  - Lower network RTT, packet loss, and jitter lead to faster response times and better overall performance. Consider using low-latency network connections to minimize the impact of network performance on user experience.

- **Storage performance**
  - Storage performance can impact user experience, especially for applications that require frequent disk access.
  - Use high-performance storage solutions, such as SSDs or NVMe drives, to ensure fast data access and minimize latency.

- **Graphics processing unit (GPU) requirements**
  - Some workloads, such as graphics-intensive applications for video rendering, 3D design, and simulations or virtual desktops with high-resolution displays, might require dedicated GPUs to ensure optimal performance.
  - Consider using session hosts with GPU capabilities if your users run graphics-intensive applications or require high-resolution displays.

All these factors can impact the overall performance and capacity of session hosts. The measurement of user input delay, or end-to-end session response time, is a key metric to consider when evaluating the performance for users. This metric measures the time it takes for a user's input to be processed and reflected in the session, providing a more accurate representation of user experience. Users generally expect a response time of less than 200 milliseconds for their actions, and any delay beyond that can lead to a degraded user experience. For more information about measuring user experience, see [Use performance counters to diagnose app performance problems on Remote Desktop Session Hosts](rds-rdsh-performance-counters.md).

## Workloads

When sizing session hosts, it's important to consider the type of workload that users run as they can be significantly different. For example, light data entry workers have low resource utilization that would lead to a high user density. However, expert workers using heavy 3D apps consume higher resources that would lead to low user density with the same hardware.

Here's an example that categorizes workloads into four types: *light*, *medium*, *heavy*, and *power*. Each workload type has different resource requirements and user expectations.

The following table describes each workload. *Example users* are the types of users that might find each workload most helpful. *Example apps* are the kinds of apps that work best for each workload.

| Workload type | Example users | Example apps |
| --- | --- | --- |
| Light | Users doing basic data entry tasks | Database entry apps, command-line interfaces |
| Medium | Consultants and market researchers | Database entry apps, command-line interfaces, Microsoft Word, static web pages |
| Heavy | Software engineers, content creators | Database entry apps, command-line interfaces, Microsoft Word, static web pages, Microsoft Outlook, Microsoft PowerPoint, dynamic web pages, software development |
| Power | Graphic designers, 3D model makers, machine learning researchers | Database entry apps, command-line interfaces, Microsoft Word, static web pages, Microsoft Outlook, Microsoft PowerPoint, dynamic web pages, photo and video editing, computer-aided design (CAD), computer-aided manufacturing (CAM) |

### Single-session session host sizing recommendations

In a *single-session* scenario, only one user is signed in to a session host at any one time. For example, if you use personal host pools in Azure Virtual Desktop, you're using a single-session scenario.

These sizing recommendations for single-session scenarios are based on Azure VMs. You can also use these figures as a baseline for physical session hosts, consider your capacity planning approach to refine these recommendations for your workloads.

We recommend you use at least two physical CPU cores per VM, typically four vCPUs with hyper-threading. If you need more specific VM sizing recommendations for single-session scenarios, ask the software vendors specific to your workload. VM sizing for single-session session hosts usually align with physical device guidelines.

The following table shows examples of typical workloads:

| Workload type | vCPU/RAM/OS storage minimum | Example Azure instances | Profile container storage minimum |
|--|--|--|--|
| Light | 2 vCPUs, 8 GB RAM, 32 GB storage | D2s_v5, D2s_v4 | 30 GB |
| Medium | 4 vCPUs, 16 GB RAM, 32 GB storage | D4s_v5, D4s_v4 | 30 GB |
| Heavy | 8 vCPUs, 32 GB RAM, 32 GB storage | D8s_v5, D8s_v4 | 30 GB |

### Multi-session session host sizing recommendations

In a *multi-session* scenario, more than one user is signed in to a session host virtual machine at any given time. For example, when you use pooled host pools in Azure Virtual Desktop with the Windows 11 Enterprise multi-session operating system (OS), that's a multi-session deployment.

A multi-session computing environment experiences significantly higher peak loads compared to single-session environments. A session host with a specific hardware capacity has a maximum workload limit that it can support before its resources are exhausted.

These sizing recommendations for multi-session scenarios are based on Azure VMs. You can also use these figures as a baseline for physical session hosts, consider your capacity planning approach to refine these recommendations for your workloads.

The following table lists the maximum suggested number of users per virtual central processing unit (vCPU) and the minimum VM configuration for a standard or larger user workload. If you need more specific VM sizing recommendations for single-session scenarios, ask the software vendors specific to your workload.

| Workload type | Maximum users per vCPU | Minimum vCPU/RAM/OS storage | Example Azure instances | Minimum profile storage |
| --- | --- | --- | --- | --- |
| Light | 6 | 8 vCPUs, 16 GB RAM, 32 GB storage | D8s_v5, D8s_v4, F8s_v2, D8as_v4, D16s_v5, D16s_v4, F16s_v2, D16as_v4 | 30 GB |
| Medium | 4 | 8 vCPUs, 16 GB RAM, 32 GB storage | D8s_v5, D8s_v4, F8s_v2, D8as_v4, D16s_v5, D16s_v4, F16s_v2, D16as_v4 | 30 GB |
| Heavy | 2 | 8 vCPUs, 16 GB RAM, 32 GB storage | D8s_v5, D8s_v4, F8s_v2, D8as_v4, D16s_v5, D16s_v4, F16s_v2, D16as_v4 | 30 GB |
| Power | 1 | 6 vCPUs, 56 GB RAM, 340 GB storage | D16ds_v5, D16s_v4, D16as_v4, NV6, NV16as_v4 | 30 GB |

For multi-session workloads, you should limit VM size to between 4 vCPUs and 24 vCPUs for the following reasons:

- All VMs should have more than two cores. The UI components in Windows rely on the use of at least two parallel threads for some of the heavier rendering operations. For multi-session scenarios, having multiple users on a two-core VM leads to the UI and apps becoming unstable, which lowers the quality of user experience. Four cores are the lowest recommended number of cores that a stable multi-session VM should have.

- VMs shouldn't have more than 32 cores. As the number of cores increases, the system's synchronization overhead also increases. For most workloads, at around 16 cores, the return on investment gets lower, with most of the extra capacity offset by synchronization overhead. User experience is better with two 16-core VMs instead of one 32-core VM.

The recommended range between 4 and 24 cores generally provides better capacity returns for your users as you increase the number of cores. For example, if you have 12 users sign in at the same time to a VM that has four cores, the ratio is three users per core. On a VM with 8 cores and 14 users, the ratio is 1.75 users per core. In this scenario, the latter configuration with a ratio of 1.75 offers greater burst capacity for applications that have short-term CPU demand.

This recommendation is true at a larger scale. For scenarios with 20 or more users connected to a single VM, several smaller VMs would perform better than one or two large VMs. For example, if you're expecting 30 or more users to sign in within 10 minutes of each other on the same session host with 16 cores, two 8-core VMs would handle the workload better. You can also use breadth-first load balancing to evenly distribute users across different VMs instead of depth-first load balancing, where you can only use a new session host after the existing one is full of users.

It's also better to use a large number of smaller VMs instead of a few large VMs. It's easier to shut down VMs that need to be updated or aren't currently in use. With larger VMs, you're more likely to have at least one user signed in at any given time, which prevents you from shutting down the VM. When you have many smaller VMs, it's more likely you have some VMs without active users. You can safely shut down these unused VMs to conserve resources, either manually or automatically by using autoscale in Azure Virtual Desktop. Conserving resources makes your deployment more resilient, easier to maintain, and less expensive.

## Related content

- [Use performance counters to diagnose app performance problems on Remote Desktop Session Hosts](rds-rdsh-performance-counters.md).
