---
title: Audit Filtering Platform Packet Drop
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f207f4e8-d0f7-4234-acf8-a982bfd7d776
---
# Audit Filtering Platform Packet Drop
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Filtering Platform Packet Drop**, which determines whether the operating system generates audit events when packets are dropped by the Windows Filtering Platform.

Windows Filtering Platform \(WFP\) was introduced in Windows Server 2008 and Windows Vista to enable independent software vendors \(ISVs\) to filter and modify TCP\/IP packets, monitor or authorize connections, filter Internet Protocol security \(IPsec\)\-protected traffic, and filter remote procedure calls \(RPCs\).

A high rate of dropped packets may indicate that there have been attempts to gain unauthorized access to computers on your network.

Event volume: High

Default setting: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the  **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------------|-----------------|
|5152|The Windows Filtering Platform blocked a packet.|
|5153|A more restrictive Windows Filtering Platform filter has blocked a packet.|

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)


