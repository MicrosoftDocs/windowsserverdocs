---
title: secedit:validate
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9fb06354-f55a-4ca4-9fbc-9a872eb9b9cf
---
# secedit:validate
Validates the security settings stored in a security template \(.inf file\). for examples of how this command can be used, see [Examples](seceditvalidate.md#BKMK_Examples).

## Syntax

```
secedit /validate <configuration file name>

```

### Parameters

|Parameter|Description|
|-------------|---------------|
|Configuration file name|Required.<br /><br />Specifies the path and file name for the security template that will be validated.|

## remarks
Validating security templates can help you if one is corrupted or inappropriately set.

An invalid security template will not be applied.

The log file will not be updated.

In Windows Server 2008, `secedit /refreshpolicy` has been replaced with `gpupdate`. for information on how to refresh security settings, see [gpupdate]().

## <a name="BKMK_Examples"></a>Examples
After a rollback is performed on a security template, you want to verify that the rollback inf file, secRBKcontoso.inf, is valid.

```
secedit /validate secRBKcontoso.inf
```

## additional references

-   [secedit:generaterollback](seceditgeneraterollback.md)

-   [secedit](secedit.md)

-   [Command-Line Syntax Key](../../commandline-syntax-key.md)


