---
title: manage-bde: unlock
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 7852bf7d-9102-40be-adcb-71e8f4dfde72
---
# manage-bde: unlock
Unlocks a BitLocker\-protected drive by using a recovery password or a recovery key. for examples of how this command can be used, see [Examples](#BKMK_Examples).

## Syntax

```
manage-bde -unlock {-recoverypassword <Password>|-recoverykey <pathToExternalKeyFile>} <Drive> [-certificate {-cf pathToCertificateFile | -ct CertificateThumbprint} {-pin}] [-password] [-computername <Name>] [{-?|/?}] [{-help|-h}]
```

### Parameters

|Parameter|Value|Description|
|-------------|---------|---------------|
|\-recoverypassword||Specifies that a recovery password will be used to unlock the drive.Abbreviation: \-rp|
||<Password>|Represents the recovery password that can be used to unlock the drive.|
|\-recoverykey||Specifies that an external recovery key file will be used to unlock the drive. Abbreviation: \-rk|
||<pathToExternalKeyFile>|Represents the external recovery key file that can be used to unlock the drive.|
||<Drive>|Represents a drive letter followed by a colon.|
|\-certificate||The local user certificate for a BitLocker certificate to unclock the volume is located in the locat user certificate store. Abbreviation: \-cert|
||<\-cf pathToCertificateFile>|path to the cerficate file|
||<\-ct CertificateThumbprint>|Certificate thumbprint which may optionally include the PIN \(\-pin\).|
|\-password||Presents a prompt for the password to unlock the volume. Abbreviation: \-pw|
|\-computername||Specifies that manage\-bde.exe will be used to modify BitLocker protection on a different computer. Abbreviation: \-cn|
||<Name>|Represents the name of the computer on which to modify BitLocker protection. Accepted values include the computer's NetBIOS name and the computer's IP address.|
|\-? or \/?||Displays brief help at the command prompt.|
|\-help or \-h||Displays complete help at the command prompt.|

## <a name="BKMK_Examples"></a>Examples
The following example illustrates using the **\-unlock** command to unlock drive E with a recovery key file that has been saved to a backup folder on another drive.

```
manage-bde –unlock E: -recoverykey "F:\Backupkeys\recoverykey.bek"
```

## additional references

-   [Command-Line Syntax Key](../commandline-syntax-key.md)

-   [manage-bde]()


