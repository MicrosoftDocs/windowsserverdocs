---
title: Netdom resetpwd
description: Netdom resetpwd is a command-line utility that resets the computer account password for a domain controller in Windows Server.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 06/09/2025
---

# netdom resetpwd

The `netdom resetpwd` command resets the secure channel password of the machine account for a domain controller (DC). This command must be run on the DC whose machine account password you wish to reset. It doesn't support resetting passwords for remote machines or member servers. It's available if you have the Active Directory Domain Services (AD DS) server role installed. It's also available if you install the AD DS tools that are part of the Remote Server Administration Tools (RSAT).

For more information, see [How to Administer Microsoft Windows Client and Server Computers Locally and Remotely](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee649281(v=ws.10)).

To use `netdom resetpwd`, you must run the command from an elevated command prompt.

## Syntax

```
netdom resetpwd /Server:domain-controller /UserD:user /PasswordD:[password | *]
                [/SecurePasswordPrompt]
```

## Parameters

| Parameter | Description |
|---|---|
| `/server:<DC>` | Specifies the DC to use to set the computer account password. |
| `/userd:<User>]` | Specifies the user account to use to make the secure connection with the domain specified using the `/server` parameter. If omitted, it uses the current user account. |
| `/passwordd:<Password>` \| `*` | Specifies the password for the user account when using the `/userd` parameter. If set to `*`, you're prompted for the password. |
| `/securepasswordprompt` | Opens a secure credentials popup for entering credentials. This is useful when specifying smartcard credentials. This option is effective only when the password is entered as `*`. |
| `help` \| `/?` | Displays help at the command prompt. |

## Examples

To reset the secure channel password for a computer account associated with the DC **MyDC** and be securely prompted for the password, run the following command:

```
netdom resetpwd /server:MyDC /userd:admin /passwordd:*
```

## See also

[Command-Line Syntax Key](command-line-syntax-key.md)
