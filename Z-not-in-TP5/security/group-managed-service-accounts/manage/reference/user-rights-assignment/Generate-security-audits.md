---
title: Generate security audits
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 260fc594-bb66-40aa-8451-3e7e86bdbd6b
---
# Generate security audits
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
This policy setting determines which accounts can be used by a process to generate audit records in the Security log. The Local Security Authority Subsystem Service writes events to the log. You can use the information in the Security log to trace unauthorized computer access.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

Constant: SeAuditPrivilege

### Possible values

-   User-defined list of accounts

-   Local Service

-   Network Service

### Best practices

1.  Because the audit log can potentially be an attack vector if an account is compromised, ensure that only the Local Service and Network Service accounts have the **Generate security audits** user right assigned to them.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment

### Default values
By default, this setting is Local Service and Network Service on domain controllers and stand-alone servers.

The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Not defined|
|Default Domain Controller Policy|Local Service<br /><br />Network Service|
|Stand-Alone Server Default Settings|Local Service<br /><br />Network Service|
|Domain Controller Effective Default Settings|Local Service<br /><br />Network Service|
|Member Server Effective Default Settings|Local Service<br /><br />Network Service|
|Client Computer Effective Default Settings|Local Service<br /><br />Network Service|

### Operating system version differences
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

## Policy management
This section describes features, tools, and guidance to help you manage this policy.

A restart of the computer is not required for this policy setting to be effective.

Any change to the user rights assignment for an account becomes effective the next time the owner of the account logs on.

Misuse of this user right can result in the generation of many auditing events, potentially hiding evidence of an attack or causing a denial-of-service (DoS) if the **Audit: Shut down system immediately if unable to log security audits** security policy setting is enabled. For more information see [Audit: Shut down system immediately if unable to log security audits](https://technet.microsoft.com/library/dd772720.aspx).

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
A malicious user could use accounts that can write to the Security log to fill that log with meaningless events. If the computer is configured to overwrite events as needed, malicious users could use this method to remove evidence of their unauthorized activities. If the computer is configured to shut down when it is unable to write to the Security log, and it is not configured to automatically back up the log files, this method could be used to create a DoS condition.

### Countermeasure
Ensure that only the Local Service and Network Service accounts have the **Generate security audits** user right assigned to them.

### Potential impact
None. Restricting the **Generate security audits** user right to the Local Service and Network Service accounts is the default configuration.

## See Also
[User Rights Assignment](User-Rights-Assignment.md)


