---
title: ksetup changepassword
description: Reference article for the ksetup changepassword command, which uses the Key Distribution Center (KDC) password (kpasswd) value to change the password of the logged-on user.
ms.topic: reference
ms.assetid: 283078e7-a88f-4875-90e6-f8605e6b7ea7
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup changepassword

Uses the Key Distribution Center (KDC) password (kpasswd) value to change the password of the logged-on user. The output of the command informs you of the success or failure status.

You can check whether the **kpasswd** is set, by running the `ksetup /dumpstate` command and viewing the output.


## Syntax

```
ksetup /changepassword <oldpassword> <newpassword>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<oldpassword>` | Specifies the logged-on user's existing password. |
| `<newpassword>` | Specifies the logged on user's new password. This password must meet all the password requirements set on this computer. |

#### Remarks

- If the user account isn't found in the current domain, the system will ask you to supply the domain name where the user account resides.

- If you want to force a password change at next logon, this command allows the use of the asterisk (*) so the user will be prompted for a new password.

-

### Examples

To change the password of a user who is currently logged on to this computer in this domain, type:

```
ksetup /changepassword Pas$w0rd Pa$$w0rd
```

To change the password of a user who is currently logged on in the Contoso domain, type:

```
ksetup /domain CONTOSO /changepassword Pas$w0rd Pa$$w0rd
```

To force the currently logged on user to change the password at the next logon, type:

```
ksetup /changepassword Pas$w0rd *
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)

- [ksetup dumpstate command](ksetup-dumpstate.md)

- [ksetup addkpasswd command](ksetup-addkpasswd.md)

- [ksetup delkpasswd command](ksetup-delkpasswd.md)

- [ksetup dumpstate command](ksetup-dumpstate.md)
