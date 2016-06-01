---
title: Irftp
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e15c60a7-546d-4e9f-9871-43aaa1b569d6
---
# Irftp
Sends files over an infrared link.  For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).

## Syntax

```
irftp [<Drive>:\] [[<Path>] <FileName>] [/h][/s]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|Drive:\\|Specifies the drive that contains the files that you want to send over an infrared link.|
|\[Path\]FileName|Specifies the location and name of the file or set of files that you want to send over an infrared link. If you specify a set of files, you must specify the full path for each file.|
|\/h|Specifies hidden mode. When hidden mode is used, the files are sent without displaying the Wireless Link dialog box.|
|\/s|Opens the Wireless Link dialog box, so that you can select the file or set of files that you want to send without using the command line to specify the drive, path, and file names.|

## Remarks

-   Before using this command, verify that the devices that you want to communicate over an infrared link have infrared functionality enabled and working correctly, and that an infrared link is established between the devices.

-   Used without parameters or used with **\/s**, **irftp** opens the **Wireless Link** dialog box, where you can select the files that you want to send without using the command line.

## <a name="BKMK_Examples"></a>Examples
Send Example.txt over the infrared link.

```
irftp c:\example.txt
```

## Additional references

-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)


