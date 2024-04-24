---
title: scwcmd register
description: Reference article for the scwcmd register command, which extends or customizes the Security Configuration Wizard (SCW) Security Configuration Database by registering a Security Configuration Database file that contains role, task, service, or port definitions.
ms.topic: reference
ms.assetid: fe4d126a-9f27-4076-b7b1-fbefa45f378a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# scwcmd register

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2012 R2 and Windows Server 2012

Extends or customizes the Security Configuration Wizard (SCW) Security Configuration Database by registering a Security Configuration Database file that contains role, task, service, or port definitions.

## Syntax

```
scwcmd register /kbname:<MyApp> [/kbfile:<kb.xml>] [/kb:<path>] [/d]
```

### Parameters

| Parameter | Description |
|--|--|
| /kbname:`<MyApp>` | Specifies the name under which the Security Configuration Database extension will be registered. This parameter must be specified. |
| /kbfile:`<kb.xml>` | Specifies the path and file name of the Security Configuration Database file used to extend or customize the base Security Configuration Database. To validate that the Security Configuration Database file is compliant with the SCW schema, use the `%windir%\security\KBRegistrationInfo.xsd` schema definition file. This option must be provided unless the **/d** parameter is specified. |
| /kb:`<path>` | Specifies the path to the directory that contains the SCW Security Configuration Database files to be updated. If this option is not specified, `%windir%\security\msscw\kbs` is used. |
| /d | Unregisters a Security Configuration Database extension from the Security Configuration Database. The extension to unregister is specified by the **/kbname** parameter. (The **/kbfile** parameter shouldn't be specified.) The Security Configuration Database to unregister the extension from is specified by the **/kb** parameter. |
| /? | Displays help at the command prompt. |

## Examples

To register the Security Configuration Database file named *SCWKBForMyApp.xml* under the name *MyApp* in the location `\\kbserver\kb`, type:

```
scwcmd register /kbfile:d:\SCWKBForMyApp.xml /kbname:MyApp /kb:\\kbserver\kb
```

To unregister the Security Configuration Database *MyApp*, located at `\\kbserver\kb`, type:

```
scwcmd register /d /kbname:MyApp /kb:\\kbserver\kb
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [scwcmd analyze command](scwcmd-analyze.md)

- [scwcmd configure command](scwcmd-configure.md)

- [scwcmd rollback command](scwcmd-rollback.md)

- [scwcmd transform command](scwcmd-transform.md)

- [scwcmd view command](scwcmd-view.md)
