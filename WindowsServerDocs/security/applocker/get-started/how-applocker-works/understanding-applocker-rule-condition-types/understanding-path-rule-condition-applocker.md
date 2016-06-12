---
title: Understanding the Path Rule Condition in applocker
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 25513809-5e46-402c-a977-d0c1577304d6
---
# Understanding the Path Rule Condition in applocker
This topic explains the applocker path rule condition, the advantages and disadvantages, and how it is applied.

The path condition identifies an application by its location in the file system of the computer or on the network.

When creating a rule that uses a deny action, path conditions are less secure than publisher and file hash conditions for preventing access to a file because a user could easily copy the file to a different location than the location specified in the rule. Because path rules specify locations within the file system, you should ensure that there are no subdirectories that are writable by non\-administrators. For example, if you create a path rule for C:\\ with the allow action, any file under that location will be allowed to run, including within users' profiles. The following table describes the advantages and disadvantages of the path condition.

|Path condition advantages|Path condition disadvantages|
|-----------------------------|--------------------------------|
|-   You can easily control many directories or a single file.<br />-   You can use the asterisk \(\*\) as a wildcard character within path rules.|-   It might be less secure if a rule that is configured to use a directory path contains subdirectories that are writable by non\-administrators.<br />-   You must specify the full path to a file or folder when creating path rules so that the rule will be properly enforced.|

applocker does not enforce rules that specify paths with short names. You should always specify the full path to a file or folder when creating path rules so that the rule will be properly enforced.

The asterisk \(\*\) wildcard character can be used within **Path** field. The asterisk \(\*\) character used by itself represents any path. When combined with any string value, the rule is limited to the path of the file and all the files under that path. For example, %ProgramFiles%\\Internet Explorer\\\* indicates that all files and subfolders within the Internet Explorer folder will be affected by the rule.

applocker uses path variables for well\-known directories in Windows. Path variables are not environment variables. The applocker engine can only interpret applocker path variables. The following table details these path variables.

|Windows directory or drive|applocker path variable|Windows environment variable|
|------------------------------|---------------------------|--------------------------------|
|Windows|%WINDIR%|%SystemRoot%|
|System32|%SYSTEM32%|%SystemDirectory%|
|Windows installation directory|%OSDRIVE%|%SystemDrive%|
|Program Files|%PROGRAMFILES%|%ProgramFiles% and %ProgramFiles\(x86\)%|
|Removable media \(for example, CD or DVD\)|%REMOVABLE%||
|Removable storage device \(for example, USB flash drive\)|%HOT%||

For an overview of the three types of applocker rule conditions and explanations of the advantages and disadvantages of each, see [Understanding applocker Rule Condition Types]().

## See Also
[How applocker Works]()


