---
title: Configure processor compatibility in Hyper-V virtual machines
description: Learn how to configure processor compatibility mode in Hyper-V, which limits processor features in a virtual machine to enable VM migration between hosts with different processors.
ms.topic: how-to
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 08/06/2025
---

# Configure processor compatibility mode in Hyper-V virtual machines

Processor compatibility mode enables virtual machine migration between hosts with different processor capabilities. It limits the processor features available to a virtual machine (VM) to ensure compatibility when moving VMs between hosts or clusters with different processors.

There are times when you might need to limit the processor capabilities that are passed through, such as when you want to move a live virtual machine (VM) or a saved VM between hosts or clusters with different processor capabilities, or developing applications that need to run on a wide range of hardware. In these cases, you can use processor compatibility mode. We recommend you enable processor compatibility mode only during the migration process, and then disable it to allow the VM to take advantage of the full capabilities of the host's processor. If you have a cluster with different processor generations, you need to leave processor compatibility mode enabled for live migration to work.

Dynamic processor compatibility mode, introduced in Windows Server 2025 for VMs that use configuration version 10.0 or later, enhances the previous version of processor compatibility mode by allowing VMs to use a dynamically calculated set of processor features that are common across all nodes in a cluster. This means that VMs can take advantage of the maximum capabilities available across the cluster while still ensuring compatibility when moving VMs between hosts.

To learn about processor compatibility mode, see [Processor compatibility in Hyper-V virtual machines](processor-compatibility-mode.md).

This article explains how to configure processor compatibility mode for a VM using Hyper-V Manager, PowerShell, or Windows Admin Center.

## Prerequisites

Before you begin, make sure you meet the following prerequisites:

- You have administrative access to the Hyper-V host or cluster where the VM is running and where you want to migrate it to.

- The VM you want to configure processor compatibility mode is powered off. Processor compatibility mode can't be enabled or disabled while the VM is running.

- Dynamic processor compatibility mode was introduced for VMs on a Hyper-V host running Windows Server 2025 or Azure Local (previously Azure Stack HCI) version 21H2 and use configuration version 10.0 or later. If your VM is using an earlier configuration version, upgrade its configuration version, otherwise it uses standard processor compatibility mode.

## Configure a VM to use processor compatibility mode

This section explains how to configure a VM to use processor compatibility mode using Hyper-V manager, PowerShell, or Windows Admin Center. It's possible to run VMs with and without compatibility mode in the same cluster. The two modes of processor compatibility are enabled and disabled the same way. Dynamic processor compatibility mode is transparent to the user and is enabled when the VM is running on a cluster.

Select the relevant tab for the method you want to use.

### [Hyper-V manager](#tab/hyper-v-manager)

To enable or disable processor compatibility mode for a VM using Hyper-V Manager, follow these steps. You can't configure dynamic processor compatibility mode in Hyper-V Manager; use PowerShell or Windows Admin Center instead.

1. Open **Hyper-V Manager**.

1. Select the server running Hyper-V and the desired VM.

1. If the VM is running, you must shut down the VM to change the processor compatibility mode setting.

1. In the **Actions** pane for the VM, select **Settings**.

1. In the **Hardware** pane, select **Processor**. Expand **Processor**, then select **Compatibility**.

1. To enable processor compatibility mode, check the box for **Migrate to a physical computer with a different processor**. To disable it, uncheck the box.

   :::image type="content" source="media/configure-processor-compatibility-mode/hyper-v-manager-processor-compatibility.png" alt-text="Screenshot of Hyper-V Manager VM Settings showing the Processor Compatibility page with the checkbox to migrate to a physical computer with a different processor." lightbox="media/configure-processor-compatibility-mode/hyper-v-manager-processor-compatibility.png":::

1. Select **OK** to save the change, then start the VM.

### [PowerShell](#tab/powershell)

To enable or disable processor compatibility mode for a VM using PowerShell, you can use the [Set-VMProcessor](/powershell/module/hyper-v/set-vmprocessor) cmdlet. The parameter `CompatibilityForMigrationMode` specifies whether to use dynamic processor compatibility mode or standard processor compatibility mode, with the values `CommonClusterFeatureSet` for dynamic mode and `MinimumFeatureSet` for standard mode. Be sure to replace placeholder `<values>` with your own.

1. On the Hyper-V host, open PowerShell as an administrator.

1. If the VM is running, you must shut down the VM to change the processor compatibility mode setting. You can use the following command to shut down the VM:

   ```powershell
   Stop-VM -Name <VMName>
   ```

1. Configure processor compatibility mode for the VM by using one of the following commands.

   - To enable processor compatibility mode with the default value of the minimum feature set for migration, run the following command:

      ```powershell
      Set-VMProcessor -VMName <VMName> -CompatibilityForMigrationEnabled $true
      ```

   - To enable dynamic processor compatibility mode with the maximum common features across all nodes for Hyper-V clusters that support dynamic processor compatibility, run the following command:

      ```powershell
      Set-VMProcessor -VMName <VMName> -CompatibilityForMigrationEnabled $true -CompatibilityForMigrationMode CommonClusterFeatureSet
      ```

   - To enable processor compatibility mode and explicitly set the minimum feature set for migration, run the following command:

      ```powershell
      Set-VMProcessor -VMName <VMName> -CompatibilityForMigrationEnabled $true -CompatibilityForMigrationMode MinimumFeatureSet
      ```

   - To disable processor compatibility mode, run the following command:

      ```powershell
      Set-VMProcessor -VMName <VMName> -CompatibilityForMigrationEnabled $false
      ```

### [Windows Admin Center](#tab/windows-admin-center)

To enable or disable processor compatibility mode using Windows Admin Center:

1. Open Windows Admin Center and connect to your cluster.

1. In the **Tools** pane, select **Virtual machines**.

1. Under **Inventory**, select the VM on which you want to configure processor compatibility, expand the **Power** menu, then select **Shut down**.

1. Select **Settings**, then **Processors**.

1. To enable processor compatibility mode, check the box for **Processor compatibility**. To disable it, uncheck the box.

    :::image type="content" source="media/configure-processor-compatibility-mode/windows-admin-center-processor-compatibility.png" alt-text="Screenshot of the checkbox to enable processor compatibility." lightbox="media/configure-processor-compatibility-mode/windows-admin-center-processor-compatibility.png":::

1. To enable dynamic processor compatibility mode with the maximum common features across all nodes for Hyper-V clusters that support dynamic processor compatibility, select **Compatible across the cluster (Recommended)**. This setting maximizes VM performance while preserving the ability to move the running VM to other servers in the cluster. If disabled, the VM must be restarted to move to a host with a different level of supported CPU instructions, common with different generations of CPUs.

   Alternatively, if you want to set the VM's CPU features to minimum to ensure that you can move the running VM to other Hyper-V hosts outside the cluster as long as they have the same CPU manufacturer, select **Compatible across other hosts with the same CPU manufacturer**.

1. Select **Save processor settings** and restart the VM.

---

## Verify processor features on a Hyper-V host and in a VM

Once you configure processor compatibility mode, you can verify the processor features available on a Hyper-V host and in the VM. This information can be useful if you want to check the VM has the expected set of features available.

To check the processor features on a Hyper-V host and a Windows VM, you can run [Coreinfo from Sysinternals](/sysinternals/downloads/coreinfo):

1. Sign in to the host or the VM and download and extract the [Coreinfo tool](/sysinternals/downloads/coreinfo).

1. Open PowerShell as an administrator and navigate to the directory where you extracted Coreinfo.

1. Run the following command. If it's the first time running Coreinfo on this host, you need to accept the license agreement.

   ```powershell
   .\Coreinfo.exe -f
   ```

   Here's a truncated example of the output you might see, where each line represents a processor feature and an asterisk (*) indicates that the feature is available:

   ```output
   HTT             *       Hyperthreading enabled
   CET             -       Supports Control Flow Enforcement Technology
   Kernel CET      -       Kernel-mode CET Enabled
   User CET        -       User-mode CET Allowed
   HYPERVISOR      *       Hypervisor is present
   VMX             -       Supports Intel hardware-assisted virtualization
   SVM             -       Supports AMD hardware-assisted virtualization
   X64             *       Supports 64-bit mode
   
   SMX             -       Supports Intel trusted execution
   SKINIT          -       Supports AMD SKINIT
   SGX             -       Supports Intel SGX

   ...
   ```

When processor compatibility mode is enabled, you see that some features aren't available (indicated by a dash `-`) when compared to the output from the host. A reduced list indicates that the VM is running in processor compatibility mode and is limited to a common set of features.

If you're using dynamic processor compatibility mode, the features available in the VM are the maximum set of features that are common across all nodes in the cluster.

### Linux VMs

Here's an example of how to check the processor features on a Debian-based or Red Hat-based Linux VM:

1. Sign in to the VM and open a terminal.

1. Run the following command to list the processor features:

   ```bash
   lscpu | grep Flags
   ```

   Here's a truncated example of the output you might see:

   ```output
   Flags:                           fpu vme de pse tsc msr pae mce cx8 apic sep mtrr pge mca cmov 
   pat pse36 clflush mmx fxsr sse sse2 ss ht syscall nx pdpe1gb rdtscp lm constant_tsc rep_good nopl 
   xtopology aperfmperf pni pclmulqdq ssse3 fma cx16 pcid sse4_1 sse4_2 x2apic movbe popcnt 
   tsc_deadline_timer aes xsave avx f16c rdrand hypervisor lahf_lm abm 3dnowprefetch invpcid_single 
   ssbd ibrs ibpb stibp ibrs_enhanced kaiser fsgsbase tsc_adjust bmi1 avx2 smep bmi2 erms invpcid 
   avx512f avx512dq rdseed adx smap clflushopt avx512cd sha_ni avx512bw avx512vl xsaveopt xsavec 
   xgetbv1 xsaves rdpid md_clear flush_l1d arch_capabilities
   ```

When processor compatibility mode is enabled, you see that some features aren't listed when compared to the output from the host. A reduced list indicates that the VM is running in processor compatibility mode and is limited to a common set of features.

If you're using dynamic processor compatibility mode, the features available in the VM are the maximum set of features that are common across all nodes in the cluster.

## Live migration behavior of VMs between separate clusters

Assuming that all servers in each cluster are running the same hardware, it's possible to live migrate running VMs between clusters. There are three common scenarios.

- **Live migrating a VM from a cluster with new processors to a cluster with the same processors.** The VM capabilities are transferred to the destination cluster. This scenario doesn't require processor compatibility mode to be enabled; however, leaving it enabled shouldn't cause any migration issues.

- **Live migrating a VM from a cluster with older processors to a cluster with newer processors.** The VM capabilities are transferred to the destination cluster. In this scenario, when the VM is restarted, it receives the latest calculated capability of the destination cluster.

- **Live migrating a VM from a cluster with newer processors to a cluster with older processors.** You need to set the VM processor to use the `MinimumFeatureSet` for the `CompatibilityForMigrationMode` parameter in PowerShell, or select **Compatible across other hosts with the same CPU manufacturer** in Windows Admin Center. Once the VM is restarted, it receives the latest calculated capability of the destination cluster.
