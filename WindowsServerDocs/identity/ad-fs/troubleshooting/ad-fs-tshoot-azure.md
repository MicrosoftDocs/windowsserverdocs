---
title: AD FS Troubleshooting - Microsoft Entra ID
description: This article describes how to troubleshoot various aspects of Active Directory Federation Services (AD FS) and Microsoft Entra ID.
ms.date: 02/13/2024
ms.topic: troubleshooting-general
ms.custom:
  - has-azure-ad-ps-ref
  - azure-ad-ref-level-one-done
  - sfi-image-nochange
---

# AD FS troubleshooting: Microsoft Entra ID

With the growth of the cloud, many companies moved to use Microsoft Entra ID for their various apps and services. Federating with Microsoft Entra ID is now a standard practice with many organizations. This article covers some of the aspects of troubleshooting issues that arise with this federation. Several of the topics in the general troubleshooting article still pertain to federating with Azure, so this article describes specifics with Microsoft Entra ID and Active Directory Federation Services (AD FS) interaction.

## Redirection to AD FS

Redirection occurs when you sign in to an application such as Office 365 and you're redirected to your organization's AD FS servers to sign in.

![Screenshot that shows the Redirection pane.](media/ad-fs-tshoot-azure/azure1.png)

### First things to check

If redirection doesn't occur, there are a few things to check.

1. Make sure that your Microsoft Entra tenant is enabled for federation. Sign in to the Azure portal and check under **Microsoft Entra Connect**.

   ![Screenshot that shows the User sign-in pane in Microsoft Entra Connect.](media/ad-fs-tshoot-azure/azure2.png)

1. Make sure that your custom domain is verified. Select the domain next to **Federation** in the Azure portal.

   ![Screenshot that shows the domain next to Federation in the portal.](media/ad-fs-tshoot-azure/azure3.png)

1. Check the [Domain Name System (DNS)](ad-fs-tshoot-dns.md) and make sure that your AD FS servers or Web Application Proxy servers are resolving from the internet. Verify that they resolve and that you can go to them.

   You can also use the PowerShell cmdlet `Get-MgDomain` to get this information.

   ![Screenshot that shows the PowerShell window showing the results of the Get-MgDomain command.](media/ad-fs-tshoot-azure/azure6.png)

### You receive an "Unknown Auth method" error

You might encounter an "Unknown Auth method" error stating that `AuthnContext` isn't supported at the AD FS or security token service (STS) level when you're redirected from Azure.

This scenario is most common when Microsoft Entra ID redirects to the AD FS or STS by using a parameter that enforces an authentication method.

To enforce an authentication method, use one of the following methods:

- For WS-Federation, use a WAUTH query string to force a preferred authentication method.
- For SAML 2.0, use the following code:

  ```
  <saml:AuthnContext>
  <saml:AuthnContextClassRef>
  urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport
  </saml:AuthnContextClassRef>
  </saml:AuthnContext>
  ```
  
   When the enforced authentication method is sent with an incorrect value, or if that authentication method isn't supported on AD FS or STS, you receive an error message before you're authenticated.

|Method of authentication wanted|WAUTH URI|
|-----|-----|
|User name and password authentication|`urn:oasis:names:tc:SAML:1.0:am:password`|
|Secure Sockets Layer (SSL) client authentication|`urn:ietf:rfc:2246`|
|Windows integrated authentication|`urn:federation:authentication:windows`|

The following table lists supported SAML authentication context classes:

|Authentication method|Authentication context class URI|
|-----|-----|
|User name and password|`urn:oasis:names:tc:SAML:2.0:ac:classes:Password`|
|Password protected transport|`urn:oasis:names:tc:SAML:2.0:ac:classes:PasswordProtectedTransport`|
|Transport Layer Security (TLS) client|`urn:oasis:names:tc:SAML:2.0:ac:classes:TLSClient`
|X.509 certificate|`urn:oasis:names:tc:SAML:2.0:ac:classes:X509`
|Integrated Windows authentication|`urn:federation:authentication:windows`|
|Kerberos|`urn:oasis:names:tc:SAML:2.0:ac:classes:Kerberos`|

To make sure that the authentication method is supported at the AD FS level, check the following things.

#### AD FS 2.0

Under */adfs/ls/web.config*, make sure that the entry for the authentication type is present.

```
<microsoft.identityServer.web>
<localAuthenticationTypes>
<add name="Forms" page="FormsSignIn.aspx" />
<add name="Integrated" page="auth/integrated/" />
<add name="TlsClient" page="auth/sslclient/" />
<add name="Basic" page="auth/basic/" />
</localAuthenticationTypes>
```

#### AD FS 2012 R2

1. Under **AD FS Management**, select **Authentication Policies** in the AD FS snap-in.

1. In the **Primary Authentication** section, next to **Global Settings**, select **Edit**. You can also right-click **Authentication Policies** and then select **Edit Global Primary Authentication**. Or on the **Actions** pane, select **Edit Global Primary Authentication**.

1. On the **Edit Global Authentication Policy** pane, on the **Primary** tab, you can configure settings as part of the global authentication policy. For example, for primary authentication, select available authentication methods under **Extranet** and **Intranet**.

   Make sure that the checkbox for the required authentication method is selected.

#### AD FS 2016

1. Under **AD FS Management**, select **Service** > **Authentication Methods** in the AD FS snap-in.

1. In the **Primary Authentication** section, select **Edit**.

1. On the **Edit Authentication Methods** pane, on the **Primary** tab, you can configure settings as part of the authentication policy.

   ![Screenshot that shows the Edit Authentication Methods pane.](media/ad-fs-tshoot-azure/azure4.png)

## Tokens issued by AD FS

This section discusses tokens issued by AD FS.

<a name='azure-ad-throws-error-after-token-issuance'></a>

### Microsoft Entra ID throws an error after token issuance

After AD FS issues a token, Microsoft Entra ID might throw an error. In this situation, check for the following issues:

- The claims that AD FS issues in the token should match the respective attributes of the user in Microsoft Entra ID.
- The token for Microsoft Entra ID should contain the following required claims:

  - **WSFED**:
    - **UPN**: The value of this claim should match the user principal name (UPN) of the users in Microsoft Entra ID.
    - **ImmutableID**: The value of this claim should match the `sourceAnchor` or `ImmutableID` attributes of the user in Microsoft Entra ID.

    To get the `User` attribute value in Microsoft Entra ID, run the following command line: `Get-AzureADUser –UserPrincipalName <UPN>`

    ![Screenshot that shows the PowerShell pane showing the results of the Get-AzureADUser command.](media/ad-fs-tshoot-azure/azure5.png)

  - **SAML 2.0**:
    - **IDPEmail**: The value of this claim should match the UPN of the users in Microsoft Entra ID.
    - **NAMEID**: The value of this claim should match the `sourceAnchor` or `ImmutableID` attributes of the user in Microsoft Entra ID.

For more information, see [Use a SAML 2.0 identity provider to implement single sign-on](/previous-versions/azure/azure-services/dn641269(v=azure.100)).

<a name='token-signing-certificate-mismatch-between-ad-fs-and-azure-ad'></a>

### Token-signing certificate mismatch between AD FS and Microsoft Entra ID

AD FS uses the token-signing certificate to sign the token that's sent to the user or application. The trust between AD FS and Microsoft Entra ID is a federated trust that's based on this token-signing certificate.

If the token-signing certificate on the AD FS side is changed because of Auto Certificate Rollover or by some intervention, the details of the new certificate must be updated on the Microsoft Entra ID side for the federated domain. When the Primary token-signing certificate on the AD FS is different from Microsoft Entra ID, then Microsoft Entra ID doesn't trust the token that AD FS issued. For this reason, the federated user isn't allowed to sign in.

To fix this problem, follow the steps in [Renew federation certificates for Office 365 and Microsoft Entra ID](/azure/active-directory/connect/active-directory-aadconnect-o365-certs).

## Other common things to check

If you're having issues with AD FS and Microsoft Entra interaction, check for:

- Stale or cached credentials in Windows Credential Manager.
- Secure Hash Algorithm (SHA) that's configured on the relying party trust for Office 365 is set to SHA1.

## Related content

- [AD FS troubleshooting](ad-fs-tshoot-overview.md)
