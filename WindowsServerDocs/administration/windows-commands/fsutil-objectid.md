---
ms.assetid: 693ab895-9d0c-47c1-9f52-df5cd287842a
title: Fsutil objectid
ms.prod: windows-server
manager: dmoss
ms.author: toklima
author: toklima
ms.technology: storage
audience: "IT Pro"
ms.topic: article
ms.date: 10/16/2017
---
# Fsutil objectid
>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016, Windows 10, Windows Server 2012 R2, Windows 8.1, Windows Server 2012, Windows 8, Windows Server 2008 R2, Windows 7

Manages object identifiers (OIDs), which are internal objects used by the Distributed Link Tracking (DLT) Client service and File Replication Service (FRS) to track other objects such as files, directories, and links. Object identifiers are invisible to most programs and should never be modified.

> [!CAUTION]
> Do not delete, set, or otherwise modify an object identifier. Deleting or setting an object identifier can result in the loss of data from portions of a file, up to and including entire volumes of data. In addition, you might cause adverse behavior in the Distributed Link Tracking (DLT) Client service and File Replication Service (FRS).

For examples of how to use this command, see [Examples](#BKMK_examples).

## Syntax

```
fsutil objectid [create] <FileName>
fsutil objectid [delete] <FileName>
fsutil objectid [query] <FileName>
fsutil objectid [set] <ObjectID> <BirthVolumeID> <BirthObjectID> <DomainID> <FileName>
```

## Parameters

|Parameter|Description|
|-------------|---------------|
|create|Creates an object identifier if the specified file does not already have one. If the file already has an object identifier, this subcommand is equivalent to the **query** subcommand.|
|delete|Deletes an object identifier.|
|query|Queries an object identifier.|
|set|Sets an object identifier.|
|\<ObjectID>|Sets a file-specific 16 byte hexadecimal identifier that is guaranteed to be unique within a volume. The object identifier is used by the Distributed Link Tracking (DLT) Client service and the File Replication Service (FRS) to identify files.|
|\<BirthVolumeID>|Indicates the volume on which the file was located when it first obtained an object identifier. This value is a 16 byte hexadecimal identifier that is used by the DLT Client service.|
|\<BirthObjectID>|Indicates the file's original object identifier (The *ObjectID* may change when a file is moved). This value is a 16 byte hexadecimal identifier that is used by the DLT Client service.|
|\<DomainID>|16 byte hexadecimal domain identifier. This value is not currently used and must be set to all zeros.|
|\<FileName>|Specifies the full path to the file including the file name and extension, for example C:\documents\filename.txt.|

## Remarks

-   Any file that has an object identifier also has a birth volume identifier, a birth object identifier, and a domain identifier. When you move a file, the object identifier may change, but the birth volume and birth object identifiers remain the same. This behavior enables the Windows operating system to always find a file, no matter where it has been moved.

## <a name="BKMK_examples"></a>Examples
To create an object identifier, type:

`fsutil objectid create c:\temp\sample.txt`

To delete an object identifier, type:

`fsutil objectid delete c:\temp\sample.txt`

To query an object identifier, type:

`fsutil objectid query c:\temp\sample.txt`

To set an object identifier, type:

`fsutil objectid set 40dff02fc9b4d4118f120090273fa9fc f86ad6865fe8d21183910008c709d19e 40dff02fc9b4d4118f120090273fa9fc 00000000000000000000000000000000 c:\temp\sample.txt`

#### Additional references
[Command-Line Syntax Key](Command-Line-Syntax-Key.md)

[Fsutil](Fsutil.md)


