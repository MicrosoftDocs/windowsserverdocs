---
ms.assetid: 0cd1ac70-532c-416d-9de6-6f920a300a45
title: Deploy a cloud witness for a failover cluster
manager: lizross
ms.author: jgerend
ms.topic: article
author: JasonGerend
ms.date: 10/21/2021
description: How to use Microsoft Azure to host the witness for a Windows Server failover cluster in the cloud - also known as how to deploy a Cloud Witness.
---

# Deploy Cloud Witness for a failover cluster

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

Cloud Witness is a type of failover cluster quorum witness that uses Microsoft Azure to provide a vote on cluster quorum. This article contains an overview of the Cloud Witness feature, which scenarios it supports, and instructions for how to configure a cloud witness for a failover cluster. For more information, see [Set up a cluster witness](/azure-stack/hci/manage/witness).

## What is a cloud witness?

Cluster quorum configurations are systems that are run by voting algorithms on each node of a network of servers. The system runs or stops running based on whether it has a *quorum*, or majority of votes from its various nodes. In a typical cluster quorum configuration, each node has one vote. As long as enough nodes are active and can give their votes, the system can start up and keep running. In the event of a disaster scenario where too many nodes shut down, the system can't achieve quorum, and so the cluster turns off. Once enough nodes are back on to give quorum again, the cluster turns back on.

Let's start by looking at an example configuration of a multi-site stretched failover cluster quorum for Windows Server 2016.

:::image type="content" source="media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_1.png" alt-text="File Share Witness in a third separate site with 2 nodes in 2 other sites.":::

Cluster quorum configurations are usually much larger, but for simplicity's sake, this example configuration has only two nodes in two on-site datacenters. While in typical configurations each node has one vote, Cloud Witness gives one extra vote to the quorum witness. This extra vote lets the cluster keep running even if one of the datacenters turns off. In this example, the cluster quorum has five possible votes, and only needs three votes to continue running.

When you create your own cluster quorum, we recommend you host the quorum witness in a separate datacenter. In the example configuration, the admin has set up their quorum witness in a third datacenter separate from the other two that hosts a file server that backs up the file share. As a result, we call this third datacenter the *file share witness*, and it functions as the quorum witness for this deployment. Configuring a file share witness ensures that, if one datacenter turns off unexpectedly, the cluster still runs because the other datacenter and the file share witness are still on.

Most organizations don't have a third datacenter serving as the file share witness. In these scenarios, the organizations host the file server in one of the two datacenters. The datacenter they host their file shares in becomes the primary datacenter. In this type of configuration, if one of the two datacenters turns off because of a power outage, the entire cluster will stop working because it doesn't have enough votes to achieve quorum. Having a file share witness provides the redundancy required to keep your file server highly available. However, you should remember that hosting the file share witness on a guest OS can cause significant overhead for setup and maintenance when you're hosting virtual machines (VMs) in the public cloud.

<!--Do we need all that preceding information? Is there an article that I can link to that has the basics?-->

Cloud Witness is different from traditional cluster quorum witness configurations because it uses Microsoft Azure as the quorum witness instead of a physical datacenter. A cloud witness uses Azure Blob Storage to read and write a blob file that the system uses as the deciding vote for the system to achieve quorum. The following diagram shows an example configuration that you can compare to the previous physical datacenter example at the beginning of this section.

:::image type="content" source="media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_2.png" alt-text="Diagram illustrating a multi-site stretched cluster with Cloud Witness as a quorum witness.":::

As you can see, this configuration doesn't require a third separate datacenter. Cloud Witness, like any other quorum witness, gets an extra vote and helps prevent total shutdowns if one of the other datacenters turns off. However, it does this without requiring an extra site to store the quorum witness on or the physical maintenance required for an on-site datacenter.

In summary, these are the benefits to using the Cloud Witness feature:

- You don't need to use a separate extra datacenter to achieve quorum.
- Using Azure Blob Storage removes extra maintenance overhead normally required for hosting VMs in the public cloud.
- You can use the same Azure Storage account for multiple clusters. The only requirements are that you use only one blob per cluster and name the blob file name after the cluster's unique ID.
- Lower ongoing costs to your storage account because the blob file doesn't need much data and updates only when the cluster node state changes.
- Comes with a built-in Cloud Witness resource type.

## Prerequisites

You must have a valid Azure general-purpose storage account in order to configure Cloud Witness. This storage account is where Cloud Witness creates the msft-cloud-witness container to store the blob file required for voting arbitration.

You can also use this account and the msft-cloud-witness container that Cloud Witness automatically creates to configure Cloud Witness across multiple different clusters. Each cluster will have its own blob file stored in the container.

You can use a cloud witness as a quorum witness in the following supported scenarios:

- Disaster recovery for stretched multi-site clusters, as shown in [What is a cloud witness](#what-is-a-cloud-witness).
- Failover clusters without shared storage, such as SQL Always On.
- Failover clusters running inside a guest OS hosted in either the Microsoft Azure Virtual Machine role or any other public cloud.
- Failover clusters made of VMs hosted in private clouds running inside of a guest OS.
- Storage clusters with or without shared storage, such as Scale-out File Server clusters.
- Small branch-office clusters, which are even two-node clusters.

We recommend you always configure a witness if you're using Windows Server 2012 R2 and later, because clusters in later versions of Windows Server automatically manage the witness vote and their nodes vote with Dynamic Quorum.

## Create an Azure Storage Account to use as a Cloud Witness

This section describes how to create a storage account and view and copy endpoint URLs and access keys for that account.

To create an Azure storage account:

1. Sign in to the [Azure portal](https://portal.azure.com).
1. On the Hub menu, go to **New** > **Data + Storage** > **Storage account**.
1. In the **Create a storage account** page, enter a name for your storage account.

   >[!NOTE]
   >Storage account names must be a unique name between three and 24 characters long that only uses numbers and lowercase letters.

1. For the **Account kind** field, select **General purpose**.

   >[!NOTE]
   >Blob storage accounts aren't compatible with Cloud Witness.

1. For the **Performance** field, select **Standard**.

   >[!NOTE]
   >Azure Premium Storage accounts aren't compatible with Cloud Witness.

1. For the **Replication** field:

   - If the cluster you're configuring Cloud Witness for is on-premises or in Azure within the same Azure region and availability zones, select **Locally-redundant storage (LRS)**.
   - If your cluster is in the same Azure region but in different availability zones, select **Zone-redundant storage (ZRS)**.

### View and copy storage access keys for your Azure Storage Account

<!--Where I left off.-->

When you create a Microsoft Azure Storage Account, it is associated with two Access Keys that are automatically generated - Primary Access key and Secondary Access key. For a first-time creation of Cloud Witness, use the **Primary Access Key**. There is no restriction regarding which key to use for Cloud Witness.

#### To view and copy storage access keys

In the Azure portal, navigate to your storage account, click **All settings** and then click **Access Keys** to view, copy, and regenerate your account access keys. The Access Keys blade also includes pre-configured connection strings using your primary and secondary keys that you can copy to use in your applications, as shown in the following screenshot.

:::image type="content" source="media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_4.png" alt-text="A screenshot of the Manage Access Keys dialog in Microsoft Azure.":::

### View and copy endpoint URL Links

When you create a Storage Account, the following URLs are generated using the format: `https://<Storage Account Name>.<Storage Type>.<Endpoint>`

Cloud Witness always uses **Blob** as the file storage type in a general purpose storage account. Azure uses **.core.windows.net** as the Endpoint. When configuring Cloud Witness, it is possible that you configure it with a different endpoint as per your scenario (for example the Microsoft Azure datacenter in China has a different endpoint).

> [!NOTE]
> The endpoint URL is generated automatically by the Cloud Witness resource. Make sure that port 443 is open in your firewalls and that `*.core.windows.net` is included in any firewall allow lists you're using between the cluster and Azure Storage.

#### To view and copy endpoint URL links

In the Azure portal, navigate to your storage account, click **All settings** and then click **Properties** to view and copy your endpoint URLs, as shown in the following screenshot.

:::image type="content" source="media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_5.png" alt-text="A screenshot of the Cloud Witness endpoint URL links.":::

For more information about creating and managing Azure Storage Accounts, see [About Azure Storage Accounts](/azure/storage/common/storage-account-create)

## Configure Cloud Witness as a quorum witness for your cluster

Cloud Witness configuration is well integrated within the existing Quorum Configuration Wizard built into the Failover Cluster Manager.

### To configure Cloud Witness as a Quorum Witness

1. Launch Failover Cluster Manager.

2. Right-click the cluster -> **More Actions** -> **Configure Cluster Quorum Settings**, as shown in the following screenshot. This launches the Configure Cluster Quorum wizard.

    :::image type="content" source="media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_7.png" alt-text="A screenshot of the menu path to Configure Cluster Quorum Settings in the Failover Cluster Manager UI.":::

3. On the **Select Quorum Configurations** page, select **Select the quorum witness**, as shown in the following screenshot.

    :::image type="content" source="media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_8.png" alt-text="A screenshot of the select the quorum witness radio button in the Cluster Quorum wizard.":::

4. On the **Select Quorum Witness** page, select **Configure a cloud witness**, as shown in the following screenshot.

    :::image type="content" source="media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_9.png" alt-text="A screenshot of the appropriate radio button to select a cloud witness.":::

5. On the **Configure Cloud Witness** page, enter the following information:
   1. (Required parameter) Azure Storage Account Name.
   2. (Required parameter) Access Key corresponding to the Storage Account.
       1. When creating for the first time, use Primary Access Key.
       2. When rotating the Primary Access Key, use Secondary Access Key.
   3. (Optional parameter) If you intend to use a different Azure service endpoint (for example the Microsoft Azure service in China), then update the endpoint server name.

      :::image type="content" source="media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_10.png" alt-text="A screenshot of the Cloud Witness configuration pane in the Cluster Quorum wizard.":::

6. Upon successful configuration of Cloud Witness, you can view the newly created witness resource in the Failover Cluster Manager snap-in, as shown in the following screenshot.

    :::image type="content" source="media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_11.png" alt-text="A screenshot of the message that appears when you successfully configure Cloud Witness.":::

### Configuring Cloud Witness using PowerShell

The existing Set-ClusterQuorum PowerShell command has new additional parameters corresponding to Cloud Witness.

You can configure Cloud Witness with the cmdlet [`Set-ClusterQuorum`](/powershell/module/failoverclusters/set-clusterquorum) using the following PowerShell command:

```PowerShell
Set-ClusterQuorum -CloudWitness -AccountName <StorageAccountName> -AccessKey <StorageAccountAccessKey>
```

In case you need to use a different endpoint (rare):

```PowerShell
Set-ClusterQuorum -CloudWitness -AccountName <StorageAccountName> -AccessKey <StorageAccountAccessKey> -Endpoint <servername>
```

### Azure Storage Account considerations with Cloud Witness

When configuring a Cloud Witness as a quorum witness for your failover cluster, consider the following:
- Instead of storing the Access Key, your failover cluster will generate and securely store a Shared Access Security (SAS) token.
- The generated SAS token is valid as long as the Access Key remains valid. When rotating the Primary Access Key, it is important to first update the Cloud Witness (on all your clusters that are using that Storage Account) with the Secondary Access Key before regenerating the Primary Access Key.
- Cloud Witness uses HTTPS REST interface of the Azure Storage Account service. This means it requires the HTTPS port to be open on all cluster nodes.

### Proxy considerations with Cloud Witness

Cloud Witness uses HTTPS (default port 443) to establish outbound communication with the Azure blob service. Ensure that the HTTPS outbound port is accessible via network Proxy. Azure uses **.core.windows.net** as the Endpoint. You need to ensure that it is included in any firewall allow lists you're using between the cluster and Azure Storage.

## See Also

- [What's New in failover clustering in Windows Server](whats-new-in-failover-clustering.md)
