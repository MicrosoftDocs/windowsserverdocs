---
title: Tzutil
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: bcf6e007-c9b6-4df5-83c5-ed7b4b1b5913
---
# Tzutil
Displays the Windows Time Zone Utility. For examples of how this command can be used, see [Examples](assetId:///c6d43992-8243-4f0a-8605-3152c8a8fe9a#BKMK_Examples).

## Syntax

```
tzutil [/?] [/g] [/s <TimeZoneID>[_dstoff]] [/l]
```

### Parameters

|Parameter|Description|
|-------------|---------------|
|\/?|Displays Help at the command prompt.|
|\/g|Displays the current time zone ID.|
|\/s <TimeZoneID>\[\_dstoff\]|Sets the current time zone using the specified time zone ID. The **\_dstoff** suffix disables Daylight Saving Time adjustments for the time zone \(where applicable\).|
|\/l|Lists all valid time zone IDs and display names. The output will be:<br /><br />-   <display name><br />-   <time zone ID>|

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


