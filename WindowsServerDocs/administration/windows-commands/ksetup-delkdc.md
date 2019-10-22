---
title: ksetup:delkdc
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7d6ec389-094c-4a7b-a78b-605497ddc289
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# ksetup:delkdc



Deletes instances of Key Distribution Center (KDC) names for the Kerberos realm. For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
ksetup /delkdc <RealmName> <KDCName>
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<RealmName>|The realm name is stated as an uppercase DNS name, such as CORP.CONTOSO.COM, and it is listed as the default realm when **ksetup** is run. It is to this realm from which you are attempting to delete the other KDC.|
|\<KDCName>|The KDC name is stated as a case-insensitive, fully qualified domain name, such as mitkdc.contoso.com.|

## Remarks

These mappings are stored in the registry in **HKEY_LOCAL_MACHINE\System\CurrentControlSet\Control\LSA\Kerberos\Domains**. To remove realm configuration data from multiple computers, use the Security Configuration Template snap-in and policy distribution instead of using **ksetup** explicitly on individual computers.

On computers running Windows 2000 Server with Service Pack 1 (SP1) and earlier, the computer must be restarted before the changed realm setting configuration will be used.

To verify the default realm name for the computer, or to verify that this command worked as intended, run **ksetup** at the command prompt and verify that the KDC that was removed does not exist in the list.

## <a name="BKMK_Examples"></a>Examples

The security requirements for this computer have changed so the link between the Windows realm and the non-Windows realm must be removed. First, determine which association to remove and produce the output of existing associations:
```
ksetup
```
Remove the association by using the following command:
```
Ksetup /delkdc CORP.CONTOSO.COM mitkdc.contoso.com
```

#### Additional references

-   [Ksetup](ksetup.md)
-   [Command-Line Syntax Key](command-line-syntax-key.md)