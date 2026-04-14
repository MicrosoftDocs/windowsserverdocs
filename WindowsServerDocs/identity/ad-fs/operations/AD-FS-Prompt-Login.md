---
title: AD FS prompt=login
description: Learn about the native support for the prompt=login parameter that is available in AD FS.
ms.date: 04/08/2025
ms.topic: how-to
ms.custom: it-pro, has-azure-ad-ps-ref, azure-ad-ref-level-one-done
---

# Active Directory Federation Services prompt=login parameter support

The following document describes the native support for the prompt=login parameter that is available in AD FS.

## What is prompt=login?

When applications need to request fresh authentication from Microsoft Entra ID, meaning that they need Microsoft Entra ID to re-authenticate the user even if the user has already been authenticated, they can send the `prompt=login` parameter to Microsoft Entra ID as part of the authentication request.

When this request is for a federated user, Microsoft Entra ID needs to inform the IdP, like AD FS, that the request is for fresh authentication.

By default, Microsoft Entra ID translates `prompt=login` to `wfresh=0` and `wauth=https://schemas.microsoft.com/ws/2008/06/identity/authenticationmethod/password` when sending this type of authentication requests to the federated IdP.

These parameters mean:

- `wfresh=0`: do fresh authentication
- `wauth=https://schemas.microsoft.com/ws/2008/06/identity/authenticationmethod/password`: use username/password for the fresh authentication request

This can cause problems with corporate intranet and multi-factor authentication scenarios in which an authentication type other than username and password, as  requested by the `wauth` parameter, is desired.

AD FS in Windows Server 2012 R2 with the July 2016 update rollup introduced native support for the `prompt=login` parameter. This means that now Microsoft Entra ID can send this parameter as-is to AD FS service as part of Microsoft Entra ID and Office 365 authentication requests.

## AD FS versions that support prompt=login

The following is a list of AD FS versions that support the `prompt=login` parameter.

- AD FS in Windows Server 2012 R2 with the July 2016 update rollup
- AD FS in Windows Server 2016 or later 

## How to configure a federated domain to send prompt=login to AD FS

Use the [Microsoft Graph PowerShell](/powershell/microsoftgraph/installation) module to configure the setting.

1. First obtain the current values of `FederatedIdpMfaBehavior`, `PreferredAuthenticationProtocol`, and `PromptLoginBehavior` for the federated domain by running the following PowerShell command:

   ```powershell
   Get-MgDomainFederationConfiguration -DomainId <your_domain_name> | Format-List *
   ```

   > [!NOTE]
   > The output of `Get-MgDomainFederationConfiguration` by default does not display certain properties in the console. To view all the properties you should pipe (`|`) its output to `Format-List *` to force the output of all the properties of the object.

   If the value of the property `PromptLoginBehavior` is empty (`$null`) the behavior of `TranslateToFreshPasswordAuth` is used.

2. Configure the desired value of `PromptLoginBehavior` by running the following command:

   ```powershell
   New-MgDomainFederationConfiguration -DomainId <your_domain_name> `
      -FederatedIdpMfaBehavior <current_value_from_step1> `
      -PreferredAuthenticationProtocol <current_value_from_step1> `
      -PromptLoginBehavior <TranslateToFreshPasswordAuth|nativeSupport|Disabled>
   ```

Following are the possible values of `PromptLoginBehavior` parameter and their meaning:

- **TranslateToFreshPasswordAuth**: means the default Microsoft Entra behavior of translating `prompt=login` to `wauth=https://schemas.microsoft.com/ws/2008/06/identity/authenticationmethod/password` and `wfresh=0`.
- **nativeSupport**: means that the `prompt=login` parameter will be sent as is to AD FS. This is the recommended value if AD FS is in Windows Server 2012 R2 with the July 2016 update rollup or higher.
- **Disabled**: means that only `wfresh=0` is sent to AD FS.
