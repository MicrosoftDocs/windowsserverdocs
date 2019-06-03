---
title: ksetup:addkdc
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 98bfc23a-14c4-401c-bcb3-9903c5cdde64
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ksetup:addkdc



Adds a Key Distribution Center (KDC) address for the given Kerberos realm. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
ksetup /addkdc <RealmName> [<KDCName>] 
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<RealmName>|The realm name is stated as an uppercase DNS name, such as CORP.CONTOSO.COM, and it is listed as the default realm when **ksetup** is run. It is to this realm that you are attempting to add the other KDC.|
|\<KDCName>|The KDC name is stated as a case insensitive fully qualified domain name, such as mitkdc.microsoft.com. If the KDC name is omitted, DNS will locate KDCs.|

## Remarks

These mappings are stored in the registry under **HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA\Kerberos\Domains**. To deploy Kerberos realm configuration data to multiple computers, use the Security Configuration Template snap-in and policy distribution instead of using **ksetup** explicitly on individual computers.

The computer must be restarted before the new realm setting will be used.

To verify the default realm name for the computer, or to verify that this command worked as intended, run **ksetup** at the command prompt and verify the output for the added KDC.

## <a name="BKMK_Examples"></a>Examples

Configure a non-Windows KDC server and the realm that the workstation should use:
```
ksetup /addkdc CORP.CONTOSO.COM mitkdc.contoso.com
```
Run the Ksetup tool at the command line of the same computer as in the preceding command to set the local computer account password to "p@sswrd1%". Then restart the computer.
```
Ksetup /setcomputerpassword p@sswrd1%
```

#### Additional references

-   [Ksetup](ksetup.md)
-   [Ksetup:setcomputerpassword](ksetup-setcomputerpassword.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)