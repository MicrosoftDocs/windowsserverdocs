---
title: Audit Special Logon
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4825b27c-4720-4512-85ae-75c860f31ce1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit Special Logon

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Special Logon**, which determines whether the operating system generates audit events under special sign on (or log on) circumstances.

This security policy setting determines whether the operating system generates audit events when:

-   A special logon is used. A special logon is a logon that has administrator-equivalent privileges and can be used to elevate a process to a higher level.

-   A member of a special group logs on. Special Groups is a Windows feature that enables the administrator to find out when a member of a certain group has logged on. The administrator can set a list of group security identifiers (SIDs) in the registry. If any of these SIDs is added to a token during logon and this auditing subcategory is enabled, a security event is logged. For more information about this feature, see [article 947223](http://go.microsoft.com/fwlink/?LinkID=120183) in the Microsoft Knowledge Base (http://go.microsoft.com/fwlink/?LinkID=120183).

Users holding special privileges can potentially make changes to the system. We recommend that you track their activity.

Event volume: Low

Default: Success

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------|---------|
|4964|Special groups have been assigned to a new logon.|

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)


