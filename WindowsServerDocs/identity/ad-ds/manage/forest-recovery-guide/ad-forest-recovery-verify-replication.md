---
title: AD Forest Recovery - Verify Replication
description: Learn more about resources to verify replication.
ms.topic: article
ms.author: daveba
author: iainfoulds
ms.date: 06/21/2023
ms.custom: inhenkel
---

# Active Directory Forest Recovery - Verify Replication

Applies to: Windows Server (All supported versions)

After you've restored or reinstalled all domain controllers (DCs), you can verify that AD DS, and the sysvol folder has recovered and is replicating correctly by using `repadmin /replsum`. `repadmin /replsum` runs on any version of Windows Server.

> [!TIP]
> You can also download and run the [Active Directory Replication Status Tool](/troubleshoot/windows-server/identity/get-use-active-directory-replication-status-tool), a free tool that monitors replication status of DCs and reports errors. ADReplStatus requires .NET Framework 4, which will be installed if it isn't already present.

Check the DFS Replication event logs for Event ID 4602 (or File Replication Service event ID 13516). This log event indicates sysvol replication has been initialized.

If the first recovered DC has Event ID 4614 in the DFS Replication log (“the domain controller is waiting to perform initial replication"), the replicated folder remains in the initial synchronization state until it has replicated with its partner. If Event ID 4602 doesn't appear, you need to perform the following manual steps to recover the sysvol folder if it's replicated using DFSR.

1. If DFSR Event 4612 appears on the first restored DC, perform a manual authoritative restore as described in [2218556: How to force authoritative and nonauthoritative synchronization for DFSR-replicated sysvol replication)](https://support.microsoft.com/kb/2218556).
1. Set **SysvolReady Flag** to 1 manually, as described in [947022 The NETLOGON share isn't present after you install Active Directory Domain Services on a new full or read-only Windows Server 2008-based domain controller](https://support.microsoft.com/kb/947022).

You can also create a diagnostic report DFS Replication. For more information, see [Create a Diagnostic Report for DFS Replication](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754227(v=ws.11)) and [DFS Step-by-Step Guide for Windows Server 2008](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754227(v=ws.11)). If the server is running Windows Server 2008 R2, you can use [dfsrdiag.exe ReplicationState command line switch](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754227(v=ws.11)).

You can also run the Replications test using dcdiag.exe to check for replication errors. For more information, see Knowledge Base [Active Directory replication error 8452 - Windows Server](/troubleshoot/windows-server/identity/replication-error-8452).

## Next steps

[!INCLUDE [ad-forest-recovery-guide-links](includes/ad-forest-recovery-guide-links.md)]