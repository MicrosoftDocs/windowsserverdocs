---
title: Profile single process
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c9c1d65e-618c-4bb5-b8aa-32675c18de53
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Profile single process

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
This policy setting determines which users can view a sample performance of an application process. Typically, you do not need this user right to use the performance reporting tools included in the operating system. However, you do need this user right if the system???s monitor components are configured to collect data through Windows Management Instrumentation (WMI).

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

Constant: SeProfileSingleProcessPrivilege

### Possible values

-   User-defined list of accounts

-   Administrators

-   Not Defined

### Best practices

1.  This right should not be granted to individual users. It should be granted only for trusted applications that monitor other programs.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment

### Default values
By default this setting is Administrators on domain controllers and on stand-alone servers.

The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy???s property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Administrators|
|Stand-Alone Server Default Settings|Administrators|
|Domain Controller Effective Default Settings|Administrators|
|Member Server Effective Default Settings|Administrators|
|Client Computer Effective Default Settings|Administrators|

### Operating system version differences
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic. Note that the Power Users group is assigned for backward compatibility to Windows XP.

## Policy management
This section describes features, tools, and guidance to help you manage this policy.

A restart of the computer is not required for this policy setting to be effective.

Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.

### Group Policy
Settings are applied in the following order through a Group Policy Object (GPO), which will overwrite settings on the local computer at the next Group Policy update:

1.  Local policy settings

2.  Site policy settings

3.  Domain policy settings

4.  OU policy settings

When a local setting is greyed out, it indicates that a GPO currently controls that setting.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
The **Profile single process** user right presents a moderate vulnerability. Attackers with this user right could monitor a computer's performance to help identify critical processes that they might want to attack directly. Attackers may be able to determine what processes run on the computer so that they could identify countermeasures that they may need to avoid, such as antivirus software or an intrusion-detection system. They could also identify other users who are logged on to a computer.

### Countermeasure
Ensure that only the local Administrators group is assigned the **Profile single process** user right.

### Potential impact
If you remove the **Profile single process** user right from the Power Users group or other accounts, you could limit the abilities of users who are assigned to specific administrative roles in your environment. You should ensure that delegated tasks are not negatively affected.

## See Also
[User Rights Assignment](user-rights-assignment.md)


