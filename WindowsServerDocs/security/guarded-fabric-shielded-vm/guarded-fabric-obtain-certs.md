---
title: Obtain certificates for HGS
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: f4b4d1a8-bf6d-4881-9150-ddeca8b48038
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Obtain certificates for HGS

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

When you deploy HGS, you will be asked to provide signing and encryption certificates that are used to protect the sensitive information needed to start up a shielded VM.
These certificates never leave HGS, and are only used to decrypt shielded VM keys when the host on which they're running has proven it is healthy.
Tenants (VM owners) use the public half of the certificates to authorize your datacenter to run their shielded VMs.
This section covers the steps required to obtain compatible signing and encryption certificates for HGS.

## Request certificates from your certificate authority

While not required, it is strongly recommended that you obtain your certificates from a trusted certificate authority.
Doing so helps VM owners verify that they are authorizing the correct HGS server (i.e. service provider or datacenter) to run their shielded VMs.
In an enterprise scenario, you may choose to use your own enterprise CA to issue these certs.
Hosters and service providers should consider using a well-known, public CA instead.

Both the signing and encryption certificates must be issued with the following certificiate properties (unless marked "recommended"):

Certificate Template Property | Required value 
------------------------------|----------------
Crypto provider               | Any Key Storage Provider (KSP). Legacy Cryptographic Service Providers (CSPs) are **not** supported.
Key algorithm                 | RSA
Minimum key size              | 2048 bits
Signature algorithm           | Recommended: SHA256
Key usage                     | Digital signature *and* data encipherment
Enhanced key usage            | Server authentication
Key renewal policy            | Renew with the same key. Renewing HGS certificates with different keys will prevent shielded VMs from starting up.
Subject name                  | Recommended: your company's name or web address. This information will be shown to VM owners in the shielding data file wizard.

These requirements apply whether you are using certificates backed by hardware or software.
For security reasons, it is recommended that you create your HGS keys in a Hardware Security Module (HSM) to prevent the private keys from being copied off the system.
Follow the guidance from your HSM vendor to request certificates with the above attributes and be sure to install and authorize the HSM KSP on every HGS node.

Every HGS node will require access to the same signing and encryption certificates.
If you are using software-backed certificates, you can export your certificates to a PFX file with a password and allow HGS to manage the certificates for you.
You can also choose to install the certs into the local machine's certificate store on each HGS node and provide the thumbprint to HGS.
Both options are explained in the [Initialize the HGS Cluster](guarded-fabric-initialize-hgs.md) topic.

## Create self signed certificates for test scenarios

If you are creating an HGS lab environment and do not have or want to use a certificate authority, you can create self-signed certificates.
You will receive a warning when importing the certificate information in the shielding data file wizard, but all functionality will remain the same.

To create self-signed certificates and export them to a PFX file, run the following commands in PowerShell:

```powershell
$certificatePassword = Read-Host -AsSecureString -Prompt "Enter a password for the PFX file"

$signCert = New-SelfSignedCertificate -Subject "CN=HGS Signing Certificate"
Export-PfxCertificate -FilePath .\signCert.pfx -Password $certificatePassword -Cert $signCert
Remove-Item $signCert.PSPath

$encCert = New-SelfSignedCertificate -Subject "CN=HGS Encryption Certificate"
Export-PfxCertificate -FilePath .\encCert.pfx -Password $certificatePassword -Cert $encCert
Remove-Item $encCert.PSPath
```

## Request an SSL certificate

All keys and sensitive information transmitted between Hyper-V hosts and HGS are encrypted at the message level -- that is, the information is encrypted with keys known either to HGS or Hyper-V, preventing someone from sniffing your network traffic and stealing keys to your VMs.
However, if you have compliance reqiurements or simply prefer to encrypt all communications between Hyper-V and HGS, you can configure HGS with an SSL certificate which will encrypt all data at the transport level.

Both the Hyper-V hosts and HGS nodes will need to trust the SSL certificate you provide, so it is recommended that you request the SSL certificate from your enterprise certificate authority. When requesting the certificate, be sure to specify the following:

SSL Certificate Property | Required value
-------------------------|---------------
Subject name             | Name of your HGS cluster (distributed network name). This will be the concatenation of your HGS service name provided to `Initialize-HgsServer` and your HGS domain name.
Subject alternative name | If you will be using a different DNS name to reach your HGS cluster (e.g. if it is behind a load balancer), be sure to include those DNS names in the SAN field of your certificate request.

The options for specifying this certificate when initializing the HGS server are covered in [Configure the first HGS node](guarded-fabric-initialize-hgs.md).
You can also add or change the SSL certificate at a later time using the [Set-HgsServer](https://docs.microsoft.com/powershell/module/hgsserver/set-hgsserver?view=win10-ps) cmdlet.

## Next step

> [!div class="nextstepaction"]
> [Install HGS](guarded-fabric-choose-where-to-install-hgs.md)