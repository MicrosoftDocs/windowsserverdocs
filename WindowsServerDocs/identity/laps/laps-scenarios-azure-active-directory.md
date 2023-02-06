---
title: Get started with Windows LAPS and Azure Active Directory
description: Learn how to get started with Windows Local Administrator Password Solution (Windows LAPS) and Azure Active Directory.
author: jay98014
ms.author: jsimmons
ms.date: 07/04/2022
ms.topic: conceptual
---

# Get started with Windows LAPS and Azure Active Directory

Learn how to get started with Windows Local Administrator Password Solution (Windows LAPS) and Azure Active Directory. The article describes the basic procedures for using Windows LAPS to back up passwords to Azure Active Directory and how to retrieve them.

> [!IMPORTANT]
> Windows LAPS currently is available only in [Windows 11 Insider Preview Build 25145 and later](/windows-insider/flight-hub/#active-development-builds-of-windows-11). Support for the Windows LAPS Azure Active Directory scenario is currently in private preview, and limited to a small number of customers who have a direct engagement with engineering. Once public preview is declared in 2023, all customers will be able to evaluate this AAD scenario.

## Configure device policy

To configure device policy, complete these tasks:

- Choose a policy deployment mechanism
- Understand policies that apply to Azure Active Directory mode
- Configure specific policies

### Choose a policy deployment mechanism

The first step is to choose how to apply policy to your devices.

The preferred option for Azure Active Directory-joined devices is to use [Microsoft Intune](/mem/endpoint-manager-overview) with the [Windows LAPS configuration service provider (CSP)](/windows/client-management/mdm/laps-csp).

If your devices are Azure Active Directory-joined but you're not using Microsoft Intune, you can still deploy Windows LAPS for Azure Active Directory. In this scenario, you must deploy policy manually (for example, either by using direct registry modification or by using Local Computer Group Policy). For more information, see [Configure Windows LAPS policy settings](laps-management-policy-settings.md).

> [!NOTE]
> If your devices are hybrid-joined to on-premises Windows Server Active Directory, you can deploy policy by using [Windows LAPS Group Policy](laps-management-policy-settings.md#windows-laps-group-policy).

### Policies that apply to Azure Active Directory mode

The Windows LAPS CSP and Windows LAPS Group Policy object both manage the same settings, but only a subset of these settings applies to Windows LAPS in Azure mode.

The following settings are applicable when backing passwords up to Azure Active Directory:

- BackupDirectory
- PasswordAgeDays
- PasswordComplexity
- PasswordLength
- AdministratorAccountName
- PostAuthenticationResetDelay
- PostAuthenticationActions

More plainly: the Windows Server Active Directory-specific policy settings don't make sense, and aren't supported, when backing the password up to Azure Active Directory.

### Configure specific policies

At a minimum, you must configure the BackupDirectory setting to the value 1 (backup passwords to Azure Active Directory).

If you don't configure the AdministratorAccountName setting, Windows LAPS defaults to managing the default built-in local administrator account. This built-in account is automatically identified by its well-known relative identifier (RID) and should never be identified by name. The name of the built-in local administrator account varies depending on the default locale of the device.

If you want to configure a custom local administrator account, you should configure the AdministratorAccountName setting with the name of that account.

> [!IMPORTANT]
> If you configure Windows LAPS to manage a custom local administrator account, you must ensure that the account is created. Windows LAPS doesn't create the account. We recommend that you use the [Accounts CSP](/windows/client-management/mdm/accounts-csp) to create the account.

You can configure other settings, like PasswordLength, as needed for your organization.

## Update a password in Azure Active Directory

Windows LAPS processes the currently active policy on a periodic basis (every hour). To avoid waiting after you apply the policy, you can run the `Invoke-LapsPolicyProcessing` PowerShell cmdlet.

To verify that the password was successfully updated in Azure Active Directory, look in the event log for the 10029 event:

:::image type="content" source="./media/laps-scenarios-azure-active-directory/laps-scenarios-azure-active-directory-password-update-event.png" alt-text="Screenshot of the event log and a successful Azure Active Directory password update event log message.":::

## Retrieve a password from Azure Active Directory

Retrieving Windows LAPS passwords stored in Azure Active Directory is supported by using Microsoft Graph. Windows LAPS includes a PowerShell cmdlet (`Get-LapsAADPassword`) that's a wrapper around the Microsoft Graph PowerShell library. Windows LAPS doesn't provide any user interface options for Azure Active Directory password retrieval. The instructions describe how to use the `Get-LapsAADPassword` cmdlet to retrieve Windows LAPS passwords from Azure Active Directory.

### Install the Microsoft Graph PowerShell library

The first step is to install the Microsoft Graph PowerShell library:

`Install-Module Microsoft.Graph -Scope AllUsers`

You might need to configure the repository as Trusted for the command to succeed:

`Set-PSRepository PSGallery -InstallationPolicy Trusted`

### Create an Azure Active Directory registered app to retrieve Windows LAPS passwords

The next step is to create an Azure Active Directory application that's configured with the necessary permissions. To review the basic instructions for creating an Azure Active Directory application, see [Quickstart: Register an application with the Microsoft identity platform](/azure/active-directory/develop/quickstart-register-app)

The app needs to be configured with two permissions: `Device.Read.All` and either `Device.LocalCredentials.Read` or `Device.LocalCredentials.ReadAll`.

> [!IMPORTANT]
>
> - Use `Device.LocalCredentials.Read` to grant permissions for reading non-sensitive metadata about persisted Windows LAPS passwords. Examples include the time the password was backed up to Azure and the expected expiration time of a password. This permissions level is appropriate for reporting and compliance applications.
> - Use `Device.LocalCredentials.ReadAll` to grant full permissions for reading everything about persisted Windows LAPS passwords, including the clear-text passwords themselves. This permissions level is sensitive and should be used carefully.

#### Manual consent to Device.LocalCredentials.\* permissions

Currently, a manual step is required to consent to either `Device.LocalCredentials.Read` or the `Device.LocalCredentials.ReadAll` permissions.

After you decide which `Device.LocalCredentials` permission to configure, manually construct a URL for your scenario. In the following examples, `DeviceLocalCredential.Read.All` is the permission. Replace the permission with `DeviceLocalCredential.Read.Basic` if necessary.

For multi-tenant apps:

`https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=<YourClientAppID>=response_type=code&scope=https://graph.microsoft.com/DeviceLocalCredential.Read.All`

For single-tenant apps:

`https://login.microsoftonline.com/<YourTenantNameOrTenantID>/oauth2/v2.0/authorize?client_id=<YourClientAppID>&response_type=code&scope=https://graph.microsoft.com/DeviceLocalCredential.Read.All`

Using the URL template that's relevant for your scenario, replace `<YourClientAppID>` with the application ID of the Azure registered app you created earlier. Replace `<YourTenantNameOrTenantID>` with your Azure tenant name or tenant ID.

When the final URL is ready, paste it into a browser and go to the URL. The browser displays a permissions consent dialog. Select the **Consent on behalf of your organization** checkbox, and then select **Accept**. For example:

:::image type="content" source="./media/laps-scenarios-azure-active-directory/laps-scenarios-azure-active-directory-permission-consent.png" alt-text="Screenshot that shows an Azure Active Directory application permissions consent dialog.":::

### Retrieve the password from Azure Active Directory

You're almost there! First, sign in to Microsoft Graph. Then, use the `Get-LapsAADPassword` cmdlet to retrieve the password.

To sign in to Microsoft Graph, use the `Connect-MgGraph` cmdlet. You must know your Azure tenant ID and the application ID of the Azure Active Directory application you created earlier. Run the cmdlet once to sign in. For example:

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

Finally, for testing or ad-hoc purposes, you can request that the password appear in clear text by using the `-AsPlainText` parameter:

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
> - Azure Active Directory doesn't support expiration of a device's currently stored password via modification of the password expiration timestamp in Azure Active Directory. This is a design difference from the Windows Server Active Directory-based Windows LAPS.
> - Avoid excessively frequent use of the `Reset-LapsPassword` cmdlet. If detected, the activity might be throttled.

## See also

- [Windows LAPS CSP](/windows/client-management/mdm/laps-csp)
- [Quickstart: Register an application with the Microsoft identity platform](/azure/active-directory/develop/quickstart-register-app)

## Next steps

- [Configure Windows LAPS policy settings](laps-management-policy-settings.md)
- [Use Windows LAPS event logs](laps-management-event-log.md)
- [Key concepts in Windows LAPS](laps-concepts.md)
