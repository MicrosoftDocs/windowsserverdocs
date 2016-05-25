---
title: Step 3 Create storage spaces CSVs and file shares on the Scale-Out File Server
ms.custom: na
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 75330c33-5463-4a26-9508-650f5a7bf3cc
author: JasonGerend
---
# Step 3 Create storage spaces CSVs and file shares on the Scale-Out File Server
This topic discusses how to create virtual disks, CSVs, and file shares on a Scale\-Out File Server that uses Storage Spaces to store your data \(likely Hyper\-V VMs and virtual hard disks\).  
  
Before using this topic, you should already have created the Scale\-Out File Server, and done the other steps in [Step 2 Create the Scale-Out File Server and storage pools](../Topic/Step-2-Create-the-Scale-Out-File-Server-and-storage-pools.md).  
  
Here's what's in this topic:  
  
-   [Step 1: Create a security group for Hyper\-V computer accounts](#BKMK_CreateSecGroup)  
  
-   [Step 2 Create virtual disks, and CSVs](#BKMK_Step1_CreateSpaces)  
  
-   [Step 3: Create file shares](#BKMK_Step2_CreateShares)  
  
-   [Step 3: Update key settings on the cluster nodes](#BKMK_UpdateSettings)  
  
-   [Step 4: Deploy SMB Direct](#BKMK_Step3_DeploySMBDirect)  
  
## <a name="BKMK_CreateSecGroup"></a>Step 1: Create a security group for Hyper\-V computer accounts  
If you're going to use this storage solution for storing Hyper\-V virtual machines and virtual hard disks, you must create a security group for all the Hyper\-V computer accounts, if you don't already have one. Note that if you're using System Center Virtual Machine Manager, we'd suggest skipping this step and using VMM to provision your file shares \- VMM can handle all the permissions for you.  
  
1.  Use Active Directory Administration Center or Windows PowerShell to create a security group named **Hyper\-V Server Computer Accounts** \(for example\) to contain all the Hyper\-V servers that use file server\-based storage.  Create the domain global group in the same domain as the file server cluster and any Hyper\-V servers that will use the cluster for storage. Here's an example of doing this with Windows PowerShell:  
  
    ```  
    New-ADGroup -GroupCategory:"Security" -GroupScope:"Global" -Name:"Hyper-V Server Computer Accounts" -Path:"CN=Users,DC=contoso,DC=com" -SamAccountName:"Hyper-V Computer Accounts" -Server:"dc1.contoso.com"  
    ```  
  
2.  After creating the security group, add the following computer accounts as members of the group:  
  
    -   Computer accounts for all Hyper\-V servers or cluster nodes that use the clustered file server for storage  
  
    -   The cluster name account \(also known as cluster name object or CNO\) for all clustered Hyper\-V roles that use the clustered file server for storage  
  
    Here's an example of doing this with Windows PowerShell:  
  
    ```  
    Set-ADGroup -Add:@{'Member'="CN=MGMT01,CN=Computers,DC=contoso,DC=com", "CN=MGMT02,CN=Computers,DC=contoso,DC=com"} -Identity:"CN=Hyper-V Computer Accounts,CN=Users,DC=contoso,DC=com" -Server:"dc1.contoso.com"  
    ```  
  
> [!NOTE]  
> You'll have to update the group membership when you add cluster nodes unless you use System Center Virtual Machine Manager to create your shares.  
  
## <a name="BKMK_Step1_CreateSpaces"></a>Step 2 Create virtual disks, and CSVs  
Use the following procedures to create the storage spaces \(virtual disks\), and cluster shared volumes \(CSVs\) for your storage solution. We suggest that you create all of your storage spaces  before deploying your workloads so that your workloads are balanced across your cluster nodes.  
  
You can use Failover Cluster Manager or Windows PowerShell to create your virtual disks and CSVs. While Virtual Machine Manager doesn't currently create storage spaces with tiers, it is a great way to create the shares after you've created the CSVs, because VMM will handle the permissions for you.  
  
> [!IMPORTANT]  
> If you're using Failover Cluster Manager or Server Manager to create virtual disks, make sure that you've already set the appropriate storage pool settings for enclosure awareness and column count, as described in the [Step 4: Set storage pool defaults](../Topic/Step-2-Create-the-Scale-Out-File-Server-and-storage-pools.md#BKMK_Step4_SetDefaults) section of [Step 2 Create the Scale-Out File Server and storage pools](../Topic/Step-2-Create-the-Scale-Out-File-Server-and-storage-pools.md).  
  
### To create a virtual disk and CSV by using Server Manager  
If you're just creating one or two virtual disks, Server Manager provides a simple way to create them and add them to CSVs. If you have more virtual disks to create or need to create virtual disks that will store very large files, such as .vhdx files larger than 1 TB, we suggest using Windows PowerShell so that you can automate the process and format the volumes with the large FRS setting that enables large .vhdx files to be extended.  
  
##### To create a storage space and CSV  
  
1.  In Failover Cluster Manager, select the file server cluster, and then go to **Storage** > **Pools**.  
  
2.  Select the pool in which you want to create a virtual disk, and then click **New Virtual Disk** to open the New Virtual Disk Wizard.  
  
3.  On the **Storage Pool** page of the wizard, select the appropriate pool \(if you have multiple pools\).  
  
4.  On the **Virtual Disk Name** page, enter a name for the virtual disk.  
  
    Select the **Create storage tiers on this virtual disk** checkbox if your storage design calls for storage tiers.  
  
    > [!IMPORTANT]  
    > Make sure to leave enough free space in your pool to allow Storage Spaces to repair virtual disks after a disk failure. For more info, see [Software-Defined Storage Design Considerations Guide](../Topic/Software-Defined-Storage-Design-Considerations-Guide.md).  
  
5.  On the **Storage Layout** page, click the appropriate layout for the storage space \(**Mirror** for example\).  
  
6.  On the **Resiliency Settings** page, click the appropriate resiliency type \(such as **Two\-way mirror\)**.  
  
7.  On the **Size** page, enter the tier sizes as specified in your storage design.  
  
8.  On the **Drive Letter or Folder** page of the **New Volume Wizard**, optionally specify a drive letter.  
  
9. After the virtual disk and volume are created, in Failover Cluster Manager go to **Storage** > **Disks**, right\-click the newly created disk, and then click **Add to Cluster Shared Volumes**. This makes the virtual disk a CSV.  
  
10. Repeat this procedure to create any other virtual disks specified in your storage design.  
  
### To create storage spaces and CSVs by using Windows PowerShell  
You can use the ProvisionStorageConfiguration.ps1 script to automatically  create storage pools and virtual disks according to recommended best practices. For more information, see [Storage Spaces Deployment Guide for Automation Scripts](http://social.technet.microsoft.com/wiki/contents/articles/31664.storage-spaces-deployment-guide-for-automation-scripts.aspx). Alternatively, here's a somewhat simpler script example that you can use to create a single virtual disk with storage tiers:  
  
```  
 <Script is untested - sizes might not work in variables as-is>  
$StoragePoolFriendlyName = "Pool1"  
$VirtualDiskName = "VirtualDisk01"  
$SSDTierSize = 100GB  
$HDDTierSize = 100GB  
  
$SSDTier = New-StorageTier -StoragePoolFriendlyName $StoragePoolFriendlyName `  
            -FriendlyName ([string]($VirtualDiskName) + "_SSD_Tier") -MediaType SSD  
  
$HDDTier = New-StorageTier -StoragePoolFriendlyName $StoragePoolFriendlyName  `  
            -FriendlyName ([string]($VirtualDiskName) + "_HDD_Tier") -MediaType HDD  
  
Get-StoragePool -FriendlyName $StoragePoolFriendlyName -StorageSubsystemFriendlyName "Clustered Storage Spaces*"  |  
New-VirtualDisk -FriendlyName $VirtualDiskName –StorageTiers $SSDTier, $HDDTier -StorageTierSizes $SSDTierSize, $HDDTierSize |  
Initialize-Disk -PassThru |  
New-Partition -AssignDriveLetter -UseMaximumSize |  
Format-Volume -AllocationUnitSize 64KB –UseLargeFRS   
```  
  
## <a name="BKMK_Step2_CreateShares"></a>Step 2: Create file shares  
After you've created your virtual disks and added them to CSVs, it's time to create file shares on them. System Center Virtual Machine Manager \(VMM\) is probably the handiest way to do this because it handles permissions for you, but if you don't have it in your environment, you can use Server Manager if you've got a small number of shares to create or Windows PowerShell if you have more.  
  
### To create a file share for Hyper\-V storage  by using Server Manager  
If you have only a few file shares to create, you can use Server Manager easily create them.  
  
##### To create a file share for Hyper\-V storage  by using Server Manager  
  
1.  Create a security group named **Hyper\-V Server Computer Accounts** \(for example\) to contain all the Hyper\-V servers that use file server\-based storage.  
  
    Create the domain global group in the same domain as the file server cluster and any Hyper\-V servers that will use the cluster for storage. You can use Active Directory Administration Center, Windows Powershell or another tool to do this.  
  
2.  Add the following computer accounts as members of the group:  
  
    -   Computer accounts for all Hyper\-V servers or cluster nodes that use the clustered file server for storage  
  
    -   The cluster name account \(also known as cluster name object or CNO\) for all clustered Hyper\-V roles that use the clustered file server for storage  
  
    > [!NOTE]  
    > You'll have to update the group membership when you add cluster nodes unless you use System Center Virtual Machine Manager to create your shares.  
  
3.  Go to **Roles**, select the appropriate Scale\-Out File Server, and then click **Add File Share** to open the New Share Wizard.  
  
4.  On the **Select Profile** page of the wizard, click **SMB Share \- Applications**.  
  
    If you're creating a file share for use as a file share witness for another cluster, instead click **SMB Share \- Quick**.  
  
5.  On the **Share Location** page, select the CSV that you just created.  
  
    If you're creating a file share witness, instead select the virtual disk you're using as the file server cluster's disk witness \(or another virtual disk that you created without a CSV for use as a witness\).  
  
6.  On the **Share Name** page, type a name for the share \(for example, **VMs1$**\) in the Share name box.  
  
    > [!TIP]  
    > Consider hiding the share from casual browsers by putting a **$** after the share name.  
  
7.  On the **Other Settings** page, optionally select the **Encrypt data access** checkbox if your storage design uses SMB encryption.  
  
    If you're creating a file share witness, clear the **Enable continuous availability** checkbox.  
  
8.  On the **Permissions** page, click **Customize permissions…** to open the Advanced Security Settings window, shown in Figure 1.  
  
    ![](../Image/F01-SOFS-Share-Permissions.png)  
  
    **Figure 1** NTFS permissions for a share storing Hyper\-V VMs and virtual hard disks  
  
9. Click **Disable inheritance**, and then **Remove all inherited permissions from this object**.  
  
10. Assuming that you're using the share to host Hyper\-V files, click **Add**, and then grant the following principals \(shown in Figure 1\) Full Control file system permissions to **This folder, subfolders and files** \(we suggest leaving the share permissions at Everyone \= Full Control for simplicity\):  
  
    -   The group you created for all the Hyper\-V servers that use file server\-based storage \(For example, **Hyper\-V Server Computer Accounts**\)  
  
    -   The **Domain Admins** group, and\/or whatever groups you use to administer this file server cluster and related Hyper\-V servers  
  
    -   The **SYSTEM** account of the file server cluster  
  
    -   **CREATOR OWNER**  
  
    > [!IMPORTANT]  
    > If you're using the share to store Microsoft SQL Server databases directly, make sure to grant Full Control permissions to the SQL Server service account as well.  
  
11. Click **Create** when you're finished with the wizard.  
  
    The share appears in Failover Cluster Manager under **Roles** on the **Shares** tab.  
  
### To create file shares by using Windows PowerShell  
We're still working on this content and will publish it as soon as it's ready \- sorry for the delay\!  
  
## <a name="BKMK_UpdateSettings"></a>Step 3: Update key settings on the cluster nodes  
There are some settings that we recommend changing based on our experience with Storage Spaces in large\-scale environments, as discussed in the following tasks.  
  
-   **Storage Spaces repair registry updates** \- There are some manual steps that you must take to update the way Storage Spaces repairs virtual disks \- see [Optimize Storage Spaces repair settings on Scale-Out File Servers with the November 2014 update rollup](../Topic/Optimize-Storage-Spaces-repair-settings-on-Scale-Out-File-Servers-with-the-November-2014-update-rollup.md) for more information.  
  
-   **Windows file\-delete notification \(trim\/unmap\)** \- Although Windows has built\-in support for file\-delete notification \(issuing trim commands to reclaim SSD storage\), we recommend disabling Windows file\-delete notification on servers that use Storage Spaces. To do so, from an elevated command prompt, use the following command on each node of the cluster: `Fsutil behavior set DisableDeleteNotify 1`  
  
-   **Multipath I\/O \(MPIO\) settings** \- If you're using multiple SAS connections to your storage enclosure, enable MPIO on each node of the cluster so that Storage Spaces can communicate with the enclosures over multiple cables. You'll also want to set the global MPIO policy \- Round Robin is the default policy, but according to our internal testing, Least Blocks provides increased performance under most circumstances.  
  
    To max out your performance, you can also set the policy on individual SSDs to Round Robin \(which has the effect of using Least Blocks for your HDDs, and Round Robin for SSDs\). To set the MPIO policy for individual SSDs, use the Mpclaim.exe command from each node to set the MPIO policy for each SSD. For example, to set the MPIO policy to Round Robin \(represented by a 2 in MPclaim\) for disk 10, use this command from an elevated command prompt: `Mpclaim -l -d 10 2`.  
  
-   **Physical disk caches** \- In some cases leaving disk\-based write\-caches enabled can decrease performance so we recommend disabling them on all disks. To do so, use the Diskcache.exe tool, as described in Microsoft Knowledge Base article [811392](http://support.microsoft.com/kb/811392).  
  
## <a name="BKMK_Step3_DeploySMBDirect"></a>Step 4: Deploy SMB Direct  
If you're using RDMA networking for your file server cluster, after creating virtual disks and shares, the next step is to deploy SMB Direct, which is the Windows Server implementation of RDMA. For help with this task, see [Improve Performance of a File Server with SMB Direct](../Topic/Improve-Performance-of-a-File-Server-with-SMB-Direct.md).  
  
It's also important to note that if you're using the RoCE flavor of RDMA, you must configure Priority Flow Control \(PFC\). This includes configuring PFC on all servers on the RDMA network and the switches being used. This process is described [Deploy SMB Direct with RoCE Network Adapters](../Topic/Deploy-SMB-Direct-with-RoCE-Network-Adapters.md).  
  
## Next steps  
After deploying your clustered file server, we recommend testing the performance of your solution using synthetic workloads prior to migrating your production workloads. This lets you confirm that the solution is performing properly and work out any lingering issues before placing it into production.  
  
For more information, see [Test Storage Spaces Performance Using Synthetic Workloads in Windows Server](../Topic/Test-Storage-Spaces-Performance-Using-Synthetic-Workloads-in-Windows-Server.md).  
  
## See Also  
[Configuring a File Share Witness on a Scale\-Out File Server](http://blogs.msdn.com/b/clustering/archive/2014/03/31/10512457.aspx)  
  
