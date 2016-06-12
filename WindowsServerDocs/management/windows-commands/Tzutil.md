---
title: tzutil
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bcf6e007-c9b6-4df5-83c5-ed7b4b1b5913
---
# tzutil
Displays the Windows time Zone Utility. for examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).

## Syntax

```
tzutil [/?] [/g] [/s <timeZoneID>[_dstoff]] [/l]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|\/?|Displays help at the command prompt.|
|\/g|Displays the current time zone ID.|
|\/s <timeZoneID>\[\_dstoff\]|Sets the current time zone using the specified time zone ID. The **\_dstoff** suffix disables Daylight Saving time adjustments for the time zone \(where applicable\).|
|\/l|lists all valid time zone IDs and display names. The output will be:<br /><br />-   <display name><br />-   <time zone ID>|

## remarks
An exit code of **0** indicates the command completed successfully.

## <a name="BKMK_Examples"></a>Examples
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

## additional references

-   [Command-Line Syntax Key](commandline-syntax-key.md)

-   [Command-Line Reference_1](Command-Line-Reference_1.md)


