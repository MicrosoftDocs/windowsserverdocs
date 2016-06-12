---
title: Script Rules in AppLocker
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5179f0a6-e9db-447d-a14b-74d721d5599f
---
# Script Rules in AppLocker
This topic describes the file formats and available default rules for the script rule collection.

AppLocker defines script rules to include only the following file formats:

-   .ps1

-   .bat

-   .cmd

-   .vbs

-   .js

The following table lists the default rules that are available for the script rule collection.

|Purpose|Name|User|Rule condition type|
|-----------|--------|--------|-----------------------|
|Allows members of the local Administrators group to run all scripts|\(Default Rule\) All scripts|BUILTIN\\Administrators|Path: \*|
|Allow all users to run scripts in the Windows folder|\(Default Rule\) All scripts located in the Windows folder|Everyone|Path: %windir%\\\*|
|Allow all users to run scripts in the Program Files folder|\(Default Rule\) All scripts located in the Program Files folder|Everyone|Path: %programfiles%\\\*|

## See Also
[Understanding AppLocker Default Rules](Understanding-AppLocker-Default-Rules.md)


