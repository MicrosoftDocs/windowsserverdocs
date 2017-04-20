---
title: robocopy
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: d4c6e8e9-fcb3-4a4a-9d04-2d8c367b6354
author: coreyp-at-msft
ms.author: coreyp
manager: lizapo
ms.date: 02/28/2017
---
# robocopy

>Applies To: Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Copies file data.
## Syntax
```
robocopy <Source> <Destination> [<File>[ ...]] [<Options>]
```
## Parameters
|Parameter|Description|
|-------|--------|
|<Source>|Specifies the path to the source directory.|
|<Destination>|Specifies the path to the destination directory.|
|<File>|Specifies the file or files to be copied. You can use wildcard characters (**\*** or **?**), if you want. If the **File** parameter is not specified, **\*.\*** is used as the default value.|
|<Options>|Specifies options to be used with the **robocopy**command.|

#### Copy options
|Option|Description|
|-----|--------|
|/s|Copies subdirectories. Note that this option excludes empty directories.|
|/e|Copies subdirectories. Note that this option includes empty directories. For additional information, see [remarks](robocopy.md#BKMK_remarks).|
|/lev:<N>|Copies only the top *N* levels of the source directory tree.|
|/z|Copies files in Restart mode.|
|/b|Copies files in Backup mode.|
|/zb|Uses Restart mode. If access is denied, this option uses Backup mode.|
|/efsraw|Copies all encrypted files in EFS RAW mode.|
|/copy:<copyFlags>|Specifies the file properties to be copied. The following are the valid values for this option:<br /><br />**D** Data<br /><br />**A** attributes<br /><br />**T** time stamps<br /><br />**S** NTFS access control list (ACL)<br /><br />**O** Owner information<br /><br />**U** Auditing information<br /><br />The default value for **copyFlags** is **Dat** (data, attributes, and time stamps).|
|/dcopy:T|Copies directory time stamps.|
|/sec|Copies files with security (equivalent to **/copy:Dat**).|
|/copyall|Copies all file information (equivalent to **/copy:DatSOU**).|
|/nocopy|Copies no file information (useful with **/purge**).|
|/secfix|Fixes file security on all files, even skipped ones.|
|/timfix|Fixes file times on all files, even skipped ones.|
|/purge|deletes destination files and directories that no longer exist in the source. For additional information, see [remarks](robocopy.md#BKMK_remarks).|
|/mir|Mirrors a directory tree (equivalent to **/e** plus **/purge**). For additional information, see [remarks](robocopy.md#BKMK_remarks).|
|/mov|moves files, and deletes them from the source after they are copied.|
|/move|moves files and directories, and deletes them from the source after they are copied.|
|/a+:[RASHCNET]|adds the specified attributes to copied files.|
|/a-:[RASHCNET]|removes the specified attributes from copied files.|
|/create|creates a directory tree and zero-length files only.|
|/fat|creates destination files by using 8.3 character-length Fat file names only.|
|/256|Turns off support for very long paths (longer than 256 characters).|
|/mon:<N>|Monitors the source, and runs again when more than *N* changes are detected.|
|/mot:<M>|Monitors source, and runs again in *M* minutes if changes are detected.|
|/MT[:N]|creates multi-threaded copies with *N* threads. *N* must be an integer between 1 and 128. The default value for *N* is 8.<br /><br />The **/MT** parameter cannot be used with the **/IPG** and **/EFSRAW** parameters.<br /><br />Redirect output using **/LOG** option for better performance. **Note:** The /MT parameter applies to Windows Server 2008 R2 and Windows 7.|
|/rh:hhmm-hhmm|Specifies run times when new copies may be started.|
|/pf|Checks run times on a per-file (not per-pass) basis.|
|/ipg:n|Specifies the inter-packet gap to free bandwidth on slow lines.|
|/sl|Copies the symbolic link instead of the target.|

> [!IMPORTANT]
> When using the **/SECFIX** copy option, specify the type of security information you want to copy by also using one of these additional copy options:
> 
> -   **/copyALL**
> -   **/copy:O**
> -   **/copy:S**
> -   **/copy:U**
> -   **/SEC**

#### File selection options
|Option|Description|
|-----|--------|
|/a|Copies only files for which the **Archive** attribute is set.|
|/m|Copies only files for which the **Archive** attribute is set, and resets the **Archive** attribute.|
|/ia:[RASHCNETO]|Includes only files for which any of the specified attributes are set.|
|/xa:[RASHCNETO]|Excludes files for which any of the specified attributes are set.|
|/xf <FileName>[ ...]|Excludes files that match the specified names or paths. Note that *FileName* can include wildcard characters (**\*** and **?**).|
|/xd <directory>[ ...]|Excludes directories that match the specified names and paths.|
|/xct|Excludes changed files.|
|/xn|Excludes newer files.|
|/xo|Excludes older files.|
|/xx|Excludes extra files and directories.|
|/xl|Excludes "lonely" files and directories.|
|/is|Includes the same files.|
|/it|Includes "tweaked" files.|
|/max:<N>|Specifies the maximum file size (to exclude files bigger than *N* bytes).|
|/min:<N>|Specifies the minimum file size (to exclude files smaller than *N* bytes).|
|/maxage:<N>|Specifies the maximum file age (to exclude files older than *N* days or date).|
|/minage:<N>|Specifies the minimum file age (exclude files newer than *N* days or date).|
|/maxlad:<N>|Specifies the maximum last access date (excludes files unused since *N*).|
|/minlad:<N>|Specifies the minimum last access date (excludes files used since *N*) if *N* is less than 1900, *N* specifies the number of days. Otherwise, *N* specifies a date in the format YYYYMMDD.|
|/xj|Excludes junction points, which are normally included by default.|
|/fft|Assumes Fat file times (two-second precision).|
|/dst|compensates for one-hour DST time differences.|
|/xjd|Excludes junction points for directories.|
|/xjf|Excludes junction points for files.|

#### Retry options
|Option|Description|
|-----|--------|
|/r:<N>|Specifies the number of retries on failed copies. The default value of *N* is 1,000,000 (one million retries).|
|/w:<N>|Specifies the wait time between retries, in seconds. The default value of *N* is 30  (wait time 30 seconds).|
|/reg|Saves the values specified in the **/r** and **/w** options as default settings in the registry.|
|/tbd|Specifies that the system will wait for share names to be defined (retry error 67).|

#### Logging options
|Option|Description|
|-----|--------|
|/l|Specifies that files are to be listed only (and not copied, deleted, or time stamped).|
|/x|Reports all extra files, not just those that are selected.|
|/v|Produces verbose output, and shows all skipped files.|
|/ts|Includes source file time stamps in the output.|
|/fp|Includes the full path names of the files in the output.|
|/bytes|prints sizes, as bytes.|
|/ns|Specifies that file sizes are not to be logged.|
|/nc|Specifies that file classes are not to be logged.|
|/nfl|Specifies that file names are not to be logged.|
|/ndl|Specifies that directory names are not to be logged.|
|/np|Specifies that the progress of the copying operation (the number of files or directories copied so far) will not be displayed.|
|/eta|Shows the estimated time of arrival (ETA) of the copied files.|
|/log:<LogFile>|Writes the status output to the log file (overwrites the existing log file).|
|/log+:<LogFile>|Writes the status output to the log file (appends the output to the existing log file).|
|/unicode|Displays the status output as Unicode text.|
|/unilog:<LogFile>|Writes the status output to the log file as Unicode text (overwrites the existing log file).|
|/unilog+:<LogFile>|Writes the status output to the log file as Unicode text (appends the output to the existing log file).|
|/tee|Writes the status output to the console window, as well as to the log file.|
|/njh|Specifies that there is no job header.|
|/njs|Specifies that there is no job summary.|

#### Job options
|Option|Description|
|-----|--------|
|/job:<JobName>|Specifies that parameters are to be derived from the named job file.|
|/save:<JobName>|Specifies that parameters are to be saved to the named job file.|
|/quit|Quits after processing command line (to view parameters).|
|/nosd|Indicates that no source directory is specified.|
|/nodd|Indicates that no destination directory is specified.|
|/if|Includes the specified files.|

#### <a name="BKMK_remarks"></a>Remarks
-   The **/mir** option is equivalent to the **/e** plus **/purge** options with one small difference in behavior:
    -   With the **/e** plus **/purge** options, if the destination directory exists, the destination directory security settings are not overwritten.
    -   With the **/mir** option, if the destination directory exists, the destination directory security settings are overwritten.

#### Additional references
[Command-Line Syntax Key](command-line-syntax-key.md)
