---
title: repair-bde
description: Reference article for the repair-bde command, which can try to reconstruct critical parts of a severely damaged drive and salvage recoverable data if the drive was encrypted by using BitLocker.
ms.topic: reference
ms.assetid: 534dca1a-05f7-4ea8-ac24-4fe5f14f988a
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# repair-bde

Attempts to reconstruct critical parts of a severely damaged drive and salvage recoverable data if the drive was encrypted by using BitLocker and if it has a valid recovery password or recovery key for decryption.

> [!IMPORTANT]
> If the BitLocker metadata data on the drive is corrupt, you must be able to supply a backup key package in addition to the recovery password or recovery key. If you used the default key back up setting for Active Directory Domain Services, your key package is backed up there. You can use the [BitLocker: Use BitLocker Recovery Password Viewer](/windows/security/information-protection/bitlocker/bitlocker-use-bitlocker-recovery-password-viewer) to obtain the key package from AD DS.
>
> Using the key package and either the recovery password or recovery key, you can decrypt portions of a BitLocker-protected drive, even if the disk is corrupted. Each key package works only for a drive with the corresponding drive identifier.

## Syntax

```
repair-bde <inputvolume> <outputvolumeorimage> [-rk] [–rp] [-pw] [–kp] [–lf] [-f] [{-?|/?}]
```

> [!WARNING]
> The contents of the output volume will be **completely deleted and overwritten** by the decrypted contents from the damaged BitLocker drive. If you want to save any existing data on the selected target drive, move the existing data to other reliable backup media first, before running the `repair-bde` command.

### Parameters

| Parameter | Description |
| --- | --- |
| `<inputvolume>` | Identifies the drive letter of the BitLocker-encrypted drive that you want to repair. The drive letter must include a colon; for example: **C:**. If the path to a key package isn't specified, this command searches the drive for a key package. In the event that the hard drive is damaged, this command might not be able to find the package and will prompt you to provide the path. |
| `<outputvolumeorimage>` | Identifies the drive on which to store the content of the repaired drive. All information on the output drive will be overwritten. |
| -rk | Identifies the location of the recovery key that should be used to unlock the volume. This command can also be specified as **-recoverykey**. |
| -rp | Identifies the numerical recovery password that should be used to unlock the volume. This command can also be specified as **-recoverypassword**. |
| -pw | Identifies the password that should be used to unlock the volume. This command can also be specified as **-password** |
| -kp | Identifies the recovery key package that can be used to unlock the volume. This command can also be specified as **-keypackage**. |
| -lf | Specifies the path to the file that will store Repair-bde error, warning, and information messages. This command may also be specified as **-logfile**. |
| -f | Forces a volume to be dismounted even if it cannot be locked. This command can also be specified as **-force**. |
| -? or /? | Displays Help at the command prompt. |

### Limitations

The following limitations exist for the this command:

- This command can't repair a drive that failed during the encryption or decryption process.

- This command assumes that if the drive has any encryption, then the drive has been fully encrypted.

## Examples

To attempt to repair drive C:, to write the content from drive C: to drive D: using the recovery key file (RecoveryKey.bek) stored on drive F:, and to write the results of this attempt to the log file (log.txt) on drive Z:, type:

```
repair-bde C: D: -rk F:\RecoveryKey.bek –lf Z:\log.txt
```

To attempt to repair drive C: and to write the content from drive C: to drive D: using the 48-digit recovery password specified, type:

```
repair-bde C: D: -rp 111111-222222-333333-444444-555555-666666-777777-888888
```

> [!NOTE]
> The recovery password should be typed in eight blocks of six digits with a hyphen separating each block.

To force drive C: to dismount, attempt to repair drive C:, and then to write the content from drive C: to drive D: using the recovery key package and recovery key file (RecoveryKey.bek) stored on drive F:, type:

```
repair-bde C: D: -kp F:\RecoveryKeyPackage -rk F:\RecoveryKey.bek -f
```

To attempt to repair drive C: and to write the content from drive C: to drive D:, where you must type a password to unlock drive C: (when prompted), type:

```
repair-bde C: D: -pw
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)
