---
title: tpmtool
description: "Windows Commands topic for tpmtool - gets information about the Trusted Platform Module."
ms.custom: na
ms.prod: windows-server-threshold
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
author: ashleytqy
ms.author: ashleytqy
manager: ronaldai
ms.date: 05/07/2019
---
# tpmtool

This utility can be used to get information about the [Trusted Platform Module (TPM)](https://docs.microsoft.com/windows/security/information-protection/tpm/trusted-platform-module-overview).

>[!IMPORTANT]
>Some information relates to prereleased product which may be substantially modified before it's commercially released. Microsoft makes no warranties, express or implied, with respect to the information provided here.

For examples of how to use this command, see [Examples](#tpmtool_examples).

## Syntax

```
tpmtool /parameter [<arguments>]
```
## Parameters

|Parameter|Description|
|---------|-----------|
|getdeviceinformation|Displays the basic information of the TPM. The meaning of the information flag values can be found [here](https://docs.microsoft.com/windows/desktop/SecProv/win32-tpm-isreadyinformation#parameters).|
|gatherlogs [output directory path]|Collects TPM logs and places them in the specified directory. If that directory does not exist, it is created. By default, they are placed in the current directory. The possible files generated are: </br>- TpmEvents.evtx</br>- TpmInformation.txt</br>- SRTMBoot.dat</br>- SRTMResume.dat</br>- DRTMBoot.dat</br>- DRTMResume.dat</br>|
|drivertracing [start / stop]|Start / stop collecting TPM driver traces. The trace log, TPMTRACE.etl, will be generated and placed in the current directory.|
|parsetcglogs [-validate (-v)]|Displays the parsed TCG log, also known as the Windows Boot Configuration Log (WBCL). The most up-to-date event descriptions can be found on the [TCG website](https://trustedcomputinggroup.org/resource/pc-client-specific-platform-firmware-profile-specification/), under **Event Descriptions**. If the `-validate` flag set, validates that the Platform Configuration Register (PCR) values on the TPM match values in the log.|
|/?|Displays help at the command prompt.|

## <a name="tpmtool_examples"></a>Examples

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
To parse the TCG log:
```
tpmtool parsetcglogs
```
To parse the TCG log and validate the PCRs:
```
tpmtool parsetcglogs -validate
```

## Decoding Error Codes

TPM-specific error codes are documented [here](https://docs.microsoft.com/windows/desktop/com/com-error-codes-6).
