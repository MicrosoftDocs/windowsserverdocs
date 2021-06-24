---
title: scwcmd view
description: Reference article for the scwcmd view command, which renders an .xml file by using a specified .xsl transform.
ms.topic: reference
ms.assetid: 7995959a-d93e-4865-a6a0-2ab18c2bb47f
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# scwcmd view

> Applies to: Windows Server 2012 R2 and Windows Server 2012

Renders an .xml file by using a specified .xsl transform. This command can be useful for displaying Security Configuration Wizard (SCW) .xml files by using different views.

## Syntax

```
scwcmd view /x:<Xmlfile.xml> [/s:<Xslfile.xsl>]
```

### Parameters

| Parameter | Description |
|--|--|
| /x:`<Xmlfile.xml>` | Specifies the .xml file to be viewed. This parameter must be specified. |
| /s:`<Xslfile.xsl>` | Specifies the .xsl transform to apply to the .xml file as part of the rendering process. This parameter is optional for SCW .xml files. When the **view** command is used to render a SCW .xml file, it will automatically try to load the correct default transform for the specified .xml file. If an .xsl transform is specified, the transform must be written under the assumption that the .xml file is in the same directory as the .xsl transform. |
| /? | Displays help at the command prompt. |

## Example

To view *Policyfile.xml* by using the *Policyview.xsl* transform, type:

```
scwcmd view /x:C:\policies\Policyfile.xml /s:C:\viewers\Policyview.xsl
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [scwcmd analyze command](scwcmd-analyze.md)

- [scwcmd configure command](scwcmd-configure.md)

- [scwcmd register command](scwcmd-register.md)

- [scwcmd rollback command](scwcmd-rollback.md)

- [scwcmd transform command](scwcmd-transform.md)