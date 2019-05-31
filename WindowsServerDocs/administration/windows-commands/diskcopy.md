---
title: diskcopy
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 5fd21efa-52cc-4e70-a7fe-35125a435106
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 05/07/2018
---

# diskcopy



Copies the contents of the floppy disk in the source drive to a formatted or unformatted floppy disk in the destination drive. If used without parameters, **diskcopy** uses the current drive for the source disk and the destination disk.

For examples of how to use this command, see [Examples](#BKMK_examples).

> [!NOTE]
> This command isn't included in Windows 10.

## Syntax

```
diskcopy [<Drive1>: [<Drive2>:]] [/v]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<Drive1>|Specifies the drive that contains the source disk.|
|\<Drive2>|Specifies the drive that contains the destination disk.|
|/v|Verifies that the information is copied correctly. This option slows down the copying process.|
|/?|Displays help at the command prompt.|

## Remarks

-   Using disks

    **Diskcopy** works only with removable disks such as floppy disks, which must be the same type. You cannot use **diskcopy** with a hard disk. If you specify a hard disk drive for *Drive1* or *Drive2*, **diskcopy** displays the following error message:  
    ```
    Invalid drive specification
    Specified drive does not exist or is nonremovable
    ```  
    The **diskcopy** command prompts you to insert the source and destination disks and waits for you to press any key on the keyboard before continuing.

    After it copies the disk, **diskcopy** displays the following message:  
    ```
    Copy another diskette (Y/N)?
    ```  
    If you press Y, **diskcopy** prompts you to insert source and destination disks for the next copy operation. To stop the **diskcopy** process, press **N**.

    If you are copying to an unformatted floppy disk in *Drive2*, **diskcopy** formats the disk with the same number of sides and sectors per track as are on the disk in *Drive1*. **Diskcopy** displays the following message while it formats the disk and copies the files:  
    ```
    Formatting while copying
    ```  
-   Disk serial numbers

    If the source disk has a volume serial number, **diskcopy** creates a new volume serial number for the destination disk and displays the number when the copy operation is complete.
-   Omitting drive parameters

    If you omit the *Drive2* parameter, **diskcopy** uses the current drive as the destination drive. If you omit both drive parameters, **diskcopy** uses the current drive for both. If the current drive is the same as *Drive1*, **diskcopy** prompts you to swap disks as necessary.
-   Using one drive for copying

    Run **diskcopy** from a drive other than the floppy disk drive, for example the C drive. If floppy disk *Drive1* and floppy disk *Drive2* are the same, **diskcopy** prompts you to switch disks. If the disks contain more information than the available memory can hold, **diskcopy** cannot read all of the information at once. **Diskcopy** reads from the source disk, writes to the destination disk, and prompts you to insert the source disk again. This process continues until you have copied the entire disk.
-   Avoiding disk fragmentation

    Fragmentation is the presence of small areas of unused disk space between existing files on a disk. A fragmented source disk can slow down the process of finding, reading, or writing files.

    Because **diskcopy** makes an exact copy of the source disk on the destination disk, any fragmentation on the source disk is transferred to the destination disk. To avoid transferring fragmentation from one disk to another, use **copy** or **xcopy** to copy your disk. Because **copy** and **xcopy** copy files sequentially, the new disk is not fragmented.

> [!NOTE]
> You cannot use **xcopy** to copy a startup disk.
> -   Understanding **diskcopy** exit codes

    The following table explains each exit code.  
    |Exit code|Description|
    |---------|-----------|
    |0|Copy operation was successful|
    |1|Nonfatal Read/Write error occurred|
    |3|Fatal hard error occurred|
    |4|Initialization error occurred|

    To process the exit codes that are returned by **diskcomp**, you can use the *ERRORLEVEL* environment variable on the **if** command line in a batch program.

## <a name="BKMK_examples"></a>Examples

To copy the disk in drive B to the disk in drive A, type:
```
diskcopy b: a:
```
To use floppy disk drive A to copy one floppy disk to another, first switch to the C drive and then type:

diskcopy a: a:

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)