---
title: manage-bde protectors
description: "Windows Commands topic for **** - "
ms.custom: na
ms.prod: windows-server
ms.reviewer: na
ms.suite: na
ms.technology: manage-windows-commands
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 1f9b22c5-cc93-45df-9165-bedee94998da
author: coreyp-at-msft
ms.author: coreyp
manager: dongill
ms.date: 08/06/2018
---
# manage-bde: protectors

>Applies To: Windows Server (Semi-Annual Channel), Windows Server 2016

Manages the protection methods used for the BitLocker encryption key. For examples of how this command can be used, see [Examples](#BKMK_Examples).
## Syntax
```
manage-bde -protectors [{-get|-add|-delete|-disable|-enable|-adbackup|-aadbackup}] <Drive> [-computername <Name>] [{-?|/?}] [{-help|-h}]
```
### Parameters

|   Parameter   |                                                                                                                                                                                           Description                                                                                                                                                                                            |
|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|     -get      |                                                                                                                                            Displays all the key protection methods enabled on the drive and provides their type and identifier (ID).                                                                                                                                             |
|     -add      |                                                                                                                                   adds key protection methods as specified by using additional [add parameters](manage-bde-protectors.md#BKMK_addprotectors).                                                                                                                                    |
|    -delete    | deletes key protection methods used by BitLocker. All key protectors will be removed from a drive unless the optional [-delete parameters](manage-bde-protectors.md#BKMK_deleteprotectors) are used to specify which protectors to delete. When the last protector on a drive is deleted, BitLocker protection of the drive is disabled to ensure that access to data is not lost inadvertently. |
|   -disable    |                      Disables protection, which will allow anyone to access encrypted data by making the encryption key available unsecured on drive. No key protectors are removed. Protection will be resumed the next time Windows is booted unless the optional [-disable parameters](manage-bde-protectors.md#BKMK_disableprot) are used to specify the reboot count.                       |
|    -enable    |                                                                                                                             Enables protection by removing the unsecured encryption key from the drive. All configured key protectors on the drive will be enforced.                                                                                                                             |
|   -adbackup   |                                                                          Backs up all recovery information for the drive specified to Active Directory Domain Services (AD DS). To back up only a single recovery key to AD DS, append the **-id** parameter and specify the ID of a specific recovery key to back up.                                                                           |
|  -aadbackup   |                                                                            Backs up all recovery information for the drive specified to Azure Active Directory (Azure Ad). To back up only a single recovery key to Azure AD, append the **-id** parameter and specify the ID of a specific recovery key to back up.                                                                             |
|    <Drive>    |                                                                                                                                                                          Represents a drive letter followed by a colon.                                                                                                                                                                          |
| -computername |                                                                                                              Specifies that manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command.                                                                                                              |
|    <Name>     |                                                                                                                 Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address.                                                                                                                  |
|   -? or /?    |                                                                                                                                                                            Displays brief help at the command prompt.                                                                                                                                                                            |
|  -help or -h  |                                                                                                                                                                          Displays complete help at the command prompt.                                                                                                                                                                           |

### <a name="BKMK_addprotectors"></a>-add syntax and parameters
```
manage-bde  -protectors  -add [<Drive>] [-forceupgrade] [-recoverypassword <NumericalPassword>] [-recoverykey <pathToExternalKeydirectory>]
[-startupkey <pathToExternalKeydirectory>] [-certificate {-cf <pathToCertificateFile>|-ct <CertificateThumbprint>}] [-tpm] [-tpmandpin] 
[-tpmandstartupkey <pathToExternalKeydirectory>] [-tpmandpinandstartupkey <pathToExternalKeydirectory>] [-password][-adaccountorgroup <securityidentifier> [-computername <Name>] 
[{-?|/?}] [{-help|-h}]
```

|          Parameter           |                                                                                                                                                                                   Description                                                                                                                                                                                   |
|------------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|           <Drive>            |                                                                                                                                                                 Represents a drive letter followed by a colon.                                                                                                                                                                  |
|      -recoverypassword       |                                                                                                                                    adds a numerical password protector. You can also use **-rp** as an abbreviated version of this command.                                                                                                                                     |
|     <NumericalPassword>      |                                                                                                                                                                        Represents the recovery password.                                                                                                                                                                        |
|         -recoverykey         |                                                                                                                                adds an external key protector for recovery. You can also use **-rk** as an abbreviated version of this command.                                                                                                                                 |
| <pathToExternalKeydirectory> |                                                                                                                                                               Represents the directory path to the recovery key.                                                                                                                                                                |
|         -startupkey          |                                                                                                                                 adds an external key protector for startup. You can also use **-sk** as an abbreviated version of this command.                                                                                                                                 |
| <pathToExternalKeydirectory> |                                                                                                                                                                Represents the directory path to the startup key.                                                                                                                                                                |
|         -certificate         |                                                                                                                               adds a public key protector for a data drive. You can also use **-cert** as an abbreviated version of this command.                                                                                                                               |
|             -cf              |                                                                                                                                              Specifies that a certificate file will be used to provide the public key certificate.                                                                                                                                              |
|   <pathToCertificateFile>    |                                                                                                                                                             Represents the directory path to the certificate file.                                                                                                                                                              |
|             -ct              |                                                                                                                                           Specifies that a certificate thumbprint will be used to identify the public key certificate                                                                                                                                           |
|   <CertificateThumbprint>    |                                                       Specifies the value of the thumbprint property of the certificate you want to use. For example, a certificate thumbprint value of "a9 09 50 2d d8 2a e4 14 33 e6 f8 38 86 b0 0d 42 77 a3 2a 7b" should be specified as "a909502dd82ae41433e6f83886b00d4277a32a7b."                                                        |
|          -tpmandpin          |                                                                                           adds a Trusted Platform Module (TPM) and personal identification number (PIN) protector for the operating system drive. You can also use **-tp** as an abbreviated version of this command.                                                                                           |
|      -tpmandstartupkey       |                                                                                                                    adds a TPM and startup key protector for the operating system drive. You can also use **-tsk** as an abbreviated version of this command.                                                                                                                    |
|   -tpmandpinandstartupkey    |                                                                                                                adds a TPM, PIN, and startup key protector for the operating system drive. You can also use **-tpsk** as an abbreviated version of this command.                                                                                                                 |
|          -password           |                                                                                                                              adds a password key protector for the data drive. You can also use **-pw** as an abbreviated version of this command.                                                                                                                              |
|      -adaccountorgroup       | adds a security identifier(SID)-based identity protector for the volume.  You can also use **-sid** as an abbreviated version of this command. **IMPORTANT:** By default, you cannot add an ADAccountOrGroup protector remotely using either WMI or manage-bde.  if your deployment requires the ability to add this protector remotely you must enable constrained delegation. |
|        -computername         |                                                                                                       Specifies that manage-bde is being used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command.                                                                                                       |
|            <Name>            |                                                                                                         Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address.                                                                                                         |

### <a name="BKMK_deleteprotectors"></a>-delete syntax and parameters
```
manage-bde  -protectors  -delete <Drive> [-type {recoverypassword|externalkey|certificate|tpm|tpmandstartupkey|tpmandpin|tpmandpinandstartupkey|Password|Identity}] 
[-id <KeyProtectorID>] [-computername <Name>] [{-?|/?}] [{-help|-h}]
```

|       Parameter        |                                                                              Description                                                                               |
|------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|        <Drive>         |                                                             Represents a drive letter followed by a colon.                                                             |
|         -type          |                               Identifies the key protector to delete. You can also use **-t** as an abbreviated version of this command.                               |
|    recoverypassword    |                                                 Specifies that any recovery password key protectors should be deleted.                                                 |
|      externalkey       |                                        Specifies that any external key protectors associated with the drive should be deleted.                                         |
|      certificate       |                                       Specifies that any certificate key protectors associated with the drive should be deleted.                                       |
|          tpm           |                                        Specifies that any TPM-only key protectors associated with the drive should be deleted.                                         |
|    tpmandstartupkey    |                                Specifies that any TPM and startup key based key protectors associated with the drive should be deleted.                                |
|       tpmandpin        |                                    Specifies that any TPM and PIN based key protectors associated with the drive should be deleted.                                    |
| tpmandpinandstartupkey |                             Specifies that any TPM, PIN, and startup key based key protectors associated with the drive should be deleted.                             |
|        password        |                                        Specifies that any password key protectors associated with the drive should be deleted.                                         |
|        identity        |                                        Specifies that any identity key protectors associated with the drive should be deleted.                                         |
|          -id           |                Identifies the key protector to delete by using the key identifier. This parameter is an alternative option to the **-type** parameter.                 |
|    <KeyProtectorID>    |        Identifies an individual key protector on the drive to delete. Key protector IDs can be displayed by using the **manage-bde -protectors -get** command.         |
|     -computername      | Specifies that manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command. |
|         <Name>         |    Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address.     |
|        -? or /?        |                                                               Displays brief help at the command prompt.                                                               |
|      -help or -h       |                                                             Displays complete help at the command prompt.                                                              |

### <a name="BKMK_disableprot"></a>-disable syntax and parameters
```
manage-bde  -protectors  -disable <Drive> [-RebootCount <integer 0 - 15>] [-computername <Name>] [{-?|/?}] [{-help|-h}]
```

|   Parameter   |                                                                                                                                                                                                                   Description                                                                                                                                                                                                                    |
|---------------|--------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
|    <Drive>    |                                                                                                                                                                                                  Represents a drive letter followed by a colon.                                                                                                                                                                                                  |
|  RebootCount  | Starting with Windows 8, specifies that protection of the operating system volume has been suspended and will resume after Windows has been restarted the number of times specified in the RebootCount parameter. Specify 0 to suspend protection indefinitely. If this parameter is not specified BitLocker protection will automatically resume when Windows is restarted. You can also use **-rc** as an abbreviated version of this command. |
| -computername |                                                                                                                                      Specifies that manage-bde.exe will be used to modify BitLocker protection on a different computer. You can also use **-cn** as an abbreviated version of this command.                                                                                                                                      |
|    <Name>     |                                                                                                                                         Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address.                                                                                                                                          |
|   -? or /?    |                                                                                                                                                                                                    Displays brief help at the command prompt.                                                                                                                                                                                                    |
|  -help or -h  |                                                                                                                                                                                                  Displays complete help at the command prompt.                                                                                                                                                                                                   |

## <a name="BKMK_Examples"></a>Examples
The following example illustrates using the **-protectors** command to add a certificate key protector identified by a certificate file to drive E.
```
manage-bde  -protectors  -add E: -certificate  -cf "c:\File Folder\Filename.cer"
```
The following example illustrates using the **-protectors** command to add an **adaccountorgroup** key protector identified by domain and user name to drive E.
```
manage-bde  -protectors  -add E: -sid DOMAIN\user
```
The following example illustrates using the **protectors** command to disable protection until the computer has rebooted 3 times.
```
manage-bde  -protectors  -disable C: -rc 3
```
The following example illustrates using the **-protectors** command to delete all TPM and startup key based key protectors on drive C.
```
manage-bde  -protectors -delete C: -type tpmandstartupkey
```
The following example illustrates using the **-protectors** command to back up all recovery information for drive C to AD DS.
```
manage-bde  -protectors  -adbackup C:
```
## additional references
-   [Command-Line Syntax Key](command-line-syntax-key.md)
-   [manage-bde](manage-bde.md)
