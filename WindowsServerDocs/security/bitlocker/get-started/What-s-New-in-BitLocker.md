---
title: What&#39;s New in BitLocker
ms.custom: na
ms.prod: windows-server-2012
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 8ebb68e7-f962-428f-ba53-f0e68ffa8594
---
# What&#39;s New in BitLocker
This topic for the advanced user and IT professional describes the BitLocker Drive Encryption functionality that is new or changed in [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)], Windows Server 2012, [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)], and Windows 8.

**In this topic:**

-   [What’s new in BitLocker in Windows Server 2012 R2 and Windows 8.1](What-s-New-in-BitLocker.md#BKMK_BL2012R2)

-   [What’s new in BitLocker in Windows Server 2012 and Windows 8](What-s-New-in-BitLocker.md#BKMK_BL2012)

## <a name="BKMK_BL2012R2"></a>What’s new in BitLocker in Windows Server 2012 R2 and Windows 8.1
In [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)], BitLocker offers enhanced support in the following areas:

-   [Device encryption](What-s-New-in-BitLocker.md#BKMK_Encryption)

-   [FIPS support for recovery password protector](What-s-New-in-BitLocker.md#BKMK_FIPS)

### <a name="BKMK_Encryption"></a>Device encryption
BitLocker provides support for device encryption on x86 and x64\-based computers with a TPM that supports connected stand\-by. Previously this form of encryption was only available on Windows RT devices.

Device encryption helps protect data on your Windows PC. It helps block malicious users from accessing the system files they rely on to discover your password, or from accessing your drive by physically removing it from your PC and installing it in a different one. You can still sign in to Windows and use your files as you normally would. Device encryption protects the operating system drive and any fixed data drives on the system using AES 128\-bit encryption. Device encryption can be used with either a Microsoft Account or a domain account. To support device encryption, the system must support connected standby and meet the [Windows Hardware Certification Kit](http://msdn.microsoft.com/library/windows/hardware/hh833788.aspx) \(HCK\) requirements for TPM and SecureBoot on ConnectedStandby systems. The prerequisites are listed in the following sections:

-   **System.Fundamentals.Security.DeviceEncryption** \- General device encryption requirements.

-   **System.Fundamentals** – Connected standby systems requirements.

-   **System.Fundamentals.Firmware.CS.UEFISecureBoot.ConnectedStandby**\- Requirements for TPM 2.0 and Secure Boot for connect standby systems.

Unlike a standard BitLocker implementation, device encryption is enabled automatically so that the device is always protected. The following list outlines the way this is accomplished:

-   When a clean install of [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)] is completed the computer is prepared for first use. As part of this preparation, device encryption is initialized on the operating system drive and fixed data drives on the computer with a clear key \(this is the equivalent of standard BitLocker suspended state\).

-   If the device is not domain\-joined a Microsoft Account that has been granted administrative privileges on the device is required. When the administrator uses a Microsoft account to sign in, the clear key is removed, a recovery key is uploaded to online Microsoft account and TPM protector is created. Should a device require the recovery key, the user will be guided to use an alternate device and navigate to a recovery key access URL to retrieve the recovery key using their Microsoft Account credentials.

-   If the user signs in using a domain account, the clear key is not removed until the user joins the device to a domain \(on x86\/x64 platforms\) and the recovery key is successfully backed up to Active Directory Domain Services. The Group Policy setting **Computer Configuration\\Administrative Templates\\Windows Components\\BitLocker Drive Encryption\\Operating System Drives** must be enabled and the option **Do not enable BitLocker until recovery information is stored in AD DS for operating system drives** should be selected. With this configuration the recovery password will be automatically created when the computer joins the domain, then the recovery key will be backed up to AD DS, the TPM protector is created, and the clear key is removed.

For more information about the recovery key and how to access it, see [Recovery keys: Frequently asked questions](http://windows.microsoft.com/windows-8/bitlocker-recovery-keys-faq).

##### To turn device encryption on or off

1.  If you have performed a clean install of [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)], device encryption is turned on by default. If you have upgraded a previous Windows installation to [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)], you can turn device encryption on by using **PC info**.

2.  To open **PC info**, swipe in from the right edge of the screen, tap **Settings**, and then tap **Change PC settings**. \(If you're using a mouse, point to the upper\-right corner of the screen, move the mouse pointer down, click **Settings**, and then click **Change PC settings**.\)

3.  Tap or click **PC & devices**, and then tap or click **PC info**. The **Device Encryption** section appears at the bottom of the **PC info** page.

4.  In the **Device Encryption** section, select **Turn On**.

5.  Device encryption cannot be turned off on devices running Windows RT. For other devices, in the **Device Encryption** settings portion of **PC info**, you can select **Turn Off** if you want to stop using device encryption for any reason.

#### Opting out of automatic device encryption
If you do not want the devices you are deploying to be automatically protected with device encryption, you can configure the unattend file to enforce the following registry setting:

-   Path: HKEY\_LOCAL\_MACHINE\\SYSTEM\\CurrentControlSet\\Control\\BitLocker

-   Value: PreventDeviceEncryption equal to True \(1\)

-   Type: REG\_DWORD

#### Group Policy setting conflicts
Device encryption is subject to BitLocker Group Policy settings; however, its default configuration will conflict with some Group Policy settings. The following list describes the policy settings that should be set to either “not configured” or, if configured, reviewed to ensure that they support device encryption.

-   **Computer Configuration\\Administrative Templates\\Windows Components\\BitLocker Drive Encryption\\Operating System Drives\\Require additional authentication at startup** settings:

    -   Any option that requires a startup authentication method other than the TPM.

        Device encryption defaults only allow for the TPM key protector to be configured when the device is encrypted. On Windows x84 and x86 computers an additional protector can be added after the device is encrypted from the BitLocker Control Panel by using the **Change how drive is unlocked at startup** item.

-   **Computer Configuration\\Administrative Templates\\Windows Components\\BitLocker Drive Encryption\\Operating System Drives\\Choose how BitLocker\-protected operating system drives can be recovered** and **Computer Configuration\\Administrative Templates\\Windows Components\\BitLocker Drive Encryption\\Fixed Data Drives\\Choose how BitLocker\-protected fixed data drives can be recovered** settings:

    -   Device encryption uses recovery passwords only. If you have configured this Group Policy setting with the option **Do not allow 48\-digit recovery password**, device encryption will be prevented because its only recovery method is the recovery password.

    -   Device encryption requires that passwords be backed up to an online storage location. If you have configured this Group Policy setting with the option **Save BitLocker recovery information to Active Directory Domain Services** unchecked, device encryption will be prevented because device encryption requires that the recovery password be backed up to AD DS if the device is domain\-joined.

### <a name="BKMK_FIPS"></a>FIPS support for recovery password protector
In [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)], recovery password protectors use a FIPS\-compliant algorithm, which allows BitLocker to be more manageable in FIPS mode.

> [!NOTE]
> The United States Federal Information Processing Standard \(FIPS\) defines security and interoperability requirements for computer systems that are used by the U.S. federal government. The FIPS 140 standard defines approved cryptographic algorithms. The FIPS 140 standard also sets forth requirements for key generation and for key management.

To set FIPS compliant mode for Windows, see [System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing](System-cryptography--Use-FIPS-compliant-algorithms-for-encryption,-hashing,-and-signing.md).

Changes in functionality include:

-   FIPS\-compliant recovery password protectors can be created when Windows is in FIPS mode, which uses the FIPS certifiable algorithm.

-   Recovery passwords created in FIPS mode on [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)] can be distinguished from recovery passwords created on other systems.

-   Recovery unlock using the FIPS certifiable algorithm based recovery password protector work in all cases that currently work for recovery password.

-   When FIPS\-compliant recovery passwords unlock volumes, the volume is unlocked to allow read\/write access even while in FIPS mode.

-   FIPS\-compliant recovery password protectors can be exported and stored in AD while in FIPS mode.

#### Practical applications
Prior to [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)], when you enabled FIPS compliancy for system cryptography, BitLocker prevented the creation or use of recovery passwords and instead forced the user to use recovery keys. Now, the user can use their BitLocker recovery password to unlock the system running   [!INCLUDE[winblue_server_2](includes/winblue_server_2_md.md)] and [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)]. The following list describes the two applications:

-   A recovery password can be created while in FIPS mode

    To comply with FIPS requirements, you can enable the local policy setting [System cryptography: Use FIPS compliant algorithms for encryption, hashing, and signing](System-cryptography--Use-FIPS-compliant-algorithms-for-encryption,-hashing,-and-signing.md).  To ensure that BitLocker is turned on for client computers in your organization, you can update your Windows deployment images to have this policy setting. You can continue to use AD to back up recovery passwords as well. You can use these management tools to verify that recovery passwords are created and stored for BitLocker client computers in FIPS mode.

-   Recovery password can be used while in FIPS mode.

    When a user in your organization must perform a BitLocker recovery on her computer running [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)], they can retrieve the recovery password through established channels, such as Help Desk or their IT administrator, enter it into the BitLocker interface, and continue their work.

    Unlock with recovery password is fully functional while in FIPS mode.

For more information about how the FIPS\-compliant BitLocker recovery passwords fit into your design, see [Prepare your organization for BitLocker: Planning and Policies](assetId:///94c445de-a32c-44d8-b520-1ec2e507f2f6).

## <a name="BKMK_BL2012"></a>What’s new in BitLocker in Windows Server 2012 and Windows 8
In [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] and [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], BitLocker offers enhanced support for the following scenarios:

-   [BitLocker provisioning](What-s-New-in-BitLocker.md#BKMK_prov)

    BitLocker can be used to deploy drives to an encrypted state during installation prior to calling setup.

-   [Used Disk Space Only encryption](What-s-New-in-BitLocker.md#BKMK_usedspace)

    BitLocker now offers two encryption methods, Used Disk Space Only and Full volume encryption.  Used Disk Space Only allows for a much quicker encryption experience by only encrypting used blocks on the targeted volume.

-   [Standard User PIN and password change](What-s-New-in-BitLocker.md#BKMK_supin)

    Allows a standard user to change the BitLocker PIN or password on operating system volumes and the BitLocker password on data volumes, reducing internal help desk call volume.

-   [Network Unlock](What-s-New-in-BitLocker.md#BKMK_netunlock)

    Enables a BitLocker system on a wired network to automatically unlock the system volume during boot \(on capable [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] networks\), reducing internal help desk call volumes for lost PINs.

-   [Support for Encrypted Hard Drives for Windows](What-s-New-in-BitLocker.md#BKMK_edrive)

    BitLocker support for encrypted hard drives provides users a familiar method for managing drive encryption along with the benefit of using hardware\-based encryption.

### <a name="BKMK_prov"></a>BitLocker provisioning
In Windows Vista and Windows 7, BitLocker is provisioned post installation for system and data volumes through either the manage\-bde command line interface or the Control Panel user interface.  In [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] and [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)], BitLocker can also be easily provisioned before the operating system is installed.

With this improvement administrators can enable BitLocker from the Windows Preinstallation Environment \(WinPE\) prior to operating system deployment.  This is done with a randomly generated clear protector applied to the formatted volume and encrypting the volume prior to running the Windows setup process. If the encryption uses the Used Disk Space Only option described in the next section, this step takes only a few seconds and so incorporates well into regular deployment processes.

To check the BitLocker status of a particular volume, administrators can look at the status of the drive in the BitLocker control panel applet or Windows Explorer.  When a drive is pre\-provisioned for BitLocker, a status of "Waiting For Activation" is displayed with a yellow exclamation icon in the BitLocker Control Panel. This status means that there was only a clear protector used when encrypting the volume. In this case, the volume is not protected and needs to have a secure key added to the volume before the drive is considered fully protected. You can use the control panel, manage\-bde tool or WMI APIs to add an appropriate key protector and the volume status will be updated. The following table shows the appropriate key protectors that can be added to drives that have been pre\-provisioned with BitLocker protection:

|Drive Type|Key protector|
|--------------|-----------------|
|Operating System|TPM<br /><br />TPM\+PIN<br /><br />Startup Key \(for systems without a TPM\)<br /><br />Password \(for systems without a TPM\)|
|Fixed data drive|Automatic unlock<br /><br />Password<br /><br />Smart card|
|Removable data drive|Password<br /><br />Smart card|

### <a name="BKMK_usedspace"></a>Used Disk Space Only encryption
In Windows 7, BitLocker requires that all data and free space on the drive are encrypted. The encryption process can take a very long time on larger volumes.  In [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] and [!INCLUDE[winblue_client_2](includes/winblue_client_2_md.md)], administrators can choose to encrypt the entire volume or the used space only. When you choose the Used Disk Space Only encryption option, only the portion of the drive that has data will be encrypted.  Free disk space will not be encrypted.  Used Disk Space Only encryption allows encryption to complete much faster on empty or partly empty drives than previous implementations of BitLocker.  When provisioning BitLocker during Windows deployments, Used Disk Space Only encryption allows BitLocker to encrypt a drive in a short amount of time before installing the operating system. Full Encryption encrypts both data and free space on the volume, similar to the way BitLocker works in Windows 7 and Windows Vista.

**New Group Policy settings for encryption type**

You can use Group Policy settings to enforce that either Used Disk Space Only or Full Encryption is used when BitLocker is enabled on a drive. Group Policy settings for BitLocker Drive Encryption are located under the **\\Computer Configuration\\Administrative Templates\\Windows Components\\BitLocker Drive Encryption** path of the Local Group Policy Editor

The following new Group Policies are available:

-   **Fixed Data Drives\\Enforce drive encryption type on fixed data drives**

-   **Operating System Drives\\Enforce drive encryption type on operating system drives**

-   **Removable Data Drives\\Enforce drive encryption type on removable data drives**

For each of these policies, once they are enabled you can then specify which type of encryption is required to be used on which drive type. If the policy is not configured the user will be able to choose the encryption method when they turn on BitLocker.

### <a name="BKMK_supin"></a>Standard user PIN and password change
Administrative privileges are required to configure BitLocker for operating system drives. In an organization where computers are managed by IT professionals and users are not normally granted administrative privileges, deploying the TPM \+ PIN protection option to large numbers of computers can be challenging. In [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)], administrative privileges are still required to configure BitLocker, however standard users are allowed to change the BitLocker PIN or password for the operating system volume or the BitLocker password for fixed data volumes by default. This gives users the ability to choose PINs and passwords that correspond to a personal mnemonic instead of requiring the user remember a randomly generated character set and allows IT professionals to use the same initial PIN or password setting for all computer images. This also presents the opportunity for users to choose passwords and PINs that are more susceptible to password guessing, dictionary attacks, and social engineering attacks and gives users the ability unlock any computer that still uses the original PIN or password assignment. Requiring password complexity and PIN complexity by Group Policy is recommended to help ensure that users take appropriate care when setting passwords and PINs.

Standard users are required to enter the current PIN or password for the drive to change the BitLocker PIN or BitLocker password.  If a user enters an incorrect current PIN or password, the default tolerance for retry attempts is set to 5.  Once the retry limit is reached, a standard user will not be able to change the BitLocker PIN or BitLocker password.  The retry counter is set to zero when the computer is restarted or when an administrator resets the BitLocker PIN or BitLocker password.

You can disable the option to allow standard users to change PINs and passwords using the Group Policy setting **Disallow standard users from changing the PIN** located in the **\\Computer Configuration\\Administrative Templates\\Windows Components\\BitLocker Drive Encryption\\Operating System Drives** section of Local Group Policy Editor.

### <a name="BKMK_netunlock"></a>Network Unlock
[!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] has added a new BitLocker protector option for Operating System Volumes called Network Unlock.  Network Unlock will enable easier management for BitLocker enabled desktops and servers in a domain environment by providing automatic unlock of operating system volumes at system reboot when connected to a trusted wired corporate network. This feature requires the client hardware to have a DHCP driver implemented in its UEFI firmware.

Operating system volumes protected by TPM\+PIN protectors require a PIN to be entered when a machine reboots or resumes from hibernation \(for example, when configured for Wake on LAN\). The requirement to enter a PIN can make it difficult for enterprises to install software patches to unattended desktops and servers. Network Unlock provides a method by which computers that are configured to use a TPM\+PIN key protector can start Windows without user intervention. Network Unlock works in a similar fashion to the TPM\+StartupKey. Rather than needing to read the StartupKey from USB media, however, the key for Network Unlock is composed from a key stored in the TPM and an encrypted network key that is sent to the server, decrypted and returned to the client in a secure session. The network key is stored on the system drive along with an AES 256 session key, and encrypted with the 2048\-bit RSA public key of the unlock server's certificate. The network key is decrypted with the help of a provider on a [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] WDS server and returned encrypted with its corresponding session key. In instances where the Network Unlock provider is unavailable, the standard TPM\+PIN unlock screen is presented to unlock the drive. The server side configuration to enable Network Unlock also requires provisioning a 2048 bit RSA public\/private key pair in the form of an X.509 certificate, and for the public key certificate to be distributed to the clients.  This certificate must be managed and deployed through the Group Policy Management Console directly on [!INCLUDE[win8_server_2](includes/win8_server_2_md.md)] Domain Controller. For more information, see [BitLocker: How to enable network unlock](assetId:///a7929b61-ce42-4aa4-8600-5fc581a8dddf).

### <a name="BKMK_edrive"></a>Support for encrypted hard drives for Windows
BitLocker provides Full Volume Encryption \(FVE\) of Windows operating system and data volumes using software\-based encryption. In [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] BitLocker also provide support for a new enhanced storage device type, the encrypted hard drive, that is becoming a more common option in new servers and computers. Encrypted hard drives offer Full Disk Encryption \(FDE\), which means encryption occurs on each block of the physical drive. Encryption operations are more efficient on encrypted hard drives because the encryption process is offloaded to the storage controller on the drive \(also known as hardware\-based encryption\).

[!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] supports encrypted hard drives natively in the operating system through the following mechanisms:

-   Identification: [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] will be able to identify that the drive is an encrypted hard drive device type

-   Activation: [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] disk management will activate, create and map volumes to ranges\/bands as appropriate

-   Configuration: [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] will create and map volumes to ranges\/bands as appropriate

-   API: [!INCLUDE[win8_client_2](includes/win8_client_2_md.md)] provides API support for applications to manage encrypted hard drives independently of BitLocker Drive Encryption

-   BitLocker: BitLocker Control Panel will enable users to manage encrypted hard drives in the same manner as full volume encrypted drives.

For more information about the system requirements and usage, see [Encrypted Hard Drive](Encrypted-Hard-Drive.md).

## See also

-   [BitLocker Overview](BitLocker-Overview.md)

-   [Changes in BitLocker Drive Encryption from Windows Vista to Windows 7](http://technet.microsoft.com/library/dd630628(v=ws.10).aspx)


