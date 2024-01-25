---
title: ksetup getenctypeattr
description: Reference article for the ksetup getenctypeattr command, which retrieves the encryption type attribute for the domain.
ms.topic: reference
ms.assetid: 6c7ec002-355e-474d-bc27-27215049f1a8
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup getenctypeattr

Retrieves the encryption type attribute for the domain. A status message is displayed upon successful or failed completion.

You can view the encryption type for the Kerberos ticket-granting ticket (TGT) and the session key, by running the **klist** command and viewing the output. You can set the domain to connect to and use, by running the `ksetup /domain <domainname>` command.

## Syntax

```
ksetup /getenctypeattr <domainname>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<domainname>` | Name of the domain to which you want to establish a connection. Use the fully-qualified domain name or a simple form of the name, such as corp.contoso.com or contoso. |

### Examples

To verify the encryption type attribute for the domain, type:

```
ksetup /getenctypeattr mit.contoso.com
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [klist command](klist.md)

- [ksetup command](ksetup.md)

- [ksetup domain command](ksetup-domain.md)

- [ksetup addenctypeattr command](ksetup-addenctypeattr.md)

- [ksetup setenctypeattr command](ksetup-setenctypeattr.md)

- [ksetup delenctypeattr command](ksetup-delenctypeattr.md)
