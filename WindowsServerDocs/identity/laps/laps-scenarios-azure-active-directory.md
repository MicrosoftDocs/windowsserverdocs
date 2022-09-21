---
ms.assetid: e373705e-097a-406b-9334-72f3ada9aab1
title: Local Administrator Password Solution Azure AD Scenario Guide
description: Local Administrator Password Solution Azure AD Scenario Guide
author: jsimmons
ms.author: jsimmons
manager: jsimmons
ms.date: 07/04/2022
ms.topic: article
---

# Getting started with Windows LAPS and Azure Active Directory

> [!IMPORTANT]
> Windows LAPS is currently only available in Windows Insider builds as of 25145 and later. Support for the Windows LAPS Azure AD scenario is currently limited to a small group of Windows Insiders.

## Overview

In this article, we're going to go over the basic procedures for using Windows LAPS to back up passwords to Azure Active Directory and also how to retrieve them.

Let's get started on backing up some passwords to Azure Active Directory!

## Configure device policy

### Choose policy deployment mechanism

The first step is to choose how you're going to apply policy to your devices.

The preferred option for Azure AD joined devices is to use [Microsoft Endpoint Manager](/mem/endpoint-manager-overview) in combination with the [Windows LAPS CSP](/windows/client-management/mdm/laps-csp).

If your devices are Azure AD joined but you're not using Microsoft Endpoint Manager, then it's still possible to deploy Windows LAPS for Azure Active Directory. In this case though you must deploy policy manually (for example, either using direct registry modification or Local Computer Group Policy). See [Windows LAPS Policy Settings](../laps/laps-management-policy-settings.md) article for specific details.

  > [!NOTE]
  > If your devices are hybrid-joined to on-premises Active Directory, you may deploy policy using [Windows LAPS Group Policy](../laps/laps-management-policy-settings.md#laps-group-policy).

### Policies applicable to Azure Active Directory mode

The LAPS CSP and LAPS Group Policy object both manage the same settings, however only a subset of these settings is applicable to Windows LAPS in Azure mode.

The following settings are applicable when backing passwords up to Azure AD:

* BackupDirectory
* PasswordAgeDays
* PasswordComplexity
* PasswordLength
* AdministratorAccountName
* PostAuthenticationResetDelay
* PostAuthenticationActions

More plainly: the Windows Server Active Directory-specific policy settings don't make sense, and aren't supported, when backing the password up to Azure Active Directory.

### Configure specific policies

At minimum, you must configure the BackupDirectory setting to the value 1 (backup passwords to Azure Active Directory).

If you don't configure the AdministratorAccountName setting, Windows LAPS will default to managing the default built-in local Administrator account. This built-in account is automatically identified by its well-known Relative Identifier (also known as "RID") and should therefore never be identified by name. (The name of the built-in local Administrator account will vary depending on the default locale of the device.)

If you want to configure a custom local admin account, you should configure the AdministratorAccountName setting with the name of that account.

> [!IMPORTANT]
> If you configure Windows LAPS to manage a custom local admin account, you must ensure that the account is created - LAPS doesn't support creation of the account. Microsoft recommends using the [RestrictedGroups CSP](/windows/client-management/mdm/policy-csp-restrictedgroups) for this purpose.

Finally, feel free to configure the other settings as needed or desired, for example PasswordLength, etc.

## Update the password in Azure Active Directory

Windows LAPS will process the currently active policy on a periodic (every hour) basis. In order to avoid waiting after applying the policy, you can run the `Invoke-LapsPolicyProcessing` PowerShell cmdlet.

Now look in the event log for 10029 event that verifies that the password was successfully updated in Azure Active Directory:

:::image type="content" source="../laps/media/laps-scenarios-azure-active-directory/laps-scenarios-azure-active-directory-password-update-event.png" alt-text="Screenshot of the event log showing a successful Azure Active Directory password update event log message.":::

## Password retrieval from Azure Active Directory

Retrieval of LAPS passwords stored in Azure Active Directory is supported using Microsoft Graph. Windows LAPS includes a PowerShell cmdlet (`Get-LapsAADPassword`) that is a wrapper around the Microsoft Graph PowerShell library. Windows LAPS doesn't provide any user interface options for Azure Active Directory password retrieval. The instructions describe how to use the `Get-LapsAADPassword` cmdlet to retrieve LAPS passwords from Azure Active Directory.

### Install the Microsoft Graph PowerShell library

The first step is to install the Microsoft Graph PowerShell library:

`Install-Module Microsoft.Graph -Scope AllUsers`

You may need to configure the repository as Trusted for the above command to succeed:

`Set-PSRepository PSGallery -InstallationPolicy Trusted`

### Creation of an Azure Active Directory registered app for retrieving Azure LAPS passwords

The next step is to create an Azure Active Directory application configured with the necessary permissions. The basic instructions for creating an Azure Active Directory application can be found here:

[Quickstart: Register an application with the Microsoft identity platform](/azure/active-directory/develop/quickstart-register-app)

The app needs to be configured with two permissions, first `Devices.Read.All`, and second either `Device.LocalCredentials.Read` or `Device.LocalCredentials.ReadAll`.

> [!IMPORTANT]
> `Device.LocalCredentials.Read` is used to grant permission for reading non-sensitive metadata about persisted LAPS passwords, for example the time the password was backed up to Azure, or the expected expiration time of a password. This permission level is appropriate for reporting and compliance applications.

> [!IMPORTANT]
> `Device.LocalCredentials.ReadAll` is used to grant full permission for reading everything about persisted LAPS passwords, including the clear-text passwords themselves. This permission level is sensitive and should be used carefully.

#### Manual consent to Device.LocalCredentials.* permissions

A manual step is currently required to consent to either `Device.LocalCredentials.Read` or the `Device.LocalCredentials.ReadAll` permissions. This limitation will be removed in future.

Once you've decided which Device.LocalCredentials permission to configure, manually construct a URL as follows. In these examples, we're using `DeviceLocalCredential.Read.All` as the permission; replace that with `DeviceLocalCredential.Read.Basic` as required.

<ins>For multi-tenant apps:</ins>

`https://login.microsoftonline.com/common/oauth2/v2.0/authorize?client_id=YOUR_CLIENT_APPID_HERE=response_type=code&scope=https://graph.microsoft.com/DeviceLocalCredential.Read.All`

<ins>For single-tenant apps:</ins>

`https://login.microsoftonline.com/YOUR_TENANT_NAME_OR_ID_HERE/oauth2/v2.0/authorize?client_id=YOUR_CLIENT_APPID_HERE&response_type=code&scope=https://graph.microsoft.com/DeviceLocalCredential.Read.All`

Using the appropriate URL template above, replace `YOUR_CLIENT_APPID_HERE` with the application ID of the Azure registered app you created above, and replace `YOUR_TENANT_NAME_OR_ID_HERE` with your Azure tenant name or ID.

Once the final URL is ready, paste it into a browser and navigate to it. The browser will then display a permission consent dialog, which you should say ok to. For example:

:::image type="content" source="../laps/media/laps-scenarios-azure-active-directory/laps-scenarios-azure-active-directory-permission-consent.png" alt-text="Screenshot showing an Azure Active Directory application permission consent dialog.":::

### Retrieve the password from Azure Active Directory

We're almost there! First we need to sign-in into Microsoft Graph, and then we can use the `Get-LapsAADPassword` cmdlet to retrieve the password.

Logging into Microsoft Graph is done using the `Connect-MgGraph` cmdlet. You must know your Azure tenant ID, plus the application ID of the Azure Active Directory application you created above. Run the cmdlet once to do the sign-in, for example:

`Connect-MgGraph -Environment PROD -TenantId c754bc06-12e1-4508-b3b1-653a220c62cc -ClientId 71f6c060-e966-4d7e-b068-7ea116e131ed`

```PowerShell
PS C:\> Connect-MgGraph -Environment Global -TenantId acca2622-272f-413f-865f-a67416923a6b -ClientId 1c2e514c-2ef1-486d-adbb-8da208457957
Welcome To Microsoft Graph!
```

> [!TIP]
> You may need to modify your PowerShell execution policy in order for the `Connect-MgGraph` cmdlet to succeed. For example, by running `Set-ExecutionPolicy -ExecutionPolicy Unrestricted`.

Awesome - now that you're logged into Microsoft Graph, you're ready to retrieve the password!

First, let's invoke the `Get-LapsAADPassword` cmdlet passing the name of the device:

```PowerShell
PS C:\> Get-LapsAADPassword -DeviceIds myAzureDevice

DeviceName    DeviceId                             PasswordExpirationTime
----------    --------                             ----------------------
myAzureDevice be8ab291-6307-42a2-8fda-2f4ee78e51c8 7/31/2022 11:34:39 AM
```

> [!TIP]
> Pass the -Verbose parameterFor to see detailed info on what the Get-LapsAADPassword cmdlet (or any other cmdlet in the LAPS PowerShell module) is doing.

The above example requires that the client is granted `DeviceLocalCredential.Read.Basic`. The examples below require that the client is granted `DeviceLocalCredential.Read.All`.

Next, let's invoke the `Get-LapsAADPassword` cmdlet asking for the actual password to be returned:

```PowerShell
PS C:\> Get-LapsAADPassword -DeviceIds myAzureDevice -IncludePasswords
DeviceName             : myAzureDevice
DeviceId               : be8ab291-6307-42a2-8fda-2f4ee78e51c8
Account                : Administrator
Password               : System.Security.SecureString
PasswordExpirationTime : 7/31/2022 11:34:39 AM
PasswordUpdateTime     : 7/1/2022 11:34:39 AM
```

Note: the password above is returned in a SecureString object.

Finally, for testing or ad-hoc purposes you can request that the password is displayed in clear-text using the -AsPlainText parameter:

```PowerShell
PS C:\> Get-LapsAADPassword -DeviceIds myAzureDevice -IncludePasswords -AsPlainText
DeviceName             : myAzureDevice
DeviceId               : be8ab291-6307-42a2-8fda-2f4ee78e51c8
Account                : Administrator
Password               : xzYVg,;rqQ+rkXEM0B29l3z!Ez.}T9rY8%67i1#TUk
PasswordExpirationTime : 7/31/2022 11:34:39 AM
PasswordUpdateTime     : 7/1/2022 11:34:39 AM
```

## Rotating the password

Windows LAPS will locally remember when the last stored password expires, and will automatically rotate the password upon expiry. In some situations (for example, after a security breach, or for ad-hoc testing purposes) it may be necessary to rotate the password early. To manually force a password rotation, you can use the `Reset-LapsPassword` cmdlet, for example:

```PowerShell
PS C:\> Reset-LapsPassword
PS C:\> Get-LapsAADPassword -DeviceIds myAzureDevice -IncludePasswords -AsPlainText
DeviceName             : myAzureDevice
DeviceId               : be8ab291-6307-42a2-8fda-2f4ee78e51c8
Account                : Administrator
Password               : &HK%tbA+k7,vcrI387k9([f+%w)9VZz98;,(@+Ai6b
PasswordExpirationTime : 7/31/2022 12:16:16 PM
PasswordUpdateTime     : 7/1/2022 12:16:16 PM
```

> [!IMPORTANT]
> Azure Active Directory doesn't support expiration of a device's currently stored password via modification of the password expiration timestamp in Azure Active Directory. This is a design difference from the Windows Server Active Directory-based Windows LAPS.

> [!IMPORTANT]
> Excessively frequent use of the `Reset-LapsPassword` cmdlet is not recommended. If detected such activity may be throttled.

## Next steps

Proceed to the [Windows LAPS Concepts](../laps/laps-concepts.md) article.

## See also

[Windows LAPS Concepts](../laps/laps-concepts.md)

[Windows LAPS Policy Settings](../laps/laps-management-policy-settings.md)

[Windows LAPS CSP](/windows/client-management/mdm/laps-csp)

[Quickstart: Register an application with the Microsoft identity platform](/azure/active-directory/develop/quickstart-register-app)
