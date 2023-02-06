---
title: select volume
description: Reference article for the select volume command, which selects the specified volume and shifts the focus to it.
ms.topic: reference
ms.assetid: 5d70d776-80ad-4f20-8288-a7997fb1df28
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# select volume

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016, Windows Server 2012 R2, Windows Server 2012

Selects the specified volume and shifts the focus to it. This command can also be used to display the volume that currently has the focus in the selected disk.

## Syntax

```
select volume={<n>|<d>}
```

### Parameters

| Parameter | Description |
|--|--|
| `<n>` | The number of the volume to receive the focus. You can view the numbers for all volumes on the disk currently selected by using the **list volume** command in DiskPart. |
| `<d> `| The drive letter or mount point path of the volume to receive the focus. |

## Remarks

- If no volume is specified, this command displays the volume that currently has the focus in the selected disk.

- On a basic disk, selecting a volume also gives the focus to the corresponding partition.

  - If a volume is selected with a corresponding partition, the partition will be automatically selected.

  - If a partition is selected with a corresponding volume, the volume will be automatically selected.

## Examples

To shift the focus to *volume 2*, type:

```
select volume=2
```

To shift the focus to *Drive C*, type:

```
select volume=c
```

To shift the focus to the volume mounted on a folder named *c:\mountpath*, type:

```
select volume=c:\mountpath
```

To display the volume that currently has the focus in the selected disk, type:

```
select volume
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [add volume command](add-volume.md)

- [attributes volume command](attributes-volume.md)

- [create volume mirror command](create-volume-mirror.md)

- [create volume raid command](create-volume-raid.md)

- [create volume simple command](create-volume-simple.md)

- [create volume stripe command](create-volume-stripe.md)

- [delete volume command](delete-volume.md)

- [detail volume command](detail-volume.md)

- [fsutil volume command](fsutil-volume.md)

- [list volume command](list-volume.md)

- [offline volume command](offline-volume.md)

- [onine volume command](online-volume.md)

- [select disk command](select-disk.md)

- [select partition command](select-partition.md)

- [select vdisk command](select-vdisk.md)
