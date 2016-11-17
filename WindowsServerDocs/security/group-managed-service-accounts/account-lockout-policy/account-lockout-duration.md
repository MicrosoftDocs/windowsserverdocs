---
title: Account lockout duration
description: "Windows Server Security"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: security-gmsa
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 938efcfe-edac-4650-bc3f-e421a9dbfc3a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Account lockout duration

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

This security policy reference topic for the IT professional describes the best practices, location, values, and security considerations for this policy setting.

## Reference
The **Account lockout duration** policy setting determines the number of minutes that a locked-out account remains locked out before automatically becoming unlocked. The available range is from 1 through 99,999 minutes. A value of 0 specifies that the account will be locked out until an administrator explicitly unlocks it. If **Account lockout threshold** is set to a number greater than zero, **Account lockout duration** must be greater than or equal to the value of **Reset account lockout counter after**.

This policy setting is dependent on the **Account lockout threshold** policy setting that is defined, and it must be greater than or equal to the value specified for the **Reset lockout counter after** policy setting.

This policy setting is supported on versions of Windows that are designated in the **Applies To** list at the beginning of this topic.

#### Possible values

-   A user-defined number of minutes from 0 through 99,999

-   Not defined

If **Account lockout threshold** is configured, after the specified number of failed attempts, the account will be locked out. If th **Account lockout duration** is set to 0, the account will remain locked until an administrator unlocks it manually.

It is advisable to set **Account lockout duration** to approximately 30 minutes. To specify that the account will never be locked out, set the value to 0. To configure the value for this policy setting so that it never automatically unlocks the account might seem like a good idea; however, doing so can increase the number of requests that your organization???s Help Desk receives to unlock accounts that were locked by mistake.

#### Location
*GPO_name***\Computer Configuration\Windows Settings\Security Settings\Account Policies\Password Policy**

#### Default values
The following table lists the actual and effective default policy values for the most recent supported versions of Windows. Default values are also listed on the policy???s property page.

|Server type or Group Policy Object (GPO)|Default value|
|-----------------------|---------|
|Default domain policy|Not defined|
|Default domain controller policy|Not defined|
|Stand-alone server default settings|Not applicable|
|Domain controller effective default settings|Not defined|
|Member server effective default settings|Not defined|
|Client computer effective default settings|Not applicable|

#### Operating system version differences
There are no differences in the way this policy setting works between supported versions of Windows.

## Security considerations
More than a few unsuccessful password submissions during an attempt to log on to a computer might represent an attacker's attempts to determine an account password by trial and error. The Windows and Windows Server operating systems can track logon attempts, and you can configure the operating system to disable the account for a preset period of time after a specified number of failed attempts. Account lockout policy settings control the threshold for this response and what action to take after the threshold is reached.

### Vulnerability
A denial-of-service (DoS) condition can be created if an attacker abuses the **Account lockout threshold** policy setting and repeatedly attempts to log on with a specific account. After you configure the **Account lockout threshold** policy setting, the account will be locked out after the specified number of failed attempts. If you configure the **Account lockout duration** policy setting to 0, the account remains locked until an administrator unlocks it manually.

### Countermeasure
Configure the **Account lockout duration** policy setting to an appropriate value for your environment. To specify that the account will remain locked until an administrator manually unlocks it, configure the value to 0. When the **Account lockout duration** policy setting is configured to a nonzero value, automated attempts to guess account passwords are delayed for this interval before resuming attempts against a specific account. Using this setting in combination with the **Account lockout threshold** policy setting makes automated password guessing attempts more difficult.

### Potential impact
Configuring the **Account lockout duration** policy setting to 0 so that accounts cannot be automatically unlocked can increase the number of requests that your organization's Help Desk receives to unlock accounts that were locked by mistake.

## See Also
[Account Lockout Policy](account-lockout-policy.md)


