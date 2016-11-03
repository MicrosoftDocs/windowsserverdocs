---
title: Audit Security Group Management
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: eb8718d9-fa3d-4330-bc10-6b19d7671a69
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit Security Group Management

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Security Group Management**, which determines whether the operating system generates audit events when specific security group management tasks are performed.

Tasks for security group management include:

-   A security group is created, changed, or deleted.

-   A member is added to or removed from a security group.

-   A group's type is changed.

Security groups can be used for access control permissions and also as distribution lists.

Event volume: Low

Default: Success

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------|---------|
|4727|A security-enabled global group was created.|
|4728|A member was added to a security-enabled global group.|
|4729|A member was removed from a security-enabled global group.|
|4730|A security-enabled global group was deleted.|
|4731|A security-enabled local group was created.|
|4732|A member was added to a security-enabled local group.|
|4733|A member was removed from a security-enabled local group.|
|4734|A security-enabled local group was deleted.|
|4735|A security-enabled local group was changed.|
|4737|A security-enabled global group was changed.|
|4754|A security-enabled universal group was created.|
|4755|A security-enabled universal group was changed.|
|4756|A member was added to a security-enabled universal group.|
|4757|A member was removed from a security-enabled universal group.|
|4758|A security-enabled universal group was deleted.|
|4764|A group's type was changed.|

## Related resource
[Advanced Security Audit Policy Settings](../advanced-security-audit-policy-settings.md)


