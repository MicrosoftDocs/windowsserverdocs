---
title: vssadmin list providers
titleSuffix: in Windows and Windows Server
description: Use the vssadmin list providers command to show the registered volume shadow copy providers on a computer, including their type and version.
ms.topic: reference
author: robinharwood
ms.author: roharwoo
ms.date: 09/07/2026
ai-usage: ai-assisted
---

# vssadmin list providers

Lists the volume shadow copy providers registered on the computer. A shadow copy provider is the component that creates and manages shadow copies (point-in-time snapshots) of a volume. A provider can be the built-in system provider that Windows includes, or a software or hardware provider that a storage vendor supplies.

Run this command when you want to confirm which providers are available before you create a shadow copy, or to verify that a vendor-supplied provider is installed and registered correctly.

## Syntax

```
vssadmin list providers
```

## Examples

To list all registered volume shadow copy providers, type:

```
vssadmin list providers
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [vssadmin command](vssadmin.md)
