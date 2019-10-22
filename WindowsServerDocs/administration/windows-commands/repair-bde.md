---
title: repair-bde
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 534dca1a-05f7-4ea8-ac24-4fe5f14f988a
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 10/16/2017
---

# repair-bde



Accesses encrypted data on a severely damaged hard disk if the drive was encrypted by using BitLocker. Repair-bde can reconstruct critical parts of the drive and salvage recoverable data as long as a valid recovery password or recovery key is used to decrypt the data. If the BitLocker metadata data on the drive has become corrupt, you must be able to supply a backup key package in addition to the recovery password or recovery key. This key package is backed up in Active Directory Domain Services (AD DS) if you used the default setting for AD DS backup. With this key package and either the recovery password or recovery key, you can decrypt portions of a BitLocker-protected drive if the disk is corrupted. Each key package will work only for a drive that has the corresponding drive identifier. You can use the [BitLocker Recovery Password Viewer for Active Directory](https://technet.microsoft.com/library/dd875531(v=ws.10).aspx) to obtain this key package from AD DS.

> [!NOTE]
> The BitLocker Recovery Password Viewer is included as one of the optional management features installable using Server Manage on Windows Server 2012.

The following limitations exist for the Repair-bde command-line tool:
-   Repair-bde cannot repair a drive that failed during the encryption or decryption process.
-   Repair-bde assumes that if the drive has any encryption, then the drive has been fully encrypted.

For examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
repair-bde <InputVolume> <OutputVolumeorImage> [-rk] [–rp] [-pw] [–kp] [–lf] [-f] [{-?|/?}]
```

### Parameters

|Parameter|Description|
|---------|-----------|
|\<InputVolume>|Identifies the drive letter of the BitLocker-encrypted drive that you want to repair. The drive letter must include a colon; for example: **C:**.|
|\<OutputVolumeorImage>|Identifies the drive on which to store the content of the repaired drive. All information on the output drive will be overwritten.|
|-rk|Identifies the location of the recovery key that should be used to unlock the volume. This command may also be specified as **-recoverykey**.|
|-rp|Identifies the numerical recovery password that should be used to unlock the volume. This command may also be specified as **-recoverypassword**.|
|-pw|Identifies the password that should be used to unlock the volume. This command may also be specified as **-password**|
|-kp|Identifies the recovery key package that can be used to unlock the volume. This command may also be specified as **-keypackage**.|
|-lf|Specifies the path to the file that will store Repair-bde error, warning, and information messages. This command may also be specified as **-logfile**.|
|-f|Forces a volume to be dismounted even if it cannot be locked. This command may also be specified as **-force**.|
|-? or /?|Displays Help at the command prompt.|

## Remarks

If the path to a key package is not specified, **repair-bde** will search the drive for a key package. However, if the hard drive has been damaged, **repair-bde** may not be able to find the package and will prompt you to provide the path.

## <a name="BKMK_Examples"></a>Examples

The following example attempts to repair drive C and write the content from drive C to drive D by using the recovery key file (RecoveryKey.bek) stored on drive F and writes the results of this attempt to the log file (log.txt) on drive Z.
```
repair-bde C: D: -rk F:\RecoveryKey.bek –lf Z:\log.txt
```
The following example attempts to repair drive C and write the content on drive C to drive D by using the 48-digit recovery password specified. The recovery password should be typed in eight blocks of six digits with a hyphen separating each block.
```
repair-bde C: D: -rp 111111-222222-333333-444444-555555-666666-777777-888888
```
The following example forces drive C to be dismounted and then attempts to repair drive C and write the content on drive C to drive D by using the recovery key package and recovery key file (RecoveryKey.bek) stored on drive F.
```
repair-bde C: D: -kp F:\RecoveryKeyPackage -rk F:\RecoveryKey.bek -f
```
The following example attempts to repair drive C and write the content from drive C to drive D and you must type a password to unlock drive C: when prompted:
```
repair-bde C: D: -pw
```

#### Additional references

-   [Command-Line Syntax Key](command-line-syntax-key.md)