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
ms.date: 10/12/2016
---
# secedit

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

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
|-------|--------|
|[secedit:analyze](secedit-analyze.md)|Allows you to analyze current systems settings against baseline settings that are stored in a database.  The analysis results are stored in a separate area of the database and can be viewed in the Security Configuration and Analysis snap-in.|
|[secedit:configure](secedit-configure.md)|Allows you to configure a system with security settings stored in a database.|
|[secedit:export](secedit-export.md)|Allows you to export security settings stored in a database.|
|[secedit:generaterollback](secedit-generaterollback.md)|Allows you to generate a rollback template with respect to a configuration template.|
|[secedit:import](secedit-import.md)|Allows you to import a security template into a database so that the settings specified in the template can be applied to a system or analyzed against a system.|
|[secedit:validate](secedit-validate.md)|Allows you to validate the syntax of a security template.|
## remarks
for all filenames, the current directory is used if no path is specified.
When a security template is created using the Security Template snap-in and the Security Configuration and Analysis snap-in is run, the following files are created:
|File|Description|
|----|--------|
|Scesrv.log|**Location**: %windir%\security\logs<br /><br />**created by**: operating system<br /><br />**File type**: text<br /><br />**Refresh rate**: Overwritten when secedit /analyze, /configure, /export or /import are run.<br /><br />**Content**: Contains the results of the analysis grouped by policy type.|
|*User-selected name*.sdb|**Location**: %windir%\\*user account*\Documents\Security\Database<br /><br />**created by**: running the Security Configuration and Analysis snap-in<br /><br />**File type**: proprietary<br /><br />**Refresh rate**: Updated whenever a new security template is created.<br /><br />**Content**: Local security policies and user-created security templates.|
|*User-selected name*.log|**Location**: User-defined but defaults to %windir%\\*user account*\Documents\Security\Logs<br /><br />**created by**: Running the /analyze and /configure subcommands (or using the Security Configuration and Analysis snap-in)<br /><br />**File type**: text<br /><br />**Refresh rate**: Running the /analyze and /configure subcommands (or using the Security Configuration and Analysis snap-in); overwritten.<br /><br />**Content**:<br /><br />1.  Log file name<br />2.  date and time<br />3.  Results of analysis or investigation.|
|*User-selected name*.inf|**Location**: %windir%\\*user account*\Documents\Security\Templates<br /><br />**created by**: running the Security Template snap-in<br /><br />**File type**: text<br /><br />**Refresh rate**: each time the security template is updated<br /><br />**Content**: Contains the set up information for the template for each policy selected using the snap-in.|
> [!NOTE]
> The Microsoft Management Console (mmc) and the Security Configuration and Analysis snap-in are not available on Server Core.
## additional references
for examples of how this command can be used, see the examples section in any of the subcommand files.
-   [Command-Line Syntax Key](command-line-syntax-key.md)
