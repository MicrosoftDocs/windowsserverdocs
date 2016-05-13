---
title: Nslookup set domain
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 9d4d28e8-6e88-42cc-801f-94e9d8e051f4
---
# Nslookup set domain
Changes the default Domain Name System \(DNS\) domain name to the name specified.

## Syntax

```
set domain=<DomainName>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|<DomainName>|Specifies a new name for the default DNS domain name. The default domain name is the host name.|
|{help &#124; ?}|Displays a short summary of **nslookup** subcommands.|

## Remarks

-   The default DNS domain name is appended to a lookup request depending on the state of the **defname** and **search** options. The DNS domain search list contains the parents of the default DNS domain if it has at least two components in its name. For example, if the default DNS domain is mfg.widgets.com, the search list is named both mfg.widgets.com and widgets.com. Use the **set srchlist** command to specify a different list and the **set all** command to display the list.

## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Nslookup set srchlist](Nslookup-set-srchlist.md)

[Nslookup set all](Nslookup-set-all.md)


