---
title: AD FS OpenID Connect/OAuth concepts
description: Learn about Active Directory Federation Services modern authentication concepts.
author: billmath
ms.author: wscontent
manager: amycolannino
ms.date: 05/25/2023
ms.topic: article
ms.custom: inhenkel
---

# AD FS OpenID Connect/OAuth concepts

> Applies to Active Directory Federation Services (AD FS) 2016 and later

## Modern authentication actors

| Actor | Description |
|-----|-----|
| End user | The security principal (users, applications, services, and groups) who accesses the resource. |
| Client | Your web application, identified by its client ID. The client is usually the party that the end user interacts with, and the client requests tokens from the authorization server. |
| Authorization server/Identity provider (IdP)| Your AD FS server. It's responsible for verifying the identity of security principals that exist in an organization's directory. It issues security tokens (bearer access token, ID token, and refresh token) upon successful authentication of those security principals. |
| Resource server/Resource provider/Relying party| Where the resource or data resides. It trusts the authorization server to securely authenticate and authorize the client and uses bearer access tokens to ensure that access to a resource can be granted. |

The following diagram provides the most basic relationship between the actors:

:::image type="content" source="media/adfs-modern-auth-concepts/concept1.png" alt-text="Diagram of the modern authentication actors." lightbox="media/adfs-modern-auth-concepts/concept1.png":::

## Application types

|Application Type | Description | Role |
|-----|-----|-----|
| Native application | Sometimes called a _public client_. It's intended to be a client app that runs on a pc or device and with which the user interacts.| Requests tokens from the authorization server (AD FS) for user access to resources. Sends HTTP requests to protected resources, by using the tokens as HTTP headers. |
| Server application (web app) | A web application that runs on a server and is accessible to users via a browser. Because it's capable of maintaining its own client secret or credential, it's sometimes called a _confidential client_. | Requests tokens from the authorization server (AD FS) for user access to resources. Before it requests a token, client (web app) needs to authenticate by using its secret. |
| web API | The end resource that the user accesses. Think of it as the new representation of relying parties.| Consumes bearer access tokens obtained by the clients. |

## Application group

You must associate an application group with every native or web app OAuth client or web API resource that's configured with AD FS. Configure the clients in an application group to access the resources in the same group. An application group can have multiple clients and resources.

## Security tokens

Modern authentication uses following token types:

- **id_token**: A JWT token issued by authorization server (AD FS) and consumed by the client. Claims in the ID token contain information about the user so that client can use it.
- **access_token**: A JWT token issued by authorization server (AD FS) and intended to be consumed by the resource. The 'aud' or audience claim of this token must match the identifier of the resource or web API.
- **refresh_token**: Issued by AD FS for the client to use when it needs to refresh the id_token and access_token. The token is opaque to the client and only consumed by AD FS.

## Refresh token lifetimes

- **Simple logon, no KMSI, device _not_ registered**: AD FS applies `SsoLifetime` and `DeviceUsageWindowInDays`. The first refresh token has `lifetime=DeviceUsageWindowInDays` or `SsoLifetime`, based on which field is lower but _no_ further refresh tokens are issued.
- **KMSI logon, `EnableKmsi=true` in AD FS conf and `kmsi=true` passed as parameter**: AD FS applies `KmsiLifetimeMins` with `DeviceUsageWindowInDays`. The first refresh token has `lifetime=DeviceUsageWindowInDays` and each subsequent `grant_type=refresh_token` request gets a new refresh token. This process happens only with native clients or confidential client plus device authentication.
- **Registered devices, device auth**: AD FS uses `PersistentSsoLifetimeMins` and `DeviceUsageWindowInDays` similar to KMSI. Both native and confidential clients should get new refresh tokens, based on device authentication.

To learn more, see [AD FS single sign-on documentation](../operations/ad-fs-single-sign-on-settings.md).

## Scopes

When you register a resource in AD FS, you can configure scopes to let AD FS perform specific actions. Along with configuring the scope, you must send the scope value in the request for AD FS to perform the action. For example, an administrator configures the scope as `openid` during resource registration and the application (client) must send the `scope = openid` in the authentication request for AD FS to issue the ID Token. The following are details on the available scopes in AD FS:

- `aza` - If you use [OAuth 2.0 protocol extensions for broker clients](/openspecs/windows_protocols/ms-oapxbc/2f7d8875-0383-4058-956d-2fb216b44706) and if the scope parameter contains the scope `aza`, the server issues a new primary refresh token. It sets the token in the `refresh_token` field of the response and sets the `refresh_token_expires_in field` to the lifetime of the new primary refresh token if one is enforced.
- `openid` - Lets the application request use of the `openid` connect authentication protocol.
- `logon_cert` - Lets an application request sign-in certificates that you can use to interactively log on authenticated users. The AD FS server omits the `access_token` parameter from the response and instead provides a base64-encoded CMS certificate chain or a CMC full PKI response. For more information, see [MS-OAPX: OAuth 2.0 protocol extensions](/openspecs/windows_protocols/ms-oapx/32ce8878-7d33-4c02-818b-6c9164cc731e).
- `user_impersonation` - Requests an on-behalf-of access token from AD FS. For details on how to use this scope, see [Build a multi-tiered application using On-Behalf-Of (OBO) using OAuth with AD FS 2016](ad-fs-on-behalf-of-authentication-in-windows-server.md).
- `allatclaims` – Lets the application request the claims in the access token to be added to the ID token as well.
- `vpn_cert` - Lets an application request VPN certificates, which establish VPN connections by using EAP-TLS authentication. This feature isn't supported anymore.
- `email` - Lets the application request an email claim for the signed-in user.
- `profile` - Lets the application request profile-related claims for the signed-in user.

## Claims

Security tokens (access and ID tokens) issued by AD FS contain claims, or assertions of information about the subject that has been authenticated. Applications can use claims for various tasks, including:

- Validate the token
- Identify the subject's directory tenant
- Display user information
- Determine the subject's authorization

The claims present in any given security token are dependent upon the type of token, the type of credential used to authenticate the user, and the application configuration.

## High-level AD FS authentication flow

A diagram of the high-level flow follows.

:::image type="content" source="media/adfs-modern-auth-concepts/adfsauthflow.png" alt-text="Diagram of the AD FS authentication flow." lightbox="media/adfs-modern-auth-concepts/adfsauthflow.png":::

1. AD FS receives authentication request from the client.

1. AD FS validates the client ID in the authentication request with the client ID obtained during client and resource registration in AD FS. If using confidential client, then AD FS also validates the client secret provided in the authentication request. AD FS also validates the redirect URI of the Client.

1. AD FS identifies the resource that the client wants to access through the resource parameter that's passed in the authentication request. If you use the MSAL client library, the resource parameter isn't sent. Instead, the resource URL is sent as a part of the scope parameter: *scope = [resource url]/[scope values, for example, openid]*.

    If the resource isn't passed using the resource or scope parameters, AD FS uses a default resource `urn:microsoft:userinfo` whose policies, such as, MFA, issuance, or authorization policy, can't be configured.

1. Next AD FS validates whether the client has permissions to access the resource. AD FS also validates whether the scopes passed in the authentication request match the scopes configured while registering the resource. If the client doesn't have the permissions, or the right scopes aren't sent in the authentication request, the authentication flow terminates.

1. Once permissions and scopes validate, AD FS authenticates the user by using the configured [authentication method](../operations/configure-authentication-policies.md).

1. If [another authentication method](../operations/configure-additional-authentication-methods-for-ad-fs.md) is required as per the resource policy or the global authentication policy, AD FS triggers the extra authentication.

1. AD FS uses [Microsoft Entra multifactor authentication](../operations/configure-ad-fs-and-azure-mfa.md) or [third-party multifactor authentication](../operations/additional-authentication-methods-ad-fs.md) to do the authentication.

1. Once the user is authenticated, AD FS applies the [claim rules](../deployment/configuring-claim-rules.md). Claim rules determine the claims sent to the resource as a part of the security tokens. AD FS also applies the [access control polices](../operations/ad-fs-client-access-policies.md) that confirm the user meets the required conditions to access the resource.

1. Next, AD FS generates the access and refreshes the tokens. AD FS also generates the ID token.

1. AD FS receives the authentication request.

1. If you include the `scope = allatclaims` in the authentication request, it customizes the [ID token](custom-id-tokens-in-ad-fs.md) to include claims in the access token based on the defined claim rules.

1. Once the required tokens are generated and customized, AD FS responds to the client and includes the tokens. The ID token response is only included in the response if the authentication request includes `scope = openid`. The client can always get the ID token after authentication by using the token endpoint.

## Types of libraries

Use two types of libraries with AD FS:

- **Client libraries**: Native clients and server apps use client libraries to get access tokens for calling a resource such as a web API. Microsoft Authentication Library (MSAL) is the latest and recommended client library when you use AD FS 2019.

- **Server middleware libraries**: Web apps use server middleware libraries for user sign-in. Web APIs use server middleware libraries to validate tokens sent by native clients or by other servers. Open Web Interface for .NET (OWIN) is the recommended middleware library.

## Customize ID token (extra claims in ID token)

In certain scenarios, it's possible that the web app client needs extra claims in an ID token to help in the functionality. Set up extra claims in an ID token by using one of the following options:

**Option 1:** Use this option when you have a public client and the web app doesn't have a resource that it's trying to access. This option requires:

- `response_mode` is set as `form_post`
- Relying party identifier (web API identifier) is the same as the client identifier

![Diagram of AD FS customize token option one.](media/adfs-modern-auth-concepts/option1.png)

**Option 2:** Use this option when the web app has a resource that it's trying to access and needs to pass extra claims through the ID token. You can use both public and confidential clients. This option requires:

- `response_mode` is set as `form_post`
- KB4019472 is installed on your AD FS servers
- Scope `allatclaims` is assigned to the client – RP pair. You can assign the scope by using the `Grant-ADFSApplicationPermission`. Use `Set-AdfsApplicationPermission` if it's already been granted once. The PowerShell cmdlet is indicated in the following example:

    ```powershell
    Grant-AdfsApplicationPermission -ClientRoleIdentifier "https://my/privateclient" -ServerRoleIdentifier "https://rp/fedpassive" -ScopeNames "allatclaims","openid"
    ```

![Diagram of AD FS customize token option two.](media/adfs-modern-auth-concepts/option2.png)

To better understand how to configure a web app in AD FS to get a customized ID token, see [Custom ID tokens in AD FS 2016 or later](Custom-Id-Tokens-in-AD-FS.md).

## Single log-out

Single log-out ends all client sessions that use the session ID. AD FS 2016 and later supports single log-out for OpenID Connect/OAuth. For more information, see [Single log-out for OpenID Connect with AD FS](ad-fs-logout-openid-connect.md).

## AD FS endpoints

|AD FS Endpoint|Description|
|-----|-----|
| /authorize | AD FS returns an authorization code that you can use to get the access token. |
| /token | AD FS returns an access token that you can use to access the resource, as in, the web API. |
| /userinfo | AD FS returns the subject claim. |
| /devicecode | AD FS returns the device code and user code. |
| /logout | AD FS logs out the user.|
| /keys | AD FS public keys used to sign responses. |
| /.well-known/openid-configuration | AD FS returns OAuth/OpenID Connect metadata. |
