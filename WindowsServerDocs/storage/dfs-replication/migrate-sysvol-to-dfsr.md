---
description: Learn how to migrate SYSVOL replication to DFS Replication by creating a new domain name or by upgrading an existing domain.
title: Migrate SYSVOL replication to DFS Replication
ms.date: 04/25/2023
author: JasonGerend
manager: elizapo
ms.author: jgerend
ms.topic: conceptual
---

# Migrate SYSVOL replication to DFS Replication

>**Applies To:** Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008

Domain controllers use a special shared folder named SYSVOL to replicate sign-in scripts and Group Policy object files to other domain controllers. Windows 2000 Server and Windows Server 2003 use the File Replication Service (FRS) to replicate SYSVOL. Windows Server 2008 uses the newer Distributed File System Replication (DFS Replication) service for domains that use the Windows Server 2008 domain functional level. Windows Server 2008 uses FRS for domains that run older domain functional levels.

To use DFS Replication to replicate the SYSVOL folder, you can create a new domain that uses the Windows Server 2008 domain functional level. You can also use the procedure described in this article to upgrade an existing domain and migrate replication to DFS Replication.

## Prerequisites

This article assumes you have a basic knowledge of Active Directory Domain Services (AD DS), FRS, and Distributed File System Replication (DFS Replication). For more information, see:

- [Active Directory Domain Services overview](/previous-versions/orphan-topics/ws.11/cc731053(v=ws.11))
- [FRS overview](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754297(v=ws.11))
- [Overview of DFS Replication](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc771058(v=ws.11))

## Printable download

To download a printable version of this guide, go to [SYSVOL Replication Migration Guide: FRS to DFS Replication](https://go.microsoft.com/fwlink/?LinkId=150375).

## Migration topics

The SYSVOL migration guide provides topics that describe a range of concepts and procedures from the use of FRS to the use DFS. Use the following list to access articles about migrating the SYSVOL folder to use DFS Replication.

### Concepts

Review these concepts about SYSVOL migration states for a basic understanding of the migration tasks.

- [SYSVOL migration conceptual information](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd640170(v=ws.10))
- [SYSVOL migration states](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd641052(v=ws.10))
- [Overview of the SYSVOL migration procedure](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd639809(v=ws.10))

### Procedures

Follow these SYSVOL migration procedures for a basic understanding of the migration states.

- [SYSVOL migration procedure](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd639860(v=ws.10))
- [Migrating to the Prepared state](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd641193(v=ws.10))
- [Migrating to the Redirected state](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd641340(v=ws.10))
- [Migrating to the Eliminated state](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd640254(v=ws.10))

### Troubleshooting

Access these articles that describe known issues and provide troubleshooting guidance.

- [Troubleshooting SYSVOL migration](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd640395(v=ws.10))
- [Troubleshooting SYSVOL migration issues](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd639976(v=ws.10))
- [Rolling back SYSVOL migration to a previous stable state](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd640509(v=ws.10))

### References

The following resources offer supplemental reference information:

- [SYSVOL migration reference information](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd640293(v=ws.10))
- [Supported SYSVOL migration scenarios](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd639854(v=ws.10))
- [Verifying the state of SYSVOL migration](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd639789(v=ws.10))
- [Dfsrmig](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd641227(v=ws.10))
- [SYSVOL migration tool actions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd639712(v=ws.10))

## Related links

- [SYSVOL Migration Series: Part 1 – Introduction to the SYSVOL migration process](https://techcommunity.microsoft.com/t5/storage-at-microsoft/sysvol-migration-series-part-1-8211-introduction-to-the-sysvol/ba-p/423456)
- [SYSVOL Migration Series: Part 2 – Dfsrmig.exe: The SYSVOL migration tool](https://techcommunity.microsoft.com/t5/storage-at-microsoft/sysvol-migration-series-part-2-8211-dfsrmig-exe-the-sysvol/ba-p/423470)
- [SYSVOL Migration Series: Part 3 - Migrating to the 'PREPARED' state](https://techcommunity.microsoft.com/t5/storage-at-microsoft/sysvol-migration-series-part-3-migrating-to-the-prepared-state/ba-p/423503)
- [SYSVOL Migration Series: Part 4 – Migrating to the 'REDIRECTED' state](https://techcommunity.microsoft.com/t5/storage-at-microsoft/sysvol-migration-series-part-4-8211-migrating-to-the-8216/ba-p/423514)
- [SYSVOL Migration Series: Part 5 – Migrating to the 'ELIMINATED' state](https://techcommunity.microsoft.com/t5/storage-at-microsoft/sysvol-migration-series-part-5-8211-migrating-to-the-8216/ba-p/423516)
- [Distributed File System step-by-step guide for Windows Server 2008](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732863(v=ws.10))
- [FRS technical reference](/previous-versions/windows/it-pro/windows-server-2003/cc759297(v=ws.10))
