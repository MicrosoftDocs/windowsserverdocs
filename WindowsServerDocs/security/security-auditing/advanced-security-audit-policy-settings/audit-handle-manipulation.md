---
title: Audit Handle Manipulation
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4fb3f918-432b-4176-99f7-c4a477e9b5ee
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit Handle Manipulation

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Handle Manipulation**, which determines whether the operating system generates audit events when a handle to an object is opened or closed.

Only objects with configured system access control lists (SACLs) generate these events, and only if the attempted handle operation matches the SACL.

> [!IMPORTANT]
> Handle Manipulation events are generated only for object types where the corresponding File System or Registry Object Access subcategory is enabled. For more information, see [Audit File System](audit-file-system.md) or [Audit Registry](audit-registry.md).

Event volume: High, depending on how SACLs are configured

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------|---------|
|4656|A handle to an object was requested.|
|4658|The handle to an object was closed.|
|4690|An attempt was made to duplicate a handle to an object.|

## Related resource
[Advanced Security Audit Policy Settings](../advanced-security-audit-policy-settings.md)


