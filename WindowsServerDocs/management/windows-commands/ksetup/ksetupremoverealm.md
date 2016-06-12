---
title: ksetup:removerealm
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 39f0c6f0-4c50-4781-941e-0893495405e8
---
# ksetup:removerealm
deletes all information for the specified realm from the registry. for examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
ksetup /removerealm <RealmName>
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<RealmName>|The realm name is stated as an uppercase DNS name, such as CORP.CONTOSO.COM, and it is listed as the default realm when **ksetup** is run.|

## remarks
The realm name is stored in two places in the registry: **HKEY\_LOCAL\_MACHINE\\SYSTEM\\ControlSet001** and **\\CurrentControlSet\\Control\\Lsa\\Kerberos**.

You cannot remove the default realm name from the domain controller because this will reset its DNS information, and removing it might make the domain controller unusable.

## <a name="BKMK_Examples"></a>Examples
Mistakenly set the realm name by misspelling “.COM” on the local computer to CORP.CONTOSO.CON

```
ksetup /setrealm CORP.CONTOSO.CON
```

remove that erroneous realm name from the local computer:

```
ksetup /removerealm CORP.CONTOSO.CON
```

verify the removal by running **ksetup** and review the output.

## additional references

-   [ksetup](../ksetup.md)

-   [ksetup:setrealm](ksetupsetrealm.md)

-   [Command-Line Syntax Key](../commandline-syntax-key.md)


