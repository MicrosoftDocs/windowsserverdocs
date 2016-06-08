---
title: Audit User Account Management
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 53dd6ff4-8706-4e7c-9082-82a80610a833
---
# Audit User Account Management
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit User Account Management**, which determines whether the operating system generates audit events when specific user account management tasks are performed.

Tasks that are audited for user account management include:

-   A user account is created, changed, deleted, renamed, disabled, enabled, locked out, or unlocked.

-   A user account password is set or changed.

-   Security identifier \(SID\) history is added to a user account.

-   The Directory Services Restore Mode password is set.

-   Permissions are changed on accounts that are members of administrator groups.

-   Credential Manager credentials are backed up or restored.

This policy setting is essential for tracking events that involve provisioning and managing user accounts.

Event volume: Low

Default: Success

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------------|-----------------|
|4720|A user account was created.|
|4722|A user account was enabled.|
|4723|An attempt was made to change an account's password.|
|4724|An attempt was made to reset an account's password.|
|4725|A user account was disabled.|
|4726|A user account was deleted.|
|4738|A user account was changed.|
|4740|A user account was locked out.|
|4765|SID History was added to an account.|
|4766|An attempt to add SID History to an account failed.|
|4767|A user account was unlocked.|
|4780|The ACL was set on accounts which are members of administrators groups.|
|4781|The name of an account was changed:|
|4794|An attempt was made to set the Directory Services Restore Mode.|
|5376|Credential Manager credentials were backed up.|
|5377|Credential Manager credentials were restored from a backup.|

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)


