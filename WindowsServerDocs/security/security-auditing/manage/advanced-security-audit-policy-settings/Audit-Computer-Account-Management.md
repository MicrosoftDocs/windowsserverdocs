---
title: Audit Computer Account Management
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0e810ea4-a91a-44df-b5b2-8a90e6ca26b3
---
# Audit Computer Account Management
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Computer Account Management**, which determines whether the operating system generates audit events when a computer account is created, changed, or deleted.

This policy setting is useful for tracking account\-related changes to computers that are members of a domain.

Event volume: Low

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------------|-----------------|
|4741|A computer account was created.|
|4742|A computer account was changed.|
|4743|A computer account was deleted.|

## Related resource
[Advanced Security Audit Policy Settings](Advanced-Security-Audit-Policy-Settings.md)


