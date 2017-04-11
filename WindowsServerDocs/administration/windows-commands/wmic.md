---
title: wmic
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 76397c72-d06f-4cea-88cf-c7603315a983
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# wmic

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Displays WMI information inside an interactive command shell.
for examples of how to use this command, see [Examples](#BKMK_examples).
## Syntax
```
command </parameter>
```
## Sub-commands
The following sub-commands are available at all times:
|Sub-command|Description|
|--------|--------|
|class|Escapes from the default alias mode of wmic to access classes in the WMI schema directly.|
|path|Escapes from the default alias mode of wmic to access instances in the WMI schema directly.|
|context|Displays the current values of all global switches.|
|[quit &#124; exit]|exits the wmic command shell.|
## Parameters
|Parameter|Description|
|-------|--------|
|<\/parameter>|<Concise description, starts with a verb.>|
|<\/param2>|<Another concise description, starts with a verb.>|
## remarks
## Scripting
## <a name="BKMK_examples"></a>Examples
To display the current values of all global switches, type:
```
wmic context
```
Output similar to the following displays:
```
NAMESPACE    : root\cimv2
ROLE         : root\cli
NODE(S)      : BOBENTERPRISE
IMPLEVEL     : IMPERSONatE
[AUTHORITY   : N/A]
AUTHLEVEL    : PKTPRIVACY
LOCALE       : ms_409
PRIVILEGES   : ENABLE
TRACE        : OFF
RECOrd       : N/A
INTERactive  : OFF
FAILFAST     : OFF
OUTPUT       : STDOUT
append       : STDOUT
USER         : N/A
AGGregatE    : ON
```
To change the language ID used by the command line to English (locale ID 409), type:
```
wmic /locale:ms_409
```
#### additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
