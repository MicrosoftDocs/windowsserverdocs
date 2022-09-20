---
ms.assetid: 05452862-51a1-4b28-bf1a-8de787ad887e
title: Windows Local Administrator Password Solution Event Log
description: Windows Local Administrator Password Solution Event Log
author: jsimmons
ms.author: jsimmons
manager: jsimmons
ms.date: 07/04/2022
ms.topic: article
---

# Windows LAPS Event Log

Windows LAPS includes a dedicated event log channel, and all operations are tracked with rich eventing. This overview article provides a brief overview of the key events.

## Event log channel location

The Windows LAPS events to the following Operational log:

`\Applications and Services Logs\Microsoft\Windows\LAPS\Operational`

:::image type="content" source="../laps/media/laps-management-event-log/laps-management-event-log-event-log.png" alt-text="Screenshot of the event log showing a Windows LAPS policy processing started event log message.":::

## Key events to be aware of

### Policy processing start and end events

Whenever Windows LAPS begins a background policy processing cycle, the progress of the operation will be tracked in the event log. Knowing the specific events that demarcate the beginning and end of every cycle makes it easy to read the event log and understand the various activities.

Each background policy processing cycle starts with a 10003 event:

```text
LAPS policy processing is now starting.
```

Each 10003 event will be followed by several other events that describe what is happening. When the cycle completes, the final event will mark the operation as having either succeeded or failed.

A successful cycle will be marked by a 10004 event; here's an example of a 10004 event:

```text
LAPS policy processing succeeded.
```

A failed cycle will be marked by a 10005 event; here's an example of a 10005 event:

```text
LAPS policy processing failed with the error code below.

Error code: 80070032
```

If a failure occurs the error code is helpful with troubleshooting, however also look at the intervening events for more detailed information.

### Policy configuration details

Whenever password backup is enabled, a policy configuration event will be emitted during every Windows LAPS background policy processing cycle to log the specific policy setting value for every cycle iteration. 

When the policy is configured to back up the password to Active Directory, a 10021 event will be logged. here's an example of a 10021 event:

```text
The current LAPS policy is configured as follows:

Policy source: GPO
Backup directory: Active Directory
Local administrator account name:
Password age in days: 30
Password complexity: 4
Password length: 14
Password expiration protection enabled: 1
Password encryption enabled: 1
Password encryption target principal: LapsAdministrators@contoso.com
Password encrypted history size: 12
Backup DSRM password on domain controllers: 0
Post authentication grace period (hours): 8
Post authentication actions: 1
```

When the policy is configured to back up the password to Azure Active Directory, a 10022 event will be logged. here's an example of a 10022 event:

```text
The current LAPS policy is configured as follows:

Policy source: CSP
Backup directory: Azure AD
Local administrator account name: ContosoLocalAdminAccount
Password age in days: 7
Password complexity: 4
Password length: 64
Post authentication grace period (hours): 8
Post authentication actions: 3
```

When Windows LAPS is configured to use a legacy LAPS policy, a 10023 event will be logged. here's an example of a 10023 event:

```text
The current LAPS policy is configured as follows:

Policy source: Legacy LAPS
Backup directory: Active Directory
Local administrator account name:
Password age in days: 30
Password complexity: 4
Password length: 8
Password expiration protection enabled: 0
```

The specific policy setting values above are examples and shouldn't be considered as recommendations.

### Password update confirmation events

Whenever Windows LAPS successfully updates the configured directory (Windows Server Active Directory or Azure Active Directory) with a new password, a success event will be logged: 10018 for password updates in Windows Server Active Directory, and 10029 for password updates in Azure Active Directory.

Here's an example of a 10018 event:

```text
LAPS successfully updated Active Directory with the new password.
```

Here's an example of a 10029 event:

```text
LAPS successfully updated Azure Active Directory with the new password.
```

Once the directory has been updated with the new password, Windows LAPS will then update the managed local account as well. A 10020 event will be logged on success.

Here's an example of a 10020 event:

```text
LAPS successfully updated the local admin account with the new password.

Account name: ContosoLocalAdminAccount
Account RID: 1087
```

### Blocked external password modification request

Whenever Windows LAPS is enabled, it will protect the specified managed account from having its password modified by anyone other than LAPS itself. A 10031 event will be logged when such attempts are blocked.

Here's an example of a 10031 event:

```text
LAPS blocked an external request that tried to modify the password of the current managed account.

Account name: ContosoLocalAdminAccount
Account RID: 1087
```

### Post-authentication-action related events

Whenever post-authentication actions are configured, Windows LAPS will monitor for successful authentications by the specified managed account. When an authentication is detected, a 10041 event will be logged.

Here's an example of a 10041 event:

```text
LAPS detected a successful authentication for the currently managed account. A background task has been scheduled to execute the configured post-authentication actions after the configured grace period has expired.%n

Account name: ContosoLocalAdminAccount
Account RID: 1087
Password reset timer deadline: %3%n
```

When the deadline listed in the 10031 event is reached, Windows LAPS will log a 10042 event:

```text
The post-authentication grace period has expired per policy. The configured post-authentication actions will now be executed.

Account name: ContosoLocalAdminAccount
Account RID: 1087
```

Windows LAPS will then attempt to rotate the password and execute any specified post-authentication actions. A 10044 event will be logged once the password rotation succeeds.

Here's an example of a 10044 event:

```text
LAPS successfully reset the password for the currently managed account and completed all configured post-authentication actions.%n
%n
Account name: ContosoLocalAdminAccount
Account RID: 1087
```

If the password rotation fails, a 10043 event will be logged. here's an example of a 10043 event:

```text
LAPS failed to reset the password for the currently managed account. The password is considered expired due to an authentication event. LAPS will continue retrying the password reset operation until it succeeds.

Account name: ContosoLocalAdminAccount
Account RID: 1087
Password reset retry count: 1
Error code: 80070032
```

### See also

[Windows LAPS Management](../laps/laps-management.md)
