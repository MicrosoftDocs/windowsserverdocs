---
title: Capture TPM-mode information required by HGS
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 915b1338-5085-481b-8904-75d29e609e93
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 04/01/2019
---

# Authorize guarded hosts using TPM-based attestation

>Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

TPM mode uses a TPM identifier (also called a platform identifier or endorsement key \[EKpub\]) to begin determining whether a particular host is authorized as "guarded." This mode of attestation uses Secure Boot and code integrity measurements to ensure that a given Hyper-V host is in a healthy state and is running only trusted code. In order for attestation to understand what is and is not healthy, you must capture the following artifacts:

1.  TPM identifier (EKpub)

    -  This information is unique to each Hyper-V host

2.  TPM baseline (boot measurements)

    -  This is applicable to all Hyper-V hosts that run on the same class of hardware

3.  Code integrity policy (a whitelist of allowed binaries)

    -  This is applicable to all Hyper-V hosts that share common hardware and software

We recommend that you capture the baseline and CI policy from a "reference host" that is representative of each unique class of Hyper-V hardware configuration within your datacenter. Beginning with Windows Server version 1709, sample CI policies are included at C:\Windows\schemas\CodeIntegrity\ExamplePolicies. 

## Versioned attestation policies

Windows Server 2019 introduces a new method for attestation, called *v2 attestation*, where a TPM certificate must be present in order to add the EKPub to HGS. The v1 attestation method used in Windows Server 2016 allowed you to override this safety check by specifying the -Force flag when you run Add-HgsAttestationTpmHost or other TPM attestation cmdlets to capture the artifacts. Beginning with Windows Server 2019, v2 attestation is used by default and you need to specify the -PolicyVersion v1 flag when you run Add-HgsAttestationTpmHost if you need to register a TPM without a certificate. The -Force flag does not work with v2 attestation. 

A host can only attest if all artifacts (EKPub + TPM baseline + CI Policy) use the same version of attestation. V2 attestation is tried first, and if that fails, v1 attestation is used. This means if you need to register a TPM identifier by using v1 attestation, you need to also specify the -PolicyVersion v1 flag to use v1 attestation when you capture the TPM baseline and create the CI policy. If the TPM baseline and CI policy were created by using v2 attestation and then later you need to add a guarded host without a TPM certificate, you need to re-create each artifact with the -PolicyVersion v1 flag. 

## Capture the TPM identifier (platform identifier or EKpub) for each host

1.  In the fabric domain, make sure the TPM on each host is ready for use - that is, the TPM is initialized and ownership obtained. You can check the status of the TPM by opening the TPM Management Console (tpm.msc) or by running **Get-Tpm** in an elevated Windows PowerShell window. If your TPM is not in the **Ready** state, you will need to initialize it and set its ownership. This can be done in the TPM Management Console or by running **Initialize-Tpm**.

2.  On each guarded host, run the following command in an elevated Windows PowerShell console to obtain its EKpub. For `<HostName>`, substitute the unique host name with something suitable to identify this host - this can be its hostname or the name used by a fabric inventory service (if available). For convenience, name the output file using the host's name.

    ```powershell
    (Get-PlatformIdentifier -Name '<HostName>').InnerXml | Out-file <Path><HostName>.xml -Encoding UTF8
    ```
3.  Repeat the preceding steps for each host that will become a guarded host, being sure to give each XML file a unique name.

4.  Provide the resulting XML files to the HGS administrator.

5.  In the HGS domain, open an elevated Windows PowerShell console on an HGS server and run the following command. Repeat the command for each of the XML files.

    ```powershell
    Add-HgsAttestationTpmHost -Path <Path><Filename>.xml -Name <HostName>
    ```

    > [!NOTE]
    > If you encounter an error when adding a TPM identifier regarding an untrusted Endorsement Key Certificate (EKCert), ensure that the [trusted TPM root certificates have been added](guarded-fabric-install-trusted-tpm-root-certificates.md) to the HGS node.
    > Additionally, some TPM vendors do not use EKCerts.
    > You can check if an EKCert is missing by opening the XML file in an editor such as Notepad and checking for an error message indicating no EKCert was found.
    > If this is the case, and you trust that the TPM in your machine is authentic, you can use the `-Force` parameter to add the host identifier to HGS. In Windows Server 2019, you need to also use the `-PolicyVersion v1` parameter when using `-Force`. This creates a policy consistent with the Windows Server 2016 behavior and will require you to use `-PolicyVersion v1` when registering the CI policy and the TPM baseline as well.

## Create and apply a code integrity policy

A code integrity policy helps ensure that only the executables you trust to run on a host are allowed to run. 
Malware and other executables outside the trusted executables are prevented from running.

Each guarded host must have a code integrity policy applied in order to run shielded VMs in TPM mode. 
You specify the exact code integrity policies you trust by adding them to HGS. 
Code integrity policies can be configured to enforce the policy, blocking any software that does not comply with the policy, or simply audit (log an event when software not defined in the policy is executed). 

Starting with Windows Server version 1709, sample code integrity policies are included with Windows at C:\Windows\schemas\CodeIntegrity\ExamplePolicies. Two policies are recommended for Windows Server:

- **AllowMicrosoft**: Allows all files signed by Microsoft. This policy is recommended for server applications such as SQL or Exchange, or if the server is monitored by agents published by Microsoft.
- **DefaultWindows_Enforced**: Allows only files that shipped in Windows and doesn't permit other applications released by Microsoft, such as Office. This policy is recommended for servers that run only built-in server roles and features such as Hyper-V. 

It is recommended that you first create the CI policy in audit (logging) mode to see if it's missing anything, then enforce the policy for host production workloads. 

If you use the [New-CIPolicy](https://docs.microsoft.com/powershell/module/configci/new-cipolicy?view=win10-ps) cmdlet to generate your own code integrity policy, you will need to decide the rule levels to use. 
We recommend a primary level of **Publisher** with fallback to **Hash**, which allows most digitally signed software to be updated without changing the CI policy.
New software written by the same publisher can also be installed on the server without changing the CI policy.
Executables that are not digitally signed will be hashed -- updates to these files will require you to create a new CI policy.
For more information about the available CI policy rule levels, see [Deploy code integrity policies: policy rules and file rules](https://docs.microsoft.com/windows/security/threat-protection/windows-defender-application-control/select-types-of-rules-to-create#windows-defender-application-control-policy-rules) and cmdlet help.

1.  On the reference host, generate a new code integrity policy. The following commands create a policy at the **Publisher** level with fallback to **Hash**. It then converts the XML file to the binary file format Windows and HGS need to apply and measure the CI policy, respectively.

    ```powershell
    New-CIPolicy -Level Publisher -Fallback Hash -FilePath 'C:\temp\HW1CodeIntegrity.xml' -UserPEs

    ConvertFrom-CIPolicy -XmlFilePath 'C:\temp\HW1CodeIntegrity.xml' -BinaryFilePath 'C:\temp\HW1CodeIntegrity.p7b'
    ```

    >[!NOTE]
    >The above command creates a CI policy in audit mode only. It will not block unauthorized binaries from running on the host. You should only use enforced policies in production.

2.  Keep your Code Integrity policy file (XML file) where you can easily find it. You will need to edit this file later to enforce the CI policy or merge in changes from future updates made to the system.

3.  Apply the CI policy to your reference host:

    1.  Run the following command to configure the machine to use your CI policy. You can also deploy the CI policy with [Group Policy](https://docs.microsoft.com/windows/security/threat-protection/windows-defender-application-control/deploy-windows-defender-application-control-policies-using-group-policy) or [System Center Virtual Machine Manager](https://docs.microsoft.com/system-center/vmm/guarded-deploy-host?view=sc-vmm-2019#manage-and-deploy-code-integrity-policies-with-vmm).

        ```powershell
        Invoke-CimMethod -Namespace root/Microsoft/Windows/CI -ClassName PS_UpdateAndCompareCIPolicy -MethodName Update -Arguments @{ FilePath = "C:\temp\HW1CodeIntegrity.p7b" }
        ```

    2.  Restart the host to apply the policy.

3.  Test the code integrity policy by running a typical workload. This may include running VMs, any fabric management agents, backup agents, or troubleshooting tools on the machine. Check if there are any code integrity violations and update your CI policy if necessary.

4.  Change your CI policy to enforced mode by running the following commands against your updated CI policy XML file.

    ```powershell
    Set-RuleOption -FilePath 'C:\temp\HW1CodeIntegrity.xml' -Option 3 -Delete

    ConvertFrom-CIPolicy -XmlFilePath 'C:\temp\HW1CodeIntegrity.xml' -BinaryFilePath 'C:\temp\HW1CodeIntegrity_enforced.p7b'
    ```

5.  Apply the CI policy to all of your hosts (with identical hardware and software configuration) using the following commands:

    ```powershell
    Invoke-CimMethod -Namespace root/Microsoft/Windows/CI -ClassName PS_UpdateAndCompareCIPolicy -MethodName Update -Arguments @{ FilePath = "C:\temp\HW1CodeIntegrity.p7b" }
    
    Restart-Computer
    ```

    >[!NOTE]
    >Be careful when applying CI policies to hosts and when updating any software on these machines. Any kernel mode drivers that are non-compliant with the CI Policy may prevent the machine from starting up. 

6.  Provide the binary file (in this example, HW1CodeIntegrity\_enforced.p7b) to the HGS administrator.

7.  In the HGS domain, copy the code integrity policy to an HGS server and run the following command.

    For `<PolicyName>`, specify a name for the CI policy that describes the type of host it applies to. A best practice is to name it after the make/model of your machine and any special software configuration running on it.<br>For `<Path>`, specify the path and filename of the code integrity policy.

    ```powershell
    Add-HgsAttestationCIPolicy -Path <Path> -Name '<PolicyName>'
    ```

## Capture the TPM baseline for each unique class of hardware

A TPM baseline is required for each unique class of hardware in your datacenter fabric. Use a "reference host" again. 

1. On the reference host, make sure that the Hyper-V role and the Host Guardian Hyper-V Support feature are installed.

    >[!WARNING]
    >The Host Guardian Hyper-V Support feature enables Virtualization-based protection of code integrity that may be incompatible with some devices. We strongly recommend testing this configuration in your lab before enabling this feature. Failure to do so may result in unexpected failures up to and including data loss or a blue screen error (also called a stop error).

    ```powershell
    Install-WindowsFeature Hyper-V, HostGuardian -IncludeManagementTools -Restart
    ```
        
2. To capture the baseline policy, run the following command in an elevated Windows PowerShell console.
        
    ```powershell
    Get-HgsAttestationBaselinePolicy -Path 'HWConfig1.tcglog'
    ```

    >[!NOTE]
    >You will need to use the **-SkipValidation** flag if the reference host does not have Secure Boot enabled, an IOMMU present, Virtualization Based Security enabled and running, or a code integrity policy applied. These validations are designed to make you aware of the minimum requirements of running a shielded VM on the host. Using the -SkipValidation flag does not change the output of the cmdlet; it merely silences the errors.

3.  Provide the TPM baseline (TCGlog file) to the HGS administrator.

4.  In the HGS domain, copy the TCGlog file to an HGS server and run the following command. Typically, you will name the policy after the class of hardware it represents (for example, "Manufacturer Model Revision").

    ```powershell
    Add-HgsAttestationTpmPolicy -Path <Filename>.tcglog -Name '<PolicyName>'
    ```

## Next step

> [!div class="nextstepaction"]
> [Confirm attestation](guarded-fabric-confirm-hosts-can-attest-successfully.md)
