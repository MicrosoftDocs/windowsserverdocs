---
title: fsutil 8dot3name
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: de99ab45-1b22-44d0-9c45-4852abbf8d9b
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/12/2016
---
# fsutil 8dot3name

>Applies To: Windows Server&reg; 2016, Windows Server&reg; 2012 R2, Windows Server&reg; 2012

Queries or changes the settings for short name \(8dot3 name\) behavior, which include:  
  
-   query the current setting for the short name behavior  
  
-   Scan the specified directory path for registry keys that might be impacted if short names were stripped from the specified directory path  
  
-   change the setting that controls the short name behavior. This setting can be applied to a specified volume or to the default volume setting.  
  
-   remove the short names for all files within a directory  
  
for examples of how to use this command, see [Examples](#BKMK_examples).  
  
## Syntax  
  
```  
fsutil 8dot3name [query] [<volumepath>]  
fsutil 8dot3name [scan] [/s] [/l [<log file>] ] [/v] <directorypath>  
fsutil 8dot3name [set] { <DefaultValue> | <volumepath> {1|0}}  
fsutil 8dot3name [strip] [/t] [/s] [/f] [/l [<log file.] ] [/v] <directorypath>  
```  
  
## Parameters  
  
|Parameter|Description|  
|-------|--------|  
|query \[<volumepath>\]|Queries the file system for the state of the 8dot3 short name creation behavior.<br /><br />if a *volumepath* is not specified as a parameter, the default 8dot3name creation behavior setting for all volumes is displayed.|  
|scan <directorypath>|Scans the files that are located in the specified *directorypath* for registry keys that might be impacted if 8dot3 short names were stripped from the file names.|  
|set { <DefaultValue> &#124; <volumepath>}|changes the file system behavior for 8dot3 name creation in the following instances:<br /><br /><ul><li>When *DefaultValue* is specified, the registry key, **HKLM\\System\\CurrentControlSet\\Control\\FileSystem\\NtfsDisable8dot3NameCreationNtfsDisable8dot3NameCreationNtfsDisable8dot3NameCreation**, will be set to the *DefaultValue*.<br /><br />    The *DefaultValue* can have the following values:<br /><br /><ul><li>**0**: Enables 8dot3 name creation for all volumes on the system.</li><li>**1**: Disables 8dot3 name creation for all volumes on the system.</li><li>**2**: Sets 8dot3 name creation on a per volume basis.</li><li>**3**: Disables 8dot3 name creation for all volumes except the system volume.</li></ul></li><li>When a *volumepath* is specified, the specified volumes on disk flag 8dot3name properties will be set to enable 8dot3 name creation for a specified volume \(**0**\) or set to disable 8dot3 name creation on the specified volume \(**1**\).<br /><br />    You must set the default file system behavior for 8dot3 name creation to the value **2** before you can enable or disable 8dot3 name creation for a specified volume.</li></ul>|  
|strip <directorypath>|removes the 8dot3 file names for all files that are located in the specified *directorypath*. The 8dot3 file name is not removed for any files where the *directorypath* combined with the file name contains more than 260 characters.<br /><br />This command lists, but does not modify the registry keys that point to the files that had 8dot3 file names permanently removed.<br /><br />for more information about the effects of permanently removing the 8dot3 file names from files, see [remarks](fsutil-8dot3name.md#BKMK_remarks).|  
|<volumepath>|Specifies the drive name followed by a colon or the GUID in the format **volume{***GUID***}**.|  
|\/f|Specifies that all files that are located in the specified *directorypath* will have the 8dot3 file names removed even if there are registry keys that point to files using the 8dot3 file name. In this case, the operation removes the 8dot3 file names, but does not modify any registry keys that point to the files that are using the 8dot3 file names. **Warning:** It is recommended that you back up your directory or volume prior to using the **\/f** parameter because it may lead to unexpected application failures, including the inability to uninstall programs.|  
|\/l \[<log file>\]|Specifies a log file where information will be written.<br /><br />if the **\/l** parameter is not specified, all information is written to the default log file:<br /><br />**%temp%\\8dot3\_removal\_log@\(***GMT YYYY\-MM\-DD HH\-MM\-SS***\).log**|  
|\/s|Specifies that the operation should be applied to the subdirectories of the specified *directorypath*.|  
|\/t|Specifies that the removal of 8dot3 file names should be run in test mode. All operations except the actual removal of the 8dot3 file names are performed. You can use test mode to discover which registry keys point to files that use the 8dot3 file names.|  
|\/v|Specifies that all information that is written to the log file is also displayed on the command\-line.|  
  
## <a name="BKMK_remarks"></a>remarks  
  
-   Permanently removing 8dot3 file names and not modifying registry keys that point to the 8dot3 file names may lead to unexpected application failures, including the inability to uninstall an application. It is recommended you first back up your directory or volume before you attempt to remove 8dot3 file names.  
  
## <a name="BKMK_examples"></a>Examples  
To query for the disable 8dot3 name behavior for a disk volume that is specified with the GUID, {928842df\-5a01\-11de\-a85c\-806e6f6e6963}, type:  
  
```  
fsutil 8dot3name query volume{928842df-5a01-11de-a85c-806e6f6e6963}  
```  
  
You can also query the 8dot3 name behavior by using the **behavior** subcommand.  
  
To remove 8dot3 file names in the *D:\\MyData* directory and all subdirectories, while writing the information to the log file that is specified as *mylogfile.log*, type:  
  
```  
fsutil 8dot3name scan /l mylogfile.log /s d:\MyData  
```  
  
### additional references  
[Command-Line Syntax Key](command-line-syntax-key.md)  
  
[fsutil](fsutil.md)  
  
[fsutil 8dot3name](fsutil-8dot3name.md)  
  
[fsutil behavior](fsutil-behavior.md)  
  

