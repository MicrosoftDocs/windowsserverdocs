---
title: AD Forest Recovery - Determine how to recover the forest 
description:
ms.author: joflore
author: MicrosoftGuyJFlo
manager: mtillman
ms.date: 08/09/2018
ms.topic: article
ms.prod: windows-server
ms.assetid: 5a291f65-794e-4fc3-996e-094c5845a383
ms.technology: identity-adds
---
# Determine how to recover the forest

>Applies To: Windows Server 2016, Windows Server 2012 and 2012 R2, Windows Server 2008 and 2008 R2

Recovering an entire Active Directory forest involves either restoring it from backup or reinstalling Active Directory Domain Services (AD DS) on every domain controller (DC) in the forest. Recovering the forest restores each domain in the forest to its state at the time of the last trusted backup. Consequently, the restore operation will result in the loss of at least the following Active Directory data:

- All objects (such as users and computers) that were added after the last trusted backup
- All updates that were made to existing objects since the last trusted backup
- All changes that were made to either the configuration partition or the schema partition in AD DS (such as schema changes) since the last trusted backup

For each domain in the forest, the password of a Domain Admin account must be known. Preferably, this is the password of the built-in Administrator account. You must also know the DSRM password to perform a system state restore of a DC. In general, it is a good practice to archive the Administrator account and DSRM password history in a safe place for as long as the backups are valid, that is, within the tombstone lifetime period or within the deleted object lifetime period if Active Directory Recycle Bin is enabled. You can also synchronize the DSRM password with a domain user account in order to make it easier to remember. For more information, see KB article [961320](https://support.microsoft.com/kb/961320). Synchronizing the DSRM account must be done in advance of the forest recovery, as part of preparation.

> [!NOTE]
> The Administrator account is a member of the built-in Administrators group by default, as are the Domain Admins and Enterprise Admins groups. This group has full control of all DCs in the domain.

## Determining which backups to use

Back up at least two writeable DCs for each domain regularly so you have several backups to choose from. Note that you cannot use the backup of a read-only domain controller (RODC) to restore a writeable DC. We recommend that you restore the DCs by using backups that were taken a few days before the occurrence of the failure. In general, you must determine a tradeoff between the recentness and the safeness of the restored data. Choosing a more recent backup recovers more useful data, but it might increase the risk of reintroducing dangerous data into the restored forest.

Restoring system state backups depends on the original operating system and server of the backup. For example, you should not restore a system state backup to a different server. In this case, you may see the following warning:

“The specified backup is of a different server than the current one. We do not recommend performing a system state recovery with the backup to an alternate server because the server might become unusable. Are you sure you want to use this backup for recovering the current server?”

If you need to restore Active Directory to different hardware, create full server backups and plan to perform a full server recovery.

> [!IMPORTANT]
> Beginning with Windows Server 2008, it is not supported to restore system state backup to a new installation of Windows Server on new hardware or the same hardware. If Windows Server is reinstalled on the same hardware, as recommended later in this guide, then you can restore the domain controller in this order:
>
> 1. Perform a full server restore in order to restore the operating system and all files and applications.
> 2. Perform a system state restore using wbadmin.exe in order to mark SYSVOL as authoritative.
>
> For more information, see Microsoft KB article [249694](https://support.microsoft.com/kb/249694).

If the time of the occurrence of the failure is unknown, investigate further to identify backups that hold the last safe state of the forest. This approach is less desirable. Therefore, we strongly recommend that you keep detailed logs about the health state of AD DS on a daily basis so that, if there is a forest-wide failure, the approximate time of failure can be identified. You should also keep a local copy of backups to enable faster recovery.

If Active Directory Recycle Bin is enabled, the backup lifetime is equal to the **deletedObjectLifetime** value or the **tombstoneLifetime** value, whichever is less. For more information, see [Active Directory Recycle Bin Step-by-Step Guide](https://go.microsoft.com/fwlink/?LinkId=178657) (https://go.microsoft.com/fwlink/?LinkId=178657).

As an alternative, you can also use the Active Directory database mounting tool (Dsamain.exe) and a Lightweight Directory Access Protocol (LDAP) tool, such as Ldp.exe or Active Directory Users and Computers, to identify which backup has the last safe state of the forest. The Active Directory database mounting tool, which is included in Windows Server 2008 and later Windows Server operating systems, exposes Active Directory data that is stored in backups or snapshots as an LDAP server. Then, you can use an LDAP tool to browse the data. This approach has the advantage of not requiring you to restart any DC in Directory Services Restore Mode (DSRM) to examine the contents of the backup of AD DS.

For more information about using the Active Directory database mounting tool, see the [Active Directory Database Mounting Tool Step-by-Step Guide](https://technet.microsoft.com/library/cc753609\(WS.10\).aspx).

You can also use the **ntdsutil snapshot** command to create snapshots of the Active Directory database. By scheduling a task to periodically create snapshots, you can obtain additional copies of the Active Directory database over time. You can use these copies to better identify when the forest-wide failure occurred and then choose the best backup to restore. To create snapshots, use the version of **ntdsutil** that ships with Windows Server 2008 or the Remote Server Administration Tools (RSAT) for Windows Vista or later. The target DC can run any version of Windows Server. For more information about using the **ntdsutil snapshot** command, see [Snapshot](https://technet.microsoft.com/library/cc731620\(WS.10\).aspx).

## Determining which domain controllers to restore

Ease of the restore process is an important factor when deciding which domain controller to restore. It is recommended to have a dedicated DC for each domain that is the preferred DC for a restore. A dedicated restore DC makes it easier to reliably plan and execute the forest recovery because you use the same source configuration that was used to perform restore tests. You can script the recovery, and not contend with different configurations, such as whether the DC holds operations master roles or not, or whether it is a GC or DNS server or not.

> [!NOTE]
> While it is not recommended to restore an operations master role holder in the interest of simplicity, some organizations may choose to restore one for other advantages. For example restoring the RID master may help prevent problems with managing RIDs during the recovery.  

Choose a DC that best meets the following criteria:

- A DC that is writeable. This is mandatory.

- A DC running Windows Server 2012 as a virtual machine on a hypervisor that supports VM-GenerationID. This DC can be used as a source for cloning.
- A DC that is accessible, either physically or on a virtual network, and preferably located in a datacenter. This way, you can easily isolate it from the network during forest recovery.
- A DC that has a good full server backup. A good backup is a backup that can be restored successfully, was taken a few days before the failure, and contains as much useful data as possible.
- A DC that was a Domain Name System (DNS) server before the failure. This saves the time required to reinstall DNS.
- If you also use Windows Deployment Services, choose a DC that is not configured to use BitLocker Network Unlock. In this case, BitLocker Network Unlock is not supported to be used for the first DC that you restore from backup during a forest recovery.

   BitLocker Network Unlock as the *only* key protector *cannot* be used on DCs where you have deployed Windows Deployment Services (WDS) because doing so results in a scenario where the first DC requires Active Directory and WDS to be working in order to unlock. But before you restore the first DC, Active Directory is not yet available for WDS, so it cannot unlock.

   To determine if a DC is configured to use BitLocker Network Unlock, check that a Network Unlock certificate is identified in the following registry key:

   HKEY_LOCAL_MACHINESoftwarePoliciesMicrosoftSystemCertificatesFVE_NKP

Maintain security procedures when handling or restoring backup files that include Active Directory. The urgency that accompanies forest recovery can unintentionally lead to overlooking security best practices. For more information, see the section titled “Establishing Domain Controller Backup and Restore Strategies” in [Best Practice Guide for Securing Active Directory Installations and Day-to-Day Operations: Part II](https://technet.microsoft.com/library/bb727066.aspx).

## Identify the current forest structure and DC functions

Determine the current forest structure by identifying all the domains in the forest. Make a list of all of the DCs in each domain, particularly the DCs that have backups, and virtualized DCs which can be a source for cloning. A list of DCs for the forest root domain will be the most important because you will recover this domain first. After you restore the forest root domain, you can obtain a list of the other domains, DCs, and the sites in the forest by using Active Directory snap-ins.

Prepare a table that shows the functions of each DC in the domain, as shown in the following example. This will help you revert back to the pre-failure configuration of the forest after recovery.

|DC name|Operating system|FSMO|GC|RODC|Backup|DNS|Server Core|VM|VM-GenID|  
|-------------|----------------------|----------|--------|----------|------------|---------|-----------------|--------|---------------|  
|DC_1|Windows Server 2012|Schema master, Domain naming master|Yes|No|Yes|No|No|Yes|Yes|  
|DC_2|Windows Server 2012|None|Yes|No|Yes|Yes|No|Yes|Yes|  
|DC_3|Windows Server 2012|Infrastructure Master|No|No|No|Yes|Yes|Yes|Yes|  
|DC_4|Windows Server 2012|PDC emulator, RID Master|Yes|No|No|No|No|Yes|No|  
|DC_5|Windows Server 2012|None|No|No|Yes|Yes|No|Yes|Yes|  
|RODC_1|Windows Server 2008 R2|None|Yes|Yes|Yes|Yes|Yes|Yes|No|  
|RODC_2|Windows Server 2008|None|Yes|Yes|No|Yes|Yes|Yes|No|  

For each domain in the forest, identify a single writeable DC that has a trusted backup of the Active Directory database for that domain. Use caution when you choose a backup to restore a DC. If the day and cause of the failure are approximately known, the general recommendation is to use a backup that was made a few days before that date.
  
In this example, there are four backup candidates: DC_1, DC_2, DC_4, and DC_5. Of these backup candidates, you restore only one. The recommended DC is DC_5 for the following reasons:  

- It satisfies requirements for using it as a source for virtualized DC cloning, that is, it runs Windows Server 2012 as a virtual DC on a hypervisor that supports VM-GenerationID, runs software that is allowed to be cloned (or that can be removed if it is not able to be cloned). After the restore, the PDC emulator role will be seized to that server and it can be added to the Cloneable Domain Controllers group for the domain.  
- It runs a full installation of Windows Server 2012. A DC that runs a Server Core installation can be less convenient as a target for recovery.  
- It is a DNS server. Therefore, DNS does not have to be reinstalled.  

> [!NOTE]
> Because DC_5 is not a global catalog server, it also has an advantage in that the global catalog does not need to be removed after the restore. But whether or not the DC is also a global catalog server is not a decisive factor because beginning with Windows Server 2012, all DCs are global catalog servers by default, and removing and adding the global catalog after the restore is recommended as part of the forest recovery process in any case.  

## Recover the forest in isolation

The preferred scenario is to shut down all writeable DCs before the first restored DC is brought back into production. This ensures that any dangerous data does not replicate back into the recovered forest. It is particularly important to shut down all operations master role holders.  

> [!NOTE]
> There may be cases where you move the first DC that you plan to recover for each domain to an isolated network while allowing other DCs to remain online in order to minimize system downtime. For example, if you are recovering from a failed schema upgrade, you may choose to keep domain controllers running on the production network while you perform recovery steps in isolation.

If you are running virtualized DCs, you can move them to a virtual network that is isolated from the production network where you will perform recovery. Moving virtualized DCs to a separate network provides two benefits:  

- Recovered DCs are prevented from reoccurrence of the problem that caused the forest recovery because they are isolated.  
- Virtualized DC cloning can be performed on the separate network so that a critical number of DCs can be running and tested before they are brought back to the production network.

If you are running DCs on physical hardware, disconnect the network cable of the first DC that you plan to restore in the forest root domain. If possible, also disconnect the network cables of all other DCs. This prevents DCs from replicating, if they are accidentally started during the forest recovery process.  

In a large forest that is spread across multiple locations, it can be difficult to guarantee that all writeable DCs are shut down. For this reason, the recovery steps—such as resetting the computer account and krbtgt account, in addition to metadata cleanup—are designed to ensure that the recovered writeable DCs do not replicate with dangerous writeable DCs (in case some are still online in the forest).  
  
However, only by taking writeable DCs offline can you guarantee that replication does not occur. Therefore, whenever possible, you should deploy remote management technology that can help you to shut down and physically isolate the writeable DCs during forest recovery.  
  
RODCs can continue to operate while writeable DCs are offline. No other DC will directly replicate any changes from any RODC—especially, no Schema or Configuration container changes—so they do not pose the same risk as writeable DCs during recovery. After all the writeable DCs are recovered and online, you should rebuild all the RODCs.  
  
RODCs will continue to allow access to local resources that are cached in their respective sites while the recovery operations are going on in parallel. Local resources that are not cached on the RODC will have authentication requests forwarded to a writeable DC. These requests will fail because writeable DCs are offline. Some operations such as password changes will also not work until you recover writeable DCs.  
  
If you are using a hub-and-spoke network architecture, you can concentrate first on recovering the writeable DCs in the hub sites. Later, you can rebuild the RODCs in remote sites.  
  
## Next Steps

- [AD Forest Recovery - Prerequisites](AD-Forest-Recovery-Prerequisties.md)  
- [AD Forest Recovery - Devising a custom forest recovery plan](AD-Forest-Recovery-Devising-a-Plan.md)  
- [AD Forest Recovery - Identify the problem](AD-Forest-Recovery-Identify-the-Problem.md)
- [AD Forest Recovery - Determine how to recover](AD-Forest-Recovery-Determine-how-to-Recover.md)
- [AD Forest Recovery - Perform initial recovery](AD-Forest-Recovery-Perform-initial-recovery.md)  
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)  
- [AD Forest Recovery - Frequently Asked Questions](AD-Forest-Recovery-FAQ.md)  
- [AD Forest Recovery - Recovering a Single Domain within a Multidomain Forest](AD-Forest-Recovery-Single-Domain-in-Multidomain-Recovery.md)  
- [AD Forest Recovery - Forest Recovery with Windows Server 2003 Domain Controllers](AD-Forest-Recovery-Windows-Server-2003.md)  
