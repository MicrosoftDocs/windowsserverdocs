---
title: Prepare for the Host Guardian Service deployment
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: f4b4d1a8-bf6d-4881-9150-ddeca8b48038
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 04/24/2017
---

# Prepare for the Host Guardian Service deployment

>Applies To: Windows Server 2016

This topic covers HGS prerequisites and initial steps to prepare for the HGS deployment.

## Prerequisites for the Host Guardian Service

-   **Hardware**: HGS can be run on physical or virtual machines, but physical machines are recommended.

    If you want to run HGS as a three-node physical cluster (for availability), you must have three physical servers. (As a best practice for clustering, the three servers should have very similar hardware.)
  
-   **Operating system**: Windows Server 2016, Standard or Datacenter edition.

-   **Server Roles**: Host Guardian Service and supporting server roles.

-   **Configuration permissions/privileges for the fabric (host) domain**: You will need to configure DNS forwarding between the fabric (host) domain and the HGS domain. If you are using Admin-trusted attestation (AD mode), you will need to configure an Active Directory trust between the fabric domain and the HGS domain. 
    
## Supported upgrade scenarios

Before you deploy a guarded fabric, make sure the servers have installed the [latest Cumulative Update](https://support.microsoft.com/help/4000825/windows-10-and-windows-server-2016-update-history). 
If you deployed a guarded fabric before the release of the [October 27, 2016 Cumulative Update](http://support.microsoft.com/kb/3197954), the servers need to be upgraded:
- Guarded hosts can be upgraded in-place by installing the latest Cumulative Update.
- HGS servers need to be rebuilt, including configuring certificates and information about the hosts. 

Shielded VMs that ran on a guarded host with an earlier operating system version, such as TP5, can still run after the host is upgraded to Windows Server 2016. New shielded VMs cannot be created from template disks that were prepared using the template disk wizard from a Technical Preview build.

## Obtain certificates for HGS

When you deploy HGS, you will be asked to provide signing and encryption certificates that are used to protect the sensitive information needed to start up a shielded VM.
These certificates never leave HGS, and are only used to decrypt shielded VM keys when the host on which they're running has proven it is healthy.
Tenants (VM owners) use the public half of the certificates to authorize your datacenter to run their shielded VMs.
This section covers the steps required to obtain compatible signing and encryption certificates for HGS.

### Request certificates from your certificate authority

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
Both options are explained in the [Initialize the HGS Cluster](guarded-fabric-configure-the-first-hgs-node.md#initialize-the-hgs-cluster) topic.

### Create self signed certificates for test scenarios

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

### Request an SSL certificate

All keys and sensitive information transmitted between Hyper-V hosts and HGS are encrypted at the message level -- that is, the information is encrypted with keys known either to HGS or Hyper-V, preventing someone from sniffing your network traffic and stealing keys to your VMs.
However, if you have compliance reqiurements or simply prefer to encrypt all communications between Hyper-V and HGS, you can configure HGS with an SSL certificate which will encrypt all data at the transport level.

Both the Hyper-V hosts and HGS nodes will need to trust the SSL certificate you provide, so it is recommended that you request the SSL certificate from your enterprise certificate authority. When requesting the certificate, be sure to specify the folloiwng:

SSL Certificate Property | Required value
-------------------------|---------------
Subject name             | Name of your HGS cluster (distributed network name). This will be the concatenation of your HGS service name provided to `Initialize-HgsServer` and your HGS domain name.
Subject alternative name | If you will be using a different DNS name to reach your HGS cluster (e.g. if it is behind a load balancer), be sure to include those DNS names in the SAN field of your certificate request.

The options for specifying this certificate when initializing the HGS server are covered in [Configure the first HGS node](guarded-fabric-configure-the-first-hgs-node.md).
You can also add or change the SSL certificate at a later time using the [Set-HgsServer](https://technet.microsoft.com/en-us/itpro/powershell/windows/hgsserver/set-hgsserver) cmdlet.

## See also

- [Deploying the Host Guardian Service for guarded hosts and shielded VMs](guarded-fabric-deploying-hgs-overview.md)
- [Configuration steps for Hyper-V hosts that will become guarded hosts](guarded-fabric-configure-hgs-with-authorized-hyper-v-hosts.md)
