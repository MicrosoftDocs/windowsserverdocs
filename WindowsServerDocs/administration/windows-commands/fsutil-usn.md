---
title: fsutil usn
description: Reference article for the fsutil usn command, which manages the update sequence number (USN) change journal.
manager: dmoss
ms.author: toklima
author: toklima
ms.assetid: faad34aa-4ba1-4129-bc1f-08088399e2fa
ms.topic: reference
ms.date: 10/16/2017
---

# fsutil usn

> Applies to: Windows Server (Semi-Annual Channel), Windows Server 2019, Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8

Manages the update sequence number (USN) change journal. The USN change journal provides a persistent log of all changes made to files on the volume. As files, directories, and other NTFS objects are added, deleted, and modified, NTFS enters records into the USN change journal, one for each volume on the computer. Each record indicates the type of change and the object changed. New records are appended to the end of the stream.

## Syntax

```
fsutil usn [createjournal] m=<maxsize> a=<allocationdelta> <volumepath>
fsutil usn [deletejournal] {/d | /n} <volumepath>
fsutil usn [enablerangetracking] <volumepath> [options]
fsutil usn [enumdata] <fileref> <lowUSN> <highUSN> <volumepath>
fsutil usn [queryjournal] <volumepath>
fsutil usn [readdata] <filename>
fsutil usn [readjournal] [c= <chunk-size> s=<file-size-threshold>] <volumepath>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| createjournal | Creates a USN change journal. |
| m=`<maxsize>` | Specifies the maximum size, in bytes, that NTFS allocates for the change journal. |
| a=`<allocationdelta>` | Specifies the size, in bytes, of memory allocation that is added to the end and removed from the beginning of the change journal. |
| `<volumepath>` | Specifies the drive letter (followed by a colon). |
| deletejournal | Deletes or disables an active USN change journal.<p>**CAUTION:** Deleting the change journal impacts the File Replication Service (FRS) and the Indexing Service, because it requires these services to perform a complete (and time-consuming) scan of the volume. This in turn negatively impacts FRS SYSVOL replication and replication between DFS link alternates while the volume is being rescanned. |
| /d | Disables an active USN change journal, and returns input/output (I/O) control while the change journal is being disabled. |
| /n | Disables an active USN change journal and returns I/O control only after the change journal is disabled. |
| enablerangetracking | Enables USN write range tracking for a volume. |
| c=`<chunk-size>` | Specifies the chunk size to track on a volume. |
| s=`<file-size-threshold>` | Specifies the file size threshold for range tracking. |
| enumdata | Enumerates and lists the change journal entries between two specified boundaries. |
| `<fileref>` | Specifies the ordinal position within the files on the volume at which the enumeration is to begin. |
| `<lowUSN>` | Specifies the lower boundary of the range of USN values used to filter the records that are returned. Only records whose last change journal USN is between or equal to the *lowUSN* and *highUSN* member values are returned. |
| `<highUSN>` | Specifies the upper boundary of the range of USN values used to filter the files that are returned. |
| queryjournal | Queries a volume's USN data to gather information about the current change journal, its records, and its capacity. |
| readdata | Reads the USN data for a file. |
| `<filename>` | Specifies the full path to the file, including the file name and extension For example: *C:\documents\filename.txt*. |
| readjournal | Reads the USN records in the USN journal. |
| minver=`<number>` | Minimum Major Version of USN_RECORD to return. Default = 2. |
| maxver=`<number>` | Maximum Major Version of USN_RECORD to return. Default = 4. |
| startusn=`<USN number>` | USN to start reading the USN journal from. Default = 0. |

#### Remarks

- Programs can consult the USN change journal to determine all the modifications made to a set of files. The USN change journal is much more efficient than checking time stamps or registering for file notifications. The USN change journal is enabled and used by the Indexing Service, File Replication Service (FRS), Remote Installation Services (RIS), and Remote Storage.

- If a change journal already exists on a volume, the **createjournal** parameter updates the change journal's **maxsize** and **allocationdelta** parameters. This enables you to expand the number of records that an active journal maintains without having to disable it.

- The change journal can grow larger than this target value, but the change journal is truncated at the next NTFS checkpoint to less than this value. NTFS examines the change journal and trims it when its size exceeds the value of **maxsize** plus the value of **allocationdelta**. At NTFS checkpoints, the operating system writes records to the NTFS log file that enable NTFS to determine what processing is required to recover from a failure.

- The change journal can grow to more than the sum of the values of **maxsize** and **allocationdelta** before being trimmed.

- Deleting or disabling an active change journal is very time consuming, because the system must access all the records in the master file table (MFT) and set the last USN attribute to 0 (zero). This process can take several minutes, and it can continue after the system restarts, if a restart is necessary. During this process, the change journal is not considered active, nor is it disabled. While the system is disabling the journal, it cannot be accessed, and all journal operations return errors. You should use extreme care when disabling an active journal, because it adversely affects other applications that are using the journal.

### Examples

To create a USN change journal on drive C, type:

```
fsutil usn createjournal m=1000 a=100 c:
```

To delete an active USN change journal on drive C, type:

```
fsutil usn deletejournal /d c:
```

To enable range tracking with a specified chunk-size and file-size-threshold, type:

```
fsutil usn enablerangetracking c=16384 s=67108864 C:
```

To enumerate and list the change journal entries between two specified boundaries on drive C, type:

```
fsutil usn enumdata 1 0 1 c:
```

To query USN data for a volume on drive C, type:

```
fsutil usn queryjournal c:
```

To read the USN data for a file in the \Temp folder on drive C, type:

```
fsutil usn readdata c:\temp\sample.txt
```

To read the USN journal with a specific start USN, type:

```
fsutil usn readjournal startusn=0xF00
```

## Additional References

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [fsutil](fsutil.md)
