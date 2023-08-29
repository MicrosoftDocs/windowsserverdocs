---
title: fsutil volume
description: Reference article for the fsutil devdrv command, which groups lots of dev drive related functionalites.
manager: nealch
ms.author: chandkv
author: chandkv
ms.assetid: 0397c204-b3f8-4fd8-b71d-b7efb117766d
ms.topic: reference
ms.date: 08/29/2023
---

# fsutil devdrv

>Applies to: Windows 11

Dev drive or a developer volume is a volume that is tuned for performance of developer scenarios. This also lets an administrator of the device control the file system minifilters that are attached to the volume.

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


## fsutil devdrv query
Query information about dev drives in general or the given dev drive.
This shows if the given volume is a dev drive and if it is trusted. This also lists filters allowed to attach and filters currently attached.
### Syntax
```
fsutil devdrv query [<volume path>]
```
### Examples
To query information about dev drives, in general, on this system.
```
fsutil devdrv query
```
To query dev drive related information for `D:`. This would list the filters currently attached to `D:` if it is a dev drive.
```
fsutil devdrv query D:
```

## fsutil devdrv enable
Enable dev drive support on this system.
### Syntax
```
fsutil devdrv enable [/allowAv|/disallowAv]
```
### Examples
To enable dev drive and let the system decide whether to allow antivirus filter to attach on a dev drive.
```
fsutil devdrv enable
```
To enabled dev drive while allowing antivirus filter to be attached on a dev drive.
```
fsutil devdrv enable /allowAv
```
To enabled dev drive without allowing antivirus filter to be attached on a dev drive.
```
fsutil devdrv enable /disallowAv
```

## fsutil devdrv disable
Disable dev drive support on this system.
NOTE: Existing dev drives will function as a regular volume i.e., all filters are allowed to attach.
### Syntax
```
fsutil devdrv disable
```

## fsutil devdrv trust
Trust the given dev drive. Dev drive filter attach policy is honored only for a trusted dev drive.
### Syntax
```
fsutil devdrv trust [/f] <volume path>
```
### Parameters
| Parameter | Description |
| --------- | ----------- |
| /F        | Force dismount the volume for the change to take effect immediately even if the volume is in use.  Otherwise the volume is dismounted only if it is not in use. |
### Examples
To trust the volume.  The volume won't be dismounted if it is in use and the change would take effect next time the volume mounts.
```
fsutil devdrv trust D:
```
To trust the volume and dismout it forcefully for the change to take effect immediately.
```
fsutil devdrv trust /f D:
```

## fsutil devdrv untrust
Untrust the given dev drive. Dev drive filter attach policy is not honored for an untrusted dev drive.
### Syntax
```
fsutil devdrv untrust [/f] <volume path>
```
### Parameters
| Parameter | Description |
| --------- | ----------- |
| /F        | Force dismount the volume for the change to take effect immediately even if the volume is in use.  Otherwise the volume is dismounted only if it is not in use. |
### Examples
To untrust the volume.  The volume won't be dismounted if it is in use and the change would take effect next time the volume mounts.
```
fsutil devdrv untrust D:
```
To untrust the volume and dismout it forcefully for the change to take effect immediately.
```
fsutil devdrv untrust /f D:
```

## fsutil devdrv setFiltersAllowed
Set the list of allowed filters for the given dev drive or any dev drive on this system.
### Syntax
```
fsutil devdrv setFiltersAllowed [[/f] /volume <volume path>] "filter1, filter 2, ..."
```
### Parameters
| Parameter | Description |
| --------- | ----------- |
| /F        | Force dismount the volume for the change to take effect immediately even if the volume is in use.  Otherwise the volume, if specified, is dismounted only if it is not in use. <br /> Note: This is available only when `<volume path>` is provided. |
| /Volume   | If specified, the allowed list of filters is set only for this volume. |
### Examples
To allow `filter1` and `filter2` to attach on any dev drive on this system. The change will take effect next time a dev drive mounts on this system.
```
fsutil devdrv setFiltersAllowed "filter1, filter 2"
```
To allow `filter1` and `filter2` to attach to dev drive `D:`. The volume won't be dismounted if it is in use and the change would take effect next time the volume mounts.
```
fsutil devdrv setFiltersAllowed /volume D: filter1,filter2
```
To allow `filter1` and `filter2` to attach to dev drive `D:` and forcefully dismount the volume for the change to take effect immediately.
```
fsutil devdrv setFiltersAllowed /f /volume D: filter1,filter2
```

## fsutil devdrv clearFiltersAllowed
Clear the list of allowed filters for the given dev drive or any dev drive on this system.
### Syntax
```
fsutil devdrv clearFiltersAllowed [[/f] <volume path>]
```
### Parameters
| Parameter | Description |
| --------- | ----------- |
| /F        | Force dismount the volume for the change to take effect immediately even if the volume is in use.  Otherwise the volume, if specified, is dismounted only if it is not in use. <br /> Note: This is available only when `<volume path>` is provided. |
| /Volume   | If specified, the allowed list of filters is set only for this volume. |
### Examples
To clear list of allowed filters on any dev drive on this system. The change will take effect next time a dev drive mounts on this system.
```
fsutil devdrv clearFiltersAllowed
```
To clear list of allowed filters on `D:`. The volume won't be dismounted if it is in use and the change would take effect next time the volume mounts.
NOTE: `D:` must be a dev drive.
```
fsutil devdrv clearFiltersAllowed D:
```
To clear list of allowed filters on `D:` and forcefully dismount the volume for the change to take effect immediately.
NOTE: `D:` must be a dev drive.
```
fsutil devdrv clearFiltersAllowed /f D:
```

## Related links
- [Command-Line Syntax Key](command-line-syntax-key.md)
- [fsutil](fsutil.md)
- [Dev Drive](https://learn.microsoft.com/en-us/windows/dev-drive/)
