---
title: Ftp: literal_1
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fb81aa2d-07fa-4e79-bf44-1fb5526fdf14
---
# Ftp: literal_1
Sends verbatim arguments to the remote FTP server. A single FTP reply code is returned. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).

## Syntax

```
literal <Argument> […]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<Argument>|Specifies the argument to send to the FTP server.|

## Remarks
The **literal** command is identical to the **quote** command.

## <a name="BKMK_Examples"></a>Examples
Send a **quit** command to the remote FTP server.

```
literal quit
```

## Additional references

-   [Ftp: quote](Ftp--quote.md)

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)


