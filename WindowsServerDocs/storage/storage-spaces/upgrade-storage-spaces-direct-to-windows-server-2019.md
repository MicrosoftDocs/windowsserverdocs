---
title: Upgrade a Storage Spaces Direct cluster to Windows Server 2019
description: How to upgrade a Storage Spaces Direct cluster to Windows Server 2019-either while keeping VMs running or while they're stopped.
author: robhindman
ms.author: robhind
manager: eldenc
ms.date: 03/06/2019
ms.topic: article
ms.prod: windows-server
ms.technology: storage-spaces
---
# Upgrade a Storage Spaces Direct cluster to Windows Server 2019

This topic describes how to upgrade a Storage Spaces Direct cluster to Windows Server 2019. There are four approaches to upgrading a Storage Spaces Direct
cluster from Windows Server 2016 to Windows Server 2019, using the [cluster OS rolling upgrade process](../../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md) —two that involve keeping the VMs running, and two that involve stopping all VMs. Each approach has different strengths and weaknesses, so select that one that best suits the needs of your organization:

- **In-place upgrade while VMs are running** on each server in the cluster—this option incurs no VM downtime, but you'll need to wait for storage jobs (mirror repair) to complete after each server is upgraded.

- **Clean-OS installation while VMs are running** on each server in the cluster—this option incurs no VM downtime, but you'll need to wait for storage jobs (mirror repair) to complete after each server is upgraded, and you'll have to set up each server and all its apps and roles again.

- **In-place upgrade while VMs are stopped** on each server in the cluster—this option incurs VM downtime, but you don't need to wait for storage jobs (mirror repair), so it's faster.

- **Clean-OS install while VMs are stopped** on each server in the cluster—This option incurs VM downtime, but you don't need to wait for storage jobs (mirror repair) so it's faster.

## Prerequisites and limitations

Before proceeding with an upgrade:

- Check that you have usable backups in case there are any issues during the upgrade process.

- Check that your hardware vendor has a BIOS, firmware, and drivers for your servers that they will support on Windows Server 2019.

There are some limitations with the upgrade process to be aware of:

- To enable Storage Spaces Direct with Windows Server 2019 builds earlier than 176693.292, customers may need to contact Microsoft support for registry keys that enable Storage Spaces Direct and Software Defined Networking functionality. For more info, see Microsoft Knowledge Base [article 4464776](https://support.microsoft.com/help/4464776/software-defined-data-center-and-software-defined-networking).

- When upgrading a cluster with ReFS volumes, there are a few limitations:

- Upgrading is fully supported on ReFS volumes, however, upgraded volumes won't benefit from ReFS enhancements in Windows Server 2019. These benefits, such as increased performance for mirror-accelerated parity, require a newly-created Windows Server 2019 ReFS volume. In other words, you'd have to create new volumes using the `New-Volume` cmdlet or Server Manager. Here are the some of the ReFS enhancements new volumes would get:

    - **MAP log-bypass**: a performance improvement in ReFS that only applies to clustered (Storage Spaces Direct) systems and doesn't apply to stand-alone storage pools.

    - **Compaction** efficiency improvements in Windows Server 2019 that are specific to multi-resilient volumes.

- Before upgrading a Windows Server 2016 Storage Spaces Direct cluster server, we recommend putting the server into storage maintenance mode. For more info, see the Event 5120 section of [Troubleshoot Storage Spaces Direct](troubleshooting-storage-spaces.md). Although this issue has been fixed in Windows Server 2016, we recommend putting each Storage Spaces Direct server into storage maintenance mode during the upgrade as a best practice.

- There is a known issue with Software Defined Networking environments that use SET switches. This issue involves Hyper-V VM live migrations from Windows Server 2019 to Windows Server 2016 (live migration to an earlier operating system). To ensure successful live migrations, we recommend changing a VM network setting on VMs that are being live-migrated from Windows Server 2019 to Windows Server 2016. This issue is fixed for Windows Server 2019 in the 2019-01D hotfix rollup package, AKA build 17763.292. For more info, see Microsoft Knowledge Base [article 4476976](https://support.microsoft.com/help/4476976/windows-10-update-kb4476976).

Because of the known issues above, some customers may consider building a new Windows Server 2019 cluster and copying data from the old cluster, instead of upgrading their Windows Server 2016 clusters using one of the four processes described below.

## Performing an in-place upgrade while VMs are running

This option incurs no VM downtime, but you'll need to wait for storage jobs (mirror repair) to complete after each server is upgraded. Although individual
servers will be restarted sequentially during the upgrade process, the remaining servers in the cluster, as well as all VMs, will remain running.

1. Check that all the servers in the cluster have installed the latest Windows updates. For more info, see [Windows 10 and Windows Server 2016 update history](https://support.microsoft.com/help/4000825/windows-10-windows-server-2016-update-history). At a minimum, install Microsoft Knowledge Base [article 4487006](https://support.microsoft.com/help/4487006/windows-10-update-kb4487006) (Feb 19th, 2019). The build number (see `ver` command) should be 14393.2828 or higher.

2. If you're using Software Defined Networking with SET switches, open an elevated PowerShell session and run the following command to disable VM live    migration verification checks on all VMs on the cluster:

   ```PowerShell
   Get-ClusterResourceType -Cluster {clusterName} -Name "Virtual Machine" |
   Set-ClusterParameter -Create SkipMigrationDestinationCheck -Value 1
   ```

3. Perform the following steps on one cluster server at a time:

   1. Use Hyper-V VM live migration to move running VMs off the server you're about to upgrade.

   2. Pause the cluster server using the following PowerShell command—note that some internal groups are hidden. We recommend this step to be cautious — if you didn't already live migrate VMs off the server this cmdlet will do that for you, so you could skip the previous step if you prefer.

        ```PowerShell
       Suspend-ClusterNode -Drain
       ```

   3. Place the server in storage maintenance mode by running the following PowerShell commands:

       ```PowerShell
       Get-StorageFaultDomain -type StorageScaleUnit | 
       Where FriendlyName -Eq <ServerName> | 
       Enable-StorageMaintenanceMode
       ```

   4. Run the following cmdlet to check that the **OperationalStatus** value is **In Maintenance Mode**:

       ```PowerShell
       Get-PhysicalDisk
       ```

   5. Perform an upgrade installation of Windows Server 2019 on the server by running **setup.exe** and using the “Keep personal files and apps” option. After installation is complete, the server remains in the cluster and the cluster service starts automatically.

   6. Check that the newly upgraded server has the latest Windows Server 2019 updates. For more info, see [Windows 10 and Windows Server 2019 update
   history](https://support.microsoft.com/help/4464619/windows-10-update-history). The build number (see `ver` command) should be 17763.292 or higher.

   7. Remove the server from storage maintenance mode by using the following PowerShell command:

       ```PowerShell
       Get-StorageFaultDomain -type StorageScaleUnit | 
       Where FriendlyName -Eq <ServerName> | 
       Disable-StorageMaintenanceMode
       ```

   8. Resume the server by using the following PowerShell command:

       ```PowerShell
       Resume-ClusterNode
       ```

   9. Wait for storage repair jobs to finish and for all disks to return to a healthy state. This could take considerable time depending on the number of VMs running during the server upgrade. Here are the commands to run:

       ```PowerShell
       Get-StorageJob
       Get-VirtualDisk
       ```

4. Upgrade the next server in the cluster.

5. After all servers have been upgraded to Windows Server 2019, use the following PowerShell cmdlet to update the cluster functional level.

   ```PowerShell
   Update-ClusterFunctionalLevel
   ```

   > [!NOTE]
   > We recommend updating the cluster functional level as soon as possible, though technically you have up to four weeks to do so.

6. After the cluster functional level has been updated, use the following cmdlet to update the storage pool. At this point, new cmdlets such as `Get-ClusterPerf` will be fully operational on any server in the cluster.

   ```PowerShell
   Update-StoragePool
   ```

7. Optionally upgrade VM configuration levels by stopping each VM, using the `Update-VMVersion` cmdlet, and then starting the VMs again.

8. If you're using Software Defined Networking with SET switches and disabled VM live migration checks as instructed to above, use the following cmdlet to re-enable VM Live verification checks:

   ```PowerShell
   Get-ClusterResourceType -Cluster {clusterName} -Name "Virtual Machine" |
   Set-ClusterParameter  SkipMigrationDestinationCheck -Value 0
   ```

9. Verify that the upgraded cluster functions as expected. Roles should fail-over correctly and if VM live migration is used on the cluster, VMs should successfully live migrate.

10. Validate the cluster by running Cluster Validation (`Test-Cluster`) and examining the cluster validation report.

## Performing a clean OS installation while VMs are running

This option incurs no VM downtime, but you'll need to wait for storage jobs (mirror repair) to complete after each server is upgraded. Although individual servers will be restarted sequentially during the upgrade process, the remaining servers in the cluster, as well as all VMs, will remain running.

1. Check that all the servers in the cluster are running the latest updates. For more info, see [Windows 10 and Windows Server 2016 update history](https://support.microsoft.com/help/4000825/windows-10-windows-server-2016-update-history). At a minimum, install Microsoft Knowledge Base [article 4487006](https://support.microsoft.com/help/4487006/windows-10-update-kb4487006) (Feb 19th, 2019). The build number (see `ver` command) should be 14393.2828 or higher.

2. If you're using Software Defined Networking with SET switches, open an elevated PowerShell session and run the following command to disable VM live   migration verification checks on all VMs on the cluster:

   ```PowerShell
   Get-ClusterResourceType -Cluster {clusterName} -Name "Virtual Machine" |
   Set-ClusterParameter -Create SkipMigrationDestinationCheck -Value 1
   ```

3. Perform the following steps on one cluster server at a time:

   1. Use Hyper-V VM live migration to move running VMs off the server you're about to upgrade.

   2. Pause the cluster server using the following PowerShell command—note that some internal groups are hidden. We recommend this step to be cautious — if you didn't already live migrate VMs off the server this cmdlet will do that for you, so you could skip the previous step if you prefer.

        ```PowerShell
       Suspend-ClusterNode -Drain
       ```

   3. Place the server in storage maintenance mode by running the following PowerShell commands:

       ```PowerShell
       Get-StorageFaultDomain -type StorageScaleUnit | 
       Where FriendlyName -Eq <ServerName> | 
       Enable-StorageMaintenanceMode
       ```

   4. Run the following cmdlet to check that the **OperationalStatus** value is **In Maintenance Mode**:

       ```PowerShell
       Get-PhysicalDisk
       ```

   3.  Evict the server from the cluster by running the following PowerShell command:  

       ```PowerShell
       Remove-ClusterNode <ServerName>
       ```

   4. Perform a clean installation of Windows Server 2019 on the server: format the system drive, run **setup.exe** and use the “Nothing” option. You'll have to configure the server identity, roles, features, and applications after setup completes and the server restarts.

   5. Install the Hyper-V role and Failover-Clustering feature on the server (you can use the `Install-WindowsFeature` cmdlet).

   6. Install the latest storage and networking drivers for your hardware that are approved by your server manufacturer for use with Storage Spaces Direct.

   7. Check that the newly upgraded server has the latest Windows Server 2019 updates. For more info, see [Windows 10 and Windows Server 2019 update history](https://support.microsoft.com/help/4464619/windows-10-update-history). The build number (see `ver` command) should be 17763.292 or higher.

   8. Rejoin the server to the cluster by using the following PowerShell command:

       ```PowerShell
       Add-ClusterNode
       ```

   9. Remove the server from storage maintenance mode by using the following PowerShell commands:

       ```PowerShell
       Get-StorageFaultDomain -type StorageScaleUnit | 
       Where FriendlyName -Eq <ServerName> | 
       Disable-StorageMaintenanceMode
       ```

   10. Wait for storage repair jobs to finish and for all disks to return to a healthy state. This could take considerable time depending on the number of VMs running during the server upgrade. Here are the commands to run:

        ```PowerShell
        Get-StorageJob
        Get-VirtualDisk
        ```

4. Upgrade the next server in the cluster.

5. After all servers have been upgraded to Windows Server 2019, use the following PowerShell cmdlet to update the cluster functional level.
    
   ```PowerShell
   Update-ClusterFunctionalLevel
   ```

   > [!NOTE]
   > We recommend updating the cluster functional level as soon as possible, though technically you have up to four weeks to do so.

6. After the cluster functional level has been updated, use the following cmdlet to update the storage pool. At this point, new cmdlets such as `Get-ClusterPerf` will be fully operational on any server in the cluster.

   ```PowerShell
   Update-StoragePool
   ```

7. Optionally upgrade VM configuration levels by stopping each VM and using the `Update-VMVersion` cmdlet, and then starting the VMs again.

8. If you're using Software Defined Networking with SET switches and disabled VM live migration checks as instructed to above, use the following cmdlet to
   re-enable VM Live verification checks:

   ```PowerShell
   Get-ClusterResourceType -Cluster {clusterName} -Name "Virtual Machine" | 
   Set-ClusterParameter SkipMigrationDestinationCheck -Value 0
   ```

9. Verify that the upgraded cluster functions as expected. Roles should fail-over correctly and if VM live migration is used on the cluster, VMs should successfully live migrate.

10. Validate the cluster by running Cluster Validation (`Test-Cluster`) and examining the cluster validation report.

## Performing an in-place upgrade while VMs are stopped

This option incurs VM downtime but can take less time than if you kept the VMs running during the upgrade because you don't need to wait for storage jobs (mirror repair) to complete after each server is upgraded. Although individual servers will be restarted sequentially during the upgrade process, the remaining servers in the cluster remain running.

1. Check that all the servers in the cluster are running the latest updates. For more info, see [Windows 10 and Windows Server 2016 update history](https://support.microsoft.com/help/4000825/windows-10-windows-server-2016-update-history). At a minimum, install Microsoft Knowledge Base [article 4487006](https://support.microsoft.com/help/4487006/windows-10-update-kb4487006) (Feb 19th, 2019). The build number (see `ver` command) should be 14393.2828 or higher.

2. Stop the VMs running on the cluster.

3. Perform the following steps on one cluster server at a time:

   1. Pause the cluster server using the following PowerShell command—note that some internal groups are hidden. We recommend this step to be cautious.

        ```PowerShell
       Suspend-ClusterNode -Drain
       ```

   2. Place the server in storage maintenance mode by running the following PowerShell commands:

       ```PowerShell
       Get-StorageFaultDomain -type StorageScaleUnit | 
       Where FriendlyName -Eq <ServerName> | 
       Enable-StorageMaintenanceMode
       ```

   3. Run the following cmdlet to check that the **OperationalStatus** value is **In Maintenance Mode**:

       ```PowerShell
       Get-PhysicalDisk
       ```

   4. Perform an upgrade installation of Windows Server 2019 on the server by running **setup.exe** and using the “Keep personal files and apps” option.  
   After installation is complete, the server remains in the cluster and the
   cluster service starts automatically.

   5.  Check that the newly upgraded server has the latest Windows Server 2019
   updates.  
   For more info, see [Windows 10 and Windows Server 2019 update
   history](https://support.microsoft.com/help/4464619/windows-10-update-history).
   The build number (see `ver` command) should be 17763.292 or higher.

   6.  Remove the server from storage maintenance mode by using the following
   PowerShell commands:

       ```PowerShell
       Get-StorageFaultDomain -type StorageScaleUnit | 
       Where FriendlyName -Eq <ServerName> | 
       Disable-StorageMaintenanceMode
       ```

   7.  Resume the server by using the following PowerShell command:

       ```PowerShell
       Resume-ClusterNode
       ```

   8.  Wait for storage repair jobs to finish and for all disks to return to a healthy state.  
   This should be relatively fast, since VMs are not running. Here are the commands to run:

       ```PowerShell
       Get-StorageJob
       Get-VirtualDisk
       ```

4. Upgrade the next server in the cluster.
5. After all servers have been upgraded to Windows Server 2019, use the following PowerShell cmdlet to update the cluster functional level.
    
   ```PowerShell
   Update-ClusterFunctionalLevel
   ```

   > [!NOTE]
   >   We recommend updating the cluster functional level as soon as possible, though technically you have up to four weeks to do so.

6. After the cluster functional level has been updated, use the following cmdlet to update the storage pool.  
   At this point, new cmdlets such as `Get-ClusterPerf` will be fully operational on any server in the cluster.

   ```PowerShell
   Update-StoragePool
   ```

7. Start the VMs on the cluster and check that they're working properly.

8. Optionally upgrade VM configuration levels by stopping each VM and using the
   `Update-VMVersion` cmdlet, and then starting the VMs again.

9. Verify that the upgraded cluster functions as expected.  
   Roles should fail-over correctly and if VM live migration is used on the
   cluster, VMs should successfully live migrate.

10. Validate the cluster by running Cluster Validation (`Test-Cluster`) and examining the cluster validation report.

## Performing a clean OS installation while VMs are stopped

This option incurs VM downtime but can take less time than if you kept the VMs
running during the upgrade because you don't need to wait for storage jobs
(mirror repair) to complete after each server is upgraded. Although individual
servers will be restarted sequentially during the upgrade process, the remaining
servers in the cluster remain running.

1. Check that all the servers in the cluster are running the latest updates.  
   For more info, see [Windows 10 and Windows Server 2016 update
   history](https://support.microsoft.com/help/4000825/windows-10-windows-server-2016-update-history).
   At a minimum, install Microsoft Knowledge Base [article
   4487006](https://support.microsoft.com/help/4487006/windows-10-update-kb4487006)
   (Feb 19th, 2019). The build number (see `ver` command) should be
   14393.2828 or higher.

2. Stop the VMs running on the cluster.

3. Perform the following steps on one cluster server at a time:

   2. Pause the cluster server using the following PowerShell command—note that some internal groups are hidden.  
      We recommend this step to be cautious.

       ```PowerShell
      Suspend-ClusterNode -Drain
      ```

   3. Place the server in storage maintenance mode by running the following
      PowerShell commands:

      ```PowerShell
      Get-StorageFaultDomain -type StorageScaleUnit | 
      Where FriendlyName -Eq <ServerName> | 
      Enable-StorageMaintenanceMode
      ```

   4. Run the following cmdlet to check that the
      **OperationalStatus** value is **In Maintenance Mode**:

      ```PowerShell
      Get-PhysicalDisk
      ```

   5. Evict the server from the cluster by running the following PowerShell
      command:  
    
      ```PowerShell
      Remove-ClusterNode <ServerName>
      ```

   6. Perform a clean installation of Windows Server 2019 on the server: format
      the system drive, run **setup.exe** and use the “Nothing” option.  
      You'll have to configure the server identity, roles, features, and
      applications after setup completes and the server restarts.

   7. Install the Hyper-V role and Failover-Clustering feature on the server (you
      can use the `Install-WindowsFeature` cmdlet).

   8. Install the latest storage and networking drivers for your hardware that are
      approved by your server manufacturer for use with Storage Spaces Direct.

   9. Check that the newly upgraded server has the latest Windows Server 2019
      updates.  
      For more info, see [Windows 10 and Windows Server 2019 update
      history](https://support.microsoft.com/help/4464619/windows-10-update-history).
      The build number (see `ver` command) should be 17763.292 or higher.

   10. Rejoin the server to the cluster by using the following PowerShell command:

      ```PowerShell
      Add-ClusterNode
      ```

   11. Remove the server from storage maintenance mode by using the following
       PowerShell command:

       ```PowerShell
       Get-StorageFaultDomain -type StorageScaleUnit | 
       Where FriendlyName -Eq <ServerName> | 
       Disable-StorageMaintenanceMode
       ```

   12. Wait for storage repair jobs to finish and for all disks to return to a healthy state.  
       This could take considerable time depending on the number of VMs running during the server upgrade. Here are the commands to run:

       ```PowerShell
       Get-StorageJob
       Get-VirtualDisk
       ```

4. Upgrade the next server in the cluster.

5. After all servers have been upgraded to Windows Server 2019, use the following PowerShell cmdlet to update the cluster functional level.
    
   ```PowerShell
   Update-ClusterFunctionalLevel
   ```

   > [!NOTE]
   >   We recommend updating the cluster functional level as soon as possible, though technically you have up to four weeks to do so.

6. After the cluster functional level has been updated, use the following cmdlet to update the storage pool.  
   At this point, new cmdlets such as `Get-ClusterPerf` will be fully operational on any server in the cluster.

   ```PowerShell
   Update-StoragePool
   ```

7. Start the VMs on the cluster and check that they're working properly.

8. Optionally upgrade VM configuration levels by stopping each VM and using the
   `Update-VMVersion` cmdlet, and then starting the VMs again.

9. Verify that the upgraded cluster functions as expected.  
   Roles should fail-over correctly and if VM live migration is used on the
   cluster, VMs should successfully live migrate.

10. Validate the cluster by running Cluster Validation (`Test-Cluster`) and
    examining the cluster validation report.
