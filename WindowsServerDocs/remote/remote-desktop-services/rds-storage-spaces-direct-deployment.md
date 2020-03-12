---
title: Deploy a two-node Storage Spaces Direct SOFS for UPD storage in Azure
description: Learn how to use Storage Spaces Direct with RDS.
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: remote-desktop-services
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1099f21d-5f07-475a-92dd-ad08bc155da1
author: haley-rowland
ms.author: harowl
ms.date: 07/17/2018
manager: scottman
---
# Deploy a two-node Storage Spaces Direct scale-out file server for UPD storage in Azure

>Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016

Remote Desktop Services (RDS) requires a domain-joined file server for user profile disks (UPDs). To deploy a high availability domain-joined scale-out file server (SOFS) in Azure, use Storage Spaces Direct with Windows Server 2016. If you're not familiar with UPDs or Remote Desktop Services, check out [Welcome to Remote Desktop Services](welcome-to-rds.md).

> [!NOTE] 
> Microsoft just published an [Azure template to deploy a Storage Spaces Direct scale-out file server](https://azure.microsoft.com/documentation/templates/301-storage-spaces-direct/)! You can use the template to create your deployment, or use the steps in this article. 

We recommend deploying your SOFS with DS-series VMs and premium storage data disks, where there are the same number and size of data disks on each VM. You will need a minimum of two storage accounts. 

For small deployments, we recommend a 2-node cluster with a cloud witness, where the volume is mirrored with 2 copies. Grow small deployments by adding data disks. Grow larger deployments by adding nodes (VMs). 

These instructions are for a 2-node deployment. The following table shows the VM and disk sizes you'll need to store UPDs for the number of users in your business. 

| Users | Total (GB) | VM | # Disks | Disk type | Disk size (GB) | Configuration   |
|-------|------------|----|---------|-----------|----------------|-----------------|
| 10    | 50         | DS1 | 2       | P10       | 128            | 2x(DS1 + 2 P10)  |
| 25    | 125        | DS1 | 2       | P10       | 128            | 2x(DS1 + 2 P10)  |
| 50    | 250        | DS1 | 2       | P10       | 128            | 2x(DS1 + 2 P10)  |
| 100   | 500        | DS1 | 2       | P20       | 512            | 2x(DS1 + 2 P20)  |
| 250   | 1250       | DS1 | 2       | P30       | 1024           | 2x(DS1 + 2 P30)  |
| 500   | 2500       | DS2 | 3       | P30       | 1024           | 2x(DS2 + 3 P30)  |
| 1000  | 5000       | DS3 | 5       | P30       | 1024           | 2x(DS3 + 5 P30)  |
| 2500  | 12500      | DS4 | 13      | P30       | 1024           | 2x(DS4 + 13 P30) |
| 5000  | 25000      | DS5 | 25      | P30       | 1024           | 2x(DS5 + 25 P30) | 

Use the following steps to create a domain controller (we called ours "my-dc" below) and two node VMs ("my-fsn1" and "my-fsn2") and configure the VMs to be a 2-node Storage Spaces Direct SOFS.

1. Create a [Microsoft Azure subscription](https://azure.microsoft.com).
2. Sign into the [Azure portal](https://ms.portal.azure.com).
3. Create an [Azure storage account](https://azure.microsoft.com/documentation/articles/storage-create-storage-account/#create-a-storage-account) in Azure Resource Manager. Create it in a new resource group and use the  following configurations:
   - Deployment model: Resource Manager
   - Type of storage account: General purpose
   - Performance tier: Premium
   - Replication option: LRS
4. Set up an Active Directory forest by either using a quickstart template or deploying the forest manually. 
   - Deploy using an Azure quickstart template:
      - [Create an Azure VM with a new AD forest](https://azure.microsoft.com/documentation/templates/active-directory-new-domain/)
      - [Create a new AD domain with 2 domain controllers](https://azure.microsoft.com/documentation/templates/active-directory-new-domain-ha-2-dc/) (for high availability)
   - Manually [deploy the forest](https://azure.microsoft.com/documentation/articles/active-directory-new-forest-virtual-machine/) with the following configurations:
      - Create the virtual network in the same resource group as the storage account.
      - Recommended size: DS2 (increase the size if the domain controller will host more domain objects)
      - Use an automatically generated VNet.
      - Follow the steps to install AD DS.
5. Set up the file server cluster nodes. You can do this by deploying the [Windows Server 2016 Storage Spaces Direct SOFS cluster Azure template](https://azure.microsoft.com/resources/templates/301-storage-spaces-direct/) or by following steps 6-11 to deploy manually.
6. To manually set up the file server cluster nodes:
   1. Create the first node: 
      1. Create a new virtual machine using the Windows Server 2016 image. (Click **New > Virtual Machines > Windows Server 2016.** Select **Resource Manager**, and then click **Create**.)
      2. Set the basic configuration as follows:
         - Name: my-fsn1
         - VM disk type SSD
         - Use an existing resource group, the one that you created in step 3. 
      3. Size: DS1, DS2, DS3, DS4, or DS5 depending on your user needs (see table at beginning of these instructions). Ensure premium disk support is selected.
      4. Settings: 
         - Storage account: Choose the storage account you created in step 3.
         - High Availability - create a new availability set. (Click **High Availability > Create new**, and then enter a name (for example, s2d-cluster). Use the default values for **Update domains** and **Fault domains**.)
   2. Create the second node. Repeat the step above with the following changes:
      - Name: my-fsn2
      - High Availability - select the availability set you created above.  
7. [Attach data disks](https://azure.microsoft.com/documentation/articles/virtual-machines-windows-attach-disk-portal/) to the cluster node VMs according to your user needs (as seen in the table above). After the data disks are created and attached to the VM, set **host caching** to **None**.
8. Set IP addresses for all VMs to **static**. 
   1. In the resource group, select a VM, and then click **Network interfaces** (under **settings**). Select the listed network interface, and then click **IP Configurations**. Select the listed IP configuration, select **static**, and then click **Save**.
   2. Note the domain controller (my-dc for our example) private IP address (10.x.x.x).
9. Set primary DNS server address on NICs of the cluster node VMs to the my-dc server. Select the VM, and then click **Network Interfaces > DNS servers > Custom DNS**. Enter the private IP address you noted above, and then click **Save**.
10. Create an [Azure storage account to be your cloud witness](https://docs.microsoft.com/windows-server/failover-clustering/deploy-cloud-witness). (If you use the linked instructions, stop when you get to "Configuring Cloud Witness with Failover Cluster Manager GUI" - we'll do that step below.)
11. Set up the Storage Spaces Direct file server. Connect to a node VM, and then run the following Windows PowerShell cmdlets.
    1. Install Failover Clustering Feature and File Server Feature on the two file server cluster node VMs:

       ```powershell
       $nodes = ("my-fsn1", "my-fsn2")
       icm $nodes {Install-WindowsFeature Failover-Clustering -IncludeAllSubFeature -IncludeManagementTools} 
       icm $nodes {Install-WindowsFeature FS-FileServer} 
       ```
    2. Validate cluster node VMs and create 2-node SOFS cluster:

       ```powershell
       Test-Cluster -node $nodes
       New-Cluster -Name MY-CL1 -Node $nodes –NoStorage –StaticAddress [new address within your addr space]
       ``` 
    3. Configure the cloud witness. Use your cloud witness storage account name and access key.

       ```powershell
       Set-ClusterQuorum –CloudWitness –AccountName <StorageAccountName> -AccessKey <StorageAccountAccessKey> 
       ```
    4. Enable Storage Spaces Direct.

       ```powershell
       Enable-ClusterS2D 
       ```
      
    5. Create a virtual disk volume.

       ```powershell
       New-Volume -StoragePoolFriendlyName S2D* -FriendlyName VDisk01 -FileSystem CSVFS_REFS -Size 120GB 
       ```
       To view information about the cluster shared volume on the SOFS cluster, run the following cmdlet:

       ```powershell
       Get-ClusterSharedVolume
       ```
   
    6. Create the scale-out file server (SOFS):

       ```powershell
       Add-ClusterScaleOutFileServerRole -Name my-sofs1 -Cluster MY-CL1
       ```

    7. Create a new SMB file share on the SOFS cluster.

       ```powershell
       New-Item -Path C:\ClusterStorage\VDisk01\Data -ItemType Directory
       New-SmbShare -Name UpdStorage -Path C:\ClusterStorage\VDisk01\Data
       ```

You now have a share at `\\my-sofs1\UpdStorage`, which you can use for UPD storage when you [enable UPD](https://social.technet.microsoft.com/wiki/contents/articles/15304.installing-and-configuring-user-profile-disks-upd-in-windows-server-2012.aspx) for your users. 
