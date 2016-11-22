---
title: Audit Detailed Directory Service Replication
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c9dd927d-d63a-42a7-947c-fca5e4bc95c9
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit Detailed Directory Service Replication

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Detailed Directory Service Replication**, which determines whether the operating system generates audit events that contain detailed tracking information about data that is replicated between domain controllers.

This audit subcategory can be useful to diagnose replication issues.

Event volume: These events can create a very high volume of event data.

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008.

|Event ID|Event message|
|------|---------|
|4928|An Active Directory replica source naming context was established.|
|4929|An Active Directory replica source naming context was removed.|
|4930|An Active Directory replica source naming context was modified.|
|4931|An Active Directory replica destination naming context was modified.|
|4934|Attributes of an Active Directory object were replicated.|
|4935|Replication failure begins.|
|4936|Replication failure ends.|
|4937|A lingering object was removed from a replica.|

## Related resource
[Advanced Security Audit Policy Settings](../advanced-security-audit-policy-settings.md)


