---
title: Capture TPM-mode information required by HGS
ms.custom: na
ms.prod: windows-server-threshold
ms.topic: article
ms.assetid: 915b1338-5085-481b-8904-75d29e609e93
manager: dongill
author: rpsqrd
ms.technology: security-guarded-fabric
ms.date: 10/14/2016
---

# Capture TPM-mode information required by HGS

>Applies To: Windows Server 2016

This topic describes the intermediate steps that a fabric administrator takes to prepare Hyper-V hosts to become guarded hosts using TPM-trusted attestation (TPM mode). Before taking these steps, complete the steps in [Configuring the fabric DNS for hosts that will become guarded hosts](guarded-fabric-configuring-fabric-dns.md). 

For a video that illustrates the deployment process, see [Guarded fabric deployment using TPM mode](https://channel9.msdn.com/Shows/Guarded-fabric-deployment-AD-mode/Guarded-fabric-deployment-TPM-mode/).

## Prerequisites 

Guarded hosts using TPM mode must meet the following prerequisites:

-   **Hardware**: One host is required for initial deployment. To test Hyper-V live migration for shielded VMs, you must have at least two hosts.

    Hosts must have:
    
    - IOMMU and Second Level Address Translation (SLAT)
    - TPM 2.0
    - UEFI 2.3.1 or later
    - Configured to boot using UEFI (not BIOS or "legacy" mode)
    - Secure boot enabled
        
-   **Operating system**: Windows Server 2016 Datacenter edition

    > [!IMPORTANT]
    > Make sure you install the [latest cumulative update](https://support.microsoft.com/help/4000825/windows-10-and-windows-server-2016-update-history).  

-   **Role and features**: Hyper-V role and the Host Guardian Hyper-V Support feature. The Host Guardian Hyper-V Support feature is only available on Datacenter editions of Windows Server 2016. Special instructions for Nano Server are near the end of this topic.

> [!WARNING]
> The Host Guardian Hyper-V Support feature enables Virtualization-based protection of code integrity that may be incompatible with some devices. 
> We strongly recommend testing this configuration in your lab before enabling this feature. 
> Failure to do so may result in unexpected failures up to and including data loss or a blue screen error (also called a stop error). 
> For more information, see [Compatible hardware with Windows Server 2016 Virtualization-based protection of Code Integrity](guarded-fabric-compatible-hardware-with-virtualization-based-protection-of-code-integrity.md).

## Capture hardware and software information 

TPM mode uses a TPM identifier (also called a platform identifier or endorsement key \[EKpub\]) to begin determining whether a particular host is authorized as "guarded." This mode of attestation uses secure boot and code integrity measurements to ensure that a given Hyper-V host is in a healthy state and is running only trusted code. In order for attestation to understand what is and is not healthy, you must capture the following information:

1.  TPM identifier (EKpub)

    -  This information is unique to each Hyper-V host

2.  TPM baseline (boot measurements)

    -  This is applicable to all Hyper-V hosts that run on the same class of hardware

3.  Code Integrity policies (a white list of allowed binaries)

    -  This is applicable to all Hyper-V hosts that share both common hardware and software

We recommend that you capture the baseline and CI policies from a "reference host" that is representative of each unique class of Hyper-V hardware configuration within your datacenter. 

## Capture the TPM identifier (platform identifier or EKpub) for each host

1.  Ensure the TPM on each host is ready for use - that is, the TPM is initialized and ownership obtained. You can check the status of the TPM by opening the TPM Management Console (tpm.msc) or by running **Get-Tpm** in an elevated Windows PowerShell window. If your TPM is not in the **Ready** state, you will need to initialize it and set its ownership. This can be done in the TPM Management Console or by running **Initialize-Tpm**.

2.  On each guarded host, run the following command in an elevated Windows PowerShell console to obtain its EKpub. For `<HostName>`, substitute the unique host name with something suitable to identify this host - this can be its hostname or the name used by a fabric inventory service (if available). For convenience, name the output file using the host's name.

    ```powershell
    (Get-PlatformIdentifier -Name '<HostName>').InnerXml | Out-file <Path><HostName>.xml -Encoding UTF8
    ```
3.  Repeat the preceding steps for each host that will become a guarded host, being sure to give each XML file a unique name.

4.  Provide the resulting XML files to the HGS administrator, who can [register each host's TPM identifier with HGS](guarded-fabric-add-host-information-for-tpm-trusted-attestation.md).

## Create and apply a Code Integrity policy

A Code Integrity policy helps ensure that only the executables you trust to run on a host are allowed to run. Malware and other executables outside the trusted executables are prevented from running.

Each guarded host must have a code integrity policy applied in order to run shielded VMs in TPM mode. You specify the exact code integrity policies you trust by adding them to HGS. Code integrity policies can be configured to enforce the policy, blocking any software that does not comply with the policy, or simply audit (log an event when software not defined in the policy is executed). It is recommended that you first create the CI policy in audit (logging) mode to see if it's missing anything, then enforce the policy for host production workloads. For more information about generating CI policies and the enforcement mode, see:

- [Planning and getting started on the Device Guard deployment process](https://technet.microsoft.com/itpro/windows/keep-secure/planning-and-getting-started-on-the-device-guard-deployment-process#getting-started-on-the-deployment-process)
- [Deploy Device Guard: deploy code integrity policies](https://technet.microsoft.com/itpro/windows/keep-secure/deploy-device-guard-deploy-code-integrity-policies)

Before you can use the [New-CIPolicy](https://technet.microsoft.com/library/mt634473.aspx) cmdlet to generate a Code Integrity policy, you will need to decide the rule levels to use. For Server Core, we recommend a primary level of **FilePublisher** with fallback to **Hash**. This allows files with publishers to be updated without changing the CI policy. Addition of new files or modifications to files without publishers (which are measured with a hash) will require you to create a new CI policy matching the new system requirements. For Server with Desktop Experience, we recommend a primary level of **Publisher** with fallback to **Hash**. For more information about the available CI policy rule levels, see [Deploy code integrity policies: policy rules and file rules](https://technet.microsoft.com/itpro/windows/keep-secure/deploy-code-integrity-policies-policy-rules-and-file-rules) and cmdlet help.

1.  On the reference host, generate a new code integrity policy. The following commands create a policy at the **FilePublisher** level with fallback to **Hash**. It then converts the XML file to the binary file format Windows and HGS need to apply and measure the CI policy, respectively.

    ```powershell
    New-CIPolicy -Level FilePublisher -Fallback Hash -FilePath 'C:\temp\HW1CodeIntegrity.xml' -UserPEs

    ConvertFrom-CIPolicy -XmlFilePath 'C:\temp\HW1CodeIntegrity.xml' -BinaryFilePath 'C:\temp\HW1CodeIntegrity.p7b'
    ```

    >**Note**&nbsp;&nbsp;The above command creates a CI policy in audit mode only. It will not block unauthorized binaries from running on the host. You should only use enforced policies in production.

2.  Keep your Code Integrity policy file (XML file) where you can easily find it. You will need to edit this file later to enforce the CI policy or merge in changes from future updates made to the system.

3.  Apply the CI policy to your reference host:

    1.  Copy the binary CI policy file (HW1CodeIntegrity.p7b) to the following location on your reference host (the filename must exactly match):<br>
        **C:\\Windows\\System32\\CodeIntegrity\\SIPolicy.p7b**

    2.  Restart the host to apply the policy.

3.  Test the code integrity policy by running a typical workload. This may include running VMs, any fabric management agents, backup agents, or troubleshooting tools on the machine. Check if there are any code integrity violations and update your CI policy if necessary.

4.  Change your CI policy to enforced mode by running the following commands against your updated CI policy XML file.

    ```powershell
    Set-RuleOption -FilePath 'C:\temp\HW1CodeIntegrity.xml' -Option 3 -Delete

    ConvertFrom-CIPolicy -XmlFilePath 'C:\temp\HW1CodeIntegrity.xml' -BinaryFilePath 'C:\temp\HW1CodeIntegrity_enforced.p7b'
    ```

5.  Apply the CI policy to all of your hosts (with identical hardware and software configuration) using the following commands:

    ```powershell
    Copy-Item -Path '<Path to HW1CodeIntegrity\_enforced.p7b>' -Destination 'C:\Windows\System32\CodeIntegrity\SIPolicy.p7b'

    Restart-Computer
    ```

    >**Note**&nbsp;&nbsp;Be careful when applying CI policies to hosts and when updating any software on these machines. Any kernel mode drivers that are non-compliant with the CI Policy may prevent the machine from starting up. For best practices regarding CI policies, see [Planning and getting started on the Device Guard deployment process](https://technet.microsoft.com/itpro/windows/keep-secure/planning-and-getting-started-on-the-device-guard-deployment-process#getting-started-on-the-deployment-process) and [Deploy Device Guard: deploy code integrity policies](https://technet.microsoft.com/itpro/windows/keep-secure/deploy-device-guard-deploy-code-integrity-policies).

6.  Provide the binary file (in this example, HW1CodeIntegrity\_enforced.p7b) to the HGS administrator, who can [register the CI policy with HGS](guarded-fabric-add-host-information-for-tpm-trusted-attestation.md).

## Capture the TPM baseline for each unique class of hardware

A TPM baseline is required for each unique class of hardware in your datacenter fabric. Use a "reference host" again. 

1. On the reference host, make sure that the Hyper-V role and the Host Guardian Hyper-V Support feature are installed.

    >**Warning**&nbsp;&nbsp;The Host Guardian Hyper-V Support feature enables Virtualization-based protection of code integrity that may be incompatible with some devices. We strongly recommend testing this configuration in your lab before enabling this feature. Failure to do so may result in unexpected failures up to and including data loss or a blue screen error (also called a stop error).

    ```powershell
    Install-WindowsFeature Hyper-V, HostGuardian -IncludeManagementTools -Restart
    ```
        
2. To capture the baseline policy, run the following command in an elevated Windows PowerShell console.
        
    ```powershell
    Get-HgsAttestationBaselinePolicy -Path 'HWConfig1.tcglog'
    ```

    >**Note**&nbsp;&nbsp;You will need to use the **-SkipValidation** flag if the reference host does not have Secure Boot enabled, an IOMMU present, Virtualization Based Security enabled and running, or a code integrity policy applied. These validations are designed to make you aware of the minimum requirements of running a shielded VM on the host. Using the -SkipValidation flag does not change the output of the cmdlet; it merely silences the errors.

3.  Provide the TPM baseline (TCGlog file) to the HGS administrator so they can [register it as a trusted baseline](guarded-fabric-add-host-information-for-tpm-trusted-attestation.md).

## Next step

[Confirm hosts can attest successfully](guarded-fabric-confirm-hosts-can-attest-successfully.md)

## See also

- [Deploying the Host Guardian Service for guarded hosts and shielded VMs](guarded-fabric-deploying-hgs-overview.md)
