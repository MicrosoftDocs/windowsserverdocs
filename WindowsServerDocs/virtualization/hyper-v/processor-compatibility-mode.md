---
title: Processor compatibility for Hyper-V virtual machines
description: Learn about processor compatibility mode in Hyper-V, which limits processor features in a virtual machine to enable VM migration between hosts with different processors.
ms.topic: concept-article
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 08/06/2025
---

# Processor compatibility for Hyper-V virtual machines

Hyper-V processor compatibility mode enables virtual machine migration between hosts with different processor capabilities. A Hyper-V host passes through its processor capabilities to the virtual machines running on it, enabling the guest operating system and applications to take advantage of the same processor features as the host.

There are times when you might need to limit the processor capabilities that are passed through, such as when you want to move a live virtual machine (VM) or a saved VM between hosts or clusters with different processor capabilities, or developing applications that need to run on a wide range of hardware. In these cases, you can use processor compatibility mode. We recommend you enable processor compatibility mode only during the migration process, and then disable it to allow the VM to take advantage of the full capabilities of the host's processor.

Processor compatibility mode provides a VM with a common set of processor features. There are two modes of processor compatibility:

- **Dynamic processor compatibility mode**: for Hyper-V hosts in a cluster, it dynamically calculates the common set of processor features across all nodes, enabling VMs to take advantage of the maximum capabilities available across the cluster. Dynamic processor compatibility mode was introduced in Windows Server 2025.

- **Standard processor compatibility mode**: uses a fixed set of processor features, regardless of the capabilities of the host or cluster.

This article describes processor compatibility mode, why it's useful and how it works.

## Why processor compatibility is useful

Processor manufacturers often introduce optimizations and capabilities in their processors. These capabilities often improve performance or security by using specialized hardware for a particular task. For example, many media applications use processor capabilities to speed up vector calculations. These features are rarely required for applications to run; they boost performance.

The capability set that's available on a processor varies depending on its make, model, and age. Operating systems and application software typically enumerate the system's processor capability set when they're first launched. Software doesn't expect the available processor capabilities on a device to change during its lifetime.

However, VM mobility features allow a running VM to be migrated to a new virtualization host. If software in the VM detects and starts using a particular processor capability, and then the VM is moved to a new virtualization host without that capability, the software can fail. Different processor features can result in the application or VM crashing.

To avoid failures, Hyper-V performs initial checks whenever a VM live migration or save/restore operation is initiated. These checks compare the set of processor features that are available to the VM on the source host against the set of features that are available on the target host. If these feature sets don't match, the migration or restore operation is canceled.

You don't need to enable processor compatibility mode if you plan to stop and restart the VMs, as the guest operating system enumerates the processor capabilities available on the new host when the VM is restarted.

## How processor compatibility mode works

Processor compatibility mode isn't enabled by default. You must explicitly enable it for each VM that you want to use it with.

When you enable processor compatibility mode on a VM, it ensures that the set of processor features available across a disparate set of virtualization hosts match by presenting only a limited set of processor features to the virtual machine. Processor compatibility mode hides newer processor instructions sets, typically those processors introduced within the last 10 years. However, hiding these features means that the guest operating system and application software can't take advantage of these processor instruction set enhancements.

:::image type="content" source="media/processor-compatibility-mode/processor-compatibility-vm-migration.png" alt-text="Diagram showing VM migration between Hyper-V hosts with different processor capabilities, illustrating how processor compatibility mode enables successful migration by presenting a common set of processor features.":::

Dynamic processor compatibility mode, introduced in Windows Server 2025 for VMs that use configuration version 10.0 or later, enhances the previous version of processor compatibility mode by enabling VMs to use a dynamically calculated set of processor features that are common across all nodes in a cluster. This means that VMs can take advantage of the maximum capabilities available across the cluster while still ensuring compatibility when moving VMs between hosts.

Each VM receives the maximum number of processor instruction sets that are present across all servers in the cluster. This process occurs automatically and is always enabled and replicated across the cluster, so there's no command to enable or disable the process.

It's difficult to quantify the overall performance effects of processor compatibility mode. The performance loss is primarily dependent on the workload running in the VM. Some workloads might be unaffected, while others show a noticeable difference. Software that heavily relies on hardware optimizations (such as encryption, compression, or intensive floating-point calculations) is impacted the most. If you're concerned about the performance impact of processor compatibility mode, it's best to compare VM workload performance with processor compatibility mode enabled and with it disabled.

Even when processor compatibility is enabled, you can't move VMs between hosts with different processor manufacturers. For example, you can't move running VMs or saved state VMs from a host with Intel processors to a host with AMD processors.

## Next step

Learn how to [Configure a virtual machine to use processor compatibility mode](configure-processor-compatibility-mode.md).
