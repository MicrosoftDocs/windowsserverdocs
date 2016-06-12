---
title: Audit Directory Service Access
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d9bb2761-6b92-40ff-8f60-572e8c65d439
---
# Audit Directory Service Access
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Directory Service Access**, which determines whether the operating system generates audit events when an Active Directory Domain Services \(AD DS\) object is accessed.

These events are similar to the Directory Service Access events in previous versions of Windows Server operating systems.

> [!IMPORTANT]
> Audit events are generated only on objects with configured system access control lists \(SACLs\), and only when they are accessed in a manner that matches the SACL settings.

Event volume: High on servers running AD DS role services; none on client computers

Default: Not configured

If this policy setting is configured, the following event appears on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008.

|Event ID|Event message|
|------------|-----------------|
|4662|An operation was performed on an object.|

## Related resource
[Advanced Security Audit Policy Settings](../advanced-security-audit-policy-settings.md)


