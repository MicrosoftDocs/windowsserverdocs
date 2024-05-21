---
title: 32k pages for Active Directory Domain Services on Windows Server
description: Learn about 32k page optional feature for Active Directory Domain Services and Active Directory Lightweight Domain Services on Windows Server.
author: gswashington
ms.author: wscontent
ms.date: 05/21/2024
ms.topic: conceptual
#customer intent: As an Active Directory administrator, I want to learn about the 32k pages feature in Active Directory Domain Services, so that I can improve scalability.
---

# 32K pages in Active Directory Domain Services and Active Directory Lightweight Domain Services (preview)

Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016

> [!IMPORTANT]
> Windows Server 2025 is in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Beginning with Windows Server 2025, new Active Directory Domain Services (AD DS) and Lightweight Directory Services (LDS) installs use a 32K page database. 

Domain Services (AD DS) and Lightweight Directory Services (LDS) uses an Extensible Storage Engine (ESE) database. Since its introduction in Windows 2000 ESE used an 8k database page size, this architecture limited the scale of forest and domain objects. A 32K database page format offers an improvement in scalability using 64-bit Long Value IDs (LIDs). AD objects using multi-valued attributes are now able to hold approximately 3,200 values, which is an increase by a factor of 2.6. For more information about the Active Directory's scalability, see [Active Directory Maximum Limits - Scalability](/previous-versions/windows/it-pro/windows-server-2003/cc756101%28v=ws.10%29).

New domain controllers, or application directory partitions for LDS, are installed with a 32k page database but use an 8k page mode for compatibility with earlier versions. Moving to a 32k database page-size is a forest-wide operation and requires that all domain controllers in the forest have a 32k page capable database.

> [!NOTE]
> An upgraded domain controller continues to use its current 8K database format and pages.

## Requirements for enabling 32k pages

Before you can enable 32k pages in your Active Directory Domain Services, you need to meet the following requirements.

- Your Active Directory forest and domain is operational and free from replication errors. To learn more about replication errors, see [Diagnose Active Directory replication failures](/troubleshoot/windows-server/active-directory/diagnose-replication-failures).
- All domain controllers are upgraded to Windows Server 2025 or later.
- Domain and forest functional levels are upgraded to Windows Server 2025 or later. To learn more about raising the functional levels, see [Raise Active Directory domain and forest functional levels](/troubleshoot/windows-server/active-directory/raise-active-directory-domain-forest-functional-levels).
- Identify all your DCs hosting the Global Catalog (GC) and FSMO roles. Create and verify backups of theses Active Directory Domain Server domain controllers before making changes.
- All applications and services that interact with Active Directory are compatible with the 32K pages feature.

## Considerations enabling 32k page feature

When you create a backup of an AD database, the page size of the database is preserved on a backup media. Before Windows Server 2025, all backup media uses 8k-page databases, which was the only page size supported. However, a server running Windows Server 2025 or later might have either an 8k or 32k-page database. For example, a Windows Server 2025 machine might have an 8K page database if it was upgraded from an earlier version. It might have a 32K page database if it was:

- Installed as a new DC in a Windows Server 2025 forest.
- Promoted to a DC over-the-wire.
- Restored from a 32k-page backup image.

Before you enable the 32k-page feature, you can use either 8k or 32k page backup media to restore a Windows Server 2025 domain controller. After you enable the 32k-page feature, you can only use 32k page backup media to restore a Windows Server 2025 domain controller. You should also consider that enabling the larger 32K page sizes can affect server performance due to increased memory usage.

> [!WARNING]
> Once you have enabled the 32k database page feature, you can't revert back to the previous 8k page mode. As a result, any 8k-page backup media created prior to enabling the feature will be unusable unless you perform a complete authoritative forest recovery.


## Next steps

To enable the 32k pages optional feature in your forest or domain, see [Enable 32k pages in Active Directory Domain Services](enable-32K-pages-optional-feature.md).
