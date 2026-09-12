---
title: Enable SAM Client Event Logging in Windows
description: Learn how to enable Security Account Manager (SAM) client event logging and tracing to diagnose SAM client activity in Windows 11.
ms.topic: how-to
author: robinharwood
ms.author: roharwoo
ms.reviewer: sanaray
ms.date: 07/16/2026
#customer intent: As a Windows administrator, I want to understand and enable SAM client event logging, so that I can troubleshoot domain controller performance issues and identify sources of excessive SAM traffic.
ai-usage: ai-assisted
---

# Enable SAM client logging and diagnostics

Security Account Manager (SAM) client event logging is a diagnostic capability in Windows that helps identify sources of excessive SAM traffic that can cause domain controller high central processing unit (CPU) usage and authentication delays. It records SAM client operations, such as account lookups and domain enumeration, through a dedicated event log channel.

When you troubleshoot an overloaded domain controller, you need to know which clients are generating the SAM traffic behind it. Enabling SAM client event logging pinpoints the processes, services, and executables responsible and reveals unexpected usage patterns, so you can target the actual source instead of guessing.

In this article, you enable and disable the SAM client event log, configure its logging options, and review the events it records and where to find them.

## Prerequisites

- Windows 11 with the [2026-06 Security Update (KB5095093)](https://support.microsoft.com/help/5095093) or later
- Administrator or equivalent access to the Windows system.

## Enable the SAM client event log

The SAM client event logging feature uses a dedicated event log channel that records SAM client operations in a consistent, administrator-friendly format.

To help protect potentially sensitive diagnostic data, only users with appropriate administrative privileges can enable the feature and access the resulting logs.

The SAM client event log records activity from any Windows system that generates SAM traffic toward a domain controller. This activity includes client and server stock keeping units (SKUs) and both domain-joined and non-domain-joined systems.

To enable SAM client logging, follow these steps:

1. Select the **Start** button, type **Event Viewer**, and open **Event Viewer** from the best match list.

1. In Event Viewer, go to **Applications and Services Logs** > **Microsoft** > **Windows** > **SAMLIB**.

1. Select and hold (or right-click) **Debug**, and then select **Enable Log**.

   :::image type="content" source="media/enable-sam-client-logging-diagnostics/enable-samlib-debug-log.png" alt-text="Screenshot of Event Viewer showing the SAMLIB Debug log with the Enable Log option highlighted in the context menu." lightbox="media/enable-sam-client-logging-diagnostics/enable-samlib-debug-log.png":::

When you enable the SAM client event log, it records operations such as connections, handle operations, domain lookups, and enumeration requests.

To stop logging, repeat these steps and select **Disable Log** in step 3.

## Review SAM client events

SAM client events record the operation and the process responsible for the call. The following table summarizes the common event IDs in the SAM client event log (the **SAMLIB** > **Debug** channel in Event Viewer).

| Event ID | Operation | Event text | Description |
|----------|-----------|------------|-------------|
| 1000 | `SamConnect` | SamConnect called:<br>ServerName: `<server>`<br>DesiredAccess: `<access>`<br>Calling process: `<process>` | Indicates a client connecting to a SAM server. Captures the target server and calling process. |
| 1002 | `SamCloseHandle` | SamCloseHandle called:<br>SamHandle: `<handle>`<br>Calling process: `<process>` | Records cleanup of SAM handles. Useful for validating proper client behavior. |
| 1010 | `SamLookupDomainInSamServer` | SamLookupDomainInSamServer called:<br>ServerHandle: `<handle>`<br>Name: `<name>`<br>Calling process: `<process>` | Records domain lookup operations. Useful when correlating name resolution and lookup behavior. |
| 1012 | `SamEnumerateDomainsInSamServer` | SamEnumerateDomainsInSamServer called:<br>ServerHandle: `<handle>`<br>PreferredMaximumLength: `<length>`<br>Calling process: `<process>` | Indicates enumeration of available domains. Often appears during group or account queries. |
| 1014 | `SamOpenDomain` | SamOpenDomain called:<br>ServerHandle: `<handle>`<br>DesiredAccess: `<access>`<br>DomainId: `<domain ID>`<br>Calling process: `<process>` | Indicates that a client opens a domain handle. Helps identify access patterns and permission-related activity. |
| 1100 | `SamGetCompatibilityMode` | SamGetCompatibilityMode called:<br>Handle: `<handle>`<br>Calling process: `<process>` | Records the compatibility checks the client performs. Useful for understanding client behavior during initialization. |

Use these events to correlate process-level activity with observed behavior on domain controllers. The following screenshot shows an example of Event 1000 (SamConnect) in Event Viewer, including the server name, desired access, and calling process.

:::image type="complex" source="media/enable-sam-client-logging-diagnostics/sam-event-1000-samconnect.png" alt-text="Screenshot of Event Viewer showing Event 1000 for SAMLIB with SamConnect details." lightbox="media/enable-sam-client-logging-diagnostics/sam-event-1000-samconnect.png":::
   The Event 1000 properties show: SamConnect called, ServerName (blank for local), DesiredAccess 0x30, and the calling process path (for example, `C:\Windows\system32\lsass.exe`). The Log Name is Microsoft-Windows-SAMLIB/Debug, Source is SAMLIB, and Level is Information.
:::image-end:::

## Manage command-line argument logging

By default, SAM client events identify the calling executable but omit command-line arguments. This default behavior protects against inadvertent exposure of sensitive data. For advanced scenarios, you can enable command-line argument logging by using a registry key.

> [!CAUTION]
> Because command-line arguments can contain sensitive information such as credentials or user data, enable this setting only when necessary for targeted diagnostics and disable it immediately after data collection.

To enable command-line argument logging, follow these steps:

1. Open Registry Editor.

1. Go to `HKEY_LOCAL_MACHINE\SYSTEM\CurrentControlSet\Control\SAMLIB`.

1. Set the `IncludeArguments` `REG_DWORD` value to `1` to enable command-line argument logging.

   :::image type="content" source="media/enable-sam-client-logging-diagnostics/samlib-includearguments-registry.png" alt-text="Screenshot of Registry Editor showing the SAMLIB registry key with the IncludeArguments REG_DWORD value set to 0." lightbox="media/enable-sam-client-logging-diagnostics/samlib-includearguments-registry.png":::

1. To disable command-line argument logging, set `IncludeArguments` back to `0`.

After you change the registry value, restart the computer for the new setting to take effect.

The following table summarizes the `IncludeArguments` registry value behavior:

| Value | Behavior |
|-------|----------|
| `0` (default) | Events show the calling process without command-line arguments. |
| `1` | Events include the full command line of the calling process. |

## Related content

- [Security Account Manager Remote (SAMR) protocol](/openspecs/windows_protocols/ms-samr/96952411-1d17-4fe4-879c-d5b48a264314)
