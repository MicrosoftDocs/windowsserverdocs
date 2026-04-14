---
ms.topic: include
ms.date: 12/29/2025
---

First, obtain an SSL certificate for HGS from your certificate authority. Each host machine will need to trust the SSL certificate, so it is recommended that you issue the SSL certificate from your company's public key infrastructure or a third party CA. Any SSL certificate supported by IIS is supported by HGS, however **the subject name on the certificate must match the fully qualified HGS service name** (cluster distributed network name). For instance, if the HGS domain is "bastion.local" and your HGS service name is "hgs", your SSL certificate should be issued for "hgs.bastion.local". You can add additional DNS names to the certificate's subject alternative name field if necessary.

Once you have the SSL certificate, open an elevated PowerShelll session and either provide the certificate path when you run [Set-HgsServer](/powershell/module/hgsserver/set-hgsserver):


```powershell
$sslPassword = Read-Host -AsSecureString -Prompt "SSL Certificate Password"
Set-HgsServer -Http -Https -HttpsCertificatePath 'C:\temp\HgsSSLCertificate.pfx' -HttpsCertificatePassword $sslPassword
```

Or, if you have already installed the certificate into the local certificate store, you can reference it by thumbprint:

```powershell
Set-HgsServer -Http -Https -HttpsCertificateThumbprint 'A1B2C3D4E5F6...'
```

> [!IMPORTANT]
> Configuring HGS with an SSL certificate does not disable the HTTP endpoint.
> If you wish to only allow use of the HTTPS endpoint, configure Windows Firewall to block inbound connections to port 80.
> **Do not modify the IIS bindings** for HGS websites to remove the HTTP endpoint; it is unsupported to do so.
