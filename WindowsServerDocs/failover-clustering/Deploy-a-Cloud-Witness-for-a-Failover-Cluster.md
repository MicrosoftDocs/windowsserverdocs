---
title: Deploy a Cloud Witness for a Failover Cluster
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology:
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2d3f7741-ca13-42d2-a952-747c90393175
author: kumudd
ms.author: kumud
---
# Deploy a Cloud Witness for a Failover Cluster

>Applies To: Windows Server Technical Preview

Cloud Witness is a new type of Failover Cluster quorum witness being introduced in Windows Server 2016 Technical Preview. This topic provides an overview of the Cloud Witness feature, the scenarios that it supports, and instructions about how to configure a cloud witness for a Failover Cluster that is running Windows Server 2016 Technical Preview.
*    [Cloud Witness Overview](#BKMK_CloudWitnessOverview)
*    [Cloud Witness Supported Scenarios](#BKMK_CloudWitnessSupportedScenarios)
*    [Set up a Cloud Witness for a cluster](#BKMK_CloudWitnessSetUp)

## <a name="BKMK_CloudWitnessOverview"></a>Cloud Witness Overview
Figure 1 illustrates a multi-site stretched Failover Cluster quorum configuration with Windows Server 2016 Technical Preview. In this example configuration (figure 1), there are 2 nodes in 2 datacenters (referred to as Sites). Note, it is possible for a cluster to span more than 2 datacenters. Also, each datacenter can have  more than 2 nodes. A typical cluster quorum configuration in this setup (automatic failover SLA) gives each node a vote. One extra vote is given to the quorum witness to allow cluster to keep running even if either one of the datacenter experiences a power outage. The math is simple - there are 5 total votes and you need 3 votes for the cluster to keep it running.  

![](media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_1.png)

**Figure 1: Using a File Share Witness as a quorum witness**  


In case of power outage in one datacenter, to give equal opportunity for the cluster in other datacenter to keep it running, it is recommended to host the quorum witness in a location other than the two datacenters. This typically means requiring a 3<sup>rd</sup> separate datacenter (site) to host a File Server that is backing the File Share which is used as the quorum witness (File Share Witness).  

Most organizations do not have a 3<sup>rd</sup> separate datacenter that will host File Server backing the File Share Witness. This means organizations primarily host the File Server in one of the two datacenters, which by extension, makes that datacenter the primary datacenter. In a scenario where there is power outage in the primary datacenter, the cluster would go down as the other datacenter would only have 2 votes which is below the quorum majority of 3 votes needed. For the customers that have 3<sup>rd</sup> separate datacenter to host the File Server, it is an overhead to maintain the highly available File Server backing the File Share Witness. Hosting virtual machines in the public cloud that have the File Server for File Share Witness running in Guest OS is a significant overhead in terms of both setup & maintenance.  

Cloud Witness is a new type of Failover Cluster quorum witness that leverages Microsoft Azure as the arbitration point (figure 2). It uses Azure Blob Storage to read/write a blob file which is then used as an arbitration point in case of split-brain resolution.  

There are significant benefits which this approach:  

1.  Leverages Microsoft Azure (no need for 3<sup>rd</sup> separate datacenter).  

2.  Uses standard available Azure Blob Storage (no extra maintenance overhead of virtual machines hosted in public cloud).  

3.  Same Azure Storage Account can be used for multiple clusters (one blob file per cluster; cluster unique id used as blob file name).  

4.  Very low on-going $cost to the Storage Account (very small data written per blob file, blob file updated only once when cluster nodes' state changes).  

5.  Built-in Cloud Witness resource type.  


![](media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_2.png)

**Figure 2: Multi-site stretched clusters with Cloud Witness as a quorum witness**  

As shown in figure 2, there is no 3<sup>rd</sup> separate site that is required. Cloud Witness, like any other quorum witness, gets a vote and can participate in quorum calculations.  

## <a name="BKMK_CloudWitnessSupportedScenarios"></a>Cloud Witness: Supported Scenarios for Single Witness Type

If you have a Failover Cluster deployment, where all nodes can reach the internet (by extension of Azure), it is recommended that you configure a Cloud Witness as your quorum witness resource.  

Some of the scenarios that are supported use of Cloud Witness as a quorum witness are as follows:  

-   disaster recovery stretched multi-site clusters (see figure 2).  

-   failover clusters without shared storage (SQL Always On, Exchange DAGs, etc.).  

-   failover clusters running inside Guest OS hosted in Microsoft Azure Virtual Machine Role (or any other public cloud).  

-   failover clusters running inside Guest OS of Virtual Machines hosted in private clouds.

-   storage clusters with or without shared storage, such as Scale-out File Server clusters.  

-   small branch-office clusters (even 2-node clusters)  

Starting with Windows Server 2012 R2, it is recommended to always configure a witness as the cluster automatically manages the witness vote and the nodes vote with Dynamic Quorum.  

## <a name="BKMK_CloudWitnessSetUp"></a> Set up a Cloud Witness for a cluster
To set up a Cloud Witness as a quorum witness for your cluster, complete the following steps:
1. Create an Azure Storage Account to use as a Cloud Witness
2. Configure the Cloud Witness as a quorum witness for your cluster.

## Create an Azure Storage Account to use as a Cloud Witness
 This section describes how to create a storage account and view and copy endpoint URLs and access keys for that account.

To configure Cloud Witness, you must have a valid Azure Storage Account which can be used to store the blob file (used for arbitration). Cloud Witness creates a well-known Container **msft-cloud-witness** under the Microsoft Storage Account. Cloud Witness writes a single blob file with corresponding cluster's unique ID used as the file name of the blob file under this **msft-cloud-witness** container. This means that you can use the same Microsoft Azure Storage Account to configure a Cloud Witness for multiple different clusters.  

When you use the same Azure Storage Account for configuring Cloud Witness for multiple different clusters,  a single **msft-cloud-witness** container gets created automatically. This container will contain one-blob file per cluster.  

### To create a Azure Account
1. Sign in to the [Azure Portal](http://portal.azure.com).
2. On the Hub menu, select New -> Data + Storage -> Storage account.
3. In the Create a storage account page, do the following:
  4. Enter a name for your storage account.

      >[!NOTE]
      > Storage account names must be between 3 and 24 characters in length and may contain numbers and  lowercase letters only.
    Your storage account name must be unique within Azure. The Azure Portal will indicate if the storage account name you select is already in use.
  5. For **Replication**, select **Locally-redundant storage (LRS)** (see figure 3).

     >[!NOTE]
     >Failover Cluster uses the blob file as the arbitration point, which requires some consistency guarantees when reading the data. Hence, it is very important to select **Locally-redundant storage** for **Replication** type.   

      ![](media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_3.png)

      **Figure 3: Creating an Azure Storage account with locally-redundant storage replication type**

### View and copy storage access keys for your Azure Storage Account  

When you create a Microsoft Azure Storage Account, it is associated with two Access Keys that are automatically generated - Primary Access key and Secondary Access key. For a first-time creation of Cloud Witness, use the **Primary Access Key**. There is no restriction regarding which key to use for Cloud Witness.  

#### To view and copy storage access keys

In the Azure Portal, navigate to your storage account, click **All settings** and then click **Access keys** to view, copy, and regenerate your account access keys. The Access Keys blade also includes pre-configured connection strings using your primary and secondary keys that you can copy to use in your applications (see figure 4).

![](media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_4.png)  

**Figure 4: Storage access keys**

### View and copy endpoint URL Links  

When you create a Storage Account, the following URLs are generated using the format: https://&lt;Storage Account Name&gt;.&lt;Storage Type&gt;.&lt;Endpoint&gt;  

Cloud Witness always uses **Blob** as the storage type. Azure uses **.core.windows.net** as the Endpoint. When configuring Cloud Witness, it is possible that you configure it with a different Endpoint as per your scenario (for example the  Microsoft Azure in China has a different Endpoint).  

>[!NOTE]
> The endpoint URL is generated automatically by Cloud Witness resource and there is no extra step of configuration necessary for the URL.  

#### To view and copy endpoint URL links

In the Azure Portal, navigate to your storage account, click **All settings** and then click **Properties** to view and copy your endpoint URLs (see figure 5).  

![](media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_5.png)  

**Figure 5: Cloud Witness endpoint URL links**

 For more information about creating and managing Azure Storage Accounts, see [About Azure Storage Accounts](https://azure.microsoft.com/documentation/articles/storage-create-storage-account/)

## Configure Cloud Witness as a quorum witness for your cluster

Cloud Witness configuration is well-integrated within the existing Quorum Configuration Wizard built into the Failover Cluster Manager.  

### To configure Cloud Witness as a Quorum Witness

1. Launch Failover Cluster Manager.
2. Right-click the cluster -> **More Actions** -> **Configure Cluster Quorum Settings** (see figure 6).This launches the Configure Cluster Quorum Wizard  

  ![](media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_7.png)
  **Figure 6. Cluster Quorum Settings**

1. On the  **Select Quorum Configurations** page, select **Select the quorum witness** (see figure 7).  

  ![](media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_8.png)  
  **Figure 7. Select the Quorum Configuration**

1. On the **Select Quorum Witness** page, select **Configure a cloud witness** (see figure 8).  

  ![](media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_9.png)
  **Figure 8. Select the Quorum Witness**  

1. On the **Configure Cloud Witness** page, enter the following information:

    1.  (Required parameter) Azure Storage Account Name.  

    2.  (Required parameter) Access Key corresponding to the Storage Account.  

        1.  When creating for the first time, use Primary Access Key (see figure 5)  

        2.  When rotating the Primary Access Key, use Secondary Access Key (see figure 5)  

    3.  (Optional parameter) If you intend to use a different Azure service endpoint (for example the Microsoft Azure service in China), then update the endpoint server name.  

  ![](media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_10.png)  
  **Figure 9: Configure your Cloud Witness**

1.  Upon successful configuration of Cloud Witness, you can view the newly created witness resource in the Failover Cluster Manager snap-in (see figure 10).

  ![](media/Deploy-a-Cloud-Witness-for-a-Failover-Cluster/CloudWitness_11.png)
  **Figure 10: Successful configuration of Cloud Witness**

### Configuring Cloud Witness using PowerShell  

The existing Set-ClusterQuorum PowerShell command has new additional parameters corresponding to Cloud Witness.  

You can configure Cloud Witness using the following PowerShell command:  

    Set-ClusterQuorum -CloudWitness -AccountName <StorageAccountName> -AccessKey <StorageAccountAccessKey>  

In case you need to use a different endpoint (rare):  

    Set-ClusterQuorum -CloudWitness -AccountName <StorageAccountName> -AccessKey <StorageAccountAccessKey> -Endpoint <servername>  


### Azure Storage Account considerations with Cloud Witness  
 When configuring a Cloud Witness as a quorum witness for your failover cluster, consider the following:
*  Failover Cluster will not store the Access Key, but rather it will generate a Shared Access Security (SAS) token that is generated using the Access Key provided and stores this SAS Token securely.  

*  The generated SAS token is valid as long as the Access Key remains valid. When rotating the Primary Access Key, it is important to first update the Cloud Witness (on all your clusters that are using that Storage Account) with the Secondary Access Key before regenerating the Primary Access Key.  

*  Cloud Witness uses HTTPS REST interface of the Azure Storage Account service. This means it requires the HTTPS port to be open on all cluster nodes.  
## See Also
-   [What's New in Failover Clustering in Windows Server Technical Preview](whats-new-failover-clustering-windows-server.md)
