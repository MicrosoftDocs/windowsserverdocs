---
title: netdom renamecomputer
description: Netdom renamecomputer is a command-line utility that renames a domain workstation or member server in Windows Server.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 06/09/2025
---

# netdom renamecomputer

The `netdom renamecomputer` command renames a domain workstation or member server and its corresponding domain account. It's available if you have the Active Directory Domain Services (AD DS) server role installed. It's also available if you install the AD DS tools that are part of the Remote Server Administration Tools (RSAT). For more information, see [How to Administer Microsoft Windows Client and Server Computers Locally and Remotely](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee649281(v=ws.10)).

To use `netdom renamecomputer`, you must run the command from an elevated command prompt.

## Syntax

```
netdom renamecomputer machine /NewName:new-name
                              [/UserD:user [/PasswordD:[password | *]]]
                              [/UserO:user [/PasswordO:[password | *]]]
                              [/Force] [/Reboot[:Time in seconds]]
                              [/SecurePasswordPrompt]
```

## Parameters

| Parameter | Description |
|-----------|-------------|
| `<machine>` | Specifies the name of the computer that you want to rename. |
| `/newname:<NewComputerName>` | Specifies the new name of the computer. |
| `/userd:<User>` | Specifies the user account that you want to use for the destination domain. |
| `/passwordd:<Password>` \| `*` | Specifies the password of the user account that you specify using the `/userd` parameter. If you specify the value of this parameter as a wildcard character (`*`), this parameter prompts you for the password. |
| `/usero:<User>` | Specifies the user account that you want to use for the originating domain. |
| `/passwordo:<Password>` \| `*` | Specifies the password of the user account that you specify using the `/usero` parameter. If you specify the value of this parameter as a wildcard character (`*`), this parameter prompts you for the password. |
| `/force` | When the `/force` parameter is specified, you aren't prompted for confirmation to rename a device. |
| `/reboot:<seconds>` | Shuts down the computer and automatically reboots after the move operation completes. The *seconds* value is the number of seconds before automatic shutdown. The default is **20** seconds. |
| `/securepasswordprompt` | Opens a secure credentials popup for entering credentials. This is useful when specifying smartcard credentials. This option is effective only when the password is entered as `*`. |
| `help` \| `/?` | Displays help at the command prompt. |

> [!NOTE]
> Don't use the `netdom renamecomputer` command to rename an AD DS domain controller (DC). Doing so Might cause the DC to no longer function as a DC on the network. Instead, use the `netdom computername` command.

## Examples

To rename the member server **MyServer** to **MyNewServer**, run the following command:

```cmd
netdom renamecomputer MyServer /newname:MyNewServer
```

If you don't have the appropriate permissions, the `/userd` and `/passwordd` parameters must be specified.

## See also

[Command-Line Syntax Key](command-line-syntax-key.md)
