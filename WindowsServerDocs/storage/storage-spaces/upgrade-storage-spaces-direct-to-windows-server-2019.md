---
title: Upgrade a Storage Spaces Direct cluster to Windows Server 2019
description: Learn how to upgrade a Storage Spaces Direct cluster to Windows Server 2019, while VMs are running or while they're stopped.
author: robhindman
ms.author: robhind
manager: eldenc
ms.date: 03/06/2019
ms.topic: article
---

# Upgrade a Storage Spaces Direct cluster to Windows Server 2019

To upgrade a Storage Spaces Direct cluster from Windows Server 2016 to Windows Server 2019, you have four options using the [cluster OS rolling upgrade process](../../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md). Two options involve keeping the virtual machines (VMs) running, and two options involve stopping all VMs. Each option has strengths and weaknesses, so select the option that best suits the needs of your organization.

To read more about an upgrade option, select a link:

- [In-place upgrade while VMs are running](#in-place-upgrade-while-vms-are-running) on each server in the cluster. This option incurs no VM downtime, but you must wait for storage jobs (mirror repair) to finish after each server is upgraded.

- [Clean OS installation while VMs are running](#clean-os-installation-while-vms-are-running) on each server in the cluster. This option incurs no VM downtime, but you must wait for storage jobs (mirror repair) to finish after each server is upgraded, and you must set up each server and all its apps and roles again. We recommend this option over an in-place upgrade.

- [In-place upgrade while VMs are stopped](#in-place-upgrade-while-vms-are-stopped) on each server in the cluster. This option incurs VM downtime, but you don't need to wait for storage jobs (mirror repair), so it's faster.

- [Clean OS installation while VMs are stopped](#clean-os-installation-while-vms-are-stopped) on each server in the cluster. This option incurs VM downtime, but you don't need to wait for storage jobs (mirror repair), so it's faster. We recommend this option over an in-place upgrade.

## Prerequisites and limitations

Before you proceed with an upgrade:

- Check that you have usable backups in case any issues occur during the upgrade process.

- Check that your hardware vendor has a BIOS, firmware, and drivers for your servers to support Windows Server 2019.

It's important to be aware of some limitations with the upgrade process:

- To enable Storage Spaces Direct with Windows Server 2019, use build version 17763.292 or later. You can enable Storage Spaces Direct with Windows Server 2019 by ensuring that the latest Windows Update is applied.

- Upgrading is fully supported on Resilient File System (ReFS) volumes, but in Windows Server 2019, upgraded volumes don't benefit from ReFS enhancements. Benefits from ReFS, such as improved performance for mirror-accelerated parity, require a newly created Windows Server 2019 ReFS volume. To create a new Windows Server 2019 ReFS volume, you must create new volumes by using the `New-Volume` cmdlet or Server Manager. Here are some of the ReFS enhancements in new volumes:

  - **MAP log-bypass**: A performance improvement in ReFS that applies only to clustered (Storage Spaces Direct) systems and doesn't apply to standalone storage pools.

  - **Compaction**: Efficiency improvements in Windows Server 2019 that are specific to multi-resilient volumes.

- Before you upgrade a Windows Server 2016 Storage Spaces Direct cluster server, we recommend that you put the server in storage maintenance mode. For more information, see the [Event 5120 section of Troubleshoot Storage Spaces Direct](troubleshooting-storage-spaces.md#event-5120-with-status_io_timeout-c00000b5). Although this issue has been fixed in Windows Server 2016, we recommend that you put each Storage Spaces Direct server in storage maintenance mode during the upgrade.

- A known issue occurs with Software Defined Networking environments that use Switch Embedded Teaming (SET) switches. The issue involves Hyper-V VM live migrations from Windows Server 2019 to Windows Server 2016 (live migration to an earlier version of the operating system). To ensure successful live migrations, we recommend that you change a VM network setting on VMs that you live-migrate from Windows Server 2019 to Windows Server 2016. This issue is fixed for Windows Server 2019 in build 17763.292 and later, but ensure that the latest Windows Update is applied. For more information, see Microsoft Knowledge Base [article 4476976](https://support.microsoft.com/help/4476976/windows-10-update-kb4476976).

Because of the known issues described here, some customers might consider building a new Windows Server 2019 cluster and copying data from the old cluster instead of upgrading their Windows Server 2016 clusters by using one of the four processes described in the following sections.

## In-place upgrade while VMs are running

This option incurs no VM downtime, but you must wait for storage jobs (mirror repair) to complete after each server is upgraded. Although individual servers are restarted sequentially during the upgrade process, the remaining servers in the cluster and all VMs remain running.

1. Check that all servers in the cluster have installed the latest Windows Update. For more information, see [Windows 10 and Windows Server 2016 update history](https://support.microsoft.com/help/4000825/windows-10-windows-server-2016-update-history). At a minimum, install Microsoft Knowledge Base [article 4487006](https://support.microsoft.com/help/4487006/windows-10-update-kb4487006) (February 19, 2019). The build version should be 14393.2828 or later. You can check the build version by using the `ver` command or the `winver` command.

2. If you're using Software Defined Networking with SET switches, open an elevated PowerShell session and run the following command to disable VM live migration verification checks on all VMs on the cluster:

    ```powershell
    Get-ClusterResourceType -Cluster {clusterName} -Name "Virtual Machine" | `
    Set-ClusterParameter -Create SkipMigrationDestinationCheck -Value 1
    ```

3. On one cluster server at a time, complete the following steps:

   1. Use Hyper-V VM live migration to move running VMs off the server you're about to upgrade.

   2. Pause the cluster server by running the following PowerShell command. Some internal groups are hidden. We recommend that you do this step with caution. If you didn't already live-migrate VMs off the server, this cmdlet does that step for you. In that case, you can skip the previous step, if you prefer.

       ```powershell
       Suspend-ClusterNode -Drain
       ```

   3. Place the server in storage maintenance mode:

       ```powershell
       Get-StorageFaultDomain -type StorageScaleUnit | `
       Where FriendlyName -Eq <ServerName> | `
       Enable-StorageMaintenanceMode
       ```

   4. Run the following cmdlet to check that the **OperationalStatus** value is **In Maintenance Mode**:

       ```powershell
       Get-PhysicalDisk
       ```

   5. Perform an upgrade installation of Windows Server 2019 on the server by running *setup.exe* and using the **Keep personal files and apps** option. When installation is finished, the server remains in the cluster and the cluster service starts automatically.

   6. Check that the newly upgraded server has the latest Windows Server 2019 updates. For more information, see [Windows 10 and Windows Server 2019 update
   history](https://support.microsoft.com/help/4464619/windows-10-update-history). The build number should be 17763.292 or later. You can check the build number by using the `ver` command or the `winver` command.

   7. Remove the server from storage maintenance mode:

       ```powershell
       Get-StorageFaultDomain -type StorageScaleUnit | `
       Where FriendlyName -Eq <ServerName> | `
       Disable-StorageMaintenanceMode
       ```

   8. Resume the server:

       ```powershell
       Resume-ClusterNode
       ```

   9. Wait for storage repair jobs to finish and for all disks to return to a healthy state. The process might take considerable time depending on the number of VMs running during the server upgrade. To check for a healthy state, run these commands:

       ```powershell
       Get-StorageJob
       Get-VirtualDisk
       ```

4. Upgrade the next server in the cluster.

5. After all servers are upgraded to Windows Server 2019, use the following PowerShell cmdlet to update the cluster functional level. After you update the cluster functional level, you can't go back to the previous cluster functional level. That is, after you update the cluster functional level, you can't add Windows Server 2016 nodes to the cluster. For more information, see [Cluster operating system rolling upgrade](../../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md).

    ```powershell
    Update-ClusterFunctionalLevel
    ```

    > [!NOTE]
    > Although you have up to four weeks to update the cluster functional level, we recommend that you update the cluster functional level as soon as possible.

6. After you update the cluster functional level, use the following cmdlet to update the storage pool. At this point, new cmdlets like `Get-ClusterPerf` are fully operational on any server in the cluster.

    ```powershell
    Update-StoragePool
    ```

7. Optionally, upgrade VM configuration levels by stopping each VM, using the `Update-VMVersion` cmdlet, and then starting the VMs again.

8. If you're using Software Defined Networking with SET switches and disabled VM live migration checks as instructed earlier, use the following cmdlet to reenable VM live verification checks:

    ```powershell
    Get-ClusterResourceType -Cluster {clusterName} -Name "Virtual Machine" | `
    Set-ClusterParameter  SkipMigrationDestinationCheck -Value 0
    ```

9. Verify that the upgraded cluster works as expected. Roles should fail over correctly. If VM live migration is used on the cluster, VMs should successfully live-migrate.

10. Validate the cluster by running cluster validation and examining the cluster validation report. In an elevated PowerShell session, run the following command:

    ```powershell
    Test-Cluster
    ```

## Clean OS installation while VMs are running

This option incurs no VM downtime, but you must wait for storage jobs (mirror repair) to complete after each server is upgraded. Although individual servers are restarted sequentially during the upgrade process, the remaining servers in the cluster and all VMs remain running.

1. Check that all servers in the cluster are running the latest updates. For more information, see [Windows 10 and Windows Server 2016 update history](https://support.microsoft.com/help/4000825/windows-10-windows-server-2016-update-history). At a minimum, install Microsoft Knowledge Base [article 4487006](https://support.microsoft.com/help/4487006/windows-10-update-kb4487006) (February 19, 2019). The build version should be 14393.2828 or later. You can check the build version by using the `ver` command or the `winver` command.

2. If you're using Software Defined Networking with SET switches, open an elevated PowerShell session and run the following command to disable VM live migration verification checks on all VMs on the cluster:

    ```powershell
    Get-ClusterResourceType -Cluster {clusterName} -Name "Virtual Machine" | `
    Set-ClusterParameter -Create SkipMigrationDestinationCheck -Value 1
    ```

3. On one cluster server at a time, complete the following steps:

   1. Use Hyper-V VM live migration to move running VMs off the server you're about to upgrade.

   2. Pause the cluster server by running the following PowerShell command. Some internal groups are hidden. We recommend that you do this step with caution. If you didn't already live-migrate VMs off the server, this cmdlet does that step for you. In that case, you can skip the previous step, if you prefer.

       ```powershell
       Suspend-ClusterNode -Drain
       ```

   3. Place the server in storage maintenance mode:

       ```powershell
       Get-StorageFaultDomain -type StorageScaleUnit | `
       Where FriendlyName -Eq <ServerName> | `
       Enable-StorageMaintenanceMode
       ```

   4. Run the following cmdlet to check that the **OperationalStatus** value is **In Maintenance Mode**:

       ```powershell
       Get-PhysicalDisk
       ```

   5. Evict the server from the cluster:

       ```powershell
       Remove-ClusterNode <ServerName>
       ```

   6. Perform a clean installation of Windows Server 2019 on the server. For a clean installation, format the system drive, run *setup.exe*, and use the **Nothing** option. You must configure the server identity, roles, features, and applications after setup finishes and the server restarts.

   7. Install the Hyper-V role and Failover-Clustering feature on the server (you can use the `Install-WindowsFeature` cmdlet).

   8. Install the latest storage and networking drivers for your hardware that are approved by your server manufacturer to use with Storage Spaces Direct.

   9. Check that the newly upgraded server has the latest Windows Server 2019 updates. For more information, see [Windows 10 and Windows Server 2019 update history](https://support.microsoft.com/help/4464619/windows-10-update-history). The build version should be 17763.292 or later. You can check the build number by using the `ver` command or the `winver` command.

   10. Rejoin the server to the cluster:

       ```powershell
       Add-ClusterNode
       ```

   11. Remove the server from storage maintenance mode:

       ```powershell
       Get-StorageFaultDomain -type StorageScaleUnit | `
       Where FriendlyName -Eq <ServerName> | `
       Disable-StorageMaintenanceMode
       ```

   12. Wait for storage repair jobs to finish and for all disks to return to a healthy state. The process might take considerable time depending on the number of VMs running during the server upgrade. To check for a healthy state, run these commands:

        ```powershell
        Get-StorageJob
        Get-VirtualDisk
        ```

4. Upgrade the next server in the cluster.

5. After all servers are upgraded to Windows Server 2019, use the following PowerShell cmdlet to update the cluster functional level. After you update the cluster functional level, you can't go back to the previous cluster functional level. That is, after you update the cluster functional level, you can't add Windows Server 2016 nodes to the cluster. For more information, see [Cluster operating system rolling upgrade](../../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md).

    ```powershell
    Update-ClusterFunctionalLevel
    ```

   > [!NOTE]
   > Although you have up to four weeks to update the cluster functional level, we recommend that you update the cluster functional level as soon as possible.

6. After you update the cluster functional level, use the following cmdlet to update the storage pool. At this point, new cmdlets like `Get-ClusterPerf` are fully operational on any server in the cluster.

    ```powershell
    Update-StoragePool
    ```

7. Optionally, upgrade VM configuration levels by stopping each VM, using the `Update-VMVersion` cmdlet, and then starting the VMs again.

8. If you're using Software Defined Networking with SET switches and disabled VM live migration checks as instructed earlier, use the following cmdlet to reenable VM live verification checks:

    ```powershell
    Get-ClusterResourceType -Cluster {clusterName} -Name "Virtual Machine" | `
    Set-ClusterParameter SkipMigrationDestinationCheck -Value 0
    ```

9. Verify that the upgraded cluster works as expected. Roles should fail over correctly. If VM live migration is used on the cluster, VMs should successfully live-migrate.

10. Validate the cluster by running Cluster Validation and examining the cluster validation report. In an elevated PowerShell session, run the following command:

    ```powershell
    Test-Cluster
    ```

## In-place upgrade while VMs are stopped

This option incurs VM downtime, but it might take less time than if you kept the VMs running during the upgrade because you don't need to wait for storage jobs (mirror repair) to finish after each server is upgraded. Although individual servers are restarted sequentially during the upgrade process, the remaining servers in the cluster remain running.

1. Check that all servers in the cluster are running the latest updates. For more information, see [Windows 10 and Windows Server 2016 update history](https://support.microsoft.com/help/4000825/windows-10-windows-server-2016-update-history). At a minimum, install Microsoft Knowledge Base [article 4487006](https://support.microsoft.com/help/4487006/windows-10-update-kb4487006) (February 19, 2019). The build version should be 14393.2828 or later. You can check the build version by using the `ver` command or the `winver` command.

2. Stop the VMs that are running on the cluster.

3. On one cluster at a time, complete the following steps:

   1. Pause the cluster server by opening an elevated PowerShell session and running the following PowerShell command. Some internal groups are hidden. We recommend that you do this step with caution.

       ```powershell
       Suspend-ClusterNode -Drain
       ```

   2. Place the server in storage maintenance mode:

       ```powershell
       Get-StorageFaultDomain -type StorageScaleUnit | `
       Where FriendlyName -Eq <ServerName> | `
       Enable-StorageMaintenanceMode
       ```

   3. Run the following cmdlet to check that the **OperationalStatus** value is **In Maintenance Mode**:

       ```powershell
       Get-PhysicalDisk
       ```

   4. Perform an upgrade installation of Windows Server 2019 on the server by running *setup.exe* and using the **Keep personal files and apps** option. When installation is finished, the server remains in the cluster and the cluster service starts automatically.

   5. Check that the newly upgraded server has the latest Windows Server 2019 updates. For more information, see [Windows 10 and Windows Server 2019 update history](https://support.microsoft.com/help/4464619/windows-10-update-history). The build version should be 17763.292 or later. You can check the build version by using the `ver` command or the `winver` command.

   6. Remove the server from storage maintenance mode:

       ```powershell
       Get-StorageFaultDomain -type StorageScaleUnit | `
       Where FriendlyName -Eq <ServerName> | `
       Disable-StorageMaintenanceMode
       ```

   7. Resume the server:

       ```powershell
       Resume-ClusterNode
       ```

   8. Wait for storage repair jobs to finish and for all disks to return to a healthy state. The process should be relatively fast because VMs aren't running. Run these commands to check for a healthy state:

       ```powershell
       Get-StorageJob
       Get-VirtualDisk
       ```

4. Upgrade the next server in the cluster.

5. After all servers are upgraded to Windows Server 2019, use the following PowerShell cmdlet to update the cluster functional level. After you update the cluster functional level, you can't go back to the previous cluster functional level. That is, after you update the cluster functional level, you can't add Windows Server 2016 nodes to the cluster. For more information, see [Cluster operating system rolling upgrade](../../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md).

    ```powershell
    Update-ClusterFunctionalLevel
    ```

   > [!NOTE]
   > Although you have up to four weeks to update the cluster functional level, we recommend that you update the cluster functional level as soon as possible.

6. After you update the cluster functional level, use the following cmdlet to update the storage pool. At this point, new cmdlets like `Get-ClusterPerf` are fully operational on any server in the cluster.

    ```powershell
    Update-StoragePool
    ```

7. Start the VMs on the cluster and check that they're working properly.

8. Optionally, upgrade VM configuration levels by stopping each VM, using the `Update-VMVersion` cmdlet, and then starting the VMs again.

9. Verify that the upgraded cluster works as expected. Roles should fail over correctly. If VM live migration is used on the cluster, VMs should successfully live-migrate.

10. Validate the cluster by running Cluster Validation and examining the cluster validation report. In an elevated PowerShell session, run the following command:

    ```powershell
    Test-Cluster
    ```

## Clean OS installation while VMs are stopped

This option incurs VM downtime, but it might take less time than if you kept the VMs running during the upgrade because you don't need to wait for storage jobs (mirror repair) to finish after each server is upgraded. Although individual servers are restarted sequentially during the upgrade process, the remaining servers in the cluster remain running.

1. Check that all the servers in the cluster are running the latest updates. For more info, see [Windows 10 and Windows Server 2016 update history](https://support.microsoft.com/help/4000825/windows-10-windows-server-2016-update-history). At a minimum, install Microsoft Knowledge Base [article 4487006](https://support.microsoft.com/help/4487006/windows-10-update-kb4487006) (February 19, 2019). The build version should be 14393.2828 or higher. You can check the build version by using the `ver` command or the `winver` command.

2. Stop the VMs that are running on the cluster.

3. One cluster server at a time, complete the following steps:

   1. Pause the cluster server by opening an elevated PowerShell session and running the following PowerShell command. Some internal groups are hidden. We recommend that you do this step with caution.

       ```powershell
       Suspend-ClusterNode -Drain
       ```

   2. Place the server in storage maintenance mode:

      ```powershell
      Get-StorageFaultDomain -type StorageScaleUnit | `
      Where FriendlyName -Eq <ServerName> | `
      Enable-StorageMaintenanceMode
      ```

   3. Run the following cmdlet to check that the **OperationalStatus** value is **In Maintenance Mode**:

       ```powershell
       Get-PhysicalDisk
       ```

   4. Evict the server from the cluster:

       ```powershell
       Remove-ClusterNode <ServerName>
       ```

   5. Perform a clean installation of Windows Server 2019 on the server. For a clean installation, format the system drive, run *setup.exe*, and use the **Nothing** option. You must configure the server identity, roles, features, and applications after setup finishes and the server restarts.

   6. Install the Hyper-V role and Failover-Clustering feature on the server (you can use the `Install-WindowsFeature` cmdlet).

   7. Install the latest storage and networking drivers for your hardware that are approved by your server manufacturer to use with Storage Spaces Direct.

   8. Check that the newly upgraded server has the latest Windows Server 2019 updates. For more information, see [Windows 10 and Windows Server 2019 update history](https://support.microsoft.com/help/4464619/windows-10-update-history). The build version should be 17763.292 or later. You can check the build version by using the `ver` command or the `winver` command.

   9. Rejoin the server to the cluster:

       ```powershell
       Add-ClusterNode
       ```

   10. Remove the server from storage maintenance mode:

       ```powershell
       Get-StorageFaultDomain -type StorageScaleUnit | `
       Where FriendlyName -Eq <ServerName> | `
       Disable-StorageMaintenanceMode
       ```

   11. Wait for storage repair jobs to finish and for all disks to return to a healthy state.  The process might take considerable time depending on the number of VMs running during the server upgrade. To check for a healthy state, run these commands:

       ```powershell
       Get-StorageJob
       Get-VirtualDisk
       ```

4. Upgrade the next server in the cluster.

5. After all servers are upgraded to Windows Server 2019, use the following PowerShell cmdlet to update the cluster functional level. After you update the cluster functional level, you can't go back to the previous cluster functional level. That is, after you update the cluster functional level, you can't add Windows Server 2016 nodes to the cluster. For more information, see [Cluster operating system rolling upgrade](../../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md).

    ```powershell
    Update-ClusterFunctionalLevel
    ```

   > [!NOTE]
   > Although you have up to four weeks to update the cluster functional level, we recommend that you update the cluster functional level as soon as possible.

6. After you update the cluster functional level, use the following cmdlet to update the storage pool. At this point, new cmdlets like `Get-ClusterPerf` are fully operational on any server in the cluster.

    ```powershell
    Update-StoragePool
    ```

7. Start the VMs on the cluster and check that they're working properly.

8. Optionally, upgrade VM configuration levels by stopping each VM, using the `Update-VMVersion` cmdlet, and then starting the VMs again.

9. Verify that the upgraded cluster works as expected. Roles should fail over correctly. If VM live migration is used on the cluster, VMs should successfully live-migrate.

10. Validate the cluster by running Cluster Validation and examining the cluster validation report. In an elevated PowerShell session, run the following command:

     ```powershell
     Test-Cluster
     ```
