---
title: Ftp: mget
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 6c85ae96-ec51-48a9-a227-7f02c7332c69
---
# Ftp: mget
Copies remote files to the local computer using the current file transfer type. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).

## Syntax

```
mget <RemoteFile>[…]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<RemoteFile>|Specifies the remote files to copy to the local computer.|

## <a name="BKMK_Examples"></a>Examples
Copy remote files **a.exe** and **b.exe** to the local computer using the current file transfer type.

```
mget a.exe b.exe
```

## Additional references

-   [Ftp: ascii](Ftp--ascii.md)

-   [Ftp: binary](Ftp--binary.md)

-   [Command-Line Syntax Key](../Command-Line-Syntax-Key.md)


