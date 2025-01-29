---
title: Deploy a Cloud Witness for a failover cluster in Windows Server
description: How to deploy a cluster quorum Cloud Witness in Windows Server using Failover Cluster Manager, PowerShell, and Windows Admin Center.
ms.author: alalve
author: xelu86
ms.topic: how-to
ms.date: 01/29/2025
ms.assetid: 0cd1ac70-532c-416d-9de6-6f920a300a45
---

# Deploy Cloud Witness for a failover cluster

Cloud Witness is a type of failover cluster quorum witness that uses Microsoft Azure to provide a vote on cluster quorum. This article contains an overview of the Cloud Witness feature, which scenarios it supports, and instructions for how to configure a cloud witness for a failover cluster. For more information, see [Set up a cluster witness](/azure/azure-local/manage/witness?context=/windows-server/context/windows-server-failover-clustering).

## What is Cloud Witness?

Before we begin, you should refresh your memory about what cluster quorums and quorum witnesses are by reading [Understanding cluster and pool quorum](/azure/azure-local/concepts/quorum?context=/windows-server/context/windows-server-failover-clustering).

Now, let's start by looking at an example configuration of a multi-site stretched failover cluster quorum for Windows Server, shown in the following diagram.

:::image type="content" source="media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_1.png" alt-text="A diagram depicting a cluster quorum with a site labeled file share witness connected to site one and site two.":::

This example is a simplified configuration with two nodes in two on-site datacenters. In typical clusters, each node has one vote, a *file share witness*, that gives one extra vote to the quorum witness. This extra vote lets the cluster keep running even if one of the datacenters turns off. In the example, the cluster quorum has five possible votes, and only needs three votes to continue running.

However, you might notice that in addition to the two datacenters, there's also a third datacenter called a *file share witness*. This datacenter is kept separate from the other two sites and hosts a file server that backs up the system file share. The file share witness functions as the quorum witness in this cluster quorum configuration, making sure the system still runs even if one of the datacenters unexpectedly shuts down.

Having a file share witness provides enough redundancy to keep your file server highly available. However, you should remember that hosting the file share witness on another server in a separate site requires setup, regular maintenance, and independent connectivity to the other sites.

Cloud Witness is different from traditional cluster quorum witness configurations because it uses an Azure Virtual Machine (VM) in the cloud as the quorum witness instead of a physical datacenter. Cloud Witness uses Azure Blob Storage to read and write a blob file that the system uses as the deciding vote to achieve quorum. The following diagram shows an example configuration that uses Cloud Witness.

:::image type="content" source="media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_2.png" alt-text="A diagram depicting a failover cluster with Cloud Witness connected to site one and site two.":::

As you can see, Cloud Witness configurations don't require a third separate datacenter. Cloud Witness, like any other quorum witness, gets an extra vote and helps prevent total shutdowns if one of the other datacenters turns off. However, it doesn't need an extra site for storing the quorum witness. Cloud Witness also doesn't need the regular physical maintenance required for an on-site datacenter.

Along with redundancy, there are some other benefits to using the Cloud Witness feature:

- You don't need to use a separate extra datacenter to achieve quorum.

- Using Azure Blob Storage removes extra maintenance overhead normally required for hosting VMs in the public cloud.

- You can use the same Azure Storage account for multiple clusters. The only requirements are that you use only one blob per cluster and name the blob file name after the cluster's unique ID.

- Lower ongoing costs to your storage account because the blob file doesn't need much data and updates only when the cluster node state changes.

- Azure comes with a built-in Cloud Witness resource type.

## Prerequisites

You must have an [Azure account](/azure/storage/common/storage-account-create?tabs=azure-portal) with an active subscription and a valid Azure general-purpose storage account in order to configure Cloud Witness. This storage account is where Cloud Witness creates the `msft-cloud-witness` container to store the blob file required for voting arbitration.

> [!NOTE]
> Cloud Witness isn't compatible with the following types of Azure storage accounts:
>
> - Blob storage
> - Azure Premium Storage

You can also use this account and the `msft-cloud-witness` container that Cloud Witness automatically creates to configure Cloud Witness across multiple different clusters. Each cluster has its own blob file that it stores in the container.

When creating your Azure Storage account, if the cluster you're configuring Cloud Witness for is on-premises or in Azure within the same Azure region and availability zones, select **Locally-redundant storage (LRS)** when configuring the **Replication** field. If your cluster is in the same Azure region but in different availability zones, select **Zone-redundant storage (ZRS)** instead.

You must use one of the following supported scenarios:

- Disaster recovery for stretched multi-site clusters, as shown in [What is Cloud Witness](#what-is-cloud-witness).

- Failover clusters without shared storage, such as SQL Always On.

- Failover clusters running inside a guest OS hosted in either the Microsoft Azure Virtual Machine role or any other public cloud.

- Failover clusters made of VMs hosted in private clouds running inside of a guest OS.

- Storage clusters with or without shared storage, such as Scale-out File Server clusters.

- Small branch-office clusters, which are even two-node clusters.

We recommend you always configure a witness if you're using Windows Server 2012 R2 and later. Clusters in later versions of Windows Server automatically manage the witness vote and their nodes vote with Dynamic Quorum.

You also must make sure all firewalls between the failover cluster and Azure Storage account service allow traffic from port 443, also known as the HTTPS port. Cloud Witness uses the HTTPS REST interface for the Azure Storage service. Therefore, you must have port 443 open on all nodes in your failover cluster for Cloud Witness to work as intended.

When you create an Azure Storage account, Azure associates it with automatically generated primary and secondary access keys. When you set up Cloud Witness for the first time, we recommend you use the primary access key. After that, you can use either the primary or secondary access key.

## Configure Cloud Witness as a quorum witness for your cluster

You can configure Cloud Witness using the Quorum Configuration setup workflow built into the Failover Cluster Manager application or by using PowerShell.

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

Once the Cloud Witness is created, navigate to the middle pane of the Failover Cluster Manager and it can be seen under **Cluster Core Resources**.

# [PowerShell](#tab/powershell)

1. Run the following command to set up Cloud Witness:

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

## Proxy considerations with Cloud Witness

Cloud Witness uses HTTPS (default port 443) to establish outbound communication with the Azure blob service. Azure uses `.core.windows.net` as the endpoint. You need to ensure that this endpoint is included in any firewall allowlists you're using between the cluster and Azure Storage. If a proxy is required to reach Azure Storage, configure Windows HTTP services (WinHTTP) with the required proxy settings. Failover cluster utilizes WinHTTP for HTTPS communication.

You can use the `netsh` command to configure a default proxy server by opening an elevated PowerShell window and running the following command:

> [!NOTE]
> Running this command changes the default proxy configuration for WinHTTP. Any application, including Windows services, that use WinHTTP might be affected.

```powershell
netsh winhttp set proxy proxy-server="<ProxyServerName>:<port>" bypass-list="<HostsList>"
```

For example:

```powershell
netsh winhttp set proxy proxy-server="192.168.10.80:8080" bypass-list="<local>; *.contoso.com"
```

## See also

- [What's New in failover clustering in Windows Server](whats-new-in-failover-clustering.md)

- [Netsh Command Syntax, Contexts, and Formatting](/windows-server/networking/technologies/netsh/netsh-contexts)
