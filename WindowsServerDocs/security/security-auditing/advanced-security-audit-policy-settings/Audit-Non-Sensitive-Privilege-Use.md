---
title: Audit Non-Sensitive Privilege Use
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bf26a458-5897-4408-9e25-d2a32eab8d6e
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit Non-Sensitive Privilege Use

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Non-Sensitive Privilege Use**, which determines whether the operating system generates audit events when non-sensitive privileges (user rights) are used.

The following privileges are non-sensitive:

-   **Access Credential Manager as a trusted caller**

-   **Access this computer from the network**

-   **Add workstations to domain**

-   **Adjust memory quotas for a process**

-   **Allow log on locally**

-   **Allow log on through Terminal Services**

-   **Bypass traverse checking**

-   **Change the system time**

-   **Create a page file**

-   **Create global objects**

-   **Create permanent shared objects**

-   **Create symbolic links**

-   **Deny access to this computer from the network**

-   **Deny log on as a batch job**

-   **Deny log on as a service**

-   **Deny log on locally**

-   **Deny log on through Terminal Services**

-   **Force shutdown from a remote system**

-   **Increase a process working set**

-   **Increase scheduling priority**

-   **Lock pages in memory**

-   **Log on as a batch job**

-   **Log on as a service**

-   **Modify an object label**

-   **Perform volume maintenance tasks**

-   **Profile single process**

-   **Profile system performance**

-   **Remove computer from docking station**

-   **Shut down the system**

-   **Synchronize directory service data**

If you configure this policy setting, an audit event is generated when a non-sensitive privilege is called. Success audits record successful attempts, and failure audits record unsuccessful attempts.

Event volume: Very high

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------|---------|
|4672|Special privileges assigned to new logon.|
|4673|A privileged service was called.|
|4674|An operation was attempted on a privileged object.|

## Related resource
[Advanced Security Audit Policy Settings](../advanced-security-audit-policy-settings.md)


