---
title: Configure Stretch Cluster Replication using shared storage in Windows Server
description: Stretch cluster replication using shared storage
ms.author: daknappe
ms.topic: how-to
author: dknappettmsft
ms.date: 04/16/2025
---

# Stretch cluster replication using shared storage

This evaluation example allows you to configure computers and their storage in a single stretch cluster, where two nodes share one set of storage and two nodes share another set of storage, then replication keeps both sets of storage mirrored in the cluster to allow immediate failover. These nodes and their storage should be located in separate physical sites, although it isn't required. There are separate steps for creating Hyper-V and File Server clusters as sample scenarios.

> [!IMPORTANT]
> Servers in different sites must be able to communicate with the other servers via a network, but not have any physical connectivity to the other site's shared storage. This scenario doesn't make use of Storage Spaces Direct.

This walkthrough uses the following environment as an example:

- Four servers named **SR-SRV01**, **SR-SRV02**, **SR-SRV03**, and **SR-SRV04**.

- The four servers are formed into a single cluster called **SR-SRVCLUS**.

- A pair of logical "sites" that represents two different data centers. One called **Redmond** and the other called **Bellevue**.

- Servers **SR-SRV01** and **SR-SRV02** belong to the **Redmond** site.

- Servers **SR-SRV03** and **SR-SRV04** belong to the **Bellevue** site.

![Diagram showing two nodes in Redmond replicating with two nodes of the same cluster in the Bellevue site.](./media/Stretch-Cluster-Replication-Using-Shared-Storage/Storage_SR_StretchClusterExample.png)

> [!NOTE]
> You can use only as few as two nodes, where one node each is in each site. However, you can't perform intra-site failover with only two servers. You can use as many as 64 nodes.

## Prerequisites

- **Software**:

  - 2-64 servers running Windows Server 2016 Datacenter Edition or later. If you're running Windows Server 2019, you can use Standard Edition if you're comfortable replicating only a single volume up to 2 TB in size.
  - The **Active Directory Domain Services** role, **Failover Clustering**, and **Storage Replica** features must be installed on your device. To learn more, see [Install or Uninstall Roles, Role Services, or Features](/windows-server/administration/server-manager/install-or-uninstall-roles-role-services-or-features).
  - Your device must be part of an Active Directory (AD) forest.
  - Appropriate firewall and router rules to allow ICMP, SMB port 445, SMB Direct port 5445, and WS-MAN port 5985 bidirectional traffic between all nodes.

- **Hardware**:

  - At least 2 GB of RAM and two cores per server. You'll need more RAM and cores for virtual machine environments.
  - Two sets of shared storage, using SAS JBODs (such as with Storage Spaces), Fibre Channel SAN, Shared VHDX, or iSCSI Target.
  - The storage should contain a mix of HDD and SSD media and must support Persistent Reservation. Each storage set should be available to two of the servers only (asymmetric).
    - The physical storage must be identical in capacity, have the same sector sizes on all the data disks and log disks.
    - The data and log disks must be initialized as GPT.
    - The volumes must be formatted as NTFS or ReFS.
    - The log volumes should use flash-based storage and high performance resiliency settings. Microsoft recommends that the log storage be faster than the data storage.
    - The log size defaults to 8 GB if unspecified. Your log volume must be at least 10 GB or larger based on log requirements and organizational needs.
  - Each set of storage must allow creation of at least two virtual disks, one for replicated data and one for logs.
  - The replicated storage can't be located on the drive containing the Windows operating system folder.

- **Disk configuration**:

  - **JBOD enclosures**

    - Ensure that each set of paired server nodes can see that site's storage enclosures only (asymmetric storage) and that the SAS connections are correctly configured.

    - Provision the storage using Storage Spaces by following **steps 1-3** provided in [Deploy Storage Spaces on a stand-alone server](/windows-server/storage/storage-spaces/deploy-standalone-storage-spaces) using PowerShell or Server Manager.

  - **iSCSI storage**

    - Ensure that each set of paired server nodes can see that site's storage enclosures only, such as asymmetric storage. You should use more than one single network adapter if using iSCSI.

    - Provision the storage using your vendor documentation. If using Windows-based iSCSI Targeting, see the [iSCSI Target Server overview](/windows-server/storage/iscsi/iscsi-target-server).

  - **For FC SAN storage:**

    - Ensure that each set of paired server nodes can see that site's storage enclosures only (asymmetric storage) and that you properly zoned the hosts.

    - Provision the storage using your vendor documentation.

- **Network**:

  - At least one 1-GbE connection on each server for synchronous replication.
  - A network between servers with sufficient bandwidth to contain your IO write workload and an average of ~5ms round trip latency for synchronous replication. Asynchronous replication doesn't have a latency recommendation.

> [!NOTE]
> Data disks can use either mirrored or parity spaces or RAID 1 or 10, RAID 5 or RAID 50.
>
> Log volumes must never be used for other workloads.

> [!IMPORTANT]
> While it's possible to attach a storage device to a single server and use this for replication, Windows Failover Clustering still relies on SCSI Persistent Reservations. Therefore, the storage must still be a Shared Storage type such as a SAN technology. Local disks or disks presented by a hypervisor might not be compatible. In Azure, the disks must be a premium SSD size that supports sharing, even if only one VM is to be attached to it.

Many of these requirements can be determined by using the [Test-SRTopology](/powershell/module/storagereplica/test-srtopology) cmdlet. You get access to this tool if you install Storage Replica or the Storage Replica Management Tools features on at least one server. There's no need to configure Storage Replica to use this tool, only to install the cmdlets.

## Provision your environment

Always sign in as a domain user who is a member of the built-in administrator group on all servers. Always run PowerShell or the command prompt with elevated privileges.

1. Install Windows Server on all server nodes, using either the Server with Desktop Experience or Server Core installation options.

1. Ensure that BIOS/UEFI settings for servers are set to high performance, such as disabling C-State, setting QPI speed, enabling NUMA, and setting the highest memory frequency. Ensure power management in Windows Server is set to high performance. Restart as required.

1. Add the network information and join the nodes to the domain, then restart them.

   > [!NOTE]
   > This guide presumes you have two pairings of servers for use in a stretch cluster. A WAN or LAN network separates the servers and the servers belong to either physical or logical sites.

1. Connect the first set of shared JBOD storage enclosure, Shared VHDX, iSCSI target, or FC SAN to the servers in **Redmond** site.

1. Connect the second set of storage to the servers in **Bellevue** site.

1. Install the latest vendor storage and enclosure firmware, all necessary drivers, HBA drivers, and BIOS/UEFI firmware on all four nodes. Restart the nodes as needed.

   > [!NOTE]
   > Consult your hardware vendor documentation for configuring shared storage and networking hardware.

In the next step, the servers will be added and configured with the necessary roles and features:

1. In **Server Manager**, select **Manage**, then select **Add Servers**.

1. In the **Add Servers** window, select your servers through the following methods:

   1. **AD** (the servers must be joined to the domain)

   1. **DNS** (computer name or IP)

   1. **Import** (from text file)

1. Once you select your servers, import them using the "&rarr;" button, then select **OK**.

1. On **SR-SRV04** or a remote management computer, run the following command in an elevated PowerShell window:

   ```powershell
   $Servers = 'SR-SRV01','SR-SRV02','SR-SRV03','SR-SRV04'

   $Servers | foreach { Install-WindowsFeature -ComputerName $_ -Name Storage-Replica,Failover-Clustering,FS-FileServer -IncludeManagementTools -Restart }
   ```

## Configure a Hyper-V Failover Cluster or File Server cluster

After you set up your server nodes, the next step is to create a Hyper-V failover cluster or a File Server cluster. If the nodes reside in different subnets, then an IP Address for the additional site must be created using the "OR" dependency. To learn more, see [Configuring IP Addresses and Dependencies for Multi-Subnet Clusters – Part III](https://techcommunity.microsoft.com/t5/Failover-Clustering/Configuring-IP-Addresses-and-Dependencies-for-Multi-Subnet/ba-p/371698).

If you're creating a two-node stretch cluster, you must add all storage before continuing. This is a by-design behavior in Windows Server 2016. Run the following command to add available storage:

```powershell
Get-ClusterAvailableDisk -All | Add-ClusterDisk
```

When using a test server with no write IO load on a specified source volume, consider adding a workload as `Test-SRTopology` doesn't generate a useful report. You should test with production-like workloads in order to see real world numbers and recommended log sizes.

Alternatively, copy some files into the source volume during the test or download and run [diskspd](https://github.com/Microsoft/diskspd/releases) to generate write IOs. For example, to sample a low write IO workload for 10 minutes on the **D:** volume, run the following command:

```
diskspd -c1g -d600 -W5 -C5 -b4k -t2 -o2 -r -w5 -i100 D:\Test.dat
```

No option is available to configure site awareness using Failover Cluster Manager in Windows Server 2016.

> [!NOTE]
> Configure a File Share Witness or Cloud Witness to provide quorum if a site goes down. Windows Server now includes an option for [Cloud (Azure)-based Witness](../../failover-clustering/deploy-cloud-witness.md). You can choose this quorum option instead of the file share or disk witness.
>
> For more information about quorum configuration, see the [Configure and Manage the Quorum in a Windows Server 2012 Failover Cluster guide's Witness Configuration](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj612870(v=ws.11)). For more information on the cluster quorum cmdlets, see the [FailoverClusters](/powershell/module/failoverclusters/) module set.

> [!TIP]
> Review [Network Recommendations for a Hyper-V Cluster in Windows Server 2012](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/dn550728(v=ws.11)) to ensure cluster networking is optimally configured. Configure cluster networking and AD for faster DNS site failover. You can utilize Hyper-V software defined networking, stretched VLANs, network abstraction devices, lowered DNS TTL, and other common techniques.
>
> You can also configure VM resiliency so that guests don't pause for long during node failures. Instead, they fail over to the new replication source storage within 10 seconds. To perform this action, run the `(Get-Cluster).ResiliencyDefaultPeriod=10` command.

# [Hyper-V Failover Cluster](#tab/hyperv-failover)

1. In **Server Manager**, select **Tools**, then select **Failover Cluster Manager**.

1. In the right pane, under **Actions**, select **Validate Configuration** to ensure you can proceed.

   > [!NOTE]
   > You should expect storage errors from cluster validation due to the use of asymmetric storage.

1. Create the Hyper-V compute cluster with 15 characters or fewer using the [Deploy a Hyper-V Cluster](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/jj863389(v=ws.11)) guide. Follow **steps 7-10** within the **Redmond** site to create a test virtual machine only to ensure the cluster is working normally within the two nodes sharing the storage in the first test site.

1. Add one disk in the **Redmond** site to the cluster CSV. Right-click a source disk in the **Disks** node of the **Storage** section, and then select **Add to Cluster Shared Volumes**.

1. The `Test-SRTopology` cmdlet is used to determine if the Storage Replica requirements are met. For example, to validate two of the proposed stretch cluster nodes where each have a **D:** and **E:** volume for 30 minutes, perform the following steps:

   1. Move all available storage to **SR-SRV01**.
   1. In **Failover Cluster Manager**, expand your cluster, right-click on **Roles**, then select **Create Empty Role**.
   1. Add the online storage to the empty role named **New Role**.
   1. Move all available storage to **SR-SRV03**.
   1. Right-click on **Roles** again, then select **Create Empty Role**.
   1. Move **New Role (2)** to **SR-SRV03**.
   1. Add the online storage to that empty role named **New Role (2)**.
   1. Evaluate the cluster with by running the following command:

      ```powershell
      $params = @{
         SourceComputerName       = 'SR-SRV01'
         SourceVolumeName         = 'D:'
         SourceLogVolumeName      = 'E:'
         DestinationComputerName  = 'SR-SRV03'
         DestinationVolumeName    = 'D:'
         DestinationLogVolumeName = 'E:'
         DurationInMinutes        = 30
         ResultPath               = 'C:\Temp'
      }
      MD C:\Temp | Test-SRTopology @params
      ```

1. Examine the **TestSrTopologyReport-\<date>.html** report to ensure you meet the Storage Replica requirements and note the initial sync time prediction and log recommendations.

   ![A screenshot of the Storage Replica replication report for a Hyper-V Failover Cluster.](./media/Stretch-Cluster-Replication-Using-Shared-Storage/SRTestSRTopologyReport.png)

1. Return the disks to **Available Storage** and remove the temporary empty roles.

1. Remove the test virtual machine. Add any real test virtual machines needed for further evaluation to a proposed source node.

1. Configure stretch cluster site awareness so that servers **SR-SRV01** and **SR-SRV02** are in the **Redmond** site, servers **SR-SRV03** and **SR-SRV04** are in the **Bellevue** site. Ensure that **Redmond** is the primary node that has ownership of the source storage and VMs:

   ```powershell
   New-ClusterFaultDomain -Name Redmond -Type Site -Description "Primary" -Location "Redmond Datacenter"

   New-ClusterFaultDomain -Name Bellevue -Type Site -Description "Secondary" -Location "Bellevue Datacenter"

   Set-ClusterFaultDomain -Name SR-SRV01 -Parent Redmond
   Set-ClusterFaultDomain -Name SR-SRV02 -Parent Redmond
   Set-ClusterFaultDomain -Name SR-SRV03 -Parent Bellevue
   Set-ClusterFaultDomain -Name SR-SRV04 -Parent Bellevue

   (Get-Cluster).PreferredSite="Redmond"
   ```

# [File Server](#tab/fileserver)

1. In **Server Manager**, select **Tools**, then select **Failover Cluster Manager**.

1. In the right pane, under **Actions**, select **Validate Configuration** to ensure you can proceed.

   > [!NOTE]
   > You should expect storage errors from cluster validation due to the use of asymmetric storage.

1. Follow **steps 2-18** outlined in [Configure a file server failover cluster](/windows-server/failover-clustering/deploy-two-node-clustered-file-server?tabs=server-manager#configure-a-file-server-failover-cluster)

1. Configure stretch cluster site awareness so that servers **SR-SRV01** and **SR-SRV02** are in the **Redmond** site, servers **SR-SRV03** and **SR-SRV04** are in the **Bellevue** site. Ensure that **Redmond** is the primary node that has ownership of the source storage and VMs:

   ```powershell
   New-ClusterFaultDomain -Name Redmond -Type Site -Description "Primary" -Location "Redmond Datacenter"

   New-ClusterFaultDomain -Name Bellevue -Type Site -Description "Secondary" -Location "Bellevue Datacenter"

   Set-ClusterFaultDomain -Name SR-SRV01 -Parent Redmond
   Set-ClusterFaultDomain -Name SR-SRV02 -Parent Redmond
   Set-ClusterFaultDomain -Name SR-SRV03 -Parent Bellevue
   Set-ClusterFaultDomain -Name SR-SRV04 -Parent Bellevue

   (Get-Cluster).PreferredSite="Redmond"
   ```

# [PowerShell](#tab/powershell)

1. Run the following command to test the proposed cluster and analyze the results before continuing:

   ```powershell
   Test-Cluster SR-SRV01, SR-SRV02, SR-SRV03, SR-SRV04
   ```

   > [!NOTE]
   > You should expect storage errors from cluster validation, due to the use of asymmetric storage.

1. When creating the Hyper-V cluster, you must specify your own static IP address the cluster is to use. Ensure that the cluster name is 15 characters or fewer. The `-Dependency` parameter can be used for either the \<Cluster IP Address> or \<NewIPAddress>. To perform this step, run the following command:

   ```powershell
   New-Cluster -Name SR-SRVCLUS -Node SR-SRV01, SR-SRV02, SR-SRV03, SR-SRV04 -StaticAddress "IP Address"
   Add-ClusterResource -Name NewIPAddress -ResourceType "IP Address" -Group "Cluster Group"
   Set-ClusterResourceDependency -Resource "Cluster Name" -Dependency "<Cluster IP Address>"
   ```

1. To configure a File Share or Cloud witness in the cluster that points to a share hosted on the domain controller or some other independent server, run the following command:

   ```powershell
   Set-ClusterQuorum -FileShareWitness \\SomeServer\SomeShare
   ```

   If you're configuring the File Server role, run the following command:

   ```powershell
   Get-ClusterResource
   Add-ClusterFileServerRole -Name SR-CLU-FS1 -Storage "Cluster Disk 4"

   MD F:\Share01

   New-SmbShare -Name Share01 -Path F:\Share01 -ContinuouslyAvailable $false
   ```

1. Configure stretch cluster site awareness so that servers **SR-SRV01** and **SR-SRV02** are in the **Redmond** site, servers **SR-SRV03** and **SR-SRV04** are in the **Bellevue** site. Ensure that **Redmond** is the primary node that has ownership of the source storage and VMs:

   ```powershell
   New-ClusterFaultDomain -Name Redmond -Type Site -Description "Primary" -Location "Redmond Datacenter"

   New-ClusterFaultDomain -Name Bellevue -Type Site -Description "Secondary" -Location "Bellevue Datacenter"

   Set-ClusterFaultDomain -Name SR-SRV01 -Parent Redmond
   Set-ClusterFaultDomain -Name SR-SRV02 -Parent Redmond
   Set-ClusterFaultDomain -Name SR-SRV03 -Parent Bellevue
   Set-ClusterFaultDomain -Name SR-SRV04 -Parent Bellevue

   (Get-Cluster).PreferredSite="Redmond"
   ```

## Configure a stretch cluster

After you configure, validate, and test your environment, the next steps are to configure the stretch cluster using Storage Replica through the Failover Cluster Manager or PowerShell. You can perform all of the steps on the cluster nodes directly or from a remote management computer that contains the Windows Server Remote Server Administration Tools (RSAT).

# [Failover Cluster Manager](#tab/failovermanager)

1. For Hyper-V workloads, on one node where you have the data you wish to replicate out, add the source data disk from your available disks to cluster shared volumes if not already configured. Don't add all the disks; just add the single disk. At this point, half the disks show offline because this is asymmetric storage. If replicating a physical disk resource (PDR) workload like File Server for general use, you already have a role-attached disk ready to go.

   ![Screen showing Failover Cluster Manager](./media/Stretch-Cluster-Replication-Using-Shared-Storage/Storage_SR_OnlineDisks2.png)

1. Right-click the CSV disk or role-attached disk, select **Replication**, and then select **Enable**.

1. Select the appropriate destination data volume and select **Next**. The destination disks shown have a volume the same size as the selected source disk. When you move between these wizard dialogs, the available storage will automatically move and appear online in the background as needed.

   ![A screenshot showing the Select destination data disk page of the Configure Storage Replica wizard.](./media/Stretch-Cluster-Replication-Using-Shared-Storage/Storage_SR_SelectDestinationDataDisk2.png)

1. Select the appropriate source log disk and select **Next**. The source log volume should be on a disk that uses SSD or similarly fast media, not spinning disks.

1. Select the appropriate destination log volume and select Next. The destination log disks shown have a volume the same size as the selected source log disk volume.

1. Leave the **Overwrite Volume** value at **Overwrite destination Volume**  if the destination volume doesn't contain a previous copy of the data from the source server. If the destination does contain similar data, from a recent backup or previous replication, select **Seeded destination disk**, and then select **Next**.

1. Leave the **Replication Mode** value at **Synchronous Replication** if you plan to use zero RPO replication. Change it to **Asynchronous Replication** if you plan to stretch your cluster over higher latency networks or need lower IO latency on the primary site nodes.

1. Leave the **Consistency Group** value at **Highest Performance** if you don't plan to use write ordering later with additional disk pairs in the replication group. If you plan to add further disks to this replication group and you require guaranteed write ordering, select **Enable Write Ordering**, and then select **Next**.

1. Select **Next** to configure replication and the stretch cluster formation.

   ![A screenshot showing the Confirmation page of the Configure Storage Replica wizard.](./media/Stretch-Cluster-Replication-Using-Shared-Storage/Storage_SR_ConfigureSR2.png)

1. On the Summary screen, note the completion dialog results. You can view the report in a web browser.

1. A Storage Replica partnership between the two halves of the cluster is configured but replication is ongoing. There are several ways to see the state of replication via a graphical tool.

   1. Use the **Replication Role** column and the **Replication** tab. When done with initial synchronization, the source and destination disks have a Replication Status of **Continuously Replicating**.

      ![A screenshot showing the Replication tab of the selected disk in Failover Cluster Manager being continuously replicated.](./media/Stretch-Cluster-Replication-Using-Shared-Storage/Storage_SR_ReplicationDetails2.png)

   1. Open the **Event Viewer** on the _source_ server, navigate to **Applications and Services\Microsoft\Windows\StorageReplica\Admin** and examine event IDs 1237, 2200, 5001, 5002, 5004, and 5015.

   1. Open the **Event Viewer** on the _destination_ server, navigate to **Applications and Services\Microsoft\Windows\StorageReplica\Operational** and wait for event ID 1215. This event states the number of copied bytes and the time taken. Example:

      ```
      Log Name:      Microsoft-Windows-StorageReplica/Operational
      Source:        Microsoft-Windows-StorageReplica
      Date:          4/6/2016 4:52:23 PM
      Event ID:      1215
      Task Category: (1)
      Level:         Information
      Keywords:      (1)
      User:          SYSTEM
      Computer:      SR-SRV03.Threshold.nttest.microsoft.com
      Description:
      Block copy completed for replica.

      ReplicationGroupName: Replication 2
      ReplicationGroupId: {c6683340-0eea-4abc-ab95-c7d0026bc054}
      ReplicaName: \\?\Volume{43a5aa94-317f-47cb-a335-2a5d543ad536}\
      ReplicaId: {00000000-0000-0000-0000-000000000000}
      End LSN in bitmap:
      LogGeneration: {00000000-0000-0000-0000-000000000000}
      LogFileId: 0
      CLSFLsn: 0xFFFFFFFF
      Number of Bytes Recovered: 68583161856
      Elapsed Time (ms): 140
      ```

   1. Open the **Event Viewer** on the _destination_ server, navigate to **Applications and Services\Microsoft\Windows\StorageReplica\Admin** and examine event IDs 1237, 2200, 5001, 5009, 5005, and 5015 to understand the processing progress. There should be no warnings of errors in this sequence. If you encounter several event IDs 1237, this indicates progress.

      > [!WARNING]
      > CPU and memory usage are likely to be higher than normal until initial synchronization completes.

# [PowerShell](#tab/powershell2)

1. Ensure your PowerShell console is running with an elevated administrator account.

1. Add the source data storage only to the cluster as CSV. To get the size, partition, and volume layout of the available disks, use the following commands:

   ```PowerShell
   Move-ClusterGroup -Name "Available Storage" -Node SR-SRV01

   $DiskResources = Get-ClusterResource | Where-Object { $_.ResourceType -eq 'Physical Disk' -and $_.State -eq 'Online' }
   $DiskResources | foreach {
       $resource = $_
       $DiskGuidValue = $resource | Get-ClusterParameter DiskIdGuid

       Get-Disk | where { $_.Guid -eq $DiskGuidValue.Value } | Get-Partition | Get-Volume |
           Select @{N="Name"; E={$resource.Name}}, @{N="Status"; E={$resource.State}}, DriveLetter, FileSystemLabel, Size, SizeRemaining
   } | FT -AutoSize

   Move-ClusterGroup -Name "Available Storage" -Node SR-SRV03

   $DiskResources = Get-ClusterResource | Where-Object { $_.ResourceType -eq 'Physical Disk' -and $_.State -eq 'Online' }
   $DiskResources | foreach {
       $resource = $_
       $DiskGuidValue = $resource | Get-ClusterParameter DiskIdGuid

       Get-Disk | where { $_.Guid -eq $DiskGuidValue.Value } | Get-Partition | Get-Volume |
            Select @{N="Name"; E={$resource.Name}}, @{N="Status"; E={$resource.State}}, DriveLetter, FileSystemLabel, Size, SizeRemaining
   } | FT -AutoSize
   ```

1. Set the correct disk to CSV with:

   ```PowerShell
   Add-ClusterSharedVolume -Name "Cluster Disk 4"
   Get-ClusterSharedVolume
   Move-ClusterSharedVolume -Name "Cluster Disk 4" -Node SR-SRV01
   ```

1. Configure the stretch cluster specifying:

   - Source and destination nodes (where the source data is a CSV disk and all other disks aren't).

   - Source and Destination replication group names.

   - Source and destination disks, where the partition sizes match.

   - Source and destination log volumes, where there's enough free space to contain the log size on both disks and the storage is SSD or similar fast media.

   - Log size.

   - The source log volume should be on a disk that uses SSD or similarly fast media, not spinning disks.

   ```powershell
   $params = @{
     SourceComputerName    = 'SR-SRV01'
     SourceRGName          = 'RG01'
     SourceVolumeName      = 'C:\ClusterStorage\Volume1'
     SourceLogVolumeName   = 'E:'
     DestinationComputerName = 'SR-SRV03'
     DestinationRGName     = 'RG02'
     DestinationVolumeName = 'D:'
     DestinationLogVolumeName = 'E:'
     LogType               = 'Raw'
   }
   New-SRPartnership @params
   ```

   > [!NOTE]
   > You can also use `New-SRGroup` on one node in each site and `New-SRPartnership` to create replication in stages, rather than all at once.

1. Determine the replication progress.

   1. On the source server, run the following command and examine event IDs 5015, 5002, 5004, 1237, 5001, and 2200:

      ```powershell
      Get-WinEvent -ProviderName Microsoft-Windows-StorageReplica -Max 20
      ```

   1. On the destination server, run the following command to see the Storage Replica events that show creation of the partnership. This event states the number of copied bytes and the time taken. Example:

      ```powershell
      Get-WinEvent -ProviderName Microsoft-Windows-StorageReplica | Where-Object {$_.ID -eq "1215"} | FL
      ```

      ```output
      TimeCreated  : 4/6/2016 4:52:23 PM
      ProviderName : Microsoft-Windows-StorageReplica
      Id           : 1215
      Message      : Block copy completed for replica.

             ReplicationGroupName: Replication 2
             ReplicationGroupId: {c6683340-0eea-4abc-ab95-c7d0026bc054}
             ReplicaName: ?Volume{43a5aa94-317f-47cb-a335-2a5d543ad536}
             ReplicaId: {00000000-0000-0000-0000-000000000000}
             End LSN in bitmap:
             LogGeneration: {00000000-0000-0000-0000-000000000000}
             LogFileId: 0
             CLSFLsn: 0xFFFFFFFF
             Number of Bytes Recovered: 68583161856
             Elapsed Time (ms): 140
      ```

   1. On the destination server, run the following command and examine events 5009, 1237, 5001, 5015, 5005, and 2200 to understand the processing progress. There should be no warnings of errors in this sequence. If several event IDs 1237 populate, this indicating progress.

      ```powershell
      Get-WinEvent -ProviderName Microsoft-Windows-StorageReplica | FL
      ```

   1. Alternately, the destination server group for the replica states the number of byte remaining to copy, and can be queried through PowerShell. For example:

      ```powershell
      (Get-SRGroup).Replicas | Select-Object numofbytesremaining
      ```

      As a progress sample (that doesn't terminate):

      ```powershell
      while($true) {

      $v = (Get-SRGroup -Name "Replication 2").replicas | Select-Object numofbytesremaining
      [System.Console]::Write("Number of bytes remaining: {0}`r", $v.numofbytesremaining)
      Start-Sleep -s 5
      }
      ```

---

### Manage stretched cluster replication

You can perform all of the steps on the cluster nodes directly or from a remote management computer that contains the RSAT. You can also use Failover Cluster Manager to determine the current source and destination of replication and their status. Managing stretched cluster replication can be performed using the GUI or PowerShell.

# [Failover Cluster Manager](#tab/failovermanager2)

To alter replication source and destination within the stretch cluster, use the following methods:

1. To move the source replication between nodes in the same site, right-click the source CSV, select **Move Storage**, select **Select Node**, and then select a node in the same site. If using non-CSV storage for a role assigned disk, you move the role.

1. To move the source replication from one site to another, right-click the source CSV, select **Move Storage**, select **Select Node**, and then select a node in another site. If you configured a preferred site, you can use best possible node to always move the source storage to a node in the preferred site. If using non-CSV storage for a role assigned disk, you move the role.

1. To perform planned failover the replication direction from one site to another, shut down both nodes in one site using **Server Manager** or **SConfig**.

1. To perform unplanned failover the replication direction from one site to another, cut power to both nodes in one site.

   > [!NOTE]
   > In Windows Server 2016, you may need to use Failover Cluster Manager or `Move-ClusterGroup` to move the destination disks back to the other site manually after the nodes come back online.
   >
   > Storage Replica dismounts the destination volumes. This is by design.

1. To change the log size, right-click both the source and destination log disks, select the **Replication Log** tab, then change the sizes on both the disks to match.

1. To add another pair of replicated disks to the existing replication group, you must ensure that there is at least one extra disk in available storage. You can then right-click the Source disk and select **Add replication partnership**.

   > [!NOTE]
   > This need for an additional 'dummy' disk in available storage is due to a regression and not intentional.

To remove the existing replication:

- Right-click the source CSV disk and select **Replication**, then select **Remove**. Accept the warning prompt.


   Optionally, remove the storage from CSV to return it to available storage for further testing.

   > [!NOTE]
   > You may need to use **Disk Management** or **Server Manager** to add back drive letters to volumes after return to available storage.

To measure the replication performance, you can utilize the **Performance Monitor** (`perfmon.exe`) tool on both the source and destination nodes. To learn more about the Performance Monitor, see [Using Performance Monitor](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc749115(v=ws.10)) and [Add Counters Dialog Box](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc749266(v=ws.10)).

On the destination node:

1. Add the **Storage Replica Statistics** objects with all their performance counters for the data volume.

1. Examine the results.

On the source node:

1. Add the **Storage Replica Statistics** and **Storage Replica Partition I/O Statistics** objects with all their performance counters for the data volume (the latter is only available with data on the current source server).

1. Examine the results.

# [PowerShell](#tab/powershell3)

1. Use `Get-SRGroup` and `(Get-SRGroup).Replicas` to determine the current source and destination of replication and their status.

1. To measure replication performance, use the `Get-Counter` cmdlet on both the source and destination nodes. The counter names are:

   ```
   \Storage Replica Partition I/O Statistics(*)\Number of times flush paused
   \Storage Replica Partition I/O Statistics(*)\Number of pending flush I/O
   \Storage Replica Partition I/O Statistics(*)\Number of requests for last log write
   \Storage Replica Partition I/O Statistics(*)\Avg. Flush Queue Length
   \Storage Replica Partition I/O Statistics(*)\Current Flush Queue Length
   \Storage Replica Partition I/O Statistics(*)\Number of Application Write Requests
   \Storage Replica Partition I/O Statistics(*)\Avg. Number of requests per log write
   \Storage Replica Partition I/O Statistics(*)\Avg. App Write Latency
   \Storage Replica Partition I/O Statistics(*)\Avg. App Read Latency
   \Storage Replica Statistics(*)\Target RPO
   \Storage Replica Statistics(*)\Current RPO
   \Storage Replica Statistics(*)\Avg. Log Queue Length
   \Storage Replica Statistics(*)\Current Log Queue Length
   \Storage Replica Statistics(*)\Total Bytes Received
   \Storage Replica Statistics(*)\Total Bytes Sent
   \Storage Replica Statistics(*)\Avg. Network Send Latency
   \Storage Replica Statistics(*)\Replication State
   \Storage Replica Statistics(*)\Avg. Message Round Trip Latency
   \Storage Replica Statistics(*)\Last Recovery Elapsed Time
   \Storage Replica Statistics(*)\Number of Flushed Recovery Transactions
   \Storage Replica Statistics(*)\Number of Recovery Transactions
   \Storage Replica Statistics(*)\Number of Flushed Replication Transactions
   \Storage Replica Statistics(*)\Number of Replication Transactions
   \Storage Replica Statistics(*)\Max Log Sequence Number
   \Storage Replica Statistics(*)\Number of Messages Received
   \Storage Replica Statistics(*)\Number of Messages Sent
   ```

   For more information on performance counters in Windows PowerShell, see [Get-Counter](/powershell/module/microsoft.powershell.diagnostics/get-counter).

To alter replication source and destination within the stretch cluster, use the following methods:

1. To move the replication source from one node to another in the **Redmond** site, move the CSV resource using the Move-ClusterSharedVolume cmdlet.

   ```powershell
   Get-ClusterSharedVolume | FL *
   Move-ClusterSharedVolume -Name "Cluster Disk 4" -Node SR-SRV02
   ```

1. To move the replication direction from one site to another "planned", move the CSV resource using the `Move-ClusterSharedVolume` cmdlet.

   ```powershell
   Get-ClusterSharedVolume | FL *
   Move-ClusterSharedVolume -Name "Cluster Disk 4" -Node SR-SRV04
   ```

   This also moves the logs and data appropriately for the other site and nodes.

1. To perform unplanned failover the replication direction from one site to another, cut the power to both nodes in one site.

   > [!NOTE]
   > Storage Replica dismounts the destination volumes. This is by design.

1. To change the log size, use `Set-SRGroup` on both the source and destination Storage Replica Groups. For example, to set all logs to 12 GB:

   ```powershell
   Get-SRGroup | Set-SRGroup -LogSizeInBytes 12GB
   Get-SRGroup
   ```

   > [!NOTE]
   > The default log size is 8 GB. Depending on the results of the `Test-SRTopology` cmdlet, you may decide to use **LogSizeInBytes** with a higher or lower value.

1. To add another pair of replicated disks to the existing replication group, you must ensure that there is at least one extra disk in available storage. You can then right-click the Source disk and select add replication partnership.

   > [!NOTE]
   > This need for an additional 'dummy' disk in available storage is due to a regression and not intentional.

   Use the `Set-SRPartnership` cmdlet with the **SourceAddVolumePartnership** and **DestinationAddVolumePartnership** parameters.

1. To remove replication, use `Get-SRGroup`, `Get-SRPartnership`, `Remove-SRGroup`, and `Remove-SRPartnership` on any node.

   ```powershell
   Get-SRPartnership | Remove-SRPartnership
   Get-SRGroup | Remove-SRGroup
   ```

   > [!NOTE]
   > If using a remote management computer, you must specify the cluster name to these cmdlets and provide the two RG names.

---

## See also

- [Storage Replica Overview](storage-replica-overview.md)
- [Server to Server Storage Replication](server-to-server-storage-replication.md)
- [Cluster to Cluster Storage Replication](cluster-to-cluster-storage-replication.md)
- [Storage Replica: Known Issues](storage-replica-known-issues.md)
- [Storage Replica: Frequently Asked Questions](storage-replica-frequently-asked-questions.yml)
- [Storage Spaces Direct overview](../storage-spaces/storage-spaces-direct-overview.md)


