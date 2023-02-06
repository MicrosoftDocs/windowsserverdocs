---
title: date
description: Reference article for the date command, which displays or sets the system date. If used without parameters,
ms.topic: reference
ms.assetid: ce6700fb-32f9-4350-a1af-5aee61d4448c
ms.author: alalve
author: JasonGerend
manager: mtillman
ms.date: 10/26/2022
---

# date

Displays or sets the system date. If used without parameters, **date** displays the current system date setting and prompts you to enter a new date.

>[!IMPORTANT]
> You must be an administrator to use this command.

## Syntax

```
date [/t | <month-day-year>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<month-day-year>` | Sets the date specified, where *month* is the month (one or two digits, including values 1 through 12), *day* is the day (one or two digits, including values 1 through 31), and *year* is the year (two or four digits, including the values 00 through 99 or 1980 through 2099). You must separate values for *month*, *day*, and *year* with periods (.), hyphens (-), or slash marks (/).<p>**Note:** Be mindful if you use 2 digits to represent the year, the values 80-99 correspond to 1980 through 1999. |
| /t | Displays the current date without prompting you for a new date. |
| /? | Displays help at the command prompt. |

## Examples

If command extensions are enabled, to display the current system date, type:

```
date /t
```

To change the current system date to August 3, 2007, you can type any of the following:

```
date 08.03.2007
date 08-03-07
date 8/3/07
```

To display the current system date, followed by a prompt to enter a new date, type:

```
date
```

To keep the current date and return to the command prompt, press **ENTER**. To change the current date, type the new date based on your current date configuration, as seen in the second example above, and then press **ENTER**.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
