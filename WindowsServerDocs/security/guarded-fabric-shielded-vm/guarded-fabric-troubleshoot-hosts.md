---
description: "Learn more about: Troubleshooting Guarded Hosts"
title: Troubleshooting Guarded Hosts
ms.topic: article
ms.assetid: 80ea38f4-4de6-4f85-8188-33a63bb1cf81
manager: dongill
author: rpsqrd
ms.author: ryanpu
ms.date: 09/25/2019
---

# Troubleshooting Guarded Hosts

> Applies to: Windows Server 2019, Windows Server (Semi-Annual Channel), Windows Server 2016

This topic describes resolutions to common problems encountered when deploying or operating a guarded Hyper-V host in your guarded fabric.
If you are unsure of the nature of your problem, first try running the [guarded fabric diagnostics](guarded-fabric-troubleshoot-diagnostics.md) on your Hyper-V hosts to narrow down the potential causes.

## Guarded Host Feature

If you are experiencing issues with your Hyper-V host, first ensure that the **Host Guardian Hyper-V Support** feature is installed.
Without this feature, the Hyper-V host will be missing some critical configuration settings and software that allow it to pass attestation and provision shielded VMs.

To check if the feature is installed, use Server Manager or run the following command in an elevated PowerShell window:

```powershell
Get-WindowsFeature HostGuardian
```

If the feature is not installed, install it with the following PowerShell command:

```powershell
Install-WindowsFeature HostGuardian -Restart
```

## Attestation failures

If a host does not pass attestation with the Host Guardian Service, it will be unable to run shielded VMs.
The output of [Get-HgsClientConfiguration](https://technet.microsoft.com/library/dn914500.aspx) on that host will show you information about why that host failed attestation.

The table below explains the values that may appear in the **AttestationStatus** field and potential next steps, if appropriate.

AttestationStatus         | Explanation
--------------------------|------------
Expired                   | The host passed attestation previously, but the health certificate it was issued has expired. Ensure the host and HGS time are in sync.
InsecureHostConfiguration | The host did not pass attestation because it did not comply with the attestation policies configured on HGS. Consult the AttestationSubStatus table for more information.
NotConfigured             | The host is not configured to use a HGS for attestation and key protection. It is configured for local mode, instead. If this host is in a guarded fabric, use [Set-HgsClientConfiguration](https://technet.microsoft.com/library/dn914494.aspx) to provide it with the URLs for your HGS server.
Passed                    | The host passed attestation.
TransientError            | The last attestation attempt failed due to a networking, service, or other temporary error. Retry your last operation.
TpmError                  | The host could not complete its last attestation attempt due to an error with your TPM. Consult your TPM logs for more information.
UnauthorizedHost          | The host did not pass attestation because it was not authorized to run shielded VMs. Ensure the host belongs to a security group trusted by HGS to run shielded VMs.
Unknown                   | The host has not attempted to attest with HGS yet.

When **AttestationStatus** is reported as **InsecureHostConfiguration**, one or more reasons will be populated in the **AttestationSubStatus** field.
The table below explains the possible values for AttestationSubStatus and tips on how to resolve the problem.

AttestationSubStatus       | What it means and what to do
---------------------------|-------------------------------
BitLocker                  | The host's OS volume is not encrypted by BitLocker. To resolve this, [enable BitLocker](/windows/security/information-protection/bitlocker/bitlocker-basic-deployment) on the OS volume or [disable the BitLocker policy on HGS](guarded-fabric-manage-hgs.md#review-attestation-policies).
CodeIntegrityPolicy        | The host is not configured to use a code integrity policy or is not using a policy trusted by the HGS server. Ensure a code integrity policy has been configured, that the host has been restarted, and the policy is registered with the HGS server. For more information, see [Create and apply a code integrity policy](guarded-fabric-tpm-trusted-attestation-capturing-hardware.md#create-and-apply-a-code-integrity-policy).
DumpsEnabled               | The host is configured to allow crash dumps or live memory dumps, which is not allowed by your HGS policies. To resolve this, disable dumps on the host.
DumpEncryption             | The host is configured to allow crash dumps or live memory dumps but does not encrypt those dumps. Either disable dumps on the host or [configure dump encryption](../../virtualization/hyper-v/manage/about-dump-encryption.md).
DumpEncryptionKey          | The host is configured to allow and encrypt dumps, but is not using a certificate known to HGS to encrypt them. To resolve this, [update the dump encryption key](../../virtualization/hyper-v/manage/about-dump-encryption.md) on the host or [register the key with HGS](guarded-fabric-manage-hgs.md#authorizing-new-guarded-hosts).
FullBoot                   | The host resumed from a sleep state or hibernation. Restart the host to allow for a clean, full boot.
HibernationEnabled         | The host is configured to allow hibernation without encrypting the hibernation file, which is not allowed by your HGS policies. Disable hibernation and restart the host, or [configure dump encryption](../../virtualization/hyper-v/manage/about-dump-encryption.md).
HypervisorEnforcedCodeIntegrityPolicy | The host is not configured to use a hypervisor-enforced code integrity policy. Verify that code integrity is enabled, configured, and enforced by the hypervisor. See the [Device Guard deployment guide](https://technet.microsoft.com/itpro/windows/keep-secure/deploy-device-guard-deploy-code-integrity-policies) for more information.
Iommu                      | The host's Virtualization Based Security features are not configured to require an IOMMU device for protection against Direct Memory Access attacks, as required by your HGS policies. Verify the host has an IOMMU, that it is enabled, and that Device Guard is [configured to require DMA protections](https://technet.microsoft.com/itpro/windows/keep-secure/deploy-device-guard-enable-virtualization-based-security#enable-virtualization-based-security-vbs-and-device-guard) when launching VBS.
PagefileEncryption         | Page file encryption is not enabled on the host. To resolve this, run `fsutil behavior set encryptpagingfile 1` to enable page file encryption. For more information, see [fsutil behavior](/previous-versions/windows/it-pro/windows-server-2012-R2-and-2012/cc785435(v=ws.11)).
SecureBoot                 | Secure Boot is either not enabled on this host or not using the Microsoft Secure Boot template. [Enable Secure Boot](/windows-hardware/manufacture/desktop/disabling-secure-boot#enable_secure_boot) with the Microsoft Secure Boot template to resolve this issue.
SecureBootSettings         | The TPM baseline on this host does not match any of those trusted by HGS. This can occur when your UEFI launch authorities, DBX variable, debug flag, or custom Secure Boot policies are changed by installing new hardware or software. If you trust the current hardware, firmware, and software configuration of this machine, you can [capture a new TPM baseline](guarded-fabric-tpm-trusted-attestation-capturing-hardware.md#capture-the-tpm-baseline-for-each-unique-class-of-hardware) and [register it with HGS](guarded-fabric-manage-hgs.md#authorizing-new-guarded-hosts).
TcgLogVerification         | The TCG log (TPM baseline) cannot be obtained or verified. This can indicate a problem with the host's firmware, the TPM, or other hardware components. If your host is configured to attempt PXE boot before booting Windows, an outdated Net Boot Program (NBP) can also cause this error. Ensure all NBPs are up to date when PXE boot is enabled.
VirtualSecureMode          | Virtualization Based Security features are not running on the host. Ensure VBS is enabled and that your system meets the configured [platform security features](https://technet.microsoft.com/itpro/windows/keep-secure/deploy-device-guard-enable-virtualization-based-security#validate-enabled-device-guard-hardware-based-security-features). Consult the [Device Guard documentation](/windows/security/threat-protection/windows-defender-application-control/windows-defender-application-control-deployment-guide) for more information about VBS requirements.

## Modern TLS

If you've deployed a group policy or otherwise configured your Hyper-V host to prevent the use of TLS 1.0, you may encounter "the Host Guardian Service Client failed to unwrap a Key Protector on behalf of a calling process" errors when trying to start up a shielded VM.
This is due to a default behavior in .NET 4.6 where the system default TLS version is not considered when negotiating supported TLS versions with the HGS server.

To work around this behavior, run the following two commands to configure .NET to use the system default TLS versions for all .NET apps.

```cmd
reg add HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319 /v SystemDefaultTlsVersions /t REG_DWORD /d 1 /f /reg:64
reg add HKLM\SOFTWARE\Microsoft\.NETFramework\v4.0.30319 /v SystemDefaultTlsVersions /t REG_DWORD /d 1 /f /reg:32
```

> [!WARNING]
> The system default TLS versions setting will affect all .NET apps on your machine. Be sure to test the registry keys in an isolated environment before deploying them to your production machines.

For more information about .NET 4.6 and TLS 1.0, see [Solving the TLS 1.0 Problem, 2nd Edition](/security/solving-tls1-problem).
