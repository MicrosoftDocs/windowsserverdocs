---
title: Configure a file share witness for Failover Clustering in Windows Server
description: Configure cluster quorum as a file share witness in domain-joined and non-domain joined devices using Failover Cluster Manager.
ms.topic: how-to
author: dknappettmsft
ms.author: daknappe
ms.date: 01/28/2025
#customer intent: As a cluster administrator, I want to configure a file share witness so that I can use it to determine the availability of the cluster nodes in addition to the node majority vote.
---

# Configure a file share witness for Failover Clustering

When a cluster contains an even number of voting nodes, you should configure a witness. Adding a witness vote enables the cluster to continue running if half the cluster nodes simultaneously go down or are disconnected. A file share witness is a type of quorum witness that uses a Server Message Block (SMB) file share to maintain cluster information in a log file. This file share can be hosted on a server, USB storage, or Network Attached Storage (NAS).

The file share witness is also beneficial for multisite clusters with replicated storage.

You might use a file share witness when:

- A Cloud Witness can't be used because your cluster nodes don't have a reliable internet connection or an internet connectivity.

- A disk witness can't be used because there aren't any shared drives to use for a disk witness. For example, a Storage Spaces Direct cluster, SQL Server Always On Availability Groups (AG), or Exchange Database Availability Group (DAG). None of these types of clusters use shared disks.

In this article, learn how-to configure a file share witness for your Failover Cluster.

## Prerequisites

Before you can use a file share witness, you must have the following prerequisites in place:

- The Failover Cluster feature must be installed and configured on your device. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

- You have the **Full Control** permission on the Failover Cluster.

- Administrative credentials to configure a file share on the witness device.

- A device to host the file share witness supporting SMB 2 or later.

- If you're using a non-domain joined device for the file share, your cluster must be running Windows Server 2019 or later.

- The device hosting the file share witness must have a minimum of 5 MB of free space.

> [!WARNING]
> The use of Distributed File System (DFS) or replicated storage technologies isn't supported with failover clustering. DFS can cause a partition-in-space or partition-in-time, where the cluster nodes are running independently of each other and could cause data loss.

## Configure the file share

When configuring a file share witness for the cluster quorum, the file share:

- Must be dedicated to the single cluster and not used to store user or application data.

- A single file server can be configured with multiple file shares to use as a witness for multiple clusters.

- Should be physically separate from the cluster nodes or cluster sites. For example, consider the separation of network, power, rack, and rooms if necessary. Separation allows opportunity for cluster nodes or sites to survive if network communication between them is lost.

- You can use a separate Failover Cluster for high availability of the file share.

The file share witness can be hosted on a domain-joined Windows device or a non-domain joined device, for example:

- NAS devices.

- Windows devices joined to a workgroup.

- Routers with local USB storage.

The steps to configure the file share witness are different depending on the type of device hosting the file share. To create the file share, select the relevant tab for your scenario.

### [Domain-joined Windows device](#tab/domain-joined-witness)

To configure the file share witness on a domain-joined Windows device, follow these steps:

> [!IMPORTANT]
> The SMB file share must be hosted on a Windows server joined to the same Active Directory forest as the cluster.

1. Right-click **Start**, select **Computer Management**.

1. In the **Computer Management** console, expand **System Tools > Shared Folders**.

1. Right-click **Shares**, select **New Share**.

1. On the **Create A Shared Folder Wizard**, select **Next** to begin.

1. Enter the path to the folder that you want to share or select **Browse** to locate a folder, then select **Next**.

1. Enter a name for the **Share name**, then select **Change** to configure the offline settings. Adding a description for the share is optional.

1. Select **No files or programs from the shared folder are available offline**. Select **OK**, then select **Next**.

1. Under **Shared Folder Permissions**, select **Customize permissions**, then select **Custom**.

1. Select **Everyone**, then select **Remove**.

1. Select **Add**, enter the name, or locate the Cluster Name Object (CNO) for the cluster or suitable Active Directory group containing the CNO. Then select **OK**.

1. Select both **Change** and **Read** permissions.

1. Select the **Security** tab, then select **Advanced**.

1. In the **Advanced Security Settings** screen, under the **Permissions** tab, select **Add**.

1. Under **Basic permissions**, select **Modify**, **Read & execute**, **List folder contents**, and **Read**. Then select **OK**.

1. Confirm and configure any other folder permissions to meet your organization's requirements. Select **OK** for each dialog until you return to the **Shared Folder Permissions** screen.

1. Select **Finish** to create the share.

Now you have a file share on a domain-joined Windows device with the necessary permissions per your organization. Proceed to the next step to configure the cluster quorum settings.

### [Non-domain joined device](#tab/nondomain-joined-witness)

To configure the file share witness on a non-domain joined device, follow these steps:

> [!IMPORTANT]
> If you're using a non-Windows device, consult your vendor documentation for how to create local accounts and configuring an SMB share on your device. These steps are generalized.

1. Sign in to your device as an administrator.

1. Create a local account on the device for the cluster to use to authenticate the file share. Store the credentials in a secure location.

1. Create an SMB file share on the device that uses the SMB 2 or later protocol.

1. Update the share permissions to remove all users and groups except the new local account and any permissions required to meet your organization's requirements. The new local account should have the **Change** and **Read** permissions.

1. If necessary, modify your file system permissions. Grant the new local account **Modify**, **Read & execute**, **List folder contents**, and **Read** permissions as applicable to your file system. The local account must have write access.

1. Confirm and configure any other folder permissions to meet your organization's requirements.

1. Complete any further steps to create the file share.

Now you have a file share on a non-domain joined Windows device with the necessary permissions per your organization. Proceed to the next step to configure the cluster quorum settings.

---

## Configure the cluster quorum

You can configure the cluster quorum settings by using Failover Cluster Manager or the [FailoverClusters](/powershell/module/failoverclusters/failoverclusters) PowerShell module.

### [Domain joined Windows device](#tab/domain-joined-witness)

To configure the cluster quorum to use a file share witness on a domain joined device using Failover Cluster Manager, follow these steps:

1. In **Server Manager**, select **Tools**, then select **Failover Cluster Manager**.

1. On the left pane, under **Failover Cluster Manager**, select the cluster that you want to configure.

1. On the right pane, under **Actions**, select **More Actions**, and then select **Configure Cluster Quorum Settings**.

1. Under the **Configure Cluster Quorum Wizard**, select **Next**.

1. Under **Select Quorum Configuration Option**, select **Select the quorum witness**, then select **Next**.

1. Under **Select Quorum Witness**, select **Configure a file share witness**, then select **Next**.

1. Under **Configure File Share Witness**, type the file path location or select **Browse**, select **Browse** again and locate the file share to use as the witness resource. Then select **Next**.

1. Under **Confirmation**, review your configuration and select **Next**.

1. After the wizard runs, the **Summary** page appears. If you want to view a report of the tasks that the wizard performed, select **View Report**. Select **Finish** to complete your configuration.

> [!NOTE]
> After you configure the cluster quorum, we recommend that you run the **Validate Quorum Configuration** test to verify the updated quorum settings.

### [Non-domain joined device](#tab/nondomain-joined-witness)

Here's how to configure the cluster quorum to use a file share witness on a non-domain joined device. A non-domain joined file share witness can only be configured from PowerShell using the
[Set-ClusterQuorum](/powershell/module/failoverclusters/set-clusterquorum) cmdlet.

Sign into the device that has the Failover Cluster Management Remote Server Administration Tool (RSAT) installed or on a server where you installed the Failover Cluster feature. Perform the following steps:

1. Open an elevated PowerShell window.

1. Run the following command to configure the cluster quorum to use a file share witness. You're prompted to enter the local credential for the file share witness. Replace `<ClusterName>` with the name of your cluster and `\\FileShareWitnessServer\WitnessShare` with the path to the file share witness.

    ```powershell
    Set-ClusterQuorum -Cluster <ClusterName> -FileShareWitness \\FileShareWitnessServer\WitnessShare -Credential (Get-Credential)
    ```

1. To verify the cluster quorum settings, run the following command:

    ```powershell
    Get-ClusterQuorum -Cluster <ClusterName> | Format-List *
    ```

After you configure the cluster quorum, we recommend that you validate the quorum configuration settings by running the `Test-Cluster` cmdlet.

---

