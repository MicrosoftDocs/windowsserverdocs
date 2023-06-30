---
title: Virtualizing domain controllers with Hyper-V
description: Learn about considerations for virtualizing Windows Server Active Directory domain controllers (DCs) in Hyper-V.
author: daveba
ms.author: wscontent
ms.date: 06/09/2023
ms.topic: article
ms.custom: inhenkel
---

# Virtualizing domain controllers with Hyper-V

> Applies to: Windows Server 2022, Microsoft Hyper-V Server 2019, Windows Server 2019, Microsoft Hyper-V Server 2016, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Windows Server 2012 and later support the implementation of virtualized domain controllers (DCs) with safeguards to prevent update sequence number (USN) rollback on virtual DCs and the ability to clone virtual DCs. Hyper-V consolidates different server roles onto a single physical computer. For more information, see [Safely virtualizing Active Directory Domain Services (AD DS)](../../introduction-to-active-directory-domain-services-ad-ds-virtualization-level-100.md).

This guide describes how to run DCs as 32-bit or 64-bit guest operating systems (OSs).

## Planning for virtualization

The following sections outline planning considerations for virtualizing a DC. Review the hardware requirements and learn how to avoid single points of failure. Explore how to select the appropriate DC and VM configuration, and consider security and performance decisions.

### Hyper-V requirements

To install and use the Hyper-V role, you must have the following configuration:

- **An x64 processor**. Hyper-V is available in x64-based versions of Windows Server 2008 and later.

- **Hardware-assisted virtualization**. This feature is available in processors that include a virtualization option, specifically, Intel Virtualization Technology (Intel VT) or AMD Virtualization (AMD-V).

- **Hardware Data Execution Protection (DEP)**. Hardware DEP must be available and enabled. Specifically, you must enable Intel XD bit (execute disable bit) or AMD NX bit (no execute bit).

### Practices to avoid single point of failure

As you plan your virtual DC deployment, prepare a strategy to avoid creating single points of failure. You can avoid introducing potential single points of failure by implementing system redundancy. 

Consider the following recommendations and also keep in mind the potential for increases in the cost of administration:

- Run at least two virtualized DCs per domain on different virtualization hosts. This configuration reduces the risk of losing all DCs if a single virtualization host fails.

- As recommended for other technologies, diversify the hardware that runs the DCs, such as using different CPUs, motherboards, network adapters, or other hardware. Hardware diversification limits damage caused by a malfunction due to vendor configuration, driver, or hardware.

- As possible, run DCs on hardware located in different regions of the world. This approach helps to reduce the consequences of a disaster or failure that affects a site at which the DCs are hosted.

- Maintain physical DCs in each of your domains. This configuration mitigates the risk of a virtualization platform malfunction that affects all host systems that use the platform.

### Security considerations

The host computer where virtual DCs run must be managed as carefully as a writeable DC, even if the computer is only a domain-joined or workgroup computer. This consideration is critical for security. A mismanaged host is vulnerable to an elevation-of-privilege attack. This type of attack occurs when a malicious user gains access and system privileges that are unauthorized or illegitimately assigned. A malicious user can use this type of attack to compromise all the VMs, domains, and forests hosted by the computer.

Keep the following security considerations in mind when you're planning to virtualize DCs:

- The local administrator of a computer that hosts virtual writeable DCs should be considered equivalent in credentials to the default domain administrator of all the domains and forests to which the DCs belong.

- The recommended configuration to avoid security and performance issues is a host running a Server Core installation of Windows Server 2008 or later, with no applications other than Hyper-V. This configuration limits the number of applications and services that are installed on the server. The limitation should result in increased performance and fewer applications and services that can be maliciously exploited to attack the computer or network. The effect of this type of configuration is known as a _reduced attack surface_. 

- In a branch office or other locations that can't be satisfactorily secured, a read-only DC (RODC) is recommended. If a separate management network exists, we recommend the host is connected to the management network only.

- You can use BitLocker with your DCs. In Windows Server 2016 and later, you can use the virtual TPM feature to also give the guest key material to unlock the system volume.

- [Guarded fabric and shielded VMs](/windows-server/security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms-top-node) can provide other controls to protect your DCs.

For information about RODCs, see [Install a Windows Server 2012 Active Directory Read-Only Domain Controller (RODC) (Level 200)](/windows-server/identity/ad-ds/deploy/rodc/install-a-windows-server-2012-active-directory-read-only-domain-controller--rodc---level-200-).

For more information about securing DCs, see the [Best practice guide for securing Active Directory installations](../../plan/security-best-practices/best-practices-for-securing-active-directory.md).

### Security boundaries for host and guest configurations

You can have many different configurations of DCs when you implement VMs. Careful consideration must be given to the way VMs affect boundaries and trusts in your Active Directory topology. Possible configurations for an Active Directory DC and host (Hyper-V server) and its guest computers (VMs running on the Hyper-V server) are described in the following table.

| Machine | Configuration 1 | Configuration 2 |
|---|---|---|
| **Host** | Workgroup or member computer | Workgroup or member computer |
| **Guest** | Domain controller | Workgroup or member computer |

The following diagram demonstrates security boundaries a possible configuration of three guest DC VMs hosted on a Hyper-V server:

:::image type="content" source="media/virtualized-domain-controller-architecture/Dd363553.f44706fd-317e-4f0b-9578-4243f4db225f(WS.10).gif" alt-text="Diagram that shows security boundaries in a configuration of three guest DC VMs hosted on a Hyper-V server." border="false":::

Consider the configuration in the previous diagram, and review the following points when planning for security boundaries:

- **Administrator access**. The administrator on the host computer has the same access as a domain administrator on the writable DC guests and must be treated as such. For an RODC guest, the administrator of the host computer has the same access as a local administrator on the guest RODC. 

- **DC administrative rights on host**. A DC in a VM has administrative rights on the host if the host is joined to the same domain. There's an opportunity for a malicious user to compromise all VMs if the malicious user first gains access to VM 1. This scenario is known as an attack vector. If there are DCs for multiple domains or forests, these domains should have centralized administration in which the administrator of one domain is trusted on all domains.

- **Strategy to avoid attacks**. The opportunity for attack from VM 1 exists even if VM 1 is installed as an RODC. Although an administrator of an RODC doesn't explicitly have domain administrator rights, the RODC can be used to send policies to the host computer. These policies might include startup scripts. If this operation is successful, the host computer can be compromised, and it can then be used to compromise the other VMs on the host computer.

Review these extra security considerations:

- **Security of VHD files**. A VHD file of a virtual DC is equivalent to the physical hard drive of a physical DC. As such, it should be protected with the same amount of care that goes into securing the hard drive of a physical DC. Make sure that only reliable and trusted administrators are allowed access to the VHD files for the DCs.

- **RODCs**. One benefit of RODCs is the ability to place them at locations where physical security can't be guaranteed, such as at branch offices. You can use Windows BitLocker Drive Encryption to protect VHD files themselves (not the file systems therein) from being compromised on the host through theft of the physical disk.

### Performance considerations

With the new microkernel 64-bit architecture, there are significant increases in Hyper-V performance from previous virtualization platforms. For best host performance, the host should be a Server Core installation of Windows Server 2008 or later, and it shouldn't have server roles other than Hyper-V installed.

Performance of VMs depends specifically on the workload. To guarantee satisfactory Active Directory performance, test specific topologies. Assess the current workload over a period of time with a tool such as the Reliability and Performance Monitor (Perfmon.msc) or the [Microsoft Assessment and Planning (MAP) toolkit](https://www.microsoft.com/download/details.aspx?id=7826). The MAP tool can also be valuable if you want to take an inventory of all of the servers and server roles that currently exist in your network.

To get a general idea of the performance of virtualized DCs, the following performance tests were carried out with the [Active Directory Performance Testing Tool (ADTest.exe)](https://go.microsoft.com/fwlink/?linkid=137088).

Lightweight Directory Access Protocol (LDAP) tests were run on a physical DC with ADTest.exe and then on a VM hosted on a server identical to the physical DC. Only one logical processor was used for the physical computer, and only one virtual processor was used for the VM to easily reach 100-percent CPU utilization. In the following table, the letter and number in parenthesis after each test indicate the specific test in ADTest.exe. As this data shows, virtualized DC performance was 88 to 98 percent of the physical DC performance.

| Measurement  | Test                                              | Physical | Virtual | Delta |
|--------------|---------------------------------------------------|----------|---------|-------|
| Searches/sec | Search for common name in base scope (L1)         | 11508 | 10276 | -10.71% |
| Searches/sec | Search for a set of attributes in base scope (L2) | 10123 | 9005 | -11.04%  |
| Searches/sec | Search for all attributes in base scope (L3)      | 1284  | 1242 | -3.27% |
| Searches/sec | Search for common name in subtree scope (L6)      | 8613 | 7904 | -8.23% |
| Successful binds/sec | Perform fast binds (B1) | 1438 | 1374 | -4.45% |
| Successful binds/sec | Perform simple binds (B2) | 611 | 550 | -9.98% |
| Successful binds/sec | Use NTLM to perform binds (B5) | 1068 | 1056 | -1.12% |
| Writes/sec | Write multiple attributes (W2) | 6467 | 5885 | -9.00% |

To ensure satisfactory performance, integration components (IC) were installed to allow the guest OS to use hypervisor-aware synthetic drivers. During the installation process, it can be necessary to use emulated Integrated Drive Electronics (IDE) or network adapter drivers. In production environments, you should replace these emulated drivers with synthetic drivers to increase performance.

Review the following performance recommendations:

- When you monitor performance of VMs with Reliability and Performance Manager (Perfmon.msc), the CPU information within the VM isn't entirely accurate as a result of the way the virtual CPU is scheduled on the physical processor. To obtain CPU information for a VM running on a Hyper-V server, use the Hyper-V Hypervisor Logical Processor counters in the host partition. For more information about performance tuning of both AD DS and Hyper-V, see [Performance tuning guidelines for Windows Server](../../../../administration/performance-tuning/index.md).

- Don't plan to use a differencing disk VHD on a VM that's configured as a DC because the differencing disk VHD can reduce performance. To learn more about Hyper-V disk types, including differencing disks, see [New virtual hard disk wizard](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771866(v=ws.11)).

- For more information regarding AD DS in virtual hosting environments, see [Things to consider when you host Active Directory DCs in virtual hosting environments](/troubleshoot/windows-server/identity/ad-dc-in-virtual-hosting-environment) in the Microsoft Knowledge Base.

## Deployment considerations

The following sections describe common VM practices to avoid when deploying DCs, and special considerations for time synchronization and storage.

### Deployment practices to avoid

Virtualization platforms, such as Hyper-V, offer many convenience features that make managing, maintaining, backing up, and migrating computers easier. However, the following common deployment practices and features should be avoided for virtual DCs:

- **Don't deploy virtual DC database files on virtual IDE disks**. To ensure durability of Active Directory writes, don't deploy a virtual DC's database files (the Active Directory database **NTDS.DIT**, logs, and SYSVOL) on virtual IDE disks. Instead, create a second VHD attached to a virtual SCSI controller and ensure the database, logs, and SYSVOL are placed on the VM's SCSI disk during DC installation.

- **Don't implement differencing disk VHDs on a DC VM**. Don't implement differencing disk virtual hard disks (VHDs) on a VM that you're configuring as a DC. This approach makes it too easy to revert to a previous version, and it also decreases performance. For more information about VHD types, see [New virtual hard disk wizard](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771866(v=ws.11)).

- **Don't deploy Active Directory domains and forests that aren't prepared with Sysprep**. Don't deploy new Active Directory domains and forests on a copy of a Windows Server OS without first preparing them by using System Preparation tool (Sysprep). For more information about running the Sysprep, see [Sysprep (System Preparation) Overview](/windows-hardware/manufacture/desktop/sysprep--system-preparation--overview).

   > [!WARNING]
   > Running Sysprep on an already promoted DC isn't supported.

- **Don't use copies of a VHD file for an already deployed DC to deploy other DCs**. To help prevent a potential update sequence number (USN) rollback situation, don't use copies of a VHD file that represents an already deployed DC to deploy more DCs. For more information about USN rollback, see the [USN and USN rollback](#usn-and-usn-rollback) section.

   In Windows Server 2012 and later, administrators can clone DC images to deploy more DCs, when the images are properly prepared.

- **Don't use the Hyper-V Export feature to export a VM running a DC**.

   In Windows Server 2012 and later, an export and import of a DC virtual guest is handled like a nonauthoritative restore. The process detects a change of the Generation ID and it isn't configured for cloning.

   Ensure the exported guest is no longer used. You can use Hyper-V Replication to keep a second inactive copy of a DC. If you start the replicated image, you also need to perform proper cleanup for the same reason as not using the source after exporting a DC guest image.

### Physical-to-virtual migration

System Center VM Manager (VMM) 2008 provides unified management of physical machines and VMs and the ability to migrate a physical machine to a VM. This process is known as physical-to-VM conversion (P2V conversion). During the P2V conversion process, the new VM and the physical DC that's being migrated must not run at the same time. Ensuring the VM and DC don't run at the same time helps to avoid a USN rollback situation as described in the [USN and USN rollback](#usn-and-usn-rollback) section.

You should perform P2V conversion by using offline mode to ensure the directory data is consistent when the DC is turned back on. The offline mode option is offered and recommended in the Convert Physical Server Wizard. For a description of the difference between online mode and offline mode, see [P2V: Convert physical computers to VMs in VMM](/previous-versions/system-center/virtual-machine-manager-2008-r2/cc764232(v=technet.10)). During P2V conversion, the VM shouldn't be connected to the network. The network adapter of the VM should be enabled only after the P2V conversion process is complete and verified. At this point, the physical source machine should be off. Don't bring the physical source machine back onto the network again before you reformat the hard disk.

#### Practices to avoid risk of USN rollback

There are safer options to create virtual DCs that don't run the risks of creating a USN rollback. You can set up a new virtual DC by regular promotion, promotion from Install from Media (IfM), and also by using Domain Controller cloning, if you already have at least one virtual DC. This approach also helps to avoid problems with hardware or platform-related problems P2V-converted virtual guests might encounter.

> [!WARNING]
> To prevent issues with Active Directory replication, ensure that only one instance (physical or virtual) of a given DC exists on a given network at any point in time. You can lower the likelihood of the old clone being a problem by using one of the following methods:
>
> - When the new virtual DC is running, change the computer account password twice by using the following command:
>    `netdom resetpwd /Server:\<domain-controller\> ...`
>
> - Export and import the new virtual guest to force it to become a new Generation ID and a database invocation ID.

### Test environments and P2V migration

You can use P2V migration through the VMM to create test environments. You can migrate production DCs from physical machines to VMs to create a test environment without permanently bringing down the production DCs. However, the test environment must be on a different network from the production environment to enable two instances of the same DC to exist. Great care must be taken in the creation of test environments with P2V migration to avoid USN rollbacks that can affect your test and production environments.

#### Practices to create a test environment

You can use the following approach to create test environments with P2V.

- Migrate one in-production DC from each domain to a test VM by using P2V according to the guidelines stated in the [Physical-to-virtual migration](#physical-to-virtual-migration) section.

- Be sure to locate the physical production machines and test VMs in different networks when they're brought back online.

- To avoid USN rollbacks in the test environment, take all DCs to be migrated from physical machines to VMs offline. You can take the DCs offline by stopping the ntds service or by restarting the computer in Directory Services Restore Mode (DSRM).

- After the DCs are offline, no new updates should be introduced to the environment.

- All of the computers must remain offline during the P2V migration. No computers should be brought back online until all computers are fully migrated.

- Subsequent test DCs should be promoted as replicas in the test environment.

To learn more about USN rollback, see the [USN and USN rollback](#usn-and-usn-rollback) section.

### Time service and synchronization

For VMs that are configured as DCs, it's recommended that you disable time synchronization between the host system and guest OS that's acting as a DC. This practice enables your guest DC to synchronize time from the domain hierarchy.

To disable the Hyper-V time synchronization provider, shut down the VM and clear the **Time synchronization** check box under **Integration Services**.

> [!NOTE]
> The time service guidance has been recently updated to reflect the current recommendation: synchronize time for the guest DC from only the domain hierarchy. The previous recommendation was to partially disable time synchronization between the host system and guest DC.

### Storage and optimization

To optimize the performance of the DC VM and ensure durability of Active Directory writes, follow these recommended practices for storing OSs, Active Directory, and VHD files:

- **Guest storage**. Store the Active Directory database file (Ntds.dit), log files, and SYSVOL files on a separate virtual disk from the OS files. Create a second VHD attached to a virtual SCSI controller and store the database, logs, and SYSVOL on the VM's virtual SCSI disk. Virtual SCSI disks provide increased performance compared to virtual IDE and they support Forced Unit Access (FUA). FUA ensures that the OS writes and reads data directly from the media bypassing all caching mechanisms.

   > [!NOTE]
   > To use BitLocker for the virtual DC guest, make sure the extra volumes are configured for "auto unlock." For more information about configuring auto unlock, see the PowerShell reference topic for the [Enable-BitLockerAutoUnlock](/powershell/module/bitlocker/enable-bitlockerautounlock) cmdlet.

- **Host storage of VHD files**. Host storage recommendations address storage of VHD files. For maximum performance, don't store VHD files on a disk frequently used by other services or applications, such as the system disk where the host Windows OS is installed. Store each VHD file on a separate partition from the host OS and any other VHD files. The ideal configuration is to store each VHD file on a separate physical drive.

   The host physical disk system must also satisfy **at least one** of the following criteria to meet the requirements of virtualized workload data integrity:

   - The system uses server-class disks (SCSI, Fibre Channel).

   - The system ensures the disks are connected to a battery-backed caching host bus adapter (HBA).

   - The system uses a storage controller like a RAID system as the storage device.

   - The system ensures power to the disk is protected by an uninterruptible power supply (UPS).

   - The system ensures the disk's write-caching feature is disabled.

- **Fixed VHD versus pass-through disks**. There are many ways to configure storage for VMs. When VHD files are used, fixed-size VHDs are more efficient than dynamic VHDs because the memory for fixed-size VHDs is allocated when they're created. Pass-through disks, which VMs can use to access physical storage media, are even more optimized for performance. Pass-through disks are physical disks or logical unit numbers (LUNs) that are attached to a VM. Pass-through disks don't support the snapshot feature. Therefore, pass-through disks are the preferred hard disk configuration because the use of snapshots with DCs isn't recommended.

- **Use virtual SCSI controllers**. To reduce the chance of corruption of Active Directory data, use virtual SCSI controllers:

   - Use SCSI physical drives (as opposed to IDE/ATA drives) on Hyper-V servers that host virtual DCs. If you can't use SCSI drives, ensure write caching is disabled on the ATA/IDE drives that host virtual DCs. For more information, see [Event ID 1539 – Database Integrity](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd941847(v=ws.10)).

   - To guarantee the durability of Active Directory writes, the Active Directory database, logs, and SYSVOL must be placed on a virtual SCSI disk. Virtual SCSI disks support Forced Unit Access (FUA). FUA ensures that the OS writes and reads data directly from the media bypassing all caching mechanisms.

### Operational practices to avoid

Domain controllers running on VMs have operational restrictions that don't apply to DCs running on physical machines. When you use a virtualized DC, avoid the following virtualization software features and practices:

- **Don't pause, stop, or store the saved state longer than the tombstone lifetime**. Don't pause, stop, or store the saved state of a DC in a VM longer than the forest's tombstone lifetime, and resume from the paused or saved state. These types of operations can interfere with replication. To learn how to determine the tombstone lifetime for the forest, see [Determine the tombstone lifetime for the forest](/previous-versions/windows/it-pro/windows-server-2003/cc784932(v=ws.10)).

- **Don't copy or clone virtual hard disks (VHDs)**. Even with the safeguards in place for the guest VM, individual VHDs can still be copied and cause USN roll-back.

- **Don't take or use a snapshot of a virtual DC**. This practice is technically supported in Windows Server 2012 and later, but it isn't a replacement for a good backup strategy. There are few reasons for taking DC snapshots or restoring the snapshots.

- **Don't use a differencing disk VHD on a VM configured as a DC**. This practice makes reverting to a previous version too easy, and also decreases performance.

- **Don't use the Export feature on a VM running a DC**.

- **Don't restore or roll back by any means other than a supported backup**. Don't restore a DC or attempt to roll back the contents of an Active Directory database by any means other than a supported backup.

These recommendations can help you avoid the possibility of an update sequence number (USN) rollback. For more information about USN rollback, see the [USN and USN rollback](#usn-and-usn-rollback) section.

## Back up and restore considerations

Backing up DCs is a critical requirement for any environment. Backups protect against data loss for DC failures or administrative errors. If such an event occurs, it's necessary to roll back the system state of the DC to a point in time before the failure or error. The supported method of restoring a DC to a healthy state is to use a backup application to restore a system state backup that originated from the current installation of the DC. The back application should be compatible with Active Directory, such as Windows Server Backup. For more information about Windows Server Backup and Active Directory Domain Services (AD DS), see the [AD DS backup and recovery step-by-step guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771290(v=ws.10)).

With VM technology, certain requirements of Active Directory restore operations take on added significance. If you restore a DC by using a copy of the VHD file, you bypass the critical step of updating the database version of a DC after it's restored. Replication proceeds with inaccurate tracking numbers that cause an inconsistent database among DC replicas. In most cases, this problem is undetected by the replication system and no errors are reported, despite inconsistencies between DCs.

### Windows Server Backup and guest OS

There's one supported way to perform backup and restore of a virtualized DC and that's to run Windows Server Backup in the guest OS.

In Hyper-V hosts and guests in Windows Server 2012 and later, you can take supported backups of DCs by using snapshots, guest VM export and import, and also Hyper-V Replication. However, none of these approaches are a good fit for creating a proper backup history with the slight exception of guest VM export.

Windows Server 2016 Hyper-V and later support "production snapshots." The Hyper-V server triggers a VSS-based backup of the guest. When the guest is done with the snapshot, the host fetches the VHDs and stores them in the backup location. This approach works in Windows Server 2012 and later, but there's an incompatibility with BitLocker:

- When doing a VSS snapshot, Active Directory wants to perform a post-snapshot task. The task can mark the database as coming from a backup, or when preparing an IFM source for RODC, remove credentials from the database.

- When Hyper-V mounts the snapshot volume for this task, no facility unlocks the Volume for unencrypted access. The Active Directory database engine fails in the attempt to access the database and eventually fails the snapshot.

> [!NOTE]
> The shielded VM project mentioned earlier has a Hyper-V host driven backup as a non-goal for maximum data protection of the guest VM.

### Back up and restore practices to avoid

As mentioned, DCs running in VMs have restrictions that don't apply to DCs running in physical machines. When you back up or restore a virtual DC, avoid the following virtualization software features and practices:

- **Don't copy or clone VHD files of DCs instead of performing regular backups**. If the VHD file is copied or cloned, the file becomes stale. If the VHD is started in normal mode, a USN rollback occurs. You should perform proper backup operations supported by AD DS, such as working with the Windows Server Backup feature.

- **Don't use the Snapshot feature as a backup to restore a VM configured as a DC**. Problems can occur with replication when you revert the VM to an earlier state with Windows Server 2008 R2 and later. For more information, see the [USN and USN rollback](#usn-and-usn-rollback) section. You can use a snapshot to restore a read-only DC (RODC) and not encounter replication issues, but this restore method isn't recommended.

### Restoration of virtual DC

To restore a DC when it fails, you must regularly back up system state. System state includes Active Directory data and log files, the registry, the system volume (SYSVOL folder), and various elements of the OS. This requirement is the same for physical and virtual DCs. System state restoration procedures performed by Active Directory–compatible backup applications are designed to ensure the consistency of local and replicated Active Directory databases after a restore process, including the notification to replication partners of invocation ID resets. Virtual hosting environments and disk or OS imaging applications allow administrators to bypass the standard checks and validations that occur during DC system state restore.

When a DC VM fails and a USN rollback hasn't occurred, there are two supported situations for restoring the VM:

- If there's a valid system state data backup that predates the failure, you can restore system state with the restore option of the backup utility used to create the backup. To do so, the system state data backup must be created with an Active Directory–compatible backup utility within the span of the tombstone lifetime. The default tombstone lifetime is no more than 180 days. You should back up your DCs at least every half tombstone lifetime. For instructions about how to determine the specific tombstone lifetime for your forest, see [Determine the tombstone lifetime for the forest](/previous-versions/windows/it-pro/windows-server-2003/cc784932(v=ws.10)).

- If a working copy of the VHD file is available, but no system state backup is available, you can remove the existing VM. Restore the existing VM by using a previous copy of the VHD. Be sure to start the VM in DSRM and configure the registry properly as described in the following section. Then, restart the DC in normal mode.

Use the process in the following diagram to determine the best way to restore your virtualized DC.

:::image type="content" source="media/virtualized-domain-controller-architecture/Dd363553.85c97481-7b95-4705-92a7-006e48bc29d0(WS.10).gif" alt-text="Diagram that shows how to restore a virtualized DC." border="false":::

The restoration process and decisions are simpler for RODCs, as shown in the next diagram.

:::image type="content" source="media/virtualized-domain-controller-architecture/Dd363553.4c5c5eda-df95-4c6b-84e0-d84661434e5d(WS.10).gif" alt-text="Diagram that shows how to restore a read-only DC (RODC)." border="false":::

### Restoration of system state backup

If a valid system state backup exists for the DC VM, you can safely restore the backup by following the restore procedure prescribed by the backup tool that you used to back up the VHD file.

> [!IMPORTANT]
> To properly restore the DC, you must start the DC in DSRM. You must not allow the DC to start in normal mode. If you miss the opportunity to enter DSRM during system startup, turn off the DC's VM before it can fully start in normal mode. It's important to start the DC in DSRM because starting a DC in normal mode increments the USNs, even if the DC is disconnected from the network. For more information about USN rollback, see the [USN and USN rollback](#usn-and-usn-rollback) section.

#### Restore the system state backup of virtual DC

Follow these steps to restore the system state data backup of a virtual DC:

1. Start the DC's VM, and press F5 to access **Windows Boot Manager**.

   If you're prompted to enter connection credentials, follow these steps:

   1. Immediately select the **Pause** button on the VM to pause the process.
   1. Enter your connection credentials.
   1. Select the **Play** button on the VM.
   1. Select inside the VM window, and press F5.
   
   If **Windows Boot Manager** doesn't open, and the DC begins to start in normal mode, turn off the VM to pause the process. Repeat this step as many times as necessary until you're able to access Windows Boot Manager. You can't access DSRM from the Windows Error Recovery menu. Therefore, turn off the VM and try again if the Windows Error Recovery menu appears.

1. In **Windows Boot Manager**, press F8 to access advanced boot options.

1. Under **Advanced Boot Options**, select **Directory Services Restore Mode**, and then press ENTER to start the DC in DSRM.

1. Use the appropriate restore method for the tool that you used to create the system state backup. If you used Windows Server Backup, see [Performing a nonauthoritative restore of AD DS](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc730683(v=ws.10)).

### Restoration of virtual DC without system state backup

If you don't have a system state data backup that predates the VM failure, you can use a previous VHD file to restore a DC that's running on a VM. As possible, make a copy of the VHD. If you encounter an issue during the procedure or miss a step, you can try again with the copied VHD.

#### Restore previous version of virtual DC VHD without system state backup

You can use the following steps to restore to a previous version of a virtual DC VHD without a system state data backup.

> [!WARNING]
> The following procedure shouldn't be used as a substitute for regularly planned and scheduled backups. Restores performed with this procedure aren't supported by Microsoft. Use this procedure only when there's no alternative.
>
> Don't use this procedure if the copy of the VHD to restore has been started in normal mode by any VM.

1. Using the previous VHD, start the virtual DC in DSRM, as described in the previous section. Don't allow the DC to start in normal mode. If you miss the **Windows Boot Manager** screen and the DC begins to start in normal mode, turn off the VM to prevent it from completing startup. See the previous section for detailed instructions for entering DSRM.

1. Open **Registry Editor**. You can open the editor by selecting **Start** > **Run**, then enter **regedit**, and select **OK**.
    
   1. If the **User Account Control** dialog displays, confirm the displayed action is as expected, and select **Yes**.

   1. In Registry Editor, expand the path **HKLM\SYSTEM\CurrentControlSet\Services\NTDS\Parameters**.
   
   1. Look for a value named **DSA Previous Restore Count**. If the value is present, make a note of the setting. Otherwise, the setting value is the default (0). If no value is shown, don't manually set the value.

1. Right-click the **Parameters** key, select **New**, and then select **DWORD (32-bit) Value**.

1. Enter the new name **Database restored from backup**, and then press ENTER.

1. Double-click the value you just created to open the **Edit DWORD (32-bit) Value** dialog, and enter **1** in the **Value data** box.

   The **Database restored from backup entry** option is available on the following DCs running Windows Server:

   - Windows 2000 Server with Service Pack 4 (SP4)
   - Windows Server 2003 with specified updates installed (For details, see [A Windows Server domain controller logs Directory Services event 2095 when it encounters a USN rollback](/troubleshoot/windows-server/identity/detect-and-recover-from-usn-rollback) in the Microsoft Knowledge Base.)
   - Windows Server 2008

1. Restart the DC in normal mode.

1. When the DC restarts, open **Event Viewer**. To open Event Viewer, select **Start** > **Control Panel**. Double-click **Administrative Tools**, and then double-click **Event Viewer**.

1. Expand **Application and Services Logs**, and then select the **Directory Services** log. Ensure the events appear in the details pane.

1. Right-click the **Directory Services** log, and then select **Find**. In **Find what**, enter **1109**, and then select **Find Next**.

1. You should see at least one entry for Event ID 1109. If you don't see this entry, proceed to the next step. Otherwise, double-click the entry, and review the text. Confirm the text shows that the update was made to the InvocationID:

    ```output
    Active Directory has been restored from backup media, or has been configured to host an application partition.
    The invocationID attribute for this directory server has been changed.
    The highest update sequence number at the time the backup was created is <time>

    InvocationID attribute (old value):<Previous InvocationID value>
    InvocationID attribute (new value):<New InvocationID value>
    Update sequence number:<USN>

    The InvocationID is changed when a directory server is restored from backup media or is configured to host a writeable application directory partition.
    ```

1. Close **Event Viewer**.

1. Use **Registry Editor** to verify the value for the **DSA Previous Restore Count** setting is equal to the previous value plus one. If the correct value isn't shown, and you can't find an entry for Event ID 1109 in **Event Viewer**, verify that the DC's service packs are current.

   > [!NOTE]
   > You can't try this procedure again on the same VHD. You can try again on a copy of the VHD or a different VHD that hasn't been started in normal mode by starting again from step 1.

1. Close **Registry Editor**.


## USN and USN rollback

This section describes replication issues that can occur as a result of an incorrect restoration of the Active Directory database with an older version of a VM. For more information about the Active Directory replication process, see [Active Directory replication concepts](../replication/active-directory-replication-concepts.md).

### How AD DS and DCs use USNs

AD DS uses USNs to keep track of replication of data between DCs. Each time a change is made to data in the directory, the USN is incremented to indicate a new change.

For each directory partition stored by a destination DC, USNs are used to track the latest originating update that a DC introduced to its database. The USN also tracks the status of every other DC that stores a replica of the directory partition. When DCs replicate changes to one another, they query their replication partners for changes with USNs that are greater than the USN of the last change that the DC received from each partner.

Two replication metadata tables contain USNs: up-to-dateness vector and high water mark. Source and destination DCs use the USNs in these tables to filter updates that the destination DC requires.

The **up-to-dateness vector** table is maintained by the destination DC to track originating updates received from all source DCs. When a destination DC requests changes for a directory partition, it provides its up-to-dateness vector to the source DC. The source DC then uses this value to filter the updates that it sends to the destination DC. The source DC sends its up-to-dateness vector to the destination at the completion of a successful replication cycle. The USN is used to ensure the destination DC knows that it has synchronized with every DC's originating updates and the updates are at the same level as the source.

The **high water mark** table is maintained by the destination DC to track the most recent changes received from a specific source DC for a specific partition. The high water mark prevents the source DC from sending out changes that the destination DC has already received from it.

### Directory database identity

In addition to USNs, DCs keep track of the directory database of source replication partners. The identity of the directory database running on the server is maintained separately from the identity of the server object itself. The directory database identity on each DC is stored in the `invocationID` attribute of the `NTDS Settings` object, which is located under the Lightweight Directory Access Protocol (LDAP) path `cn=NTDS Settings, cn=ServerName, cn=Servers, cn=*SiteName*, cn=Sites, cn=Configuration, dc=*ForestRootDomain*`. 

The server object identity is stored in the `objectGUID` attribute of the `NTDS Settings` object. The identity of the server object never changes. However, the identity of the directory database changes under certain circumstances:

- When a system state restore procedure occurs on the server

- When an application directory partition is added, then removed, and later readded from the server

- When a Hyper-V instance triggers its VSS writers on a partition containing a virtual DC's VHD

   In this scenario, the guest triggers its own VSS writers. This action is the same mechanism used by the backup/restore process mentioned earlier. This method results in another means by which the `invocationID` is reset.

So, the `invocationID` attribute effectively relates a set of originating updates on a DC with a specific version of the directory database. The up-to-dateness vector and the high water mark tables use the `invocationID` and DC GUID respectively so the DCs recognize the copy of the Active Directory database from where the replication information is coming.

The `invocationID` attribute is a globally unique identifier (GUID) value that's visible near the top of the output after you run the command `repadmin /showrepl`. The following text represents example output from the command:

```output
Repadmin: running command /showrepl against full DC local host
Default-First-Site-Name\VDC1
DSA Options: IS_GC
DSA object GUID: 966651f3-a544-461f-9f2c-c30c91d17818
DSA invocationID: b0d9208b-8eb6-4205-863d-d50801b325a9
```

When AD DS is properly restored on a DC, the `invocationID` attribute is reset. This change causes an increase in replication traffic, where the duration is relative to the size of the partition being replicated.

Consider a scenario where VDC1 and DC2 are two DCs in the same domain. The following diagram shows the perception of DC2 about VDC1 when the `invocationID` value is reset in a proper restore situation.

:::image type="content" source="media/virtualized-domain-controller-architecture/Dd363553.ca71fc12-b484-47fb-991c-5a0b7f516366(WS.10).gif" alt-text="Diagram that demonstrates the scenario when the invocationID value is reset properly." border="false":::


### USN rollback

USN rollback occurs when the normal updates of the USNs are circumvented and a DC tries to use a USN that's lower than its latest update. In most cases, USN rollback is detected and replication is stopped before divergence in the forest is created.

USN rollback can be caused in many ways. Some examples include when old virtual hard disk (VHD) files are used or physical-to-virtual conversion (P2V conversion) is performed without ensuring that the physical machine stays offline permanently after the conversion.

#### Practices to prevent USN rollback

Take the following precautions to ensure USN rollback doesn't occur:

- When not running Windows Server 2012 or later, don't take or use a snapshot of a DC VM.

- Don't copy the DC VHD file.

- When not running Windows Server 2012 or later, don't export the VM that's running a DC.

- Don't restore a DC or attempt to roll back the contents of an Active Directory database by any other means than a supported backup solution, such as Windows Server Backup.

Sometimes, USN rollback can go undetected, and at other time, USN rollback might cause replication errors. It can be necessary to identify the extent of the problem and address it in a timely manner. For more information about how to remove lingering objects that can occur as a result of USN rollback, see [Active Directory replication Event ID 1388 or 1988: A lingering object is detected](/troubleshoot/windows-server/identity/active-directory-replication-event-id-1388-1988) in the Microsoft Knowledge Base.

### USN rollback detection

In most cases, USN rollbacks without a corresponding reset of the `invocationID` attribute caused by improper restore procedures are detected. Windows Server 2008 provides protections against inappropriate replication after an improper DC restore operation. These protections trigger when an improper restore operation causes lower USNs that represent originating changes already received by the replication partners.

In Windows Server 2008 and Windows Server 2003 SP1, when a destination DC requests changes by using a previously used USN, the response by its source replication partner is interpreted by the destination DC to mean its replication metadata is outdated. This outcome indicates the Active Directory database on the source DC has been rolled back to a previous state. An example is when the VHD file of a VM has been rolled back to a previous version. In this case, the destination DC initiates the following quarantine measures on the DC that has been identified as having undergone an improper restore:

- AD DS pauses the Net Logon service, which prevents user accounts and computer accounts from changing account passwords. This action prevents the loss of such changes if they occur after an improper restore.

- AD DS disables inbound and outbound Active Directory replication.

- AD DS generates Event ID 2095 in the Directory Service event log to indicate the condition.

The following diagram shows the sequence of events that occur when USN rollback is detected on VDC2, the destination DC that's running on a VM. In this illustration, the detection of USN rollback occurs on VDC2 when a replication partner detects that VDC2 has sent an up-to-dateness USN value previously seen by the destination DC. This condition indicates that VDC2's database has rolled back in time improperly.

:::image type="content" source="media/virtualized-domain-controller-architecture/Dd363553.373b0504-43fc-40d0-9908-13fdeb7b3f14(WS.10).gif" alt-text="Diagram that demonstrates what happens when USN rollback is detected." border="false":::


#### Resolve Event ID 2095 issues

If the Directory Service event log reports Event ID 2095, complete the following procedure immediately:

1. Isolate the VM that recorded the error from the network.

1. Attempt to determine whether any changes originated from this DC and propagated to other DCs. If the event was a result of a snapshot or copy of a VM being started, try to determine the time the USN rollback occurred. You can then check the replication partners of that DC to determine whether replication occurred in the time since the rollback.

   You can use the Repadmin tool to make this determination. For information about how to use Repadmin, see [Monitoring and troubleshooting Active Directory replication with Repadmin](/previous-versions/windows/it-pro/windows-server-2003/cc811551(v=ws.10)). If you're unable to make a determination, contact [Microsoft Support](https://support.microsoft.com) for assistance.

1. Forcefully demote the DC. This operation involves cleaning up the DC's metadata and seizing the operations master (also known as flexible single master operations or FSMO) roles. For more information, see the "Recovering from USN rollback" section of [A Windows Server domain controller logs Directory Services event 2095 when it encounters a USN rollback](/troubleshoot/windows-server/identity/detect-and-recover-from-usn-rollback) in the Microsoft Knowledge Base.

1. Delete all former VHD files for the DC.

### Undetected USN rollback

USN rollback might not be detected in two scenarios:

- The VHD file is attached to different VMs running in multiple locations simultaneously.

- The USN on the restored DC has increased past the last USN received by the other DC.

In the first scenario, other DCs might replicate with either one of the VMs, and changes might occur on either VM without being replicated to the other. This divergence of the forest is difficult to detect, and it causes unpredictable directory responses. This situation can occur after a P2V migration if both the physical DC and VM are run on the same network. This situation can also happen if multiple virtual DCs are created from the same physical DC and then run on the same network.

In the second scenario, a range of USNs applies to two different sets of changes. This scenario can continue for extended periods without being detected. Whenever an object that's created during that time is modified, a lingering object is detected and reported as Event ID 1988 in Event Viewer. The following diagram shows how USN rollback might not be detected in such a circumstance.

:::image type="content" source="media/virtualized-domain-controller-architecture/Dd363553.63565fe0-d970-4b4e-b5f3-9c76bc77e2d4(WS.10).gif" alt-text="Diagram that demonstrates a scenario where USN rollback isn't detected." border="false":::

### Read-only DCs

RODCs are DCs that host read-only copies of the partitions in an Active Directory database. RODCs avoid most USN rollback issues because they don't replicate any changes to the other DCs. However, if an RODC replicates from a writeable DC affected by USN rollback, the RODC is also affected.

Restoring an RODC by using a snapshot isn't recommended. Restore an RODC by using an Active Directory–compatible backup application. Also, as with writeable DCs, care must be taken to not allow an RODC to be offline for more than the tombstone lifetime. This condition can result in lingering objects on the RODC.

For more information about implementing RODCs, see the [Read-Only Domain Controllers step-by-step guide](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc772234(v=ws.10)).
