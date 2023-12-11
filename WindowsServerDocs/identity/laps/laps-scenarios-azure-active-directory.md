---
title: Get started with Windows LAPS and Microsoft Entra ID
description: Learn how to get started with Windows Local Administrator Password Solution (Windows LAPS) and Microsoft Entra ID.
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2022
ms.topic: conceptual
---

# Get started with Windows LAPS and Microsoft Entra ID

Learn how to get started with Windows Local Administrator Password Solution (Windows LAPS) and Microsoft Entra ID. The article describes the basic procedures for using Windows LAPS to back up passwords to Microsoft Entra ID and how to retrieve them.

> [!IMPORTANT]
> For more information on specific OS updates required to use the Windows LAPS feature, and the current status of the Microsoft Entra LAPS scenario, see [Windows LAPS availability and Microsoft Entra LAPS public preview status](laps-overview.md#windows-laps-supported-platforms-and-azure-ad-laps-preview-status).

## Supported Azure clouds

See [Windows Local Administrator Password Solution in Microsoft Entra ID (preview)](https://aka.ms/cloudlaps) and [Microsoft Intune support for Windows LAPS](/mem/intune/protect/windows-laps-overview) for information on which specific clouds are supported.

<a name='enable-laps-in-the-azure-ad-device-settings'></a>

## Enable LAPS in the Microsoft Entra device settings

> [!IMPORTANT]
> By default Microsoft Entra ID doesn't allow managed devices to post new Windows LAPS passwords to Microsoft Entra ID. You MUST first have your IT admin enable the feature at the Microsoft Entra tenant level. For more information, see [Enabling Windows LAPS with Microsoft Entra ID](/azure/active-directory/devices/howto-manage-local-admin-passwords#enabling-windows-laps-with-azure-ad).

## Configure device policy

To configure device policy, complete these tasks:

- Choose a policy deployment mechanism
- Understand policies that apply to Microsoft Entra mode
- Configure specific policies

### Choose a policy deployment mechanism

The first step is to choose how to apply policy to your devices.

The preferred option for Microsoft Entra joined devices is to use [Microsoft Intune](/mem/intune) with the [Windows LAPS configuration service provider (CSP)](/windows/client-management/mdm/laps-csp).

If your devices are Microsoft Entra joined but you're not using Microsoft Intune, you can still deploy Windows LAPS for Microsoft Entra ID. In this scenario, you must deploy policy manually (for example, either by using direct registry modification or by using Local Computer Group Policy). For more information, see [Configure Windows LAPS policy settings](laps-management-policy-settings.md).

> [!NOTE]
> If your devices are hybrid-joined to on-premises Windows Server Active Directory, you can deploy policy by using [Windows LAPS Group Policy](laps-management-policy-settings.md#windows-laps-group-policy).

<a name='policies-that-apply-to-azure-active-directory-mode'></a>

### Policies that apply to Microsoft Entra mode

The Windows LAPS CSP and Windows LAPS Group Policy object both manage the same settings, but only a subset of these settings applies to Windows LAPS in Azure mode.

The following settings are applicable when backing passwords up to Microsoft Entra ID:

- BackupDirectory
- PasswordAgeDays
- PasswordComplexity
- PasswordLength
- AdministratorAccountName
- PostAuthenticationResetDelay
- PostAuthenticationActions

More plainly: the Windows Server Active Directory-specific policy settings don't make sense, and aren't supported, when backing the password up to Microsoft Entra ID.

### Configure specific policies

At a minimum, you must configure the BackupDirectory setting to the value 1 (backup passwords to Microsoft Entra ID).

If you don't configure the AdministratorAccountName setting, Windows LAPS defaults to managing the default built-in local administrator account. This built-in account is automatically identified using its well-known relative identifier (RID) and should never be identified with its name. The name of the built-in local administrator account varies depending on the default locale of the device.

If you want to configure a custom local administrator account, you should configure the AdministratorAccountName setting with the name of that account.

> [!IMPORTANT]
> If you configure Windows LAPS to manage a custom local administrator account, you must ensure that the account is created. Windows LAPS doesn't create the account. We recommend that you use the [Accounts CSP](/windows/client-management/mdm/accounts-csp) to create the account.

You can configure other settings, like PasswordLength, as needed for your organization.

<a name='update-a-password-in-azure-active-directory'></a>

## Update a password in Microsoft Entra ID

Windows LAPS processes the currently active policy on a periodic basis (every hour). To avoid waiting after you apply the policy, you can run the `Invoke-LapsPolicyProcessing` PowerShell cmdlet.

To verify that the password was successfully updated in Microsoft Entra ID, look in the event log for the 10029 event:

:::image type="content" source="./media/laps-scenarios-azure-active-directory/laps-scenarios-azure-active-directory-password-update-event.png" alt-text="Screenshot of the event log and a successful Microsoft Entra password update event log message.":::

<a name='retrieve-a-password-from-azure-active-directory'></a>

## Retrieve a password from Microsoft Entra ID

Retrieving Windows LAPS passwords stored in Microsoft Entra ID is supported by using Microsoft Graph. Windows LAPS includes a PowerShell cmdlet (`Get-LapsAADPassword`) that's a wrapper around the Microsoft Graph PowerShell library. You may also  use the Microsoft Entra ID and\or Intune management portals for a UI-based password retrieval experience. Windows LAPS doesn't provide any user interface options within Windows for Microsoft Entra password retrieval.

The rest of these instructions describe how to use the `Get-LapsAADPassword` cmdlet to retrieve Windows LAPS passwords from Microsoft Entra ID using Microsoft Graph.

### Install the Microsoft Graph PowerShell library

The first step is to install the Microsoft Graph PowerShell library:

`Install-Module Microsoft.Graph -Scope AllUsers`

You might need to configure the repository as Trusted for the command to succeed:

`Set-PSRepository PSGallery -InstallationPolicy Trusted`

<a name='create-an-azure-active-directory-registered-app-to-retrieve-windows-laps-passwords'></a>

### Create a Microsoft Entra registered app to retrieve Windows LAPS passwords

The next step is to create a Microsoft Entra application that's configured with the necessary permissions. To review the basic instructions for creating a Microsoft Entra application, see [Quickstart: Register an application with the Microsoft identity platform](/azure/active-directory/develop/quickstart-register-app)

The app needs to be configured with two permissions: `Device.Read.All` and either `DeviceLocalCredential.ReadBasic.All` or `DeviceLocalCredential.Read.All`. `DeviceManagementManagedDevices.Read.All` may also be required in order to query passwords for Microsoft Managed Desktop devices.

> [!IMPORTANT]
>
> - Use `DeviceLocalCredential.ReadBasic.All` to grant permissions for reading non-sensitive metadata about persisted Windows LAPS passwords. Examples include the time the password was backed up to Azure and the expected expiration time of a password. This permissions level is appropriate for reporting and compliance applications.
> - Use `DeviceLocalCredential.Read.All` to grant full permissions for reading everything about persisted Windows LAPS passwords, including the clear-text passwords themselves. This permissions level is sensitive and should be used carefully.

<a name='retrieve-the-password-from-azure-active-directory'></a>

### Retrieve the password from Microsoft Entra ID

You're almost there! First, sign in to Microsoft Graph. Then, use the `Get-LapsAADPassword` cmdlet to retrieve the password.

To sign in to Microsoft Graph, use the `Connect-MgGraph` cmdlet. You must know your Azure tenant ID and the application ID of the Microsoft Entra application you created earlier. Run the cmdlet once to sign in. For example:

```powershell
PS C:\> Connect-MgGraph -Environment Global -TenantId acca2622-272f-413f-865f-a67416923a6b -ClientId 1c2e514c-2ef1-486d-adbb-8da208457957
```

```output
Welcome To Microsoft Graph!
```

> [!TIP]
> For the `Connect-MgGraph` cmdlet to succeed, you might need to modify your PowerShell execution policy. For example, you might need for first run `Set-ExecutionPolicy -ExecutionPolicy Unrestricted`.

Now that you're logged into Microsoft Graph, you can retrieve the password.

First, invoke the `Get-LapsAADPassword` cmdlet and pass the name of the device:

```powershell
PS C:\> Get-LapsAADPassword -DeviceIds myAzureDevice
```

```output
DeviceName    DeviceId                             PasswordExpirationTime
----------    --------                             ----------------------
myAzureDevice be8ab291-6307-42a2-8fda-2f4ee78e51c8 7/31/2022 11:34:39 AM
```

> [!TIP]
> Pass the `-Verbose` parameter to see detailed info about what the `Get-LapsAADPassword` cmdlet (or any other cmdlet in the Windows LAPS PowerShell module) is doing.

The preceding example requires that the client is granted `DeviceLocalCredential.Read.Basic` permissions. The following examples require that the client is granted `DeviceLocalCredential.Read.All` permissions.

Next, invoke the `Get-LapsAADPassword` cmdlet to ask for the actual password to be returned:

```powershell
PS C:\> Get-LapsAADPassword -DeviceIds myAzureDevice -IncludePasswords
```

```output
DeviceName             : myAzureDevice
DeviceId               : be8ab291-6307-42a2-8fda-2f4ee78e51c8
Account                : Administrator
Password               : System.Security.SecureString
PasswordExpirationTime : 7/31/2022 11:34:39 AM
PasswordUpdateTime     : 7/1/2022 11:34:39 AM
```

The password that's returned in a `SecureString` object.

Finally, for testing or ad-hoc purposes, you can request that the password appears in clear text by using the `-AsPlainText` parameter:

```powershell
PS C:\> Get-LapsAADPassword -DeviceIds myAzureDevice -IncludePasswords -AsPlainText
```

```output
DeviceName             : myAzureDevice
DeviceId               : be8ab291-6307-42a2-8fda-2f4ee78e51c8
Account                : Administrator
Password               : xzYVg,;rqQ+rkXEM0B29l3z!Ez.}T9rY8%67i1#TUk
PasswordExpirationTime : 7/31/2022 11:34:39 AM
PasswordUpdateTime     : 7/1/2022 11:34:39 AM
```

## Rotate the password

Windows LAPS locally remembers when the last stored password expires, and it automatically rotates the password when the password expires. In some situations (for example, after a security breach or for ad-hoc testing), you might need to rotate the password early. To manually force a password rotation, you can use the `Reset-LapsPassword` cmdlet. For example:

```powershell
PS C:\> Reset-LapsPassword
PS C:\> Get-LapsAADPassword -DeviceIds myAzureDevice -IncludePasswords -AsPlainText
```

```output
DeviceName             : myAzureDevice
DeviceId               : be8ab291-6307-42a2-8fda-2f4ee78e51c8
Account                : Administrator
Password               : &HK%tbA+k7,vcrI387k9([f+%w)9VZz98;,(@+Ai6b
PasswordExpirationTime : 7/31/2022 12:16:16 PM
PasswordUpdateTime     : 7/1/2022 12:16:16 PM
```

> [!IMPORTANT]
>
> - Microsoft Entra ID doesn't support expiration of a device's currently stored password via modification of the password expiration timestamp in Microsoft Entra ID. This is a design difference from the Windows Server Active Directory-based Windows LAPS.
> - Avoid excessively frequent use of the `Reset-LapsPassword` cmdlet. If detected, the activity might be throttled.

<a name='windows-laps-and-azure-ad-connect-in-hybrid-environments'></a>

## Windows LAPS and Microsoft Entra Connect in hybrid environments

Windows LAPS doesn't rely on [Microsoft Entra Connect](/azure/active-directory/hybrid/connect/whatis-azure-ad-connect-v2), and there are no dependencies between these two technologies. Managed Windows LAPS devices that back up their passwords to Microsoft Entra ID do so directly via https, with no reliance whatsoever on data synchronization.

Furthermore, the Microsoft Entra ID and Intune device management portals can only view and manage passwords that have been directly backed up from a Windows LAPS device. Configuring Microsoft Entra Connect to synchronize the on-premises Active Directory Windows LAPS attributes to Microsoft Entra ID isn't a tested scenario. Manually synchronizing the on-premises Active Directory Windows LAPS attributes to Microsoft Entra ID **won't** result in those attributes showing up in the Microsoft Entra ID or Intune device management portals.

While not required for Windows LAPS to operate, whenever you extend your on-premises Active Directory schema as a best practice you should also refresh your Microsoft Entra Connect directory schema. See [Refresh directory schema](/azure/active-directory/hybrid/connect/how-to-connect-installation-wizard#refresh-directory-schema).

## See also

- [Introducing Windows Local Administrator Password Solution with Microsoft Entra ID](https://techcommunity.microsoft.com/t5/microsoft-entra-azure-ad-blog/introducing-windows-local-administrator-password-solution-with/ba-p/1942487)
- [Windows Local Administrator Password Solution in Microsoft Entra ID (preview)](https://aka.ms/cloudlaps)
- [Microsoft Intune](/mem/intune)
- [Microsoft Intune support for Windows LAPS](/mem/intune/protect/windows-laps-overview)
- [Windows LAPS CSP](/windows/client-management/mdm/laps-csp)
- [Quickstart: Register an application with the Microsoft identity platform](/azure/active-directory/develop/quickstart-register-app)
- [Windows LAPS Troubleshooting Guidance](/troubleshoot/windows-server/windows-security/windows-laps-troubleshooting-guidance)

## Next steps

- [Configure Windows LAPS policy settings](laps-management-policy-settings.md)
- [Use Windows LAPS event logs](laps-management-event-log.md)
- [Key concepts in Windows LAPS](laps-concepts.md)
