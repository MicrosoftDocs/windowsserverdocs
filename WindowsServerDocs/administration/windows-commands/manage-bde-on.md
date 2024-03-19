---
title: manage-bde on
description: Reference article for the manage-bde on command, which encrypts the drive and turns on BitLocker.
ms.topic: reference
ms.assetid: f6a12814-df74-416c-a04a-62ea8512263e
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 10/16/2017
---

# manage-bde on

Encrypts the drive and turns on BitLocker.

## Syntax

```
manage-bde –on <drive> {[-recoverypassword <numericalpassword>]|[-recoverykey <pathtoexternaldirectory>]|[-startupkey <pathtoexternalkeydirectory>]|[-certificate]|
[-tpmandpin]|[-tpmandpinandstartupkey <pathtoexternalkeydirectory>]|[-tpmandstartupkey <pathtoexternalkeydirectory>]|[-password]|[-ADaccountorgroup <domain\account>]}
[-usedspaceonly][-encryptionmethod {aes128_diffuser|aes256_diffuser|aes128|aes256}] [-skiphardwaretest] [-discoveryvolumetype <filesystemtype>] [-forceencryptiontype <type>] [-removevolumeshadowcopies][-computername <name>]
[{-?|/?}] [{-help|-h}]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| `<drive>` | Represents a drive letter followed by a colon. |
| -recoverypassword | Adds a numerical password protector. You can also use **-rp** as an abbreviated version of this command. |
| `<numericalpassword>` | Represents the recovery password. |
| -recoverykey | Adds an external key protector for recovery. You can also use **-rk** as an abbreviated version of this command. |
| `<pathtoexternaldirectory>` | Represents the directory path to the recovery key. |
| -startupkey | Adds an external key protector for startup. You can also use **-sk** as an abbreviated version of this command. |
| `<pathtoexternalkeydirectory>` | Represents the directory path to the startup key. |
| -certificate | Adds a public key protector for a data drive. You can also use **-cert** as an abbreviated version of this command. |
| -tpmandpin | Adds a Trusted Platform Module (TPM) and personal identification number (PIN) protector for the operating system drive. You can also use **-tp** as an abbreviated version of this command. |
| -tpmandstartupkey | Adds a TPM and startup key protector for the operating system drive. You can also use **-tsk** as an abbreviated version of this command. |
| -tpmandpinandstartupkey | Adds a TPM, PIN, and startup key protector for the operating system drive. You can also use **-tpsk** as an abbreviated version of this command. |
| -password | Adds a password key protector for the data drive. You can also use **-pw** as an abbreviated version of this command. |
| -ADaccountorgroup | Adds a SID-based identity protector for the volume. The volume will automatically unlock if the user or computer has the proper credentials. When specifying a computer account, append a **$** to the computer name and specify **–service** to indicate that the unlock should happen in the content of the BitLocker server instead of the user. You can also use **-sid** as an abbreviated version of this command. |
| -usedspaceonly | Sets the encryption mode to Used Space Only encryption. The sections of the volume containing used space will be encrypted but the free space will not. If this option is not specified, all used space and free space on the volume will be encrypted. You can also use **-used** as an abbreviated version of this command. |
| -encryptionMethod | Configures the encryption algorithm and key size. You can also use **-em** as an abbreviated version of this command. |
| -skiphardwaretest | Begins encryption without a hardware test. You can also use **-s** as an abbreviated version of this command. |
| -discoveryvolumetype | Specifies the file system to use for the discovery data drive. The discovery data drive is a hidden drive added to a FAT-formatted, BitLocker-protected removable data drive that contains the BitLocker To Go Reader. |
| -forceencryptiontype | Forces BitLocker to use either software or hardware encryption. You can specify either **Hardware** or **Software** as the encryption type. If the **hardware** parameter is selected, but the drive doesn't support hardware encryption, manage-bde returns an error. If Group Policy settings forbids the specified encryption type, manage-bde returns an error. You can also use **-fet** as an abbreviated version of this command. |
| -removevolumeshadowcopies | Force deletion of Volume Shadow Copies for the volume. You won't be able to restore this volume using previous system restore points after running this command. You can also use **-rvsc** as an abbreviated version of this command. |
| `<filesystemtype>` | Specifies which file systems can be used with discovery data drives: FAT32, default, or none. |
| -computername | Specifies that manage-bde is being used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command. |
| `<name>` | Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address. |
| -? or /? | Displays brief Help at the command prompt. |
| -help or -h | Displays complete Help at the command prompt. |

### Examples

To turn on BitLocker for drive C, and to add a recovery password to the drive, type:

```
manage-bde –on C: -recoverypassword
```

To turn on BitLocker for drive C, add a recovery password to the drive, and to save a recovery key to drive E, type:

```
manage-bde –on C: -recoverykey E:\ -recoverypassword
```

To turn on BitLocker for drive C, using an external key protector (such as a USB key) to unlock the operating system drive, type:

```
manage-bde -on C: -startupkey E:\
```

> [!IMPORTANT]
> This method is required if you are using BitLocker with computers that don't have a TPM.

To turn on BitLocker for data drive E, and to add a password key protector, type:

```
manage-bde –on E: -pw
```

To turn on BitLocker for operating system drive C, and to use hardware-based encryption, type:

```
manage-bde –on C: -fet hardware
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [manage-bde off command](manage-bde-off.md)

- [manage-bde pause command](manage-bde-pause.md)

- [manage-bde resume command](manage-bde-resume.md)

- [manage-bde command](manage-bde.md)
