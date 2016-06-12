---
title: makecab
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4da95297-c593-427b-9f76-2f389c46cbf4
---
# makecab
Package existing files into a cabinet \(.cab\) file.

## Syntax

```
makecab [/v[n]] [/d var=<value> ...] [/l <dir>] <source> [<destination>]

makecab [/v[<n>]] [/d var=<value> ...] /f <directives_file> [...]

```

### Parameters

|Parameter|Description|
|-------------|---------------|
|<source>|File to compress.|
|<destination>|File name to give compressed file. if omitted, the last character of the source file name is replaced with an underscore \(\_\) and used as the destination.|
|\/f <directives\_file>|A file with **makecab** directives \(may be repeated\).|
|\/d var\=<value>|Defines variable with specified value.|
|\/l <dir>|Location to place destination \(default is current directory\).|
|\/v\[<n>\]|Set debugging verbosity level \(0\=none,...,3\=full\).|
|\/?|Displays help at the command prompt.|

## remarks

-   Refer to [Microsoft Cabinet format](http://go.microsoft.com/fwlink/?LinkId=226852) on MSDN for information on directive\_file.

## additional references

-   [Command-Line Syntax Key](commandline-syntax-key.md)

-   [Command-Line Reference_1](Command-Line-Reference_1.md)


