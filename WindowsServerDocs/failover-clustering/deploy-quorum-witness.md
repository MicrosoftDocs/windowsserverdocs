---
title: Deploy a quorum witness for a failover cluster in Windows Server
description: How to deploy a cluster quorum witness in Windows Server using Failover Cluster Manager, PowerShell, and Windows Admin Center.
ms.author: alalve
author: xelu86
ms.topic: how-to
ms.date: 02/05/2025
ms.assetid: 0cd1ac70-532c-416d-9de6-6f920a300a45
zone_pivot_groups: quorum-witness
---

# Deploy a quorum witness

This article describes three types of quorum witnesses that can be deployed to the specific needs and topology of your environment. By understanding these witness types, you can tailor your cluster configuration to best fit the specific design and resiliency needs of your network environment.

Each quorum witness type comes with its own set of requirements and considerations. Outlined in this guide are specific prerequisites and configuration steps for each witness type so you can choose and implement the solution that best meets your environment’s needs. We recommend you always configure a witness if you're using Windows Server 2012 R2 and later. Clusters in later versions of Windows Server automatically manage the witness vote and their nodes vote with Dynamic Quorum.

## Prerequisites

::: zone pivot="cloud-witness"

In order to configure a cloud witness, the following are required:

- The Failover Cluster feature must be installed and configured on your device. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

::: zone-end

::: zone pivot="disk-witness"

- The Failover Cluster feature must be installed and configured on your device. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

::: zone-end

::: zone pivot="file-share-witness"

- The Failover Cluster feature must be installed and configured on your device. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

::: zone-end

::: zone pivot="cloud-witness"

- You must have an [Azure account](/azure/storage/common/storage-account-create?tabs=azure-portal) with an active subscription and a valid Azure general-purpose storage account. This storage account is where a cloud witness creates the `msft-cloud-witness` container to store the blob file required for voting arbitration. You can use this account and the `msft-cloud-witness` container that the cloud witness automatically creates to configure a cloud witness across multiple different clusters. Each cluster has its own blob file that it stores in the container.

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

> [!NOTE]
> Cloud witness isn't compatible with the following types of Azure storage accounts:
>
> - Blob storage
> - Azure Premium Storage

::: zone-end

::: zone pivot="disk-witness"

In order to configure a disk witness, the following are required:

- The Failover Cluster feature must be installed and configured on your device. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).

- **Shared Storage**: The disk used for the witness must be a shared disk that is accessible by all nodes in the cluster, typically provided by a Storage Area Network (SAN) or other shared storage technology.

- **Disk Configuration**:
  - The disk witness shouldn't be assigned a drive letter or used for any other purposes, such as hosting user data or applications.
  - Configured as a basic disk, not a dynamic disk.
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

- The device hosting the file share witness must have a minimum of 5 MB of free space.

> [!WARNING]
> The use of Distributed File System (DFS) or replicated storage technologies isn't supported with failover clustering. DFS can cause a partition-in-space or partition-in-time, where the cluster nodes are running independently of each other and could cause data loss.

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

1. Under **Select Quorum Witness**, select **Configure a file cloud witness**, then select **Next**.

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

1. Open Windows Admin Center and go to **Cluster Manager**.

1. Select the name of the cluster you want to create a Cloud Witness for.

1. Go to **Configuration** > **Settings** > **Cluster** > **Witness**.

1. Select **Cloud Witness** from the witness type drop-down menu.

1. Enter your Azure storage account name and account key into the relevant fields.

1. Optionally, you can change your endpoint from the default by entering the name of an existing server into the **Endpoint** field.

1. Select **Save**.

1. Verify your configuration was successful by checking the witness resource status. If the status is online, that means the Cloud Witness is configured and ready to use.

---

### Proxy considerations with a cloud witness

Cloud witness uses HTTPS, default port 443, to establish outbound communication with the Azure blob service. Azure uses `.core.windows.net` as the endpoint. You need to ensure that this endpoint is included in any firewall allowlists you're using between the cluster and Azure Storage. If a proxy is required to reach Azure Storage, configure Windows HTTP services (WinHTTP) with the required proxy settings. Failover cluster utilizes WinHTTP for HTTPS communication.

You can use the `netsh` command to configure a default proxy server by opening an elevated PowerShell window and running the following command:

> [!NOTE]
> Running this command changes the default proxy configuration for WinHTTP. Any application, including Windows services that use WinHTTP might be affected.

```powershell
netsh winhttp set proxy proxy-server="<ProxyServerName>:<port>" bypass-list="<HostsList>"
```

For example:

```powershell
netsh winhttp set proxy proxy-server="192.168.10.80:8080" bypass-list="<local>; *.contoso.com"
```

::: zone-end

::: zone pivot="disk-witness"

## Configure a disk witness

::: zone-end

::: zone pivot="file-share-witness"

## Configure a file share witness

::: zone-end

## See also

- [What's New in failover clustering in Windows Server](whats-new-in-failover-clustering.md)

- [Netsh Command Syntax, Contexts, and Formatting](/windows-server/networking/technologies/netsh/netsh-contexts)
