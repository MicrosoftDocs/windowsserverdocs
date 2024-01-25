---
title: graftabl
description: Reference article for the graftabl command, which enables Windows operating systems to display an extended character set in graphics mode.
ms.topic: reference
ms.assetid: b08351d4-3d24-490c-86f6-1252da11d923
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# graftabl

Enables Windows operating systems to display an extended character set in graphics mode. If used without parameters, **graftabl** displays the previous and the current code page.

> [!IMPORTANT]
> The **graftabl** command is a legacy command, and therefore outdated. It is normally not installed in modern Windows versions. Please see the [chcp](./chcp.md) page for codepage handling.

## Syntax

```
graftabl <codepage>
graftabl /status
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<codepage>` | Specifies a code page to define the appearance of extended characters in graphics mode. Valid code page identification numbers are:<ul><li>**437** - United States</li><li>**850** - Multilingual (Latin I)</li><li>**852** - Slavic (Latin II)</li><li>**855** - Cyrillic (Russian)</li><li>**857** - Turkish</li><li>**860** - Portuguese</li><li>**861** - Icelandic</li><li>**863** - Canadian-French</li><li>**865** - Nordic</li><li>**866** - Russian</li><li>**869** - Modern Greek</li></ul> |
| /status | Displays the current code page being used by this command. |
| /? | Displays help at the command prompt. |

#### Remarks

- The **graftabl** command affects only the monitor display of extended characters of the code page that you specify. It doesn't change the actual console input code page. To change the console input code page, use the [mode](mode.md) or [chcp](chcp.md) command.

- Each exit code and a brief description of it:

    | Exit code | Description |
    | --------- | ----------- |
    | 0 | Character set was loaded successfully. No previous code page was loaded. |
    | 1 | An incorrect parameter was specified. No action was taken. |
    | 2 | A file error occurred. |

- You can use the ERRORLEVEL environment variable in a batch program to process exit codes that are returned by **graftabl**.

### Examples

To view the current code page used by **graftabl**, type:

```
graftabl /status
```

To load the graphics character set for code page 437 (United States) into memory, type:

```
graftabl 437
```

To load the graphics character set for code page 850 (multilingual) into memory, type:

```
graftabl 850
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [freedisk command](freedisk.md)

- [mode command](mode.md)

- [chcp command](chcp.md)