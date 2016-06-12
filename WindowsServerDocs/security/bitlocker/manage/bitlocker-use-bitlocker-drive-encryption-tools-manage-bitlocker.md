---
title: BitLocker: Use BitLocker Drive Encryption Tools to manage BitLocker
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: f9481c9b-fe6d-44f7-b5cd-f390c0a5b119
---
# BitLocker: Use BitLocker Drive Encryption Tools to manage BitLocker
BitLocker Drive Encryption Tools include the command line tools manage\-bde and repair\-bde and the BitLocker cmdlets for Windows PowerShell.

Both manage\-bde and the BitLocker cmdlets can be used to perform any task that can be accomplished through the BitLocker control panel and are appropriate to use for automated deployments and other scripting scenarios.

Repair\-bde is a special circumstance tool that is provided for disaster recovery scenarios in which a BitLocker protected drive cannot be unlocked normally or using the recovery console.

1.  [Manage\-bde](bitlocker-use-bitlocker-drive-encryption-tools-manage-bitlocker.md#BKMK_managebde)

2.  [Repair\-bde](bitlocker-use-bitlocker-drive-encryption-tools-manage-bitlocker.md#BKMK_repairbde)

3.  [BitLocker cmdlets for Windows PowerShell](bitlocker-use-bitlocker-drive-encryption-tools-manage-bitlocker.md#BKMK_blcmdlets)

## <a name="BKMK_managebde"></a>Manage\-bde
Manage\-bde is a command\-line tool that can be used for scripting BitLocker operations.  Manage\-bde offers additional options not displayed in the BitLocker control panel.  For a complete list of the manage\-bde options, see the [Manage\-bde](managebde.md) command\-line reference.

Manage\-bde includes less default settings and requires greater customization for configuring BitLocker.  For example, using just the `managebde -on` command on a data volume will fully encrypt the volume without any authenticating protectors.  A volume encrypted in this manner still requires user interaction to turn on BitLocker protection, even though the command successfully completed because an authentication method needs to be added to the volume for it to be fully protected. The following sections provide examples of common usage scenarios for manage\-bde.

### Using manage\-bde with operating system volumes
Listed below are examples of basic valid commands for operating system volumes.  In general, using only the `managebde -on <drive letter>` command will encrypt the operating system volume with a TPM\-only protector and no recovery key.  However, many environments require more secure protectors such as passwords or PIN and expect to be able to recover information with a recovery key.  It is recommended that at least one primary protector and a recovery protector be added to an operating system volume.

A good practice when using manage\-bde is to determine the volume status on the target system.  Use the following command to determine volume status:

```
managebde -status
```

This command returns the volumes on the target, current encryption status and volume type \(operating system or data\) for each volume.

The following example illustrates enabling BitLocker on a computer without a TPM chip.  Before beginning the encryption process you must create the startup key needed for BitLocker and save it to the USB drive.  When BitLocker is enabled for the operating system volume, the BitLocker will need to access the USB flash drive to obtain the encryption key \(in this example, the drive letter E represents the USB drive\). You will be prompted to reboot to complete the encryption process.

```
managebde –protectors -add C: -startupkey E:
managebde -on C:
```

> [!NOTE]
> After the encryption is completed, the USB startup key must be inserted before the operating system can be started.

An alternative to the startup key protector on non\-TPM hardware is to use a password and an **ADaccountorgroup** protector to protect the operating system volume. In this scenario, you would add the protectors first.  This is done with the command:

```
managebde -protectors -add C: -pw -sid <user or group>
```

This command will require you to enter and then confirm the password protector before adding them to the volume.  With the protectors enabled on the volume, you can then turn BitLocker on.

On computers with a TPM it is possible to encrypt the operating system volume without any defined protectors using manage\-bde.  The command to do this is:

```
managebde -on C:
```

This will encrypt the drive using the TPM as the default protector.  If you are not sure if a TPM protector is available, to list the protectors available for a volume, run the following command:

```
managebde -protectors -get <volume>
```

### Using manage\-bde with data volumes
Data volumes use the same syntax for encryption as operating system volumes but they do not require protectors for the operation to complete.  Encrypting data volumes can be done using the base command: `managebde -on <drive letter>` or you can choose to add additional protectors to the volume first.  It is recommended that at least one primary protector and a recovery protector be added to a data volume.

A common protector for a data volume is the password protector.  In the example below, we add a password protector to the volume and turn BitLocker on.

```
managebde -protectors -add -pw C:
managebde -on C:
```

> [!NOTE]
> For more information about the types of protectors available and the volume types they are compatible with, see.

## <a name="BKMK_repairbde"></a>Repair\-bde
You may experience a problem that damages an area of a hard disk on which BitLocker stores critical information. This kind of problem may be caused by a hard disk failure or if Windows exits unexpectedly.

The BitLocker Repair Tool \(Repair\-bde\) can be used to access encrypted data on a severely damaged hard disk if the drive was encrypted by using BitLocker. Repair\-bde can reconstruct critical parts of the drive and salvage recoverable data as long as a valid recovery password or recovery key is used to decrypt the data. If the BitLocker metadata data on the drive has become corrupt, you must be able to supply a backup key package in addition to the recovery password or recovery key. This key package is backed up in Active Directory Domain Services \(AD DS\) if you used the default setting for AD DS backup. With this key package and either the recovery password or recovery key, you can decrypt portions of a BitLocker\-protected drive if the disk is corrupted. Each key package will work only for a drive that has the corresponding drive identifier. You can use the BitLocker Recovery Password Viewer to obtain this key package from AD DS.

> [!TIP]
> If you are not backing up recovery information to AD DS or if you want to save key packages alternatively, you can use the command `managebde -KeyPackage` to generate a key package for a volume.

The Repair\-bde command\-line tool is intended for use when the operating system does not start or when you cannot start the BitLocker Recovery Console. You should use Repair\-bde if the following conditions are true:

1.  You have encrypted the drive by using BitLocker Drive Encryption.

2.  Windows does not start, or you cannot start the BitLocker recovery console.

3.  You do not have a copy of the data that is contained on the encrypted drive.

> [!NOTE]
> Damage to the drive may not be related to BitLocker. Therefore, we recommend that you try other tools to help diagnose and resolve the problem with the drive before you use the BitLocker Repair Tool. The Windows Recovery Environment \(Windows RE\) provides additional options to repair computers.

The following limitations exist for Repair\-bde:

-   The Repair\-bde command\-line tool cannot repair a drive that failed during the encryption or decryption process.

-   The Repair\-bde command\-line tool assumes that if the drive has any encryption, then the drive has been fully encrypted.

For more information about using repair\-bde see [Repair\-bde](../../../management/windows-commands/Repair-bde.md)

## <a name="BKMK_blcmdlets"></a>BitLocker cmdlets for Windows PowerShell
Windows PowerShell cmdlets provide a new way for administrators to use when working with BitLocker.  Using Windows PowerShell's scripting capabilities, administrators can integrate BitLocker options into existing scripts with ease.  The list below displays the available BitLocker cmdlets.

|||
|-|-|
|**Name**|**Parameters**|
|**Add\-BitLockerKeyProtector**|\-ADAccountOrGroup<br /><br />\-ADAccountOrGroupProtector<br /><br />\-Confirm<br /><br />\-MountPoint<br /><br />\-Password<br /><br />\-PasswordProtector<br /><br />\-Pin<br /><br />\-RecoveryKeyPath<br /><br />\-RecoveryKeyProtector<br /><br />\-RecoveryPassword<br /><br />\-RecoveryPasswordProtector<br /><br />\-Service<br /><br />\-StartupKeyPath<br /><br />\-StartupKeyProtector<br /><br />\-TpmAndPinAndStartupKeyProtector<br /><br />\-TpmAndPinProtector<br /><br />\-TpmAndStartupKeyProtector<br /><br />\-TpmProtector<br /><br />\-WhatIf|
|**Backup\-BitLockerKeyProtector**|\-Confirm<br /><br />\-KeyProtectorId<br /><br />\-MountPoint<br /><br />\-WhatIf|
|**Disable\-BitLocker**|\-Confirm<br /><br />\-MountPoint<br /><br />\-WhatIf|
|**Disable\-BitLockerAutoUnlock**|\-Confirm<br /><br />\-MountPoint<br /><br />\-WhatIf|
|**Enable\-BitLocker**|\-AdAccountOrGroup<br /><br />\-AdAccountOrGroupProtector<br /><br />\-Confirm<br /><br />\-EncryptionMethod<br /><br />\-HardwareEncryption<br /><br />\-Password<br /><br />\-PasswordProtector<br /><br />\-Pin<br /><br />\-RecoveryKeyPath<br /><br />\-RecoveryKeyProtector<br /><br />\-RecoveryPassword<br /><br />\-RecoveryPasswordProtector<br /><br />\-Service<br /><br />\-SkipHardwareTest<br /><br />\-StartupKeyPath<br /><br />\-StartupKeyProtector<br /><br />\-TpmAndPinAndStartupKeyProtector<br /><br />\-TpmAndPinProtector<br /><br />\-TpmAndStartupKeyProtector<br /><br />\-TpmProtector<br /><br />\-UsedSpaceOnly<br /><br />\-WhatIf|
|**Enable\-BitLockerAutoUnlock**|\-Confirm<br /><br />\-MountPoint<br /><br />\-WhatIf|
|**Get\-BitLockerVolume**|\-MountPoint|
|**Lock\-BitLocker**|\-Confirm<br /><br />\-ForceDismount<br /><br />\-MountPoint<br /><br />\-WhatIf|
|**Remove\-BitLockerKeyProtector**|\-Confirm<br /><br />\-KeyProtectorId<br /><br />\-MountPoint<br /><br />\-WhatIf|
|**Resume\-BitLocker**|\-Confirm<br /><br />\-MountPoint<br /><br />\-WhatIf|
|**Suspend\-BitLocker**|\-Confirm<br /><br />\-MountPoint<br /><br />\-RebootCount<br /><br />\-WhatIf|
|**Unlock\-BitLocker**|\-AdAccountOrGroup<br /><br />\-Confirm<br /><br />\-MountPoint<br /><br />\-Password<br /><br />\-RecoveryKeyPath<br /><br />\-RecoveryPassword<br /><br />\-RecoveryPassword<br /><br />\-WhatIf|

Similar to manage\-bde, the Windows PowerShell cmdlets allow configuration beyond the options offered in the control panel.  As with manage\-bde, users need to consider the specific needs of the volume they are encrypting prior to running Windows PowerShell cmdlets.

A good initial step is to determine the current state of the volume\(s\) on the computer.  You can do this using the `Get-BitLockerVolume` cmdlet.

The `Get-BitLockerVolume` cmdlet output gives information on the volume type, protectors, protection status and other details.

> [!TIP]
> Occasionally, all protectors may not be shown when using `Get-BitLockerVolume` due to lack of space in the output display.  If you do not see all of the protectors for a volume, you can use the Windows PowerShell pipe command \(|\) to format a full listing of the protectors.
> 
> `Get-BitLockerVolume C: | fl`

If you want to remove the existing protectors prior to provisioning BitLocker on the volume, you could use the `Remove-BitLockerKeyProtector` cmdlet.  Accomplishing this requires the GUID associated with the protector to be removed.

A simple script can pipe the values of each Get\-BitLockerVolume return out to another variable as seen below:

```
$vol = Get-BitLockerVolume
$keyprotectors = $vol.KeyProtector
```

Using this, you can display the information in the $keyprotectors variable to determine the GUID for each protector.

Using this information, you can then remove the key protector for a specific volume using the command:

```
Remove-BitLockerKeyProtector <volume>: -KeyProtectorID "{GUID}"
```

> [!NOTE]
> The BitLocker cmdlet requires the key protector GUID enclosed in quotation marks to execute.  Ensure the entire GUID, with braces, is included in the command.

### Using the BitLocker Windows PowerShell cmdlets with operating system volumes
Using the BitLocker Windows PowerShell cmdlets is similar to working with the manage\-bde tool for encrypting operating system volumes.  Windows PowerShell offers users a lot of flexibility. For example, users can add the desired protector as part command for encrypting the volume.  Below are examples of common user scenarios and steps to accomplish them in BitLocker Windows PowerShell.

The following example shows how to enable BitLocker on an operating system drive using only the TPM protector:

```
Enable-BitLocker C:
```

In the example below, adds one additional protector, the StartupKey protector and chooses to skip the BitLocker hardware test.  In this example, encryption starts immediately without the need for a reboot.

```
Enable-BitLocker C: -StartupKeyProtector -StartupKeyPath <path> -SkipHardwareTest
```

### Using the BitLocker Windows PowerShell cmdlets with data volumes
Data volume encryption using Windows PowerShell is the same as for operating system volumes.  You should add the desired protectors prior to encrypting the volume.  The following example adds a password protector to the E: volume using the variable $pw as the password.  The $pw variable is held as a SecureString value to store the user defined password.

```
$pw = Read-Host -AsSecureString
<user inputs password>
Enable-BitLockerKeyProtector E: -PasswordProtector -Password $pw
```

#### Using an AD Account or Group protector in Windows PowerShell
A new protector in available in Windows 8 and **win8\_server\_2** is the **ADAccountOrGroup** protector, an Active Directory SID\-based protector.  This protector can be added to both operating system and data volumes, although it does not unlock operating system volumes in the pre\-boot environment.  The protector requires the SID for the domain account or group to link with the protector.  BitLocker can protect a cluster\-aware disk by adding a SID\-based protector for the Cluster Name Object \(CNO\) that lets the disk properly failover to and be unlocked by any member computer of the cluster.

> [!WARNING]
> The **ADAccountOrGroup** protector requires the use of an additional protector for use \(such as TPM, PIN, or recovery key\) when used on operating system volumes

To add an **ADAccountOrGroup** protector to a volume requires either the actual domain SID or the group name preceded by the domain and a backslash.  In the example below, the CONTOSO\\Administrator account is added as a protector to the data volume G.

```
Enable-BitLocker G: -AdAccountOrGroupProtector -AdAccountOrGroup CONTOSO\Administrator
```

For users who wish to use the SID for the account or group, the first step is to determine the SID associated with the account. To get the specific SID for a user account in Windows PowerShell, use the following command:

> [!NOTE]
> Use of this command requires the RSAT\-AD\-PowerShell feature.

```
get-aduser -filter {samaccountname -eq "administrator"}
```

> [!TIP]
> In addition to the PowerShell command above, information about the locally logged on user and group membership can be found using: WHOAMI \/ALL.  This does not require the use of additional features.

The following example adds an **ADAccountOrGroup** protector to the previously encrypted operating system volume using the SID of the account:

```
Add-BitLockerKeyProtector C: -ADAccountOrGroupProtector -ADAccountOrGroup S-1-5-21-3651336348-8937238915-291003330-500
```

> [!NOTE]
> Active Directory\-based protectors are normally used to unlock Failover Cluster enabled volumes.

## More information
[BitLocker Overview](BitLocker-Overview.md)

[Encrypted Hard Drive](../../encrypted-hard-drive.md)

[BitLocker Frequently Asked Questions &#40;FAQ&#41;](BitLocker-Frequently-Asked-Questions--FAQ-.md)

[What's New in BitLocker for Windows 8 and Windows Server 2012 \[redirected\]](assetId:///2a2af536-3d99-4d86-a492-2a663dc60b4a)

[Prepare your organization for BitLocker: Planning and Policies](assetId:///94c445de-a32c-44d8-b520-1ec2e507f2f6)

[BitLocker: How to enable network unlock](assetId:///a7929b61-ce42-4aa4-8600-5fc581a8dddf)

[BitLocker: How to deploy on Windows Server 2012](../deploy/bitlocker-how-deploy-windows-server-2012.md)


