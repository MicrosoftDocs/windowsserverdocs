---
title: Configure HGS for Https communications
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 07/05/2017
---

>[!div class="step-by-step"]
[« Initialize HGS](guarded-fabric-initialize-hgs.md)
[Add HGS nodes »](guarded-fabric-configure-additional-hgs-nodes.md)

# Configure HGS for HTTPS communications

By default, when you initialize the HGS server it will configure the IIS web sites for HTTP-only communications.
All sensitive material being transmitted to and from HGS (including the encryption keys for the VM) are always encrypted using message-level encryption, however if you desire a higher level of security you can also enable HTTPS by configuring HGS with an SSL certificate.

First, obtain an SSL certificate for HGS from your certificate authority. Each Hyper-V host will need to trust the SSL certificate, so it is recommended that you issue the SSL certificate from your company's public key infrastructure or a third party CA. Any SSL certificate supported by IIS is supported by HGS, however **the subject name on the certificate must match the fully qualified HGS service name** (cluster distributed network name). For instance, if the HGS domain is "secure.contoso.com" and your HGS service name is "hgs", your SSL certificate should be issued for "hgs.secure.contoso.com". You can add additional DNS names to the certificate's subject alternative name field if necessary.

Once you have the SSL certificate, you can either provide the certificate to the `Initialize-HgsServer` cmdlet if you haven't already run it, or use `Set-HgsServer` if you've already initialized HGS.

**If you haven't already initialized HGS**

Append the following SSL-related parameters to the `Initialize-HgsServer` command from the [Initialize the HGS cluster](#initialize-the-hgs-cluster) or [Initialize HGS in the bastion forest](#initialize-hgs-in-the-bastion-forest) sections.

```powershell
$sslPassword = Read-Host -AsSecureString -Prompt "SSL Certificate Password"
Initialize-HgsServer <OtherParametersHere> -Http -Https -HttpsCertificatePath 'C:\temp\HgsSSLCertificate.pfx' -HttpsCertificatePassword $sslPassword
```

If your certificate is installed in the local certificate store and cannot be exported to a PFX file with the private key intact, you can provide the SSL certificate by its thumbprint instead:

```powershell
Initialize-HgsServer <OtherParametersHere> -Http -Https -HttpsCertificateThumbprint 'A1B2C3D4E5F6...'
```

**If you've already initialized HGS**

Run [Set-HgsServer](https://technet.microsoft.com/itpro/powershell/windows/host-guardian-service/server/set-hgsserver) to configure the new SSL certificate.
This step must be repeated on every HGS node in your cluster.

```powershell
$sslPassword = Read-Host -AsSecureString -Prompt "SSL Certificate Password"
Set-HgsServer -Http -Https -HttpsCertificatePath 'C:\temp\HgsSSLCertificate.pfx' -HttpsCertificatePassword $sslPassword
```

Or, if you have already installed the certificate into the local certificate store and want to reference it by thumbprint:
```powershell
Set-HgsServer -Http -Https -HttpsCertificateThumbprint 'A1B2C3D4E5F6...'
```

> [!IMPORTANT]
> Configuring HGS with an SSL certificate does not disable the HTTP endpoint.
> If you wish to only allow use of the HTTPS endpoint, configure Windows Firewall to block inbound connections to port 80.
> **Do not modify the IIS bindings** for HGS websites to remove the HTTP endpoint; it is unsupported to do so.

