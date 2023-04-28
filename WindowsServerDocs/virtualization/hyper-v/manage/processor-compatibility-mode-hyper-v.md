---
title: Processor compatibility mode in Hyper-V
description: Describes how to use processor compatibility mode to move a running virtual machine or save state between virtualization hosts that use different generations of processors.
ms.topic: how-to
author: khdownie
ms.author: wscontent
ms.date: 10/06/2021
---

# Processor compatibility mode in Hyper-V

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Hyper-V Server 2019, Hyper-V Server 2016, Hyper-V Server 2012 R2

Hyper-V offers processor compatibility mode, a feature that was first introduced in Windows Server 2008 R2. Processor compatibility mode allows you to move a running virtual machine (VM) or save state between virtualization hosts that use different generations of processors. This feature works by disabling many modern processor features, which can affect VM performance. This document provides details about processor compatibility mode for Hyper-V.

## When to use processor compatibility mode

Processor compatibility mode is applicable to any VM mobility scenario that does not involve rebooting the VM. These include VM live migration, save and restore, and production checkpoints.

VMs cannot be live migrated or saved and restored across virtualization hosts that use processors from different CPU manufacturers. For example, you cannot move running VMs or VM saved state from a host with Intel processors to a host with AMD processors. If you must move a VM in this case, the VM must first be shut down, then restarted on the new host.

If you plan to move VMs without rebooting them, between virtualization hosts that may use different generations of processors, you should enable processor compatibility mode. For example, you would enable processor compatibility mode to ensure that you can live migrate your VMs between cluster nodes that use different processor feature sets. You could also use processor compatibility mode to save a VM and restore it on a host computer that has a different processor feature set than the source host.

## Why processor compatibility mode is needed

Instruction set architecture (ISA) extensions are optimizations and features that are introduced by processor manufacturers. These features often improve performance or security by using specialized hardware for a particular task. For example, many media applications make use of processor features to speed up vector calculations. These features are rarely required for applications to run; they simply boost performance.

The feature set that is available on a processor varies depending on its make, model, and age. Operating systems and application software typically enumerate the system’s processor feature set and capabilities when they are first launched. Software doesn’t expect the available processor features to change during their lifetime—and this could never happen when running on a physical computer because processor features are static.

However, VM mobility features allow a running VM to be migrated to a new virtualization host. If software in the VM has detected and started using a particular processor feature, and it gets moved to a new virtualization host that lacks that capability, the software is likely to fail. This could result in the VM crashing.

To avoid these failures, Hyper-V performs “pre-flight” checks whenever a VM live migration or save/restore operation is initiated. These checks compare the set of processor features that are available to the VM on the source host against the set of features that are available on the target host. If these feature sets don’t match, the migration or restore operation is canceled.

## How processor compatibility mode works

Processor compatibility mode ensures that the set of processor features available to VMs across a disparate set of virtualization hosts will match by presenting only a limited set of processor features to the VM. Processor compatibility mode hides newer processor instructions sets, typically those introduced within the last 10 years. However, hiding these features means that the guest operating system and application software cannot take advantage of these processor instruction set enhancements.

For a complete list of features that are hidden for processor compatibility mode, refer to section 5.2.11 in the [Hypervisor Top-Level Functional Specification](/virtualization/hyper-v-on-windows/tlfs/tlfs).

:::image type="content" source="media/how-processor-compatibility-mode-works.jpg" alt-text="Processor compatibility mode hides newer processor instructions sets for smooth VM migrations between host servers":::

## Ramifications of using processor compatibility mode

It is difficult to quantify the overall performance effects of processor compatibility mode. The performance loss is primarily dependent on the workload running in the VM. Some workloads will be unaffected, while others will show a noticeable difference. Software that heavily relies on hardware optimizations (such as encryption, compression, or intensive floating-point calculations) will be impacted the most.

The following example describes how AES encryption is affected by using processor compatibility mode, and there are many more. If you are concerned about the performance impact of processor compatibility mode, it is best to compare VM workload performance with processor compatibility mode enabled and with it disabled.

### Example: AES encryption

One example of an operation that is impacted by processor compatibility mode is AES encryption (a common form of encryption). Many new Intel and AMD processors include an ISA extension that accelerates AES by using hardware. Intel claims this optimization provides a 2-3 fold performance gain, with some implementations providing a 10-fold gain. (For more information, see [Intel Advanced Encryption Standard Instructions](https://software.intel.com/articles/intel-advanced-encryption-standard-instructions-aes-ni/).)

Applications that encrypt or decrypt a large amount of data benefit from this processor feature, so turning it off by enabling processor compatibility mode will impact the performance of these specific operations.

## Using processor compatibility mode

There are important concepts to understand when using processor compatibility mode in Hyper-V:

  - Running VMs can only be migrated between virtualization hosts that use processors from the same manufacturer.

  - You must shut down the VM before you can enable or disable processor compatibility mode.

  - Processor compatibility mode isn't needed for VM moves that involve a stop and restart of the VM.

  - Anytime a VM is restarted, the guest operating system will enumerate the processor features that are available on the new host computer.

   > [!NOTE]
   > In Windows Server, Microsoft recommends turning on processor compatibility mode only before VM migration scenarios, and then turning it off when the migration is complete.

## Enable processor compatibility mode using Hyper-V Manager

To enable processor compatibility mode for a VM using Hyper-V Manager:

1. Shut down the VM.  

2. Click **Start**, point to **Administrative Tools**, and then click **Hyper-V Manager**.

3.  Select the server running Hyper-V and the desired VM.

4.  If the VM is running, you must shut down the VM to enable the processor compatibility mode setting.

5.  In the Action pane, click **Settings**, and then click **Processor**.

6.  Expand **Processor**, and click **Compatibility**.

7.  Select **Migrate to a physical computer with a different processor**, and then click **OK**.

8. Restart the VM.

## Disable processor compatibility mode using Hyper-V Manager

To disable processor compatibility mode for a VM using Hyper-V Manager:

1. Shut down the VM.  

2. Click **Start**, point to **Administrative Tools**, and then click **Hyper-V Manager**.

3.  Select the server running Hyper-V and the desired VM.

4.  If the VM is running, you must shut down the VM to disable the processor compatibility mode setting.

5.  In the Action pane, click **Settings**, and then click **Processor**.

6.  Expand **Processor**, and click **Compatibility**.

7.  De-select the **Migrate to a physical computer with a different processor** checkbox, and then click **OK**.

8. Restart the VM.

## Enable processor compatibility mode using PowerShell

To enable processor compatibility mode for a VM using PowerShell, shut down the VM and run the `Set-VMProcessor` cmdlet, setting `CompatibilityForMigrationEnabled` to **$true**:

```PowerShell
get-vm -name <name of VM> -ComputerName <target cluster or host> | Set-VMProcessor -CompatibilityForMigrationEnabled $true
```

Then restart the VM.

   > [!WARNING]
   > You may see additional parameters for `Set-VMProcessor` that are intended for use with Azure Stack HCI. Do not attempt to use these with Windows Server, or you will get an error message. The default and only `CompatibilityForMigrationMode` available for Windows Server is `MinimumFeatureSet`. [Learn about dynamic CPU compatibility mode in Azure Stack HCI](/azure-stack/hci/manage/processor-compatibility-mode).

## Disable processor compatibility mode using PowerShell

To disable processor compatibility mode for a VM using PowerShell, shut down the VM and run the `Set-VMProcessor` cmdlet, setting `CompatibilityForMigrationEnabled` to **$false**:

```PowerShell
get-vm -name <name of VM> -ComputerName <target cluster or host> | Set-VMProcessor -CompatibilityForMigrationEnabled $false
```

Then restart the VM.

## Next steps

See also:

- [Dynamic processor compatibility mode in Azure Stack HCI](/azure-stack/hci/manage/processor-compatibility-mode)