---
title: Account lockout threshold
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f4cd6db5-f4cc-44b8-a251-09e2ac56c774
---
# Account lockout threshold
This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for the **Account lockout threshold** policy setting.

## Reference
The **Account lockout threshold** policy setting determines the number of failed sign\-in attempts that will cause a user account to be locked. A locked account cannot be used until it is reset by an administrator or until the number of minutes specified by the **Account lockout duration** policy setting expires. You can set a value from 1 through 999 failed sign\-in attempts, or you can specify that the account will never be locked by setting the value to 0. If **Account lockout threshold** is set to a number greater than zero, **Account lockout duration** must be greater than or equal to the value of **Reset account lockout counter after**.

Failed password attempts on workstations or member servers that have been locked by using CTRL\+ALT\+DELETE or password\-protected screen savers do not count as failed sign\-in attempts unless **Interactive logon: Require Domain Controller authentication to unlock workstation** is set to **Enabled**. If **Interactive logon: Require Domain Controller authentication to unlock workstation** is enabled, repeated failed password attempts to unlock the workstation will count against the account lockout threshold.

Brute force password attacks can be automated to try thousands or even millions of password combinations for any or all user accounts. Limiting the number of failed sign\-ins that can be performed nearly eliminates the effectiveness of such attacks.

However, it is important to note that a denial\-of\-service \(DoS\) attack could be performed on a domain that has an account lockout threshold configured. A malicious user could programmatically attempt a series of password attacks against all users in the organization. If the number of attempts is greater than the value of **Account lockout threshold**, the attacker could potentially lock every account.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

### Possible values
It is possible to configure the following values for the **Account lockout threshold** policy setting:

-   A user\-defined number from 0 through 999

-   Not defined

Because vulnerabilities can exist when this value is configured and when it is not, organizations should weigh their identified threats and the risks that they are trying to mitigate. For information these settings, see [Countermeasure](#BKMK_Countermeasure) in this topic

### Best practices
The threshold that you select is a balance between operational efficiency and security, and it depends on your organization's risk level. To allow for user error and to thwart brute force attacks, a setting above 4 and below 10 could be an acceptable starting point for your organization.

> [!IMPORTANT]
> Implementation of this policy setting is dependent on your operational environment; threat vectors, deployed operating systems, and deployed apps. For more information, see [Implementation considerations](#BKMK_ImpleConsiderations) in this topic.

### Location
*GPO\_name***\\Computer Configuration\\Windows Settings\\Security Settings\\Account Policies\\Account Lockout Policy**

### Default values
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the property page for the policy setting.

|Server type or Group Policy Object \(GPO\)|Default value|
|----------------------------------------------|-----------------|
|Default domain policy|0 invalid sign\-in attempts|
|Default domain controller policy|Not defined|
|Stand\-alone server default settings|0 invalid sign\-in attempts|
|Domain controller effective default settings|0 invalid sign\-in attempts|
|Member server effective default settings|0 invalid sign\-in attempts|
|Effective GPO default settings on client computers|0 invalid sign\-in attempts|

### Operating system version differences
There are no differences in the way this policy setting works between [supported versions of Windows](#BKMK_top).

### Policy management
This section describes features and tools that are available to help you manage this policy setting.

#### Restart requirements
None. Changes to this policy setting become effective without a computer restart when they are saved locally or distributed through Group Policy.

#### <a name="BKMK_ImpleConsiderations"></a>Implementation considerations
Implementation of this policy setting is dependent on your operational environment. You should consider threat vectors, deployed operating systems, and deployed apps, for example:

-   The likelihood of an account theft or a DoS attack is based on the security design for your systems and environment. You should set the account lockout threshold in consideration of the known and perceived risk of those threats.

-   When negotiating encryption types between clients, servers, and domain controllers, the Kerberos protocol can automatically retry account sign\-in attempts that count toward the threshold limits that you set in this policy setting. In environments where different versions of the operating system are deployed, encryption type negotiation increases.

-   Not all apps that are used in your environment effectively manage how many times a user can attempt to sign\-in. For instance, if a connection drops repeatedly when a user is running the app, all subsequent failed sign\-in attempts count toward the account lockout threshold.

## Security considerations
This section describes how an attacker might exploit a feature or its configuration, how to implement the countermeasure, and the possible negative consequences of countermeasure implementation.

### Vulnerability
Brute force password attacks can use automated methods to try millions of password combinations for any user account. The effectiveness of such attacks can be almost eliminated if you limit the number of failed sign\-in attempts that can be performed.

However, a DoS attack could be performed on a domain that has an account lockout threshold configured. An attacker could programmatically attempt a series of password attacks against all users in the organization. If the number of attempts is greater than the account lockout threshold, the attacker might be able to lock every account without needing any special privileges or being authenticated in the network.

> [!NOTE]
> Offline password attacks are not countered by this policy setting.

### <a name="BKMK_Countermeasure"></a>Countermeasure
Because vulnerabilities can exist when this value is configured and when it is not configured, two distinct countermeasures are defined. Organizations should weigh the choice between the two, based on their identified threats and the risks that they want to mitigate. The two countermeasure options are:

-   Configure the **Account lockout threshold** setting to 0. This configuration ensures that accounts will not be locked, and it will prevent a DoS attack that intentionally attempts to lock accounts. This configuration also helps reduce Help Desk calls because users cannot accidentally lock themselves out of their accounts. Because it does not prevent a brute force attack, this configuration should be chosen only if both of the following criteria are explicitly met:

    -   The password policy setting requires all users to have complex passwords of 8 or more characters.

    -   A robust audit mechanism is in place to alert administrators when a series of failed sign\-ins occur in the environment.

-   Configure the **Account lockout threshold** policy setting to a sufficiently high value to provide users with the ability to accidentally mistype their password several times before the account is locked, but ensure that a brute force password attack still locks the account.

    A good recommendation for such a configuration is 50 invalid sign\-in attempts, which prevents accidental account lockouts and reduces the number of Help Desk calls, but does not prevent a DoS attack. We recommend this option if your organization cannot implement complex password requirements and an audit policy that alerts administrators to a series of failed sign\-in attempts.

    Using this type of policy must be accompanied by a process to unlock locked accounts. It must be possible to implement this policy whenever it is needed to help mitigate massive lockouts caused by an attack on your systems.

### Potential impact
If this policy setting is enabled, a locked account is not usable until it is reset by an administrator or until the account lockout duration expires. Enabling this setting will likely generate a number of additional Help Desk calls.

If you configure the **Account lockout threshold** policy setting to 0, there is a possibility that an malicious user's attempt to discover passwords with a brute force password attack might go undetected if a robust audit mechanism is not in place.

If you configure this policy setting to a number greater than 0, an attacker can easily lock any accounts for which the account name is known. This is especially dangerous considering that no credentials other than access to the network are necessary to lock the accounts.

## See Also
[Account Lockout Policy](account-lockout-policy.md)


