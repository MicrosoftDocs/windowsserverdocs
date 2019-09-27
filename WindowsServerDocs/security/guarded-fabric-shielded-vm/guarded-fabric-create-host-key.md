---
title: Create a host key and add it to HGS
ms.custom: na
ms.prod: windows-server
ms.topic: article
ms.assetid: a12c8494-388c-4523-8d70-df9400bbc2c0
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 08/29/2018
---

# Create a host key and add it to HGS

>Applies to: Windows Server 2019


This topic covers how to prepare Hyper-V hosts to become guarded hosts using host key attestation (Key mode). You'll create a host key pair (or use an existing certificate) and add the public half of the key to HGS.

## Create a host key

1.	Install Windows Server 2019 on your Hyper-V host machine.
2.	Install the Hyper-V and Host Guardian Hyper-V Support features:

    ```powershell
    Install-WindowsFeature Hyper-V, HostGuardian -IncludeManagementTools -Restart
    ``` 

3.	Generate a host key automatically, or select an existing certificate. If you are using a custom certificate, it should have at least a 2048-bit RSA key, Client Authentication EKU, and Digital Signature key usage.

    ```powershell
    Set-HgsClientHostKey
    ```

    Alternatively, you can specify a thumbprint if you want to use your own certificate. 
    This can be useful if you want to share a certificate across multiple machines, or use a certificate bound to a TPM or an HSM. Here's an example of creating a TPM-bound certificate (which prevents it from having the private key stolen and used on another machine and requires only a TPM 1.2):

    ```powershell
    $tpmBoundCert = New-SelfSignedCertificate -Subject “Host Key Attestation ($env:computername)” -Provider “Microsoft Platform Crypto Provider”
    Set-HgsClientHostKey -Thumbprint $tpmBoundCert.Thumbprint
    ```

4.	Get the public half of the key to provide to the HGS server. You can use the following cmdlet or, if you have the certificate stored elsewhere, provide a .cer containing the public half of the key. Note that we are only storing and validating the public key on HGS; we do not keep any certificate information nor do we validate the certificate chain or expiration date.

    ```powershell
    Get-HgsClientHostKey -Path "C:\temp\$env:hostname-HostKey.cer"
    ```

5.	Copy the .cer file to your HGS server.

## Add the host key to the attestation service

This step is done on the HGS server and allows the host to run shielded VMs. It is recommended that you set the name to the FQDN or resource identifier of the host machine, so you can easily refer to which host the key is installed on.

```powershell
Add-HgsAttestationHostKey -Name MyHost01 -Path "C:\temp\MyHost01-HostKey.cer"
``` 

## Next step

> [!div class="nextstepaction"]
> [Confirm hosts can attest successfully](guarded-fabric-confirm-hosts-can-attest-successfully.md)

## See also

- [Deploying the Host Guardian Service for guarded hosts and shielded VMs](guarded-fabric-deploying-hgs-overview.md)
