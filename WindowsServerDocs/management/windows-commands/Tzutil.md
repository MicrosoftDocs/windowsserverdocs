---
title: Tzutil
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bcf6e007-c9b6-4df5-83c5-ed7b4b1b5913
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# Tzutil

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Displays the Windows Time Zone Utility. 
## Syntax
```
tzutil [/?] [/g] [/s <TimeZoneID>[_dstoff]] [/l]
```
### Parameters
|Parameter|Description|
|-------|--------|
|/?|Displays Help at the command prompt.|
|/g|Displays the current time zone ID.|
|/s <TimeZoneID>[_dstoff]|Sets the current time zone using the specified time zone ID. The **_dstoff** suffix disables Daylight Saving Time adjustments for the time zone (where applicable).|
|/l|Lists all valid time zone IDs and display names. The output will be:<br /><br />-   <display name><br />-   <time zone ID>|
## Remarks
An exit code of **0** indicates the command completed successfully.
## <a name="BKMK_Examples"></a>Examples
To display the current time zone ID, type:
```
tzutil /g
```
To set the current time zone to Pacific Standard Time, type:
```
tzutil /s Pacific Standard Time
```
To set the current time zone to Pacific Standard Time and disable Daylight Saving Time adjustments, type:
```
tzutil /s Pacific Standard Time_dstoff
```
## Additional references
-   [Command-Line Syntax Key](Command-Line-Syntax-Key.md)
-   [Command-Line Reference_1](Command-Line-Reference_1.md)
