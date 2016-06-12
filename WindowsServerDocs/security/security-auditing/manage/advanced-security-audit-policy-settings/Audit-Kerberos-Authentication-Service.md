---
title: Audit Kerberos Authentication Service
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8f93d32f-88da-4d6c-bd1f-e6060f0e5ca9
---
# Audit Kerberos Authentication Service
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Kerberos Authentication Service**, which determines whether to generate audit events for Kerberos authentication ticket\-granting ticket \(TGT\) requests.

If you configure this policy setting, an audit event is generated after a Kerberos authentication TGT request. Success audits record successful attempts and Failure audits record unsuccessful attempts.

Event volume: High on Kerberos Key Distribution Center servers

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------------|-----------------|
|4768|A Kerberos authentication ticket \(TGT\) was requested.|
|4771|Kerberos preauthentication failed.|
|4772|A Kerberos authentication ticket request failed.|

## Related resource
[Advanced Security Audit Policy Settings](../advanced-security-audit-policy-settings.md)


