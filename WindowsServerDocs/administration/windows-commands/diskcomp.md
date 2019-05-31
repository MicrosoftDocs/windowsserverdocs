---
title: diskcomp
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4f56f534-a356-4daa-8b4f-38e089341e42
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# diskcomp



Compares the contents of two floppy disks. If used without parameters, **diskcomp** uses the current drive to compare both disks.For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
diskcomp [<Drive1>: [<Drive2>:]]
```

## Parameters

|Parameter|Description|
|---------|-----------|
|\<Drive1>|Specifies the drive containing one of the floppy disks.|
|\<Drive2>|Specifies the drive containing the other floppy disk.|
|/?|Displays help at the command prompt.|

## Remarks

- Using disks

  The **diskcomp** command works only with floppy disks. You cannot use **diskcomp** with a hard disk. If you specify a hard disk drive for *Drive1* or *Drive2*, **diskcomp** displays the following error message:  
  ```
  Invalid drive specification
  Specified drive does not exist
  or is nonremovable
  ```  
- Comparing disks

  If all tracks on the two disks being compared are the same, **diskcomp** displays the following message:  
  ```
  Compare OK
  ```  
  If the tracks are not the same, **diskcomp** displays a message similar to the following:  
  ```
  Compare error on
  side 1, track 2
  ```  
  When **diskcomp** completes the comparison, it displays the following message:  
  ```
  Compare another diskette (Y/N)?
  ```  
  If you press Y, **diskcomp** prompts you to insert the disk for the next comparison. If you press N, **diskcomp** stops the comparison.

  When **diskcomp** makes the comparison, it ignores a disk's volume number.
- Omitting drive parameters

  If you omit the *Drive2* parameter, **diskcomp** uses the current drive for *Drive2*. If you omit both drive parameters, **diskcomp** uses the current drive for both. If the current drive is the same as *Drive1*, **diskcomp** prompts you to swap disks as necessary.
- Using one drive

  If you specify the same floppy disk drive for *Drive1* and *Drive2*, **diskcomp** compares them by using one drive and prompts you to insert the disks as necessary. You might have to swap the disks more than once, depending on the capacity of the disks and the amount of available memory.
- Comparing different types of disks

  **Diskcomp** cannot compare a single-sided disk with a double-sided disk, nor a high-density disk with a double-density disk. If the disk in *Drive1* is not of the same type as the disk in *Drive2*, **diskcomp** displays the following message:  
  ```
  Drive types or diskette types not compatible
  ```  
- Using **diskcomp** with networks and redirected drives

  **Diskcomp** does not work on a network drive or on a drive created by the **subst** command. If you attempt to use **diskcomp** with a drive of any of these types, **diskcomp** displays the following error message:  
  ```
  Invalid drive specification
  ```  
- Comparing an original disk with a copy

  When you use **diskcomp** with a disk that you made by using **copy**, **diskcomp** might display a message similar to the following:  
  ```
  Compare error on 
  side 0, track 0
  ```  
  This type of error can occur even if the files on the disks are identical. Although **copy** duplicates information, it does not necessarily place it in the same location on the destination disk.
- Understanding **diskcomp** exit codes

  The following table explains each exit code.  

  |Exit code|Description|
  |---------|-----------|
  |0|Disks are the same|
  |1|Differences were found|
  |3|Hard error occurred|
  |4|Initialization error occurred|

  To process exit codes that are returned by **diskcomp**, you can use the ERRORLEVEL environment variable on the **if** command line in a batch program.

## <a name="BKMK_examples"></a>Examples

If your computer has only one floppy disk drive (for example, drive A), and you want to compare two disks, type:
```
diskcomp a: a:
```
**Diskcomp** prompts you to insert each disk, as needed.

The following example illustrates how to process a **diskcomp** exit code in a batch program that uses the ERRORLEVEL environment variable on the **if** command line:
```
rem Checkout.bat compares the disks in drive A and B 
echo off 
diskcomp a: b: 
if errorlevel 4 goto ini_error 
if errorlevel 3 goto hard_error 
if errorlevel 1 goto no_compare
if errorlevel 0 goto compare_ok 
:ini_error 
echo ERROR: Insufficient memory or command invalid 
goto exit 
:hard_error 
echo ERROR: An irrecoverable error occurred 
goto exit 
:break 
echo "You just pressed CTRL+C" to stop the comparison 
goto exit 
:no_compare 
echo Disks are not the same 
goto exit 
:compare_ok 
echo The comparison was successful; the disks are the same 
goto exit 
:exit
```

#### Additional references

[Command-Line Syntax Key](command-line-syntax-key.md)
