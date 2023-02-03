---
title: ksetup addenctypeattr
description: Reference article for the ksetup addenctypeattr command, which adds the encryption type attribute to the list of possible types for the domain.
ms.topic: reference
ms.assetid: 32cc87d7-b9e1-4d14-9eb7-3b439c55aa3a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# ksetup addenctypeattr

Adds the encryption type attribute to the list of possible types for the domain. A status message is displayed upon successful or failed completion.

## Syntax

```
ksetup /addenctypeattr <domainname> {DES-CBC-CRC | DES-CBC-MD5 | RC4-HMAC-MD5 | AES128-CTS-HMAC-SHA1-96 | AES256-CTS-HMAC-SHA1-96}
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<domainname>` | Name of the domain to which you want to establish a connection. Use the fully qualified domain name or a simple form of the name, such as corp.contoso.com or contoso. |
| encryption type | Must be one of the following supported encryption types:<ul><li>DES-CBC-CRC</li><li>DES-CBC-MD5</li><li>RC4-HMAC-MD5</li><li>AES128-CTS-HMAC-SHA1-96</li><li>AES256-CTS-HMAC-SHA1-96</li></ul> |

#### Remarks

- You can set or add multiple encryption types by separating the encryption types in the command with a space. However, you can only do so for one domain at a time.

### Examples

To view the encryption type for the Kerberos ticket-granting ticket (TGT) and the session key, type:

```
klist
```

To set the domain to corp.contoso.com, type:

```
ksetup /domain corp.contoso.com
```

To add the encryption type *AES-256-CTS-HMAC-SHA1-96* to the list of possible types for the domain *corp.contoso.com*, type:

```
ksetup /addenctypeattr corp.contoso.com AES-256-CTS-HMAC-SHA1-96
```

To set the encryption type attribute to *AES-256-CTS-HMAC-SHA1-96* for the domain *corp.contoso.com*, type:

```
ksetup /setenctypeattr corp.contoso.com AES-256-CTS-HMAC-SHA1-96
```

To verify that the encryption type attribute was set as intended for the domain, type:

```
ksetup /getenctypeattr corp.contoso.com
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [klist command](klist.md)

- [ksetup command](ksetup.md)

- [ksetup domain command](ksetup-domain.md)

- [ksetup setenctypeattr command](ksetup-setenctypeattr.md)

- [ksetup getenctypeattr command](ksetup-getenctypeattr.md)

- [ksetup delenctypeattr command](ksetup-delenctypeattr.md)
