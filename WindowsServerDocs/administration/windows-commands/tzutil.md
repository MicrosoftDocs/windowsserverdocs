---
title: tzutil
description: Reference article for the tzutil command, which displays the Windows Time Zone utility.
ms.topic: reference
ms.author: daknappe
author: dknappettmsft
ms.date: 10/16/2017
---
# tzutil



Displays the Windows Time Zone utility.

## Syntax

```
tzutil [/?] [/g] [/s <timezoneID>[_dstoff]] [/l]
```

### Parameters

| Parameter | Description |
|--|--|
| /g | Displays the current time zone ID. |
| /s `<timezoneID>[_dstoff]` | Sets the current time zone using the specified time zone ID. The **_dstoff** suffix disables Daylight Saving time adjustments for the time zone (where applicable). Your value must be surrounded by quotes. |
| /l | Lists all valid time zone IDs and display names. The output appears as:<ul><li>`<display name>`</li><li>`<time zone ID>`</li></ul> |
| /? | Displays help at the command prompt. |

#### Remarks

An exit code of **0** indicates the command completed successfully.

## Examples

To display the current time zone ID, type:

```
tzutil /g
```

To set the current time zone to Pacific Standard time, type:

```
tzutil /s "Pacific Standard time"
```

To set the current time zone to Pacific Standard time and disable Daylight Saving time adjustments, type:

```
tzutil /s "Pacific Standard time_dstoff"
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
