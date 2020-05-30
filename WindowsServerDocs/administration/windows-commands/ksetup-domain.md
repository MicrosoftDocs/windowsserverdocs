---
title: ksetup domain
description: Reference topic for the ksetup domain command, which sets the domain name for all Kerberos operations.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: 2ef766e3-6071-44f2-946b-22ea5b61a508
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ksetup domain

Sets the domain name for all Kerberos operations.

## Syntax

```
ksetup /domain <domainname>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<domainname>` | Name of the domain to which you want to establish a connection. Use the fully-qualified domain name or a simple form of the name, such as contoso.com or contoso.|

### Examples

To establish a connection to a valid domain, such as Microsoft, by using the `ksetup /mapuser` subcommand, type:

```
ksetup /mapuser principal@realm domain-user /domain domain-name
```

After a successful connection, you'll receive a new TGT or an existing TGT will be refreshed.

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [ksetup command](ksetup.md)

- [ksetup mapuser command](ksetup-mapuser.md)