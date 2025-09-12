---
title: Upgrade a Storage Spaces Direct cluster
description: Upgrade your Storage Spaces Direct cluster efficiently. Review supported upgrade methods, prerequisites, and how to keep your workloads running.
#customer intent: As an IT professional, I want to upgrade my Storage Spaces Direct cluster with minimal VM downtime so that my workloads stay available.
author: dknappettmsft
ms.author: daknappe
ms.date: 06/27/2025
ms.topic: upgrade-and-migration-article
---

# Upgrade a Storage Spaces Direct cluster

Upgrading a Storage Spaces Direct cluster to a newer version of Windows Server helps you take advantage of the latest features, security updates, and performance improvements. This article describes supported upgrade options for Storage Spaces Direct clusters running Windows Server 2016, including methods that minimize or eliminate virtual machine (VM) downtime. Learn about prerequisites, limitations, and step-by-step instructions for each upgrade approach, so you can choose the best method for your organization's needs.

> [!TIP]
> The steps covered in this article aren't needed if you're upgrading a cluster from Windows Server 2019 or later. If you're upgrading a cluster from Windows Server 2019 or later, use the [cluster OS rolling upgrade process](../../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md) to upgrade the cluster without stopping VMs. The steps in this article are for upgrading a cluster from Windows Server 2016 to Windows Server 2019 only.

To upgrade a Storage Spaces Direct cluster to a newer version of Windows Server, you have four options using the [cluster OS rolling upgrade process](../../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md). Two options involve keeping the virtual machines (VMs) running, and two options involve stopping all VMs. Each option has strengths and weaknesses, so select the option that best suits the needs of your organization.

To read more about an upgrade option, select a link:

- **In-place upgrade while VMs are running** on each server in the cluster. This option incurs no VM downtime, but you must wait for storage jobs (mirror repair) to finish after each server is upgraded.

- **Clean OS installation while VMs are running** on each server in the cluster. This option incurs no VM downtime. However, you must wait for storage jobs (mirror repair) to finish after each server is upgraded. You also need to set up each server again, including all its apps and roles. We recommend this option over an in-place upgrade.

- **In-place upgrade while VMs are stopped** on each server in the cluster. This option incurs VM downtime, but you don't need to wait for storage jobs (mirror repair), so it's faster.

- **Clean OS installation while VMs are stopped** on each server in the cluster. This option incurs VM downtime, but you don't need to wait for storage jobs (mirror repair), so it's faster. We recommend this option over an in-place upgrade.

## Prerequisites and limitations

Before you proceed with an upgrade:

- Storage Spaces Direct is enabled.

- Check that you have usable backups in case any issues occur during the upgrade process.

- Check that your hardware vendor has a BIOS, firmware, and drivers that are supported.

It's important to be aware of some limitations with the upgrade process:

- Upgrading is fully supported on Resilient File System (ReFS) volumes, but in Windows Server 2019, upgraded volumes don't benefit from ReFS enhancements. Benefits from ReFS, such as improved performance for mirror-accelerated parity, require a newly created Windows Server 2019 or later ReFS volume. To create a new Windows Server ReFS volume, you must create new volumes by using the `New-Volume` cmdlet or Server Manager. Here are some of the ReFS enhancements in new volumes:

  - **MAP log-bypass**: A performance improvement in ReFS that applies only to clustered (Storage Spaces Direct) systems and doesn't apply to standalone storage pools.

  - **Compaction**: Efficiency improvements that are specific to multi-resilient volumes.

- Before you upgrade your Storage Spaces Direct cluster server, we recommend that you put the server in storage maintenance mode.

- A known issue occurs with Software Defined Networking environments that use Switch Embedded Teaming (SET) switches. The issue involves Hyper-V VM live migrations to an earlier version of the operating system. To ensure successful live migrations, we recommend that you change a VM network setting on VMs that you live-migrate.

Because of the known issues described here, some customers might choose to build a new cluster and copy data from the old cluster, instead of upgrading their Windows Server clusters by using one of the four methods described below.

## Upgrade

The following section describes the four upgrade options in detail. Each section includes step-by-step instructions for performing the upgrade. Select your preferred upgrade option.

### [In-place upgrade while VMs are running](#tab/in-place-upgrade-while-vms-are-running)

This option incurs no VM downtime, but you must wait for storage jobs (mirror repair) to complete after each server is upgraded. Although individual servers are restarted sequentially during the upgrade process, the remaining servers in the cluster and all VMs remain running.

1. Check that all servers in the cluster have installed the latest Windows Update.

1. If you're using Software Defined Networking with SET switches, open an elevated PowerShell session and run the following command to disable VM live migration verification checks on all VMs on the cluster:

    ```powershell
    Get-ClusterResourceType -Cluster {clusterName} -Name "Virtual Machine" | `
    Set-ClusterParameter -Create SkipMigrationDestinationCheck -Value 1
    ```

1. On one cluster server at a time, complete the following steps:

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

   5. Perform an upgrade installation of Windows Server on the server by running *setup.exe* and using the **Keep personal files and apps** option. When installation is finished, the server remains in the cluster and the cluster service starts automatically.

   6. Check that the newly upgraded server has the latest Windows Server updates.

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

1. Upgrade the next server in the cluster.

1. After all servers are upgraded to the latest version of Windows Server, use the following PowerShell cmdlet to update the cluster functional level. After you update the cluster functional level, you can't go back to the previous cluster functional level. That is, after you update the cluster functional level, you can't add the older version of Windows Server nodes to the cluster. For more information, see [Cluster operating system rolling upgrade](../../failover-clustering/Cluster-Operating-System-Rolling-Upgrade.md).

    ```powershell
    Update-ClusterFunctionalLevel
    ```

    > [!NOTE]
    > Although you have up to four weeks to update the cluster functional level, we recommend that you update the cluster functional level as soon as possible.

1. After you update the cluster functional level, use the following cmdlet to update the storage pool. At this point, new cmdlets like `Get-ClusterPerf` are fully operational on any server in the cluster.

    ```powershell
    Update-StoragePool
    ```

1. Optionally, upgrade VM configuration levels by stopping each VM, using the `Update-VMVersion` cmdlet, and then starting the VMs again.

1. If you're using Software Defined Networking with SET switches and disabled VM live migration checks as instructed earlier, use the following cmdlet to reenable VM live verification checks:

    ```powershell
    Get-ClusterResourceType -Cluster {clusterName} -Name "Virtual Machine" | `
    Set-ClusterParameter  SkipMigrationDestinationCheck -Value 0
    ```

1. Verify that the upgraded cluster works as expected. Roles should fail over correctly. If VM live migration is used on the cluster, VMs should successfully live-migrate.

1. Validate the cluster by running cluster validation and examining the cluster validation report. In an elevated PowerShell session, run the following command:

    ```powershell
    Test-Cluster
    ```

### [Clean OS installation while VMs are running](#tab/clean-os-installation-while-vms-are-running)

This option incurs no VM downtime, but you must wait for storage jobs (mirror repair) to complete after each server is upgraded. Although individual servers are restarted sequentially during the upgrade process, the remaining servers in the cluster and all VMs remain running.

1. Check that all servers in the cluster are running the latest updates.

1. If you're using Software Defined Networking with SET switches, open an elevated PowerShell session and run the following command to disable VM live migration verification checks on all VMs on the cluster:

    ```powershell
    Get-ClusterResourceType -Cluster {clusterName} -Name "Virtual Machine" | `
    Set-ClusterParameter -Create SkipMigrationDestinationCheck -Value 1
    ```

1. On one cluster server at a time, complete the following steps:

   1. Use Hyper-V VM live migration to move running VMs off the server you're about to upgrade.

   1. Pause the cluster server by running the following PowerShell command. Some internal groups are hidden. We recommend that you do this step with caution. If you didn't already live-migrate VMs off the server, this cmdlet does that step for you. In that case, you can skip the previous step, if you prefer.

       ```powershell
       Suspend-ClusterNode -Drain
       ```

   1. Place the server in storage maintenance mode:

       ```powershell
       Get-StorageFaultDomain -type StorageScaleUnit | `
       Where FriendlyName -Eq <ServerName> | `
       Enable-StorageMaintenanceMode
       ```

   1. Run the following cmdlet to check that the **OperationalStatus** value is **In Maintenance Mode**:

       ```powershell
       Get-PhysicalDisk
       ```

   1. Evict the server from the cluster:

       ```powershell
       Remove-ClusterNode <ServerName>
       ```

   1. Perform a clean installation of the latest version of Windows Server on the server. For a clean installation, format the system drive, run *setup.exe*, and use the **Nothing** option. You must configure the server identity, roles, features, and applications after setup finishes and the server restarts.

   1. Install the Hyper-V role and Failover-Clustering feature on the server (you can use the `Install-WindowsFeature` cmdlet).

   1. Download and install the latest storage and networking drivers for your hardware from your server manufacturer that are approved for use with Storage Spaces Direct.

   1. Check that the newly upgraded server has the latest updates.

   1. Rejoin the server to the cluster:

       ```powershell
       Add-ClusterNode
       ```

   1. Remove the server from storage maintenance mode:

       ```powershell
       Get-StorageFaultDomain -type StorageScaleUnit | `
       Where FriendlyName -Eq <ServerName> | `
       Disable-StorageMaintenanceMode
       ```

   1. Wait for storage repair jobs to finish and for all disks to return to a healthy state. The process might take considerable time depending on the number of VMs running during the server upgrade. To check for a healthy state, run these commands:

        ```powershell
        Get-StorageJob
        Get-VirtualDisk
        ```

1. Upgrade the next server in the cluster.

1. After all servers are upgraded to the latest version of Windows Server, use the following PowerShell cmdlet to update the cluster functional level. After you update the cluster functional level, you can't go back to the previous cluster functional level.

    ```powershell
    Update-ClusterFunctionalLevel
    ```

   > [!NOTE]
   > Although you have up to four weeks to update the cluster functional level, we recommend that you update the cluster functional level as soon as possible.

1. After you update the cluster functional level, use the following cmdlet to update the storage pool. At this point, new cmdlets like `Get-ClusterPerf` are fully operational on any server in the cluster.

    ```powershell
    Update-StoragePool
    ```

1. Optionally, upgrade VM configuration levels by stopping each VM, using the `Update-VMVersion` cmdlet, and then starting the VMs again.

1. If you're using Software Defined Networking with SET switches and disabled VM live migration checks as instructed earlier, use the following cmdlet to reenable VM live verification checks:

    ```powershell
    Get-ClusterResourceType -Cluster {clusterName} -Name "Virtual Machine" | `
    Set-ClusterParameter SkipMigrationDestinationCheck -Value 0
    ```

1. Verify that the upgraded cluster works as expected. Roles should fail over correctly. If VM live migration is used on the cluster, VMs should successfully live-migrate.

1. Validate the cluster by running Cluster Validation and examining the cluster validation report. In an elevated PowerShell session, run the following command:

    ```powershell
    Test-Cluster
    ```

### [In-place upgrade while VMs are stopped](#tab/in-place-upgrade-while-vms-are-stopped)

This option performs an in-place upgrade of each server in the cluster while all VMs are stopped. The upgrade process is usually faster than upgrading while VMs are running, because you don't need to wait for storage jobs (mirror repair) to finish after each server is upgraded. Although individual servers are restarted sequentially during the upgrade process, the remaining servers in the cluster remain running.

1. Check that all servers in the cluster are running the latest updates.

1. Stop the VMs that are running on the cluster.

1. On one cluster at a time, complete the following steps:

   1. Pause the cluster server by opening an elevated PowerShell session and running the following PowerShell command. Some internal groups are hidden. We recommend that you do this step with caution.

       ```powershell
       Suspend-ClusterNode -Drain
       ```

   1. Place the server in storage maintenance mode:

       ```powershell
       Get-StorageFaultDomain -type StorageScaleUnit | `
       Where FriendlyName -Eq <ServerName> | `
       Enable-StorageMaintenanceMode
       ```

   1. Run the following cmdlet to check that the **OperationalStatus** value is **In Maintenance Mode**:

       ```powershell
       Get-PhysicalDisk
       ```

   1. Perform an upgrade installation of Windows Server on the server by running *setup.exe* and using the **Keep personal files and apps** option. When installation is finished, the server remains in the cluster and the cluster service starts automatically.

   1. Check that the newly upgraded server has the latest Windows Server updates.

   1. Remove the server from storage maintenance mode:

       ```powershell
       Get-StorageFaultDomain -type StorageScaleUnit | `
       Where FriendlyName -Eq <ServerName> | `
       Disable-StorageMaintenanceMode
       ```

   1. Resume the server:

       ```powershell
       Resume-ClusterNode
       ```

   1. Wait for storage repair jobs to finish and for all disks to return to a healthy state. The process should be relatively fast because VMs aren't running. Run these commands to check for a healthy state:

       ```powershell
       Get-StorageJob
       Get-VirtualDisk
       ```

1. Upgrade the next server in the cluster.

1. After all servers are upgraded to the latest version of Windows Server, use the following PowerShell cmdlet to update the cluster functional level.

    ```powershell
    Update-ClusterFunctionalLevel
    ```

   > [!NOTE]
   > Although you have up to four weeks to update the cluster functional level, we recommend that you update the cluster functional level as soon as possible.

1. After you update the cluster functional level, use the following cmdlet to update the storage pool. At this point, new cmdlets like `Get-ClusterPerf` are fully operational on any server in the cluster.

    ```powershell
    Update-StoragePool
    ```

1. Start the VMs on the cluster and check that they're working properly.

1. Optionally, upgrade VM configuration levels by stopping each VM, using the `Update-VMVersion` cmdlet, and then starting the VMs again.

1. Verify that the upgraded cluster works as expected. Roles should fail over correctly. If VM live migration is used on the cluster, VMs should successfully live-migrate.

1. Validate the cluster by running Cluster Validation and examining the cluster validation report. In an elevated PowerShell session, run the following command:

    ```powershell
    Test-Cluster
    ```

### [Clean OS installation while VMs are stopped](#tab/clean-os-installation-while-vms-are-stopped)

This option performs a clean installation of Windows Server on each server in the cluster while all VMs are stopped. The upgrade process is usually faster than upgrading while VMs are running, because you don't need to wait for storage jobs (mirror repair) to finish after each server is upgraded. Although individual servers are restarted sequentially during the upgrade process, the remaining servers in the cluster remain running.

1. Check that all the servers in the cluster are running the latest updates.

1. Stop the VMs that are running on the cluster.

1. One cluster server at a time, complete the following steps:

   1. Pause the cluster server by opening an elevated PowerShell session and running the following PowerShell command. Some internal groups are hidden. We recommend that you do this step with caution.

       ```powershell
       Suspend-ClusterNode -Drain
       ```

   1. Place the server in storage maintenance mode:

      ```powershell
      Get-StorageFaultDomain -type StorageScaleUnit | `
      Where FriendlyName -Eq <ServerName> | `
      Enable-StorageMaintenanceMode
      ```

   1. Run the following cmdlet to check that the **OperationalStatus** value is **In Maintenance Mode**:

       ```powershell
       Get-PhysicalDisk
       ```

   1. Evict the server from the cluster:

       ```powershell
       Remove-ClusterNode <ServerName>
       ```

   1. Perform a clean installation of Windows Server on the server. For a clean installation, format the system drive, run *setup.exe*, and use the **Nothing** option. You must configure the server identity, roles, features, and applications after setup finishes and the server restarts.

   1. Install the Hyper-V role and Failover-Clustering feature on the server (you can use the `Install-WindowsFeature` cmdlet).

   1. Download and install the latest storage and networking drivers for your hardware from your server manufacturer that are approved for use with Storage Spaces Direct.

   1. Check that the newly upgraded server has the latest Windows Server updates.

   1. Rejoin the server to the cluster:

       ```powershell
       Add-ClusterNode
       ```

   1. Remove the server from storage maintenance mode:

       ```powershell
       Get-StorageFaultDomain -type StorageScaleUnit | `
       Where FriendlyName -Eq <ServerName> | `
       Disable-StorageMaintenanceMode
       ```

   1. Wait for storage repair jobs to finish and for all disks to return to a healthy state.  The process might take considerable time depending on the number of VMs running during the server upgrade. To check for a healthy state, run these commands:

       ```powershell
       Get-StorageJob
       Get-VirtualDisk
       ```

1. Upgrade the next server in the cluster.

1. After all servers are upgraded to the latest version of Windows Server, use the following PowerShell cmdlet to update the cluster functional level.

    ```powershell
    Update-ClusterFunctionalLevel
    ```

   > [!NOTE]
   > Although you have up to four weeks to update the cluster functional level, we recommend that you update the cluster functional level as soon as possible.

1. After you update the cluster functional level, use the following cmdlet to update the storage pool. At this point, new cmdlets like `Get-ClusterPerf` are fully operational on any server in the cluster.

    ```powershell
    Update-StoragePool
    ```

1. Start the VMs on the cluster and check that they're working properly.

1. Optionally, upgrade VM configuration levels by stopping each VM, using the `Update-VMVersion` cmdlet, and then starting the VMs again.

1. Verify that the upgraded cluster works as expected. Roles should fail over correctly. If VM live migration is used on the cluster, VMs should successfully live-migrate.

1. Validate the cluster by running Cluster Validation and examining the cluster validation report. In an elevated PowerShell session, run the following command:

     ```powershell
     Test-Cluster
     ```

---


