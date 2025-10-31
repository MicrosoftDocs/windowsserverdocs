---
title: Netdom query
description: Netdom query is a command-line utility that retrieves information from a domain about its membership and trust relationships in Windows Server.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 06/09/2025
---

# netdom query

The `netdom query` command retrieves information from a domain about its membership and trust relationships. It's available if you have the Active Directory Domain Services (AD DS) server role installed. It's also available if you install the AD DS tools that are part of the Remote Server Administration Tools (RSAT). For more information, see [How to Administer Microsoft Windows Client and Server Computers Locally and Remotely](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee649281(v=ws.10)).

To use `netdom query`, you must run the command from an elevated command prompt.

## Syntax

```
netdom query [/Domain:domain] [/Server:server]
             [/UserD:user] [/PasswordD:[password | *]]
             [/Verify] [/Reset] [/Direct] [/SecurePasswordPrompt]
             WORKSTATION | SERVER | DC | OU | PDC | FSMO | TRUST
```

## Parameters

|Parameter|Description|
|---|---|
|`/domain:<Domain>`|Specifies the domain to query for information. If you don't specify this parameter, then `netdom query` uses the domain to which the current computer belongs.|
|`/server:<Server>`|Specifies the name of the domain controller that performs the query.|
|`/userd:<User>`|Specifies the user account that makes the connection with the domain that you specify using the `/domain` parameter. If you don't specify this parameter, `netdom query` uses the current user account.|
|`/passwordd:<Password>` \| `*`|Specifies the password of the user account that you specify using the `/userd` parameter. If you specify the value of this parameter as a wildcard character (`*`), this parameter prompts you for the password.|
|`/verify`|Verifies the secure channel secrets for all listed memberships or trusts and displays the results. Only outbound trusts are verified. Domain administrator credentials are required for accurate verification.|
|`/reset`|Specifies resynchronization of the secure channel secrets for all enumerated memberships or trusts that are currently broken. Domain administrator credentials are required to reset all enumerated trusts or memberships.|
|`/direct`|Indicates that the query for trust relationships returns only direct trust relationships, rather than direct and indirect relationships. This parameter can't be used with the `/verify` parameter.|
|`/securepasswordprompt`|Opens a secure credentials popup for entering credentials. This is useful when specifying smartcard credentials. This option is effective only when the password is entered as `*`.|
|`workstation` \| `server` \| `dc` \| `ou` \| `pdc` \| `fsmo` \| `trust`|Specifies the type of list to generate. The following list shows the possible objects:<br><br>- **Workstation**: Queries the domain for the list of workstations.<br>- **Server**: Queries the domain for the list of servers.<br>- **DC**: Queries the domain for the list of domain controllers.<br>- **OU**: Queries the domain for the list of OUs under which the user that you specify can create a computer object.<br>- **PDC**: Queries the domain for the current primary domain controller.<br>- **FSMO**: Queries the domain for the current list of flexible single master operations (FSMO) role owners. <br>- **Trust**: Queries the domain for the list of its trusts.|
|`help` \| `/?`|Displays help at the command prompt.|

## Examples

To list all the *servers* in the domain **NorthAmerica**, run the following command:

```cmd
netdom query /domain:NorthAmerica SERVER
```

To list all servers and verify the secure channel secret in the domain **NorthAmerica**, run the following command:

```cmd
netdom query /domain:NorthAmerica SERVER /verify
```

To list all the direct trust relationships for the domain **NorthAmerica**, run the following command:

```cmd
netdom query /domain:NorthAmerica /Direct TRUST
```

## See also

[Command-Line Syntax Key](command-line-syntax-key.md)
