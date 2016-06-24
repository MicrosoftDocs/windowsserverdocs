---
title: Audit Directory Service Replication
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: a6200b43-51f7-422b-9c8e-c8c08d2882cf
---
# Audit Directory Service Replication
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Directory Service Replication**, which determines whether the operating system generates audit events when replication between two domain controllers begins and ends.

Event volume: Medium on domain controllers; none on client computers

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008.

|Event ID|Event message|
|------------|-----------------|
|4932|Synchronization of a replica of an Active Directory naming context has begun.|
|4933|Synchronization of a replica of an Active Directory naming context has ended.|

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)


