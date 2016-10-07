---
title: Auditpol list
description: "Windows Commands"
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 45502abe-3d6e-4e13-94f0-8e6fcb6db860
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---

# Auditpol list

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Lists audit policy categories and/or subcategories, or lists users for whom a per-user audit policy is defined.
For examples of how this command can be used, see [Examples](#BKMK_examples).
## Syntax
```
auditpol /list
[/user|/category|subcategory[:<categoryname>|<{guid}>|*]]
[/v] [/r]
```
## Parameters
|Parameter|Description|
|-------------|---------------|
|/user|Retrieves all users for whom the per-user audit policy has been defined. If used with the /v parameter, the security identifier (SID) of the user is also displayed.|
|/category|Displays the names of categories understood by the system. If used with the /v parameter, the category globally unique identifier (GUID) is also displayed.|
|/subcategory|Displays the names of subcategories and their associated GUID.|
|/v|Displays the GUID with the category or subcategory, or when used with /user, displays the SID of each user.|
|/r|Displays the output as a report in comma-separated value (CSV) format.|
|/?|Displays help at the command prompt.|
## Remarks
For all list operations for the per-user policy, you must have Read permission on that object set in the security descriptor. You can also perform list operations by possessing the **Manage auditing and security log** (SeSecurityPrivilege) user right. However, this right allows additional access that is not necessary to perform the list operation.
## <a name="BKMK_examples"></a>Examples
To list all users who have a defined audit policy, type:
```
Auditpol /list /user
```
To list all users who have a defined audit policy and their associated SID, type:
```
Auditpol /list /user /v
```
To list all categories and subcategories in report format, type:
```
Auditpol /list /subcategory:* /r
```
To list the subcategories of the Detailed Tracking and DS Access categories, type:
```
Auditpol /list /subcategory:"Detailed Tracking","DS Access"
```
#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)
