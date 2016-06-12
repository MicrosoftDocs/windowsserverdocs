---
title: Using the get-AllNamespaces Command
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e8fe896d-a69a-4180-923b-9f18185f5941
---
# Using the get-AllNamespaces Command
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

## Parameters

|Parameter|Windows Server 2008|Windows Server 2008 R2|
|-------------|-----------------------|--------------------------|
|\[\/Server:<Server name>\]|Specifies the name of the server. This can be either the NetBIOS name or the fully qualified domain name \(FQDN\). if no server name is specified, the local server will be used.||
|\[\/ContentProvider:<name>\]|Displays the namespaces for the specified content provider only.||
|\[\/Show:Clients\]|Only supported for Windows Server 2008. Displays information about client computers that are connected to the namespace.||
|\[\/details:Clients\]|Only supported for Windows Server 2008 R2. Displays information about client computers that are connected to the namespace.||
|\[\/ExcludedeletePending\]|Excludes any deactivated transmissions from the list.||

## <a name="BKMK_examples"></a>Examples
To view all namespaces, type:

```
wdsutil /Get-AllNamespaces
```

To view all namespaces except those that are deactivated, type:

-   Windows Server 2008

    ```
    wdsutil /Get-AllNamespaces /Server:MyWDSServer /ContentProvider:"MyContentProv" /Show:Clients /ExcludedeletePending
    ```

-   Windows Server 2008 R2

    ```
    wdsutil /Get-AllNamespaces /Server:MyWDSServer /ContentProvider:"MyContentProv" /details:Clients /ExcludedeletePending
    ```

#### additional references
[Command-Line Syntax Key](../../commandline-syntax-key.md)

[Using the new-Namespace Command](../using-new-command/using-newnamespace-command.md)

[Using the remove-Namespace Command](../using-remove-command/using-removenamespace-command.md)

[Subcommand: start-Namespace](../the-start-server-command/subcommand-startnamespace.md)


