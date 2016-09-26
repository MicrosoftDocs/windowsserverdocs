---
title: Bitsadmin util and version
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: 
  - management
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 98f17328-dfbd-4cbb-93c1-b8d424bc3f0a
author: coreyp
ms.author: coreyp-at-msft
ms.date: 09/14/2016
---
# Bitsadmin util and version
Displays the version of BITS service.
## Syntax
```
bitsadmin /Util /Version [/Verbose]
```
## Remarks
The **Verbose** command performs the following:
-   Displays the file version for each BITS related DLL
-   Verifies the BITS Service can be started
-   Displays BITS Group Policy values (Windows Vista only)
## <a name="BKMK_examples"></a>Examples
The following example the version of the BITS Service.
```
C:\>bitsadmin /Util /Version
```
## Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
