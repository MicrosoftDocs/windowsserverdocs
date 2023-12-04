---
title: Use Windows LAPS event logs
description: Learn about key events in Windows Local Administrator Password Solution (Windows LAPS) and how to view the logs.
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2022
ms.topic: conceptual
---

# Use Windows LAPS event logs

Windows Local Administrator Password Solution (Windows LAPS) has a dedicated event log channel. All Windows LAPS operations are tracked with rich eventing. Learn about key events and how to view the log.

> [!IMPORTANT]
> For more information on specific OS updates required to use the Windows LAPS feature, and the current status of the Microsoft Entra LAPS scenario, see [Windows LAPS availability and Microsoft Entra LAPS public preview status](laps-overview.md).

## View the event log

To view the Windows LAPS event log channel, in Windows Server Event Viewer, go to **Applications and Services** > **Logs** > **Microsoft** > **Windows** > **LAPS** > **Operational**.

:::image type="content" source="./media/laps-management-event-log/laps-management-event-log-event-log.png" alt-text="Screenshot of the event log and a Windows LAPS policy processing started event log message.":::

## Key events

It's important to be aware of some key Windows LAPS events and how to view them in the event logs:

- Policy processing start and end events
- Policy configuration details
- Password update confirmation events
- Blocked external password modification request
- Post-authentication-action related events

### Policy processing cycle start and end

When Windows LAPS begins a background policy processing cycle, the progress of the operation is tracked in the event log. Knowing the specific events that indicate the start and end of each cycle makes it easy to read the event log and understand the events.

Each background policy processing cycle starts with a 10003 event:

```output
LAPS policy processing is now starting.
```

Each 10003 event is followed by several other events that describe what's happening. When the cycle finishes, the final event marks the operation as succeeded or failed.

A successful cycle is tracked with a 10004 event. Here's an example of a 10004 event:

```output
LAPS policy processing succeeded.
```

A failed cycle is tracked with a 10005 event. Here's an example of a 10005 event:

```output
LAPS policy processing failed with the error code below.

Error code: 80070032
```

If a failure occurs, you can use the error code to troubleshoot. You also can look at the intervening events for detailed information.

### Policy configuration details

When password backup is enabled, a policy configuration event is emitted during each Windows LAPS background policy processing cycle. The event logs the specific policy setting value for each cycle iteration.

When the policy is configured to back up the password to Windows Server Active Directory, a 10021 event is logged. Here's an example of a 10021 event:

```output
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

When the policy is configured to back up the password to Microsoft Entra ID, a 10022 event is logged. Here's an example of a 10022 event:

```output
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

When Windows LAPS is configured to use a legacy Microsoft LAPS policy, a 10023 event is logged. Here's an example of a 10023 event:

```output
The current LAPS policy is configured as follows:

Policy source: Legacy LAPS
Backup directory: Active Directory
Local administrator account name:
Password age in days: 30
Password complexity: 4
Password length: 8
Password expiration protection enabled: 0
```

These specific policy setting values are examples and shouldn't be considered recommendations.

### Password update confirmation events

When Windows LAPS successfully updates the configured directory (Windows Server Active Directory or Microsoft Entra ID) with a new password, a success event is logged: 10018 for password updates in Windows Server Active Directory, and 10029 for password updates in Microsoft Entra ID.

Here's an example of a 10018 event:

```output
LAPS successfully updated Active Directory with the new password.
```

Here's an example of a 10029 event:

```output
LAPS successfully updated Azure Active Directory with the new password.
```

When the directory is updated with the new password, Windows LAPS also updates the managed local account. A 10020 event is logged on success.

Here's an example of a 10020 event:

```output
LAPS successfully updated the local admin account with the new password.

Account name: ContosoLocalAdminAccount
Account RID: 1087
```

### Blocked external password modification request

When Windows LAPS is enabled, it protects the password for the specified managed account from modification by any entity other than Windows LAPS. A 10031 event is logged when an attempt to change the password is blocked.

Here's an example of a 10031 event:

```output
LAPS blocked an external request that tried to modify the password of the current managed account.

Account name: ContosoLocalAdminAccount
Account RID: 1087
```

### Post-authentication action events

When post-authentication actions are configured, Windows LAPS monitors for successful authentications by the specified managed account. When an authentication is detected, a 10041 event is logged.

Here's an example of a 10041 event:

```output
LAPS detected a successful authentication for the currently managed account. A background task has been scheduled to execute the configured post-authentication actions after the configured grace period has expired.%n

Account name: ContosoLocalAdminAccount
Account RID: 1087
Password reset timer deadline: %3%n
```

When the deadline that's listed in the 10041 event is reached, Windows LAPS logs a 10042 event:

```output
The post-authentication grace period has expired per policy. The configured post-authentication actions will now be executed.

Account name: ContosoLocalAdminAccount
Account RID: 1087
```

Windows LAPS then attempts to rotate the password and execute any specified post-authentication actions. A 10044 event is logged when the password rotation succeeds.

Here's an example of a 10044 event:

```output
LAPS successfully reset the password for the currently managed account and completed all configured post-authentication actions.%n
%n
Account name: ContosoLocalAdminAccount
Account RID: 1087
```

If the password rotation fails, a 10043 event is logged. Here's an example of a 10043 event:

```output
LAPS failed to reset the password for the currently managed account. The password is considered expired due to an authentication event. LAPS will continue retrying the password reset operation until it succeeds.

Account name: ContosoLocalAdminAccount
Account RID: 1087
Password reset retry count: 1
Error code: 80070032
```

## Client event log versus AD domain controller event log

The Windows LAPS event log channel contains events related to the local machine acting as a client. The Windows LAPS event log channel on an Active Directory domain controller only contains events related to management of the local DSRM account (if enabled), and never contains any events related to domain-joined client behaviors.

## Next steps

- [Configure Windows LAPS for Windows Server Active Directory](laps-management-user-interface.md)
- [Key concepts in Windows LAPS](laps-concepts.md)
