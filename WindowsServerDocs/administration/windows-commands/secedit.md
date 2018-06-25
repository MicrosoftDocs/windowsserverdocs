---
title: secedit
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 58ed57ed-08e3-403d-a363-0620b358637a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# secedit



Configures and analyzes system security by comparing your current configuration to specified security templates.

## Syntax

```
secedit 
[/analyze /db <database file name> /cfg <configuration file name> [/overwrite] /log <log file name> [/quiet]]
[/configure /db <database file name> [/cfg <configuration filename>] [/overwrite] [/areas [securitypolicy | group_mgmt | user_rights | regkeys | filestore | services]] [/log <log file name>] [/quiet]]
[/export /db <database file name> [/mergedpolicy] /cfg <configuration file name> [/areas [securitypolicy | group_mgmt | user_rights | regkeys | filestore | services]] [/log <log file name>]]
[/generaterollback /db <database file name> /cfg <configuration file name> /rbk <rollback file name> [/log <log file name>] [/quiet]]
[/import /db <database file name> /cfg <configuration file name> [/overwrite] [/areas [securitypolicy | group_mgmt | user_rights | regkeys | filestore | services]] [/log <log file name>] [/quiet]]
[/validate <configuration file name>]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|[Secedit:analyze](secedit-analyze.md)|Allows you to analyze current systems settings against baseline settings that are stored in a database.  The analysis results are stored in a separate area of the database and can be viewed in the Security Configuration and Analysis snap-in.|
|[Secedit:configure](secedit-configure.md)|Allows you to configure a system with security settings stored in a database.|
|[Secedit:export](secedit-export.md)|Allows you to export security settings stored in a database.|
|[Secedit:generaterollback](secedit-generaterollback.md)|Allows you to generate a rollback template with respect to a configuration template.|
|[Secedit:import](secedit-import.md)|Allows you to import a security template into a database so that the settings specified in the template can be applied to a system or analyzed against a system.|
|[Secedit:validate](secedit-validate.md)|Allows you to validate the syntax of a security template.|

## Remarks

For all filenames, the current directory is used if no path is specified.

When a security template is created using the Security Template snap-in and the Security Configuration and Analysis snap-in is run, the following files are created:

|File|Description|
|----|-----------|
|Scesrv.log|**Location**: %windir%\security\logs</br>**Created by**: operating system</br>**File type**: text</br>**Refresh rate**: Overwritten when secedit /analyze, /configure, /export or /import are run.</br>**Content**: Contains the results of the analysis grouped by policy type.|
|*User-selected name*.sdb|**Location**: %windir%\*user account*\Documents\Security\Database</br>**Created by**: running the Security Configuration and Analysis snap-in</br>**File type**: proprietary</br>**Refresh rate**: Updated whenever a new security template is created.</br>**Content**: Local security policies and user-created security templates.|
|*User-selected name*.log|**Location**: User-defined but defaults to %windir%\*user account*\Documents\Security\Logs</br>**Created by**: Running the /analyze and /configure subcommands (or using the Security Configuration and Analysis snap-in)</br>**File type**: text</br>**Refresh rate**: Running the /analyze and /configure subcommands (or using the Security Configuration and Analysis snap-in); overwritten.</br>**Content**:</br>1.  Log file name</br>2.  Date and time</br>3.  Results of analysis or investigation.|
|*User-selected name*.inf|**Location**: %windir%\*user account*\Documents\Security\Templates</br>**Created by**: running the Security Template snap-in</br>**File type**: text</br>**Refresh rate**: each time the security template is updated</br>**Content**: Contains the set up information for the template for each policy selected using the snap-in.|

> [!NOTE]
> The Microsoft Management Console (MMC) and the Security Configuration and Analysis snap-in are not available on Server Core.

#### Additional references

For examples of how this command can be used, see the examples section in any of the subcommand files.
-   [Command-Line Syntax Key](command-line-syntax-key.md)