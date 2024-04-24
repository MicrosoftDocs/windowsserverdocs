---
title: sxstrace
description: Reference article for the systrace command, which helps to diagnose side-by-side problems.
ms.topic: reference
ms.assetid: fcd26eeb-fbd9-4a86-b6a9-dfa5e9c6e4fc
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# sxstrace

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Diagnoses side-by-side problems.

## Syntax

```
sxstrace [{[trace -logfile:<filename> [-nostop]|[parse -logfile:<filename> -outfile:<parsedfile>  [-filter:<appname>]}]
```

### Parameters

| Parameter | Description |
|--|--|
| trace | Enables tracing for side-by-side. |
| -logfile | Specifies the raw log file. |
| `<filename>` | Saves tracing log to `<filename`. |
| -nostop | Specifies that you shouldn't receive a prompt to stop tracing. |
| parse | Translates the raw trace file. |
| -outfile | Specifies the output filename. |
| `<parsedfile>` | Specifies the filename of the parsed file. |
| -filter | Allows the output to be filtered. |
| `<appname>` | Specifies the name of the application. |
| stoptrace | Stops the trace, if it wasn't stopped before. |
| -? | Displays help at the command prompt. |

## Examples

To enable tracing and to save the trace file to *sxstrace.etl*, type:

```
sxstrace trace -logfile:sxstrace.etl
```

To translate the raw trace file into a human readable format and to save the result to *sxstrace.txt*, type:

```
sxstrace parse -logfile:sxstrace.etl -outfile:sxstrace.txt
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
