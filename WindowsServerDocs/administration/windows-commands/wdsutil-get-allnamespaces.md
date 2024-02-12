---
title: wdsutil get-allnamespaces
description: Reference article for wdsutil get-allnamespaces, which displays information about all namespaces on a server.
ms.topic: reference
ms.assetid: e8fe896d-a69a-4180-923b-9f18185f5941
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# wdsutil get-allnamespaces

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays information about all namespaces on a server.

## Syntax

Windows Server 2008:

```
wdsutil /Get-AllNamespaces [/Server:<Server name>] [/ContentProvider:<name>] [/Show:Clients] [/ExcludedeletePending]
```

Windows Server 2008 R2:

```
wdsutil /Get-AllNamespaces [/Server:<Server name>] [/ContentProvider:<name>] [/details:Clients] [/ExcludedeletePending]
```

### Parameters

|         Parameter         |                                                                               Windows Server 2008                                                                               | Windows Server 2008 R2 |
|---------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|------------------------|
|  [/Server:\<Server name\>]  | Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name (FQDN). If no server name is specified, the local server will be used. |                        |
| [/ContentProvider:\<name\>] |                                                        Displays the namespaces for the specified content provider only.                                                         |                        |
|      [/Show:Clients]      |                            Only supported for Windows Server 2008. Displays information about client computers that are connected to the namespace.                             |                        |
|    [/details:Clients]     |                           Only supported for Windows Server 2008 R2. Displays information about client computers that are connected to the namespace.                           |                        |
|  [/ExcludedeletePending]  |                                                              Excludes any deactivated transmissions from the list.                                                              |                        |

## Examples
To view all namespaces, type:
```
wdsutil /Get-AllNamespaces
```
To view all namespaces except those that are deactivated, type:
- Windows Server 2008
  ```
  wdsutil /Get-AllNamespaces /Server:MyWDSServer /ContentProvider:MyContentProv /Show:Clients /ExcludedeletePending
  ```
- Windows Server 2008 R2
  ```
  wdsutil /Get-AllNamespaces /Server:MyWDSServer /ContentProvider:MyContentProv /details:Clients /ExcludedeletePending
  ```

## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [wdsutil new-namespace command](wdsutil-new-namespace.md)
- [wdsutil remove-namespace command](wdsutil-remove-namespace.md)
- [wdsutil start-nmespace command](wdsutil-start-namespace.md)
