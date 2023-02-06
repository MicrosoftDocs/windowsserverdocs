---
title: load metadata
description: Reference article for the load metadata command, which loads a metadata .cab file prior to importing a transportable shadow copy or loads the writer metadata in the case of a restore.
ms.topic: reference
ms.assetid: 2c535487-668b-44fc-babb-ff59cf7d190e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# Load metadata

Loads a metadata .cab file prior to importing a transportable shadow copy or loads the writer metadata in the case of a restore. If used without parameters, **load metadata** displays help at the command prompt.

## Syntax

```
load metadata [<drive>:][<path>]<metadata.cab>
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `[<drive>:][<path>]` | Specifies the location of the metadata file. |
| metadata.cab | Specifies the metadata .cab file to load. |

## Remarks

- You can use the **import** command to import a transportable shadow copy based on the metadata specified by **load metadata**.

- You must run this command before the **begin restore** command, to load the selected writers and components for the restore.

## Examples

To load a metadata file called metafile.cab from the default location, type:

```
load metadata metafile.cab
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [import diskshadow command](import.md)

- [begin restore command](begin-restore.md)
