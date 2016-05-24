---
title: Executable Rules in AppLocker
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: e641eb38-d3bf-473b-9185-7eb78dfbcb0e
---
# Executable Rules in AppLocker
This topic describes the file formats and available default rules for the executable rule collection.  
  
AppLocker defines executable rules as any files with the .exe and .com extensions that are associated with an application. Because all of the default rules for the executable rule collection are based on folder paths, all files under those paths will be allowed. The following table lists the default rules that are available for the executable rule collection.  
  
|Purpose|Name|User|Rule condition type|  
|-----------|--------|--------|-----------------------|  
|Allow members of the local Administrators group access to run all executable files|\(Default Rule\) All files|BUILTIN\\Administrators|Path: \*|  
|Allow all users to run executable files in the Windows folder|\(Default Rule\) All files located in the Windows folder|Everyone|Path: %windir%\\\*|  
|Allow all users to run executable files in the Program Files folder|\(Default Rule\) All files located in the Program Files folder|Everyone|Path: %programfiles%\\\*|  
  
## See Also  
[Understanding AppLocker Default Rules](../Topic/Understanding-AppLocker-Default-Rules.md)  
  
