---
title: Audit Other Logon - Logoff Events
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bde9321e-1818-4ed0-b489-3c2921ee078a
---
# Audit Other Logon - Logoff Events
This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit Other Logon\/Logoff Events**, which determines whether Windows generates audit events for other logon or logoff events.

These other logon or logoff events include:

-   A Remote Desktop session connects or disconnects.

-   A workstation is locked or unlocked.

-   A screen saver is invoked or dismissed.

-   A replay attack is detected. This event indicates that a Kerberos request was received twice with identical information. This condition could also be caused by network misconfiguration.

-   A user is granted access to a wireless network. It can either be a user account or the computer account.

-   A user is granted access to a wired 802.1x network. It can either be a user account or the computer account.

Logon events are essential to understanding user activity and detecting potential attacks.

Event volume: Low

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of Windows as designated in the **Applies To** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------------|-----------------|
|4649|A replay attack was detected.|
|4778|A session was reconnected to a Window Station.|
|4779|A session was disconnected from a Window Station.|
|4800|The workstation was locked.|
|4801|The workstation was unlocked.|
|4802|The screen saver was invoked.|
|4803|The screen saver was dismissed.|
|5378|The requested credentials delegation was disallowed by policy.|
|5632|A request was made to authenticate to a wireless network.|
|5633|A request was made to authenticate to a wired network.|

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)


