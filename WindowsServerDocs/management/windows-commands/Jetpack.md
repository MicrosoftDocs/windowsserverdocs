---
title: Jetpack
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 82a2b7ef-0db5-4575-a028-8acb0bf6c7ba
---
# Jetpack
Compacts a Windows Internet Name Service \(WINS\) or Dynamic Host Configuration Protocol \(DHCP\) database. Microsoft recommends that you compact the WINS database whenever it approaches 30 MB. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).

## Syntax

```
JETPACK.EXE <database name> <temp database name>
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<database name>|Specifies the original database file.|
|<temp database name>|Specifies the temporary database file.|
|\/?|Displays Help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples
To compact the WINS database:

```
CD %SYSTEMROOT%\SYSTEM32\WINS
NET STOP WINS
JETPACK WINS.MDB TMP.MDB
NET START WINS
```

To compact the DHCP database:

```
CD %SYSTEMROOT%\SYSTEM32\DHCP
NET STOP DHCPSERVER
JETPACK DHCP.MDB TMP.MDB
NET START DHCPSERVER
```

In the examples above, **Tmp.mdb** is a temporary database that is used by Jetpack.exe. **Wins.mdb** is the WINS database. **Dhcp.mdb** is the DHCP database.

Jetpack.exe compacts the WINS or DHCP database by doing the following:

1.  Copies database information to a temporary database file called **Tmp.mdb**.

2.  Deletes the original database file, **Wins.mdb** or **Dhcp.mdb**.

3.  Renames the temporary database files to the original filename.

> [!NOTE]
> During the compact process, Jetpack.exe creates a temporary file with the name that is specified by the *temp database name* parameter. The temporary file is removed when the compact process is complete. Make sure you do not have a file already existing in WINS or DHCP folder with the same name as the one specified in the *temp database name* parameter.

## Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)


