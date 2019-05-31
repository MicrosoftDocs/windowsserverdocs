---
title: robocopy
description: Learn how to use the robocopy command in Windows and Windows Server to copy files
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
ms.date: 07/25/2018
---

# robocopy

Copies file data.

## Syntax

```
robocopy <Source> <Destination> [<File>[ ...]] [<Options>]
```

## Parameters

|   Parameter    |                                                                                            Description                                                                                             |
|----------------|----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|   \<Source>    |                                                                            Specifies the path to the source directory.                                                                             |
| \<Destination> |                                                                          Specifies the path to the destination directory.                                                                          |
|    \<File>     | Specifies the file or files to be copied. You can use wildcard characters (**&#42;** or **?**), if you want. If the **File** parameter is not specified, **\*.\\**\* is used as the default value. |
|   \<Options>   |                                                                    Specifies options to be used with the **robocopy** command.                                                                     |

### Copy options

|Option|Description|
|------|-----------|
|/s|Copies subdirectories. Note that this option excludes empty directories.|
|/e|Copies subdirectories. Note that this option includes empty directories. For additional information, see [Remarks](#remarks).|
|/lev:\<N>|Copies only the top *N* levels of the source directory tree.|
|/z|Copies files in restartable mode.|
|/b|Copies files in Backup mode.|
|/zb|Uses restartable mode. If access is denied, this option uses Backup mode.|
|/efsraw|Copies all encrypted files in EFS RAW mode.|
|/copy:\<CopyFlags>|Specifies the file properties to be copied. The following are the valid values for this option:</br>**D** Data</br>**A** Attributes</br>**T** Time stamps</br>**S** NTFS access control list (ACL)</br>**O** Owner information</br>**U** Auditing information</br>The default value for **CopyFlags** is **DAT** (data, attributes, and time stamps).|
|/dcopy:\<copyflags\>|Defines what to copy for directories. Default is DA. Options are D = data, A = attributes, and T = timestamps.|
|/sec|Copies files with security (equivalent to **/copy:DATS**).|
|/copyall|Copies all file information (equivalent to **/copy:DATSOU**).|
|/nocopy|Copies no file information (useful with **/purge**).|
|/secfix|Fixes file security on all files, even skipped ones.|
|/timfix|Fixes file times on all files, even skipped ones.|
|/purge|Deletes destination files and directories that no longer exist in the source. For additional information, see [Remarks](#remarks).|
|/mir|Mirrors a directory tree (equivalent to **/e** plus **/purge**). For additional information, see [Remarks](#remarks).|
|/mov|Moves files, and deletes them from the source after they are copied.|
|/move|Moves files and directories, and deletes them from the source after they are copied.|
|/a+:[RASHCNET]|Adds the specified attributes to copied files.|
|/a-:[RASHCNET]|Removes the specified attributes from copied files.|
|/create|Creates a directory tree and zero-length files only.|
|/fat|Creates destination files by using 8.3 character-length FAT file names only.|
|/256|Turns off support for very long paths (longer than 256 characters).|
|/mon:\<N>|Monitors the source, and runs again when more than *N* changes are detected.|
|/mot:\<M>|Monitors source, and runs again in *M* minutes if changes are detected.|
|/MT[:N]|Creates multi-threaded copies with *N* threads. *N* must be an integer between 1 and 128. The default value for *N* is 8.</br>The **/MT** parameter cannot be used with the **/IPG** and **/EFSRAW** parameters.</br>Redirect output using **/LOG** option for better performance.</br>Note: The /MT parameter applies to Windows Server 2008 R2 and Windows 7.|
|/rh:hhmm-hhmm|Specifies run times when new copies may be started.|
|/pf|Checks run times on a per-file (not per-pass) basis.|
|/ipg:n|Specifies the inter-packet gap to free bandwidth on slow lines.|
|/sl|Don't follow symbolic links and instead create a copy of the link.|

> [!IMPORTANT]
> When using the **/SECFIX** copy option, specify the type of security information you want to copy by also using one of these additional copy options:
>- **/COPYALL**
>- **/COPY:O**
>- **/COPY:S**
>- **/COPY:U**
>- **/SEC**

### File selection options

|Option|Description|
|------|-----------|
|/a|Copies only files for which the **Archive** attribute is set.|
|/m|Copies only files for which the **Archive** attribute is set, and resets the **Archive** attribute.|
|/ia:[RASHCNETO]|Includes only files for which any of the specified attributes are set.|
|/xa:[RASHCNETO]|Excludes files for which any of the specified attributes are set.|
|/xf \<FileName>[ ...]|Excludes files that match the specified names or paths. Note that *FileName* can include wildcard characters (**&#42;** and **?**).|
|/xd \<Directory>[ ...]|Excludes directories that match the specified names and paths.|
|/xc|Excludes changed files.|
|/xn|Excludes newer files.|
|/xo|Excludes older files.|
|/xx|Excludes extra files and directories.|
|/xl|Excludes "lonely" files and directories.|
|/is|Includes the same files.|
|/it|Includes "tweaked" files.|
|/max:\<N>|Specifies the maximum file size (to exclude files bigger than *N* bytes).|
|/min:\<N>|Specifies the minimum file size (to exclude files smaller than *N* bytes).|
|/maxage:\<N>|Specifies the maximum file age (to exclude files older than *N* days or date).|
|/minage:\<N>|Specifies the minimum file age (exclude files newer than *N* days or date).|
|/maxlad:\<N>|Specifies the maximum last access date (excludes files unused since *N*).|
|/minlad:\<N>|Specifies the minimum last access date (excludes files used since *N*) If *N* is less than 1900, *N* specifies the number of days. Otherwise, *N* specifies a date in the format YYYYMMDD.|
|/xj|Excludes junction points, which are normally included by default.|
|/fft|Assumes FAT file times (two-second precision).|
|/dst|Compensates for one-hour DST time differences.|
|/xjd|Excludes junction points for directories.|
|/xjf|Excludes junction points for files.|

### Retry options

|Option|Description|
|------|-----------|
|/r:\<N>|Specifies the number of retries on failed copies. The default value of *N* is 1,000,000 (one million retries).|
|/w:\<N>|Specifies the wait time between retries, in seconds. The default value of *N* is 30  (wait time 30 seconds).|
|/reg|Saves the values specified in the **/r** and **/w** options as default settings in the registry.|
|/tbd|Specifies that the system will wait for share names to be defined (retry error 67).|

### Logging options

|Option|Description|
|------|-----------|
|/l|Specifies that files are to be listed only (and not copied, deleted, or time stamped).|
|/x|Reports all extra files, not just those that are selected.|
|/v|Produces verbose output, and shows all skipped files.|
|/ts|Includes source file time stamps in the output.|
|/fp|Includes the full path names of the files in the output.|
|/bytes|Prints sizes, as bytes.|
|/ns|Specifies that file sizes are not to be logged.|
|/nc|Specifies that file classes are not to be logged.|
|/nfl|Specifies that file names are not to be logged.|
|/ndl|Specifies that directory names are not to be logged.|
|/np|Specifies that the progress of the copying operation (the number of files or directories copied so far) will not be displayed.|
|/eta|Shows the estimated time of arrival (ETA) of the copied files.|
|/log:\<LogFile>|Writes the status output to the log file (overwrites the existing log file).|
|/log+:\<LogFile>|Writes the status output to the log file (appends the output to the existing log file).|
|/unicode|Displays the status output as Unicode text.|
|/unilog:\<LogFile>|Writes the status output to the log file as Unicode text (overwrites the existing log file).|
|/unilog+:\<LogFile>|Writes the status output to the log file as Unicode text (appends the output to the existing log file).|
|/tee|Writes the status output to the console window, as well as to the log file.|
|/njh|Specifies that there is no job header.|
|/njs|Specifies that there is no job summary.|

### Job options

|Option|Description|
|------|-----------|
|/job:\<JobName>|Specifies that parameters are to be derived from the named job file.|
|/save:\<JobName>|Specifies that parameters are to be saved to the named job file.|
|/quit|Quits after processing command line (to view parameters).|
|/nosd|Indicates that no source directory is specified.|
|/nodd|Indicates that no destination directory is specified.|
|/if|Includes the specified files.|

### Exit (return) codes

Value | Description
-- | --
0 | No files were copied. No failure was encountered.  No files were mismatched. The files already exist in the destination directory; therefore, the copy operation was skipped.
1 | All files were copied successfully.
2 | There are some additional files in the destination directory that are not present in the source directory. No files were copied.
3 | Some files were copied. Additional files were present. No failure was encountered.
5 | Some files were copied. Some files were mismatched. No failure was encountered.
6 | Additional  files and mismatched files exist. No files were copied and no failures were encountered. This means that the files already exist in the destination directory.
7 | Files were copied, a file mismatch was present, and additional files were present.
8 | Several files did not copy.

> [!NOTE]
> Any value greater than 8 indicates that there was at least one failure during the copy operation.

### Remarks

-   The **/mir** option is equivalent to the **/e** plus **/purge** options with one small difference in behavior:  
    -   With the **/e** plus **/purge** options, if the destination directory exists, the destination directory security settings are not overwritten.
    -   With the **/mir** option, if the destination directory exists, the destination directory security settings are overwritten.

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
