---
title: Change the time zone
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d82a0a52-dd4c-46cc-92bb-f6648ee42f61
---
# Change the time zone
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
This policy setting determines which users can adjust the time zone that is used by the computer for displaying the local time, which includes the computer's system time plus the time zone offset.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

Constant: SeTimeZonePrivilege

### Possible values

-   User-defined list of accounts

-   Not Defined

### Best practices
None.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment

### Default values
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.

|Server type or GPO|Default value|
|----------------------|-----------------|
|Default Domain Policy|Not Defined|
|Default Domain Controller Policy|Administrators<br /><br />Users|
|Stand-Alone Server Default Settings|Administrators<br /><br />Users|
|Domain Controller Effective Default Settings|Administrators<br /><br />Users|
|Member Server Effective Default Settings|Administrators<br /><br />Users|
|Client Computer Effective Default Settings|Administrators<br /><br />Users|

### Operating system version differences
There are no differences in the way this policy setting works between the supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

## Policy management
A restart of the computer is not required for this policy setting to be effective.

Any change to the account for this user right assignment becomes effective the next time the account logs on.

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
Changing the time zone represents little vulnerability because the system time is not affected. This setting merely enables users to display their preferred time zone while being synchronized with domain controllers in different time zones.

### Countermeasure
Countermeasures are not required because system time is not affected by this setting.

### Potential impact
None.

## See Also
[User Rights Assignment](User-Rights-Assignment.md)


