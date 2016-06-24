---
title: Audit Sensitive Privilege Use
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9060bf88-6635-4f87-be8b-804f300be9e9
---
# Audit Sensitive Privilege Use
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Sensitive Privilege Use**, which determines whether the operating system generates audit events when sensitive privileges (user rights) are used.

Actions that can be audited include:

-   A privileged service is called.

-   One of the following privileges is called:

    -   **Act as part of the operating system**

    -   **Back up files and directories**

    -   **Create a token object**

    -   **Debug programs**

    -   **Enable computer and user accounts to be trusted for delegation**

    -   **Generate security audits**

    -   **Impersonate a client after authentication**

    -   **Load and unload device drivers**

    -   **Manage auditing and security log**

    -   **Modify firmware environment values**

    -   **Replace a process-level token**

    -   **Restore files and directories**

    -   **Take ownership of files or other objects**

If you configure this policy setting, an audit event is generated when sensitive privilege requests are made. Success audits record successful attempts, and failure audits record unsuccessful attempts.

Event volume: High

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------------|-----------------|
|4672|Special privileges assigned to new logon.|
|4673|A privileged service was called.|
|4674|An operation was attempted on a privileged object.|

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)


