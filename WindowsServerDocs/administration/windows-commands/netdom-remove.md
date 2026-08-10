---
title: Netdom remove
description: Netdom remove is a command-line utility that removes a workstation or server from a domain in Windows Server.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 06/09/2025
---

# netdom remove

The `netdom remove` command removes a workstation or server from a domain. It's available if you have the Active Directory Domain Services (AD DS) server role installed. It's also available if you install the AD DS tools that are part of the Remote Server Administration Tools (RSAT). For more information, see [How to Administer Microsoft Windows Client and Server Computers Locally and Remotely](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee649281(v=ws.10)).

To use `netdom remove`, you must run the command from an elevated command prompt.

## Syntax

```
netdom remove machine [/Domain:domain] [/UserD:user]
                      [/PasswordD:[password | *]]
                      [/UserO:user] [/PasswordO:[password | *]]
                      [/Reboot[:Time in seconds]] [/Force]
                      [/SecurePasswordPrompt]
```

## Parameters

|Parameter|Description|
|---|---|
|`<machine>`|Specifies the name of the computer that you want to remove.|
|`/domain:<Domain>`|Specifies the domain from which you want to remove the computer. If not specified, `netdom remove` uses the domain that the current computer belongs to.|
|`/userd:<User>`|Specifies the user account that makes the connection with the domain specified using the `/domain` parameter. If not specified, uses the current user account.|
|`/passwordd:<Password>` \| `*`|Specifies the password of the user account specified using the `/userd` parameter. If set to `*`, you're prompted for the password.|
|`/usero:<User>`|Specifies the user account to make the connection with the computer you want to remove. If not specified, uses the current user account.|
|`/passwordo:<Password>` \| `*`|Specifies the password of the user account specified using the `/usero` parameter. If set to `*`, you're prompted for the password.|
|`/reboot:<seconds>`| Shuts down the computer and automatically reboots after the move operation completes. The *seconds* value is the number of seconds before automatic shutdown. The default is **20** seconds.|
|`/securepasswordprompt`|Opens a secure credentials popup for entering credentials. This is useful when specifying smartcard credentials. This option is effective only when the password is entered as `*`.|
|`help` \| `/?`|Displays help at the command prompt.|

## Examples

To remove **mywksta** from the **MyDomain** domain, run the following command:

```cmd
netdom remove mywksta /domain:MyDomain /userd:MyDomain\admin /passwordd:*
```

## See also

[Command-Line Syntax Key](command-line-syntax-key.md)
