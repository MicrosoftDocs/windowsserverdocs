---
title: Audit MPSSVC Rule-Level Policy Change
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-auditing
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1a1e6213-7db6-4e1b-a4e6-327246d7dab1
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Audit MPSSVC Rule-Level Policy Change

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This topic for the IT professional describes the Advanced Security Audit policy setting, **Audit MPSSVC Rule-Level Policy Change**, which determines whether the operating system generates audit events when changes are made to policy rules for the Microsoft Protection Service (MPSSVC.exe).

The Microsoft Protection Service, which is used by Windows Firewall, is an integral part of the computer???s threat protection against Internet-bound threats such as Trojans and spyware. The tracked activities include:

-   Active policies when the Windows Firewall service starts.

-   Changes to Windows Firewall rules.

-   Changes to the Windows Firewall exception list.

-   Changes to Windows Firewall settings.

-   Rules ignored or not applied by the Windows Firewall service.

-   Changes to Windows Firewall Group Policy settings.

Changes to firewall rules are important for understanding the security state of the computer and how well it is protected against network attacks.

Event volume: Low

Default: Not configured

If this policy setting is configured, the following events appear on computers running the supported versions of the Windows operating system as designated in the **Applies to** list at the beginning of this topic, in addition to Windows Server 2008 and Windows Vista.

|Event ID|Event message|
|------|---------|
|4944|The following policy was active when the Windows Firewall started.|
|4945|A rule was listed when the Windows Firewall started.|
|4946|A change has been made to Windows Firewall exception list. A rule was added.|
|4947|A change has been made to Windows Firewall exception list. A rule was modified.|
|4948|A change has been made to Windows Firewall exception list. A rule was deleted.|
|4949|Windows Firewall settings were restored to the default values.|
|4950|A Windows Firewall setting has changed.|
|4951|A rule has been ignored because its major version number was not recognized by Windows Firewall.|
|4952|Parts of a rule have been ignored because its minor version number was not recognized by Windows Firewall. The other parts of the rule will be enforced.|
|4953|A rule has been ignored by Windows Firewall because it could not parse the rule.|
|4954|Windows Firewall Group Policy settings have changed. The new settings have been applied.|
|4956|Windows Firewall has changed the active profile.|
|4957|Windows Firewall did not apply the following rule:|
|4958|Windows Firewall did not apply the following rule because the rule referred to items not configured on this computer:|

## Related resource
[Advanced Security Audit Policy Settings](../Advanced-Security-Audit-Policy-Settings.md)


