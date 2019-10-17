---
title: Vssadmin list shadows
description: A description of the vssadmin list shadows command.
ms.prod: windows-server 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage 
ms.date: 05/18/2018
ms.localizationpriority: medium
---
# Vssadmin list shadows

>Applies to: Windows 10, Windows 8.1, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

Lists all existing shadow copies of a specified volume. If you use this command without parameters, it displays all volume shadow copies on the computer in the order dictated by **Shadow Copy Set**.

## Syntax

```PowerShell
vssadmin list shadows [/for=<ForVolumeSpec>] [/shadow=<ShadowID>]
```

## Parameters

|Parameter|Description|
|---|---|
|/for=\<ForVolumeSpec>|Specifies which volume the shadow copies will be listed for.|
|/shadow=\<ShadowID>|Lists the shadow copy specified by ShadowID. To get the shadow copy ID, use the **vssadmin list shadows** command. When you type a shadow copy ID, use the following format, where each *X* represents a hexadecimal character:<br><br>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX|

## Additional references

* [Command-line syntax key](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771080(v%3dws.11))
* [Vssadmin](vssadmin.md)