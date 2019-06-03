---
title: ksetup:mapuser
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 84113e6e-89ff-488a-9cd0-f14bbf23b543
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ksetup:mapuser



Maps the name of a Kerberos principal to an account. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
ksetup /mapuser <Principal> <Account>
```

### Parameters

|  Parameter   |                                                   Description                                                   |
|--------------|-----------------------------------------------------------------------------------------------------------------|
| \<Principal> |              The fully qualified domain name of any principal; for example, mike@corp.CONTOSO.COM.              |
|  \<Account>  | Any account or security group name that exists on this computer, such as Guest, Domain Users, or Administrator. |

## Remarks

An account can be specifically identified, such as domain guests. Or you can use the wildcard character (*) to include all accounts.

If an account name is omitted, mapping is deleted for the specified principal.

The computer will only authenticate the principals of the given realm if they present valid Kerberos tickets.

Use **ksetup** without any parameters or arguments to see the current mapped settings and the default realm.

Whenever changes are made to the external Key Distribution Center (KDC) and the realm configuration, a restart of the computer where the setting was changed is required.

## <a name="BKMK_Examples"></a>Examples

Map Mike Danseglio's account within the Kerberos realm CONTOSO to the guest account on this computer, granting him all the privileges of a member of the built-in Guest account without having to authenticate to this computer:
```
ksetup /mapuser mike@corp.CONTOSO.COM guest
```
Remove the mapping of Mike Danseglio's account to the guest account on this computer to prevent him from authenticating to this computer with his credentials from CONTOSO:
```
ksetup /mapuser mike@corp.CONTOSO.COM 
```
Map Mike Danseglio's account within the CONTOSO Kerberos realm to any existing account on this computer. (if only the standard user and guest accounts are active on this computer, Mike's privileges will be set to those):
```
ksetup /mapuser mike@corp.CONTOSO.COM *
```
Map all accounts within the CONTOSO Kerberos realm to any existing account of the same name on this computer:
```
ksetup /mapuser * *
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Ksetup](ksetup.md)