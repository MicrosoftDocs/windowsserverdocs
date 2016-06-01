---
title: Audit Security State Change
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eb433877-9c2f-4157-bc58-e937a8ef4176
---
# Audit Security State Change
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Security State Change**, which determines whether Windows generates audit events for changes in the security state of a system.

Changes in the security state of the operating system include:

-   System startup and shutdown.

-   Change of system time.

-   System recovery from **CrashOnAuditFail**. This event is logged after a system reboots following **CrashOnAuditFail**.

    > [!IMPORTANT]
    > Some auditable activity may not be recorded when a system reboots due to **CrashOnAuditFail**.

System startup and shutdown events are important for understanding system usage.

Event volume: Low

Default: Success

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event Message Summary|Minimum  Requirement|
|------------|-------------------------|------------------------|
|4608|Windows is starting up.|Windows Vista, Windows Server 2008|
|4609|Windows is shutting down.|Windows Vista, Windows Server 2008|
|4616|The system time was changed.|Windows Vista, Windows Server 2008|
|4621|Administrator recovered system from CrashOnAuditFail. Users who are not administrators will now be allowed to log on. Some auditable activity might not have been recorded.|Windows Vista, Windows Server 2008|

## Related resource
[Advanced Security Audit Policy Settings](Advanced-Security-Audit-Policy-Settings.md)


