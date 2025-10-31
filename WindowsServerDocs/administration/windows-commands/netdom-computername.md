---
title: Netdom computername
description: Netdom computername is a command-line utility that manages the primary and alternate names for a computer in Windows Server.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 06/09/2025
---

# netdom computername

The `netdom computername` command manages the primary and alternate names for a computer. This command can safely rename Active Directory (AD) domain controllers (DC) and member servers. It's available if you have the Active Directory Domain Services (AD DS) server role installed. It's also available if you install the AD DS tools that are part of the Remote Server Administration Tools (RSAT). To use `netdom computername`, you must run the command from an elevated command prompt.

## Syntax

```
netdom computername machine [/UserO:user] [/PasswordO:[password | *]]
                            [/UserD:user] [/PasswordD:[password | *]] [/SecurePasswordPrompt]
                            /Add:<new-alternate-DNS-name> | /Remove:<alternate-DNS-name>
                            /MakePrimary:<computer-dns-name>
                            /Enumerate[:{AlternateNames | PrimaryName | AllNames}]
                            /Verify
```

## Parameters

| Parameter | Description |
|---|---|
| `<machine>` | Specifies the name of the computer that you want to manage. |
| `/usero:<UserName>` | Specifies the user account that you want to use for the originating domain. |
| `/passwordo:<Password>` \| `*` | Specifies the password that you want to use for the originating domain. If you specify `*`, you're prompted for the password. |
| `/userd:<UserName>` | Specifies the user account that you want to use for the destination domain. |
| `/passwordd:<Password>` \| `*` | Specifies the password that you want to use for the destination domain. If you specify `*`, you're prompted for the password. |
| `/securepasswordprompt` | Opens a secure credentials popup for entering credentials. This is useful when specifying smartcard credentials. This option is effective only when the password is entered as `*`. |
| `/add:<NewAltDNSName>` | Creates a new alternate name. Specify a fully qualified domain name (FQDN), such as `comp1.example.com`. |
| `/remove:<AltDNSName>` | Deletes an existing alternate name. Specify an FQDN, such as `comp1.example.com`. |
| `/makeprimary:<ComputerDNSName>` | Makes an existing alternate name into the primary name. Specify an FQDN, such as `comp1.example.com`. |
| `/enumerate:ALTERNATENAMES` \| `PRIMARYNAME`\| `ALLNAMES` | Lists the primary name or any alternate names. Values:<br>- `ALTERNATENAMES`: Lists alternate names only.<br>- `PRIMARYNAME`: Lists the primary name only.<br>- `ALLNAMES`: Lists the primary and any alternate names (default). |
| `/verify` | Checks if there's a DNS record and a service principal name (SPN) for each computer name. |
| `help` \| `/?` | Displays help at the command prompt. |

## Examples

To give an alternate name for the DC **MyDC** in the **mydomain.com** domain, run the following command:

```cmd
netdom computername mydc.mydomain.com /add:altDCname.mydomain.com
```

Before you can make an alternate name the primary name of a computer, the name must exist as an alternate name.

Once the alternate name is added, you can promote it to be the primary name. To rename the domain controller **MyDC** to **altDCname** in the **mydomain.com** domain, use the following command:

```cmd
netdom computername mydc.mydomain.com /makeprimary:altdcname.mydomain.com
```

When you rename a member server, the process is similar. Use an existing alternate name as the new primary name.

## See also

[Command-Line Syntax Key](command-line-syntax-key.md)
