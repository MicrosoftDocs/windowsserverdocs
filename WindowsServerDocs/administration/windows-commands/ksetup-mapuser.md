---
title: ksetup mapuser
description: Reference article for the ksetup mapuser command, which maps the name of a Kerberos principal to an account.
ms.topic: reference
ms.assetid: 84113e6e-89ff-488a-9cd0-f14bbf23b543
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup mapuser

Maps the name of a Kerberos principal to an account.

## Syntax

```
ksetup /mapuser <principal> <account>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<principal>` | Specifies the fully-qualified domain name of any principal user. For example, mike@corp.CONTOSO.COM. If you don't specify an account parameter, mapping is deleted for the specified principal. |
| `<account>` | Specifies any account or security group name that exists on this computer, such as **Guest**, **Domain Users**, or **Administrator**. If this parameter is omitted, mapping is deleted for the specified principal. |

#### Remarks

- An account can be specifically identified, such as **Domain Guests**, or you can use a wildcard character (*) to include all accounts.

- The computer only authenticates the principals of the given realm if they present valid Kerberos tickets.

- Whenever changes are made to the external Key Distribution Center (KDC) and the realm configuration, a restart of the computer where the setting was changed is required.

### Examples

To see the current mapped settings and the default realm, type:

```
ksetup
```

To map Mike Danseglio's account within the Kerberos realm CONTOSO to the guest account on this computer, granting him all the privileges of a member of the built-in Guest account without having to authenticate to this computer, type:

```
ksetup /mapuser mike@corp.CONTOSO.COM guest
```

To remove the mapping of Mike Danseglio's account to the guest account on this computer to prevent him from authenticating to this computer with his credentials from CONTOSO, type:

```
ksetup /mapuser mike@corp.CONTOSO.COM
```

To map Mike Danseglio's account within the CONTOSO Kerberos realm to any existing account on this computer, type:

```
ksetup /mapuser mike@corp.CONTOSO.COM *
```

> [!NOTE]
> If only the Standard User and Guest accounts are active on this computer, Mike's privileges are set to those.

To map all accounts within the CONTOSO Kerberos realm to any existing account of the same name on this computer, type:

```
ksetup /mapuser * *
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)
