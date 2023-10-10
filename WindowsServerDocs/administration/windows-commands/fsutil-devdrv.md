---
title: fsutil devdrv
description: Reference article for the fsutil devdrv command, which groups dev drive related functionality.
manager: nealch
ms.author: chandkv
author: chandkv
ms.assetid: 0397c204-b3f8-4fd8-b71d-b7efb117766d
ms.topic: reference
ms.date: 08/29/2023
---

# fsutil devdrv

>Applies to: Windows 11

Dev drive or a developer volume is a volume that is tuned for performance of developer scenarios. The command also lets an administrator of the device control the file system minifilters that are attached to the volume.

## Devdrv commands supported

| Command | Description |
| ------- | ----------- |
| query               | Query dev drive information. |
| enable              | Enable dev drive support on this system. |
| disable             | Disable dev drive support on this system. |
| trust               | Trust the given dev drive. |
| untrust             | Untrust the given dev drive. |
| setFiltersAllowed   | Set the list of allowed filters for dev drive. |
| clearFiltersAllowed | Clear the list of allowed filters for dev drive. |

### Syntax

```
fsutil devdrv query [<volume path>]

fsutil devdrv enable [/allowAv|/disallowAv]

fsutil devdrv disable

fsutil devdrv trust [/f] <volume path>

fsutil devdrv untrust [/f] <volume path>

fsutil devdrv setFiltersAllowed [[/f] /volume <volume path>] "filter1, filter 2, ..."

fsutil devdrv clearFiltersAllowed [[/f] <volume path>]
```

## fsutil devdrv query

Queries information about dev drives or the given dev drive. The command shows if the given volume is a dev drive and if it's trusted. The command also lists the filters allowed to attach and currently attached to the dev drive.

### fsutil devdrv query examples

The following example shows the output of the command for the query command.

#### Example 1: Query dev drive information

The command queries information about dev drives on this system.

```
fsutil devdrv query
```

#### Example 2: Query dev drive information for a specified volume

The following command queries dev drive related information for `D:`. The command lists the filters currently attached to `D:` if it's a dev drive.

```
fsutil devdrv query D:
```

## fsutil devdrv enable

Enable dev drive support on this system.

### fsutil devdrv enable examples

The following example shows the output of the command for the enable command.

#### Example 1: Enable dev drive support

This command enables the dev drive and let the system decide whether to allow antivirus filter to attach on a dev drive.

```
fsutil devdrv enable
```

#### Example 2: Enable dev drive support and allow antivirus filter to attach

In this command, the dev drive is enabled while allowing antivirus filter to be attached on a dev drive.

```
fsutil devdrv enable /allowAv
```

#### Example 3: Enable dev drive support and disallow antivirus filter to attach

The following command enables dev drive without allowing antivirus filter to be attached on a dev drive.

```
fsutil devdrv enable /disallowAv
```

## fsutil devdrv disable

Disable dev drive support on this system.

> [!NOTE]
> Existing dev drives will function as a regular volume i.e., all filters are allowed to attach.

## fsutil devdrv trust

Trust the specified dev drive. The dev drive filter attach policy is honored only for a trusted dev drive.

### fsutil devdrv trust parameters

| Parameter | Description |
| --------- | ----------- |
| /F        | Force dismount the volume for the change to take effect immediately even if the volume is in use.  Otherwise the volume is dismounted only if it isn't in use. |

### fsutil devdrv trust examples

The following examples show the output of the command for the trust command.

#### Example 1: Trust a dev drive for a specified volume

This command trusts the volume `D:`.  The volume won't be dismounted if it is in use, the change takes effect next time the volume mounts.

```
fsutil devdrv trust D:
```

#### Example 2: Trust a dev drive for a specified volume immediately

In this command, the volume is trusted and is dismounted forcefully for the change to take effect immediately.

```
fsutil devdrv trust /f D:
```

## fsutil devdrv untrust

Untrust the given dev drive. The dev drive filter attach policy isn't honored for an untrusted dev drive.

### fsutil devdrv untrust parameters

| Parameter | Description |
| --------- | ----------- |
| /F        | Force dismount the volume for the change to take effect immediately even if the volume is in use.  Otherwise the volume is dismounted only if it isn't in use. |

### fsutil devdrv untrust examples

The following examples show the output of the command for the untrust command.

#### Example 1: Untrust a dev drive for a specified volume

The following command untrusts the volume `D:`.  The volume won't be dismounted if it is in use and the change would take effect next time the volume mounts.

```
fsutil devdrv untrust D:
```

#### Example 2: Untrust a dev drive for a specified volume immediately

The command untrusts the volume `D:` and dismounts it forcefully for the change to take effect immediately.

```
fsutil devdrv untrust /f D:
```

## fsutil devdrv setFiltersAllowed

Set the list of allowed filters for the specified dev drive or any dev drive on this system.

### fsutil devdrv setFiltersAllowed parameters

| Parameter | Description |
| --------- | ----------- |
| /F        | Force dismount the volume for the change to take effect immediately even if the volume is in use.  Otherwise the volume, if specified, is dismounted only if it isn't in use. <br /> Note: the parameter is available only when `<volume path>` is provided. |
| /Volume   | If specified, the allowed list of filters is set only for this volume. |

### fsutil devdrv setFiltersAllowed examples

The following examples show the output of the command for the setFiltersAllowed command.

#### Example 1: Set the list of allowed filters for any dev drive on the system

The command allows `filter1` and `filter2` to be attached to any dev drive on the system. The change will take effect next time a dev drive is mounted.

```
fsutil devdrv setFiltersAllowed "filter1, filter 2"
```

#### Example 2: Set the list of allowed filters for a specified volume

The command, `filter1` and `filter2` are allowed to attach to dev drive `D:`. The volume won't be dismounted if it is in use and the change would take effect next time the volume mounts.

```
fsutil devdrv setFiltersAllowed /volume D: filter1,filter2
```

#### Example 3: Set the list of allowed filters for a specified volume immediately

The following command allows `filter1` and `filter2` to attach to dev drive `D:`. The command forcefully dismounts the volume for the change to take effect immediately.

```
fsutil devdrv setFiltersAllowed /f /volume D: filter1,filter2
```

## fsutil devdrv clearFiltersAllowed

Clear the list of allowed filters for the specified dev drive or any dev drive on this system.

### fsutil devdrv clearFiltersAllowed parameters

| Parameter | Description |
| --------- | ----------- |
| /F        | Force dismount the volume for the change to take effect immediately even if the volume is in use.  Otherwise the volume, if specified, is dismounted only if it isn't in use. <br /> Note: the parameter is available only when `<volume path>` is provided. |
| /Volume   | If specified, the allowed list of filters is set only for this volume. |

### fsutil devdrv clearFiltersAllowed examples

The following examples show the output of the command for the clearFiltersAllowed command.

#### Example 1: Clear the list of allowed filters for any dev drive on this system

This command clears the list of allowed filters for any dev drive on this system. The change will take effect next time a dev drive is mounted on this system.

```
fsutil devdrv clearFiltersAllowed
```

#### Example 2: Clear the list of allowed filters for a specified volume

The following command clears the list of allowed filters `D:`. The volume won't be dismounted if it is in use, the change takes effect next time the volume mounts.

```
fsutil devdrv clearFiltersAllowed D:
```

> [!NOTE]
> `D:` must be a dev drive.

#### Example 3: Clear the list of allowed filters for a specified volume immediately

The following command clears the list of allowed filters on `D:`. The command forcefully dismounts the volume for the change to take effect immediately.

```
fsutil devdrv clearFiltersAllowed /f D:
```


> [!NOTE]
> `D:` must be a dev drive.

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
- [fsutil](fsutil.md)
- [Dev Drive](/windows/dev-drive/)
