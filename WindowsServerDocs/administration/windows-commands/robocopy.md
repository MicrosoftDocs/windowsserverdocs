---
title: robocopy
description: Reference article for the robocopy command, which copies file data from one location to another.
ms.topic: reference
ms.assetid: d4c6e8e9-fcb3-4a4a-9d04-2d8c367b6354
author: xelu86
ms.author: wscontent
ms.date: 11/11/2023
---

# robocopy

Copies file data from one location to another.

## Syntax

```cmd
robocopy <source> <destination> [<file>[ ...]] [<options>]
```

For example, to copy a file named *yearly-report.mov* from *c:\reports* to a file share *\\\\marketing\videos* while enabling multi-threading for higher performance (with the **/mt** parameter) and the ability to restart the transfer in case it's interrupted (with the **/z** parameter), type:

```cmd
robocopy c:\reports "\\marketing\videos" yearly-report.mov /mt /z
```

> [!IMPORTANT]
> If any data is copied from the _root_ of a device, the destination directory will adopt the "hidden" attribute during the copy process.

### Parameters

| Parameter | Description |
|--|--|
| `<source>` | Specifies the path to the source directory. |
| `<destination>` | Specifies the path to the destination directory. |
| `<file>` | Specifies the file or files to be copied. Wildcard characters (**&#42;** or **?**) are supported. If you don't specify this parameter, `*.*` is used as the default value. |
| `<options>` | Specifies the options to use with the **robocopy** command, including **copy**, **file**, **retry**, **logging**, and **job** options. |

#### Copy options

| Option | Description |
|--|--|
| /s | Copies subdirectories. This option automatically excludes empty directories. |
| /e | Copies subdirectories. This option automatically includes empty directories. |
| /lev:`<n>` | Copies only the top *n* levels of the source directory tree. |
| /z | Copies files in restartable mode. In restartable mode, should a file copy be interrupted, robocopy can pick up where it left off rather than recopying the entire file. |
| /b | Copies files in backup mode. In backup mode, robocopy overrides file and folder permission settings (ACLs), which might otherwise block access. |
| /zb | Copies files in restartable mode. If file access is denied, switches to backup mode. |
| /j | Copies using unbuffered I/O (recommended for large files). |
| /efsraw | Copies all encrypted files in EFS RAW mode. |
| /copy:`<copyflags>` | Specifies which file properties to copy. The valid values for this option are:<ul><li>**D** - Data</li><li>**A** - Attributes</li><li>**T** - Time stamps</li><li>**X** - Skip alt data streams</li><li>**S** - NTFS access control list (ACL)</li><li>**O** - Owner information</li><li>**U** - Auditing information</li></ul>The default value for the **/COPY** option is **DAT** (data, attributes, and time stamps). The **X** flag is ignored if either **/B** or **/ZB** is used. |
| /dcopy:`<copyflags>`| Specifies what to copy in directories. The valid values for this option are:<ul><li>**D** - Data</li><li>**A** - Attributes</li><li>**T** - Time stamps</li><li>**E** - Extended attribute</li><li>**X** - Skip alt data streams</li></ul>The default value for this option is **DA** (data and attributes). |
| /sec | Copies files with security (equivalent to **/copy:DATS**). |
| /copyall | Copies all file information (equivalent to **/copy:DATSOU**). |
| /nocopy | Copies no file information (useful with **/purge**). |
| /secfix | Fixes file security on all files, even skipped ones. |
| /timfix | Fixes file times on all files, even skipped ones. |
| /purge | Deletes destination files and directories that no longer exist in the source. Using this option with the **/e** option and a destination directory, allows the destination directory security settings to not be overwritten. |
| /mir | Mirrors a directory tree (equivalent to **/e** plus **/purge**). Using this option with the **/e** option and a destination directory, overwrites the destination directory security settings. |
| /mov | Moves files, and deletes them from the source after they're copied. |
| /move | Moves files and directories, and deletes them from the source after they're copied. |
| /a+:[RASHCNET] | Adds the specified attributes to copied files.  The valid values for this option are: <ul><li>**R** - Read only</li><li>**A** - Archive</li><li>**S** - System</li><li>**H** - Hidden</li><li>**C** - Compressed</li><li>**N** - Not content indexed</li><li>**E** - Encrypted</li><li>**T** - Temporary</li></ul> |
| /a-:[RASHCNETO] | Removes the specified attributes from copied files. The valid values for this option are: <ul><li>**R** - Read only</li><li>**A** - Archive</li><li>**S** - System</li><li>**H** - Hidden</li><li>**C** - Compressed</li><li>**N** - Not content indexed</li><li>**E** - Encrypted</li><li>**T** - Temporary</li><li>**O** - Offline</li></ul> |
| /create | Creates a directory tree and zero-length files only. |
| /fat | Creates destination files by using 8.3 character-length FAT file names only. |
| /256 | Turns off support for paths longer than 256 characters. |
| /mon:`<n>` | Monitors the source and runs again when more than *n* changes are detected. |
| /mot:`<m>` | Monitors the source and runs again in *m* minutes if changes are detected. |
| /rh:hhmm-hhmm | Specifies run times when new copies can be started. |
| /pf | Checks run times on a per-file (not per-pass) basis. |
| /ipg:`<n>` | Specifies the inter-packet gap to free bandwidth on slow lines. |
| /sj | Copies junctions (soft-links) to the destination path instead of link targets. |
| /sl | Don't follow symbolic links and instead create a copy of the link. |
| /mt:`<n>` | Creates multi-threaded copies with *n* threads. *n* must be an integer between 1 and 128. The default value for *n* is 8. For better performance, redirect your output using **/log** option.<p>The **/mt** parameter can't be used with the **/ipg** and **/efsraw** parameters. |
| /nodcopy | Copies no directory info (the default **/dcopy:DA** is done). |
| /nooffload | Copies files without using the Windows Copy Offload mechanism. |
| /compress | Requests network compression during file transfer, if applicable. |
| /sparse | Enables retaining the sparse state of files during copy. |

> [!IMPORTANT]
> When using the **/secfix** copy option, specify the type of security information you want to copy, using one of these additional copy options:
>
>- **/copyall**
>- **/copy:o**
>- **/copy:s**
>- **/copy:u**
>- **/sec**

> [!NOTE]
> The **/mt** parameter was introduced in Windows Server 2008 R2 and its functionality applies to current versions of Windows Server.

#### Copy file throttling options

| Option | Description |
|--|--|
| /iomaxsize:`<n>`[kmg] | The requested max i/o size per read/write cycle in *n* **k**ilobytes, **m**egabytes, or **g**igabytes. |
| /iorate:`<n>`[kmg] | The requested i/o rate in *n* **k**ilobytes **m**egabytes, or **g**igabytes per second. |
| /threshold:`<n>`[kmg] | The file size threshold for throttling in *n* **k**ilobytes, **m**egabytes, or **g**igabytes (see [Remarks](#remarks)). |

#### File selection options

| Option | Description |
|--|--|
| /a | Copies only files for which the **Archive** attribute is set. |
| /m | Copies only files for which the **Archive** attribute is set, and resets the **Archive** attribute. |
| /ia:`[RASHCNETO]` | Includes only files for which any of the specified attributes are set.  The valid values for this option are: <ul><li>**R** - Read only</li><li>**A** - Archive</li><li>**S** - System</li><li>**H** - Hidden</li><li>**C** - Compressed</li><li>**N** - Not content indexed</li><li>**E** - Encrypted</li><li>**T** - Temporary</li><li>**O** - Offline</li></ul> |
| /xa:`[RASHCNETO]` | Excludes files for which any of the specified attributes are set. The valid values for this option are: <ul><li>**R** - Read only</li><li>**A** - Archive</li><li>**S** - System</li><li>**H** - Hidden</li><li>**C** - Compressed</li><li>**N** - Not content indexed</li><li>**E** - Encrypted</li><li>**T** - Temporary</li><li>**O** - Offline</li></ul> |
| /xf `<filename>[ ...]` | Excludes files that match the specified names or paths. Wildcard characters (**&#42;** and **?**) are supported. |
| /xd `<directory>[ ...]` | Excludes directories that match the specified names and paths. |
| /xc | Excludes existing files with the same timestamp, but different file sizes. |
| /xn | Source directory files newer than the destination are excluded from the copy. |
| /xo | Source directory files older than the destination are excluded from the copy. |
| /xx | Excludes extra files and directories present in the destination but not the source. Excluding extra files won't delete files from the destination. |
| /xl | Excludes "lonely" files and directories present in the source but not the destination. Excluding lonely files prevents any new files from being added to the destination. |
| /im | Include modified files (differing change times). |
| /is | Includes the same files. Same files are identical in name, size, times, and all attributes. |
| /it | Includes "tweaked" files. Tweaked files have the same name, size, and times, but different attributes. |
| /max:`<n>` | Specifies the maximum file size (to exclude files bigger than *n* bytes). |
| /min:`<n>` | Specifies the minimum file size (to exclude files smaller than *n* bytes). |
| /maxage:`<n>` | Specifies the maximum file age (to exclude files older than *n* days or date). |
| /minage:`<n>` | Specifies the minimum file age (exclude files newer than *n* days or date). |
| /maxlad:`<n>` | Specifies the maximum last access date (excludes files unused since *n*). |
| /minlad:`<n>` | Specifies the minimum last access date (excludes files used since *n*) If *n* is less than 1900, *n* specifies the number of days. Otherwise, *n* specifies a date in the format YYYYMMDD. |
| /xj | Excludes junction points, which are normally included by default. |
| /fft | Assumes FAT file times (two-second precision). |
| /dst | Compensates for one-hour DST time differences. |
| /xjd | Excludes junction points for directories. |
| /xjf | Excludes junction points for files. |

#### Retry options

| Option | Description |
|--|--|
| /r:`<n>` | Specifies the number of retries on failed copies. The default value of *n* is 1,000,000 (one million retries). |
| /w:`<n>` | Specifies the wait time between retries, in seconds. The default value of *n* is 30 (wait time 30 seconds). |
| /reg | Saves the values specified in the **/r** and **/w** options as default settings in the registry. |
| /tbd | Specifies that the system waits for share names to be defined (retry error 67). |
| /lfsm | Operate in low free space mode that enables copy, pause and resume (see [Remarks](#remarks)). |
| /lfsm:`<n>`[kmg] | Specifies the floor size in *n* **k**ilobytes, **m**egabytes, or **g**igabytes. |

#### Logging options

| Option | Description |
|--|--|
| /l | Specifies that files are to be listed only (and not copied, deleted, or time stamped). |
| /x | Reports all extra files, not just the ones that are selected. |
| /v | Produces verbose output, and shows all skipped files. |
| /ts | Includes source file time stamps in the output. |
| /fp | Includes the full path names of the files in the output. |
| /bytes | Prints sizes as bytes. |
| /ns | Specifies that file sizes are not to be logged. |
| /nc | Specifies that file classes are not to be logged. |
| /nfl | Specifies that file names are not to be logged. |
| /ndl | Specifies that directory names are not to be logged. |
| /np | Specifies that the progress of the copying operation (the number of files or directories copied so far) won't be displayed. |
| /eta | Shows the estimated time of arrival (ETA) of the copied files. |
| /log:`<logfile>` | Writes the status output to the log file (overwrites the existing log file). |
| /log+:`<logfile>` | Writes the status output to the log file (appends the output to the existing log file). |
| /unilog:`<logfile>` | Writes the status output to the log file as unicode text (overwrites the existing log file). |
| /unilog+:`<logfile>` | Writes the status output to the log file as Unicode text (appends the output to the existing log file). |
| /tee | Writes the status output to the console window, and to the log file. |
| /njh | Specifies that there's no job header. |
| /njs | Specifies that there's no job summary. |
| /unicode | Displays the status output as unicode text. |

#### Job options

| Option | Description |
|--|--|
| /job:`<jobname>` | Specifies that parameters are to be derived from the named job file. To run `/job:jobname`, you must first run the `/save:jobname` parameter to create the job file. |
| /save:`<jobname>` | Specifies that parameters are to be saved to the named job file. This must be ran before running `/job:jobname`. All copy, retry, and logging options must be specified before this parameter. |
| /quit | Quits after processing command line (to view parameters). |
| /nosd | Indicates that no source directory is specified. |
| /nodd | Indicates that no destination directory is specified. |
| /if | Includes the specified files. |

#### Remarks

- Using **/PURGE** or **/MIR** on the root directory of the volume formerly caused robocopy to apply the requested operation on files inside the System Volume Information directory as well. This is no longer the case as if either is specified, robocopy will skip any files or directories with that name in the top-level source and destination directories of the copy session.

- Modified files classification applies only when both source and destination filesystems support change timestamps, such as NTFS, and the source and destination files have different change times but are otherwise the same. These files aren't copied by default. Specify **/IM** to include them.

- The **/DCOPY:E** flag requests that extended attribute copying should be attempted for directories. Robocopy will continue if a directory's EAs couldn't be copied. This flag isn't included in **/COPYALL**.

- If either **/IoMaxSize** or **/IoRate** are specified, robocopy will enable copy file throttling to reduce system load. Both can be adjusted to optimal values and copy parameters, but the system and robocopy are allowed to adjust them to allowed values as necessary.

- If **/Threshold** is used, it specifies a minimum file size for engaging throttling. Files below that size won't be throttled. Values for all three parameters can be followed by an optional suffix character such as [KMG] (kilo, mega, giga).

- Using **/LFSM** requests robocopy to operate in 'low free space mode'. In this mode, robocopy will pause whenever a file copy would cause the destination volume's free space to go below a 'floor' value. This value can be explicitly specified using **/LFSM:_n_**[KMG] flag.

- If **/LFSM** is specified with no explicit floor value, the floor is set to 10% of the destination volume's size. Low free space mode is incompatible with **/MT** and **/EFSRAW**.

### Exit (return) codes

| Value | Description |
|--|--|
| 0 | No files were copied. No failure was encountered. No files were mismatched. The files already exist in the destination directory; therefore, the copy operation was skipped. |
| 1 | All files were copied successfully. |
| 2 | There are some additional files in the destination directory that aren't present in the source directory. No files were copied. |
| 3 | Some files were copied. Additional files were present. No failure was encountered. |
| 5 | Some files were copied. Some files were mismatched. No failure was encountered. |
| 6 | Additional files and mismatched files exist. No files were copied and no failures were encountered meaning that the files already exist in the destination directory. |
| 7 | Files were copied, a file mismatch was present, and additional files were present. |
| 8 | Several files didn't copy. |

> [!NOTE]
> Any value equal to or greater than **8** indicates that there was at least one failure during the copy operation.

## Examples

It's highly recommended when running the `robocopy` command to create a log file that can be viewed once the process completes verifying its integrity. In the following examples, each one uses the `/LOG:` parameter. To append any log information to the same log file, use the `/LOG+:` parameter instead.

To copy all files and subdirectories, including empty directories, from the "Records" folder to the "Backup" folder on drive "D", type the following:

```cmd
robocopy C:\Users\Admin\Records D:\Backup /E /ZB /LOG:C:\Logs\Backup.log
```

To mirror the contents of the "Records" folder to the "Backup" folder on drive "D", delete any files in the destination that don't exist in the source with 2 retries and waiting 5 seconds between each retry, type the following:

```cmd
robocopy C:\Users\Admin\Records D:\Backup /MIR /R:2 /W:5 /LOG:C:\Logs\Backup.log
```

To copy all files and subdirectories that aren't empty from the "Records" folder to the "Backup" folder on drive "D", retaining the file data, attributes, and timestamps with 16 multi-threaded copy operation, type the following:

```cmd
robocopy C:\Users\Admin\Records D:\Backup /S /E /COPY:DAT /MT:16 /LOG:C:\Logs\Backup.log
```

To move files and subdirectories, excluding empty directories, from the "Records" folder to the "Backup" folder on drive "D", and exclude files older than 7 days, type the following:

```cmd
robocopy C:\Users\Admin\Records D:\Backup /S /MAXAGE:7 /MOV /LOG:C:\Logs\Backup.log
```

To copy all files and subdirectories, including empty directories, from the "Records" folder to the "Backup" folder on drive "D" showing the estimated time for each file and delete any files and directories in the destination that don't exist from the source, type the following:

```cmd
robocopy C:\Users\Admin\Records D:\Backup /ETA /PURGE /LOG:C:\Logs\Backup.log
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
