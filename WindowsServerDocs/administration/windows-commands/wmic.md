---
title: wmic
description: Reference article for wmic, which displays WMI information inside an interactive command shell.
ms.topic: reference
ms.assetid: 76397c72-d06f-4cea-88cf-c7603315a983
ms.author: alalve
author: JasonGerend
ms.date: 10/19/2022
---

# wmic

Displays WMI information inside an interactive command shell.

> [!IMPORTANT]
> The WMI command-line (WMIC) utility is deprecated as of Windows 10, version 21H1, and as of the 21H1 semi-annual channel release of Windows Server. This utility is superseded by Windows PowerShell for WMI (see [Chapter 7—Working with WMI](/powershell/scripting/learn/ps101/07-working-with-wmi)). This deprecation applies only to the WMI command-line (WMIC) utility; Windows Management Instrumentation (WMI) itself is not affected. Also see [Windows 10 features we're no longer developing](/windows/deployment/planning/windows-10-deprecated-features).

## Syntax

```cmd
wmic </parameter>
```

## Sub-commands

The following sub-commands are available:

|Sub-command|Description|
|-----------|-----------|
|class|Escapes from the default alias mode of WMIC to access classes in the WMI schema directly.|
|path|Escapes from the default alias mode of WMIC to access instances in the WMI schema directly.|
|context|Displays the current values of all global switches.|
|[quit \| exit]|Exits the WMIC command shell.|

## Examples

To display the current values of all global switches, type:

```cmd
wmic context
```

Output similar to the following displays:

```cmd
NAMESPACE    : root\cimv2
ROLE         : root\cli
NODE(S)      : BOBENTERPRISE
IMPLEVEL     : IMPERSONATE
[AUTHORITY   : N/A]
AUTHLEVEL    : PKTPRIVACY
LOCALE       : ms_409
PRIVILEGES   : ENABLE
TRACE        : OFF
RECORD       : N/A
INTERACTIVE  : OFF
FAILFAST     : OFF
OUTPUT       : STDOUT
APPEND       : STDOUT
USER         : N/A
AGGREGATE    : ON
```

To change the language ID used by the command line to English (locale ID 409), type:

```cmd
wmic /locale:ms_409
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
