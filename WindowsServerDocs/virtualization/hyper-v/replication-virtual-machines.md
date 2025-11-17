---
title: Replicate a virtual machine with Hyper-V Replica
description: Learn how to replicate a virtual machine between Hyper-V hosts using Hyper-V Replica.
ms.topic: how-to
ai-usage: ai-assisted
ms.author: daknappe
author: dknappettmsft
ms.date: 11/10/2025
---

# Replicate a virtual machine with Hyper-V Replica

Hyper-V Replica helps you protect your workloads by replicating virtual machines (VMs) between Hyper-V hosts running Windows Server. This article explains how to replicate a virtual machine after you enable replication on the receiving host or cluster by using Hyper-V Manager, Failover Cluster Manager, PowerShell, or Windows Admin Center - Virtualization mode.

You can replicate between clusters, single hosts, or a combination of both. If you use a certificate for authentication, there's no Active Directory dependency between the hosts. Single hosts can either be domain members or be in a workgroup.

For more information about Hyper-V Replica and how it works, see [Hyper-V Replica overview](replication-overview.md). If you need to enable Hyper-V Replica, see:

- [Enable Hyper-V Replica on a failover cluster](configure-replication-failover-cluster.md).
- [Enable Hyper-V Replica on a single host](configure-replication-single-host.md).

## Prerequisites

Before you begin, make sure you meet the following prerequisites:

- You have a Hyper-V cluster to receive the replicated VM on which you already configured Hyper-V Replica. If you need to configure Hyper-V Replica, see [Enable Hyper-V Replica on a failover cluster](configure-replication-failover-cluster.md) or [Enable Hyper-V Replica on a single host](configure-replication-single-host.md). You also have another cluster or single host that runs the VM you want to replicate.

- Sufficient network connectivity and bandwidth between primary and replica sites to meet your Recovery Point Objective (RPO) and initial replication method. Consider dedicating or QoS‑throttling replication traffic to avoid impacting production workloads.

- If you're using certificate-based authentication, you need to have a valid certificate installed on each host in each cluster or single host, both sending and receiving. The certificate must meet the following requirements:
  - Not be expired
  - Have both Client and Server Authentication Enhanced Key Usage (EKU) attributes and an associated private key.
  - Terminate at a valid root certificate.
  - The subject common name (CN) or subject alternative name (SAN) must match the fully qualified domain name (FQDN) of the Hyper-V Replica Broker role you provide for the receiving cluster.

- Adequate storage capacity on the replica site for the VM, including its configuration files, virtual hard disk (VHDX or VHD) files, and optional extra recovery points (snapshots).

- A user account that's a member of the **Hyper-V Administrators** security group on each host. In an Active Directory domain, you can add users or groups to this group by using Group Policy Preferences. Alternatively, the account can be a local administrator on each host. You can find more information about the Hyper-V Administrators group in [Active Directory Security Groups](../../identity/ad-ds/manage/understand-security-groups.md#hyper-v-administrators).

## Replicate a virtual machine

You need to enable replication for each VM you want to replicate. You can replicate a VM using the following combinations:

- Hyper-V Manager on clusters or single hosts.
- Failover Cluster Manager on clusters only.
- PowerShell on clusters or single hosts.
- Windows Admin Center - Virtualization mode on single hosts only.

Select the relevant tab for instructions.

### [Hyper-V Manager](#tab/hyper-v-manager)

To replicate a virtual machine by using Hyper-V Manager:

1. Open **Hyper-V Manager** on a device you use to manage a host in the **primary** cluster or a **primary** single host with the VM, or on the host itself where Windows Server with Desktop Experience is installed.

1. In the resources pane, select the host that contains the VM you want to replicate.

1. Right-click the VM you want to replicate, then select **Enable Replication**. In the **Enable Replication** screen, if you see **Before You Begin**, select **Next**.

1. For **Specify Replica Server**, in the **Replica Server** box, enter either the NetBIOS or FQDN of the Replica server. If the Replica server is part of a failover cluster, enter the name of the Hyper-V Replica Broker. Then select **Next**. The connection to the replica server is verified to retrieve the authentication and port settings you configured for the replica server.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-specify-replica-server.png" alt-text="A screenshot of the Enable Replication wizard showing the Specify Replica Server page with the Replica Server name field." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-specify-replica-server.png":::

1. Review the replica server settings. If you're using certificate-based authentication, select **Select Certificate**, then you're prompted to select the certificate for the primary host that matches the requirements. If you want to compress the data that is transmitted over the network, check the box. Select **Next**.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-specify-connection-parameters.png" alt-text="A screenshot of the connection parameters page showing authentication method, certificate selection, compression option, and port settings." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-specify-connection-parameters.png":::

1. For **Choose Replication VHDs**, make sure the checkboxes for the VHDs you want to replicate are selected, and clear the checkboxes for any VHDs that you want to exclude from replication. Then select **Next**.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-choose-virtual-hard-disks.png" alt-text="A screenshot of the Choose Replication VHDs page listing virtual hard disks with checkboxes to include or exclude from replication." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-choose-virtual-hard-disks.png":::

1. For **Configure Replication Frequency**, specify how often changes should be synchronized from the primary to replica clusters or hosts from **30 seconds**, **5 minutes**, or **15 minutes**. Then select **Next**.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-configure-replication-frequency.png" alt-text="A screenshot of the Configure Replication Frequency page with options for 30 seconds, 5 minutes, or 15 minutes." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-configure-replication-frequency.png":::

1. For **Configure Additional Recovery Points**, select **Maintain only the latest recovery point** or **Create additional hourly recovery points** and the number of extra recovery points you want to create in hours. Then select **Next**.

   When you create extra hourly recovery points, you can also check the box **Volume Shadow Copy Service (VSS) snapshot frequency** if you want recovery points to provide application-consistent recovery points for VMs running VSS-aware applications.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-configure-additional-recovery-points.png" alt-text="A screenshot of the Configure Additional Recovery Points page with options for latest point only, hourly points, and VSS snapshot frequency." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-configure-additional-recovery-points.png":::

1. For **Choose Initial Replication**, select the initial replication method. The total size of the initial copy is displayed. Select an option from the following list, then select **Next**.

   - **Send initial copy over the network**: this method is the default option.
   - **Send initial copy using external media**: specify a folder location on local or external media where the initial copy can be stored.
   - **Use an existing virtual machine on the Replica server as the initial copy**: restore the VM on the replica server and use it as the basis for replication, then replicate only the changes. You can find the process to import the initial copy in the section [Send initial copy using external media](#send-initial-copy-using-external-media).

   If you select **Send initial copy over the network** or **Use an existing virtual machine on the Replica server as the initial copy**, you can optionally specify whether to start replication immediately, or start replication at a specified time and date up to seven days in the future.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-choose-initial-replication-method.png" alt-text="A screenshot of the Choose Initial Replication page showing network transfer, external media, existing VM options, and scheduling settings." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-choose-initial-replication-method.png":::

1. Review the summary information, then select **Finish**.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-summary.png" alt-text="A screenshot of the summary page listing the selected replication settings before finishing the wizard." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-summary.png":::

1. A dialog box appears to indicate that replication was successfully enabled.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-replication-enabled-successfully.png" alt-text="A screenshot showing the Enable Replication success dialog confirming replication is enabled for the virtual machine." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-replication-enabled-successfully.png":::

1. To monitor the initial replication progress, see the section [Monitor replication progress](#monitor-replication-progress). You can change replication settings later if you need to in the **Replication** section of the VM settings.

   If you chose to send the initial copy by using external media, see the section [Send initial copy using external media](#send-initial-copy-using-external-media) for the process to import the initial copy. A placeholder VM is created on the replica site and its replication health state is **Warning**. The replica contents for the VM are stored on your external media in a subfolder for the VM. Once the export is complete, safely eject the external media and transport it to the replica server.

### [Failover Cluster Manager](#tab/failover-cluster-manager)

To replicate a virtual machine by using Failover Cluster Manager:

1. Open **Failover Cluster Manager** on a device you use to manage the **primary** cluster or a **primary** single host with the VM, or on one of the hosts in the cluster where Windows Server with Desktop Experience is installed.

1. In the resources pane, expand the name of the cluster you want to replicate to, then select **Roles**.

1. Right-click the VM you want to replicate, select **Replication**, then select **Enable Replication**. In the **Enable Replication** screen, if you see **Before You Begin**, select **Next**.

1. For **Specify Replica Server**, in the **Replica Server** box, enter either the NetBIOS or FQDN of the Replica server. If the Replica server is part of a failover cluster, enter the name of the Hyper-V Replica Broker. Then select **Next**. The connection to the replica server is verified to retrieve the authentication and port settings you configured for the replica server.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-specify-replica-server.png" alt-text="A screenshot of the Enable Replication wizard showing the Specify Replica Server page with the Replica Server name field." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-specify-replica-server.png":::

1. Review the replica server settings. If you're using certificate-based authentication, select **Select Certificate**, then you're prompted to select the certificate for the primary host that matches the requirements. If you want to compress the data that is transmitted over the network, check the box. Select **Next**.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-specify-connection-parameters.png" alt-text="A screenshot of the connection parameters page showing authentication method, certificate selection, compression option, and port settings." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-specify-connection-parameters.png":::

1. For **Choose Replication VHDs**, make sure the checkboxes for the VHDs you want to replicate are selected, and clear the checkboxes for any VHDs that you want to exclude from replication. Then select **Next**.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-choose-virtual-hard-disks.png" alt-text="A screenshot of the Choose Replication VHDs page listing virtual hard disks with checkboxes to include or exclude from replication." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-choose-virtual-hard-disks.png":::

1. For **Configure Replication Frequency**, specify how often changes should be synchronized from the primary to replica clusters or hosts from **30 seconds**, **5 minutes**, or **15 minutes**. Then select **Next**.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-configure-replication-frequency.png" alt-text="A screenshot of the Configure Replication Frequency page with options for 30 seconds, 5 minutes, or 15 minutes." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-configure-replication-frequency.png":::

1. For **Configure Additional Recovery Points**, select **Maintain only the latest recovery point** or **Create additional hourly recovery points** and the number of extra recovery points you want to create in hours. Then select **Next**.

   When you create extra hourly recovery points, you can also check the box **Volume Shadow Copy Service (VSS) snapshot frequency** if you want recovery points to provide application-consistent recovery points for VMs running VSS-aware applications.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-configure-additional-recovery-points.png" alt-text="A screenshot of the Configure Additional Recovery Points page with options for latest point only, hourly points, and VSS snapshot frequency." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-configure-additional-recovery-points.png":::

1. For **Choose Initial Replication**, select the initial replication method. The total size of the initial copy is displayed. Select an option from the following list, then select **Next**.

   - **Send initial copy over the network**: this method is the default option.
   - **Send initial copy using external media**: select **Browse** and specify a folder location on local or external media where the initial copy can be stored. You can find the process to import the initial copy in the section [Send initial copy using external media](#send-initial-copy-using-external-media).
   - **Use an existing virtual machine on the Replica server as the initial copy**: restore the VM on the replica server and use it as the basis for replication, then replicate only the changes.

   If you select **Send initial copy over the network** or **Use an existing virtual machine on the Replica server as the initial copy**, you can optionally specify whether to start replication immediately, or start replication at a specified time and date up to seven days in the future.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-choose-initial-replication-method.png" alt-text="A screenshot of the Choose Initial Replication page showing network transfer, external media, existing VM options, and scheduling settings." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-choose-initial-replication-method.png":::

1. Review the summary information, then select **Finish**. A dialog box appears to indicate that replication was successfully enabled.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-summary.png" alt-text="A screenshot of the summary page listing the selected replication settings before finishing the wizard." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-summary.png":::

1. To monitor the initial replication progress, see the section [Monitor replication progress](#monitor-replication-progress). You can change replication settings later if you need to in the **Replication** section of the VM settings.

   If you chose to send the initial copy by using external media, see the section [Send initial copy using external media](#send-initial-copy-using-external-media) for the process to import the initial copy. A placeholder VM is created on the replica site and its replication health state is **Warning**. The replica contents for the VM are stored on your external media in a subfolder for the VM. Once the export is complete, safely eject the external media and transport it to the replica server.

### [PowerShell](#tab/powershell)

To replicate a virtual machine by using PowerShell, use the `Enable-VMReplication` cmdlet, which is part of the [Hyper-V](/powershell/module/hyper-v/) module, as shown in the following examples. Be sure to replace placeholder `<values>` with your own. This process works for replicating to either a cluster or a single host.

1. Open a PowerShell session as an administrator on one of the hosts in the **primary** cluster or a **primary** single host with the VM, or connect remotely by using the [Enter-PSSession](/powershell/module/microsoft.powershell.core/enter-pssession) cmdlet on a device you use to manage the cluster or host.

1. Import the Hyper-V module by running the following command:

   ```powershell
   Import-Module Hyper-V
   ```

1. Enable VM replication for a VM by running the following command. This example uses Kerberos authentication over port 80 with default settings of a replication frequency of 5 minutes, and no extra recovery points. For more information about the available parameters, such as for certificate authentication or to exclude specific virtual hard disks, see [Enable-VMReplication](/powershell/module/hyper-v/enable-vmreplication).

   ```powershell
   $parameters = @{
       VMName = '<VM name>'
       ReplicaServerName = '<Replica cluster broker or server FQDN>'
       ReplicaServerPort = '80'
       AuthenticationType = 'Kerberos'
   }

   Enable-VMReplication @parameters
   ```

1. Start VM replication immediately. Here are some examples:

   1. To start replication and send the initial copy over the network immediately, run the following command. You can also specify a scheduled start time of up to seven days using the `InitialReplicationStartTime` parameter.

      ```powershell
      Start-VMInitialReplication -VMName $parameters.VMName
      ```

   1. To send the initial replica by using external media, run the following command, then follow the process in the section [Send initial copy using external media](#send-initial-copy-using-external-media) to learn how to import it to the replica server.

      ```powershell
      Start-VMInitialReplication -VMName $parameters.VMName -DestinationPath '<Path to store initial copy on external media>'
      ```

1. Replication begins. The time it takes to complete depends on the size of the VM. You can check the replication status by running the following command from the primary or replica host. You can change replication settings later if you need to with the [Set-VMReplication](/powershell/module/hyper-v/set-vmreplication) cmdlet.

   ```powershell
   Get-VMReplication -VMName $parameters.VMName
   ```

   The `State` property shows the current state of replication. If you chose to send the initial copy over the network, after the initial replication is complete, the state is `Replicating`, as shown in the following example output:

   ```output
   VMName        State       Health Mode    FrequencySec PrimaryServer ReplicaServer ReplicaPort AuthType Relationship
   ------        -----       ------ ----    ------------ ------------- ------------- ----------- -------- ------------
   contoso-vm-01 Replicating Normal Primary 300          hyperv01      cluster02rep  80          Kerberos Simple
   ```

   If you chose to send the initial copy by using external media, see the section [Send initial copy using external media](#send-initial-copy-using-external-media) for the process to import the initial copy. A placeholder VM is created on the replica site and its replication health state is **Warning**. The replica contents for the VM are stored on your external media in a subfolder for the VM. Once the export is complete, safely eject the external media and transport it to the replica server.

### [Windows Admin Center](#tab/windows-admin-center)

> [!IMPORTANT]
> Configuring Hyper-V Replica using *Windows Admin Center - Virtualization mode* is currently in PREVIEW.
> This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.
>
> During the preview, configuring Hyper-V Replica by using Windows Admin Center - Virtualization mode is available for the following scenarios:
>
> - Configuring a single host as a replica server and configuring replication for VMs from a single host to another single host. Failover clusters aren't supported at this time.
> - Replication and failover of VMs is from a primary host to a replica host only. Performing a test failover or configuring reverse replication or extended replication isn't supported at this time.
> - Hyper-V hosts must be running Windows Server 2022 or later.
>
> For more information about Windows Admin Center - Virtualization mode, see [Windows Admin Center - Virtualization mode overview](../../manage/windows-admin-center/virtualization-mode-overview.md).

To enable and configure Hyper-V Replica by using Windows Admin Center - Virtualization mode:

1. Go to your URL for **Windows Admin Center - Virtualization mode** and sign in.

1. In the resources pane, expand the host that contains the VM you want to replicate, then select the VM to enter its overview.

1. On the menu bar, select **Manage**, then select **Configure Replication** to open the **Enable Replication** pane.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-manage-menu.png" alt-text="A screenshot of Windows Admin Center - Virtualization mode showing the Manage menu expanded with Configure Replication selected." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-manage-menu.png":::

1. For the **Replication Connection** tab, complete the following information, then select **Replication Configuration** to continue:

   1. For **Replica Server**, enter either the NetBIOS or FQDN of the Hyper-V host you're replicating to.

   1. For **Replica server port**, enter the port number you configured on the replica host for Hyper-V Replica.

   1. For **Authentication Type**, select the correct value from  **Use Kerberos authentication (HTTP)** or **Use Certificate-based authentication (HTTPS)** based on the authentication method you configured on the replica host. If you're using certificate-based authentication, select **Select Certificate**, then you're prompted to select the certificate for the primary host that matches the requirements. If you want to compress the data that is transmitted over the network, check the box.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-replication-connection.png" alt-text="A screenshot of the Replication Connection tab in Windows Admin Center - Virtualization mode showing replica server name, port, authentication type, certificate selection, and compression options." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-replication-connection.png":::

1. For the **Replication Configuration** tab, complete the following information, then select **Initial Replication** to continue:

   1. For **Choose replication VHDs**, make sure the checkboxes for the VHDs you want to replicate are selected, and clear the checkboxes for any VHDs that you want to exclude from replication.

   1. For **Replication Frequency**, specify how often changes should be synchronized from the primary to replica clusters or hosts from **30 seconds**, **5 minutes**, or **15 minutes**.

   1. For **Configure additional Recovery Points**, select **Maintain only the latest recovery point** or **Create additional hourly recovery points** and the number of extra recovery points you want to create in hours. When you create extra hourly recovery points, you can also check the box **Volume Shadow Copy Service (VSS) snapshot frequency** if you want recovery points to provide application-consistent recovery points for VMs running VSS-aware applications.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-replication-configuration.png" alt-text="A screenshot of the Replication Configuration tab listing selectable virtual hard disks, replication frequency options, and additional recovery point settings including VSS snapshot frequency." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-replication-configuration.png":::

1. For the **Initial Replication** tab, complete the following information, then select **Review** to continue:

   For **Configure initial replication**, select the initial replication method. The total size of the initial copy is displayed. Select an option from the following list:

   - **Send initial copy over the network**: this method is the default option. You can optionally specify whether to start replication immediately, or start replication at a specified time and date up to seven days in the future.
   - **Send initial copy using external media**: specify a folder location on local or external media where the initial copy can be stored. You can find the process to import the initial copy in the section [Send initial copy using external media](#send-initial-copy-using-external-media).

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-initial-replication.png" alt-text="A screenshot of the Initial Replication tab displaying initial replication method choices for network transfer or external media and optional scheduling settings." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-initial-replication.png":::

1. Review the summary information, then select **Enable Replication**.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-review.png" alt-text="A screenshot of the Review tab summarizing the chosen Hyper-V Replica settings before enabling replication." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-review.png":::

1. You can check that replication enabled successfully in the **Notifications** pane.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-notifications.png" alt-text="A screenshot of the Notifications pane confirming that Hyper-V VM replication was enabled successfully." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-notifications.png":::

1. To monitor the initial replication progress, see the section [Monitor replication progress](#monitor-replication-progress). You can change replication settings later if you need to in the **Replication** section of the VM settings.

   If you chose to send the initial copy by using external media, see the section [Send initial copy using external media](#send-initial-copy-using-external-media) for the process to import the initial copy. A placeholder VM is created on the replica site and its replication health state is **Warning**. The replica contents for the VM are stored on your external media in a subfolder for the VM.

---

> [!IMPORTANT]
> The following behaviors apply to VMs that you replicate:
>
> - When you replicate a VM, its network adapters aren't connected to a virtual switch on the replica host. After the initial replication is complete, connect any network adapters to a virtual switch on the replica host so that VMs are ready to bring online if you need to fail over.
>
> - If you make changes to the VM configuration, such as changing memory or processor settings or modifying network adapters, those changes aren't automatically replicated to the replica VM. You must manually update the replica VM if needed. Alternatively, you can remove replication and re-enable it to create a new replica VM with the updated configuration.
>
> - Hyper-V Replica points to a single default volume for VM replication. To prevent capacity or performance issues, move the VM's storage to a different volume than the default volume for replication.
>
> - If a VM runs an application that saves data across virtual hard disks, you can ensure that all virtual hard disks selected for replication are replicated to the same point in time. An example of where this approach is useful is when an application has one virtual hard disk dedicated for application data, and another virtual hard disk dedicated for application log files. To use this feature, configure VM replication by using PowerShell with the `Enable-VMReplication` cmdlet and add the parameter `EnableWriteOrderPreservationAcrossDisks`. For more information, see [Enable-VMReplication](/powershell/module/hyper-v/enable-vmreplication#-enablewriteorderpreservationacrossdisks).

### Send initial copy using external media

If you send the initial copy by using external media, such as a hard disk or USB drive, the process creates a placeholder VM on the replica site with a checkpoint. The process stores the replica contents for the VM on your external media in a subfolder for the VM. You transport the initial copy to the replica server, then import it to the placeholder VM.

You can enable replication by using Hyper-V Manager, Failover Cluster Manager, PowerShell, or Windows Admin Center - Virtualization mode. Select the relevant tab for instructions.

### [Hyper-V Manager](#tab/hyper-v-manager)

To send the initial copy by using external media and import it by using Hyper-V Manager:

1. Follow the steps in the section [Replicate a virtual machine](#replicate-a-virtual-machine) using Hyper-V Manager. The process creates a placeholder VM on the replica site and sets its replication health state to **Warning**. The process stores the replica contents for the VM on your external media in a subfolder for the VM. Once the export is complete, safely eject the external media and transport it to the replica server.

1. Open **Hyper-V Manager** on a device you use to manage the replica host, or on the replica host itself where Windows Server with Desktop Experience is installed.

1. In the resources pane, select the host that contains the placeholder VM you're replicating.

1. Right-click the placeholder VM, then select **Import Initial Replica**.

1. Specify the location where the initial copy is stored, then select **Complete Initial Replication**.

   :::image type="content" source="media/replication-failover-virtual-machines/import-initial-replication.png" alt-text="A screenshot of the Import Initial Replica dialog in Hyper-V Manager showing the path to the exported replica data and the Complete Initial Replication option to finalize applying the offline copy." lightbox="media/replication-failover-virtual-machines/import-initial-replication.png":::

1. The process applies the initial checkpoint to the placeholder VM and changes the replication health state to **Normal**. Replication continues at the specified frequency. See the section [Monitor replication progress](#monitor-replication-progress) to monitor continued replication progress.

### [Failover Cluster Manager](#tab/failover-cluster-manager)

To send the initial copy by using external media and import it by using Failover Cluster Manager:

1. Follow the steps in the section [Replicate a virtual machine](#replicate-a-virtual-machine) using Failover Cluster Manager. A placeholder VM is created on the replica site and its replication health state is **Warning**. The replica contents for the VM are stored on your external media in a subfolder for the VM. Once the export is complete, safely eject the external media and transport it to the replica server.

1. Open **Failover Cluster Manager** on a device you use to manage the cluster with the VM, or one of the hosts in the cluster where Windows Server with Desktop Experience is installed.

1. In the resources pane, expand the name of the cluster you want to replicate to, then select **Roles**.

1. Right-click the placeholder VM, then select **Import Initial Replica**.

1. Specify the location where the initial copy is stored, then select **Complete Initial Replication**.

   :::image type="content" source="media/replication-failover-virtual-machines/import-initial-replication.png" alt-text="A screenshot of the Import Initial Replica dialog in Hyper-V Manager showing the path to the exported replica data and the Complete Initial Replication option to finalize applying the offline copy." lightbox="media/replication-failover-virtual-machines/import-initial-replication.png":::

1. The initial checkpoint is applied to the placeholder VM, so the replica contents are now synchronized with the primary VM as of that checkpoint, and the replication health state changes to **Normal**. Replication continues at the specified frequency. See the section [Monitor replication progress](#monitor-replication-progress) to monitor continued replication progress.

### [PowerShell](#tab/powershell)

To send the initial copy by using external media and import it by using PowerShell:

1. Follow the steps in the section [Replicate a virtual machine](#replicate-a-virtual-machine) by using PowerShell. The process creates a placeholder VM on the replica site, and its replication health state is **Warning**. The process stores the replica contents for the VM on your external media in a subfolder for the VM. When the export finishes, safely eject the external media and transport it to the replica server.

1. Open a PowerShell session as an administrator on one of the replica hosts, or connect remotely by using the [Enter-PSSession](/powershell/module/microsoft.powershell.core/enter-pssession) cmdlet on a device you use to manage the cluster or host.

1. Import the initial replica by running the following command:

   ```powershell
   $parameters = @{
      VMName = '<VM name>'
      Path = '<Path to initial copy on external media>'
   }

   Import-VMInitialReplica @parameters
   ```

1. The time it takes to complete depends on the size of the VM and the speed of your external media. When the command finishes, it applies the initial checkpoint to the placeholder VM and changes the replication health state to **Normal**. Replication continues at the specified frequency. You can check the replication status by running the following command from the primary or replica host:

   ```powershell
   Get-VMReplication -VMName $parameters.VMName
   ```

   The `State` property shows the current state of replication. After the initial replication finishes, the state is `Replicating`, as shown in the following example output:

   ```output
   VMName        State       Health Mode    FrequencySec PrimaryServer ReplicaServer ReplicaPort AuthType Relationship
   ------        -----       ------ ----    ------------ ------------- ------------- ----------- -------- ------------
   contoso-vm-01 Replicating Normal Primary 300          hyperv01      cluster02rep  80          Kerberos Simple
   ```

   See the section [Monitor replication progress](#monitor-replication-progress) to monitor continued replication progress.

### [Windows Admin Center](#tab/windows-admin-center)

To send the initial copy by using external media and import it by using Windows Admin Center - Virtualization mode:

1. Follow the steps in the section [Replicate a virtual machine](#replicate-a-virtual-machine) by using Windows Admin Center - Virtualization mode. The process creates a placeholder VM on the replica site and sets its replication state to **Initial replication in progress**. The process stores the replica contents for the VM on your external media in a subfolder for the VM. Safely eject the external media and transport it to the replica server.

1. In **Windows Admin Center - Virtualization mode**, from the left pane, select the host to which you're replicating the VM.

1. From the list of tools for the host, select **Virtual machines**, then select the placeholder VM to enter its overview.

1. In the **Replication** section, select **Import Initial Replica**.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-import-initial-replica.png" alt-text="A screenshot of the placeholder VM Replication section in Windows Admin Center with the Import Initial Replica action highlighted.":::

1. In the pane that opens, enter the file path to the location where the initial copy is stored. You can also select **Browse** to navigate to the location. Select **Complete Initial Replication**.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-import-initial-replica-location.png" alt-text="A screenshot of the Import Initial Replica pane prompting for the file path to the exported initial replica and the Complete Initial Replication button.":::

1. The process applies the initial checkpoint to the placeholder VM and changes the replication health state to **Ok**. Replication continues at the specified frequency. See the section [Monitor replication progress](#monitor-replication-progress) to monitor continued replication progress.

---

## Monitor replication progress

You can monitor the progress of the initial replication and ongoing replication by using Hyper-V Manager, Failover Cluster Manager, PowerShell, or Windows Admin Center - Virtualization mode. The replication health states are:

- **Normal**: Replication cycles complete on schedule (RPO met), backlog is minimal, and there are no recent replication errors. No action needed.

- **Warning**: Replication works but lags or backlog grows (often transient network or storage load). Monitor and investigate if it doesn't clear quickly.

- **Critical**: Replication stalls or fails. The RPO is at risk as changes aren't applying. Investigate immediately, such as check connectivity, storage capacity and performance, authentication and certificates, and event logs. Resume or resynchronize as required.

Select the relevant tab for instructions.

### [Hyper-V Manager](#tab/hyper-v-manager)

To monitor replication progress by using Hyper-V Manager:

1. Back in **Hyper-V Manager**, select a host.

1. In the central pane, add a column for **Replication Health** to show the high-level health status of replication for each VM. Right-click on any column heading, select **Add/Remove Columns**. In the list of **Available Columns**, select **Replication Health**, then select **Add** to move it to **Displayed Columns**. Select **OK**.

1. View summary replication information, such as the last synchronized time and primary and replica host FQDNs. Select the VM, then in the bottom pane select the **Replication** tab.

   :::image type="content" source="media/replication-failover-virtual-machines/monitor-replication-summary-hyper-v-manager.png" alt-text="A screenshot of Hyper-V Manager with a virtual machine selected and the Replication tab showing summary health status, last synchronized time, and replica server information." lightbox="media/replication-failover-virtual-machines/monitor-replication-summary-hyper-v-manager.png":::

1. To view more detailed replication information, right-click the VM and select **Replication**, then **View Replication Health**. You can reset the replication statistics if needed by selecting **Reset Statistics**.

   :::image type="content" source="media/replication-failover-virtual-machines/monitor-replication-detail.png" alt-text="A screenshot of the Replication Health dialog displaying detailed Hyper-V Replica metrics including replication state, health, statistics, and recovery point information for the selected virtual machine in Hyper-V Manager." lightbox="media/replication-failover-virtual-machines/monitor-replication-detail.png":::

### [Failover Cluster Manager](#tab/failover-cluster-manager)

To monitor replication progress by using Failover Cluster Manager:

1. In **Failover Cluster Manager**, select the name of your cluster, then select **Roles**.

1. View summary replication information, such as the last synchronized time and primary and replica host FQDNs. Select the VM, then in the bottom pane select the **Replication** tab.

   :::image type="content" source="media/replication-failover-virtual-machines/monitor-replication-summary-failover-cluster-manager.png" alt-text="A screenshot of Failover Cluster Manager Roles view with a clustered virtual machine selected and the Replication tab showing summary replication health, last synchronized time, and primary/replica server details." lightbox="media/replication-failover-virtual-machines/monitor-replication-summary-failover-cluster-manager.png":::

1. To view more detailed replication information, right-click the VM and select **Replication**, then **View Replication Health**. You can reset the replication statistics if needed by selecting **Reset Statistics**.

   :::image type="content" source="media/replication-failover-virtual-machines/monitor-replication-detail.png" alt-text="A screenshot of the Replication Health dialog in Failover Cluster Manager showing detailed Hyper-V Replica status, health indicators, replication statistics, and recovery point information for the clustered virtual machine." lightbox="media/replication-failover-virtual-machines/monitor-replication-detail.png":::

### [PowerShell](#tab/powershell)

To monitor replication progress with PowerShell, use the [Get-VMReplication](/powershell/module/hyper-v/get-vmreplication) cmdlet, as shown in the following examples. Replace placeholder `<values>` with your own values.

1. Return to the existing PowerShell session where you enabled replication.

1. Run the following command to view replication configuration information, such as the health, and primary and replica host FQDNs:

   ```powershell
   Get-VMReplication -Name '<VM name>'
   ```

   Here's an example of the output:

   ```output
   VMName        State       Health Mode    FrequencySec PrimaryServer ReplicaServer ReplicaPort AuthType Relationship
   ------        -----       ------ ----    ------------ ------------- ------------- ----------- -------- ------------
   contoso-vm-01 Replicating Normal Replica 300          hyperv01      cluster02rep  80          Kerberos Simple
   ```

1. Run the following command to view replication performance information, such as the last synchronized time and average replication size:

   ```powershell
   Measure-VMReplication -VMName '<VM name>'
   ```

   Here's an example of the output:

   ```output
   VMName        State       Health LReplTime             PReplSize(M) AvgLatency AvgReplSize(M) Relationship
   ------        -----       ------ ---------             ------------ ---------- -------------- ------------
   contoso-vm-01 Replicating Normal 9/23/2025 10:22:30 AM 0.00         01:39:43   0.0039         Simple
   ```

1. Run the following command to reset the replication statistics:

   ```powershell
   Reset-VMReplicationStatistics -VMName '<VM name>'
   ```

### [Windows Admin Center](#tab/windows-admin-center)

To monitor replication progress by using Hyper-V Manager:

1. In **Windows Admin Center - Virtualization mode**, from the left pane, expand the host that contains the VM you're replicating, then select the VM to enter its overview.

1. In the **Replication** section, you can view summary replication information, such as the replication health, last synchronized time, and primary and replica host FQDNs.

   :::image type="content" source="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-monitor-replication.png" alt-text="A screenshot of the VM overview Replication section in Windows Admin Center showing replication health, last synchronized time, and primary and replica server details." lightbox="media/replication-failover-virtual-machines/enable-replication-vm-windows-admin-center-monitor-replication.png":::

---

## Configure extended replication (optional)

You can configure extended replication, which enables you to replicate a VM to a third location, from one replica server to another replica server. This approach can help you meet compliance requirements for offsite backups or provide an extra layer of protection for your workloads.

You can enable extended replication by using Hyper-V Manager, Failover Cluster Manager, or PowerShell. You can't use Windows Admin Center - Virtualization mode to configure extended replication at this time.

Select the relevant tab for instructions.

### [Hyper-V Manager](#tab/hyper-v-manager)

To configure extended replication by using Hyper-V Manager:

1. Open **Hyper-V Manager** on a device you use to manage the host with the VM, or on the host itself where Windows Server with Desktop Experience is installed.

1. In the resources pane, select the host that contains the VM you want to configure extended replication for.

1. Right-click the VM you want to configure extended replication for, then select **Replication** > **Extend Replication**.

1. The process to configure extended replication is similar to replicating a VM to the first replica location. Follow the process in the section [Replicate a virtual machine](#replicate-a-virtual-machine) with the following exceptions:
   - You can't specify which virtual hard disks to replicate. The virtual hard disks that are replicated to the first replica server are used for extended replication.
   - The replication frequency can only be 5 minutes or 15 minutes.
   - You can't change the authentication type.

### [Failover Cluster Manager](#tab/failover-cluster-manager)

To configure extended replication by using Failover Cluster Manager:

1. Open **Failover Cluster Manager** on a device you use to manage the cluster with the VM, or one of the hosts in the cluster where Windows Server with Desktop Experience is installed.

1. In the resources pane, expand the name of the cluster you want to replicate to, then select **Roles**.

1. Right-click the VM you want to replicate, then select **Replication** > **Extend Replication**.

1. The process to configure extended replication is similar to replicating a VM to the first replica location. Follow the process in the section [Replicate a virtual machine](#replicate-a-virtual-machine) with the following exceptions:
   - You can't specify which virtual hard disks to replicate. The virtual hard disks that are replicated to the first replica server are used for extended replication.
   - The replication frequency can only be 5 minutes or 15 minutes.

### [PowerShell](#tab/powershell)

The process to configure extended replication is the same as replicating a VM to the first replica location. Follow the process in the section [Replicate a virtual machine](#replicate-a-virtual-machine) with the following exceptions:

- You can't specify which virtual hard disks to replicate. The virtual hard disks that are replicated to the first replica server are used for extended replication.
- The replication frequency can only be 5 minutes or 15 minutes.

### [Windows Admin Center](#tab/windows-admin-center)

You can't use Windows Admin Center - Virtualization mode to configure extended replication at this time. Select a tab for one of the other methods to continue.

---

## Next step

After you enable replication for a VM, you can test failover to the replica server without impacting ongoing replication. For more information about performing a test failover and how to fail over during an outage, see [Failover a replicated virtual machine with Hyper-V Replica](replication-failover.md).
