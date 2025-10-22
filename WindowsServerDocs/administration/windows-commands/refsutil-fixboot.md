---
title: refsutil fixboot
description: Reference article for the refsutil fixboot tool, which repairs or updates the boot sector of a ReFS (Resilient File System) volume in Windows.
author: dknappettmsft
ms.author: daknappe
ms.date: 04/02/2025
ms.topic: reference
---

# refsutil fixboot

The `refsutil fixboot` command repairs or updates the boot sector of a specified ReFS (Resilient File System) volume. It ensures the boot sector is correctly configured based on the provided drive, version, and cluster size.

> [!WARNING]
> This operation modifies the boot sector(s) of a volume and may lead to complete data loss. Proceed with caution.

## Syntax

```
refsutil fixboot <drive> <MajorVersion> <MinorVersion> <ClusterSize> [-f] [-w <Dir>] [-smr <SMRBandSizeInMB>] [-x]
```

## Parameters

| Parameter | Description |
|--|--|
| `<drive>` | Specifies the drive letter of the volume to be fixed in the format `E:`. |
| `<MajorVersion>` | Specifies the major version of the ReFS volume. |
| `<MinorVersion>` | Specifies the minor version of the ReFS volume. |
| `<ClusterSize>` | Specifies the cluster size of the volume, either 4096 or 65536 bytes. |
| `-f` | Forces the operation to ignore any valid boot sector found and fix the boot sector based on the provided parameters. |
| `-w <Dir>` | Writes the changes to one or more boot sectors if needed and backs up one or more current boot sectors into the specified backup directory `<DIR>`. |
| `-smr <SMRBandSizeInMB>` | Specifies that the volume is in SMR (Shingled Magnetic Recording) format. The cluster size must be 65536 bytes. `SMRBandSizeinMB` can be either 128 MB or 256 MB. |
| `-x`| Forces the volume to dismount if necessary and invalidates all open handles to the volume. |

## Examples

To fix the boot sector of a ReFS volume on drive D: with a major version of 3, minor version of 3, and a cluster size of `4096` bytes, run this command:

```
refsutil fixboot D: 3 3 4096
```

To fix the boot sector of the ReFS volume on drive D: with a major version of 2, minor version of 1, and a cluster size of `65536` bytes, run the following command. This command forces the operation to ignore any valid boot sector found and writes the necessary changes to the boot sector, then backing up the boot sector into the directory `C:\Backup`:

```
refsutil fixboot D: 2 1 65536 -f -w C:\Backup
```

To fix the boot sector of the ReFS volume on drive D: with a major version of 2, minor version of 0, and a cluster size of `65536` bytes, run the following command. The command specifies that the volume is in SMR format with a band size of 128 MB:

```
refsutil fixboot D: 2 0 65536 -smr 128
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
