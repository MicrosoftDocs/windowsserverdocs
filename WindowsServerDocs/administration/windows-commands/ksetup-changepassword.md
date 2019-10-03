---
title: ksetup:changepassword
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 283078e7-a88f-4875-90e6-f8605e6b7ea7
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ksetup:changepassword



Uses the Key Distribution Center (KDC) password (kpasswd) value to change the password of the logged-on user. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
ksetup /changepassword <OldPasswd> <NewPasswd>
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<OldPasswd>|States the logged-on user's existing password.|
|\<NewPasswd>|States the logged on user's new password.|

## Remarks

This command uses the KDC password (kpasswd) value to change the password of the logged-on user. The kpasswd, if set, is displayed in the output by running the **ksetup /dumpstate** command.

The user's new password must meet all the password requirements that are set on this computer.

If the user account is not found in the current domain, the system will ask you to supply the domain name where the user account resides.

If you want to force a password change at next logon, this command allows the use of the asterisk (*) so the user will be prompted for a new password.

The output of the command informs you of the success or failure status.

## <a name="BKMK_Examples"></a>Examples

Change the password of a user who is currently logged on to this computer in this domain:
```
ksetup /changepassword Pas$w0rd Pa$$w0rd
```
Change the password of a user who is currently logged on in the Contoso domain:
```
ksetup /domain CONTOSO /changepassword Pas$w0rd Pa$$w0rd
```
Force the currently logged on user to change the password at the next logon:
```
ksetup /changepassword Pas$w0rd *
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)