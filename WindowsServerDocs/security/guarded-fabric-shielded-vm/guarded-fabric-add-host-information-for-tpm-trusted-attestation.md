---
title: Add host information for TPM-trusted attestation
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: f0aa575b-b34e-4f6c-8416-ed3e398e0ad2
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 06/21/2019
---

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

### Add host information for TPM-trusted attestation

For TPM mode, the fabric administrator captures three kinds of host information, each of which needs to be added to the HGS configuration:

- A TPM identifier (EKpub) for each Hyper-V host
- Code Integrity policies, a white list of allowed binaries for the Hyper-V hosts
- A TPM baseline (boot measurements) that represents a set of Hyper-V hosts that run on the same class of hardware

After the fabric administrator captures the information, add it to the HGS configuration as described in the following procedure.

1. Obtain the XML files that contain the EKpub information and copy them to an HGS server. There will be one XML file per host. Then, in an elevated Windows PowerShell console on an HGS server, run the command below. Repeat the command for each of the XML files.

    ```powershell
    Add-HgsAttestationTpmHost -Path <Path><Filename>.xml -Name <HostName>
    ```

    > [!NOTE]
    > If you encounter an error when adding a TPM identifier regarding an untrusted Endorsement Key Certificate (EKCert), ensure that the [trusted TPM root certificates have been added](guarded-fabric-install-trusted-tpm-root-certificates.md) to the HGS node.
    > Additionally, some TPM vendors do not use EKCerts.
    > You can check if an EKCert is missing by opening the XML file in an editor such as Notepad and checking for an error message indicating no EKCert was found.
    > If this is the case, and you trust that the TPM in your machine is authentic, you can use the `-Force` flag to override this safety check and add the host identifier to HGS.

2. Obtain the code integrity policy that the fabric administrator created for the hosts, in binary format (\*.p7b). Copy it to an HGS server. Then run the following command.

    For `<PolicyName>`, specify a name for the CI policy that describes the type of host it applies to. A best practice is to name it after the make/model of your machine and any special software configuration running on it.<br>For `<Path>`, specify the path and filename of the code integrity policy.

    ```powershell
    Add-HgsAttestationCIPolicy -Path <Path> -Name '<PolicyName>'
    ```
    
    > [!NOTE]
    > If you're using a signed code integrity policy, register an unsigned copy of the same policy with HGS.
    > The signature on code integrity policies is used to control updates to the policy, but is not measured into the host TPM and therefore cannot be attested to by HGS.

3. Obtain the TCGlog file that the fabric administrator captured from a reference host. Copy the file to an HGS server. Then run the following command. Typically, you will name the policy after the class of hardware it represents (for example, "Manufacturer Model Revision").

    ```powershell
    Add-HgsAttestationTpmPolicy -Path <Filename>.tcglog -Name '<PolicyName>'
    ```

This completes the process of configuring an HGS cluster for TPM mode. The fabric administrator might need you to provide two URLs from HGS before the configuration can be completed for the hosts. To obtain these URLs, on an HGS server, run [Get-HgsServer](https://docs.microsoft.com/powershell/module/hgsserver/get-hgsserver?view=win10-ps).

## Next step

> [!div class="nextstepaction"]
> [Confirm attestation](guarded-fabric-confirm-hosts-can-attest-successfully.md)
