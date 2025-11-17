---
title: Netdom move
description: Netdom move is a command-line utility moves a workstation or member server to a new domain in Windows Server.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 06/09/2025
---

# netdom move

The `netdom move` command moves a workstation or member server to a new domain. The act of moving a computer to a new domain creates an account for the computer on the domain, if it doesn't already exist. It's available if you have the Active Directory Domain Services (AD DS) server role installed. It's also available if you install the AD DS tools that are part of the Remote Server Administration Tools (RSAT). To use `netdom move`, you must run the command from an elevated command prompt.

## Syntax

```
netdom move machine /Domain:domain [/OU:ou path]
                    [/UserD:user] [/PasswordD:[password | *]]
                    [/UserO:user] [/PasswordO:[password | *]]
                    [/UserF:user] [/PasswordF:[password | *]]
                    [/Reboot[:Time in seconds]]
                    [/SecurePasswordPrompt]
```

## Parameters

> [!NOTE]
> When you move a computer to a new domain, `netdom move` doesn't delete its computer account in the former domain. However, if you supply credentials for the former domain, this command disables the old computer account.

| Parameter | Description |
|-----------|-------------|
| `<machine>` | Specifies the name of the computer that you want to move. |
| `/domain:<Domain>` | Specifies the domain to which you want to move the account. If you don't specify the parameter, then `netdom move` uses the domain to which the current computer belongs. |
| `/ou:<OUPath>` | Specifies the organizational unit (OU) under which to create the account. This must be the full [RFC 1779](https://www.rfc-editor.org/rfc/rfc1779) distinguished name of the OU. If you don't specify this parameter, `netdom move` creates the account under the default OU for computer objects for that domain. |
| `/userd:<User>` | Specifies the user account that makes the connection with the domain that you specify using the `/domain` parameter. If you don't specify this parameter, `netdom move` uses the current user account. |
| `/passwordd:<Password>` \| `*` | Specifies the password of the user account that you specify using the `/userd` parameter. If you specify the value of this parameter as a wildcard character (`*`), this parameter prompts you for the password. |
| `/usero:<User>` | Specifies the user account to make the connection with the computer that you want to move. If you don't specify this parameter, `netdom move` uses the current user account. |
| `/passwordo:<Password>` \| `*` | Specifies the password of the user account that you specify using the `/usero` parameter. If you specify the value of this parameter as a wildcard character (`*`), this parameter prompts you for the password. |
| `/userf:<User>` | Specifies the user account to make the connection with the computer's former domain (of which the computer was a member before the move). This parameter is used to disable the old computer account. |
| `/passwordf:<Password>` \| `*` | Specifies the password of the user account that you specify using the `/userf` parameter. If you specify the value of this parameter as a wildcard character (`*`), this parameter prompts you for the password. |
| `/reboot:<seconds>` | Shuts down the computer and automatically reboots after the move operation completes. The *seconds* value is the number of seconds before automatic shutdown. The default is **20** seconds. |
| `/securepasswordprompt` | Opens a secure credentials popup for entering credentials. This is useful when specifying smartcard credentials. This option is effective only when the password is entered as `*`. |
| `help` \| `/?` | Displays help at the command prompt. |

## Examples

To move **mywksta** from its current domain into the **MyDomain** domain, run the following command:

```cmd
netdom move mywksta /domain:mydomain /userd:mydomain\admin /passwordd:*
```

If the destination is an AD DS domain, this command updates the Security ID history for the workstation, retaining the security permissions that the computer account had previously.

To move **Srv01** to the domain **NewDomain** and specify the OU, run the following command:

```cmd
netdom move svr01 /domain:newdomain /ou:"OU=Workstations,OU=Resources,DC=NewDomain,DC=local" /userd:NewDomain\DomainAdmin /passwordd:*
```

## See also

[Command-Line Syntax Key](command-line-syntax-key.md)
