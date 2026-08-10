---
title: Database 32k pages for Active Directory on Windows Server
description: Learn about Database 32k page optional feature for Active Directory Domain Services and Active Directory Lightweight Domain Services on Windows Server.
author: robinharwood
ms.author: roharwoo
ms.date: 10/25/2024
ms.topic: concept-article
#customer intent: As an Active Directory administrator, I want to learn about the Database 32k pages feature in Active Directory Domain Services, so that I can improve scalability.
---

# Database 32k pages for Active Directory




Active Directory Domain Services (AD DS) and Lightweight Directory Services (LDS) uses an [Extensible Storage Engine (ESE) database](/windows/win32/extensible-storage-engine/extensible-storage-engine-files). Since its introduction in Windows 2000, ESE used an 8k page database size, this architecture limited the scale of forest and domain objects. A 32k page database format offers an improvement in scalability using 64-bit [Long Value IDs](/windows/win32/extensible-storage-engine/long-value-columns) (LIDs). Multi-valued attributes are now able to hold approximately 3,200 values. For more information about Active Directory's scalability, see [Active Directory Maximum Limits - Scalability](/previous-versions/windows/it-pro/windows-server-2003/cc756101%28v=ws.10%29).

To learn more about the ESE database, see [ESE Deep Dive: Part 1: The Anatomy of an ESE database](https://techcommunity.microsoft.com/t5/ask-the-directory-services-team/ese-deep-dive-part-1-the-anatomy-of-an-ese-database/ba-p/400496).

Beginning with Windows Server 2025, new installs of Active Directory Domain Services (AD DS) and Lightweight Directory Services (LDS) use a 32k page database format.

New AD forest, domains, or LDS instances are installed with a 32k page capable database but use an 8k page simulation mode for compatibility with earlier AD DS and LDS instances. Moving to a 32k database page-size is a forest-wide operation and requires that all domain controllers in the forest have a 32k page capable database.

> [!IMPORTANT]
> Domain controllers that have had a Feature Update, also known as an in-place upgrade, continue to their current 8K page database format and pages.

## Requirements

Before you can enable the _Database 32k pages optional feature_ in your Active Directory Domain Services, your environment needs to meet the following requirements.

- Your Active Directory forest and domain is operational and free from replication errors. To learn more about replication errors, see [Diagnose Active Directory replication failures](/troubleshoot/windows-server/active-directory/diagnose-replication-failures).
- All domain controllers are running Windows Server 2025 or later, and have a 32k page capable database.
- Domain and forest functional levels are upgraded to Windows Server 2025 or later. To learn more about raising the functional levels, see [Raise Active Directory domain and forest functional levels](/troubleshoot/windows-server/active-directory/raise-active-directory-domain-forest-functional-levels).
- Identify all your DCs hosting the Global Catalog (GC) and FSMO roles. Create and verify backups of these Active Directory Domain Services domain controllers before making changes.
- Validate your backup software is compatible with the 32k page database format by backing up and restoring a 32k page capable database in a test environment.

## Considerations

When you create a backup of an AD database, the page size of the database is preserved on a backup media. Before Windows Server 2025, all backup media used 8k-page databases, which was the only page size supported. However, a server running Windows Server 2025 or later might have either an 8k or 32k page database format in 8k page simulation mode. For example, a Windows Server 2025 machine might have an 8K page database if it was in-place upgraded from an earlier version. It might have a 32k page database format in 8k page simulation mode if it was:

- Installed as a new DC in a Windows Server 2025 forest.
- Promoted to a DC over-the-wire. For example, promoted as a new replica.
- Restored from a 32k page database format backup image.

Before you enable the Database 32k pages optional feature, you can use either 8k or 32k page database format backup media to restore a Windows Server 2025 domain controller. After you enable the Database 32k pages optional feature, you can only use 32k page database format backup media to restore a Windows Server 2025 domain controller. You should also consider that enabling the larger 32k page sizes can affect server performance due to increased memory usage.

> [!WARNING]
> Once you have enabled the Database 32k pages optional feature, you can't revert back to the previous 8k page simulation mode. As a result, any 8k-page backup media created prior to enabling the feature will be unusable unless you perform a complete authoritative forest recovery.

## Next steps

To enable the Database 32k pages optional feature in your forest or domain, see [Enable Database 32k pages optional feature in Active Directory Domain Services](enable-32k-pages-optional-feature.md).
