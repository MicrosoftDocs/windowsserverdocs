---
title: Initialize HGS using Admin-trusted attestation
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 07/05/2017
---

# Initialize HGS using Admin-trusted attestation

## Initialize the HGS cluster in a new forest (default)

The following commands will complete the configuration of the first HGS node.

1.  Determine a suitable distributed network name (DNN) for the HGS cluster. This name will be registered in the HGS DNS service to make it easy for Hyper-V hosts to contact any node in the HGS cluster. As an example, if you have 3 HGS nodes with hostnames HGS01, HGS02, and HGS03, respectively, you might decide to choose "HGS" or "HgsCluster" for the DNN. Do not provide a fully qualified domain name to the `Initialize-HgsServer` cmdlet (e.g. use "hgs" not "hgs.relecloud.com").

2.  Locate your HGS guardian certificates. You will need one signing certificate and one encryption certificate to intitialize the HGS cluster. The easiest way to provide certificates to HGS is to create a password-protected PFX file for each certificate which contains both the public and private keys. If you are using HSM-backed keys or other non-exportable certificates, you must ensure the certificate is installed into the local machine's certificate store before continuing.

3.  Run the [Initialize-HgsServer](https://technet.microsoft.com/library/mt652185.aspx) cmdlet in an elevated PowerShell window on the first HGS node. The syntax of this cmdlet supports many different inputs, but the 2 most common invocations are below:

    -   If you are using PFX files for your signing and encryption certificates, run the following commands:

        ```powershell
        $signingCertPass = Read-Host -AsSecureString -Prompt "Signing certificate password"
        $encryptionCertPass = Read-Host -AsSecureString -Prompt "Encryption certificate password"

        Initialize-HgsServer -HgsServiceName 'MyHgsDNN' -SigningCertificatePath '.\signCert.pfx' -SigningCertificatePassword $signingCertPass -EncryptionCertificatePath '.\encCert.pfx' -EncryptionCertificatePassword $encryptionCertPass -TrustActiveDirectory
        ```

    -   If you are using non-exportable certificates that are installed in the local certificate store, run the following command. If you do not know the thumbprints of your certificates, you can list available certificates by running `Get-ChildItem Cert:\LocalMachine\My`.

        ```powershell
        Initialize-HgsServer -HgsServiceName 'MyHgsDNN' -SigningCertificateThumbprint '1A2B3C4D5E6F...' -EncryptionCertificateThumbprint '0F9E8D7C6B5A...' -TrustActiveDirectory
        ```

4.  If you provided any certificates to HGS using thumbprints, you will be instructed to grant HGS read access to the private key of those certificates. On a server with the full Windows user interface, complete the following steps:

    1.  Open the local computer certificate manager (**certlm.msc**)
    2.  Find the certificate(s) > right click > all tasks > manage private keys
    3.  Click **Add**
    4.  In the object picker window, click **Object types** and enable **service accounts**
    5.  Enter the name of the service account mentioned in the warning text from `Initialize-HgsServer`
    6.  Ensure the gMSA has "Read" access to the private key.

    On server core, you will need to download a PowerShell module to assist in setting the private key permissions.

    1.  Run `Install-Module GuardedFabricTools` on the HGS server if it has Internet connectivity, or run `Save-Module GuardedFabricTools` on another computer and copy the module over to the HGS server.
    2.  Run `Import-Module GuardedFabricTools`. This will add additional properties to certificate objects found in PowerShell.
    3.  Find your certificate thumbprint in PowerShell with `Get-ChildItem Cert:\LocalMachine\My`
    4.  Update the ACL, replacing the thumbprint with your own and the gMSA account in the code below with the account listed in the warning text of `Initialize-HgsServer`.

        ```powershell
        $certificate = Get-Item "Cert:\LocalMachine\1A2B3C..."
        $certificate.Acl = $certificate.Acl | Add-AccessRule "HgsSvc_1A2B3C" Read Allow
        ```

    If you are using HSM-backed certificates, or certificates stored in a third party key storage provider, these steps may not apply to you. Consult your key storage provider's documentation to learn how to manage permissions on your private key. In some cases, there is no authorization, or authorization is provided to the entire computer when the certificate is installed.


## Initialize the HGS cluster in an existing bastion