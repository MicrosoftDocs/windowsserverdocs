---
title: Ksetup:domain
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 2ef766e3-6071-44f2-946b-22ea5b61a508
---
# Ksetup:domain
Sets the domain name for all Kerberos operations. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
ksetup /domain <DomainName>
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<DomainName>|Name of the domain to which you want to establish a connection. Use the fully qualified domain name or a simple form of the name, such as contoso.com or contoso.|

## Remarks
None.

## <a name="BKMK_Examples"></a>Examples
Establish a connection to a valid domain, such as Microsoft by using the \/mapuser subcommand:

```
ksetup /mapuser principal@realm domain-user /domain domain-name
```

When the connection is successful, you will receive a new TGT or an existing TGT will be refreshed.

## Additional references

-   [Ksetup](Ksetup.md)

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)


