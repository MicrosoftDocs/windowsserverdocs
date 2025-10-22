---
title: Netdom add
description: Netdom add is a command-line utility that adds a workstation or server account to a domain in Windows Server.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 06/09/2025
---

# netdom add

The `netdom add` command adds a workstation or server account to a domain. It's available if you have the Active Directory Domain Services (AD DS) server role installed. It's also available if you install the AD DS tools that are part of the Remote Server Administration Tools (RSAT). To use `netdom add`, you must run the command from an elevated command prompt.

## Syntax

```
netdom add machine [/Domain:domain] [/UserD:user] [/PasswordD:[password | *]]
                   [/Server:server] [/OU:ou path] [/DC] [/SecurePasswordPrompt]
```

## Parameters

|Parameter|Description|
|---|---|
|`<machine>`|Specifies the name of the computer that you want to add.|
|`/domain:<Domain>`|Specifies the domain in which to create the account. If you don't specify this parameter, then `netdom add` uses the domain that the current computer belongs to.|
|`/userd:<User>`|Specifies the user account that makes the connection with the domain that you specify using the `/domain` parameter. If you don't specify this parameter, `netdom add` uses the current user account.|
|`/passwordd:<Password>` \| `*`|Specifies the password of the user account that you specify using the `/userd` parameter. If you specify the value of this parameter as a wildcard character (`*`), this parameter prompts you for the password.|
|`/server:<Server>`|Specifies the name of a domain controller that performs the *add* operation. This parameter can't be used with the `/ou` parameter.|
|`/ou:<OUPath>`|Specifies the organizational unit (OU) under which to create the account. You must use the full [RFC 1779](https://www.rfc-editor.org/rfc/rfc1779) distinguished name of the OU. If you don't specify this parameter, `netdom add` creates the account under the default OU for computer objects for that domain.|
|`/dc`|Specifies that a domain controller's machine account is to be created. This makes it possible for the computer accounts for new AD DS domain controllers. This parameter can't be used with the **/ou** parameter.|
| `/securepasswordprompt` | Opens a secure credentials popup for entering credentials. This is useful when specifying smartcard credentials. This option is effective only when the password is entered as `*`. |
|`help` \| `/?`|Displays help at the command prompt.|

## Examples

To add the workstation **mywksta** to the domain **reskita** using the credentials of a domain administrator, run the following command:

```cmd
netdom add mywksta /domain:reskita /userd:domainadmin /passwordd:*
```

To add a computer named **Srv01** to the domain **reskita.com** and specify the organizational unit (OU) where the computer account should be placed, run the following command:

```cmd
netdom add Srv01 /domain:reskita /OU:"OU=Servers,DC=reskita,DC=com" /userd:domainadmin /passwordd:*
```

> [!NOTE]
> If you don't specify the `/ou` parameter, `netdom add` creates the account in the **Computers** container.

## See also

[Command-Line Syntax Key](command-line-syntax-key.md)
