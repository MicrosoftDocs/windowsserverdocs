---
title: Understanding AppLocker Rule Behavior
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5d3c88ef-9d0c-4e52-9a06-78d5e7de022f
---
# Understanding AppLocker Rule Behavior
This topic describes how AppLocker rules are enforced by using the allow and deny options in AppLocker.

If no AppLocker rules for a specific rule collection exist, all files with that file format are allowed to run. However, when an AppLocker rule for a specific rule collection is created, only the files explicitly allowed in a rule are permitted to run. For example, if you create an executable rule that allows .exe files in *%SystemDrive%\FilePath* to run, only executable files located in that path are allowed to run.

A rule can be configured to use either an allow or deny action:

-   **Allow**. You can specify which files are allowed to run in your environment and for which users or groups of users. You can also configure exceptions to identify files that are excluded from the rule.

-   **Deny**. You can specify which files are *not* allowed to run in your environment and for which users or groups of users. You can also configure exceptions to identify files that are excluded from the rule.

> [!IMPORTANT]
> You can use a combination of allow actions and deny actions. However, we recommend using allow actions with exceptions because deny actions override allow actions in all cases. Deny actions can also be circumvented. For example, if you configure a deny action for a file or folder path, the user can still run the file from any other path.

## See Also
[How AppLocker Works](How-AppLocker-Works.md)


