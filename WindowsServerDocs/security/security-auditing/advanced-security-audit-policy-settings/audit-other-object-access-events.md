---
title: Audit Other Object Access Events
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a162c175-3475-49bf-8b6a-697749b83e27
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit Other Object Access Events

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Other Object Access Events**, which determines whether the operating system generates audit events for the management of Task Scheduler jobs or COM+ objects.

For scheduler jobs, the following actions are audited:

-   Job created.

-   Job deleted.

-   Job enabled.

-   Job disabled.

-   Job updated.

For COM+ objects, the following actions are audited:

-   Catalog object added.

-   Catalog object updated.

-   Catalog object deleted.

Event volume: Low

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------|---------|
|4671|An application attempted to access a blocked ordinal through the TBS.|
|4691|Indirect access to an object was requested.|
|4698|A scheduled task was created.|
|4699|A scheduled task was deleted.|
|4700|A scheduled task was enabled.|
|4701|A scheduled task was disabled.|
|4702|A scheduled task was updated.|
|5148|The Windows Filtering Platform has detected a DoS attack and entered a defensive mode; packets associated with this attack will be discarded. **Note:** This event is logged only on computers running the supported versions of the Windows operating system.|
|5149|The DoS attack has subsided and normal processing is being resumed. **Note:** This event is logged only on computers running the supported versions of the Windows operating system.|
|5888|An object in the COM+ Catalog was modified.|
|5889|An object was deleted from the COM+ Catalog.|
|5890|An object was added to the COM+ Catalog.|

## Related resource
[Advanced Security Audit Policy Settings](../advanced-security-audit-policy-settings.md)


