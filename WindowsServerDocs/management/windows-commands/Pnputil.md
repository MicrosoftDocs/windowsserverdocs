---
title: pnputil
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: fab686b8-09d3-4f6c-afa2-630e6036f44c
---
# pnputil
pnputil.exe is a command line utility that you can use to manage the driver store. You can use pnputil to add driver packages, remove driver packages, and list driver packages that are in the store.

## Syntax

```
pnputil.exe [-f | -i] [ -? | -a | -d | -e ] <INF name>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|\-a|Specifies to add the identified INF file.|
|\-d|Specifies to delete the identified INF file.|
|\-e|Specifies to enumerate all third\-party INF files.|
|\-f|Specifies to force the deletion of the identified INF file. Cannot be used in conjunction with the **–i** parameter.|
|\-i|Specifies to install the identified INF file. Cannot be used in conjunction with  the  **\-f** parameter.|
|\/?|Displays help at the command prompt.|

## remarks

## Examples

-   pnputil.exe \-a a:\\usbcam\\USBCAM.INF  adds the INF file that is specified by USBCAM.INF

-   pnputil.exe \-a c:\\drivers\\\*.inf  adds all INF files in c:\\drivers\\

-   pnputil.exe \-i \-a a:\\usbcam\\USBCAM.INF  adds and installs the specified driver.

-   pnputil.exe –e  Enumerates all third\-party drivers.

-   pnputil.exe \-d oem0.inf  deletes the specified.

-   pnputil.exe \-f \-d oem0.inf  forces the deletion of the specified INF file.

## additional references
[Command-Line Syntax Key](commandline-syntax-key.md)

[popd](popd.md)


