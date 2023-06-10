---
title: Active Directory Forest Recovery - Procedures
description: This section contains procedures related to the forest recovery process. The following is a list of procedures that are used in backing up and restoring domain controllers and Active Directory.
ms.author: inhenkel
author: IngridAtMicrosoft
ms.date: 06/09/2023
ms.topic: article
---

# Active Directory Forest Recovery - Procedures

> Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2 and 2012

This section contains procedures related to the forest recovery process.

The following is a list of procedures that are used in backing up and restoring
domain controllers and Active Directory.

- [Backing up a full server](ad-forest-recovery-backing-up-a-full-server.md)
- [Backing up the System State data](ad-forest-recovery-backing-up-system-state.md)
- [Performing a full server recovery](ad-forest-recovery-perform-a-full-recovery.md)
- [Performing an authoritative synch of DFSR-replicated SYSVOL](ad-forest-recovery-authoritative-recovery-sysvol.md)
- [Performing a nonauthoritative restore of Active Directory Domain Services](ad-forest-recovery-nonauthoritative-restore.md)

These steps explain how to perform an authoritative restore of SYSVOL at the
same time.

- [Configuring the DNS Server service](ad-forest-recovery-configure-dns.md)
- [Removing the global catalog](ad-forest-recovery-remove-gc.md)
- [Raising the value of available RID pools](ad-forest-recovery-raise-rid-pool.md)
- [Invalidating the current RID pool](ad-forest-recovery-invaildate-rid-pool.md)
- [Seizing an operations master role](ad-forest-recovery-seizing-operations-master-role.md)
- [Cleaning up after a restore](ad-forest-recovery-cleanup.md)
- [Cleaning metadata of removed writable domain controllers](ad-forest-recovery-cleaning-metadata.md)
- [Resetting the computer account password of the domain controller](ad-forest-recovery-reset-computer-account-dc.md)
- [Resetting the krbtgt password](ad-forest-recovery-resetting-the-krbtgt-password.md)
- [Resetting a trust password on one side of the trust](ad-forest-recovery-reset-trust.md)
- [Adding the global catalog](ad-forest-recovery-add-gc.md)
- [Resources to verify replication is working](ad-forest-recovery-verify-replication.md)

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]
