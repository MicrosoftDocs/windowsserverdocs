---
title: Audit File Share
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: da7fe64e-cbd1-43ab-8fe5-25f310385727
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit File Share

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit File Share**, which determines whether the operating system generates audit events when a file share is accessed.

Audit events are not generated when shares are created, deleted, or when share permissions change.

> [!NOTE]
> There are no system access control lists (SACLs) for shares; therefore, after this setting is enabled, access to all shares on the system will be audited.

Combined with File System auditing, File Share auditing enables you to track what content was accessed, the source (IP address and port) of the request, and the user account that was used for the access.

Event volume: High on a file server or domain controller (due to SYSVOL access by client computers for policy processing)

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the  **Applies to** list at the beginning of this topic, unless noted below.

|Event ID|Event message|
|------|---------|
|5140|A network share object was accessed. **Note:** This event is logged on computers running  Windows Server 2008 R2 , Windows Server 2008,  Windows 7 , or Windows Vista.|
|5142|A network share object was added.|
|5143|A network share object was modified.|
|5144|A network share object was deleted.|
|5168|SPN check for SMB/SMB2 failed.|

## Related resource
[Advanced Security Audit Policy Settings](../advanced-security-audit-policy-settings.md)


