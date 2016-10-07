---
title: Nslookup ls

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f15f06fe-67e7-41a9-93b5-192ab14ab380
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Nslookup ls
Lists information for a Domain Name System (DNS) domain.
## Syntax
```
ls [<Option>] <DNSDomain> [{[>] <FileName>|[>>] <FileName>}]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|<Option>|The following table lists valid options.<br /><br />-   -t: Lists all records of the specified type. For a description of <QueryType>, see  **setquerytype** in Additional references.<br />-   -a: Lists aliases of computers in the DNS domain. This parameter is a synonym for **-t CNAME**<br />-   -d: Lists all records for the DNS domain. This parameter is a synonym for **-t ANY**<br />-   -h: Lists CPU and operating system information for the DNS domain. This parameter is a synonym for **-t HINFO**<br />-   -s: Lists well-known services of computers in the DNS domain. This parameter is a synonym for **-t WKS**.|
|<DNSDomain>|Specifies the DNS domain for which you want information.|
|<FileName>|Specifies a file name in which to save the output. You can use the greater than (>) and double greater than (>>) characters to redirect the output in the usual manner.|
|{help &#124; ?}|Displays a short summary of **nslookup** subcommands.|
## Remarks
-   The default output contains computer names and their IP addresses. When output is directed to a file, hash marks are printed for every 50 records received from the server
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
[Nslookup set querytype](Nslookup-set-querytype.md)
