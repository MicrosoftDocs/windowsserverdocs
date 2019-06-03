---
ms.assetid: f2eefaaf-2817-4ac7-abac-d2b65fa971dc
title: Fsutil transaction
ms.prod: windows-server-threshold
manager: dmoss
ms.author: toklima
author: toklima
ms.technology: storage
audience: "IT Pro"
ms.topic: article
ms.date: 10/16/2017
---
# Fsutil transaction
>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows 7, Windows 2008, Windows Vista

Manages NTFS transactions.

For examples of how to use this command, see [Examples](#BKMK_examples) .

## Syntax

```
fsutil transaction [commit] <GUID>
fsutil transaction [fileinfo] <Filename>
fsutil transaction [list]
fsutil transaction [query] [{Files|All}] <GUID>
fsutil transaction [rollback] <GUID>
```

### Parameters

| Parameter  |                                                                                                                                                     Description                                                                                                                                                     |
|------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   commit   |                                                                                                                      Marks the end of a successful implicit or explicit specified transaction.                                                                                                                      |
|   <GUID>   |                                                                                                                               Specifies the GUID value that represents a transaction.                                                                                                                               |
|  fileinfo  |                                                                                                                              Displays transaction information for the specified file.                                                                                                                               |
| <Filename> |                                                                                                                                         Specifies full path and file name.                                                                                                                                          |
|    list    |                                                                                                                                 Displays a list of currently running transactions.                                                                                                                                  |
|   query    | Displays information for the specified transaction.<br /><br />-   If **fsutil transaction query Files** is specified, the file information will be displayed only for the specified transaction.<br />-   If **fsutil transaction query All** is specified, all information for the transaction will be displayed. |
|  rollback  |                                                                                                                                Rolls back a specified transaction to the beginning.                                                                                                                                 |

### Remarks

-   Transactional NTFS was introduced in  Windows Server 2008 .

### <a name="BKMK_examples"></a>Examples
To display transaction information for file c:\test.txt, type:

```
fsutil transaction fileinfo c:\test.txt  
```

### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Fsutil](Fsutil.md)

[Transactional NTFS](https://go.microsoft.com/fwlink/?LinkID=165402)


