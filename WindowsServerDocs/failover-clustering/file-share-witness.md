---
title: Configure a file share witness for Failover Clustering in Windows Server
description: Learn how-to use a file share witness as a cluster quorum using Failover Cluster Manager and PowerShell.
ms.topic: how-to
author: robhind
ms.author: roharwoo
ms.date: 04/29/2024
#customer intent: As a cluster administrator, I want to configure a file share witness so that I can use it to determine the availability of the cluster nodes in addition to the node majority vote.
---

# Configure a file share witness for Failover Clustering

When a cluster contains an even number of voting nodes, you should configure a witness. Adding a witness vote enables the cluster to continue running if half the cluster nodes simultaneously go down or are disconnected. A file share witness is a type of quorum witness that uses an SMB file share on a server, USB storage, or Network Attached Storage to maintain cluster information in a log file. The file share witness is also useful for multisite clusters with replicated storage.

You might use a file share witness when:

- A Cloud Witness can't be used because your cluster nodes don't have a reliable internet connection or an internet connectivity.

- A disk witness can't be used because there aren't any shared drives to use for a disk witness. For example, a Storage Spaces Direct cluster, SQL Server Always On Availability Groups (AG), or Exchange Database Availability Group (DAG). None of these types of clusters use shared disks.

For information about quorum configuration options, see [Configure and manage quorum](manage-cluster-quorum.md).

In this article, learn how-to configure a file share witness for your Failover Cluster.

## Prerequisites

Before you can use a file share witness, you must have the following prerequisites in place:

- A Failover Cluster installed and configured.

- You have the **Full Control** permission on the Failover Cluster.

- A device to host the file share witness. Your device can be any device that can host an SMB 2 or later file share.

- If you're using a non-domain joined device for the file share, your cluster must be running Windows Server 2019 or later.

- The device hosting the file share witness must have a minimum of 5 MB of free space.

- Administrative credentials to configure a file share on the witness device.

> [!WARNING]
> The use of a technologies like Distributed File System (DFS) or replicated storage is not supported with failover clustering.  These can cause a partition-in-space or partition-in-time, where cluster node are running independently of each other and could cause data loss.

## Configure the file share

When configuring a file share witness for the cluster quorum, the file share:

- Must be dedicated to the single cluster and not used to store user or application data.

- A single file server can be configured with multiple file share to use as a witness for multiple clusters.

- Should be physically separate from the cluster nodes or cluster sites. For example, consider the separation of network, power, rack, and rooms if required. Separation allows opportunity for cluster nodes or sites to survive if network communication between them is lost.

- You can use a separate Failover Cluster for high availability of the file share.

The file share witness can be hosted on a domain-joined Windows device or a non-domain joined device, for example:

- Network-attached storage (NAS) devices.

- Windows computers joined to a workgroup.

- Routers with local USB storage.

The steps to configure the file share witness are different depending on the type of device hosting the file share. To create the file share, select the relevant tab for your scenario and follow the steps.

### [Domain joined Windows device](#tab/domain-joined-witness)

Here's how to configure the file share witness on a domain-joined Windows device.

> [!IMPORTANT]
> The SMB file share must be hosted on a Windows server joined to the same Active Directory forest as the cluster.

1. Sign in to the device, from the Windows desktop, open the **Start** menu, type **Computer Management**, right-click **Computer Management**, and select **Run as administrator**.

1. In the Computer Management console, expand **System Tools > Shared Folders > Shares**.

1. Right-click **Shares** from the left-side panel, then select **New Share**.

1. From the **Create A Shared Folder Wizard**, select **Next** to begin.

1. Enter the path to the folder that you want to share or select **Browser** to choose a folder, then select **Next**.

1. Enter a name for the share, then select **Change** to configure the offline settings.

1. Select the **No files or programs from the shared folder are available offline** radio option, then select **OK**. Then select **Next**.

1. In the **Shared Folder Permissions** screen, select **Customize permissions**, then select **Custom**.

1. Select **Everyone**, then select **Remove**.

1. Select **Add**, then enter the name of the Cluster Name Object (CNO) for the cluster or suitable Active Directory group containing the CNO, then select **OK**.

1. Check the **Change** and **Read** permissions for the CNO or Active Directory group.

1. Select the **Security** tab, then select **Advanced**.

1. From the **Advanced Security Settings** dialog, and select **Add** to add the CNO.

1. Check the **Modify**, **Read & execute**, **List folder contents**, and **Read** permissions for the CNO or Active Directory group, select **OK**.

1. Confirm and configure any other folder permissions to meet your organization's requirements, select **OK** for each dialog until you return to the **Shared Folder Permissions** screen.

1. Select **Finish** to create the share.

Now you have a file share on a domain-joined Windows device with the correct permissions you can configure the cluster quorum settings.

### [Non-domain joined device](#tab/non-domain-joined-witness)

Here's how to configure the file share witness on a non-domain joined device.

> [!IMPORTANT]
> If you're using a non-Windows device, consulting your vendor documentation for how to create local accounts and configuring an SMB share on your device. These steps have been generalized.

1. Sign in to your device as an administrator.

1. Create a local account on the device for the cluster to use to authenticate to the file share. Store the credentials in a secure location.

1. Create an SMB file share on the device that uses the SMB 2 or later protocol.

1. Update the share permissions to remove all users and groups except the new local account and any permissions required to meet your organization's requirements. The new local account should have the **Change** and **Read** permissions.

1. If necessary, modify your file system permissions. Grant the new local account **Modify**, **Read & execute**, **List folder contents**, and **Read** permissions as applicable to your file system. The local account must have write access.

1. Confirm and configure any other folder permissions to meet your organization's requirements.

1. Complete any further steps to create the file share.

Now you have a file share on a non-domain joined device with the correct permissions, you can configure the cluster quorum settings.

---

## Configure the cluster quorum

You can configure the cluster quorum settings by using Failover Cluster Manager or the FailoverClusters Windows PowerShell cmdlets.

### [Domain joined Windows device](#tab/domain-joined-witness)

Here's how to configure the cluster quorum to use a file share witness on a domain joined device using Failover Cluster Manager.

1. On a computer that has the Failover Cluster Management Tools installed from the Remote Server Administration Tools or on a server where you installed the Failover Clustering feature, start Failover Cluster Manager. Start **Server Manager** and then on the **Tools** menu, select **Failover Cluster Manager**.

1. In Failover Cluster Manager, select the cluster that you want to change.

1. With the cluster selected, under **Actions**, select **More Actions**, and then select **Configure Cluster Quorum Settings**. The Configure Cluster Quorum Wizard appears. Select **Next**.

1. On the **Select Quorum Configuration Option** screen, select **Select the quorum witness**, then select **Next**.

1. On the **Select Quorum Witness** screen, select **Configure a file share witness**, then select **Next**.

1. On the **Configure File Share Witness** screen, type or browse to a file share to use as the witness resource, then select **Next**.

1. On the **Confirmation** screen, review your changes and select **Next**.

1. After the wizard runs, the **Summary** page appears. If you want to view a report of the tasks that the wizard performed, select **View Report**.

> [!NOTE]
> After you configure the cluster quorum, we recommend that you run the **Validate Quorum Configuration** test to verify the updated quorum settings.

### [Non-domain joined device](#tab/non-domain-joined-witness)

Here's how to configure the cluster quorum to use a file share witness on a non-domain joined device. A non-domain joined file share witness can only be configured from PowerShell using the
[Set-ClusterQuorum](/powershell/module/failoverclusters/set-clusterquorum) command.

1. Sign in to a computer that has the Failover Cluster Management Tools installed from the Remote Server Administration Tools or on a server where you installed the Failover Clustering feature.

1. Open a PowerShell prompt.

1. Run the following command to configure the cluster quorum to use a file share witness. You're prompted to enter the local credential for the file share witness. Replace `<ClusterName>` with the name of your cluster and `\\FileShareWitnessServer\WitnessShare` with the path to the file share witness.

    ```powershell
    Set-ClusterQuorum -Cluster <ClusterName> -FileShareWitness \\FileShareWitnessServer\WitnessShare -Credential (Get-Credential)
    ```

1. To verify the cluster quorum settings, run the following command.

    ```powershell
    Get-ClusterQuorum -Cluster <ClusterName> | Format-List *
    ```

> [!NOTE]
> After you configure the cluster quorum, we recommend that you run the **Validate Quorum Configuration** test to verify the updated quorum settings. To run the test, use the `Test-Cluster` PowerShell command.
