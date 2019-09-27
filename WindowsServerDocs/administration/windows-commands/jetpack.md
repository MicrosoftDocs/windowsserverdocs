---
title: jetpack
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 82a2b7ef-0db5-4575-a028-8acb0bf6c7ba
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# jetpack

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

compacts a Windows Internet Name Service (WINS) or Dynamic Host Configuration Protocol (DHCP) database. Microsoft recommends that you compact the WINS database whenever it approaches 30 MB. 

## Syntax
```
jetpack.EXE <database name> <temp database name>
```

### Parameters
|Parameter|Description|
|-------|--------|
|<database name>|Specifies the original database file.|
|<temp database name>|Specifies the temporary database file.|
|/?|Displays help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples
To compact the WINS database:
```
cd %SYSTEMROOT%\SYSTEM32\WINS
NET STOP WINS
jetpack WINS.MDB TMP.MDB
NET start WINS
```
To compact the DHCP database:
```
cd %SYSTEMROOT%\SYSTEM32\DHCP
NET STOP DHCPSERver
jetpack DHCP.MDB TMP.MDB
NET start DHCPSERver
```
In the examples above, **Tmp.mdb** is a temporary database that is used by jetpack.exe. **Wins.mdb** is the WINS database. **Dhcp.mdb** is the DHCP database.
jetpack.exe compacts the WINS or DHCP database by doing the following:
1.  Copies database information to a temporary database file called **Tmp.mdb**.
2.  deletes the original database file, **Wins.mdb** or **Dhcp.mdb**.
3.  renames the temporary database files to the original filename.

> [!NOTE]
> During the compact process, jetpack.exe creates a temporary file with the name that is specified by the *temp database name* parameter. The temporary file is removed when the compact process is complete. Make sure you do not have a file already existing in WINS or DHCP folder with the same name as the one specified in the *temp database name* parameter.

## additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)
