---
title: date
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: ce6700fb-32f9-4350-a1af-5aee61d4448c
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# date



Displays or sets the system date. If used without parameters, **date** displays the current system date setting and prompts you to enter a new date.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
date [/t | <Month-Day-Year>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<Month-Day-Year>|Sets the date specified, where *Month* is the month (one or two digits), *Day* is the day (one or two digits), and *Year* is the year (two or four digits).|
|/t|Displays the current date without prompting you for a new date.|
|/?|Displays help at the command prompt.|

## Remarks

-   To change the current date, you must have administrative credentials.
-   You must separate values for *Month*, *Day*, and *Year* with periods (.), hyphens (-), or slash marks (/).
-   Valid *Month* values are 1 through 12.
-   Valid *Day* values are 1 through 31.
-   Valid *Year* values are either 00 through 99, or 1980 through 2099. If you use two digits, the values 80 through 99 correspond to the years 1980 through 1999.

## <a name="BKMK_examples"></a>Examples

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
The current date is: Mon 04/02/2007
Enter the new date: (mm-dd-yy)
```
To keep the current date and return to the command prompt, press ENTER. To change the current date, type the new date and then press ENTER.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)