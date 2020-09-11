---
title: Migrate SYSVOL replication to DFS Replication
ms.date: 07/02/2012
author: JasonGerend
manager: elizapo
ms.author: jgerend
---

# Migrate SYSVOL replication to DFS Replication


Updated: August 25, 2010

Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, and Windows Server 2008

Domain controllers use a special shared folder named SYSVOL to replicate logon scripts and Group Policy object files to other domain controllers. Windows 2000 Server and Windows Server 2003 use File Replication Service (FRS) to replicate SYSVOL, whereas Windows Server 2008 uses the newer DFS Replication service when in domains that use the Windows Server 2008 domain functional level, and FRS for domains that run older domain functional levels.

To use DFS Replication to replicate the SYSVOL folder, you can either create a new domain that uses the Windows Server 2008 domain functional level, or you can use the procedure that is discussed in this document to upgrade an existing domain and migrate replication to DFS Replication.

This document assumes that you have a basic knowledge of Active Directory Domain Services (AD DS), FRS, and Distributed File System Replication (DFS Replication). For more information, see [Active Directory Domain Services Overview](https://go.microsoft.com/fwlink/?linkid=147787), [FRS Overview](https://go.microsoft.com/fwlink/?linkid=121763), or [Overview of DFS Replication](https://go.microsoft.com/fwlink/?linkid=121762)


> [!NOTE]
> To download a printable version of this guide, go to <a href="https://go.microsoft.com/fwlink/?linkid=150375">SYSVOL Replication Migration Guide: FRS to DFS Replication</a> (https://go.microsoft.com/fwlink/?LinkId=150375)
<br>


## In this guide

[SYSVOL Migration Conceptual Information](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd640170(v=ws.10))

  - [SYSVOL Migration States](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd641052(v=ws.10))

  - [Overview of the SYSVOL Migration Procedure](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd639809(v=ws.10))


[SYSVOL Migration Procedure](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd639860(v=ws.10))

  - [Migrating to the Prepared State](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd641193(v=ws.10))

  - [Migrating to the Redirected State](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd641340(v=ws.10))

  - [Migrating to the Eliminated State](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd640254(v=ws.10))


[Troubleshooting SYSVOL Migration](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd640395(v=ws.10))

  - [Troubleshooting SYSVOL Migration Issues](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd639976(v=ws.10))

  - [Rolling Back SYSVOL Migration to a Previous Stable State](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd640509(v=ws.10))


[SYSVOL Migration Reference Information](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd640293(v=ws.10))

  - [Supported SYSVOL Migration Scenarios](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd639854(v=ws.10))

  - [Verifying the State of SYSVOL Migration](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd639789(v=ws.10))

  - [Dfsrmig](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd641227(v=ws.10))

  - [SYSVOL Migration Tool Actions](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd639712(v=ws.10))


## Additional references

[SYSVOL Migration Series: Part 1 – Introduction to the SYSVOL migration process](https://techcommunity.microsoft.com/t5/storage-at-microsoft/sysvol-migration-series-part-1-8211-introduction-to-the-sysvol/ba-p/423456)

[SYSVOL Migration Series: Part 2—Dfsrmig.exe: The SYSVOL migration tool](https://techcommunity.microsoft.com/t5/storage-at-microsoft/sysvol-migration-series-part-2-8211-dfsrmig-exe-the-sysvol/ba-p/423470)

[SYSVOL Migration Series: Part 3 - Migrating to the 'PREPARED' state](https://techcommunity.microsoft.com/t5/storage-at-microsoft/sysvol-migration-series-part-3-migrating-to-the-prepared-state/ba-p/423503)

[SYSVOL Migration Series: Part 4—Migrating to the 'REDIRECTED' state](https://techcommunity.microsoft.com/t5/storage-at-microsoft/sysvol-migration-series-part-4-8211-migrating-to-the-8216/ba-p/423514)

[SYSVOL Migration Series: Part 5—Migrating to the 'ELIMINATED' state](https://techcommunity.microsoft.com/t5/storage-at-microsoft/sysvol-migration-series-part-5-8211-migrating-to-the-8216/ba-p/423516)

[Distributed File Systems Step-By-Step Guide for Windows Server 2008](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc732863(v=ws.10))

[FRS Technical Reference](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2003/cc759297(v=ws.10))
