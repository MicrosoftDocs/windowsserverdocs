---
title: manage-bde protectors
description: Reference article for the manage-bde protectors command, which manages the protection methods used for the BitLocker encryption key.
ms.topic: reference
ms.assetid: 1f9b22c5-cc93-45df-9165-bedee94998da
ms.author: jgerend
author: JasonGerend
manager: mtillman
ms.date: 08/06/2018
---

# manage-bde protectors

>Applies to: Windows Server 2022, Windows Server 2019, Windows Server 2016

Manages the protection methods used for the BitLocker encryption key.

## Syntax

```
manage-bde -protectors [{-get|-add|-delete|-disable|-enable|-adbackup|-aadbackup}] <drive> [-computername <name>] [{-?|/?}] [{-help|-h}]
```

### Parameters

| Parameter | Description |
| --------- | ----------- |
| -get | Displays all the key protection methods enabled on the drive and provides their type and identifier (ID). |
| -add | Adds key protection methods as specified by using additional **-add** parameters. |
| -delete | Deletes key protection methods used by BitLocker. All key protectors will be removed from a drive unless the optional **-delete** parameters are used to specify which protectors to delete. When the last protector on a drive is deleted, BitLocker protection of the drive is disabled to ensure that access to data is not lost inadvertently. |
| -disable | Disables protection, which will allow anyone to access encrypted data by making the encryption key available unsecured on drive. No key protectors are removed. Protection will be resumed the next time Windows is booted unless the optional **-disable** parameters are used to specify the reboot count. |
| -enable | Enables protection by removing the unsecured encryption key from the drive. All configured key protectors on the drive will be enforced. |
| -adbackup | Backs up recovery information for the drive specified to Active Directory Domain Services (AD DS). Append the **-id** parameter and specify the ID of a specific recovery key to back up. The **-id** parameter is required. |
| -aadbackup | Backs up all recovery information for the drive specified to Microsoft Entra ID. Append the **-id** parameter and specify the ID of a specific recovery key to back up. The **-id** parameter is required. |
| `<drive>` | Represents a drive letter followed by a colon. |
| -computername | Specifies that manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command. |
| `<name>` | Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address. |
| -? or /? | Displays brief help at the command prompt. |
| -help or -h | Displays complete help at the command prompt. |

#### Additional -add parameters

The -add parameter can also use these valid additional parameters.

```
manage-bde -protectors -add [<drive>] [-forceupgrade] [-recoverypassword <numericalpassword>] [-recoverykey <pathtoexternalkeydirectory>]
[-startupkey <pathtoexternalkeydirectory>] [-certificate {-cf <pathtocertificatefile>|-ct <certificatethumbprint>}] [-tpm] [-tpmandpin]
[-tpmandstartupkey <pathtoexternalkeydirectory>] [-tpmandpinandstartupkey <pathtoexternalkeydirectory>] [-password][-adaccountorgroup <securityidentifier> [-computername <name>]
[{-?|/?}] [{-help|-h}]
```

| Parameter | Description |
| --------- | ----------- |
| `<drive>` | Represents a drive letter followed by a colon. |
| -recoverypassword | Adds a numerical password protector. You can also use **-rp** as an abbreviated version of this command. |
| `<numericalpassword>` | Represents the recovery password. |
| -recoverykey | Adds an external key protector for recovery. You can also use **-rk** as an abbreviated version of this command. |
| `<pathtoexternalkeydirectory>` | Represents the directory path to the recovery key. |
| -startupkey | Adds an external key protector for startup. You can also use **-sk** as an abbreviated version of this command. |
| `<pathtoexternalkeydirectory>` | Represents the directory path to the startup key. |
| -certificate | Adds a public key protector for a data drive. You can also use **-cert** as an abbreviated version of this command. |
| -cf | Specifies that a certificate file will be used to provide the public key certificate. |
| `<pathtocertificatefile>` | Represents the directory path to the certificate file. |
| -ct | Specifies that a certificate thumbprint will be used to identify the public key certificate |
| `<certificatethumbprint>` | Specifies the value of the thumbprint property of the certificate you want to use. For example, a certificate thumbprint value of a9 09 50 2d d8 2a e4 14 33 e6 f8 38 86 b0 0d 42 77 a3 2a 7b should be specified as a909502dd82ae41433e6f83886b00d4277a32a7b. |
| -tpmandpin | Adds a Trusted Platform Module (TPM) and personal identification number (PIN) protector for the operating system drive. You can also use **-tp** as an abbreviated version of this command. |
| -tpmandstartupkey | Adds a TPM and startup key protector for the operating system drive. You can also use **-tsk** as an abbreviated version of this command. |
| -tpmandpinandstartupkey | Adds a TPM, PIN, and startup key protector for the operating system drive. You can also use **-tpsk** as an abbreviated version of this command. |
| -password | Adds a password key protector for the data drive. You can also use **-pw** as an abbreviated version of this command. |
| -adaccountorgroup | Adds a security identifier(SID)-based identity protector for the volume. You can also use **-sid** as an abbreviated version of this command. **IMPORTANT:** By default, you can't add an ADaccountorgroup protector remotely using either WMI or manage-bde. If your deployment requires the ability to add this protector remotely, you must enable constrained delegation. |
| -computername | Specifies that manage-bde is being used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command. |
| `<name>` | Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address. |
| -? or /? | Displays brief help at the command prompt. |
| -help or -h | Displays complete help at the command prompt. |

#### Additional -delete parameters

```
manage-bde -protectors -delete <drive> [-type {recoverypassword|externalkey|certificate|tpm|tpmandstartupkey|tpmandpin|tpmandpinandstartupkey|Password|Identity}]
[-id <keyprotectorID>] [-computername <name>] [{-?|/?}] [{-help|-h}]
```

| Parameter | Description |
| --------- | ----------- |
| `<drive>` | Represents a drive letter followed by a colon. |
| -type | Identifies the key protector to delete. You can also use **-t** as an abbreviated version of this command. |
| recoverypassword | Specifies that any recovery password key protectors should be deleted. |
| externalkey | Specifies that any external key protectors associated with the drive should be deleted. |
| certificate | Specifies that any certificate key protectors associated with the drive should be deleted. |
| tpm | Specifies that any TPM-only key protectors associated with the drive should be deleted. |
| tpmandstartupkey | Specifies that any TPM and startup key based key protectors associated with the drive should be deleted. |
| tpmandpin | Specifies that any TPM and PIN based key protectors associated with the drive should be deleted. |
| tpmandpinandstartupkey | Specifies that any TPM, PIN, and startup key based key protectors associated with the drive should be deleted. |
| password | Specifies that any password key protectors associated with the drive should be deleted. |
| identity | Specifies that any identity key protectors associated with the drive should be deleted. |
| -ID | Identifies the key protector to delete by using the key identifier. This parameter is an alternative option to the **-type** parameter. |
| `<keyprotectorID>` | Identifies an individual key protector on the drive to delete. Key protector IDs can be displayed by using the **manage-bde -protectors -get** command. |
| -computername | Specifies that manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command. |
| `<name>` | Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address. |
| -? or /? | Displays brief help at the command prompt. |
| -help or -h | Displays complete help at the command prompt. |

#### Additional -disable parameters

```
manage-bde -protectors -disable <drive> [-rebootcount <integer 0 - 15>] [-computername <name>] [{-?|/?}] [{-help|-h}]
```

| Parameter | Description |
| --------- | ----------- |
| `<drive>` | Represents a drive letter followed by a colon. |
| rebootcount | Specifies that protection of the operating system volume has been suspended and will resume after Windows has been restarted the number of times specified in the **rebootcount** parameter. Specify **0** to suspend protection indefinitely. If this parameter isn't specified, BitLocker protection automatically resumes after Windows is restarted. You can also use **-rc** as an abbreviated version of this command. |
| -computername | Specifies that manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command. |
| `<name>` | Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address. |
| -? or /? | Displays brief help at the command prompt. |
| -help or -h | Displays complete help at the command prompt. |

### Examples

To add a certificate key protector, identified by a certificate file, to drive E, type:

```
manage-bde -protectors -add E: -certificate -cf c:\File Folder\Filename.cer
```

To add an **adaccountorgroup** key protector, identified by domain and user name, to drive E, type:

```
manage-bde -protectors -add E: -sid DOMAIN\user
```

To disable protection until the computer has rebooted 3 times, type:

```
manage-bde -protectors -disable C: -rc 3
```

To delete all TPM and startup keys-based key protectors on drive C, type:

```
manage-bde -protectors -delete C: -type tpmandstartupkey
```

To list all key protectors for drive C, type:

```
manage-bde -protectors -get C:
```

To back up all recovery information for drive C to AD DS, type (where `-id` is the ID of the specific key protector to back up):

```
manage-bde -protectors -adbackup C: -id '{00000000-0000-0000-0000-000000000000}'
```

## Related links

- [Command-Line Syntax Key](command-line-syntax-key.md)

- [manage-bde command](manage-bde.md)
