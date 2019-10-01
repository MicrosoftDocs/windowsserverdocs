---
title: choice
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: c65a9119-410b-4dcf-9fa7-4e07d2a7238b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# choice



Prompts the user to select one item from a list of single-character choices in a batch program, and then returns the index of the selected choice. If used without parameters, **choice** displays the default choices **Y** and **N**.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
choice [/c [<Choice1><Choice2><…>]] [/n] [/cs] [/t <Timeout> /d <Choice>] [/m <"Text">]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|/c \<Choice1><Choice2><…>|Specifies the list of choices to be created. Valid choices include a-z, A-Z, 0-9, and extended ASCII characters (128-254). The default list is "YN", which is displayed as `[Y,N]?`.|
|/n|Hides the list of choices, although the choices are still enabled and the message text (if specified by **/m**) is still displayed.|
|/cs|Specifies that the choices are case-sensitive. By default, the choices are not case-sensitive.|
|/t \<Timeout>|Specifies the number of seconds to pause before using the default choice specified by **/d**. Acceptable values are from **0** to **9999**. If **/t** is set to **0**, **choice** does not pause before returning the default choice.|
|/d \<Choice>|Specifies the default choice to use after waiting the number of seconds specified by **/t**. The default choice must be in the list of choices specified by **/c**.|
|/m <"Text">|Specifies a message to display before the list of choices. If **/m** is not specified, only the choice prompt is displayed.|
|/?|Displays help at the command prompt.|

## Remarks

-   The ERRORLEVEL environment variable is set to the index of the key that the user selects from the list of choices. The first choice in the list returns a value of 1, the second a value of 2, and so on. If the user presses a key that is not a valid choice, **choice** sounds a warning beep. If **choice** detects an error condition, it returns an ERRORLEVEL value of 255. If the user presses CTRL+BREAK or CTRL+C, **choice** returns an ERRORLEVEL value of 0.

> [!NOTE]
> When you use ERRORLEVEL values in a batch program, list them in decreasing order.

## <a name="BKMK_examples"></a>Examples

To present the choices Y, N, and C, type the following line in a batch file:
```
choice /c ync
```
The following prompt appears when the batch file runs the **choice** command:
```
[Y,N,C]?
```
To hide the choices Y, N, and C, but display the text "Yes, No, or Continue", type the following line in a batch file:
```
choice /c ync /n /m "Yes, No, or Continue?"
```
The following prompt appears when the batch file runs the **choice** command:
```
Yes, No, or Continue?
```

> [!NOTE]
> If you use the **/n** parameter, but do not use **/m**, the user is not prompted when **choice** is waiting for input.

To show both the text and the options used in the previous examples, type the following line in a batch file:
```
choice /c ync /m "Yes, No, or Continue"
```
The following prompt appears when the batch file runs the **choice** command:
```
Yes, No, or Continue [Y,N,C]?
```
To set a time limit of five seconds and specify **N** as the default value, type the following line in a batch file:
```
choice /c ync /t 5 /d n
```
The following prompt appears when the batch file runs the **choice** command:
```
[Y,N,C]?
```

> [!NOTE]
> In this example, if the user does not press a key within five seconds, **choice** selects **N** by default and returns an error value of 2. Otherwise, **choice** returns the value corresponding to the user's choice.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)