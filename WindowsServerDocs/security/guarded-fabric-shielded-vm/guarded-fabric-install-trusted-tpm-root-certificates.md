---
title: Install trusted TPM root certificates
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 06/27/2019
---

# Install trusted TPM root certificates

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

When you configure HGS to use TPM attestation, you also need to configure HGS to trust the vendors of the TPMs in your servers.
This extra verification process ensures only authentic, trustworthy TPMs are able to attest with your HGS.
If you try to register an untrusted TPM with `Add-HgsAttestationTpmHost`, you will receive an error indicating the TPM vendor is untrusted.

To trust your TPMs, the root and intermediate signing certificates used to sign the endorsement key in your servers' TPMs need to be installed on HGS.
If you use more than one TPM model in your datacenter, you may need to install different certificates for each model.
HGS will look in the "TrustedTPM_RootCA" and "TrustedTPM_IntermediateCA" certificate stores for the vendor certificates.

> [!NOTE]
> The TPM vendor certificates are different from those installed by default in Windows and represent the specific root and intermediate certificates used by TPM vendors.

A collection of trusted TPM root and intermediate certificates is published by Microsoft for your convenience.
You can use the steps below to install these certificates.
If your TPM certificates are not included in the package below, contact your TPM vendor or server OEM to obtain the root and intermediate certificates for your specific TPM model.

Repeat the following steps on **every HGS server**:

1.  Download the latest package from [https://go.microsoft.com/fwlink/?linkid=2097925](https://go.microsoft.com/fwlink/?linkid=2097925).

2.  Verify the signature of the cab file to ensure its authenticity. Do not proceed if the signature is not valid.

    ```powershell
    Get-AuthenticodeSignature .\TrustedTpm.cab
    ```
    
    Here's some example output:
    
    ```
    Directory: C:\Users\Administrator\Downloads
        
    SignerCertificate                         Status                                 Path
    -----------------                         ------                                 ----
    0DD6D4D4F46C0C7C2671962C4D361D607E370940  Valid                                  TrustedTpm.cab
    ```

2.  Expand the cab file.

    ```
    mkdir .\TrustedTPM
    expand.exe -F:* <Path-To-TrustedTpm.cab> .\TrustedTPM
    ```

3.  By default, the configuration script will install certificates for every TPM vendor. If you only want to import certificates for your specific TPM vendor, delete the folders for TPM vendors not trusted by your organization.

4.  Install the trusted certificate package by running the setup script in the expanded folder.

    ```
    cd .\TrustedTPM
    .\setup.cmd
    ```

To add new certificates or ones intentionally skipped during an earlier installation, simply repeat the above steps on every node in your HGS cluster.
Existing certificates will remain trusted but new certificates found in the expanded cab file will be added to the trusted TPM stores.

## Next step

> [!div class="nextstepaction"]
> [Configure fabric DNS](guarded-fabric-configuring-fabric-dns-tpm.md)



