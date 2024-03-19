---
title: ksetup delenctypeattr
description: Reference article for the ksetup delenctypeattr, which removes the encryption type attribute for the domain.
ms.topic: reference
ms.assetid: 4fc25ef3-e271-4229-a712-72c507df55aa
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup delenctypeattr

Removes the encryption type attribute for the domain. A status message is displayed upon successful or failed completion.

You can view the encryption type for the Kerberos ticket-granting ticket (TGT) and the session key, by running the **klist** command and viewing the output. You can set the domain to connect to and use, by running the `ksetup /domain <domainname>` command.

## Syntax

```
ksetup /delenctypeattr <domainname>
```

### Parameters

| Parameter | Description |
| ----------| ----------- |
| `<domainname>` | Name of the domain to which you want to establish a connection. You can use either the fully-qualified domain name or a simple form of the name, such as corp.contoso.com or contoso. |

### Examples

To determine the current encryption types that are set on this computer, type:

```
klist
```

To set the domain to mit.contoso.com, type:

```
ksetup /domain mit.contoso.com
```

To verify what the encryption type attribute is for the domain, type:

```
ksetup /getenctypeattr mit.contoso.com
```

To remove the set encryption type attribute for the domain mit.contoso.com, type:

```
ksetup /delenctypeattr mit.contoso.com
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [klist command](klist.md)

- [ksetup command](ksetup.md)

- [ksetup domain command](ksetup-domain.md)

- [ksetup addenctypeattr command](ksetup-addenctypeattr.md)

- [ksetup setenctypeattr command](ksetup-setenctypeattr.md)
