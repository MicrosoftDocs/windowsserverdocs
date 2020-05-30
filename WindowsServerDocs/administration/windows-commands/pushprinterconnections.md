---
title: pushprinterconnections
description: Reference topic for **** -

ms.prod: windows-server


ms.technology: manage-windows-commands

ms.topic: article
ms.assetid: c30afb97-b149-478f-a4b9-2cbc25361818
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# pushprinterconnections



Reads Deployed Printer Connection settings from Group Policy and deploys/removes printer connections as needed.

## Syntax

```
pushprinterconnections <-log> <-?>
```

#### Parameters

|Parameter|Description|
|---------|-----------|
|<-log>|Writes a per user debug log file to %temp, or writes a per machine debug log to %windir%\temp.|
|<-?>|Displays Help at the command prompt.|

## Remarks

This utility is for use in machine startup or user logon scripts, and should not be run from the command line.

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)
-   [Deploy Printers by Using Group Policy](https://go.microsoft.com/fwlink/?LinkId=230627)