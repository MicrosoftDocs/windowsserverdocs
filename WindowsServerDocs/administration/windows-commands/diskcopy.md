---
title: diskcopy
description: Reference article for the diskcopy command, which copies the contents of the floppy disk in the source drive to a formatted or unformatted floppy disk in the destination drive.
ms.topic: reference
ms.assetid: 5fd21efa-52cc-4e70-a7fe-35125a435106
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 05/07/2018
---

# diskcopy

Copies the contents of the floppy disk in the source drive to a formatted or unformatted floppy disk in the destination drive. If used without parameters, **diskcopy** uses the current drive for the source disk and the destination disk.

## Syntax

```
diskcopy [<drive1>: [<drive2>:]] [/v]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<drive1>` | Specifies the drive that contains the source disk. |
| /v | Verifies that the information is copied correctly. This option slows down the copying process. |
| /? | Displays help at the command prompt. |

#### Remarks

- **Diskcopy** works only with removable disks such as floppy disks, which must be the same type. You cannot use **diskcopy** with a hard disk. If you specify a hard disk drive for *drive1* or *drive2*, **diskcopy** displays the following error message:

    ```
    Invalid drive specification
    Specified drive does not exist or is nonremovable
    ```

    The **diskcopy** command prompts you to insert the source and destination disks and waits for you to press any key on the keyboard before continuing.

    After it copies the disk, **diskcopy** displays the following message:

    ```
    Copy another diskette (Y/N)?
    ```

    If you press **Y**, **diskcopy** prompts you to insert source and destination disks for the next copy operation. To stop the **diskcopy** process, press **N**.

    If you're copying to an unformatted floppy disk in *drive2*, **diskcopy** formats the disk with the same number of sides and sectors per track as are on the disk in *drive1*. **Diskcopy** displays the following message while it formats the disk and copies the files:

    ```
    Formatting while copying
    ```

- If the source disk has a volume serial number, **diskcopy** creates a new volume serial number for the destination disk and displays the number when the copy operation is complete.

- If you omit the *drive2* parameter, **diskcopy** uses the current drive as the destination drive. If you omit both drive parameters, **diskcopy** uses the current drive for both. If the current drive is the same as *drive1*, **diskcopy** prompts you to swap disks as necessary.

- Run **diskcopy** from a drive other than the floppy disk drive, for example the C drive. If floppy disk *drive1* and floppy disk *drive2* are the same, **diskcopy** prompts you to switch disks. If the disks contain more information than the available memory can hold, **diskcopy** cannot read all of the information at once. **Diskcopy** reads from the source disk, writes to the destination disk, and prompts you to insert the source disk again. This process continues until you have copied the entire disk.

- Fragmentation is the presence of small areas of unused disk space between existing files on a disk. A fragmented source disk can slow down the process of finding, reading, or writing files.

    Because **diskcopy** makes an exact copy of the source disk on the destination disk, any fragmentation on the source disk is transferred to the destination disk. To avoid transferring fragmentation from one disk to another, use the [copy command](copy.md) or the [xcopy command](xcopy.md) to copy your disk. Because **copy** and **xcopy** copy files sequentially, the new disk is not fragmented.

    > [!NOTE]
    > You cannot use **xcopy** to copy a startup disk.

- **diskcopy** exit codes:

    | Exit code | Description |
    | --------- | ----------- |
    | 0 | Copy operation was successful |
    | 1 | Nonfatal Read/Write error occurred |
    | 3 | Fatal hard error occurred |
    | 4 | Initialization error occurred |

    To process the exit codes that are returned by **diskcomp**, you can use the *ERRORLEVEL* environment variable on the **if** command line in a batch program.

## Examples

To copy the disk in drive B to the disk in drive A, type:

```
diskcopy b: a:
```

To use floppy disk drive A to copy one floppy disk to another, first switch to the C drive and then type:

```
diskcopy a: a:
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [xcopy command](xcopy.md)

- [copy command](copy.md)
