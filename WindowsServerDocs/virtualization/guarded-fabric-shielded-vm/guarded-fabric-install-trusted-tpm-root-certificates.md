---
title: Install trusted TPM root certificates
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 07/05/2017
---

>[!div class="step-by-step"]
[« Initialize HGS](guarded-fabric-initialize-hgs-tpm-mode.md)
[Configure fabric DNS  »](guarded-fabric-configuring-fabric-dns.md)

# Install trusted TPM root certificates

If you chose TPM mode, or expect to migrate to TPM mode in the future, you need to install root certificates to issue the endorsement key in each host's TPM module.
These root certificates are different from those installed by default in Windows and represent the specific root and intermediate certificates used by TPM vendors.
The following steps help you install certificates for TPMs produced by Microsoft's partners.
Some TPMs do not use endorsement key certificates or use certificates not included in this package.
Consult your TPM vendor or server OEM for further assistance in these cases.

1.  Download the latest package from [http://tpmsec.microsoft.com/OnPremisesDHA/TrustedTPM.cab](http://tpmsec.microsoft.com/OnPremisesDHA/TrustedTPM.cab).
2.  Validate that the package is digitally signed by Microsoft. Do not expand the CAB file if it does not have a valid signature.

    ```powershell
    Get-AuthenticodeSignature -FilePath <Path-To-TrustedTpm.cab>
    ```

3.  Expand the cab file.

    ```powershell
    mkdir .\TrustedTPM
    expand.exe -F:* <Path-To-TrustedTpm.cab> .\TrustedTPM
    ```

4.  By default, the configuration script will install certificates for every TPM vendor. If you only want to import certificates for your specific TPM vendor, delete the folders for TPM vendors not trusted by your organization.

5.  Install the trusted certificate package by running the setup script in the expanded folder.

    ```powershell
    cd .\TrustedTPM
    .\setup.cmd
    ```

The TrustedTpm.cab file is updated regularly with new vendor certificates as they become available.
To add new certificates or ones intentionally skipped during an earlier installation, simply repeat the above steps on every node in your HGS cluster.
Existing certificates will remain trusted but new certificates found in the expanded cab file will be added to the trusted TPM stores.

 



