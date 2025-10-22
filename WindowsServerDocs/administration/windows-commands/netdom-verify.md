---
title: Netdom verify
description: Netdom verify is a command-line utility that verifies the secure channel between a specified computer and a domain controller in Windows Server.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 06/09/2025
---

# netdom verify

The `netdom verify` command checks the secure channel between a specified computer and a domain controller to ensure trust and connectivity are intact. It's available if you have the Active Directory Domain Services (AD DS) server role installed. It's also available if you install the AD DS tools that are part of the Remote Server Administration Tools (RSAT). For more information, see [How to Administer Microsoft Windows Client and Server Computers Locally and Remotely](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee649281(v=ws.10)).

To use `netdom verify`, you must run the command from an elevated command prompt.

## Syntax

```
netdom verify machine [/Domain:domain] [/UserO:user] [/PasswordO:[password | *]] [/SecurePasswordPrompt]
```

## Parameters

| Parameter | Description |
|-----------|-------------|
| `<machine>` | Specifies the name of the computer whose secure connection you want to verify. |
| `/domain:<Domain>` | Specifies the domain with which to verify the secure connection. If not specified, `netdom verify` uses the domain to which the current computer belongs. |
| `/usero:<User>` | Specifies the user account to use for verification. If not specified, the current user account is used. |
| `/passwordo:<Password>` \| `*` | Specifies the password for the user account specified used with the `/usero` parameter. If set to `*`, you're prompted for the password. |
| `/securepasswordprompt` | Opens a secure credentials popup for entering credentials. This is useful when specifying smartcard credentials. This option is effective only when the password is entered as `*`. |
| `help` \| `/?` | Displays help at the command prompt. |

## Examples

To verify that netdom maintains the secure channel secret between **mywksta** and **devgroup.contoso.com**, run the following command:

```cmd
netdom verify mywksta /domain:devgroup.contoso.com
```

## See also

[Command-Line Syntax Key](command-line-syntax-key.md)
