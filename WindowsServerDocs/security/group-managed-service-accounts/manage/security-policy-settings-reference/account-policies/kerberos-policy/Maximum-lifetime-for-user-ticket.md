---
title: Maximum lifetime for user ticket
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 099d70f2-be27-4ec6-b05c-86e06a0c0833
---
# Maximum lifetime for user ticket
This security policy reference topic for the IT professional describes the best practices, location, values, policy management, and security considerations for this policy setting.

## Reference
The **Maximum lifetime for user ticket** policy setting determines the maximum amount of time \(in hours\) that a user’s ticket\-granting ticket can be used. When a user’s ticket\-granting ticket expires, a new one must be requested or the existing one must be renewed.

The possible values for this Group Policy setting are:

-   A user\-defined number of hours from 0 through 99,999

-   Not defined

If the value for this policy setting is too high, users might be able to access network resources outside of their logon hours, or users whose accounts have been disabled might be able to continue to access network services by using valid service tickets that were issued before their account was disabled. If the value is set to 0, ticket\-granting tickets never expire.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

#### Best practices

1.  It is advisable to set **Maximum lifetime for user ticket** to 10 hours.

#### Location
*GPO\_name*\\Computer Configuration\\Windows Settings\\Security Settings\\Account Policies\\Kerberos Policy\\

#### Default Values
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy’s property page.

|Server Type or GPO|Default Value|
|----------------------|-----------------|
|Default Domain Policy|10 hours|
|Default Domain Controller Policy|Not defined|
|Stand\-Alone Server Default Settings|Not applicable|
|Domain Controller Effective Default Settings|10 hours|
|Member Server Effective Default Settings|Not applicable|
|Client Computer Effective Default Settings|Not applicable|

#### Operating system version differences
There are no differences in the way this policy setting works between the supported versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

## Policy management
This section describes features, tools, and guidance to help you manage this policy.

A restart of the computer is not required for this policy setting to be effective.

This policy setting is configured on the domain controller.

### Group Policy
Client computers will get the new setting during the next scheduled and successful Group Policy refresh. But for domain controllers to assign these new settings immediately, a Gpupdate \/force is required. On the local computer, the Security Configuration Engine will refresh this setting in about five minutes.

Settings are applied in the following order through a Group Policy Object \(GPO\), which will overwrite settings on the local computer at the next Group Policy update:

1.  Local policy settings

2.  Site policy settings

3.  Domain policy settings

4.  OU policy settings

When a local setting is greyed out, it indicates that a GPO currently controls that setting.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
If you configure the value for the **Maximum lifetime for user ticket** setting too high, users might be able to access network resources outside of their logon hours. Also, users whose accounts were disabled might continue to have access to network services with valid user tickets that were issued before their accounts were disabled. If you configure this value too low, ticket requests to the KDC may affect the performance of your KDC and present an opportunity for a DoS attack.

### Countermeasure
Configure the **Maximum lifetime for user ticket** setting with a value between 4 and 10 hours.

### Potential impact
Reducing this setting from the default value reduces the likelihood that the ticket\-granting ticket will be used to access resources that the user does not have rights to. However, it requires more frequent requests to the KDC for ticket\-granting tickets on behalf of users. Most KDCs can support a value of four hours without too much additional burden.

## See Also
[Kerberos Policy](Kerberos-Policy.md)


