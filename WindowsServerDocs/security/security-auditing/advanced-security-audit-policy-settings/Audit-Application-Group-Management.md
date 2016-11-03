---
title: Audit Application Group Management
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b5a073b9-e390-4eb6-92f7-eef23233a8e9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit Application Group Management

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Application Group Management**, which determines whether the operating system generates audit events when application group management tasks are performed.

Application group management tasks include:

-   An application group is created, changed, or deleted.

-   A member is added to or removed from an application group.

Event volume: Low

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------|---------|
|4783|A basic application group was created.|
|4784|A basic application group was changed.|
|4785|A member was added to a basic application group.|
|4786|A member was removed from a basic application group.|
|4787|A non-member was added to a basic application group.|
|4788|A non-member was removed from a basic application group.|
|4789|A basic application group was deleted.|
|4790|An LDAP query group was created.|

## Related resource
[Advanced Security Audit Policy Settings](../advanced-security-audit-policy-settings.md)


