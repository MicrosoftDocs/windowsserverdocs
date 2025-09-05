---
title: Fail over a virtual machine with Hyper-V Replica
description: Learn how to fail over a replicated virtual machine between Hyper-V hosts using Hyper-V Replica.
ms.topic: how-to
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 11/10/2025
---

# Fail over a replicated virtual machine with Hyper-V Replica

After you enable Hyper-V Replica and replicate a virtual machine (VM), you can perform failover operations to switch the VM to the replica host or cluster. This article explains how to perform different types of failover operations by using Hyper-V Replica with Hyper-V Manager, Failover Cluster Manager, PowerShell, or Windows Admin Center - Virtualization mode.

For more information about Hyper-V Replica, or if you need to enable replication or replicate a VM, see the following articles:

- [Hyper-V Replica overview](replication-overview.md)
- [Enable Hyper-V Replica on a single host](configure-replication-single-host.md)
- [Enable Hyper-V Replica on a failover cluster](configure-replication-failover-cluster.md)
- [Replicate a virtual machine with Hyper-V Replica](replication-virtual-machines.md)

## Failover scenarios

Hyper-V Replica supports the following three failover scenarios.

- **Test failover**: creates a test VM on the replica host or cluster without affecting the ongoing replication. It enables you to verify that the replica VM is functioning correctly. After testing, you can stop the test failover to remove the test VM.

   By default, the test VM is created from the latest recovery point and isn't connected to a network. If you configured extra recovery points, you can choose to create the test VM from one of those points. You can only run one test failover on a VM at a time.

- **Planned failover**: use when you can gracefully shut down the primary VM. It helps you to perform an end-to-end validation of your recovery plan. It ensures that all changes are replicated to the replica before switching over, resulting in zero data loss. After the planned failover, you can optionally reverse replication back to the original primary host or cluster, then fail back the VM to the original location.

   Planned failover isn't a substitute for high availability, but it can enable you to keep your workloads running with minimal downtime without data loss. It can be useful for events such as planned maintenance of an entire site or datacenter.

- **Unplanned failover**: use when the primary VM is unavailable due to a failure, such as a power outage. It enables you to switch to the replica VM by using the latest recovery point or previous recovery points, if configured. After the unplanned failover, you can complete the failover process and optionally reverse replication back to the original primary host or cluster, then fail back the VM to the original location.

   Unplanned failover is designed for disaster recovery scenarios where the primary VM can't be gracefully shut down. It might result in some data loss, depending on the recovery point selected.

## Prerequisites

Before you begin, make sure you meet the following prerequisites:

- You have a VM that you're replicating by using Hyper-V Replica.

- The VM's replication health state is **Normal**. To check the replication health, see [Monitor replication progress](replication-virtual-machines.md#monitor-replication-progress).

- A user account that's a member of the **Hyper-V Administrators** security group on each host. In an Active Directory domain, you can add users or groups to this group by using Group Policy Preferences. Alternatively, the account can be a local administrator on each host. For more information about the Hyper-V Administrators group, see [Active Directory Security Groups](../../identity/ad-ds/manage/understand-security-groups.md#hyper-v-administrators).

## Fail over a virtual machine

You need to run a failover operation for each VM. You can only run one failover operation at a time for a VM. You can run each failover operation by using the following combinations:

- Hyper-V Manager on clusters or single hosts
- Failover Cluster Manager on clusters
- PowerShell on clusters or single hosts
- Windows Admin Center - Virtualization mode on single hosts only. You can only fail over by using Windows Admin Center - Virtualization mode from the primary host to the replica host. You can't perform a test failover or reverse replication at this time.

Select the relevant tab for instructions.

### [Hyper-V Manager](#tab/hyper-v-manager)

Failing over a virtual machine by using Hyper-V Manager depends on the type of failover you want to perform.

### Test failover by using Hyper-V Manager

To run a test failover by using Hyper-V Manager, follow these steps:

1. Open **Hyper-V Manager** on a device you use to manage a host in the **replica** cluster or a **replica** single host with the VM, or on the host itself where Windows Server with Desktop Experience is installed.

1. In the resources pane, select the host that contains the replica VM for which you want to run a test failover.

1. Right-click the VM, select **Replication**, then select **Test Failover**.

1. In the **Test Failover** screen, select the recovery point you want to use for the test failover from the drop-down list, then select **Test Failover**.

   :::image type="content" source="media/replication-failover/test-failover-recovery-point.png" alt-text="A screenshot of the Test Failover dialog showing the recovery point selection list in Hyper-V Manager." lightbox="media/replication-failover/test-failover-recovery-point.png":::

1. The host creates a duplicate VM. The VM name is the original VM name with ` - Test` appended. The duplicate VM isn't connected to a network by default. At this point, you can start the VM and perform tests that you require to verify that it functions correctly.

1. When you finish testing, right-click the replica VM (not the test duplicate), select **Replication**, then select **Stop Test Failover**. In the confirmation dialog, select **Stop Test Failover** to delete the test VM and discard its data.

### Planned failover using Hyper-V Manager

To run a planned failover using Hyper-V Manager:

1. Open **Hyper-V Manager** on a device you use to manage a host in the **primary** cluster or a **primary** single host with the VM, or on the host itself where Windows Server with Desktop Experience is installed.

1. In the resources pane, select the host that contains the VM for which you want to run a planned failover.

1. Shut down the VM if it's running. You must shut down the VM to perform a planned failover.

1. Right-click the VM, select **Replication**, then select **Planned Failover**.

1. In the **Planned Failover** screen, check the box to **Reverse the replication direction after failover** and optionally check the box to **Start the Replica virtual machine after failover**, depending on your requirements. The dialog shows a list of the prerequisite checks and actions the planned failover does. By default, the replica VM starts after failover. Don't forget to attach the VM to a network if necessary.

   :::image type="content" source="media/replication-failover/planned-failover-prerequisites-actions-check.png" alt-text="A screenshot of the Planned Failover dialog displaying prerequisite checks, actions, and options to reverse replication and start the replica VM in Hyper-V Manager." lightbox="media/replication-failover/planned-failover-prerequisites-actions-check.png":::

1. Select **Fail Over** to begin the process.

   :::image type="content" source="media/replication-failover/planned-failover-prerequisites-actions-success.png" alt-text="A screenshot confirming successful prerequisite checks and actions in the Planned Failover dialog in Hyper-V Manager." lightbox="media/replication-failover/planned-failover-prerequisites-actions-success.png":::

   At this point, failover is complete. If you selected the option to reverse the replication direction, replication is automatically reconfigured to replicate changes back to the original primary host or cluster. Alternatively, right-click the replica VM, select **Replication**, then select **Reverse Replication** to manually configure replication back to the original primary host or cluster. Once reverse replication is configured, the replication health returns to **Normal**.

1. Start the VM if it isn't already running by right-clicking the VM, then selecting **Start**. Remember to attach the VM to a network if necessary.

### Unplanned failover using Hyper-V Manager

To run an unplanned failover using Hyper-V Manager:

1. Open **Hyper-V Manager** on a device you use to manage a host in the **replica** cluster or a **replica** single host with the VM, or on the host itself where Windows Server with Desktop Experience is installed.

1. In the resources pane, select the host that contains the replica VM for which you want to run an unplanned failover.

1. Right-click the replica VM, select **Replication**, then select **Failover**.

1. In the **Failover** screen, select the recovery point you want to use for the failover from the drop-down list, then select **Fail Over**.

   :::image type="content" source="media/replication-failover/unplanned-failover-recovery-point.png" alt-text="A screenshot of the Failover dialog showing available recovery points for an unplanned failover in Hyper-V Manager." lightbox="media/replication-failover/unplanned-failover-recovery-point.png":::

1. The process creates a checkpoint for the replica VM and then starts the VM. You should perform tests that you require to verify that the recovery point you chose functions correctly. Don't forget to attach the VM to a network if necessary.

   If you need to select a different recovery point, you can cancel the failover by right-clicking the replica VM, select **Replication**, then select **Cancel Failover**. Then you can choose a different recovery point.

1. Once you test the VM and don't need to revert to a different recovery point, you need to complete the failover. Right-click the replica VM, select **Replication**, then select **Remove Recovery Points**. This action removes the recovery points and merges the checkpoint, which means you can't revert to an earlier recovery point. If you want to keep extra recovery points, you can first export the replica VM before completing failover.

   :::image type="content" source="media/replication-failover/unplanned-failover-remove-recovery-points.png" alt-text="A screenshot of the context menu option to remove recovery points after an unplanned failover in Hyper-V Manager." lightbox="media/replication-failover/unplanned-failover-remove-recovery-points.png":::

   At this point failover is complete, however the replication health shows as **Warning** because that replication direction isn't configured.

#### Reverse replication after unplanned failover using Hyper-V Manager

Once the primary VM is available again, you should replicate the changes made to the **replica** VM back to the original **primary** VM. The process is called **Reverse replication**. Before you can reverse the replication, you need to mark the original **primary** VM as able to be a target to receive replication. You can't perform this action in Hyper-V Manager.

1. On the original **primary** host that contains the original **primary** VM, open a PowerShell session as an administrator, or connect remotely using the [Enter-PSSession](/powershell/module/microsoft.powershell.core/enter-pssession) cmdlet on a device you use to manage the host.

1. Mark the original **primary** VM to be a target to receive replication by running the following command. Be sure to replace placeholder `<VMName>` with the name of the original primary VM.

   ```powershell
   Set-VMReplication -VMName '<VM Name>' -AsReplica
   ```

1. Check the status of the original primary VM by running the following command on the primary host:

   ```powershell
   Get-VMReplication -VMName '<VM Name>' | FL VMName, ReplicationMode, ReplicationState
   ```

   Here's an example of the output, which shows that the primary VM is now configured as a replica and is waiting for replication:

   ```output
   VMName           : contoso-vm-01
   ReplicationMode  : Replica
   ReplicationState : WaitingForInitialReplication
   ```

1. On the **replica** host that contains the **replica** VM, in Hyper-V Manager right-click the replica VM, select **Replication**, then select **Reverse Replication**. In the **Reverse Replication** screen, if you see **Before You Begin**, select **Next**.

1. The options in the wizard are prepopulated based on the settings of the original primary VM. If you don't need to change any settings, select **Next** on each screen until you reach the **Summary** screen, then select **Finish** to begin the reverse replication. Alternatively the options are the same as when you initially enabled replication for the VM.

   :::image type="content" source="media/replication-failover/unplanned-failover-reverse-replication.png" alt-text="A screenshot of the Reverse Replication wizard summary page before starting reverse replication in Hyper-V Manager." lightbox="media/replication-failover/unplanned-failover-reverse-replication.png":::

   At this point, any changes are replicated and the replication health returns to **Normal**. The primary and replica roles have now swapped. To return to the original replication direction, you can perform a planned failover, as described in the [Planned failover](#planned-failover-using-hyper-v-manager) section.

### [Failover Cluster Manager](#tab/failover-cluster-manager)

Failing over a virtual machine by using Failover Cluster Manager depends on the type of failover you want to perform.

### Test failover by using Failover Cluster Manager

To run a test failover by using Failover Cluster Manager:

1. Open **Failover Cluster Manager** on a device you use to manage the **replica** cluster with the VM, or on one of the hosts in the cluster where Windows Server with Desktop Experience is installed.

1. In the resources pane, expand the name of your cluster that contains the replica VM for which you want to run a test failover, then select **Roles**.

1. Right-click the replica VM, select **Replication**, then select **Test Failover**.

1. In the **Test Failover** screen, select the recovery point you want to use for the test failover from the drop-down list, then select **Test Failover**.

   :::image type="content" source="media/replication-failover/test-failover-recovery-point.png" alt-text="A screenshot of the Test Failover dialog showing the recovery point selection list in Failover Cluster Manager." lightbox="media/replication-failover/test-failover-recovery-point.png":::

1. A duplicate VM is created on the cluster. The VM is named with the original VM name appended with ` - Test`. The duplicate VM isn't connected to a network by default. At this point, you can start the VM and perform tests that you require to verify that it functions correctly.

1. When you finish testing, right-click the replica VM (not the test duplicate), select **Replication**, then select **Stop Test Failover**. In the confirmation dialog, select **Stop Test Failover** to delete the test VM and discard its data.

### Planned failover using Failover Cluster Manager

To run a planned failover using Failover Cluster Manager, follow these steps:

1. Open **Failover Cluster Manager** on a device you use to manage the **primary** cluster with the VM, or on one of the hosts in the cluster where Windows Server with Desktop Experience is installed.

1. In the resources pane, expand the name of your cluster that contains the VM for which you want to run a planned failover, then select **Roles**.

1. Shut down the VM if it's running. You must shut down the VM to perform a planned failover.

1. Right-click the VM, select **Replication**, then select **Planned Failover**.

1. In the **Planned Failover** screen, check the box to **Reverse the replication direction after failover** and optionally check the box to **Start the Replica virtual machine after failover**, depending on your requirements. The dialog shows a list of the prerequisite checks and actions the planned failover does. By default, the replica VM starts after failover. Don't forget to attach the VM to a network if necessary.

   :::image type="content" source="media/replication-failover/planned-failover-prerequisites-actions-check.png" alt-text="A screenshot of the Planned Failover dialog displaying prerequisite checks, actions, and options to reverse replication and start the replica VM in Failover Cluster Manager." lightbox="media/replication-failover/planned-failover-prerequisites-actions-check.png":::

1. Select **Fail Over** to begin the process.

   :::image type="content" source="media/replication-failover/planned-failover-prerequisites-actions-success.png" alt-text="A screenshot confirming successful prerequisite checks and actions in the Planned Failover dialog in Failover Cluster Manager." lightbox="media/replication-failover/planned-failover-prerequisites-actions-success.png":::

   At this point, failover is complete. If you selected the option to reverse the replication direction, replication is automatically reconfigured to replicate changes back to the original primary host or cluster. Alternatively, right-click the replica VM, select **Replication**, then select **Reverse Replication** to manually configure replication back to the original primary host or cluster. Once reverse replication is configured, the replication health returns to **Normal**.

1. Start the VM if it isn't already running by right-clicking the VM, then selecting **Start**. Remember to attach the VM to a network if necessary.

### Unplanned failover using Failover Cluster Manager

To run an unplanned failover using Failover Cluster Manager, follow these steps:

1. Open **Failover Cluster Manager** on a device you use to manage the **replica** cluster with the VM, or on one of the hosts in the cluster where Windows Server with Desktop Experience is installed.

1. In the resources pane, expand the name of your cluster that contains the replica VM for which you want to run an unplanned failover, then select **Roles**.

1. Right-click the replica VM, select **Replication**, then select **Failover**.

1. In the **Failover** screen, select the recovery point you want to use for the failover from the drop-down list, then select **Fail Over**.

   :::image type="content" source="media/replication-failover/unplanned-failover-recovery-point.png" alt-text="A screenshot of the Failover dialog showing available recovery points for an unplanned failover in Failover Cluster Manager." lightbox="media/replication-failover/unplanned-failover-recovery-point.png":::

1. The process creates a checkpoint for the replica VM and then starts the VM. You should perform tests that you require to verify that the recovery point you chose functions correctly. Don't forget to attach the VM to a network if necessary.

   If you need to select a different recovery point, you can cancel the failover by right-clicking the replica VM, select **Replication**, then select **Cancel Failover**. Then you can choose a different recovery point.

1. Once you test the VM and don't need to revert to a different recovery point, you need to complete the failover. Right-click the replica VM, select **Replication**, then select **Remove Recovery Points**. This action removes the recovery points and merges the checkpoint, which means you can't revert to an earlier recovery point. If you want to keep extra recovery points, you can first export the replica VM before completing failover.

   :::image type="content" source="media/replication-failover/unplanned-failover-remove-recovery-points.png" alt-text="A screenshot of the context menu option to remove recovery points after an unplanned failover in Failover Cluster Manager." lightbox="media/replication-failover/unplanned-failover-remove-recovery-points.png":::

    At this point failover is complete, however the replication health shows as **Warning** because that replication direction isn't configured.

#### Reverse replication after unplanned failover using Failover Cluster Manager

   Once the primary VM is available again, you should replicate the changes made to the **replica** VM back to the original **primary** VM. The process is called **Reverse replication**. Before you can reverse the replication, you need to mark the original **primary** VM as able to be a target to receive replication. You can't perform this action in Failover Cluster Manager.

1. On the original **primary** host that contains the original **primary** VM, open a PowerShell session as an administrator, or connect remotely using the [Enter-PSSession](/powershell/module/microsoft.powershell.core/enter-pssession) cmdlet on a device you use to manage the host.

1. Mark the original **primary** VM to be a target to receive replication by running the following command. Be sure to replace placeholder `<VMName>` with the name of the original primary VM.

   ```powershell
   Set-VMReplication -VMName '<VM Name>' -AsReplica
   ```

1. Check the status of the original primary VM by running the following command on the primary host:

   ```powershell
   Get-VMReplication -VMName '<VM Name>' | FL VMName, ReplicationMode, ReplicationState
   ```

   Here's an example of the output, which shows that the primary VM is now configured as a replica and is waiting for replication:

   ```output
   VMName           : contoso-vm-01
   ReplicationMode  : Replica
   ReplicationState : WaitingForInitialReplication
   ```

1. On the **replica** host that contains the **replica** VM, in Failover Cluster Manager right-click the replica VM, select **Replication**, then select **Reverse Replication**. In the **Reverse Replication** screen, if you see **Before You Begin**, select **Next**.

1. The options in the wizard are prepopulated based on the settings of the original primary VM. If you don't need to change any settings, select **Next** on each screen until you reach the **Summary** screen, then select **Finish** to begin the reverse replication. Alternatively the options are the same as when you initially enabled replication for the VM.

   :::image type="content" source="media/replication-failover/unplanned-failover-reverse-replication.png" alt-text="A screenshot of the Reverse Replication wizard summary page before starting reverse replication in Failover Cluster Manager." lightbox="media/replication-failover/unplanned-failover-reverse-replication.png":::

   At this point, any changes are replicated and the replication health returns to **Normal**. The roles of the replica VM and the primary VM have now swapped. To return to the original replication direction, you can perform a planned failover, as described in the [Planned failover](#planned-failover-using-failover-cluster-manager) section.

### [PowerShell](#tab/powershell)

Failing over a virtual machine by using PowerShell depends on the type of failover you want to perform. You can use cmdlets in the [Hyper-V](/powershell/module/hyper-v/) module, as shown in the following examples. Be sure to replace placeholder `<values>` with your own.

### Test failover by using PowerShell

To run a test failover by using PowerShell:

1. Open a PowerShell session as an administrator on the host in the **replica** cluster or the **replica** single host with the VM, or connect remotely by using the [Enter-PSSession](/powershell/module/microsoft.powershell.core/enter-pssession) cmdlet on a device you use to manage the cluster or host.

1. Initiate a test failover by running the following command. Confirm the action when prompted. By default, the latest recovery point is used. To use a different recovery point, you can combine `Get-VMSnapshot` and pipe it to the `Start-VMFailover` cmdlet. For an example, see [Start-VMFailover](/powershell/module/hyper-v/start-vmfailover).

   ```powershell
   Start-VMFailover -VMName '<VM Name>' -AsTest
   ```

1. A duplicate VM is created on the host. The VM is named with the original VM name appended with ` - Test`. The duplicate VM isn't connected to a network by default. At this point, you can start the VM and perform tests that you require to verify that it functions correctly. Run the following command to start the test VM:

   ```powershell
   Start-VM -Name '<VM Name> - Test'
   ```

1. After you finish testing, run the following command to stop the test failover. Stopping the test failover deletes the test VM and discards its data.

   ```powershell
   Stop-VMFailover -VMName '<VM Name>'
   ```

### Planned failover using PowerShell

To run a planned failover using PowerShell:

1. Open a PowerShell session as an administrator on the host in the **primary** cluster or the **primary** single host with the VM, or connect remotely by using the [Enter-PSSession](/powershell/module/microsoft.powershell.core/enter-pssession) cmdlet on a device you use to manage the cluster or host.

1. Shut down the VM if it's running. You must shut down the VM to perform a planned failover.

   ```powershell
   Stop-VM -Name '<VM Name>'
   ```

1. Prepare the VM for failover by running the following command, which replicates any pending changes.

   ```powershell
   Start-VMFailover -VMName '<VM Name>' -Prepare
   ```

1. Open a PowerShell session as an administrator on the host in the **replica** cluster or the **replica** single host with the VM, or connect remotely by using the [Enter-PSSession](/powershell/module/microsoft.powershell.core/enter-pssession) cmdlet on a device you use to manage the cluster or host.

1. Initiate the planned failover by running the following command. Confirm the action when prompted. The latest recovery point is used by default. To use a different recovery point, you can combine `Get-VMSnapshot` and pipe it to the `Start-VMFailover` cmdlet. For an example, see [Start-VMFailover](/powershell/module/hyper-v/start-vmfailover).

   ```powershell
   Start-VMFailover -VMName '<VM Name>'
   ```

1. Reverse the replication direction to complete the planned failover by running the following command. Reverse replication uses the same settings as when you initially enabled replication for the VM.

   ```powershell
   Set-VMReplication -VMName '<VMName>' -Reverse
   ```

1. At this point, any changes are replicated and the replication health returns to **Normal**. Start the VM by running the following command and perform tests that you require to verify that the recovery point you chose functions correctly. Don't forget to attach the VM to a network if necessary.

   ```powershell
   Start-VM -Name '<VM Name>'
   ```

### Unplanned failover using PowerShell

To run an unplanned failover using PowerShell:

1. Open a PowerShell session as an administrator on the host in the **replica** cluster or the **replica** single host with the VM, or connect remotely by using the [Enter-PSSession](/powershell/module/microsoft.powershell.core/enter-pssession) cmdlet on a device you use to manage the cluster or host.

1. Initiate an unplanned failover by running the following command. Confirm the action when prompted. The latest recovery point is used by default. To use a different recovery point, you can combine `Get-VMSnapshot` and pipe it to the `Start-VMFailover` cmdlet. For an example, see [Start-VMFailover](/powershell/module/hyper-v/start-vmfailover).

   ```powershell
    Start-VMFailover -VMName '<VM Name>'
    ```

1. The process creates a checkpoint for the replica VM, but doesn't start the VM. You should start the VM by running the following command and perform tests that you require to verify that the recovery point you chose functions correctly. Don't forget to attach the VM to a network if necessary.

   ```powershell
   Start-VM -Name '<VM Name>'
   ```

1. Once you test the VM and don't need to revert to a different recovery point, you need to complete the failover. Run the following command and confirm the action when prompted. This action removes the recovery points and merges the checkpoint, which means you can't revert to an earlier recovery point. If you want to keep extra recovery points, you can first export the replica VM before completing failover. At this point failover is complete, however the replication health shows as **Warning** because that replication direction isn't configured.

   ```powershell
   Complete-VMFailover -VMName '<VM Name>'
   ```

1. Check that failover of the replica VM is complete by running the following command:

   ```powershell
   Get-VMReplication -VMName '<VM Name>' | FL VMName, ReplicationMode, ReplicationState
   ```

   Here's an example of the output, which shows that the replica VM is now in a failed over state:

   ```output
   VMName           : contoso-vm-01
   ReplicationMode  : Replica
   ReplicationState : FailedOver
   ```

#### Reverse replication after unplanned failover using PowerShell

Once the primary VM is available again, you should replicate the changes made to the **replica** VM back to the original **primary** VM. The process is called **Reverse replication**. Before you can reverse the replication, you need to mark the original **primary** VM as able to be a target to receive replication.

1. On the original **primary** host that contains the original **primary** VM, open a PowerShell session as an administrator, or connect remotely using the [Enter-PSSession](/powershell/module/microsoft.powershell.core/enter-pssession) cmdlet on a device you use to manage the host.

1. Mark the original **primary** VM to be a target to receive replication by running the following command:

   ```powershell
   Set-VMReplication -VMName '<VM Name>' -AsReplica
   ```

1. Check the status of the original primary VM by running the following command on the primary host:

   ```powershell
   Get-VMReplication -VMName '<VM Name>' | FL VMName, ReplicationMode, ReplicationState
   ```

   Here's an example of the output, which shows that the primary VM is now configured as a replica and is waiting for replication:

   ```output
   VMName           : contoso-vm-01
   ReplicationMode  : Replica
   ReplicationState : WaitingForInitialReplication
   ```

1. On the **replica** host that contains the **replica** VM, reverse the replication by running the following command. Reverse replication uses the same settings as when you initially enabled replication for the VM. If you want to change any settings, pass the relevant parameters to the cmdlet. For more information, see [Set-VMReplication](/powershell/module/hyper-v/set-vmreplication).

   ```powershell
   Set-VMReplication -VMName '<VMName>' -Reverse -ReplicaServerName '<Replica cluster broker or server FQDN>'
   ```

1. Start replication by running the following command:

   ```powershell
   Start-VMInitialReplication -VMName '<VM Name>'
   ```

1. At this point, any changes are replicated and the replication health returns to **Normal**. Check the status of the replica VM by running the following command:

   ```powershell
   Get-VMReplication -VMName '<VM Name>' | FL VMName, ReplicationMode, ReplicationState
   ```

   Here's an example of the output, which shows that the replica VM is now configured as a primary and is replicating changes:

   ```output
   VMName           : contoso-vm-01
   ReplicationMode  : Primary
   ReplicationState : Replicating
   ```

   The roles of the replica VM and the primary VM have now swapped. To return to the original replication direction, you can perform a planned failover, as described in the [Planned failover](#planned-failover-using-powershell) section.

### [Windows Admin Center](#tab/windows-admin-center)

> [!IMPORTANT]
> Configuring Hyper-V Replica using *Windows Admin Center - Virtualization mode* is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.
>
> During the preview, you can configure Hyper-V Replica by using Windows Admin Center - Virtualization mode for the following scenarios:
>
> - Configuring a single host as a replica server and configuring replication for VMs from a single host to another single host. Failover clusters aren't supported at this time.
> - Replication and failover of VMs is from a primary host to a replica host only. Performing a test failover or configuring reverse replication or extended replication isn't supported at this time.
> - Hyper-V hosts must be running Windows Server 2022 or later.
>
> For more information about Windows Admin Center - Virtualization mode, see [Windows Admin Center - Virtualization mode overview](../windows-admin-center/virtualization-mode-overview.md).

Failing over a virtual machine by using Windows Admin Center - Virtualization mode depends on the type of failover you want to perform.

### Planned failover using Windows Admin Center

To run a planned failover using Windows Admin Center - Virtualization mode:

1. Go to your URL for **Windows Admin Center - Virtualization mode** and sign in.

1. In the resources pane, expand the host that contains the **primary** VM you want to perform a planned failover, then select the VM to enter its overview.

1. Shut down the VM if it's running. You must shut down the VM to perform a planned failover.

1. In the **Replication** section, select **Planned Failover**.

   :::image type="content" source="media/replication-failover/windows-admin-center-monitor-replication.png" alt-text="A screenshot of Windows Admin Center - Virtualization mode displaying the VM replication overview panel with current replication state, available recovery points, and action buttons including Planned Failover." lightbox="media/replication-failover/windows-admin-center-monitor-replication.png":::

1. In the pane that opens, review the summary of the planned failover, then select **Fail Over**. The failover process begins and the replication state is **Prepared for planned failover**. If you want to cancel the planned failover at this point, select **Cancel Planned Failover**.

   :::image type="content" source="media/replication-failover/windows-admin-center-planned-replication-checks.png" alt-text="A screenshot of Windows Admin Center - Virtualization mode showing the Planned Failover summary pane with prerequisite checks, replication direction details, and the Fail Over and Cancel Planned Failover controls." lightbox="media/replication-failover/windows-admin-center-planned-replication-checks.png":::

1. In the resources pane, select the host which has the replica VM.

1. From the list of tools for the host, select **Virtual machines**, then select the replica VM to enter its overview.

1. In the **Replication** section, select **Failover**.

   :::image type="content" source="media/replication-failover/windows-admin-center-replication-failover.png" alt-text="A screenshot of Windows Admin Center - Virtualization mode showing the Replication section for a VM with the Planned Failover action highlighted prior to initiating failover." lightbox="media/replication-failover/windows-admin-center-replication-failover.png":::

1. In the pane that opens, check the box whether you want to **Start the Replica virtual machine after failover**, depending on your requirements. By default, the replica VM starts after failover. Don't forget to attach the VM to a network if necessary. Then select **Fail Over** to begin the process. Once the failover is complete, in the **replication** section the replication state changes to **Failover Complete**.

   :::image type="content" source="media/replication-failover/windows-admin-center-replication-failover-checks.png" alt-text="A screenshot of the Planned Failover summary pane in Windows Admin Center listing prerequisite checks, replication direction details, and the Fail Over confirmation button." lightbox="media/replication-failover/windows-admin-center-replication-failover-checks.png":::

1. To complete the planned failover, in the **Replication** section select **Remove Recovery Points**. For the confirmation, select **Yes**. This action removes the recovery points and merges the replica checkpoint. At this point, failover is complete. Reversing the replication direction isn't available at this time.

   :::image type="content" source="media/replication-failover/windows-admin-center-replication-failover-complete.png" alt-text="A screenshot of Windows Admin Center after planned failover completion showing replication state updated and option to reverse replication inactive during preview." lightbox="media/replication-failover/windows-admin-center-replication-failover-complete.png":::

1. Start the VM if it isn't already running. Don't forget to attach the VM to a network if necessary.

### Unplanned failover using Windows Admin Center

To run a test failover using Windows Admin Center - Virtualization mode:

1. Go to your URL for **Windows Admin Center - Virtualization mode** and sign in.

1. In the resources pane, select the host that contains the **replica** VM you want to perform an unplanned failover.

1. From the list of tools for the host, select **Virtual machines**, then select the replica VM to enter its overview.

1. In the **Replication** section, select **Failover**.

   :::image type="content" source="media/replication-failover/windows-admin-center-replication-failover.png" alt-text="A screenshot of Windows Admin Center - Virtualization mode displaying the VM Replication panel with Failover action available for unplanned failover scenario." lightbox="media/replication-failover/windows-admin-center-replication-failover.png":::

1. In the pane that opens, review the summary of the unplanned failover, select a **recovery point to use** from the drop-down list, then select **Fail Over**. The failover process begins.

   :::image type="content" source="media/replication-failover/windows-admin-center-unplanned-recovery-point.png" alt-text="A screenshot of the Failover pane in Windows Admin Center showing the recovery point selection list for an unplanned failover." lightbox="media/replication-failover/windows-admin-center-unplanned-recovery-point.png":::

1. The process creates a checkpoint for the replica VM. You should start the VM and perform tests that you require to verify that the recovery point you chose functions correctly. Don't forget to attach the VM to a network if necessary.

   If you need to select a different recovery point, you can cancel the failover by selecting **Cancel Planned Failover**. Then you can choose a different recovery point.

1. Once you test the VM and don't need to revert to a different recovery point, you need to complete the failover. In the **Replication** section, select **Remove Recovery Points**. This action removes the recovery points and merges the checkpoint, which means you can't revert to an earlier recovery point. If you want to keep extra recovery points, you can first export the replica VM before completing failover.

   :::image type="content" source="media/replication-failover/windows-admin-center-replication-unplanned-failover.png" alt-text="A screenshot of the context menu option to remove recovery points after an unplanned failover in Windows Admin Center." lightbox="media/replication-failover/windows-admin-center-replication-unplanned-failover.png":::

   At this point failover is complete, however the replication health shows as **Warning** because that replication direction isn't configured. Reverse replication using Windows Admin Center - Virtualization mode isn't available at this time. Use [Hyper-V Manager](#reverse-replication-after-unplanned-failover-using-hyper-v-manager) or [PowerShell](#reverse-replication-after-unplanned-failover-using-powershell) to perform reverse replication.

---
