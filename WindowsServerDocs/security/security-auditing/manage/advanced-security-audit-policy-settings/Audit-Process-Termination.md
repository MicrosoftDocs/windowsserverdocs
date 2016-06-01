---
title: Audit Process Termination
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a6dd8455-a41e-4f64-983b-d956b9e516a9
---
# Audit Process Termination
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Process Termination**, which determines whether the operating system generates audit events when an attempt is made to end a process.

Success audits record successful attempts and Failure audits record unsuccessful attempts.

If you do not configure this policy setting, no audit event is generated when a process ends.

This policy setting can help you track user activity and understand how the computer is used.

Event volume: Varies, depending on how the computer is used

Default: Not configured

If this policy setting is configured, the following event appears on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------------|-----------------|
|4689|A process has exited.|

## Related resource
[Advanced Security Audit Policy Settings](Advanced-Security-Audit-Policy-Settings.md)


