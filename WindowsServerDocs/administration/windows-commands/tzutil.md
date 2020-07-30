---
title: tzutil
description: Reference article for tzutil, which displays the Windows Time Zone utility.
ms.prod: windows-server
ms.technology: manage-windows-commands
ms.topic: article
ms.assetid: bcf6e007-c9b6-4df5-83c5-ed7b4b1b5913
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---
# tzutil

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays the Windows Time Zone utility.

## Syntax
```
tzutil [/?] [/g] [/s <timeZoneID>[_dstoff]] [/l]
```
#### Parameters
|Parameter|Description|
|-------|--------|
|/?|Displays help at the command prompt.|
|/g|Displays the current time zone ID.|
|/s \<timeZoneID>[_dstoff]|Sets the current time zone using the specified time zone ID. The **_dstoff** suffix disables Daylight Saving time adjustments for the time zone (where applicable).|
|/l|lists all valid time zone IDs and display names. The output will be:<p>-   \<display name><br />-   \<time zone ID>|

## Remarks
An exit code of **0** indicates the command completed successfully.

## Examples
To display the current time zone ID, type:
```
tzutil /g
```
To set the current time zone to Pacific Standard time, type:
```
tzutil /s Pacific Standard time
```
To set the current time zone to Pacific Standard time and disable Daylight Saving time adjustments, type:
```
tzutil /s Pacific Standard time_dstoff
```
## Additional References
- [Command-Line Syntax Key](command-line-syntax-key.md)

