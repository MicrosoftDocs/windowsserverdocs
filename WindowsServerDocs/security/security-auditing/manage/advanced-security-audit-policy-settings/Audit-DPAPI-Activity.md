---
title: Audit DPAPI Activity
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6c0708b5-a670-4175-831d-68555d2b0427
---
# Audit DPAPI Activity
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit DPAPI Activity**, which determines whether the operating system generates audit events when encryption or decryption calls are made into the data protection application interface \(DPAPI\).

DPAPI is used to protect secret information such as stored passwords and key information. For more information about DPAPI, see [Windows Data Protection](http://go.microsoft.com/fwlink/?LinkID=121720) \(http:\/\/go.microsoft.com\/fwlink\/?LinkID\=121720\).

Event volume: Low

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------------|-----------------|
|4692|Backup of data protection master key was attempted.|
|4693|Recovery of data protection master key was attempted.|
|4694|Protection of auditable protected data was attempted.|
|4695|Unprotection of auditable protected data was attempted.|

## Related resource
[Advanced Security Audit Policy Settings](../advanced-security-audit-policy-settings.md)


