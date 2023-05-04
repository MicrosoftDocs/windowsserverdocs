---
description: Learn more about performing a nonauthoritative restore of Active Directory Domain Services.
title: AD Forest Recovery - Nonauthoritative restore
ms.author: daveba
author: iainfoulds
ms.date: 04/01/2023
ms.topic: article
---
# Active Directory forest recovery and nonauthoritative restore of Active Directory Domain Services

Applies to: Windows Server (All supported versions)

The guidance in this article is intended to help you perform a nonauthoritative restore of Active Directory Domain Services.

The following procedures use the Wbadmin.exe to perform a nonauthoritative restore of Active Directory or Active Directory Domain Services (AD DS). If you're using a different backup solution or plan to complete the authoritative restore of SYSVOL later in the forest recovery process, do an authoritative restore of SYSVOL using these alternative methods:

- If you're using File Replication Service (FRS) to replicate SYSVOL, follow the steps in [article 290762](/troubleshoot/windows-server/networking/use-burflags-to-reinitialize-frs) in the Microsoft Knowledge Base, using the **BurFlags** registry key to reinitialize FRS replica sets. Alternate guidance in this [Knowledge Base article](https://support.microsoft.com/kb/315457) might also be helpful in rebuilding the SYSVOL tree. See [Determining Whether a Domain Controller's SYSVOL Folder is Replicated by DFSR or FRS](/windows/win32/vss/backing-up-and-restoring-an-frs-replicated-sysvol-folder#determining_whether_a_domain_controller_s_sysvol_folder_is_replicated_by_dfsr_or_frs) to confirm whether SYSVOL is replicated by FRS.
- See [Perform an authoritative synchronization of DFSR-replicated SYSVOL](AD-Forest-Recovery-Authoritative-Recovery-SYSVOL.md) if you're using Distributed File System (DFS) Replication to replicate SYSVOL.

## Performing a nonauthoritative restore

Use the following procedure to perform a nonauthoritative restore of AD DS. This procedure will also do a authoritative restore of SYSVOL using wbadmin.exe on a DC that runs Windows Server 2012, Windows Server 2008 R2, or Windows Server 2008. The backup must include system state data; a full server backup that's used for full server recovery won't work. See [Backing up the System State data](AD-Forest-Recovery-Backing-up-System-State.md) for more information about creating a system state backup.

### Perform a nonauthoritative restore of AD DS and authoritative restore of SYSVOL using wbadmin.exe

- Include the **-authsysvol** switch in your recovery command, as shown in the following example:

   ```
   wbadmin start systemstaterecovery <otheroptions> -authsysvol
   ```

   For example:

   ```
   wbadmin start systemstaterecovery -version:11/20/2012-13:00 -authsysvol
   ```

![Restore](media/AD-Forest-Recovery-Nonauthoritative-Restore/nonauth.png)

## Next Steps

- [AD Forest Recovery Guide](AD-Forest-Recovery-Guide.md)
- [AD Forest Recovery - Procedures](AD-Forest-Recovery-Procedures.md)
