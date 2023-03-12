---
title: color
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f5b67131-d196-45ec-a3f9-b5d9f091fd86
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# color



Changes the foreground and background colors in the Command Prompt window for the current session. If used without parameters, **color** restores the default Command Prompt window foreground and background colors.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
color [[<B>]<F>]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<B>|Specifies the background color.|
|\<F>|Specifies the foreground color.|
|/?|Displays help at the command prompt.|

## Remarks

-   The following table lists valid hexadecimal digits that you can use as the values for *B* and *F*.

|Value|Color|
|-----|-----|
|0|Black|
|1|Blue|
|2|Green|
|3|Aqua|
|4|Red|
|5|Purple|
|6|Yellow|
|7|White|
|8|Gray|
|9|Light blue|
|A|Light green|
|B|Light aqua|
|C|Light red|
|D|Light purple|
|E|Light yellow|
|F|Bright white|
    
-   Do not use space characters between *B* and *F*.
-   If you specify only one hexadecimal digit, the corresponding color is used as the foreground color and the background color is set to the default color.
-   To set the default Command Prompt window color, click the upper-left corner of the Command Prompt window, click **Defaults**, click the **Colors** tab, and then click the colors that you want to use for the **Screen Text** and **Screen Background**.
-   If *B* and *F* are the same, the **color** command sets ERRORLEVEL to 1, and no change is made to either the foreground or the background color.

## <a name="BKMK_examples"></a>Examples

To change the Command Prompt window background color to gray and the foreground color to red, type:
```
color 84
```
To change the Command Prompt window foreground color to light yellow, type:
```
color e
```

> [!NOTE]
> In this example, the background is set to the default color because only one hexadecimal digit is specified.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
