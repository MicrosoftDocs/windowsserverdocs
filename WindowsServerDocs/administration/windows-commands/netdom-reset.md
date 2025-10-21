---
title: Netdom reset
description: Netdom reset is a command-line utility that resets the secure connection between a workstation and a domain controller in Windows Server.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 06/09/2025
---

# netdom reset

The `netdom reset` command resets the secure connection between a workstation and a domain controller (DC). It's available if you have the Active Directory Domain Services (AD DS) server role installed. It's also available if you install the AD DS tools that are part of the Remote Server Administration Tools (RSAT). For more information, see [How to Administer Microsoft Windows Client and Server Computers Locally and Remotely](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee649281(v=ws.10)).

To use `netdom reset`, you must run the command from an elevated command prompt.

## Syntax

```
netdom reset machine [/Domain:domain] [/Server:server]
                     [/UserO:user] [/PasswordO:[password | *]] [/SecurePasswordPrompt]
```

## Parameters

|Parameter|Description|
|---|---|
|`<machine>`|Specifies the name of the computer whose secure connection you want to reset.|
|`/domain:<Domain>`|Specifies the domain with which to establish the secure connection. If not specified, `netdom reset` uses the domain to which the current computer belongs.|
|`/server:<Server>`|Specifies the DC to use to establish the secure connection.|
|`/usero:<User>`|Specifies the user account to use to make the secure connection with the computer that you want to reset. If not specified, `netdom reset` uses the current user account.|
|`/passwordo:<Password>` \| `*`|Specifies the password of the user account specified using the `/usero` parameter. If you use the wildcard character (`*`), you're prompted for the password.|
|`/securepasswordprompt`|Opens a secure credentials popup for entering credentials. This is useful when specifying smartcard credentials. This option is effective only when the password is entered as `*`.|
|`help` \| `?`|Displays help at the command prompt.|

## Examples

To reset the secure channel secret that is maintained between **mywksta** and **devgroup.contoso.com**, run the following command:

```cmd
netdom reset mywksta /domain:devgroup.contoso.com
```

To reset the secure channel between the primary DC for **NorthAmerica** and the backup DC **BackupDC**, run the following command:

```cmd
netdom reset BackupDC /domain:NorthAmerica
```

Member servers frequently establish secure channel sessions with DCs that aren't local to their site. To force a secure channel session between member server **mywksta** and a specific DC, **MyOtherDC**, run the following command:

```cmd
netdom reset mywksta /domain:MyDomain.contoso.com /Server:MyOtherDC
```

## See also

[Command-Line Syntax Key](command-line-syntax-key.md)
