---
Title: Virtualizing Domain Controllers using Hyper-V
description: Considerations to make when virtualizing Windows Server Active Directory Domain Controllers in Hyper-V
author: MicrosoftGuyJFlo
ms.author: joflore
ms.date: 04/19/2018
ms.topic: article
ms.prod: windows-server-threshold
---
# Virtualizing Domain Controllers using Hyper-V

> Applies to: Windows Server 2016

This topic will be updated in order to make the guidance applicable to Windows Server 2016. Windows Server 2012 introduces many improvements for virtualized domain controllers (DCs), including safeguards to prevent USN rollback on virtual DCs and the ability to clone virtual DCs. For more information about these improvements, see [Introduction to Active Directory Domain Services (AD DS) Virtualization (Level 100)](../../introduction-to-active-directory-domain-services-ad-ds-virtualization-level-100.md).

Hyper-V consolidates different server roles onto a single physical computer. This guide describes running domain controllers as 32-bit or 64-bit guest operating systems.

## Planning to Virtualize Domain Controllers

This section covers hardware requirements for Hyper-v server, how to avoid single points of failure, selecting the appropriate type of configuration for your Hyper-V servers and virtual machines, and security and performance decisions.

## Hyper-V requirements

To install and use the Hyper-V role, you must have the following:

   - **An x64 processor**
      - Hyper-V is available in x64-based versions of Windows Server 2008 or later.  
   - **Hardware-assisted virtualization**
      - This feature is available in processors that include a virtualization option, specifically, Intel Virtualization Technology (Intel VT) or AMD Virtualization (AMD-V).  
   - **Hardware Data Execution Protection (DEP)**
      - Hardware DEP must be available and enabled. Specifically, you must enable Intel XD bit (execute disable bit) or AMD NX bit (no execute bit).  

## Avoid creating single points of failure

You should attempt to avoid creating potential single points of failure when you plan your virtual domain controller deployment. You can avoid introducing potential single points of failure by implementing system redundancy. For example, consider the following recommendations while keeping in mind the potential for increases in the cost of administration:

1. Run at least two virtualized domain controllers per domain on different virtualization hosts, which reduces the risk of losing all domain controllers if a single virtualization host fails.  
2. As recommended for other technologies, diversify the hardware (using different CPUs, motherboards, network adapters, or other hardware) on which the domain controllers are running. Hardware diversification limits the damage that might be caused by a malfunction that is specific to a vendor configuration, a driver, or a single piece or type of hardware.  
3. If possible, domain controllers should be running on hardware that is located in different regions of the world. This helps to reduce the impact of a disaster or failure that affects a site at which the domain controllers are hosted.  
4. Maintain physical domain controllers in each of your domains. This mitigates the risk of a virtualization platform malfunction that affects all host systems that use that platform.  

## Security considerations

The host computer on which virtual domain controllers are running must be managed as carefully as a writeable domain controller, even if that computer is only a domain-joined or workgroup computer. This is an important security consideration. A mismanaged host is vulnerable to an elevation-of-privilege attack, which occurs when a malicious user gains access and system privileges that were not authorized or legitimately assigned. A malicious user can use this type of attack to compromise all the virtual machines, domains, and forests that this computer hosts.

Be sure to keep the following security considerations in mind when you are planning to virtualize domain controllers:

   - The local administrator of a computer that hosts virtual, writeable domain controllers should be considered equivalent in credentials to the default domain administrator of all the domains and forests that those domain controllers belong to.  
   - The recommended configuration to avoid security and performance issues is a host running a Server Core installation of Windows Server 2008 or later, with no applications other than Hyper-V. This configuration limits the number of applications and services that are installed on the server, which should result in increased performance and fewer applications and services that could be maliciously exploited to attack the computer or network. The effect of this type of configuration is known as a reduced attack surface. In a branch office or other locations that cannot be satisfactorily secured, a read-only domain controller (RODC) is recommended. If a separate management network exists, we recommend that the host be connected only to the management network.  
   - You can use Bitlocker with your domain controllers, since Windows Server 2016 you can use the virtual TPM feature to also give the guest key material to unlock the system volume.
   - [Guarded fabric and shielded VMs](/it-server/WindowsServerDocs/virtualization/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms.md) can provide additional controls to protect your domain controllers.

For information about RODCs, see [Read-Only Domain Controller Planning and Deployment Guide](../../deploy/rodc/read-only-domain-controller-updates.md).

For more information about securing domain controllers, see [Best Practice Guide for Securing Active Directory Installations](../../plan/security-best-practices/best-practices-for-securing-active-directory.md).

## Security boundaries for different host and guest configurations

Using virtual machines makes it possible to have many different configurations of domain controllers. Careful consideration must be given to the way that virtual machines affect boundaries and trusts in your Active Directory topology. Possible configurations for an Active Directory domain controller and host (Hyper-V server) and its guest computers (virtual machines running on the Hyper-V server) are described in the following table.

|Machine|Configuration 1|Configuration 2|
|-------|---------------|---------------|
|Host|Workgroup or member computer|Workgroup or member computer|
|Guest|Domain controller|Workgroup or member computer|

![](media/virtualized-domain-controller-architecture/Dd363553.f44706fd-317e-4f0b-9578-4243f4db225f(WS.10).gif)

   - The administrator on the host computer has the same access as a domain administrator on the writable domain controller guests and must be treated as such. In the case of an RODC guest, the administrator of the host computer has the same access as a local administrator on the guest RODC.   
   - A domain controller in a virtual machine has administrative rights on the host if the host is joined to the same domain. There is an opportunity for a malicious user to compromise all virtual machines if the malicious user first gains access to Virtual Machine 1. This is known as an attack vector. If there are domain controllers for multiple domains or forests, these domains should have centralized administration in which the administrator of one domain is trusted on all domains.  
   - The opportunity for attack from Virtual Machine 1 exists even if Virtual Machine 1 is installed as an RODC. Although an administrator of an RODC does not explicitly have domain administrator rights, the RODC can be used to send policies to the host computer. These policies might include startup scripts. If this operation is successful, the host computer can be compromised, and it can then be used to compromise the other virtual machines on the host computer.  

## Security of VHD files

A VHD file of a virtual domain controller is equivalent to the physical hard drive of a physical domain controller. As such, it should be protected with the same amount of care that goes into securing the hard drive of a physical domain controller. Make sure that only reliable and trusted administrators are allowed access to the domain controller’s VHD files.

## RODCs

One benefit of RODCs is the ability to place them at locations where physical security cannot be guaranteed, such as at branch offices. You can use Windows BitLocker Drive Encryption to protect VHD files themselves (not the file systems therein) from being compromised on the host through theft of the physical disk. 

## Performance

With the new microkernel 64-bit architecture, there are significant increases in Hyper-V performance from previous virtualization platforms. For best host performance, the host should be a Server Core installation of Windows Server 2008 or later, and it should not have server roles other than Hyper-V installed.

Performance of virtual machines depends specifically on the workload. To guarantee satisfactory Active Directory performance, test specific topologies. Assess the current workload over a period of time with a tool such as the Reliability and Performance Monitor (Perfmon.msc) or the [Microsoft Assessment and Planning (MAP) toolkit](https://go.microsoft.com/fwlink/?linkid=137077). The MAP tool can also be valuable if you want to take an inventory of all of the servers and server roles that currently exist in your network.

To get a general idea of the performance of virtualized domain controllers, the following performance tests were carried out with the [Active Directory Performance Testing Tool (ADTest.exe)](https://go.microsoft.com/fwlink/?linkid=137088).

Lightweight Directory Access Protocol (LDAP) tests were run on a physical domain controller with ADTest.exe and then on a virtual machine that was hosted on a server that was identical to the physical domain controller. Only one logical processor was used for the physical computer, and only one virtual processor was used for the virtual machine to easily reach 100-percent CPU utilization. In the following table, the letter and number in parenthesis after each test indicate the specific test in ADTest.exe. As this data shows, virtualized domain controller performance was 88 to 98 percent of the physical domain controller performance.

<table>
<colgroup>
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
<col style="width: 20%" />
</colgroup>
<thead>
<tr class="header">
<th>Measurement</th>
<th>Test</th>
<th>Physical</th>
<th>Virtual</th>
<th>Delta</th>
</tr>
</thead>
<tbody>
<tr class="odd">
<td><p>Searches/sec</p></td>
<td><p>Search for common name in base scope (L1)</p></td>
<td><p>11508</p></td>
<td><p>10276</p></td>
<td><p>-10.71%</p></td>
</tr>
<tr class="even">
<td><p>Searches/sec</p></td>
<td><p>Search for a set of attributes in base scope (L2)</p></td>
<td><p>10123</p></td>
<td><p>9005</p></td>
<td><p>-11.04%</p></td>
</tr>
<tr class="odd">
<td><p>Searches/sec</p></td>
<td><p>Search for all attributes in base scope (L3)</p></td>
<td><p>1284</p></td>
<td><p>1242</p></td>
<td><p>-3.27%</p></td>
</tr>
<tr class="even">
<td><p>Searches/sec</p></td>
<td><p>Search for common name in subtree scope (L6)</p></td>
<td><p>8613</p></td>
<td><p>7904</p></td>
<td><p>-8.23%</p></td>
</tr>
<tr class="odd">
<td><p>Successful binds/sec</p></td>
<td><p>Perform fast binds (B1)</p></td>
<td><p>1438</p></td>
<td><p>1374</p></td>
<td><p>-4.45%</p></td>
</tr>
<tr class="even">
<td><p>Successful binds/sec</p></td>
<td><p>Perform simple binds (B2)</p></td>
<td><p>611</p></td>
<td><p>550</p></td>
<td><p>-9.98%</p></td>
</tr>
<tr class="odd">
<td><p>Successful binds/sec</p></td>
<td><p>Use NTLM to perform binds (B5)</p></td>
<td><p>1068</p></td>
<td><p>1056</p></td>
<td><p>-1.12%</p></td>
</tr>
<tr class="even">
<td><p>Writes/sec</p></td>
<td><p>Write multiple attributes (W2)</p></td>
<td><p>6467</p></td>
<td><p>5885</p></td>
<td><p>-9.00%</p></td>
</tr>
</tbody>
</table>

To ensure satisfactory performance, integration components (IC) were installed to allow the guest operating system to use “enlightenments,” or hypervisor-aware synthetic drivers. During the installation process, it may be necessary to use emulated Integrated Drive Electronics (IDE) or network adapter drivers. In production environments, you should replace these emulated drivers with synthetic drivers to increase performance.

When you monitor performance of virtual machines with Reliability and Performance Manager (Perfmon.msc), within the virtual machine the CPU information will not be entirely accurate as a result of the way the virtual CPU is scheduled on the physical processor. When you want to obtain CPU information for a virtual machine that is running on a Hyper-V server, use the Hyper-V Hypervisor Logical Processor counters in the host partition.

For more information about performance tuning of both AD DS and Hyper-V, see [Performance Tuning Guidelines for Windows Server 2016](../../../../administration/performance-tuning/index.md).

Also, do not plan to use a differencing disk VHD on a virtual machine that is configured as a domain controller because the differencing disk VHD can reduce performance. To learn more about Hyper-V disk types, including differencing disks, see [New Virtual Hard Disk Wizard](http://go.microsoft.com/fwlink/?linkid=137279).

For additional information regarding AD DS in virtual hosting environments, see [Things to consider when you host Active Directory domain controllers in virtual hosting environments](https://go.microsoft.com/fwlink/?linkid=141292) in the Microsoft Knowledge Base.

## Deployment Considerations for Virtualized Domain Controllers

There are several common virtual machine practices that you should avoid when you deploy domain controllers, and special considerations for time synchronization and storage.

## Virtualization deployment practices to avoid

Virtualization platforms, such as Hyper-V, offer a number of convenience features that make managing, maintaining, backing up, and migrating computers easier. However, the following common deployment practices and features should not be used for virtual domain controllers:

- To ensure durability of Active Directory writes, do not deploy a virtual domain controller’s database files (the Active Directory database (NTDS.DIT), logs and SYSVOL) on virtual IDE disks. Instead, create a second VHD attached to a virtual SCSI controller and ensure that the database, logs, and SYSVOL are placed on the virtual machine’s SCSI disk during domain controller installation.  
- Do not implement differencing disk virtual hard disks (VHDs) on a virtual machine that you are configuring as a domain controller. This makes it too easy to revert to a previous version, and it also decreases performance. For more information about VHD types, see [New Virtual Hard Disk Wizard](https://go.microsoft.com/fwlink/?linkid=137279).  
- Do not deploy new Active Directory domains and forests on a copy of a Windows Server operating system that was not first prepared using System Preparation tool (Sysprep). For more information about running the Sysprep, see [Sysprep (System Preparation) Overview](https://docs.microsoft.com/windows-hardware/manufacture/desktop/sysprep--system-preparation--overview)

   > [!WARNING]
   > Running Sysprep on a domain controller is not supported.

- To help prevent a potential update sequence number (USN) rollback situation, do not use copies of a VHD file that represents an already deployed domain controller to deploy additional domain controllers. For more information about USN rollback, see [USN and USN Rollback](#usn-and-usn-rollback).
   - Windows Server 2012 and newer allows administrators to clone domain controller images if prepared properly when they want to deploy additional domain controllers
- Do not use the Hyper-V Export feature to export a virtual machine that is running a domain controller.
  - With Windows Server 2012 and newer, an export and import of a Domain Controller virtual guest is handled like a non-authoritative restore as it detects a change of the Generation ID and it is not configured for cloning.
  - Ensure you are not using the guest that you exported anymore.
    - You may use Hyper-V Replication to keep a second inactive copy of a Domain Controller. If you start the replicated image, you also need to perform proper cleanup, for the same reason as not using the source after exporting a DC guest image.

## Physical-to-virtual migration

System Center Virtual Machine Manager (VMM) 2008 provides unified management of physical machines and virtual machines. It also provides the ability to migrate a physical machine to a virtual machine. This process is known as physical-to-virtual machine conversion (P2V conversion). During the P2V conversion process, the new virtual machine and the physical domain controller that is being migrated must not be running at the same time, to avoid a USN rollback situation as described in [USN and USN Rollback](#usn-and-usn-rollback).

You should perform P2V conversion using offline mode so that the directory data is consistent when the domain controller is turned back on. The offline mode option is offered and recommended in the Convert Physical Server Wizard. For a description of the difference between online mode and offline mode, see [P2V: Converting Physical Computers to Virtual Machines in VMM](https://go.microsoft.com/fwlink/?linkid=155072). During P2V conversion, the virtual machine should not be connected to the network. The network adapter of the virtual machine should be enabled only after the P2V conversion process is complete and verified. At this point, the physical source machine will be off. Do not bring the physical source machine back onto the network again before you reformat the hard disk.

> [!NOTE]
> There are safer options to create new virtual DCs that don’t run the risks of creating a USN Rollback. You may setup a new virtual DC by regular promotion, promotion from Install from Media (IfM), and also using Domain Controller cloning, if you already have at least one virtual DC.
This also helps avoiding problems with hardware or platform-related problems P2V-converted virtual guests may encounter.

> [!WARNING]
> To prevent issues with Active Directory replication, ensure that only one instance (physical or virtual) of a given domain controller exists on a given network at any point in time.
> You can lower the likelihood of the old clone being a problem:
> 
> -	When the new virtual DC is running, change the computer account password twice using: netdom resetpwd /Server:<domain-controller> …
> - Export and import the new virtual guest to force it becoming a new Generation ID and hence a database invocation ID.
> 

## Using P2V Migration to Create Test Environments

You can use P2V migration through the VMM to create test environments. You can migrate production domain controllers from physical machines to virtual machines to create a test environment without permanently bringing down the production domain controllers. However, the test environment must be on a different network from the production environment if two instances of the same domain controller are to exist. Great care must be taken in the creation of test environments with P2V migration to avoid USN rollbacks that can affect your test and production environments. The following is a method that you can use for creating test environments with P2V.

One in-production domain controller from each domain is migrated to a test virtual machine using P2V according to the guidelines stated in the Physical-to-virtual migration section. The physical production machines and the test virtual machines must be in different networks when they are brought back online. To avoid USN rollbacks in the test environment, all domain controllers that are to be migrated from physical machines to virtual machines must be taken offline. (You can do this by stopping the ntds service or by restarting the computer in Directory Services Restore Mode (DSRM).) After the domain controllers are offline, no new updates should be introduced to the environment. The computers must remain offline during the P2V migration; none of the computers should be brought back online until all the computers have been fully migrated. To learn more about USN rollback, see USN and USN Rollback.

Subsequent test domain controllers should be promoted as replicas in the test environment.

## Time service

For virtual machines that are configured as domain controllers, it is recommended that you disable time synchronization between the host system and guest operating system acting as a domain controller. This enables your guest domain controller to synchronize time from the domain hierarchy.

To disable the Hyper-V time synchronization provider, shut down the VM and clear the Time synchronization check box under Integration Services.

> [!NOTE]
> This guidance has been recently updated to reflect the current recommendation to synchronize time for the guest domain controller from only the domain hierarchy, rather than the previous recommendation to partially disable time synchronization between the host system and guest domain controller.

## Storage

To optimize the performance of the domain controller virtual machine and ensure durability of Active Directory writes, use the following recommendations for storing operating system, Active Directory, and VHD files:

- **Guest storage**. Store the Active Directory database file (Ntds.dit), log files, and SYSVOL files on a separate virtual disk from the operating system files. Create a second VHD attached to a virtual SCSI controller and store the database, logs, and SYSVOL on the virtual machine’s virtual SCSI disk. Virtual SCSI disks provide increased performance compared to virtual IDE and they support Forced Unit Access (FUA). FUA ensures that the operating system writes and reads data directly from the media bypassing any and all caching mechanisms.

  > [!NOTE]
  > If you are planning to use Bitlocker for the virtual DC guest, you need to make sure the additional volumes are configured for “auto unlock”.
  > More information about configuring auto unlock can be found in [Enable-BitLockerAutoUnlock](https://docs.microsoft.com/powershell/module/bitlocker/enable-bitlockerautounlock)

- **Host storage of VHD files**. Recommendations: Host storage recommendations address storage of VHD files. For maximum performance, do not store VHD files on a disk that is used frequently by other services or applications, such as the system disk on which the host Windows operating system is installed. Store each VHD file on a separate partition from the host operating system and any other VHD files. The ideal configuration is to store each VHD file on a separate physical drive.  

  The host physical disk system must also satisfy **at least one** of the following criteria to meet the requirements of virtualized workload data integrity:  

   - The system uses server-class disks (SCSI, Fibre Channel).  
   - The system makes sure that the disks are connected to a battery-backed caching host bus adapter (HBA).  
   - The system uses a storage controller (for example, a RAID system) as the storage device.  
   - The system makes sure that power to the disk is protected by an uninterruptible power supply (UPS).  
   - The system makes sure that the disk's write-caching feature is disabled.  

- **Fixed VHD versus pass-through disks**. There are many ways to configure storage for virtual machines. When VHD files are used, fixed-size VHDs are more efficient than dynamic VHDs because the memory for fixed-size VHDs is allocated when they are created. Pass-through disks, which virtual machines can use to access physical storage media, are even more optimized for performance. Pass-through disks are essentially physical disks or logical unit numbers (LUNs) that are attached to a virtual machine. Pass-through disks do not support the snapshot feature. Therefore, pass-through disks are the preferred hard disk configuration, because the use of snapshots with domain controllers is not recommended.  

To reduce the chance of corruption of Active Directory data, use virtual SCSI controllers:

   - Use SCSI physical drives (as opposed to IDE/ATA drives) on Hyper-V servers that host virtual domain controllers. If you cannot use SCSI drives, ensure that write caching is disabled on the ATA/IDE drives that host virtual domain controllers. For more information, see [Event ID 1539 – Database Integrity](https://go.microsoft.com/fwlink/?linkid=162419).
   - To guarantee the durability of Active Directory writes, the Active Directory database, logs, and SYSVOL must be placed on a virtual SCSI disk. Virtual SCSI disks support Forced Unit Access (FUA). FUA ensures that the operating system writes and reads data directly from the media bypassing any and all caching mechanisms.  

## Operational Considerations for Virtualized Domain Controllers

Domain controllers that are running on virtual machines have operational restrictions that do not apply to domain controllers that are running on physical machines. When you use a virtualized domain controller, there are some virtualization software features and practices that you should not use:

   - Do not pause, stop, or store the saved state of a domain controller in a virtual machine for time periods longer than the tombstone lifetime of the forest and then resume from the paused or saved state. Doing this can interfere with replication. To learn how to determine the tombstone lifetime for the forest, see [Determine the Tombstone Lifetime for the Forest](https://go.microsoft.com/fwlink/?linkid=137177).  
   - Do not copy or clone virtual hard disks (VHDs). Even with the Safeguards in place for the guest VM, individual VHDs can still be copied and cause USN roll-back.
   - Do not take or use a Snapshot of a virtual domain controller. It is technically supported with Windows Server 2012 and newer, it is not a replacement for a good backup strategy. There are few reasons for taking DC snapshots or restoring the snapshots.
   - Do not use a differencing disk VHD on a virtual machine that is configured as a domain controller. This makes reverting to a previous version too easy, and it also decreases performance.  
   - Do not use the Export feature on a virtual machine that is running a domain controller.  
   - Do not restore a domain controller or attempt to roll back the contents of an Active Directory database by any means other than using a supported backup. For more information, see [Backup and Restore Considerations for Virtualized Domain Controllers](#backup-and-restore-practices-to-avoid).  

All these recommendations are made to help avoid the possibility of an update sequence number (USN) rollback. For more information about USN rollback, see USN and USN Rollback.

## Backup and Restore Considerations for Virtualized Domain Controllers

Backing up domain controllers is a critical requirement for any environment. Backups protect against data loss in the event of domain controller failure or administrative error. If such an event occurs, it is necessary to roll back the system state of the domain controller to a point in time before the failure or error. The supported method of restoring a domain controller to a healthy state is to use an Active Directory–compatible backup application, such as Windows Server Backup, to restore a system state backup that originated from the current installation of the domain controller. For more information about using Windows Server Backup with Active Directory Domain Services (AD DS), see the [AD DS Backup and Recovery Step-by-Step Guide](https://go.microsoft.com/fwlink/?LinkId=138501).

With virtual machine technology, certain requirements of Active Directory restore operations take on added significance. For example, if you restore a domain controller by using a copy of the virtual hard disk (VHD) file, you bypass the critical step of updating the database version of a domain controller after it has been restored. Replication will proceed with inappropriate tracking numbers, resulting in an inconsistent database among domain controller replicas. In most cases, this problem goes undetected by the replication system and no errors are reported, despite inconsistencies between domain controllers.

There is one supported way to perform backup and restore of a virtualized domain controller:

1. Run Windows Server Backup in the guest operating system.  

With Windows Server 2012 and newer Hyper-V hosts and guests, you can take supported backups of domain controllers using snapshots, guest VM export and import and also Hyper-V Replication. All of these however are not a good fit for creating a proper backup history, with the slight exception of guest VM export.

With Windows Server 2016 Hyper-V there is support for “production snapshots” where the Hyper-V server triggers a VSS-based backup of the guest and when the guest is done with the snapshot, the host fetches the VHDs and stores them in the backup location.

While this works with Windows Server 2012 and newer, there is an incompatibility with Bitlocker:

- When doing a VSS Snap-Shot, AD wants to perform a post-snapshot task to mark the database as coming from a backup, or in the case of preparing a IFM source for RODC, remove credentials from the database.
- When Hyper-V mounts the snapshotted volume for this task, there is no facility that would unlock the Volume for unencrypted access. So the AD database engine fails accessing the database and eventually fails the snapshot.

> [!NOTE]
> The shielded VM project mentioned previously has a Hyper-V host driven backup as a non-goal for maximum data protection of the guest VM.

## Backup and restore practices to avoid

As mentioned, domain controllers that are running in virtual machines have restrictions that do not apply to domain controllers that are running in physical machines. When you back up or restore a virtual domain controller, there are certain virtualization software features and practices that you should not use:

   - Do not copy or clone VHD files of domain controllers instead of performing regular backups. If he VHD file is copied or cloned, it becomes stale. Then, if the VHD is started in normal mode, you will encounter a USN Rollback. You should perform proper backup operations that are supported by Active Directory Domain Services (AD DS), such as using the Windows Server Backup feature.  
   - Do not use the Snapshot feature as a backup to restore a virtual machine that was configured as a domain controller. Problems will occur with replication when you revert the virtual machine to an earlier state with Windows Server 2008 R2 and older. For more information, see [USN and USN Rollback](#usn-and-usn-rollback). Although using a snapshot to restore a read-only domain controller (RODC) will not cause replication issues, this method of restoration is still not recommended.  

## Restoring a virtual domain controller

To restore a domain controller when it fails, you must regularly backup system state. System state includes Active Directory data and log files, the registry, the system volume (SYSVOL folder), and various elements of the operating system. This requirement is the same for physical and virtual domain controllers. System state restore procedures that Active Directory–compatible backup applications perform are designed to ensure the consistency of local and replicated Active Directory databases after a restore process, including the notification to replication partners of invocation ID resets. However, using virtual hosting environments and disk or operating system imaging applications makes it possible for administrators to bypass the checks and validations that ordinarily occur when domain controller system state is restore.

When a domain controller virtual machine fails and an update sequence number (USN) rollback has not occurred, there are two supported situations for restoring the virtual machine:

   - If a valid system state data backup that predates the failure exists, you can restore system state by using the restore option of the backup utility that you used to create the backup. The system state data backup must have been created using an Active Directory–compatible backup utility within the span of the tombstone lifetime, which is by default, no more than 180 days. You should back up your domain controllers at least every half tombstone lifetime. For instructions about how to determine the specific tombstone lifetime for your forest, see [Determine the Tombstone Lifetime for the Forest](https://go.microsoft.com/fwlink/?linkid=137177).  
   - If a working copy of the VHD file is available, but no system state backup is available, you can remove the existing virtual machine. Restore the existing virtual machine by using a previous copy of the VHD, but be sure to start it in Directory Services Restore Mode (DSRM) and configure the registry properly, as described in the following section. Then, restart the domain controller in normal mode.

Use the process in the following illustration to determine the best way to restore your virtualized domain controller.

![](media/virtualized-domain-controller-architecture/Dd363553.85c97481-7b95-4705-92a7-006e48bc29d0(WS.10).gif)

For RODCs, the restoration process and decisions are simpler.

![](media/virtualized-domain-controller-architecture/Dd363553.4c5c5eda-df95-4c6b-84e0-d84661434e5d(WS.10).gif)

## Restoring the system state backup of a virtual domain controller

If a valid system state backup exists for the domain controller virtual machine, you can safely restore the backup by following the restore procedure prescribed by the backup tool that you used to back up the VHD file.

> [!IMPORTANT]
> To properly restore the domain controller, you must start it in DSRM. You must not allow the domain controller to start in normal mode. If you miss the opportunity to enter DSRM during system startup, turn off the domain controller’s virtual machine before it can fully start in normal mode. It is important to start the domain controller in DSRM because starting a domain controller in normal mode increments its USNs, even if the domain controller is disconnected from the network. For more information about USN rollback, see USN and USN Rollback. 

## To restore the system state backup of a virtual domain controller

1. Start the domain controller’s virtual machine, and press F5 to access the Windows Boot Manager screen. If you are required to enter connection credentials, immediately click the **Pause** button on the virtual machine so that it does not continue starting. Then, enter your connection credentials, and click the **Play** button on the virtual machine. Click inside the virtual machine window, and then press F5.

   If you do not see the Windows Boot Manager screen and the domain controller begins to start in normal mode, turn off the virtual machine to prevent it from completing startup. Repeat this step as many times as necessary until you are able to access the Windows Boot Manager screen. You cannot access DSRM from the Windows Error Recovery menu. Therefore, turn off the virtual machine and try again if the Windows Error Recovery menu appears.

2. In the Windows Boot Manager screen, press F8 to access advanced boot options.
3. In the **Advanced Boot Options** screen, select **Directory Services Restore Mode**, and then press ENTER. This starts the domain controller in DSRM.
4. Use the appropriate restore method for the tool that you used to create the system state backup. If you used Windows Server Backup, see [Performing a Nonauthoritative Restore of AD DS](https://go.microsoft.com/fwlink/?linkid=132637).

## Restoring a virtual domain controller when an appropriate system state data backup is not available

If you do not have a system state data backup that predates the virtual machine failure, you can use a previous VHD file to restore a domain controller that is running on a virtual machine. If you can, make a copy of the VHD, so that if you encounter an issue during the procedure or miss a step, you can try again with the copied VHD.

> [!IMPORTANT]
> - You should not consider using the following procedure as a replacement for regularly planned and scheduled backups.
> - **Restores that are performed with the following procedure are not supported by Microsoft and should be used only when there is no other alternative.**
> - Do not use this procedure if the copy of the VHD that you are about to restore has been started in normal mode by any virtual machine.

## To restore a previous version of a virtual domain controller VHD without system state data backup

1. Using the previous VHD, start the virtual domain controller in DSRM, as described in the previous section. Do not allow the domain controller to start in normal mode. If you miss the Windows Boot Manager screen and the domain controller begins to start in normal mode, turn off the virtual machine to prevent it from completing startup. See the previous section for detailed instructions for entering DSRM.
2. Open Registry Editor. To open Registry Editor, click **Start**, click **Run**, type **regedit**, and then click OK. If the **User Account Control** dialog box appears, confirm that the action it displays is what you want, and then click **Yes**. In Registry Editor, expand the following path: **HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Services\\NTDS\\Parameters**. Look for a value named **DSA Previous Restore Count**. If the value is there, make a note of the setting. If the value is not there, the setting is equal to the default, which is zero. Do not add a value if you do not see one there.
3. Right-click the **Parameters** key, click **New**, and then click **DWORD (32-bit) Value**.
4. Type the new name **Database restored from backup**, and then press ENTER.
5. Double-click the value that you just created to open the **Edit DWORD (32-bit) Value** dialog box, and then type **1** in the **Value data** box. The **Database restored from backup entry** option is available on domain controllers that are running Windows 2000 Server with Service Pack 4 (SP4), Windows Server 2003 with the updates that are included in [How to detect and recover from a USN rollback in Windows Server 2003, Windows Server 2008, and Windows Server 2008 R2](https://go.microsoft.com/fwlink/?linkid=137182) in the Microsoft Knowledge Base installed, and Windows Server 2008.
6. Restart the domain controller in normal mode.
7. When the domain controller restarts, open Event Viewer. To open Event Viewer, click **Start**, click **Control Panel**, double-click **Administrative Tools**, and then double-click **Event Viewer**.
8. Expand **Application and Services Logs**, and then click the **Directory Services** log. Ensure that events appear in the details pane.
9. Right-click the **Directory Services** log, and then click **Find**. In **Find what**, type **1109**, and then click **Find Next**.
10. You should see at least an Event ID 1109 entry. If you do not see this entry, proceed to the next step. Otherwise, double-click the entry, and then review the text confirming that the update was made to the InvocationID:

    ```
    Active Directory has been restored from backup media, or has been configured to host an application partition. 
    The invocationID attribute for this directory server has been changed. 
    The highest update sequence number at the time the backup was created is <time>

    InvocationID attribute (old value):<Previous InvocationID value>
    InvocationID attribute (new value):<New InvocationID value>
    Update sequence number:<USN>

    The InvocationID is changed when a directory server is restored from backup media or is configured to host a writeable application directory partition.
    ```

11. Close Event Viewer.
12. Use Registry Editor to verify that the value in **DSA Previous Restore Count** is equal to the previous value plus one. If this is not the correct value and you cannot find an entry for Event ID 1109 in Event Viewer, verify that the domain controller’s service packs are current. You cannot try this procedure again on the same VHD. You can try again on a copy of the VHD or a different VHD that has not been started in normal mode by starting over at step 1.
13. Close Registry Editor.

## USN and USN Rollback

This section describes replication issues that can occur as a result of an incorrect restoration of the Active Directory database with an older version of a virtual machine. For additional details about the Active Directory replication process, see [Active Directory Replication Concepts](../replication/active-directory-replication-concepts.md)

## USNs

Active Directory Domain Services (AD DS) uses update sequence numbers (USNs) to keep track of replication of data between domain controllers. Each time that a change is made to data in the directory, the USN is incremented to indicate that a change has been made.

For each directory partition that a destination domain controller stores, USNs are used to track the latest originating update that a domain controller introduced to its database, as well as the status of every other domain controller that stores a replica of the directory partition. When domain controllers replicate changes to one another, they query their replication partners for changes with USNs that are greater than the USN of the last change that the domain controller received from each partner.

The following two replication metadata tables contain USNs. Source and destination domain controllers use them to filter updates that the destination domain controller requires.

1. **Up-to-dateness vector**: A table that the destination domain controller maintains for tracking the originating updates that are received from all source domain controllers. When a destination domain controller requests changes for a directory partition, it provides its up-to-dateness vector to the source domain controller. The source domain controller then uses this value to filter the updates that it sends to the destination domain controller. The source domain controller sends its up-to-dateness vector to the destination at the completion of a successful replication cycle in order to ensure that the destination domain controller knows that it has synchronized with every domain controllers’ originating updates and the updates are at the same level as the source.  
2. **High water mark**: A value that the destination domain controller maintains to keep track of the most recent changes that it has received from a specific source domain controller for a specific partition. The high water mark prevents the source domain controller from sending out changes that by the destination domain controller has already received from it.  

## Directory database identity

In addition to USNs, domain controllers keep track of the directory database of source replication partners. The identity of the directory database running on the server is maintained separately from the identity of the server object itself. The directory database identity on each domain controller is stored in the **invocationID** attribute of the NTDS Settings object, which is located under the following Lightweight Directory Access Protocol (LDAP) path: cn=NTDS Settings, cn=ServerName, cn=Servers, cn=*SiteName*, cn=Sites, cn=Configuration, dc=*ForestRootDomain*. The server object identity is stored in the **objectGUID** attribute of the NTDS Settings object. The identity of the server object never changes. However, the identity of the directory database changes when a system state restore procedure occurs on the server or when an application directory partition is added, then removed and later re-added from the server. (other scenario: when a HyperV instance triggers its VSS writers on a partition containing a virtual DC’s VHD, the guest in turn triggers its own VSS writers (the same mechanism used by backup/restore above) resulting in another means by which the invocationID is reset)

Consequently, **invocationID** effectively relates a set of originating updates on a domain controller with a specific version of the directory database. The up-to-dateness vector and the high water mark tables use the **invocationID** and DC GUID respectively so that domain controllers know from which copy of the Active Directory database the replication information is coming.

The **invocationID** is a globally unique identifier (GUID) value that is visible near the top of the output after you run the command **repadmin /showrepl**. The following text represents example output from the command:

   ```
   Repadmin: running command /showrepl against full DC local host
   Default-First-Site-Name\VDC1
   DSA Options: IS_GC
   DSA object GUID: 966651f3-a544-461f-9f2c-c30c91d17818
   DSA invocationID: b0d9208b-8eb6-4205-863d-d50801b325a9
   ```

When AD DS is properly restored on a domain controller, the **invocationID** is reset. As a result of this change, you will experience an increase in replication traffic – the duration of which is relative to the size of the partition being replicated

For example, assume that VDC1 and DC2 are two domain controllers in the same domain. The following figure shows the perception of DC2 about VDC1 when the invocationID value is reset in a proper restore situation.

![](media/virtualized-domain-controller-architecture/Dd363553.ca71fc12-b484-47fb-991c-5a0b7f516366(WS.10).gif)

## USN rollback

USN rollback occurs when the normal updates of the USNs are circumvented and a domain controller tries to use a USN that is lower than its latest update. USN rollback will be detected and replication will be stopped before divergence in the forest is created, in most cases. 

USN rollback can be caused in many ways, for example, when old virtual hard disk (VHD) files are used or physical-to-virtual conversion (P2V conversion) is performed without ensuring that the physical machine stays offline permanently after the conversion. Take the following precautions to ensure that USN rollback does not occur:

   - When not running Windows Server 2012 or newer, do not take or use a snapshot of a domain controller virtual machine.
   - Do not copy the domain controller VHD file.  
   - When not running Windows Server 2012 or newer, do not export the virtual machine that is running a domain controller.  
   - Do not restore a domain controller or attempt to roll back the contents of an Active Directory database by any other means than a supported backup solution, such as Windows Server Backup.  

In some cases, USN rollback may go undetected. In other cases, it may cause other replication errors. In these cases, it is necessary to identify the extent of the problem and take care of it in a timely manner. For information about how to remove lingering objects that may occur as a result of USN rollback, see [Outdated Active Directory objects generate event ID 1988 in Windows Server 2003](https://go.microsoft.com/fwlink/?linkid=137185) in the Microsoft Knowledge Base.

## USN rollback detection

In most cases, USN rollbacks without a corresponding reset of the **invocationID** caused by improper restore procedures are detected. Windows Server 2008 provides protections against inappropriate replication after an improper domain controller restore operation. These protections are triggered by the fact that an improper restore operation results in lower USNs that represent originating changes that the replication partners have already received.

In Windows Server 2008 and Windows Server 2003 SP1, when a destination domain controller requests changes by using a previously used USN, the response by its source replication partner is interpreted by the destination domain controller to mean that its replication metadata is outdated. This indicates that the Active Directory database on the source domain controller has been rolled back to a previous state. For example, the VHD file of a virtual machine has been rolled back to a previous version. In this case, the destination domain controller initiates the following quarantine measures on the domain controller that has been identified as having undergone an improper restore:

   - AD DS pauses the Net Logon service, which prevents user accounts and computer accounts from changing account passwords. This action prevents the loss of such changes if they occur after an improper restore.  
   - AD DS disables inbound and outbound Active Directory replication.  
   - AD DS generates Event ID 2095 in the Directory Service event log to indicate the condition.  

The following illustration shows the sequence of events that occurs when USN rollback is detected on VDC2, the destination domain controller that is running on a virtual machine. In this illustration, the detection of USN rollback occurs on VDC2 when a replication partner detects that VDC2 has sent an up-to-dateness USN value that was seen previously by the destination domain controller, which indicates that VDC2’s database has rolled back in time improperly.

![](media/virtualized-domain-controller-architecture/Dd363553.373b0504-43fc-40d0-9908-13fdeb7b3f14(WS.10).gif)

If the Directory Service event log reports Event ID 2095, complete the following procedure immediately.

## To resolve Event ID 2095

1. Isolate the virtual machine that recorded the error from the network.
2. Attempt to determine whether any changes originated from this domain controller and propagated to other domain controllers. If the event was a result of a snapshot or copy of a virtual machine being started, try to determine the time the USN rollback occurred. You can then check the replication partners of that domain controller to determine whether replication occurred since then.

   You can use the Repadmin tool to make this determination. For information about how to use Repadmin, see [Monitoring and Troubleshooting Active Directory Replication Using Repadmin](https://go.microsoft.com/fwlink/?linkid=122830). If you are not able to determine this yourself, contact [Microsoft Support](https://support.microsoft.com) for assistance.

3. Forcefully demote the domain controller. This involves cleaning up the domain controller’s metadata and seizing the operations master (also known as flexible single master operations or FSMO) roles. For more information, see the “Recovering from USN rollback” section of [How to detect and recover from a USN rollback in Windows Server 2003, Windows Server 2008, and Windows Server 2008 R2](https://go.microsoft.com/fwlink/?linkid=137182) in the Microsoft Knowledge Base.
4. Delete all former VHD files for the domain controller.

## Undetected USN rollback

USN rollback might not be detected in one of two circumstances:

1. The VHD file is attached to different virtual machines that are running in multiple locations simultaneously.  
2. The USN on the restored domain controller has increased past the last USN that the other domain controller has received.  

In the first circumstance, other domain controllers might replicate with either one of the virtual machines, and changes might occur on either virtual machine without being replicated to the other. This divergence of the forest is difficult to detect, and it will cause unpredictable directory responses. This situation might occur after a P2V migration if both the physical and virtual machine are run on the same network. This could also happen if multiple virtual domain controllers are created from the same physical domain controller and then run on the same network.

In the second circumstance, a range of USNs applies to two different sets of changes. This can continue for extended periods without being detected. Whenever an object that is created during that time is modified, a lingering object is detected and reported as Event ID 1988 in Event Viewer. The following illustration shows how USN rollback might not be detected in such a circumstance.

![](media/virtualized-domain-controller-architecture/Dd363553.63565fe0-d970-4b4e-b5f3-9c76bc77e2d4(WS.10).gif)

## Read-only domain controllers

RODCs are domain controllers that host read-only copies of the partitions in an Active Directory database. RODCs avoid most USN rollback issues because they do not replicate any changes to the other domain controllers. However, if an RODC replicates from a writeable domain controller that has been affected by USN rollback, the RODC is affected as well.

Restoring an RODC using a snapshot is not recommended. Restore an RODC using an Active Directory–compatible backup application. Also, as with writeable domain controllers, care must be taken to not allow an RODC to be offline for more than tombstone lifetime. This condition can result in lingering objects on the RODC.

For more information about RODCs, see the [Read-Only Domain Controller Planning and Deployment Guide](../../deploy/rodc/read-only-domain-controller-updates.md).
