---
title: Enforce user logon restrictions
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 12baca36-dd16-4483-b5d2-7c081d36a585
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Enforce user logon restrictions

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
The **Enforce user logon restrictions** policy setting determines whether the Kerberos V5 Key Distribution Center (KDC) validates every request for a session ticket against the user rights policy of the user account. Validating each request for a session ticket is optional because the extra step takes time, and that can slow network access to services.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

The possible values for this Group Policy setting are:

-   Enabled

-   Disabled

-   Not defined

#### Best practices

1.  If this policy setting is disabled, users might be granted session tickets for services that they do not have the right to use.

    It is advisable to set **Enforce user logon restrictions** to Enabled.

#### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Account Policies\Kerberos Policy\

#### Default Values
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy' property page.

|Server Type or GPO|Default Value|
|-----------|---------|
|Default Domain Policy|Enabled|
|Default Domain Controller Policy|Not defined|
|Stand-Alone Server Default Settings|Not applicable|
|DC Effective Default Settings|Enabled|
|Member Server Effective Default Settings|Not applicable|
|Client Computer Effective Default Settings|Not applicable|

#### Operating system version differences
There are no differences in the way this policy setting works between the supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

## Policy management
This section describes features, tools, and guidance to help you manage this policy.

A restart of the computer is not required for this policy setting to be effective.

### Group Policy
Client computers will get the new setting during the next scheduled and successful Group Policy refresh. But for domain controllers to assign these new settings immediately, a Gpupdate /force is required. On the local computer, the Security Configuration Engine will refresh this setting in about five minutes.

Settings are applied in the following order through a Group Policy Object (GPO), which will overwrite settings on the local computer at the next Group Policy update:

1.  Local policy settings

2.  Site policy settings

3.  Domain policy settings

4.  OU policy settings

When a local setting is greyed out, it indicates that a GPO currently controls that setting.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
If you disable this policy setting, users could receive session tickets for services that they no longer have the right to use because the right was removed after they logged on.

### Countermeasure
Enable the **Enforce user logon restrictions** setting.

### Potential impact
None. This is the default configuration.

## See Also
[Kerberos Policy](../../kerberos/kerberos-policy.md)


