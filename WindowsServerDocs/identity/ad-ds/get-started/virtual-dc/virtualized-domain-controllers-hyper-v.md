---
title: Virtualizing domain controllers with Hyper-V
description: Learn about considerations for virtualizing Windows Server Active Directory domain controllers (DCs) in Hyper-V.
author: robinharwood
ms.author: roharwoo
ms.date: 03/07/2024
ms.topic: concept-article
---

# Virtualizing domain controllers with Hyper-V

> 

Windows Server 2012 and later support virtualized domain controllers (DCs) with safeguards to prevent update sequence number (USN) rollback on virtual DCs and the ability to clone virtual DCs. Virtualization consolidates different server roles onto a single physical machine. For more information, see [Safely virtualizing Active Directory Domain Services (AD DS)](../../introduction-to-active-directory-domain-services-ad-ds-virtualization-level-100.md).

This guide describes how to run DCs as 32-bit or 64-bit guest operating systems.

## Planning for virtualization

The following sections contain planning considerations you should know when virtualizing a DC, including hardware requirements, architecture, configuration, and managing security and performance.

### Hyper-V requirements

To install and use the Hyper-V role, your hardware must meet the following requirements:

- You must have an x64 processor.

- Your processor must let you enable the hardware-assisted virtualization feature.

  - Typically this setting is known as Intel Virtualization Technology (Intel VT) or Advanced Micro Devices Virtualization (AMD-V).

- Your processor must support Hardware Data Execution Protection (DEP).
  
  - You can only use Hyper-V when you enable the Intel execute disable (XD) bit or the AMD no execute (NX) bit.

### Avoid single points of failure

As you plan your virtual DC deployment, you should prepare a strategy to avoid creating single points of failure. You can avoid introducing potential single points of failure, or areas where downtime can cause the whole system to stop working, by implementing system redundancy.

The following recommendations can help prevent single points of failure. However, it's also important to remember that following these recommendations can increase administration costs.

- Run at least two virtualized DCs per domain on different virtualization hosts. This configuration reduces the risk of losing all DCs if a virtualization host stops working.

- Diversify the hardware that runs your DCs. For example, use different CPUs, motherboards, network adapters, and so on. Diverse hardware prevents damage from device and hardware malfunctions or vendor configuration.

- If possible, run your DCs on hardware located in different regions. This approach reduces consequences of disasters that affect one of the sites hosting your DCs.

- Add physical DCs to all of your domains. Configuring your system to have physical DCs prevents your host systems from experiencing virtualization platform malfunctions.

### Security considerations

You must manage the host computer where you run your virtual DCs as carefully as you would a writeable DC, even if the computer is only a domain-joined or workgroup computer. This requirement is for security reasons. Mismanaged hosts are vulnerable to elevation-of-privilege attacks, where malicious users gain access to higher privileges than they're supposed to because the admin assigned the wrong level of permission to a lower-level role assignment. These attacks can compromise all virtual machines (VMs), domains, and forests hosted by the affected computer.

When you plan to virtualize your DC, keep the following security considerations in mind:

- The local admin credentials of a computer that hosts virtual writeable DCs should be treated as equal to the default domain admin of all domains and forests those DCs belong to.

- We recommend you configure your system to have a host running a Server Core installation of Windows Server with no applications besides Hyper-V. This configuration limits how many applications and servers you install on the server. This limitation results in better system performance and also creates a *reduced attack surface*, where there are fewer entry points for malicious attacks through applications and services.

- For branch offices or other locations that are difficult to secure, we recommend you use read-only DCs (RODCs). If you have a separate management network, we recommend that you only connect the host to the management network. For more information about RODCs, see [Install a Windows Server Active Directory Read-Only Domain Controller (RODC) (Level 200)](../../deploy/rodc/Install-a-Windows-Server-2012-Active-Directory-Read-Only-Domain-Controller--RODC---Level-200-.md).

- You can secure your DCs with BitLocker. In Windows Server 2016 and later, you can also use the virtual Trusted Platform Module (TPM) feature that provides the guest key material required to unlock the system volume.

- [Guarded fabric and shielded VMs](../../../../security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms-top-node.md) can provide other controls to protect your DCs.

For more information about securing DCs, see the [Best practice guide for securing Active Directory installations](../../plan/security-best-practices/best-practices-for-securing-active-directory.md).

### Security boundaries for host and guest configurations

You can implement virtual machines (VMs) on many different types of DC configurations. Therefore, you need to carefully consider how those VMs affect boundaries and trusts in your Active Directory topology. The following list describes two configurations you can set up for Active Directory DCs and hosts on a Hyper-V server and guest computers that are VMs running on the Hyper-V server:

- A host that's a workgroup or member computer with a guest that's a DC.
- A host that's a workgroup or member computer with a guest that's also a workgroup or member computer.

The following diagram demonstrates a configuration of three guest DC VMs hosted on a Hyper-V server.

:::image type="complex" source="media/virtualized-domain-controller-architecture/Dd363553.f44706fd-317e-4f0b-9578-4243f4db225f(WS.10).gif" alt-text="Diagram that shows security boundaries in a configuration of three guest DC VMs hosted on a Hyper-V server." border="false":::
   A diagram of an example deployment of three virtual machines (VMs) and a Hyper-V server. The three VMs are inside of a blue rectangle labeled "guest machines." All three VMs are domain controllers. VM 1 is in the Corp domain and in the Contoso.com forest. VM2 is in the Fabrikam domain and the Fabrikam.com forest. VM 3 is in the HQ domain and the Fineartschool.net forest. The Hyper-V server is outside of the blue rectangle. It's a member server located in the Corp domain and the Contoso.com forest.
:::image-end:::

Based on the example configuration in the previous diagram, here are some important considerations you should make when planning a deployment like this one:

- Administrator access
  
  - The administrator credentials on the host computer should be treated the same as that of the domain administrator on the writable DC. For an RODC guest, the administrator credentials of the host computer should be treated the same as that of the local administrator on the guest RODC.

- DC administrative rights on the host computer
  
  - An administrator of a virtualized DC has administrative rights on the host if you join the host to the same domain. However, this access privilege can also give malicious users an opportunity to compromise all VMs if they can gain access to VM 1. This scenario creates a possible *attack vector*. You can prevent this attack vector by making sure any DCs configured for multiple domains or forests have a centralized administration domain trusted by all domains, and make the virtualization host a member of the highly privileged administration domain. This approach prevents individual domain admins from controlling the host and thus the other domains.

- Avoiding attacks

  - Malicious users can attack VM 1 even if you install it as an RODC. Although RODC admins don't explicitly have domain admin rights, they can still use the RODC to apply policies to the host computer. These policies might include startup scripts for example. If a malicious actor finds a way to get RODC admin rights and sends a policy with a malicious startup script, they can compromise the host computer and use it to compromise other VMs on the host.

- Virtual hard disk (VHD) file security

  - VHD files for a virtual DC are like the physical hard drive of a physical DC. You should be just as careful securing the VHD file as you would with a hard drive. Make sure you only allow reliable and trusted admins to access these VHD files.

- RODCs

  - You can place RODCs at locations where physical security isn't guaranteed, such as branch offices. You can protect their VHD files using Windows BitLocker Drive Encryption from attacks on the host involving theft of the physical disk. However, these protections don't apply to the file systems inside of the RODC.

### Performance considerations

The Microkernel 64-bit architecture has better Hyper-V performance over previous virtualization platforms.

VM performance depends on the workload you use it for. We recommend you test specific VM topologies to make sure you're satisfied with your Active Directory deployment performance. You can assess performance under workloads over a specific period of time using tools like the Reliability and Performance Monitor (Perfmon.msc) or the [Microsoft Assessment and Planning (MAP) toolkit](https://www.microsoft.com/download/details.aspx?id=7826). The MAP tool can also help you take inventory of all servers and server roles currently within your network.

To give you an idea of how testing virtualized DC performance works, we created an example performance test using the [Active Directory Performance Testing Tool (ADTest.exe)](https://go.microsoft.com/fwlink/?linkid=137088).

Lightweight Directory Access Protocol (LDAP) tests were performed on a physical DC using `ADTest.exe`. The same tests were run on a virtualized DC that consisted of a VM hosted on a server identical to the physical DC. Only one logical processor was used in this example build for the physical computer and only one virtual processor for the VM. This configuration allowed for deployment to easily reach 100 percent CPU utilization.

The following table lists the test results for the physical and virtual DCs. The letters and numbers in parentheses next to the test names are their labels in ADTest.exe. This data shows that the virtualized DC performance was between 88 to 98 percent of the physical DC performance.

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

To maximize performance in our test deployment, we installed integration components (IC) in this test build to allow the guest OS to use hypervisor-aware synthetic drivers. When you install an IC, sometimes you need to use emulated Integrated Drive Electronics (IDE) or network adapter drivers. In production environments, you should replace these emulated drivers with synthetic drivers to increase performance.

Based on this test, consider the following recommendations for improving performance:

- When you monitor VM performance using the `Perfmon.msc` tool, sometimes the CPU information for the VM isn't entirely accurate. This inaccuracy is because of how the virtual CPU is scheduled to run on the physical processor. For more accurate CPU information for VM running on Hyper-V servers, use the Hyper-V Hypervisor Logical Processor counters in the host partition instead. For more information about performance tuning of both AD DS and Hyper-V, see [Performance tuning guidelines for Windows Server](../../../../administration/performance-tuning/index.md).

- We recommend you avoid using differencing disk VHDs on a VM configured as a DC, as differencing disk VHDs can reduce performance. To learn more about Hyper-V disk types, including differencing disks, see [New virtual hard disk wizard](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771866(v=ws.11)).

- We also recommend you become familiar with the information about how to use AD DS in virtual hosting environments by reading [Things to consider when you host Active Directory DCs in virtual hosting environments](/troubleshoot/windows-server/identity/ad-dc-in-virtual-hosting-environment).

## Deployment considerations

The following sections describe common VM practices to avoid when deploying DCs, and special considerations for time synchronization and storage.

### Deployment recommendations

Virtualization platforms like Hyper-V have many features that make managing, maintaining, backing up, and migrating machines easier. However, there are certain recommendations you need to follow in order to take advantage of these features for your virtual DCs.

- To ensure your Active Directory writes are durable, don't deploy virtual DC database files, such as the **NTDS.DIT** Active Directory database, logs, and SYSVOL, on virtual IDE disks. Instead, create a second virtual hard disk (VHD) attached to a virtual Small Computer System Interface (SCSI) controller and ensure the database files are on the VM SCSI disk when you install the DC.

- Don't implement differencing disk VHDs on a VM you're configuring as the DC. While this approach makes it easy to revert your deployment to previous versions, it also decreases performance. For more information about VHD types, see [New virtual hard disk wizard](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771866(v=ws.11)).

- Don't deploy Active Directory domains and forests on a copy of a Windows Server OS without first using the System Preparation tool (sysprep) to prepare them for deployment. For more information about running the Sysprep, see [Sysprep (System Preparation) Overview](/windows-hardware/manufacture/desktop/sysprep--system-preparation--overview).

   > [!WARNING]
   > Running Sysprep on a promoted DC isn't recommended, as it can negatively affect the AD database and related components and cause the following issues:
   >
   > - Data loss
   > - AD database corruption
   > - Stability and functionality issues
   > - Application, services, and drivers issues

- Don't deploy other DCs with a copy of a VHD file from a DC you deployed. Not using copies prevents potential USN rollback scenarios. For more information about USN rollback, see [USN and USN rollback](#usn-and-usn-rollback).

  - In Windows Server 2012 and later, administrators can clone DC images to deploy more DCs, but only if they use properly prepared images.

- Don't use the Hyper-V Export feature to export a VM that's running a DC.

  - In Windows Server 2012 and later, the system handles exporting and importing DC virtual guests like a nonauthoritative restore. This process detects if the Generation ID changed and if the DC isn't configured for cloning.

  - When you export a guest VM, you must make sure nobody's using it. To make things easier, you can use Hyper-V Replication to create an inactive copy of the DC. When you start using the replicated image, you must also perform cleanup like you would for the source image after exporting a DC guest image.

### Physical-to-virtual conversion

System Center VM Manager (VMM) lets you manage physical machines and VMs in a unified way. You can also use VMM to migrate a physical machine to a VM. This migration process is called *physical-to-VM conversion*, or P2V conversion. In order to start the P2V conversion process, you must make sure the VM and physical DC you're migrating aren't running at the same time. Ensuring the two machines aren't running at the same time prevents USN rollback scenarios, as described in [USN and USN rollback](#usn-and-usn-rollback).

You should perform P2V conversion in offline mode to keep the directory data consistent when you turn the DC back on. You can toggle offline mode in the Convert Physical Server installer. For more information about how to use offline mode, see [P2V: Convert physical computers to VMs in VMM](/previous-versions/system-center/virtual-machine-manager-2008-r2/cc764232(v=technet.10)).

You should also disconnect the VM from the network during P2V conversion. You should only enable the network adapter after you finish the conversion process and verify that everything works. At that point, you should turn the physical source machine off. Don't turn the physical source machine back on and reconnect it to the network until after you reformat the hard disk.

#### Avoiding USN rollback

When you create virtual DCs, you should avoid creating USN rollback scenarios. To avoid rollback, you can set up a new virtual DC with regular promotion, promotion from Install from Media (IfM), or by cloning the DC if you already have at least one virtual DC. This approach also lets you avoid hardware or platform problems P2V-converted virtual guests might encounter.

> [!WARNING]
> To prevent issues with Active Directory replication, ensure that only one physical or virtual DC exists on a given network at any point in time. You can lower the likelihood of the old clone being a problem by using one of the following methods:
>
> - When the new virtual DC is running, run the following command twice to change the computer account password:
>
>   ```cmd
>   netdom resetpwd /Server:<domain-controller>
>   ```
>
> - Export and import the new virtual guest to force it to become a new Generation ID and a database invocation ID.

### Test environments and P2V migration

You can use P2V migration in combination with the VMM to create test environments. With this method, you can migrate production DCs from physical machines to VMs to create a test environment without permanently bringing down the production DCs. However, you must build the test environment on a separate network from the production environment to allow for two instances of the same DC to exist. It's important to avoid USN rollbacks when you create test environments using P2V migration.

#### Creating a test environment

We recommend you do the following when you create test environments using P2V:

- Migrate one in-production DC from each domain to a test VM by using P2V based on the recommendations in [Physical-to-virtual conversion](#physical-to-virtual-conversion).

- Place the physical production machines and the test VMs in different networks when you bring them back online.

- To avoid [USN rollbacks](#usn-and-usn-rollback) in the test environment, disconnect all DCs you plan to migrate from the network. You can disconnect your DCs by stopping the NTDS service or restarting the machines in Directory Services Restore Mode (DSRM).

- Don't introduce any new updates to the environment after you disconnect the DCs from the network.

- Don't connect any of the machines to the network during P2V migration. You can only reconnect them once you finish migrating all machines.

- You should only promote test DCs you make after P2V conversion as replicas in the test environment.

### Time service and synchronization

For VMs you configured to be DCs, we recommend that you disable time synchronization between the host system and guest OS that's acting as a DC. If the guest DC doesn't synchronize with the host system, then it synchronizes with the domain hierarchy instead.

To disable the Hyper-V time synchronization provider, turn the VM off, then go to the VM settings, select **Integration Services** and uncheck the **Time synchronization** check box.

### Storage and optimization

We recommend you follow the storage recommendations in this section to optimize your DC VM performance and ensure your Active Directory writes are durable.

- For guest storage, store the Active Directory database file (`Ntds.dit`) and the log and SYSVOL files on a separate virtual disk from the OS files. We recommend that you store these files in a virtual SCSI disk in a second VHD attached to a virtual SCSI controller. A virtual SCSI disk increases performance and supports Forced Unit Access (FUA). With FUA, the OS writes and reads directly from the media, bypassing any caching mechanisms.

- If you're using BitLocker to secure your virtual DC guest, configure the extra volumes for auto unlock using the [Enable-BitLockerAutoUnlock](/powershell/module/bitlocker/enable-bitlockerautounlock) PowerShell cmdlet.

- When storing VHD files on hosts, you should use a disk that isn't frequently used by other services or applications, such as the system disk for the host OS. Store each VHD file on a separate partition from the host OS and other VHD files, preferably on a separate physical drive.

- Your host physical disk system must meet at least one of the following criteria to meet virtualized workload data integrity requirements:

  - The host uses server-class disks, such as SCSI or Fibre Channel.

  - The host ensures the disks are connected to a battery-backed caching HBA.

  - The host uses a storage controller like a redundant array of independent disks (RAID) system as its storage device.

  - The host uses an uninterruptible power supply (UPS) to power the disk.

  - The host disables the disk's write-caching feature by default.

- When using VHD files, we recommend using pass-through disks or fixed-size VHDs because they're optimized for performance. We don't recommend dynamically expanding and differencing disks because they can cause delays, performance degradation during high disk activity, and potential data loss when rolling back to a previous snapshot.

- We recommend you use virtual SCSI controllers to reduce the chance of your Active Directory data corrupting.

  - On Hyper-V servers that host virtual DCs, you should use SCSI physical drives. If your scenario doesn't let you use SCSI drives, you should disable write caching on the Advanced Technology Attachment (ATA) or Integrated Drive Electronics (IDE) drive you're using instead. For more information, see [Event ID 1539 – Database Integrity](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd941847(v=ws.10)).

### Operational restrictions for VM domain controllers

Domain controllers running on VMs have operational restrictions that don't apply to DCs running on physical machines. When you use a virtualized DC, you must follow these guidelines:

- Don't pause, stop, or store the saved state of a DC in a VM longer than the forest's tombstone lifetime. Resuming a saved state that you paused or saved longer than the tombstone lifetime can interfere with replication. To learn how to determine the tombstone lifetime for the forest, see [Determine the tombstone lifetime for the forest](/previous-versions/windows/it-pro/windows-server-2003/cc784932(v=ws.10)).

- Don't copy or clone VHDs.

- Don't take or use snapshots of virtual DCs. You should use a more permanent and reliable backup method instead.

- Don't use the Export feature on a VM running a DC.

- Don't restore or roll back your DC or the contents of an Active Directory database using an unsupported backup method.

## Backup and restore considerations

You must back up your DCs to prevent data loss due to disaster scenarios or administrative errors. The backup method that Active Directory supports is using a backup application to restore a system state backup made from the current installation of the DC. The application should be one that's compatible with Active Directory, such as Windows Server Backup. For more information about supported backup methods, see [AD DS backup and recovery step-by-step guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771290(v=ws.10)).

In virtualized deployments, you need to pay special attention to certain requirements for Active Directory backup operations. For example, if you restore a DC using a copy of the VHD file and you don't update the database version of the DC after restoring it, it can cause problems with replication due to inaccurate tracking numbers among the DC replicas. In most cases, the replication doesn't detect this issue and doesn't report any errors, but inconsistencies between DCs can potentially cause problems in certain scenarios.

### Recommended method for backing up and restoring virtualized DCs

The method we recommend you use to back up and restore your virtualized DCs is to run Windows Server Backup in the guest OS. For more information, see [Restore a virtual domain controller](../../manage/virtual-dc/restore-virtualized-domain-controller.md).

While you can technically use snapshots or copies of VHD files to restore a backup, we don't recommend using these methods for the following reasons:

- If you copy or clone a VHD file, the database becomes stale because its database version number isn't automatically updated when you restore it. This inconsistency in tracking numbers means that if you start the VHD in normal mode, you can potentially cause a [USN rollback](#usn-and-usn-rollback).

- While Windows Server 2016 and later is compatible with snapshots, snapshots don't provide the type of stable, permanent backup history you need to consistently restore your system during disaster scenarios. The Volume Shadow Copy Service (VSS)-based snapshots you can create in Windows Server 2016 Hyper-V and later also aren't compatible with BitLocker, which can cause potential security issues. This issue prevents the Active Directory database engine from accessing the database containing the snapshot when Hyper-V tries to mount the snapshot volume.

> [!NOTE]
> The shielded VM project described in [Guarded fabric and shielded VMs](../../../../security/guarded-fabric-shielded-vm/guarded-fabric-and-shielded-vms-top-node.md) has a Hyper-V host driven backup as a non-goal for maximum data protection of the guest VM.

## USN and USN rollback

This section describes replication issues that can occur as a result of an incorrect restoration of the Active Directory database with an older version of a VM. For more information about the Active Directory replication process, see [Active Directory replication concepts](../replication/active-directory-replication-concepts.md).

### How AD DS and DCs use USNs

AD DS uses USNs to keep track of replication of data between DCs. Each time you change data in the directory, the USN increments to indicate a new change.

Destination DCs use USNs to track updates to each directory partition they store. The USN also tracks the status of every DC that stores replicas of these directory partitions. When DCs replicate changes to one another, they query their replication partners for changes with USNs greater than the last change the DC received from its partner.

You can find the replication metadata tables that contain the USNs in the up-to-dateness vector and high water mark. Both the source and destination DCs use these tables to filter required updates for the destination DC.

The destination DC maintains the up-to-dateness vector table to track originating updates it receives from all source DCs. When a destination DC requests changes for a directory partition, it provides its up-to-dateness vector to the source DC. The source DC then uses this value to filter the updates that it sends to the destination DC. The source DC sends its up-to-dateness vector to the destination DC after a successful replication cycle finishes. The source DC uses the USN to track if the destination DC is synchronized with the originating updates at every DC, and that the updates to the destinations are at the same level as the source.

The destination DC maintains the high water mark table to track the most recent changes it received from a specific source DC for a specific partition. The high water mark table prevents the source DC from sending out changes that the destination DC already received from it.

### Directory database identity

In addition to USNs, DCs keep track of the directory database of source replication partners. The system maintains identity of the directory database running on the server separately from the identity of the server object itself. The directory database identity on each DC is stored in the `invocationID` attribute of the `NTDS Settings` object, which is located under the Lightweight Directory Access Protocol (LDAP) path `cn=NTDS Settings, cn=ServerName, cn=Servers, cn=*SiteName*, cn=Sites, cn=Configuration, dc=*ForestRootDomain*`.

The system stores the server object identity in the `objectGUID` attribute of the `NTDS Settings` object. The identity of the server object never changes. However, the identity of the directory database changes under the following circumstances:

- When a system state restore procedure occurs on the server.

- When you add an application directory partition to the server, then remove it, then add it again.

- When a Hyper-V instance triggers its VSS writers on a partition containing a virtual DC's VHD.

   In this scenario, the guest triggers its own VSS writers. This action is the same mechanism that the backup and restore process uses. This method resets the `invocationID` attribute.

The `invocationID` attribute relates a set of originating updates on a DC with a specific version of the directory database. The up-to-dateness vector and the high water mark tables use the `invocationID` and DC GUID respectively so the DCs recognize which copy of the Active Directory database the replication information is coming from.

The `invocationID` attribute is a globally unique identifier (GUID) value that's visible near the top of the output after you run the `repadmin /showrepl` command. The following text represents example output from the command:

```output
Repadmin: running command /showrepl against full DC local host
Default-First-Site-Name\VDC1
DSA Options: IS_GC
DSA object GUID: 966651f3-a544-461f-9f2c-c30c91d17818
DSA invocationID: b0d9208b-8eb6-4205-863d-d50801b325a9
```

When you restore AD DS on a DC, the system resets the `invocationID` attribute. This change increases replication traffic, with duration relative to the size of the partition you're replicating.

To demonstrate this scenario, the following diagram depicts an example environment where virtual domain controller VDC1 and domain controller DC2 are two DCs in the same domain. This diagram shows how DC2 detects the `invocationID` value in VDC1 after a reset in a supported restore scenario.

:::image type="complex" source="media/virtualized-domain-controller-architecture/Dd363553.ca71fc12-b484-47fb-991c-5a0b7f516366(WS.10).gif" alt-text="Diagram that demonstrates the scenario when the invocationID value is reset properly." border="false":::
   A diagram depicting a flow chart of VDC1's view of itself and DC2's view of VDC1. On the VDC1 line, VDC1 starts off with a USN of 1000 and an Invocation ID of B. It then is restored to its previous version, which has a USN of 500 and an InvocationID value of B. Changes occur on VDC1, bringing it back up to USN 600 while the Invocation ID stays the same. On the line that says "DC2 view of VDC1," DC2 starts with an Invocation ID of VDC1(A)@USN1000. After VDC1 gets restored, DC2 resets its expected USN from 1000 to 500, making its value for Invocation ID B VDC1(B)@USN500. It continues to track both Invocation ID A and Invocation ID B. After the next set of changes on VDC1, DC2 now tracks VDC1's invocation ID A of USN 1000 and its new Invocation ID B of USN 600.
:::image-end:::

### USN rollback

USN rollback occurs when the system can't update a USN as normal, a user circumvents USN updates, or a DC tries to use a USN lower than its latest update. When the system detects a USN rollback, it stops replication before the mismatch can cause a divergence in the forest.

Many factors can cause a USN rollback. For example, it can happen if you use old VHD files or perform P2V conversion without permanently disconnecting the physical machine after the conversion.

#### Preventing USN rollback

You can prevent USN rollbacks by taking the following precautions:

- When not running Windows Server 2012 or later, don't take or use a snapshot of a DC VM.

- Don't copy the DC VHD file.

- When not running Windows Server 2012 or later, don't export a VM that's running a DC.

- Only restore a DC or roll back the contents of an Active Directory database using supported first-party backup solutions, such as Windows Server Backup.

Sometimes the system can't detect USN rollback before it can cause replication errors. When you encounter replication errors, you must identify the extent of the problem and address it as soon as possible. For more information about how to remove lingering objects that can occur as a result of USN rollback, see [Active Directory replication Event ID 1388 or 1988: A lingering object is detected](/troubleshoot/windows-server/identity/active-directory-replication-event-id-1388-1988).

#### USN rollback detection

<!--The version numbers described here are very old. Do we need this section/need to rewrite it? Also, a lot of the info here has been described in earlier sections, I think. Not to mention this feels like a conceptual article jammed into a how-to.-->

In most cases, the system can detect USN rollbacks by tracking inconsistencies in the `invocationID` attribute caused by restoring a DC without resetting the attribute. Windows Server 2008 provides protections against replication errors after unsupported DC restore operations. These protections trigger when an unsupported restore creates USNs lower than the original versions, representing changes that replication partners already received.

In Windows Server, when a destination DC requests changes using a previously used USN, the destination DC interprets the replication partner response to mean its replication metadata is outdated. Outdated metadata means that the Active Directory database on the source DC rolled back to a previous state, so the system responds accordingly.

For example, let's say a VM's VHD file rolled back to a previous version. In this case, the destination DC initiates the following quarantine measures on the DC it identified as having undergone an unsupported restore:

- AD DS pauses the Net Logon service, which prevents user accounts and computer accounts from changing account passwords. This action prevents the loss of such changes if they occur after an improper restore.

- AD DS disables inbound and outbound Active Directory replication.

- AD DS generates Event ID 2095 in the Directory Service event log to record what happened.

The following diagram shows the sequence of events that occur when AD DS detects USN rollback on VDC2, the destination DC that's running on a VM. In this illustration, the detection of USN rollback occurs on VDC2 when a replication partner detects that VDC2 sent an up-to-dateness USN value previously seen by the destination DC. This condition indicates that VDC2 database experienced a rollback.

:::image type="complex" source="media/virtualized-domain-controller-architecture/Dd363553.373b0504-43fc-40d0-9908-13fdeb7b3f14(WS.10).gif" alt-text="Diagram that demonstrates what happens when USN rollback is detected." border="false":::
   A diagram depicting a flowchart of VDC2 updates and DC1 up-to-dateness value for VDC2. VDC2 starts off with a USN of 100 and Invocation ID A. It then updates its USNs from 101 to 200, which is replicated onto DC1. However, the user also makes a VHD copy of VDC2 USN 200. Next, VDC2 updates to USN 201 to 350, and replicates those changes onto DC1. However, VDC2 then fails. The user then restores VDC2 with the copy they made on the USN 200 VHD. After that, the user makes another update to VDC2 for a new version of USNs 201-355. DC1 requests changes greater than USN 350 from VDC2 and gets replicated because the USN on VDC2 is higher than DC1. However, the new version of USNs 201 through 350 aren't the same as the ones on DC1, causing a USN rollback.
:::image-end:::

#### Resolve Event ID 2095 issues


If you see Event ID 2095 in the Directory Service event log, follow these instructions immediately:

1. Isolate the VM that recorded the error from the network.

1. Check if the reported changes originated from this DC and propagated to other DCs. If the event was a result of using a snapshot or copy of a VM, try to find out when the USN rollback occurred. Once you have the time, you can check the replication partners of that DC to determine whether replication occurred after the rollback.

   You can use the Repadmin tool to check where the changes came from. For information about how to use Repadmin, see [Monitoring and troubleshooting Active Directory replication with Repadmin](/previous-versions/windows/it-pro/windows-server-2003/cc811551(v=ws.10)). If you're unable to make a determination, contact [Microsoft Support](https://support.microsoft.com) for assistance.

1. Forcefully demote the DC. This operation involves cleaning up the DC's metadata and seizing the operations master roles, also known as flexible single master operations (FSMO) roles. For more information, see [Recover from USN rollback](/troubleshoot/windows-server/identity/detect-and-recover-from-usn-rollback#recover-from-usn-rollback).

1. Delete all former VHD files for the DC.

### Undetected USN rollback

The DC might not detect USN rollback in the following scenarios:

- The VHD file is attached to different VMs running in multiple locations simultaneously.

- The USN on the restored DC increased past the last USN received by the other DC.

In the VHD file scenario, other DCs might replicate with either one of the VMs, and changes might occur on either VM without being replicated to the other. This divergence of the forest is difficult to detect, and it causes unpredictable directory responses. This situation can occur after a P2V migration if both the physical DC and VM are run on the same network. This situation can also happen if multiple virtual DCs are created from the same physical DC and then run on the same network.

In the USN scenario, a range of USNs applies to two different sets of changes. This scenario can continue for extended periods without being detected. When you modify an object you created during this period, the system detects a lingering object and reports it as Event ID 1988 in the Event Viewer. The following diagram shows why the DC might not detect USN rollback in this scenario.

:::image type="complex" source="media/virtualized-domain-controller-architecture/Dd363553.63565fe0-d970-4b4e-b5f3-9c76bc77e2d4(WS.10).gif" alt-text="Diagram that demonstrates a scenario where USN rollback isn't detected." border="false":::
   Diagram that shows a flow chart for the rollback detection process in an example build. There are two domain controllers labeled "VDC1" and "DC2." The initial stage of the flow chart shows the virtual DC, VDC1, take a snapshot when its USN is 2000. After the snapshot, VDC1 creates 100 users, and the updated VDC1 now has a USN of 2100. The updates on VDC1 replicate to DC2, which now shares the USN of 2100. However, the VDC1 then uses the snapshot it took to revert to its USN 2000 version. The reverted version of VDC1 creates 150 new users, which brings its USN up to 2150. The updated VDC1 replicates to DC2, but DC2 doesn't detect the mismatched changes because its USN is higher than the DC2's USN of 2100. Text on the bottom says, "USN rollback is not detected, which results in an undetected divergence where USNs 2001 through 2100 are not the same between the two domain controllers.
:::image-end:::

### Read-only DCs

Read-only domain controllers (RODCs) are DCs that host read-only copies of the partitions in an Active Directory database. RODCs avoid most USN rollback issues because they don't replicate any changes to the other DCs. However, if an RODC replicates from a writeable DC affected by USN rollback, the rollback also affects the RODC.

We don't recommend using a snapshot to restore an RODC. You should only restore an RODC using an Active Directory–compatible backup application. Also, as with writeable DCs, you must not allow an RODC to be offline for more than the tombstone lifetime. This condition can result in lingering objects on the RODC.

For more information about implementing RODCs, see the [Read-Only Domain Controllers step-by-step guide](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/cc772234(v=ws.10)).

## Additional content

Learn how to restore virtualized DCs at [Restore virtualized domain controllers](../../manage/virtual-dc/restore-virtualized-domain-controller.md).

