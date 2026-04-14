---
title: Deploy a quorum witness for a failover cluster in Windows Server
description: Learn how to deploy a cluster quorum witness in Windows Server using Failover Cluster Manager, PowerShell, and Windows Admin Center.
ms.author: roharwoo
author: robinharwood
ms.topic: how-to
ms.date: 06/16/2025
zone_pivot_groups: quorum-witness
#customer intent: As a cluster admin, I want to configure a quorum witness to determine cluster nodes availability and node majority vote.
---

# Deploy a quorum witness

This article describes three types of quorum witnesses that can be deployed to the specific needs and topology of your environment. By understanding these witness types, you can tailor your cluster configuration to best fit the specific design and resiliency needs of your network environment.

Each quorum witness type comes with its own set of requirements and considerations. Outlined in this guide are specific prerequisites and configuration steps for each witness type so you can choose and implement the solution that best meets your environment’s needs. We recommend you always configure a witness if you're using Windows Server 2012 R2 and later. Clusters in later versions of Windows Server automatically manage the witness vote and their nodes vote with Dynamic Quorum.

## Prerequisites

::: zone pivot="cloud-witness"

In order to configure a cloud witness, the following are required:

- The Failover Cluster feature must be installed and configured on your device. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

- You must have an [Azure account](/azure/storage/common/storage-account-create?tabs=azure-portal) with an active subscription.

- You must have an Azure Standard [general purpose V2 storage account](/azure/storage/common/storage-account-upgrade) as only this storage account type is supported. This storage account is where a cloud witness creates the `msft-cloud-witness` container to store the blob file required for voting arbitration. You can use this account and the `msft-cloud-witness` container that the cloud witness automatically creates to configure a cloud witness across multiple different clusters.

  - When creating your Azure Storage account, if the cluster you're configuring the cloud witness for is on-premises or in Azure within the same Azure region and availability zones, select **Locally-redundant storage (LRS)** when configuring the **Replication** field. If your cluster is in the same Azure region but in different availability zones, select **Zone-redundant storage (ZRS)** instead.

  - When you create an Azure Storage account, Azure associates it with automatically generated primary and secondary access keys. When you set up a cloud witness for the first time, we recommend you use the primary access key. After that, you can use either the primary or secondary access key.

- You must ensure all firewalls between the failover cluster and Azure Storage account service allow traffic from port 443, also known as the HTTPS port. A cloud witness uses the HTTPS REST interface for the Azure Storage service. Therefore, you must have port 443 open on all nodes in your failover cluster for a cloud witness to work as intended.

You must also use one of the following supported scenarios:

- Disaster recovery for stretched multi-site clusters.

- Failover clusters without shared storage, such as SQL Always On.

- Failover clusters running inside a guest OS hosted in either the Microsoft Azure Virtual Machine role or any other public cloud.

- Failover clusters made of VMs hosted in private clouds running inside of a guest OS.

- Storage clusters with or without shared storage, such as Scale-out File Server clusters.

- Small branch-office clusters, which are even two-node clusters.

::: zone-end

::: zone pivot="disk-witness"

In order to configure a disk witness, the following are required:

- The Failover Cluster feature must be installed and configured on your device. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

- **Shared Storage**: The disk used for the witness must be a shared disk that is accessible by all nodes in the cluster, typically provided by a Storage Area Network (SAN) or other shared storage technology.

- **Disk Configuration**:
  - The disk witness shouldn't be assigned a drive letter or used for any other purposes, such as hosting user data or applications.
  - Is configured as a basic disk, not a dynamic disk.
  - Formatted as NTFS or ReFS for Windows Server 2012 and later.
  - Minimum disk size must be greater than 512MB.

::: zone-end

::: zone pivot="file-share-witness"

In order to configure a file share witness, the following are required:

- The Failover Cluster feature must be installed and configured on your device. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

- You have the **Full Control** permission on the Failover Cluster.

- Administrative credentials to configure a file share on the witness device.

- A device to host the file share witness supporting SMB 2 or later.

- If you're using a non-domain joined device for the file share, your cluster must be running Windows Server 2019 or later.

- The file share must be dedicated to a single cluster and not used to store user or application data.

- The device hosting the file share witness must have a minimum of 5 MB of free space.

- The file share should be physically separate from the cluster nodes or cluster sites. For instance, consider separating network, power, rack, and rooms if necessary. This separation increases the chances of cluster nodes or sites remain operational if network communication between them is disrupted.

> [!WARNING]
> The use of Distributed File System (DFS) or replicated storage technologies isn't supported with Failover Clustering. DFS can cause a partition-in-space or partition-in-time, where the cluster nodes are running independently of each other and could cause data loss.

::: zone-end

::: zone pivot="file-share-witness"

## Create a file share

The file share witness can be hosted on either a domain-joined Windows device or a non-domain joined device, such as Network Attached Storage (NAS) devices, Windows devices joined to a workgroup, or routers with local USB storage. You can also use a separate Failover Cluster to ensure high availability of the file share. A single file server can be configured with multiple file shares to serve as witnesses for multiple clusters.

Before you can configure a file share witness, a file share must first be created. The following steps allow you to configure a file share for both domain-joined Windows devices and non-domain joined devices. Select the relevant tab for your scenario.

# [Domain-joined Windows device](#tab/domain-joined-witness)

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

# [Non-domain joined device](#tab/nondomain-joined-witness)

To configure the file share witness on a non-domain joined device, follow these steps:

> [!IMPORTANT]
> If you're using a non-Windows device, consult your vendor documentation for how to create local accounts and configuring an SMB share on your device. These steps are generalized.

1. Sign into your device as an administrator.

1. Create a local account on the device for the cluster to use to authenticate the file share. Store the credentials in a secure location.

1. Create an SMB file share on the device that uses the SMB 2 or later protocol.

1. Update the share permissions to remove all users and groups except the new local account and any permissions required to meet your organization's requirements. The new local account should have the **Change** and **Read** permissions.

1. If necessary, modify your file system permissions. Grant the new local account **Modify**, **Read & execute**, **List folder contents**, and **Read** permissions as applicable to your file system. The local account must have write access.

1. Confirm and configure any other folder permissions to meet your organization's requirements.

1. Complete any further steps to create the file share.

::: zone-end

::: zone pivot="cloud-witness"

## Configure a cloud witness

You can configure a cloud witness using the Failover Cluster Manager, PowerShell, and Windows Admin Center.

# [Failover Cluster Manager](#tab/failovercluster)

1. In **Server Manager**, select **Tools**, then select **Failover Cluster Manager**.

1. On the left pane, under **Failover Cluster Manager**, select the cluster that you want to configure.

1. On the right pane, under **Actions**, select **More Actions**, and then select **Configure Cluster Quorum Settings**.

1. Under the **Configure Cluster Quorum Wizard**, select **Next**.

1. Under **Select Quorum Configuration Option**, select **Select the quorum witness**, then select **Next**.

1. Under **Select Quorum Witness**, select **Configure a cloud witness**, then select **Next**.

1. Under **Configure cloud witness**, enter the following information, then select **Next**:

   - Your Azure Storage account name.

   - The access key associated with your storage account.

     - If you're creating a cloud witness for the first time, use your primary access key.

     - If you're rotating your primary access key, then use the secondary access key instead.

     > [!NOTE]
     > Instead of storing access keys directly, your failover cluster generates a Shared Access Signature (SAS) token for secure storage. The token remains valid only as long as the associated access key is valid. When you rotate the primary access key, update the cloud witnesses on all clusters using that storage account with the secondary key before regenerating the primary key.

   - The Azure service endpoint

     You can enter the name of another existing server into the **Azure service endpoint** field if you plan to use a different Azure service endpoint for your cloud witness, such as Azure China.

1. Under **Confirmation**, review your quorum settings, then select **Next**.

1. Under **Summary**, review your witness configuration, then select **Finish**.

   You can select **View Report** for further configuration details.

Once the cloud witness is created, it can be located by navigating to the middle pane of the Failover Cluster Manager under **Cluster Core Resources**.

# [PowerShell](#tab/powershell)

Open an elevated PowerShell window and perform the following steps:

1. Run the following command to set up a cloud witness:

   ```powershell
   Set-ClusterQuorum -CloudWitness -AccountName <StorageAccountName> -AccessKey <StorageAccountAccessKey>
   ```

   If you need to change the endpoint, run the following command:

   ```PowerShell
   Set-ClusterQuorum -CloudWitness -AccountName <StorageAccountName> -AccessKey <StorageAccountAccessKey> -Endpoint <servername>
   ```

1. Run the following command to verify that the setup process was successful:

   ```powershell
   Get-ClusterQuorum
   ```

# [Windows Admin Center](#tab/wac)

1. In **Windows Admin Center**, navigate to **Cluster Manager**.

1. Select the name of the cluster you want to create a cloud witness for.

1. Go to **Configuration** > **Settings** > **Cluster** > **Witness**.

1. Select **Cloud Witness** from the witness type drop-down menu.

1. Enter your Azure storage account name and account key into the relevant fields.

   Optionally, you can change your endpoint from the default by entering the name of an existing server into the **Endpoint** field.

1. Select **Save**.

1. Verify your configuration was successful by checking the witness resource status. If the status is online, that means the cloud witness is configured and ready to use.

---

::: zone-end

::: zone pivot="disk-witness"

## Configure a disk witness

# [Failover Cluster Manager](#tab/failovercluster1)

You can configure a disk witness using the Failover Cluster Manager by performing the following steps:

1. In **Server Manager**, select **Tools**, then select **Failover Cluster Manager**.

1. On the left pane, under **Failover Cluster Manager**, select the cluster that you want to configure.

1. On the right pane, under **Actions**, select **More Actions**, and then select **Configure Cluster Quorum Settings**.

1. Under the **Configure Cluster Quorum Wizard**, select **Next**.

1. Under **Select Quorum Configuration Option**, select **Select the quorum witness**, then select **Next**.

1. Under **Select Quorum Witness**, select **Configure a disk witness**, then select **Next**.

1. Under **Configure Storage Witness**, select the disk you want to designate as the disk witness, then select **Next**.

1. Under **Confirmation**, review your quorum settings, then select **Next**.

1. Under **Summary**, review your witness configuration, then select **Finish**.

# [PowerShell](#tab/powershell1)

Open an elevated PowerShell window and perform the following steps:

1. Run the following command to list all available disks for use as a disk witness:

   ```powershell
   Get-ClusterAvailableDisk
   ```

1. Run the following command to select the disk you want to use as the disk witness:

   ```powershell
   Set-ClusterQuorum -DiskWitness <Cluster Disk Number>
   ```

   For example:

   ```powershell
   Set-ClusterQuorum -DiskWitness Cluster Disk 1
   ```

---

::: zone-end

::: zone pivot="file-share-witness"

## Configure a file share witness

# [Failover Cluster Manager](#tab/failovercluster1)

You can configure a file share witness on a domain joined Windows device using the Failover Cluster Manager by performing the following steps:

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

# [PowerShell](#tab/powershell1)

A non-domain joined file share witness can only be configured from PowerShell. Open an elevated PowerShell window and perform the following steps:

1. Run the following command to configure the cluster quorum to use a file share witness. You're prompted to enter the local credential for the file share witness. Replace `<ClusterName>` with the name of your cluster and `\\FileShareWitnessServer\WitnessShare` with the path to the file share witness.

    ```powershell
    Set-ClusterQuorum -Cluster <ClusterName> -FileShareWitness \\FileShareWitnessServer\WitnessShare -Credential (Get-Credential)
    ```

1. To verify the cluster quorum settings, run the following command:

    ```powershell
    Get-ClusterQuorum -Cluster <ClusterName> | Format-List *
    ```

1. After you configure the cluster quorum, run the following command to validate the quorum configuration settings:

   ```powershell
   Test-Cluster
   ```

---

::: zone-end

::: zone pivot="cloud-witness"

## Proxy considerations with a cloud witness

Cloud witness uses HTTPS, default port 443, to establish outbound communication with the Azure blob service. Azure uses `.core.windows.net` as the endpoint. You need to ensure that this endpoint is included in any firewall allowlists you're using between the cluster and Azure Storage. If a proxy is required to reach Azure Storage, configure Windows HTTP services (WinHTTP) with the required proxy settings. Failover cluster utilizes WinHTTP for HTTPS communication.

You can use the `netsh` command to configure a default proxy server by opening an elevated PowerShell window and running the following command:

```powershell
netsh winhttp set proxy proxy-server="<ProxyServerName>:<port>" bypass-list="<HostsList>"
```

For example:

```powershell
netsh winhttp set proxy proxy-server="192.168.10.80:8080" bypass-list="<local>; *.contoso.com"
```

> [!NOTE]
> Running this command changes the default proxy configuration for WinHTTP. Any application, including Windows services that use WinHTTP might be affected.

::: zone-end

## See also

- [What's New in failover clustering in Windows Server](whats-new-in-failover-clustering.md)

- [Netsh Command Syntax, Contexts, and Formatting](/windows-server/networking/technologies/netsh/netsh-contexts)

- [Use Cluster Shared Volumes in a failover cluster](/windows-server/failover-clustering/failover-cluster-csvs)

