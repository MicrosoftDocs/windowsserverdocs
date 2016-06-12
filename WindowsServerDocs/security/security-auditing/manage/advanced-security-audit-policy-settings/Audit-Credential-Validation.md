---
title: Audit Credential Validation
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 0673bfcd-fb06-40cf-9419-19770c0603c9
---
# Audit Credential Validation
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Credential Validation**, which determines whether the operating system generates audit events on credentials that are submitted for a user account logon request.

These events occur on the computer that is authoritative for the credentials as follows:

-   For domain accounts, the domain controller is authoritative.

-   For local accounts, the local computer is authoritative.

Event volume: High on domain controllers

Because domain accounts are used much more frequently than local accounts in enterprise environments, most of the Account Logon events in a domain environment occur on the domain controllers that are authoritative for the domain accounts. However, these events can occur on any computer, and they may occur in conjunction with or on separate computers from Logon and Logoff events.

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------------|-----------------|
|4774|An account was mapped for logon.|
|4775|An account could not be mapped for logon.|
|4776|The domain controller attempted to validate the credentials for an account.|
|4777|The domain controller failed to validate the credentials for an account.|

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)


