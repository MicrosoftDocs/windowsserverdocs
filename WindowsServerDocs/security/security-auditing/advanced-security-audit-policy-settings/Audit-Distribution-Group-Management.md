---
title: Audit Distribution Group Management
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0e067be5-8934-49dd-9d3f-35701ecd1bca
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit Distribution Group Management

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Distribution Group Management**, which determines whether the operating system generates audit events for specific distribution-group management tasks.

Tasks for distribution-group management that can be audited include:

-   A distribution group is created, changed, or deleted.

-   A member is added to or removed from a distribution group.

This subcategory to which this policy belongs is logged only on domain controllers.

> [!NOTE]
> Distribution groups cannot be used to manage access control permissions.

Event volume: Low

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008.

|Event ID|Event message|
|------|---------|
|4744|A security-disabled local group was created.|
|4745|A security-disabled local group was changed.|
|4746|A member was added to a security-disabled local group.|
|4747|A member was removed from a security-disabled local group.|
|4748|A security-disabled local group was deleted.|
|4749|A security-disabled global group was created.|
|4750|A security-disabled global group was changed.|
|4751|A member was added to a security-disabled global group.|
|4752|A member was removed from a security-disabled global group.|
|4753|A security-disabled global group was deleted.|
|4759|A security-disabled universal group was created.|
|4760|A security-disabled universal group was changed.|
|4761|A member was added to a security-disabled universal group.|
|4762|A member was removed from a security-disabled universal group.|

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)


