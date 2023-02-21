---
title: time
description: Reference article for the time command, which displays or sets the system time.
ms.topic: reference
ms.assetid: 1276a257-7283-41da-ae80-fb4cfb311f9d
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# time

Displays or sets the system time. If used without parameters, **time** displays the current system time and prompts you to enter a new time.

> [!NOTE]
> You must be an administrator to change the current time.

## Syntax

```
time [/t | [<HH>[:<MM>[:<SS>]] [am|pm]]]
```

### Parameters

| Parameter | Description |
|--|--|
| `<HH>[:<MM>[:<SS>[.<NN>]]] [am | pm]` | Sets the system time to the new time specified, where *HH* is in hours (required), *MM* is in minutes, and *SS* is in seconds. *NN* can be used to specify hundredths of a second. You must separate values for *HH*, *MM*, and *SS* with colons (:). *SS* and *NN* must be separated with a period (.).<p>If **am** or **pm** isn't specified, **time** uses the 24-hour format by default. |
| /t | Displays the current time without prompting you for a new time. |
| /? | Displays help at the command prompt. |

#### Remarks

- Valid *HH* values are 0 through 24.

- Valid *MM* and *SS* values are 0 through 59.

## Examples

If command extensions are enabled, to display the current system time, type:

```
time /t
```

To change the current system time to 5:30 PM, type either of the following:

```
time 17:30:00
time 5:30 pm
```

To display the current system time, followed by a prompt to enter a new time, type:

```
The current time is: 17:33:31.35
Enter the new time:
```

To keep the current time and return to the command prompt, press ENTER. To change the current time, type the new time and then press ENTER.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
