---
title: ksetup:removerealm
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 39f0c6f0-4c50-4781-941e-0893495405e8
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ksetup:removerealm



Deletes all information for the specified realm from the registry. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
ksetup /removerealm <RealmName>
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<RealmName>|The realm name is stated as an uppercase DNS name, such as CORP.CONTOSO.COM, and it is listed as the default realm when **ksetup** is run.|

## Remarks

The realm name is stored in two places in the registry: **HKEY_LOCAL_MACHINE\SYSTEM\ControlSet001** and **\CurrentControlSet\Control\Lsa\Kerberos**.

You cannot remove the default realm name from the domain controller because this will reset its DNS information, and removing it might make the domain controller unusable.

## <a name="BKMK_Examples"></a>Examples

Mistakenly set the realm name by misspelling ".COM" on the local computer to CORP.CONTOSO.CON
```
ksetup /setrealm CORP.CONTOSO.CON
```
Remove that erroneous realm name from the local computer:
```
ksetup /removerealm CORP.CONTOSO.CON
```
Verify the removal by running **ksetup** and review the output.

#### Additional references

-   [Ksetup](ksetup.md)
-   [Ksetup:setrealm](ksetup-setrealm.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)