---
title: color
description: Reference article for the color command, which changes the foreground and background colors in the Command Prompt window for the current session.
ms.topic: article
ms.assetid: f5b67131-d196-45ec-a3f9-b5d9f091fd86
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# color

Changes the foreground and background colors in the Command Prompt window for the current session. If used without parameters, **color** restores the default Command Prompt window foreground and background colors.

## Syntax

```
color [[<b>]<f>]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<b>` | Specifies the background color. |
| `<f>` | Specifies the foreground color. |
| /? | Displays help at the command prompt. |

Where:

The following table lists valid hexadecimal digits that you can use as the values for `<b>` and `<f>`:

| Value | Color |
| ----- | ----- |
| 0 | Black |
| 1 | Blue |
| 2 | Green |
| 3 | Aqua |
| 4 | Red |
| 5 | Purple |
| 6 | Yellow |
| 7 | White |
| 8 | Gray |
| 9 | Light blue |
| a | Light green |
| b | Light aqua |
| c | Light red |
| d | Light purple |
| e | Light yellow |
| f | Bright white |

#### Remarks

- Don't use space characters between `<b>` and `<f>`.

- If you specify only one hexadecimal digit, the corresponding color is used as the foreground color and the background color is set to the default color.

- To set the default Command Prompt window color, select the upper-left corner of the **Command Prompt** window, select **Defaults**, select the **Colors** tab, and then select the colors that you want to use for the **Screen Text** and **Screen Background**.

- If `<b>` and `<f>` are the same color value, the ERRORLEVEL is set to `1`, and no change is made to either the foreground or the background color.

## Examples

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

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
