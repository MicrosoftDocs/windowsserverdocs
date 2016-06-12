---
title: Fsutil transaction
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-storage
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ac0d3be7-3e19-4b79-8aa5-daf8d5affd28
---
# Fsutil transaction
manages NTFS transactions.

for examples of how to use this command, see [Examples](#BKMK_examples) .

## Syntax

```
fsutil transaction [commit] <GUID>
fsutil transaction [fileinfo] <Filename>
fsutil transaction [list]
fsutil transaction [query] [{Files|All}] <GUID>
fsutil transaction [rollback] <GUID>

```

### Parameters

|Parameter|Description|
|-------------|---------------|
|commit|Marks the end of a successful implicit or explicit specified transaction.|
|<GUID>|Specifies the GUID value that represents a transaction.|
|fileinfo|Displays transaction information for the specified file.|
|<Filename>|Specifies full path and file name.|
|list|Displays a list of currently running transactions.|
|query|Displays information for the specified transaction.<br /><br />-   if **fsutil transaction query Files** is specified, the file information will be displayed only for the specified transaction.<br />-   if **fsutil transaction query All** is specified, all information for the transaction will be displayed.|
|rollback|Rolls back a specified transaction to the beginning.|

### remarks

-   Transactional NTFS was introduced in  Windows Server 2008 .

### <a name="BKMK_examples"></a>Examples
To display transaction information for file c:\\test.txt, type:

```
fsutil transaction fileinfo c:\test.txt  
```

### additional references
[Command-Line Syntax Key](../commandline-syntax-key.md)

[Fsutil]()

[Transactional NTFS](http://go.microsoft.com/fwlink/?LinkID=165402)


