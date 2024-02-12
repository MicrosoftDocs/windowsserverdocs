---
title: ksetup dumpstate
description: Reference article for the ksetup dumpstate commnand, which displays the current state of realm settings for all realms that are defined on the computer.
ms.topic: reference
ms.assetid: 3ef2f7b8-97af-4f42-9542-cff324840637
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup dumpstate

Displays the current state of realm settings for all realms that are defined on the computer. This command displays the same output as the **ksetup** command.

## Syntax

```
ksetup /dumpstate
```

### Remarks

- The output of this command includes the default realm (the domain that the computer is a member of) and all the realms that are defined on this computer. The following is included for each realm:

  - All the Key Distribution Centers (KDCs) that are associated with this realm.

  - All the **set realm** flags for this realm.

  - The KDC password.

- This command doesn't display the domain name specified by DNS detection or by the command `ksetup /domain`.

- This command doesn't display the computer password set by using the command `ksetup /setcomputerpassword`.

## Examples

To locate the Kerberos realm configurations on a computer, type:

```
ksetup /dumpstate
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)