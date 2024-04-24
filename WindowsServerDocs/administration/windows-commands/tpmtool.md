---
title: tpmtool
description: Reference article for the tpmtool command, which gets information about the Trusted Platform Module.
ms.topic: reference
author: ashleytqy
ms.author: wscontent
manager: raigner
ms.date: 05/07/2019
---

# tpmtool

This utility can be used to get information about the [Trusted Platform Module (TPM)](/windows/security/information-protection/tpm/trusted-platform-module-overview).

>[!IMPORTANT]
>Some information may relate to the pre-released product, which may be substantially modified before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information provided here.

## Syntax

```
tpmtool /parameter [<arguments>]
```

### Parameters

| Parameter | Description |
|--|--|
| getdeviceinformation | Displays the basic information of the TPM. See the [Win32_Tpm::IsReadyInformation method parameters](/windows/win32/secprov/win32-tpm-isreadyinformation#parameters) article for details about the information flag values. |
| gatherlogs [output directory path] | Collects TPM logs and places them in the specified directory. If that directory doesn't exist, it's created. By default, the log files are placed in the current directory. The possible files generated are:<ul><li>TpmEvents.evtx</li><li>TpmInformation.txt</li><li>SRTMBoot.dat</li><li>SRTMResume.dat</li><li>DRTMBoot.dat</li><li>DRTMResume.dat</li></ul> |
| drivertracing `[start | stop]` | Starts or stops collecting TPM driver traces. The trace log, *TPMTRACE.etl*, is created and placed in the current directory. |
| /? | Displays help at the command prompt. |

## Examples

To display the basic information of the TPM, type:

```
tpmtool getdeviceinformation
```

To collect TPM logs and place them in the current directory, type:

```
tpmtool gatherlogs
```

To collect TPM logs and place them in `C:\Users\Public`, type:

```
tpmtool gatherlogs C:\Users\Public
```

To collect TPM driver traces, type:

```
tpmtool drivertracing start
# Run scenario
tpmtool drivertracing stop
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [COM Error Codes (TPM, PLA, FVE)](/windows/win32/com/com-error-codes-6)
