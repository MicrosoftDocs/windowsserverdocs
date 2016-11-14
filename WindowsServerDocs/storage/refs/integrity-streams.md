---
# required metadata

title: Integrity streams
description:
author: gawatu
ms.author: jgerend
manager: dmoss
ms.date: 11/14/2016
ms.topic: article
ms.prod: windows-server-threshold
ms.technology: storage
ms.assetid: 1f1215cd-404f-42f2-b55f-3888294d8a1f
---

# Integrity streams
>Applies To: Windows Server 2012, Windows Server 2012 R2, Windows Server 2016

Integrity streams is an optional feature in ReFS that validates and maintains file integrity. This feature improves upon the integrity tools within NTFS, as it validates data integrity by using a separate checksum for the data. This separate checksum allows ReFS to detect corruptions with greater precision, and if another copy of the corrupted data exists, ReFS can repair those corruptions while remaining online, providing continuous availability and integrity for your files. 

## How it works 

Once integrity streams are enabled, ReFS will create and maintain a checksum in the metadata for the specified files. This checksum allows ReFS to validate the integrity of the data before accessing it. Before returning any data that has integrity streams enabled, ReFS will first calculate its checksum:

![Compute checksum for file data](media/compute-checksum.gif)

Then, this checksum is compared to the checksum contained in the file metadata:

![Compare computed checksum to metadata checksum](media/compare-checksum.gif)

If the checksums match, then the data is marked as valid and returned to the user:

![Checksums match, mark data valid](media/valid-data.gif)

If the checksums don't match, then the existing data is corrupted. If there isn't another valid copy of the data, ReFS will return an error to the user without returning the corrupted data. If a valid copy exists, ReFS will return the valid data to the user and correct the corrupted copy:

![Checksums don't match, corrupted data corrected by other copy](media/corrupted-data.gif)

## Performance impact

Though integrity streams provides greater data integrity for the system, it also incurs a performance penalty. There are a couple different reasons for this:
- Read operations can trigger a write operation if integrity streams are enabled. If a read operation attempts to access corrupted data, ReFS will correct the data by rewriting the data from a valid copy, which increases the IO workload for the system. 
- If integrity streams are enabled, all write operations become allocate-on-write operations. Though this avoids the read-modify-write bottleneck, data frequently becomes fragmented, which delays random reads. 
- Metadata overhead increases because ReFS must store checksums for the files where integrity streams are enabled.  

Because integrity streams carries a performance penalty, we recommend leaving integrity streams disabled on highly performant systems. 

## Examples

### Get-FileIntegrity
To see if integrity streams is enabled, use the **Get-FileIntegrity** cmdlet. 

```PowerShell
PS C:\> Get-FileIntegrity -FileName 'C:\Docs\TextDocument.txt'
```

You can also use the **Get-Item** cmdlet to get the integrity stream settings for all the files in a specified folder. 

```PowerShell
PS C:\> Get-Item -Path 'C:\Docs\*' | Get-FileIntegrity
```

### Set-FileIntegrity
To enable/disable integrity streams, use the **Set-FileIntegrity** cmdlet. 

```PowerShell
PS C:\> Set-FileIntegrity -FileName 'H:\Docs\TextDocument.txt' -Enable $True
```

You can also use the **Get-Item** cmdlet to set the integrity stream settings for all the files in a specified folder. 

```PowerShell
PS C:\> Get-Item -Path 'H\Docs\*' | Set-FileIntegrity -Enable $True 
```

The **Set-FileIntegrity** cmdlet can also be used on volumes. 

```PowerShell
PS C:\> Set-FileIntegrity H:\ -Enable $True
```



