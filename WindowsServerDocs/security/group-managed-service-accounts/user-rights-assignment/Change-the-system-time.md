---
title: Change the system time
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 497e2c4b-35ae-4958-8e18-e5f72c32e14a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Change the system time

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
This policy setting determines which users can adjust the time on the computer's internal clock. This right allows the computer user to change the date and time associated with records in the event logs, database transactions, and the file system. This right is also required by the process that performs time synchronization. This setting does not impact the user???s ability to change the time zone or other display characteristics of the system time. For information about assigning the right to change the time zone, see [Change the time zone](change-the-time-zone.md).

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

Constant: SeSystemtimePrivilege

### Possible values

-   User-defined list of accounts

-   Not Defined

### Best practices

1.  Restrict the **Change the system time** user right to users with a legitimate need to change the system time, such as members of the IT team.

### Location
*GPO_name*\Computer Configuration\Windows Settings\Security Settings\Local Policies\User Rights Assignment

### Default values
By default, members of the Administrators and Local Service groups have this right on workstations and servers. Members of the Administrators, Server Operators, and Local Service groups have this right on domain controllers.

The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy???s property page.

|Server type or GPO|Default value|
|-----------|---------|
|Default Domain Policy|Not Defined|
|Default Domain Controller Policy|Administrators<br /><br />Server Operators<br /><br />Local Service|
|Stand-Alone Server Default Settings|Administrators<br /><br />Local Service|
|DC Effective Default Settings|Administrators<br /><br />Server Operators<br /><br />Local Service|
|Member Server Effective Default Settings|Administrators<br /><br />Local Service|
|Client Computer Effective Default Settings|Administrators<br /><br />Local Service|

### Operating system version differences
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

## Policy management
This section describes features, tools and guidance to help you manage this policy.

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
Users who can change the time on a computer could cause several problems. For example:

-   Time stamps on event log entries could be made inaccurate

-   Time stamps on files and folders that are created or modified could be incorrect

-   Computers that belong to a domain might not be able to authenticate themselves

-   Users who try to log on to the domain from computers with inaccurate time might not be able to authenticate.

Also, because the Kerberos authentication protocol requires that the requester and authenticator have their clocks synchronized within an administrator-defined skew period, an attacker who changes a computer's time may cause that computer to be unable to obtain or grant Kerberos protocol tickets.

The risk from these types of events is mitigated on most domain controllers, member servers, and end-user computers because the Windows Time Service automatically synchronizes time with domain controllers in the following ways:

-   All desktop client computers and member servers use the authenticating domain controller as their inbound time partner.

-   All domain controllers in a domain nominate the primary domain controller (PDC) emulator operations master as their inbound time partner.

-   All PDC emulator operations masters follow the hierarchy of domains in the selection of their inbound time partner.

-   The PDC emulator operations master at the root of the domain is authoritative for the organization. Therefore, we recommend that you configure this computer to synchronize with a reliable external time server.

This vulnerability becomes much more serious if an attacker is able to change the system time and then stop the Windows Time Service or reconfigure it to synchronize with a time server that is not accurate.

### Countermeasure
Restrict the **Change the system time** user right to users with a legitimate need to change the system time, such as members of the IT team.

### Potential impact
There should be no impact because time synchronization for most organizations should be fully automated for all computers that belong to the domain. Computers that do not belong to the domain should be configured to synchronize with an external source, such as a web service.

## See Also
[User Rights Assignment](user-rights-assignment.md)


