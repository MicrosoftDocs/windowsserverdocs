---
title: append
description: Reference article for the append command, which allows programs to open data files in specified directories, as if they were in the current directory.
ms.topic: reference
ms.assetid: 9c3fea20-9502-40ad-a442-7a927aad88eb
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# append

Allows programs to open data files in specified directories as if they were in the current directory. If used without parameters, **append** displays the appended directory list.

> [!NOTE]
> This command not supported in Windows 10.

## Syntax

```
append [[<drive>:]<path>[;...]] [/x[:on|:off]] [/path:[:on|:off] [/e]
append ;
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `[\<drive>:]<path>` | Specifies a drive and directory to append. |
| /x:on | Applies appended directories to file searches and launching applications. |
| /x:off | Applies appended directories only to requests to open files. The **/x:off** option is the default setting. |
| /path:on | Applies appended directories to file requests that already specify a path. **/path:on** is the default setting. |
| /path:off | Turns off the effect of **/path:on**. |
| /e | Stores a copy of the appended directory list in an environment variable named APPEND. **/e** may be used only the first time you use **append** after starting your system. |
| ; | Clears the appended directory list. |
| /? | Displays help at the command prompt. |

## Examples

To clear the appended directory list, type:

```
append ;
```

To store a copy of the appended directory to an environment variable named *append*, type:

```
append /e
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
