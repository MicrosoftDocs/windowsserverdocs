---
title: graftabl
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: b08351d4-3d24-490c-86f6-1252da11d923
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# graftabl



Enables Windows operating systems to display an extended character set in graphics mode. If used without parameters, **graftabl** displays the previous and the current code page.

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
graftabl <CodePage>
graftabl /status
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<CodePage>|Specifies a code page to define the appearance of extended characters in graphics mode.</br>Valid code page identification numbers are:</br>437: United States</br>850: Multilingual (Latin I)</br>852: Slavic (Latin II)</br>855: Cyrillic (Russian)</br>857: Turkish</br>860: Portuguese</br>861: Icelandic</br>863: Canadian-French</br>865: Nordic</br>866: Russian</br>869: Modern Greek|
|/status|Displays the current code page that **graftabl** is using.|
|/?|Displays help at the command prompt.|

## Remarks

-   **Graftabl** affects only the monitor display of extended characters of the code page that you specify. It does not change the actual console input code page. To change the console input code page, use the **mode** or **chcp** command.
-   The following table lists each exit code and a brief description of it.  
    |Exit code|Description|
    |---------|-----------|
    |0|Character set was loaded successfully. No previous code page was loaded.|
    |1|An incorrect parameter was specified. No action was taken.|
    |2|A file error occurred.|
-   You can use the ERRORLEVEL environment variable in a batch program to process exit codes that are returned by **graftabl**.

## <a name="BKMK_examples"></a>Examples

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

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)

[Freedisk](freedisk.md)

[Chcp](chcp.md)