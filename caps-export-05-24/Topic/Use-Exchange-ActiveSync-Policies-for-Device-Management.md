---
title: Use Exchange ActiveSync Policies for Device Management
ms.custom: na
ms.prod: windows-server-2012-r2
ms.reviewer: na
ms.suite: na
ms.technology: 
  - techgroup-security
ms.tgt_pltfrm: na
ms.topic: article
ms.assetid: 4bfe2eb4-7f95-4048-b80a-11d9d2fad64d
---
# Use Exchange ActiveSync Policies for Device Management
This topic for the IT professional and mail app developer describes the policies available to use the Exchange ActiveSync \(EAS\) policy engine to comply with security policies, and it describes the details of each applicable policy.  
  
The EAS policy engine was introduced in [!INCLUDE[win8_server_2](../Token/win8_server_2_md.md)], [!INCLUDE[win8_client_2](../Token/win8_client_2_md.md)], and [!INCLUDE[winrt_2](../Token/winrt_2_md.md)] to enable Windows store apps to apply EAS policies on desktops, laptops, and tablets to protect data that is synchronized from the cloud, such as data from an Exchange Server. It supports a core set of Windows security primitives.  
  
For more information about the EAS policy engine and how it works, see [Exchange ActiveSync Policy Engine Overview](assetId:///c12f154f-b96a-47e0-a136-00ab37eef80a). This topic contains:  
  
-   [Addressing policy compliance](#BKMK_Compliance)  
  
-   [Supported EAS policy engine policies details](#BKMK_PolicyDetails)  
  
    -   [AllowSimpleDevicePassword](#BKMK_AllowImpleDevicePassword)  
  
    -   [DisallowConvenienceLogon](#BKMK_DisallowConvenienceLogon)  
  
    -   [MaxInactivityTimeDeviceLock](#BKMK_MaxInactivityTimeDeviceLock)  
  
    -   [MaxDevicePasswordFailedAttempts](#BKMK_MaxDevicePasswordFailedAttempts)  
  
    -   [MinDevicePasswordComplexCharacters](#BKMK_MinDevicePasswordComplexCharacters)  
  
    -   [MinDevicePasswordLength](#BKMK_MinDevicePasswordLength)  
  
    -   [DevicePasswordExpiration](#BKMK_DevicePasswordExpiration)  
  
    -   [DevicePasswordHistory](#BKMK_DevicePasswordHistory)  
  
    -   [RequireDeviceEncryption](#BKMK_RequireDeviceEncryption)  
  
## <a name="BKMK_Compliance"></a>Addressing policy compliance  
Most of the policies listed in the previous section can be applied by the user if the user is an administrator. However, there are certain cases where the user must take action first. These are:  
  
-   When the server requires encryption  
  
    -   The Windows client operating system supports BitLocker Drive Encryption, but it is not enabled. The user must manually enable BitLocker.  
  
    -   The Windows client operating system runs on a Windows RT device that supports device encryption, but it is suspended. The user must restart the device.  
  
    -   The Windows client operating system runs on a Windows RT device that supports device encryption, but it isn’t enabled. The user must sign into Windows with a Microsoft account.  
  
-   When an administrator on a computer does not have a strong password. All administrator accounts must have a strong password.  
  
-   When the user’s account does not have a strong password. Users must set strong passwords.  
  
A device that is shared between an administrator and a standard user, when the user is configuring Exchange Server, requires that user and administrator are compliant with the password policy.  
  
Microsoft accounts have a password length and complexity of ratio of 8 and 2, respectively. This means that connected accounts cannot be enforced with a length\/complexity of greater than 8 and 2. Users who are blocked by an Exchange Server that has an EAS policy complexity ratio greater than what is supported by the connected accounts should create a local account with a higher complexity and ensure that their connected accounts are non\-administrator accounts.  
  
Users with non\-administrator accounts cannot apply policies that require a state change to the computer or that impact other accounts. If a user with a non\-administrator account attempts to apply EAS policies, the application might fail. To mitigate this problem, the user can take the following steps:  
  
1.  Change the account from a standard user to an administrator.  
  
2.  Use an administrator account to accept and apply policies. When the policies are applied, all the administrator and control user accounts can be made compliant without further administrator action. If more stringent policies are needed in the future, the administrator might have to accept the new policies before non\-administrator accounts will become compliant.  
  
3.  An administrator can apply local policies and Group Policies equal to or stricter than the EAS policies. This ensures that all non\-administrator accounts can be compliant because they conform to policy requirements that are equal to or stricter than what the EAS policy engine expects.  
  
## <a name="BKMK_PolicyDetails"></a>Supported EAS policy engine policies details  
A policy that is applied using the EAS policy engine prompts the user for consent before a change is made to the system. Policy changes that require a change in the computer’s state or impact other accounts require administrator consent. Policies that are applied using this mechanism are always more stringent.  
  
> [!NOTE]  
> Windows Store apps \(for example, the Mail app\) use the WinRT APIs that are provided in the EasClientSecurityPolicy class to check and apply security policies. The following list shows the recommended mapping between this policy and the API properties supported by the operating system. For more information, see [EasClientSecurityPolicy class \(Windows\)](http://msdn.microsoft.com/library/windows/apps/hh701406.aspx).  
  
### <a name="BKMK_AllowImpleDevicePassword"></a>AllowSimpleDevicePassword  
Originally, the AllowSimpleDevicePassword policy was used to allow or deny setting PINs and passwords that consisted of repeating or sequential numbers or characters. Windows 8 introduced DisallowConvenienceLogon to control sign\-in methods. Because different types of sign\-in methods exist for the user’s convenience, AllowSimplePassword is no longer directly exposed as a policy setting in the operating system. AllowSimpleDevicePassword is mapped to DisallowConvenienceLogon by the Mail app.  
  
### <a name="BKMK_DisallowConvenienceLogon"></a>DisallowConvenienceLogon  
The DisallowConvenienceLogon policy can be used to disable convenience sign\-in methods like PINs, pictures, and biometrics. It prevents users from using sign\-in methods that are less secure in certain configurations.  
  
PIN and picture sign\-in methods allow users to attempt five incorrect sign\-ins. These incorrect sign\-in attempts also contribute toward the MaxDevicePasswordFailedAttempts policy. When a certain threshold is reached, the computer will restart, and users are possibly locked out of their devices.  
  
In the supported versions of Windows \(designated in the **Applies To** list at the top of this page\),  biometric sign\-in methods, do not count toward the MaxDevicePasswordFailedAttempts policy.  
  
In [!INCLUDE[winblue_server_2](../Token/winblue_server_2_md.md)] and [!INCLUDE[winblue_client_2](../Token/winblue_client_2_md.md)], if the device is encrypted with BitLocker or any other disk encryption software, biometrics is not disabled if the DisallowConvenienceLogon policy is set.  
  
The DisallowConvenienceLogon policy applies to all administrator and control user accounts. It is recommended to allow the use of simple passwords and to set adequate password lengths and other related policies.  
  
The following table describes policy evaluation for account types.  
  
|Account types|Evaluation scope|  
|-----------------|--------------------|  
|Local accounts|The strictest policy of either EAS, local, or domain policy applies.|  
|Domain accounts|The strictest policy of either EAS, local, or domain policy applies.|  
|Connected accounts \(for example, Microsoft account\)|The strictest policy of either EAS, local, or domain policy applies.|  
  
**EAS policy mapping at the WinRT API layer**  
  
-   WinRT API Policy Object: DisallowConvenienceLogon  
  
-   Relationship: Inverse  
  
### <a name="BKMK_MaxInactivityTimeDeviceLock"></a>MaxInactivityTimeDeviceLock  
The MaxInactivityTimeDeviceLock policy ensures that unattended computers and devices are locked after a certain amount of time. However, locking the device alone is not enough protection from a security perspective. Therefore, when this policy is applied, it also forces the system to require a password when the computer is activated.  
  
A user can configure an inactivity time that is shorter than the time applied in the policy. The shorter of the two will become the effective inactivity timer.  
  
MaxInactivityTimeDeviceLock is a device global timer that applies to all administrator and all user accounts. This is unique relative to other policies because they apply only to administrative and controlled user accounts.  
  
The following table describes policy evaluation for account types.  
  
|Account types|Evaluation scope|  
|-----------------|--------------------|  
|Local accounts|The strictest policy of either EAS, local, or domain policy applies.|  
|Domain accounts|The strictest policy of either EAS, local, or domain policy applies.|  
|Connected accounts \(for example, Microsoft account\)|The strictest policy of either EAS, local, or domain policy applies.|  
  
**EAS policy mapping at the WinRT API layer**  
  
-   WinRT API Policy Object: MaxInactivityTimeLock  
  
-   Relationship: One\-to\-One  
  
### <a name="BKMK_MaxDevicePasswordFailedAttempts"></a>MaxDevicePasswordFailedAttempts  
The MaxDevicePasswordFailedAttempts policy ensures that there is a limit to incorrect sign\-in attempts that are made to a local account. When specified, the policy causes the computer or device to restart after the specified threshold is reached. If the system is protected with BitLocker or Device Encryption, it will be put into device lock mode. Restarting a device prevents lightweight attacks such as password guessing. However, it cannot prevent against motivated attacks and data theft if the disk is not encrypted. When coupled with disk encryption, there is a better stance against data theft if a device is lost or stolen.  
  
Failed password attempt counts persist across restarts, and they are maintained on a per user basis to ensure that the computer is put into device lock mode, even if incorrect password attempts are made across restarts.  
  
The following table describes policy evaluation for account types.  
  
|Account types|Evaluation scope|  
|-----------------|--------------------|  
|Local accounts|The strictest policy of either EAS, local, or domain policy applies.|  
|Domain accounts|The strictest policy of either EAS, local, or domain policy applies.|  
|Connected accounts \(for example, Microsoft account\)|The strictest policy of either EAS, local, or domain policy applies.|  
  
**EAS policy mapping at the WinRT API layer**  
  
-   WinRT API Policy Object: MaxPasswordFailedAttempts  
  
-   Relationship: One\-to\-One  
  
### <a name="BKMK_MinDevicePasswordComplexCharacters"></a>MinDevicePasswordComplexCharacters  
The MinDevicePasswordComplexCharacters policy defines the number of minimum character types that should be present in an account password to meet security requirements. The character types are defined as:  
  
-   Lower\-case alphabetical  
  
-   Upper\-case alphabetical  
  
-   Numbers  
  
-   Non\-alphanumeric  
  
If MinDevicePasswordComplexCharacters is greater than 1, DisallowConvenienceLogon is ignored. The password cannot contain the user's account name or parts of the user's full name that exceed two consecutive characters. It also needs to be at least six characters in length.  
  
MinDevicePasswordComplexCharacters applies to all administrator and control user accounts.  
  
The following table describes policy evaluation for account types.  
  
|Account types|Evaluation scope|  
|-----------------|--------------------|  
|Local accounts|The strictest policy of either EAS, local, or domain policy applies.|  
|Domain accounts|Not evaluated|  
|Connected accounts \(for example, Microsoft account\)|EAS Policy set at less than or equal to 2 is always compliant and a value greater than 2 results in non\-compliance.|  
  
**EAS policy mapping at the WinRT API layer**  
  
-   WinRT API Policy Object: MinPasswordComplexCharacters  
  
-   Relationship: One\-to\-One  
  
### <a name="BKMK_MinDevicePasswordLength"></a>MinDevicePasswordLength  
The MinDevicePasswordLength policy defines the minimum length of a password.  
  
MinDevicePasswordLength applies to all administrator and control user accounts.  
  
The following table describes policy evaluation for account types.  
  
|Account types|Evaluation scope|  
|-----------------|--------------------|  
|Local accounts|The strictest policy of either EAS, and local policy applies.|  
|Domain accounts|Not evaluated|  
|Connected accounts \(for example, Microsoft account\)|EAS Policy less than or equal to 8 is always compliant and a value greater than 8 results in non\-compliance.|  
  
**EAS policy mapping at the WinRT API layer**  
  
-   WinRT API Policy Object: MinPasswordLength  
  
-   Relationship: One\-to\-One  
  
### <a name="BKMK_DevicePasswordExpiration"></a>DevicePasswordExpiration  
The DevicePasswordExpiration policy determines the period of time \(in days\) that a password can be used before the system requires the user to change it.  
  
DevicePasswordExpiration applies to all administrator and control user accounts and only governs local accounts.  
  
The following table describes policy evaluation for account types.  
  
|Account types|Evaluation scope|  
|-----------------|--------------------|  
|Local accounts|The strictest policy of either EAS, and local policy applies.|  
|Domain accounts|Not evaluated|  
|Connected accounts \(for example, Microsoft account\)|Not evaluated|  
  
**EAS policy mapping at the WinRT API layer**  
  
-   WinRT API Policy Object: PasswordExpiration  
  
-   Relationship: One\-to\-One  
  
### <a name="BKMK_DevicePasswordHistory"></a>DevicePasswordHistory  
The DevicePasswordHistory policy allows administrators to enhance security by ensuring that old passwords are not reused. It is recommended that anyone setting this policy also sets the **Minimum password age** policy \(by using Group Policy\) to prevent users from rolling over passwords to get back to a favorite password.  
  
DevicePasswordHistory applies to all administrator and control user accounts and only governs local accounts.  
  
The following table describes policy evaluation for accounts types.  
  
|Account types|Evaluation scope|  
|-----------------|--------------------|  
|Local accounts|The strictest policy of either EAS, and local policy applies.|  
|Domain accounts|Not evaluated|  
|Connected accounts \(for example, Microsoft account\)|Not evaluated|  
  
**EAS policy mapping at the WinRT API layer**  
  
-   WinRT API Policy Object: PasswordHistory  
  
-   Relationship: One\-to\-One  
  
### <a name="BKMK_RequireDeviceEncryption"></a>RequireDeviceEncryption  
The RequireDeviceEncryption policy requires that all fixed data partitions that can contain user data must be encrypted. This includes the operating system partition and any other data partitions that are created by the user.  
  
The EAS policy engine in Windows only checks for compliance related to this policy. If a computer or device is found to not be in compliance, a user action is required to encrypt the hard disk drive before the computer or device can be compliant so that data can be synchronized.  
  
On Windows RT devices, encryption starts as soon as an account is connected so the recovery key is automatically bound to the corresponding Microsoft account.  
  
The following table describes policy evaluation for accounts types.  
  
|Account types|Evaluation scope|  
|-----------------|--------------------|  
|Local accounts|All non\-conflicting EAS policies apply.|  
|Domain accounts|All non\-conflicting EAS policies apply.|  
|Connected accounts \(for example, Microsoft account\)|All non\-conflicting EAS policies apply.|  
  
**EAS policy mapping at the WinRT API layer**  
  
-   WinRT API Policy Object: RequireEncryption  
  
-   Relationship: One\-to\-One  
  
## Related resources  
For more information about the EAS policy engine and how it works, see [Exchange ActiveSync Policy Engine Overview](assetId:///c12f154f-b96a-47e0-a136-00ab37eef80a).  
  
