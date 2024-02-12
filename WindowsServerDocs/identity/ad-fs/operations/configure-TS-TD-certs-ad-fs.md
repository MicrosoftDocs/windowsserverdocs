---
title: Obtain and configure token signing and token decryption certificates for AD FS
description: Learn about tasks and procedures you can perform to ensure your Azure Directory Federation Services (AD FS) token signing and token decryption certificates are up to date.
author: jenfieldmsft
ms.author: wscontent
manager: amycolannino
ms.date: 06/13/2023
ms.topic: article
ms.contributor: billmath
---

# Obtain and configure TS and TD certificates for AD FS

This article describes tasks and procedures that ensure your AD FS token signing and token decryption certificates are up to date.

Token signing certificates are standard X509 certificates used to securely sign all tokens that the federation server issues. Token decryption certificates are standard X509 certificates used to decrypt any incoming tokens. They're also published in federation metadata.

For more information, see [Certificate requirements](../design/ad-fs-requirements.md#BKMK_1).

## Determine whether AD FS renews the certificates automatically

By default, AD FS is configured to generate token signing and token decryption certificates automatically. Generation occurs both at the initial configuration and when the certificates are approaching their expiration date.

You can run the following Windows PowerShell command: `Get-AdfsProperties`.

:::image type="content" source="media/configure-TS-TD-certs-ad-fs/ts1.png" alt-text="Screenshot of the PowerShell window, highlighting the AutoCertificateRollover and CertificateGenerationThreshold values.":::

The **AutoCertificateRollover** property describes whether AD FS is configured to renew token signing and token decrypting certificates automatically.

If **AutoCertificateRollover** is set to `True`, the AD FS certificates are renewed and configured in AD FS automatically. Once the new certificate is configured, you must ensure that each federation partner is updated with this new certificate in order to avoid an outage. Your federation partner is represented in your AD FS farm by either relying party trusts or claims provider trusts.

If AD FS isn't configured to renew token signing and token decrypting certificates automatically (for example, if **AutoCertificateRollover** is set to `False`), AD FS doesn't automatically generate or use new token signing or token decrypting certificates. You must perform these tasks manually.

If AD FS is configured to renew token signing and token decrypting certificates automatically (**AutoCertificateRollover** is set to `True`), you can determine when they're renewed:

* **CertificateGenerationThreshold** describes how many days in advance of the certificate's **Not After** date a new certificate is generated.

* **CertificatePromotionThreshold** determines how many days after the new certificate is generated that it's promoted to be the primary certificate. AD FS uses **CertificatePromotionThreshold** to sign tokens that it issues and decrypt tokens that are from identity providers.

:::image type="content" source="media/configure-TS-TD-certs-ad-fs/ts2.png" alt-text="Screenshot of the PowerShell window, highlighting the CertificateGenerationThreshold and CertificatePromotionThreshhold values.":::

## Determine when the current certificates expire

You can use the following procedure to identify the primary token signing and token decrypting certificates and to determine when the current certificates expire.

You can run the following Windows PowerShell command: `Get-AdfsCertificate –CertificateType token-signing` (or `Get-AdfsCertificate –CertificateType token-decrypting`). You can also examine the current certificates in the MMC: Service->Certificates.

:::image type="content" source="media/configure-TS-TD-certs-ad-fs/ts3.png" alt-text="Screenshot of the PowerShell window, highlighting the Not After date and the Is Primary properties.":::

The AD FS uses the certificate for which the `IsPrimary` value is set to `True`.

The date shown for the **Not After** is the date by which a new primary token signing or decrypting certificate must be configured.

To ensure service continuity, all federation partners must consume the new token signing and token decryption certificates prior to this expiration. Your federation partner is represented in your AD FS farm by either relying party trusts or claims provider trusts. You should plan for this process at least 60 days in advance.

## Generate a new self-signed certificate manually prior to the end of the grace period

You can generate a new self-signed certificate manually prior to the end of the grace period by using the following steps:

1. Ensure that you're logged on to the primary AD FS server.
1. Open Windows PowerShell and run the following command: `Add-PSSnapin "microsoft.adfs.powershell"`.
1. You can check the current signing certificates in AD FS. To do so, run the following command: `Get-ADFSCertificate –CertificateType token-signing`. Look at the command output to see the **Not After** dates of any certificates listed.
1. To generate a new certificate, execute the following command to renew and update the certificates on the AD FS server: `Update-ADFSCertificate –CertificateType token-signing`.
1. Verify the update by running the following command again: `Get-ADFSCertificate –CertificateType token-signing`.
1. Two certificates should be listed now. One should have a **Not After** date of approximately one year in the future. The other should have the **IsPrimary** value **False**.

> [!IMPORTANT]
> To avoid a service outage, update the certificate information on Microsoft Entra ID with a valid token-signing certificate.

## If you don't use self-signed certificates

If you don't use the default, automatically generated, self-signed token signing and token decryption certificates, you must renew and configure these certificates manually.

First, you must obtain a new certificate from your certificate authority and import it into the local machine personal certificate store on each federation server. For instructions, see [Import a certificate](/previous-versions/windows/it-pro/windows-server-2008-R2-and-2008/cc754489(v=ws.11)).

Then you must configure this certificate as the secondary AD FS token signing or decryption certificate. You configure it as a secondary certificate to allow your federation partners enough time to consume this new certificate before you promote it to the primary certificate.

### Configure a new certificate as a secondary certificate

1. Open PowerShell and run `Set-ADFSProperties -AutoCertificateRollover $false`.
1. Once you have imported the certificate. Open the **AD FS Management** console.
1. Expand **Service** and then select **Certificates**.
1. In the **Actions** pane, select **Add Token-Signing Certificate**.
    :::image type="content" source="media/configure-TS-TD-certs-ad-fs/ts4.png" alt-text="Screenshot of the AD FS dialog box, highlighting the Add Token Signing Certificate option.":::
1. Select the new certificate from the list of displayed certificates, and then select **OK**.
1. Open PowerShell and run `Set-ADFSProperties -AutoCertificateRollover $true`.

> [!WARNING]
> Ensure the new certificate has a private key associated with it and that the AD FS service account is granted **Read** permissions to the private key. Verify this on each federation server. To do so, in the Certificates snap-in, right-click the new certificate, choose **All Tasks**, and then select **Manage Private Keys**.

Federation partners consume your new certificates by pulling your federation metadata or by receiving the public key of your new certificate from you. Once you've allowed enough time for your federation partners to consume your new certificate, you must promote the secondary certificate to primary certificate.

### Promote the new certificate from secondary to primary

1. Open the **AD FS Management** console.
1. Expand **Service** and then select **Certificates**.
1. Select the secondary token signing certificate.
1. In the **Actions** pane, select **Set as Primary**. Select **Yes** at the confirmation prompt.

    :::image type="content" source="media/configure-TS-TD-certs-ad-fs/ts5.png" alt-text="Screenshot of the AD FS dialog box, highlighting the Set as Primary option.":::

## Update federation partners

You must update your federation partners differently, depending on whether they can consume federation metadata.

### Partners who can consume federation metadata

When you renew and configure a new token signing or token decryption certificate, you must ensure all your federation partners have picked up the new certificates. Your federation partners are resource organization or account organization partners that are represented in your AD FS by relying party trusts and claims provider trusts.

### Partners who can't consume federation metadata

If your federation partners can't consume your federation metadata, you must manually send them the public key of your new token-signing or token-decrypting certificate. Send your new certificate public key (.cer file or .p7b if you wish to include the entire chain) to all of your resource organization or account organization partners. Your resource organization or account organization partners are represented in your AD FS by relying party trusts and claims provider trusts. The partners must implement changes on their side to trust the new certificates.

### Promote to primary if AutoCertificateRollover is False

If **AutoCertificateRollover** is set to `False`, AD FS doesn't automatically generate or use new token signing or token decrypting certificates. You must perform these tasks manually. After allowing a sufficient period of time for all of your federation partners to consume the new secondary certificate, promote this secondary certificate to primary. In the MMC snap-in, select the secondary token signing certificate and in the Actions pane, select **Set As Primary**.

<a name='update-azure-ad'></a>

## Update Microsoft Entra ID

AD FS provides single sign-on access to Microsoft cloud services such as Office 365 by authenticating users via their existing AD DS credentials. For more information, see [Renew federation certificates for Office 365 and Microsoft Entra ID](/azure/active-directory/connect/active-directory-aadconnect-o365-certs).
