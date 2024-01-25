---
title: Active Directory Forest Recovery - Performing a nonauthoritative restore of Active Directory Domain Services
description: The following procedures use the wbadmin.exe to perform a nonauthoritative restore of Active Directory or Active Directory Domain Services (AD DS). If you're using a different backup solution or if you intend to complete the authoritative restore of SYSVOL later in the forest recovery process...
perform an authoritative restore of SYSVOL by using these alternative methods:
ms.author: inhenkel
author: IngridAtMicrosoft
ms.date: 06/21/2023
ms.topic: article
---

# Active Directory Forest Recovery - Perform a nonauthoritative restore of Active Directory Domain Services

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2 and 2012

To perform a nonauthoritative restore, complete the following procedure.

The following procedures use the wbadmin.exe to perform a nonauthoritative
restore of Active Directory or Active Directory Domain Services (AD DS). If you're using a different backup solution or if you intend to complete the
authoritative restore of SYSVOL later in the forest recovery process, you can
perform an authoritative restore of SYSVOL by using these alternative methods:

- Determine if SYSVOL is replicated by FRS, see [Determining Whether a Domain Controller's SYSVOL Folder is Replicated by DFSR or FRS](/windows/win32/vss/backing-up-and-restoring-an-frs-replicated-sysvol-folder#determining_whether_a_domain_controller_s_sysvol_folder_is_replicated_by_dfsr_or_frs).
- If you're still using File Replication Service (FRS), please consider switching to Distributed File System (DFS) Replication as soon as possible.  
    If you still use FRS to replicate SYSVOL, follow the steps in [article 290762](/troubleshoot/windows-server/networking/use-burflags-to-reinitialize-frs)
    in the Microsoft Knowledge Base, using the **BurFlags** registry key to
    reinitialize FRS replica sets, or if necessary, article
    [315457](https://support.microsoft.com/kb/315457) to rebuild the SYSVOL
    tree.
- If you're using Distributed File System (DFS) Replication to replicate
    SYSVOL, see [Perform an authoritative synchronization of DFSR-replicated SYSVOL](ad-forest-recovery-authoritative-recovery-SYSVOL.md).

## Perform a nonauthoritative restore

Use the following procedure to perform a nonauthoritative restore of AD DS and
an authoritative restore of SYSVOL at the same time by using wbadmin.exe. The
backup must explicitly include system state data; a full server backup that is
used for full server recovery won't work. A Bare Metal Recovery Backup (BMR)
will contain a system state backup. For more information about creating a system
state backup, see [Backing up the System State data](ad-forest-recovery-backing-up-system-state.md).

### Perform a nonauthoritative restore of AD DS and authoritative restore of SYSVOL using wbadmin.exe**

Include the **-authsysvol** switch in your recovery command, as shown in the following example:

`wbadmin start systemstaterecovery \<otheroptions\> -authsysvol`

For example:

`wbadmin start systemstaterecovery -version:01/01/2023-13:00 -authsysvol`

:::image type="content" source="media/b81604238b4288f9fac4e3f791d82e5f.png" alt-text="Restore":::

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]
