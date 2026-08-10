---
title: Netdom
description: Netdom is a command-line utility for administering Active Directory (AD) domains, managing computer accounts, and configuring or verifying trust relationships between domains.
ms.topic: reference
ms.author: roharwoo
author: robinharwood
ms.date: 06/09/2025
---

# netdom

`Netdom` is a command-line tool that enables administrators to manage Active Directory (AD) domains and trust relationships from the command line. It's available if you have the Active Directory Domain Services (AD DS) server role installed. It's also available if you install the AD DS tools that are part of the Remote Server Administration Tools (RSAT). To learn more, see [How to Administer Microsoft Windows Client and Server Computers Locally and Remotely](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/ee649281(v=ws.10)).

You must run the `netdom` command from an elevated command prompt. The `netdom` allows you to performing the following actions:

- Add a device to a domain:

  - This process involves creating a computer account in the domain's directory. The computer and the domain exchange security credentials, allowing the domain to authenticate and authorize the computer.

  - You can also remove query, and move an existing computer account for a member workstation from one domain to another while maintaining the security descriptor on the computer account.

- Manage computer accounts for domain member workstations and member servers:

  - Computer accounts in a domain are similar to user accounts but represent computers. Managing these accounts involves making sure they're correctly configured and secure. It includes activities such as renaming the computer within the domain or updating its credentials to maintain its ability to communicate securely with the domain controllers.

- Establish one-way or two-way trust relationships between domains:

  - A one-way trust means that one domain trusts the users from another domain but not vice versa.

  - A two-way trust allows mutual access.

  - Trusts can be transitive, meaning they extend beyond two domains, or non-transitive, limited to the direct trust link. This is crucial for organizations with multiple domain environments to manage resources and user access efficiently.

- Verifies or resets the secure channel:

  - A secure channel is a communication link established between a computer and a domain controller for exchanging authentication information. This channel needs to remain secure to protect sensitive data.

  - If the secure channel becomes disrupted, a verification checks its status. If issues are detected, resetting the channel re-establishes this secure communication link by updating credentials and ensuring the computer can authenticate with the domain controller again.

- Manage trust relationships between domains:

  - Managing trust relationships involves routinely verifying that these relationships are still valid and functioning as intended. It also includes modifying or removing them per organization needs.

  - Proper management ensures that resources remain secure while accessible and helps to maintain an efficient cross-domain interaction.

## Syntax

```
netdom [ ADD | COMPUTERNAME | HELP | JOIN | MOVE | MOVENT4BDC | QUERY | REMOVE | RENAMECOMPUTER | RESET | RESETPWD | TRUST | VERIFY ]
```

## Commands

| Command | Description |
|---------|-------------|
| [netdom add](netdom-add.md) | Adds a workstation or server account to the domain. |
| [netdom computername](netdom-computername.md) | Manages the primary and alternate names for a computer. This command can safely rename Active Directory domain controllers and member servers. |
| [netdom join](netdom-join.md) | Joins a workstation or member server to a domain. The act of joining a computer to a domain creates an account for the computer on the domain, if it doesn't already exist. |
| [netdom move](netdom-move.md) | Moves a workstation or member server to a new domain. The act of moving a computer to a new domain creates an account for the computer on the domain, if it doesn't already exist. |
| [netdom movent4bdc](netdom-movent4bdc.md) | Renames a Windows NT 4.0 backup domain controller to reflect a domain name change. This can help Windows NT 4.0 domain renaming efforts. |
| [netdom query](netdom-query.md) | Queries the domain for information such as membership and trust. |
| [netdom remove](netdom-remove.md) | Removes a workstation or server from the domain. |
| [netdom renamecomputer](netdom-renamecomputer.md) | Renames a domain computer and its corresponding domain account. Use this command to rename domain workstations and member servers only. To rename domain controllers, use the `netdom computername` command. |
| [netdom reset](netdom-reset.md) | Resets the secure connection between a workstation and a domain controller. |
| [netdom resetpwd](netdom-resetpwd.md) | Resets the computer account password for a domain controller. |
| [netdom trust](netdom-trust.md) | Establishes, verifies, or resets a trust relationship between domains. |
| [netdom verify](netdom-verify.md) | Verifies the secure connection between a workstation and a domain controller. |

## Remarks

- A trust relationship is a defined affiliation between domains that enables pass-through authentication.

- A one-way trust relationship between two domains means that one domain (the trusting domain) allows users who have accounts on the other domain (the trusted domain), access to its resources.

- The one-way trust relationship described is helpful in primary domain models, but it isn't the only type of trust relationship. When two one-way trusts are established between domains, it's known as a two-way trust. In two-way trusts, each domain treats the users from the trusted (and trusting) domain as its own users.

- If you specify the `/verbose` parameter, the output lists the success or failure of each transaction that is necessary to perform the operation.

- The `/reboot` parameter specifies that the computer specified by this operation is automatically rebooted after the completion of the operation.

- The default delay before the computer restarts is 20 seconds.

## See also

[Command-Line Syntax Key](command-line-syntax-key.md)
