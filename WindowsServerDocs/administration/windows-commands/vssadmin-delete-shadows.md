---
title: Vssadmin delete shadows
description: A description of the vssadmin delete shadows command.
ms.prod: windows-server 
ms.topic: article 
author: JasonGerend 
ms.author: jgerend 
ms.technology: storage 
ms.date: 05/18/2018
ms.localizationpriority: medium
---
# Vssadmin delete shadows

>Applies to: Windows 10, Windows 8.1, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012, Windows Server 2008 R2, Windows Server 2008

Deletes a specified volume's shadow copies.

## Syntax

```PowerShell
vssadmin delete shadows /for=<ForVolumeSpec> [/oldest | /all | /shadow=<ShadowID>] [/quiet]
```

## Parameters

|Parameter|Description|
|---|---|
|/for=\<ForVolumeSpec>|Specifies which volume's shadow copy will be deleted.|
|/oldest|Deletes only the oldest shadow copy.|
|/all|Deletes all of the specified volume's shadow copies.|
|/shadow=\<ShadowID>|Deletes the shadow copy specified by ShadowID. To get the shadow copy ID, use the **vssadmin list shadows** command. When you enter a shadow copy ID, use the following format, where each *X* represents a hexadecimal character:<br><br>XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX|
|/quiet|Specifies that the command will not display messages while running.|

## Remarks

You can only delete shadow copies with the client-accessible type.

## Examples

To delete the oldest shadow copy of volume C, enter this command:

```PowerShell
vssadmin delete shadows /for=c: /oldest
```

## Additional references

* [Command-line syntax key](https://docs.microsoft.com/previous-versions/windows/it-pro/windows-server-2012-r2-and-2012/cc771080(v%3dws.11))
* [Vssadmin](vssadmin.md)
* [Vssadmin list shadows](vssadmin-list-shadows.md)