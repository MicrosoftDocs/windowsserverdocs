---
description: Learn more about what's new in Active Directory Federation Services (AD FS) for Windows Server 2016.
ms.assetid: aa892a85-f95a-4bf1-acbb-e3c36ef02b0d
title: What's new in Active Directory Federation Services for Windows Server 2016
author: billmath
ms.author: wscontent
manager: amycolannino
ms.date: 05/26/2023
ms.topic: article
---

# What's new in Active Directory Federation Services

## What's new in Active Directory Federation Services for Windows Server 2019

This article describes the new changes made to Active Directory Federation Services (AD FS).

### Protected sign ins

The following points are a brief summary of updates to protected sign ins available in Active Directory Federation Services (AD FS) 2019:

- **External Auth Providers as Primary**. Customers can now use third-party authentication products as the first factor and not expose passwords as the first factor. In the cases where an external auth provider can prove two factors, it can claim MFA.
- **Password Authentication as extra Authentication**. Customers have a fully supported in-box option to use passwords only as an extra factor after a password-less option is used as the first factor. This option improves the customer experience from AD FS 2016 where customers had to download a GitHub adapter that's supported as-is.
- **Pluggable Risk Assessment Module**. Customers can now build their own plug-in modules to block certain types of requests during the preauthentication stage. This feature makes it easier for customers to use cloud intelligence such as identity protection to block sign in for risky users or risky transactions. For more information, see [Build Plug-ins with AD FS 2019 Risk Assessment Model](../../ad-fs/development/ad-fs-risk-assessment-model.md).
- **ESL improvements**. Improves on the ESL quick-fix engineering (QFE) in 2016 by adding the following capabilities:
  - Enables customers to be in audit mode while being protected by 'classic' extranet lockout functionality, available since AD FS 2012R2. Currently 2016 customers would have no protection while in audit mode.
  - Enables independent lockout threshold for familiar locations. This feature makes it possible for multiple instances of apps running with a common service account to roll over passwords with the least amount of effect.

### Other security improvements

The following security improvements are available in AD FS 2019:

- **Remote PowerShell using SmartCard Sign-in**. Customers can now use SmartCards to remote connect to AD FS via PowerShell and use that to manage all PowerShell functions including multi-node cmdlets.
- **HTTP Header customization**. Customers can now customize HTTP headers emitted during AD FS responses, including the following headers:
  - HSTS: This header conveys that AD FS endpoints can only be used on HTTPS endpoints for a compliant browser to enforce.
  - x-frame-options: Allows AD FS admins to allow specific relying parties to embed iFrames for AD FS interactive sign-in pages. This header should be used with care and only on HTTPS hosts.
  - Future header: Other future headers can be configured as well.

For more information, see [Customize HTTP security response headers with AD FS 2019](../../ad-fs/operations/customize-http-security-headers-ad-fs.md).

### Authentication/Policy capabilities

The following authentication/policy capabilities are in AD FS 2019:

- **Specify auth method for other auth per RP**. Customers can now use claims rules to decide which other authentication provider to invoke for their extra authentication. This feature is useful for two use cases:
  - Customers are transitioning from one other authentication provider to another. This way as they onboard users to a newer authentication provider they can use groups to control which extra authentication provider is called.
  - Customers have needs for a specific extra authentication provider (for example, certificate) for certain applications.
- **Restrict Transport Layer Security (TLS) based device auth only to applications that require it**. Customers can now restrict client TLS-based device authentications to only applications performing device based conditional access. This option prevents any unwanted prompts for device authentication (or failures if the client application can't handle) for applications that don't require TLS-based device authentication.
- **Multi-factor authentication (MFA) freshness support**. AD FS now supports the ability to redo second factor credential based on the freshness of the second factor credential. This feature allows customers to do an initial transaction with two factors and only prompt for the second factor on a periodic basis. This feature is only available to applications that can provide an extra parameter in the request and isn't a configurable setting in AD FS. Azure AD supports this parameter when you configure "Remember my MFA for X days" and set the 'supportsMFA' flag to true on the Azure AD federated domain trust settings.

### Single sign-on improvements

The following single sign-on SSO improvements have been made in AD FS 2019:

- **Paginated UX with Centered Theme**. AD FS now has moved to a [paginated UX flow](../operations/AD-FS-paginated-sign-in.md) that allows AD FS to validate and provide a more smoother sign-in experience. AD FS now uses a centered UI (instead of the right side of the screen). You might need newer logo and background images to align with this experience. This change also mirrors functionality offered in Azure AD.
- **Bug fix: Persistent SSO state for Win10 devices when doing Primary Refresh Token (PRT) auth**. This change resolves an issue where MFA state didn't persist when using PRT authentication for Windows 10 devices. The result of the issue was that end users would get prompted for second factor credential (MFA) frequently. The fix also makes the experience consistent when device auth is successfully performed via client TLS and via PRT mechanism.

### Support for building modern line-of-business apps

The following support for building modern line-of-business LOB apps has been added to AD FS 2019:

- **Oauth Device flow/profile**. AD FS now supports the OAuth device flow profile to sign in on devices that don't have a UI surface area to support rich sign-in experiences. This feature allows the user to complete the sign-in experience on a different device. This functionality is required for the Azure CLI experience in Azure Stack and can be used in other cases.
- **Removal of 'Resource' parameter**. AD FS has now removed the requirement to specify a resource parameter, which is in line with current Oauth specifications. Clients can now provide the relying party trust identifier as the scope parameter in addition to permissions requested.
- **Cross-origin resource sharing (CORS) headers in AD FS responses**. Customers can now build single page applications that allow client-side JavaScript libraries to validate the signature of the id_token by querying for the signing keys from the OpenID Connect (OIDC) discovery document on AD FS.
- **Proof Key for Code Exchange (PKCE) support**. AD FS adds PKCE support to provide a secure auth code flow within OAuth. This feature adds an extra layer of security to this flow to prevent hijacking the code and replaying it from a different client.
- **Bug fix: Send x5t and kid claim**. This change is a minor bug fix. AD FS now additionally sends the "kid" claim to denote the key ID hint for verifying the signature. Previously, AD FS only sent the "x5t" claim.

### Supportability improvements

The following improvements to supportability are now part of AD FS 2019:

- **Send error details to AD FS admins**. Allows admins to configure end users to send debug logs relating to a failure in end-user authentication to be stored as a zipped filed for easy consumption. Admins can also configure a Simple Mail Transfer Protocol (SMTP) connection to automail the zipped file to a triage email account or to auto create a ticket based on the email.

### Deployment updates

The following deployment updates are now included in AD FS 2019:

- **Farm Behavior Level 2019**. As with AD FS 2016, there's a new farm behavior level version that's required to enable new functionality discussed [later in the article](#moving-from-ad-fs-in-windows-server-2012-r2-to-ad-fs-in-windows-server-2016-is-easier). This update allows going from:
  - AD FS on Windows Server 2012 R2 to AD FS on Windows Server 2016.
  - AD FS on Windows Server 2016 to AD FS on Windows Server 2019.

### SAML updates

The following Security Assertion Markup Language (SAML) update is in AD FS 2019:

- **Bug fix: Fix bugs in aggregated federation**. There have been numerous bug fixes around aggregated federation support (for example, InCommon). The following areas have received fixes:
  - Improved scaling for a large number of entities in the aggregated federation metadata doc. Previously, scaling would fail with an "ADMIN0017" error.
  - Query using 'ScopeGroupID' parameter via `Get-AdfsRelyingPartyTrustsGroup` PowerShell cmdlet.
  - Handling error conditions around duplicate entityID.

### Azure AD style resource specification in scope parameter

Previously, AD FS required the desired resource and scope to be in a separate parameter in any authentication request. For example, the following OAuth request might look like you'd typically send:

```http
https:&#47;&#47;fs.contoso.com/adfs/oauth2/authorize?response_type=code&client_id=claimsxrayclient&resource=urn:microsoft:adfs:claimsxray&scope=oauth&redirect_uri=https:&#47;&#47;adfshelp.microsoft.com/
ClaimsXray/TokenResponse&prompt=login
```

With AD FS on Server 2019, you can now pass the resource value embedded in the scope parameter. This change is consistent with how one can do authentication against Azure AD also.

The scope parameter can now be organized as a space separated list where each entry is structure as resource/scope.

> [!NOTE]
> Only one resource can be specified in the authentication request. If more than one resource is included in the request, AD FS returns an error and authentication doesn't not succeed.

### Proof Key for Code Exchange (PKCE) support for oAuth

OAuth public clients using the Authorization Code Grant are susceptible to the authorization code interception attack. The attack is well described in RFC 7636. To mitigate this attack, AD FS in Server 2019 supports Proof Key for Code Exchange (PKCE) for OAuth Authorization Code Grant flow.

To use the PKCE support, this specification adds more parameters to the OAuth 2.0 Authorization and access token requests.

:::image type="content" source="media/whats-new-in-active-directory-federation-services-for-windows-server-2016/adfs2019.png" alt-text="Diagram of the PKCE relationship between the client and AD FS 2019.":::

**A**. The client creates and records a secret named the "code_verifier" and derives a transformed version "t(code_verifier)" (referred to as the "code_challenge"). The secret is sent in the OAuth 2.0 Authorization Request along with the "t_m" transformation method.

**B**. The authorization endpoint responds as usual but records "t(code_verifier)" and the transformation method.

**C**. The client then sends the authorization code in the access token request as usual but includes the "code_verifier" secret generated at (A).

**D**. The AD FS transforms "code_verifier" and compares it to "t(code_verifier)" from (B). Access is denied if they aren't equal.

#### How to choose extra auth providers in 2019

AD FS already supports triggering extra authentication based on a claim rule policy. Those policies can be set on a particular RP or at global level. You can set an extra auth policy for a particular RP by using the cmdlet [Set-AdfsRelyingPartyTrust (AD FS) | Microsoft Docs](/powershell/module/adfs/set-adfsrelyingpartytrust) by passing either the *AdditionalAuthenticationRules* or *AdditionalAuthenticationRulesFile* parameter. To set it globally, an admin can use the cmdlet [Set-AdfsAdditionalAuthenticationRule (AD FS) | Microsoft Docs](/powershell/module/adfs/set-adfsadditionalauthenticationrule).

For example, 2012 R2 onwards admin can already write the following rule to prompt extra authentication if the request comes from extranet.

```powershell
Set-AdfsAdditionalAuthenticationRule -AdditionalAuthenticationRules 'c:[type == "https://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork", value == "false"] => issue(type = "https://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod", value = "https://schemas.microsoft.com/claims/multipleauthn" );' 
```

In 2019, customers can now use claims rules to decide which other authentication provider to invoke for extra authentication. This feature is useful for two scenarios:

Customers are transitioning from one other authentication provider to another. This way as they onboard users to a newer authentication provider they can use groups to control which extra authentication provider is called.

Customers have a need for a specific extra authentication provider (for example, certificate) for certain applications but different method (Azure AD Multi-Factor Authentication) for other applications.

This configuration could be achieved by issuing the claim `https://schemas.microsoft.com/claims/authnmethodsproviders` from other authentication policies. The value of this claim should be the Name of the authentication provider.

Now in 2019 they can modify the previous claim rule to choose auth providers based on their scenarios.  

Transitioning from one other authentication provider to another:
You can modify the previously mentioned rule to choose Azure AD Multi-Factor Authentication for users that are in group SID S-1-5-21-608905689-872870963-3921916988-12345. For example you could use this modification for a group you manage by enterprise, which tracks the users that have registered for Azure AD Multi-Factor Authentication. This modification also works for the rest of the users that an admin wants to use certificate auth.

```powershell
'c:[type == "https://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork", Value == "false"] => issue(type = "http://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod", Value = "https://schemas.microsoft.com/claims/multipleauthn" ); 

 c:[Type == "https://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", Value == "S-1-5-21-608905689-872870963-3921916988-12345"] => issue(Type = "`https://schemas.microsoft.com/claims/authnmethodsproviders`", Value = "AzureMfaAuthentication"); 

not exists([Type == "https://schemas.microsoft.com/ws/2008/06/identity/claims/groupsid", Value=="S-1-5-21-608905689-872870963-3921916988-12345"]) => issue(Type = "`https://schemas.microsoft.com/claims/authnmethodsproviders`", Value = "CertificateAuthentication");’ 
```

This example shows how to set two different auth providers for two different applications:

Set Application A to use Azure AD Multi-Factor Authentication as an extra auth provider:

```powershell
Set-AdfsRelyingPartyTrust -TargetName AppA -AdditionalAuthenticationRules 'c:[type == "https://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork", Value == "false"] => issue(type = "https://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod", Value = "https://schemas.microsoft.com/claims/multipleauthn" ); 

c:[] => issue(Type = "http://schemas.microsoft.com/claims/authnmethodsproviders", Value = "AzureMfaAuthentication");' 
```

Set Application B to use Certificate as an extra auth provider:

```powershell
Set-AdfsRelyingPartyTrust -TargetName AppB -AdditionalAuthenticationRules 'c:[type == "http://schemas.microsoft.com/ws/2012/01/insidecorporatenetwork", Value == "false"] => issue(type = "http://schemas.microsoft.com/ws/2008/06/identity/claims/authenticationmethod", Value = "http://schemas.microsoft.com/claims/multipleauthn" ); 

c:[] => issue(Type = "http://schemas.microsoft.com/claims/authnmethodsproviders", Value = "CertificateAuthentication");' 
 ```

Admins can also make rules to allow more than one extra authentication provider. In this case AD FS shows the issued auth methods providers, and a user can choose any of them. To allow multiple extra authentication providers, they should issue multiple claims `https://schemas.microsoft.com/claims/authnmethodsproviders`.

If the claim evaluation returns none of the auth providers, AD FS falls back to show all the extra auth providers configured by the admin on AD FS. The user needs to then select the appropriate auth provider.

To get all the other authentication providers allowed, admin can use the cmdlet (Get-AdfsGlobalAuthenticationPolicy).AdditionalAuthenticationProvider. The value of the `https://schemas.microsoft.com/claims/authnmethodsproviders` claim should be one of the provider names returned by previously mentioned cmdlet.

There's no support to trigger a particular extra auth provider if the RP is using [Access Control Policies in AD FS Windows Server 2016 | Microsoft Docs](../operations/access-control-policies-in-ad-fs.md). When you move an application away from Access control policy, AD FS copies the corresponding policy from Access Control Policy to AdditionalAuthenticationRules and IssuanceAuthorizationRules. So if an admin wants to use a particular auth provider, they can move away from not using access control policy and then modify AdditionalAuthenticationRules to trigger a specific auth provider.

### FAQ

#### How do I resolve the AD FS Admin event logs error, “Received invalid Oauth request. The client 'NAME' is forbidden to access the resource with scope 'ugs'."?

Follow these steps to remediate the issue:

1. Launch AD FS management console. Go to **Services > Scope Descriptions**.
1. Select more options on "**Scope Descriptions**, and select **Add Scope Description**.
1. Under name, enter "ugs" and Select **Apply > OK**.
1. Launch PowerShell as Administrator.
1. Run the command `Get-AdfsApplicationPermission`. Look for the `ScopeNames :{openid, aza}` that has the `ClientRoleIdentifier`. Make a note of the `ObjectIdentifier`.
1. Run the command `Set-AdfsApplicationPermission -TargetIdentifier <ObjectIdentifier from step 5> -AddScope 'ugs'`.
1. Restart the AD FS service.
1. On the client, restart the client. You should be prompted to configure Windows Hello for Business (WHFB).
1. If the configuration window doesn't pop up, then you need to collect trace logs and troubleshoot further.

#### Can I pass a resource value as part of the scope value like how requests are done against Azure AD?

With AD FS on Server 2019, you can now pass the resource value embedded in the scope parameter. The scope parameter can now be organized as a space separated list where each entry is structure as resource/scope. For example:
`<create a valid sample request>`

#### Does AD FS support PKCE extension?

AD FS in Server 2019 supports Proof Key for Code Exchange (PKCE) for OAuth Authorization Code Grant flow.

## What's new in Active Directory Federation Services for Windows Server 2016

If you're looking for information on earlier versions of AD FS, see the following articles: [AD FS in Windows Server 2012 or 2012 R2](../../active-directory-federation-services.md) and [AD FS 2.0](/previous-versions/windows/it-pro/windows-server-2008-r2-and-2008/dd727958(v=ws.10)).

 AD FS provides access control and single sign-on across a wide variety of applications including Office 365, cloud based SaaS applications, and applications on the corporate network.

- For the IT organization, it enables you to provide sign on and access control to both modern and legacy applications on any machine, based on the same set of credentials and policies.
- For the user, it provides seamless sign-on using the same, familiar account credentials.
- For the developer, it provides an easy way to authenticate users whose identities live in the organizational directory so that you can focus your efforts on your application, not authentication or identity.

## Eliminate Passwords from the extranet

AD FS 2016 enables three new options for sign-on without passwords, enabling organizations to avoid risk of network compromise from phished, leaked, or stolen passwords.

### Sign in with Azure Active Directory multi-factor authentication

AD FS 2016 builds upon the multi-factor authentication (MFA) capabilities of AD FS in Windows Server 2012 R2. You can now allow sign-on by using only an Azure AD Multi-Factor Authentication code, without first entering a username and password.

- With Azure AD Multi-Factor Authentication as the primary authentication method, the user is prompted for their username and the OTP code from the Azure Authenticator app.
- With Azure AD Multi-Factor Authentication as the secondary or extra authentication method, the user provides primary authentication credentials. They can do sign in by using Windows Integrated Authentication, with their username and password, smart card, or a user or device certificate. Then they see a prompt for text, voice, or OTP-based Azure AD Multi-Factor Authentication sign-in.
- With the new built-in Azure AD Multi-Factor Authentication adapter, setup and configuration for Azure AD Multi-Factor Authentication with AD FS has never been simpler.
- Organizations can take advantage of Azure AD Multi-Factor Authentication without the need for an on premises Azure AD Multi-Factor Authentication server.
- Azure AD Multi-Factor Authentication can be configured for intranet or extranet, or as part of any access control policy.

For more information about Azure AD Multi-Factor Authentication with AD FS, see [Configure AD FS 2016 and Azure AD Multi-Factor Authentication](../operations/configure-ad-fs-and-azure-mfa.md).

### Password-less access from compliant devices

AD FS 2016 builds on previous device registration capabilities to enable sign on and access control based the device compliance status. Users can sign on using the device credential, and compliance is reevaluated when device attributes change so that you can always ensure policies are being enforced. This feature enables policies such as:

- Enable Access only from devices that are managed and/or compliant.
- Enable Extranet Access only from devices that are managed and/or compliant.
- Require multi-factor authentication for computers that aren't managed or not compliant.

AD FS provides the on premises component of conditional access policies in a hybrid scenario. When you register devices with Azure AD for conditional access to cloud resources, the device identity can be used for AD FS policies as well.

:::image type="content" source="media/whats-new-in-active-directory-federation-services-for-windows-server-2016/ADFS_ITPRO4.png" alt-text="Diagram of a hybrid solution and the relationships between users and on-premises active directory.":::

 For more information about using device based conditional access in the cloud, see [Azure Active Directory Conditional Access](/azure/active-directory/conditional-access/overview).

For more information about using device based conditional access with AD FS

- [Planning for Device Based Conditional Access with AD FS](../../ad-fs/deployment/Plan-Device-based-Conditional-Access-on-Premises.md).
- [Access Control Policies in AD FS](../../ad-fs/operations/Access-Control-Policies-in-AD-FS.md).

### Sign in with Windows Hello for Business

> [!NOTE]
> Currently, Google Chrome and the [new Microsoft Edge built on Chromium](https://www.microsoft.com/edge?form=MB110A&OCID=MB110A) open source project browsers are not supported for browser based single-sign on (SSO) with Windows Hello for Business. Please use Internet Explorer or an older version of Microsoft Edge.

Windows 10 devices introduce Windows Hello and Windows Hello for Business, replacing user passwords with strong device-bound user credentials protected by a user's gesture (a PIN, a biometric gesture like fingerprint, or facial recognition). AD FS 2016 supports these new Windows 10 capabilities so that users can sign in to AD FS applications from an intranet or extranet without providing password.

For more information about using Windows Hello for Business in your organization, see [Enable Windows Hello for Business in your organization](/windows/security/identity-protection/hello-for-business/hello-identity-verification).

## Secure access to applications

The following changes affect secure access to applications in AD FS.

### Modern authentication

AD FS 2016 supports the latest modern protocols that provide a better user experience for Windows 10 and the latest iOS and Android devices and apps.

For more information, see [AD FS Scenarios for Developers](../../ad-fs/overview/ad-fs-openid-connect-oauth-flows-scenarios.md).

### Configure access control policies without having to know claim rules language

Previously, AD FS administrators had to configure policies by using the AD FS claim rule language, making it difficult to configure and maintain policies. With access control policies, administrators can use built in templates to apply common policies such as

- Permit intranet access only.
- Permit everyone and require MFA from Extranet.
- Permit everyone and require MFA from a specific group.

The templates are easy to customize by using a wizard driven process to add exceptions or extra policy rules and can be applied to one or many applications for consistent policy enforcement.

For more information, see [Access control policies in AD FS](../../ad-fs/operations/Access-Control-Policies-in-AD-FS.md).

### Enable sign on with non-AD LDAP directories

Many organizations have a combination of Active Directory and third-party directories. With the addition of AD FS support for authenticating users stored in Lightweight Directory Access Protocol (LDAP) v3-compliant directories, AD FS can now be used for:

- Users in third party, LDAP v3 compliant directories.
- Users in Active Directory forests to which an Active Directory two-way trust isn't configured.
- Users in Active Directory Lightweight Directory Services (AD LDS).

For more information, see [Configure AD FS to authenticate users stored in LDAP directories](../../ad-fs/operations/Configure-AD-FS-to-authenticate-users-stored-in-LDAP-directories.md).

## Better Sign-in experience

The following changes improve the sign-in experience for AD FS.

### Customize sign in experience for AD FS applications

Previously, AD FS in Windows Server 2012 R2 provided a common sign-on experience for all relying party applications, with the ability to customize a subset of text-based content per application. With Windows Server 2016, you can customize not only the messages, but images, logo and web theme per application. Additionally, you can create new, custom web themes and apply these themes per relying party.

For more information, see [AD FS user sign-in customization](../../ad-fs/operations/AD-FS-user-sign-in-customization.md).

## Manageability and operational enhancements

The following section describes the improved operational scenarios that are introduced with Active Directory Federation Services in Windows Server 2016.

### Streamlined auditing for easier administrative management

In AD FS for Windows Server 2012 R2, there were numerous audit events generated for a single request, and the relevant information about a sign-in or token issuance activity was either absent or spread across multiple audit events. By default the AD FS audit events are turned off due to their verbose nature.
With the release of AD FS 2016, auditing has become more streamlined and less verbose.

For more information, see [Auditing enhancements to AD FS in Windows Server 2016](../../ad-fs/technical-reference/auditing-enhancements-to-ad-fs-in-windows-server.md).

### Improved interoperability with SAML 2.0 for participation in confederations

AD FS 2016 contains more SAML protocol support, including support for importing trusts based on metadata that contains multiple entities. This change enables you to configure AD FS to participate in confederations such as InCommon Federation and other implementations conforming to the eGov 2.0 standard.

For more information, see [Improved interoperability with SAML 2.0](../../ad-fs/operations/Improved-interoperability-with-SAML-2.0.md).

### Simplified password management for federated Microsoft 365 users

You can configure Active Directory Federation Services (AD FS) to send password expiry claims to the relying party trusts (applications) that are protected by AD FS. How these claims are used depends on the application. For example, with Office 365 as your relying party, updates have been implemented to Exchange and Outlook to notify federated users of their soon-to-be-expired passwords.

For more information, see [Configure AD FS to send password expiry claims](../../ad-fs/operations/Configure-AD-FS-to-Send-Password-Expiry-Claims.md).

### Moving from AD FS in Windows Server 2012 R2 to AD FS in Windows Server 2016 is easier

Previously, migrating to a new version of AD FS required exporting configuration from the old farm and importing to a brand new, parallel farm.

Now, moving from AD FS on Windows Server 2012 R2 to AD FS on Windows Server 2016 has become easier. Add a new Windows Server 2016 server to a Windows Server 2012 R2 farm, and the farm acts at the Windows Server 2012 R2 farm behavior level. Your server now looks and behaves just like a Windows Server 2012 R2 farm.

Then, add new Windows Server 2016 servers to the farm, verify the functionality and remove the older servers from the load balancer. After all farm nodes are running Windows Server 2016, you're ready to upgrade the farm behavior level to 2016 and begin using the new features.

For more information, see [Upgrading to AD FS in Windows Server 2016](../deployment/upgrading-to-ad-fs-in-windows-server.md).
