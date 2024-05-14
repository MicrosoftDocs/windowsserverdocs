---
title: Active Directory DCLocator performance counters
description: Learn about Active Directory DCLocator performance counters
ms.topic: conceptual
author: gswashington
ms.author: wscontent
ms.date: 05/31/2024

---

# Active Directory DCLocator performance counters

Applies to: Windows Server 2025 (preview), Windows Server 2022, Windows Server 2019, Windows Server 2016

> [!IMPORTANT]
> Windows Server 2025 is in PREVIEW. This information relates to a prerelease product that may be substantially modified before it's released. Microsoft makes no warranties, expressed or implied, with respect to the information provided here.

Beginning with Windows Server 2025, new Active Directory Domain Services (AD DS) and Lightweight Directory Services (LDS) ....

Active Directory (AD) uses ... 

## Requirements for using Active Directory DCLocater performance counters

Before you can enable performance counters in your Active Directory Domain Services, you need to meet the following requirements.

- Your Active Directory forest and domain is operational and free from replication errors. To learn more about replication errors, see [Diagnose Active Directory replication failures](/troubleshoot/windows-server/active-directory/diagnose-replication-failures).
- All domain controllers must be upgraded to Windows Server 2025 or later.
- Domain and forest functional levels must be upgraded to Windows Server 2025 or later. To learn more about raising the functional levels, see [Raise Active Directory domain and forest functional levels](/troubleshoot/windows-server/active-directory/raise-active-directory-domain-forest-functional-levels).
- Identify all your DCs hosting the Global Catalog (GC) and FSMO roles. Create and verify backups of theses Active Directory Domain Server domain controllers before making changes.
- All applications and services that interact with Active Directory must be compatible with the 32K pages feature.

## Considerations enabling DCLocater performance counters 

When you ...

... if it was:

- Installed as a
- Promoted to a DC
- Restored from a 

Before you enable the performance counters, ... After you enable the performance counters feature, only ...  can be used to restore a Windows Server 2025 ... Enabling the ... can affect server performance due to ...

> [!WARNING]
> Once you have enabled the DCLocater performance counter feature, you can't revert back to the previous ...  mode. As a result, any ... created prior to enabling the feature will be unusable unless a complete ... is performed.

## Next steps

- 