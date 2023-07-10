---
title: Active Directory Forest Recovery - Determine how to recover the forest 
description: Recovering an entire Active Directory forest involves restoring at least one Domain Controller (DC) in every domain from available backup. Recovering the forest restores each domain in the forest to its state at the time of the last trusted backup. Consequently, the restore operation will result in the loss of at least the following Active Directory data...
ms.author: inhenkel
author: IngridAtMicrosoft
ms.date: 07/10/2023
ms.topic: article
---

# Active Directory Forest Recovery - Determine how to recover the forest

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2 and 2012

Recovering an entire Active Directory forest involves restoring at least one
Domain Controller (DC) in every domain from an available backup. Recovering the
forest restores each domain in the forest to its state at the time of the last
trusted backup.

## What will be lost

The restore operation will result in the loss of at least the following Active Directory data:

- All objects (such as users and computers) that were added after the last trusted back up
- All updates that were made to existing objects since the last trusted back up
- All changes that were made to either the configuration partition or the schema partition in AD DS (such as schema changes) since the last trusted back up

## Password knowledge

1. You must know the password of a Domain Admin account for each domain in the forest. Preferably, this is the password of the built-in Administrator account.
1. You must also know the DSRM password to perform a system state restore of a DC.

It's a good practice to archive the Administrator account and DSRM password history in a safe place for as long as the backups are valid. That is, within the tombstone lifetime period or within the deleted object lifetime
period if Active Directory Recycle Bin is enabled.

You can also synchronize the DSRM password with a domain user account in order to make it easier to remember. For more information, see [this article](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc754363(v=ws.11)). Synchronizing the DSRM account must be done in advance of the forest recovery, as part of preparation.

> [!NOTE]
> The Administrator account is a member of the built-in Administrators group by default, as are the Domain Admins and Enterprise Admins groups. This group has full control of all DCs in the domain.

## Determine which backups to use

Back up at least two writeable DCs for each domain regularly so you have multiple backups to choose from. Select one or more DCs as required and the PDC Emulator operation master for SYSVOL data recovery.

> [!NOTE]
> You cannot use the backup of a read-only domain controller (RODC) to restore a writeable DC. We recommend that you restore the DCs by using backups that were taken a few days before the occurrence of the failure. In general, you must determine a tradeoff between the recentness and the safeness of the restored data. Choosing a more recent backup recovers more useful data, but it might increase the risk of reintroducing dangerous data into the restored forest.

Restoring system state backups depends on the original operating system and server of the backup. For example, you shouldn't restore a system state backup to a different server. In this case, you may see the following warning:

> [!WARNING]
> The specified backup is of a different server than the current one. We don't recommend performing a system state recovery with the backup to an alternate server because the server might become unusable. Are you sure you want to use this backup for recovering the current server?

If you need to restore Active Directory to different hardware, create full server backups and plan to perform a full server recovery.

> [!IMPORTANT]
> Restoring system state backup to a new installation of Windows Server on new hardware or the same hardware is not supported. If Windows Server is reinstalled on the same hardware (recommended), you can restore the domain controller in this order:
>
> 1. Perform a full server restore in order to restore the operating system and all files and applications.
> 2. Perform a system state restore using wbadmin.exe in order to mark SYSVOL as authoritative.
>
> For more information, see [How to restore a Windows 7 installation](/troubleshoot/windows-server/backup-and-storage/how-to-restore-windows-installation).

If the time of failure is unknown, investigate further to identify backups that hold the last safe state of the forest.

This approach is less desirable. Therefore, we strongly recommend that you keep detailed logs about the health state of AD DS on a daily basis so that, if there's a forest-wide failure, the approximate time of failure can be identified. You should also keep a local copy of backups to enable faster recovery.

If Active Directory Recycle Bin is enabled, the backup lifetime is equal to the **deletedObjectLifetime** value or the **tombstoneLifetime** value, whichever is less. For more information, see [Active Directory Recycle Bin Step-by-Step Guide](https://go.microsoft.com/fwlink/?LinkId=178657).

Alternatively, you can use the Active Directory database mounting tool `Dsamain.exe` and a Lightweight Directory Access Protocol (LDAP) tool, such as `Ldp.exe` or Active Directory Users and Computers, to identify which backup has the last safe state of the forest. The Active Directory database mounting tool, which is included in Windows Server operating systems, exposes Active Directory data that is stored in backups or snapshots as an LDAP server. You can use an LDAP tool to browse the data. This approach has the advantage of not requiring you to restart any DC in Directory Services Restore Mode (DSRM) to examine the contents of the backup of AD DS.

For more information about using the Active Directory database mounting tool, see the [Active Directory Database Mounting Tool Step-by-Step Guide](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc753609(v=ws.10)?redirectedfrom=MSDN%22HYPERLINK%20%22https%3A%2F%2Flearn.microsoft.com%2Fen-us%2Fprevious-versions%2Fwindows%2Fit-pro%2Fwindows-server-2008-R2-and-2008%2Fcc771232(v%3Dws.10)).

You can also use the `ntdsutil snapshot` command to create snapshots of the Active Directory database. By scheduling a task to periodically create snapshots, you can obtain additional copies of the Active Directory database over time. You can use these copies to better identify when the forest-wide failure occurred and then choose the best backup to restore. To create snapshots, use `ntdsutil` or the Remote Server Administration Tools (RSAT).

The target DC can run any version of Windows Server. For more information about using the `ntdsutil snapshot` command, see [Snapshot](/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc731620(v=ws.11)).

## Determine which domain controllers to restore

The ease of the restore process is an important factor when deciding which domain controller to restore. Haveing a dedicated DC for each domain that is the preferred DC for a restore is recommended. A dedicated restore DC makes it easier to reliably plan and execute the forest recovery because you use the same source configuration that was used to perform restore tests. You can script the recovery and avoid contending with different configurations, such as whether the DC holds operations master roles, or whether it's a GC or DNS server.

> [!NOTE]
> Restoring an operations master role holder in the interest of simplicity isn't recommended, as you always seize all roles. There is the case of a SYSVOL recovery using a backup taken from the PDC Emulator operation master, as typically the PDC has the best copy of SYSVOL data.

A good backup is a backup that can be restored successfully, was taken a few days before the failure, and contains as much useful data as possible. Choose a DC that best meets the following criteria:

- A DC that is writeable. This is mandatory.
- A DC running Windows Server 2012 or newer as a virtual machine on a hypervisor that supports VM-GenerationID. This DC can be used as a source for cloning. In general, use a DC with a good back up that has the most current OS.
- A DC that is accessible, either physically or on a virtual network, and preferably located in a datacenter. This way, you can easily isolate it from the network during forest recovery.
- A DC that has a good full server backup.
- A DC running Domain Name System (DNS) role and hosting the forest and domain(s) zone.
- A DC configured as a Global Catalog (GC).
- A DC that **isn't** confitured to use BitLocker Network Unlock, if you use Windows Deployment Services.
    Using BitLocker Network Unlock for the first DC that you restore from backup during a forest recovery isn't supported. On DCs where you have deployed Windows Deployement Services (WDS),,BitLocker Network Unlock as the **only** key protector **can't** be used because the first DC would require Active Directory and WDS to be working in order to unlock. Before you restore the first DC, Active Directory isn't yet available for WDS, so it can't unlock.

    To determine if a DC is configured to use BitLocker Network Unlock, check that a Network Unlock certificate is identified in the following registry key:

    `HKEY_LOCAL_MACHINESoftwarePoliciesMicrosoftSystemCertificatesFVE_NKP`

> [!IMPORTANT] 
> Maintain security procedures when handling or restoring backup files that include Active Directory. The urgency that accompanies forest recovery can unintentionally lead to overlooking security best practices.

## Identify the current forest structure and DC functions

Determine the current forest structure by identifying all the domains in the forest. Make a list of all of the DCs in each domain, particularly the DCs that have backups, and virtualized DCs which can be a source for cloning.

A list of DCs for the forest root domain is the most important because you'll recover this domain first. After you restore the forest root domain, you can obtain a list of the other domains, DCs, and the sites in the forest by using Active Directory snap-ins.

For each domain in the forest, identify a single writeable DC that has a trusted backup of the Active Directory database for that domain. Use caution when you choose a backup to restore a DC. If the day and cause of the failure are known, the general recommendation is to identify and use a safe backup that was made a few days before that date.

Prepare a table that shows the functions of each DC in the domain, as shown in the following example. This will help you revert back to the pre-failure configuration of the forest after recovery.

| **DC name** | **Operating system** | **FSMO**                            | **GC** | **RODC** | **Backup** | **DNS** | **Server Core** | **VM** |
|-------------|----------------------|-------------------------------------|--------|----------|------------|---------|-----------------|--------|
| DC_1        | Windows Server 2019  | Schema master, Domain naming master | Yes    | No       | Yes        | No      | No              | Yes    |
| DC_2        | Windows Server 2019  | None                                | Yes    | No       | Yes        | Yes     | No              | Yes    |
| DC_3        | Windows Server 2022  | Infrastructure Master               | No     | No       | No         | Yes     | Yes             | Yes    |
| DC_4        | Windows Server 2022  | PDC emulator, RID Master            | Yes    | No       | No         | No      | No              | Yes    |
| DC_5        | Windows Server 2022  | None                                | No     | No       | Yes        | Yes     | No              | Yes    |
| RODC_1      | Windows Server 2016  | None                                | Yes    | Yes      | Yes        | Yes     | Yes             | Yes    |
| RODC_2      | Windows Server 2022  | None                                | Yes    | Yes      | No         | Yes     | Yes             | Yes    |

In this above example, there are four backup candidates: DC_1, DC_2, DC_4, and DC_5. Of these backup candidates, you restore only one. The recommended DC is DC_5 for the following reasons:

- It is a good source for virtualized DC cloning, because it runs Windows Server 2022 as a virtual DC and runs software that is allowed to be cloned (or that can be removed if it isn't able to be cloned). After the restore, the PDC emulator role will be seized to that server and it can be added to the Cloneable Domain Controllers group for the domain.
- It runs a full installation of Windows Server 2022. A DC that runs a Server Core installation can be less convenient as a target for recovery. This may not be a factor if you're good with managing Windows Servers using the command line interface.
- It's a DNS server.

> [!NOTE]
> Because DC_5 is not a global catalog server, it has a slight advantage in that the global catalog doesn't need to be removed after the restore. However you would need to start recovery with the default Administrator account with Rid 500 or use registry value **ignoregcfailures**:  
>
>`Key: HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\Lsa`  
> `Value: IgnoreGCFailures`  
> `Type: REG_DWORD`  
> `Data: 0 – Require GlobalCatalog for logon (default)`  
> `1 – Allow logon without groups from GC`

Other factors are typically more important than the extra step of removing the GC role. DC_3 or DC_4 are also good choices as the Operation Master Roles they have aren't a problem. Consider the options and choose depending on your actual recovery situation. You may normally plan and test by restoring the PDC Operations Master backup, but if this backup doesn't work, for example because it is from the wrong time, pick a backup from a GC of the same domain.

## Recover the forest in isolation

The preferred scenario is to shut down all writeable DCs before the first restored DC is brought back into production. This ensures that any dangerous data doesn't replicate back into the recovered forest. It's particularly important to shut down all operations master role holders.

> [!NOTE]
> There may be cases where you move the first DC that you plan to recover for each domain to an isolated network while allowing other DCs to remain online in order to minimize system downtime. For example, if you are recovering from a failed schema upgrade, you may choose to keep domain controllers running on the production network while you perform recovery steps in isolation.

### Virtualized DCs

If you're running virtualized DCs, you can move them to a virtual network that is isolated from the production network where you'll perform recovery. Moving virtualized DCs to a separate network provides two benefits:

- Recovered DCs are prevented from reproducing the problem that caused the forest recovery.
- Virtualized DC cloning can be performed on the isolated network so that a critical number of DCs can be running and tested before they're brought back to the production network.

### Physical DCs

If you're running DCs on physical hardware, disconnect the network cable of the first DC that you plan to restore in the forest root domain. If possible, also disconnect the network cables of all other DCs. This prevents DCs from replicating, if they're accidentally started during the forest recovery process.

### Large forests

In a large forest spread across multiple locations, it can be difficult to guarantee that all writeable DCs are shut down. For this reason, the recovery steps—such as resetting the computer account and krbtgt account, in addition to metadata cleanup—are designed to ensure that the recovered writeable DCs don't replicate with dangerous writeable DCs (in case some are still online in the forest).

However, only by taking writeable DCs offline can you guarantee that replication doesn't occur. Therefore, whenever possible, you should deploy remote management technology that can help you to shut down and physically isolate the writeable DCs during forest recovery.

### RODCs

RODCs can continue to operate while writeable DCs are offline. No other DC will directly replicate any changes from any RODC—especially, no schema or configuration container changes—so they don't pose the same risk as writeable DCs during recovery. After all the writeable DCs are recovered and online, you should rebuild all the RODCs.

RODCs will continue to allow access to local resources that are cached in their respective sites while the recovery operations are going on in parallel. Local resources that aren't cached on the RODC will have authentication requests forwarded to a writeable DC. These requests will fail because writeable DCs are offline. Some operations such as password changes will also not work until you recover writeable DCs.

If you're using a hub-and-spoke network architecture, you can concentrate first on recovering the writeable DCs in the hub sites. Later, you can rebuild the RODCs in remote sites.

## Compromised AD database

If the AD database of a writable DC is compromised, a new KDS Root Key should be created after the recovery and all Group Managed Service Accounts (gMSA) should be recreated depending on the compromission scenario. The details are described here: [How to recover from a Golden gMSA attack](/troubleshoot/windows-server/windows-security/recover-from-golden-gmsa-attack).

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]
