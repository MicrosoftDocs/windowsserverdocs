---
title: SMB - File and printer sharing ports should be open
description: Learn how to keep file and printer sharing ports open for Server Message Block (SMB)-based network services and resolve the Best Practices Analyzer scan issue.
ms.date: 03/20/2023
author: JasonGerend
manager: elizapo
ms.author: jgerend
ms.topic: conceptual
---

# SMB: File and printer sharing ports should be open

> **Applies To**: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2

When a Best Practices Analyzer scan for Server Message Block (SMB)-based network services identifies that firewall ports for file and printer sharing aren't open, follow the steps in this article to resolve the issue.

| Operating system | Product/Feature | Severity | Category |
| --- | --- | --- | --- |
| Windows Server | File Services | Error | Configuration |

> [!NOTE]
> This article addresses a specific issue identified by a Best Practices Analyzer scan. Apply the information in this article only to computers that have a File Services Best Practices Analyzer scan that reports the specific port issue. For more information about best practices and scans, see [Best Practices Analyzer](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/dd759260(v=ws.11)).

## Identify the issue

A File Services Best Practices Analyzer scan reports that firewall ports necessary for file and printer sharing aren't open (ports 445 and 139).

The issue prevents computer access to shared folders and other SMB-based network services on the server.

## Resolve the issue

To resolve the issue, enable file and printer sharing to communicate through the computer's firewall. To complete the procedure, you must be a member of the **Administrators group** (or equivalent), at a minimum.

To open the firewall ports and enable file and printer sharing, complete the following steps:

1. Open Control Panel, select **System and Security**, and then select **Windows Defender Firewall**.

1. On the left, select **Advanced settings**. The Windows Defender Firewall console opens and shows the advanced settings.

1. In the Windows Defender Firewall console on the left, select **Inbound Rules**.

1. Under **Inbound Rules**, locate the following two rules:

   - **File and Printer Sharing (NB-Session-In)**
   
   - **File and Printer Sharing (SMB-In)**

1. For each rule, select and hold (or right-click) the rule, and then select **Enable Rule**.

## Related links

- [Understanding shared folders and the Windows Firewall](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc731402(v=ws.11))

<!-- Alterate path to related link -- https://technet.microsoft.com/library/cc731402.aspx -->
