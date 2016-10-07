---
title: Audit Logoff
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 3fcb715d-740b-49bc-9522-6a565526f2c3
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit Logoff

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Logoff**, which determines whether the operating system generates audit events when logon sessions are terminated.

These events occur on the computer that was accessed. In the case of an interactive logon, these events are generated on the computer that was logged on to.

> [!NOTE]
> There is no failure event in this subcategory because failed logoffs (such as when a system abruptly shuts down) do not generate an audit record.

Logon events are essential to understanding user activity and detecting potential attacks. Logoff events are not 100 percent reliable. For example, the computer can be turned off without a proper logoff and shutdown; in this case, a logoff event is not generated.

Event volume: Low

Default: Success

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------------|-----------------|
|4634|An account was logged off.|
|4647|User initiated logoff.|

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)


